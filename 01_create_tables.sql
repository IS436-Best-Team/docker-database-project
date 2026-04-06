create table League (
    league_id int not null auto_increment,
    league_name varchar(100) not null,
    season varchar(50) not null,
    age_division varchar(50),
    game_length_minutes int not null,
    period_count int not null,
    substitution_interval_minutes int not null,
    minimum_playtime_minutes int not null,
    foul_disqualification_limit int not null,
    max_players_on_court int not null,
    constraint pk_League primary key (league_id)
);

create table Team (
    team_id int not null auto_increment,
    league_id int not null,
    team_name varchar(100) not null,
    is_active boolean not null default true,
    constraint pk_Team primary key (team_id),
    constraint fk_Team_League foreign key (league_id) references League(league_id)
);

create table CoachUser (
    user_id int not null auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) not null,
    password_hash varchar(255) not null,
    role varchar(30) not null,
    is_active boolean not null default true,
    constraint pk_CoachUser primary key (user_id)
);

create table TeamCoach (
    team_id int not null,
    user_id int not null,
    constraint pk_TeamCoach primary key (team_id, user_id),
    constraint fk_TeamCoach_Team foreign key (team_id) references Team(team_id),
    constraint fk_TeamCoach_CoachUser foreign key (user_id) references CoachUser(user_id)
);

create table Player (
    player_id int not null auto_increment,
    team_id int not null,
    jersey_number int not null,
    default_status varchar(30) not null default 'eligible',
    is_active boolean not null default true,
    constraint pk_Player primary key (player_id),
    constraint fk_Player_Team foreign key (team_id) references Team(team_id)
);

create table Game (
    game_id int not null auto_increment,
    league_id int not null,
    team_id int not null,
    created_by int not null,
    opponent_name varchar(100) not null,
    game_date date not null,
    location varchar(100),
    status varchar(30) not null,
    constraint pk_Game primary key (game_id),
    constraint fk_Game_League foreign key (league_id) references League(league_id),
    constraint fk_Game_Team foreign key (team_id) references Team(team_id),
    constraint fk_Game_CoachUser foreign key (created_by) references CoachUser(user_id)
);

create table GameRoster (
    game_roster_id int not null auto_increment,
    game_id int not null,
    player_id int not null,
    initial_status varchar(30) not null,
    is_present boolean not null default true,
    constraint pk_GameRoster primary key (game_roster_id),
    constraint fk_GameRoster_Game foreign key (game_id) references Game(game_id),
    constraint fk_GameRoster_Player foreign key (player_id) references Player(player_id)
);

create table PlayerGameStatus (
    player_game_status_id int not null auto_increment,
    game_id int not null,
    player_id int not null,
    current_status varchar(30) not null,
    status_color varchar(20),
    minutes_played int not null default 0,
    foul_count int not null default 0,
    is_disqualified boolean not null default false,
    is_unavailable boolean not null default false,
    constraint pk_PlayerGameStatus primary key (player_game_status_id),
    constraint fk_PlayerGameStatus_Game foreign key (game_id) references Game(game_id),
    constraint fk_PlayerGameStatus_Player foreign key (player_id) references Player(player_id)
);

create table Substitution (
    substitution_id int not null auto_increment,
    game_id int not null,
    player_in_id int not null,
    player_out_id int not null,
    substitution_time datetime not null,
    recorded_by int not null,
    constraint pk_Substitution primary key (substitution_id),
    constraint fk_Substitution_Game foreign key (game_id) references Game(game_id),
    constraint fk_Substitution_PlayerIn foreign key (player_in_id) references Player(player_id),
    constraint fk_Substitution_PlayerOut foreign key (player_out_id) references Player(player_id),
    constraint fk_Substitution_CoachUser foreign key (recorded_by) references CoachUser(user_id)
);

create table Foul (
    foul_id int not null auto_increment,
    game_id int not null,
    player_id int not null,
    foul_number int not null,
    foul_time datetime not null,
    recorded_by int not null,
    constraint pk_Foul primary key (foul_id),
    constraint fk_Foul_Game foreign key (game_id) references Game(game_id),
    constraint fk_Foul_Player foreign key (player_id) references Player(player_id),
    constraint fk_Foul_CoachUser foreign key (recorded_by) references CoachUser(user_id)
);

create table Injury (
    injury_id int not null auto_increment,
    game_id int not null,
    player_id int not null,
    injury_time datetime not null,
    notes varchar(255),
    recorded_by int not null,
    constraint pk_Injury primary key (injury_id),
    constraint fk_Injury_Game foreign key (game_id) references Game(game_id),
    constraint fk_Injury_Player foreign key (player_id) references Player(player_id),
    constraint fk_Injury_CoachUser foreign key (recorded_by) references CoachUser(user_id)
);

create table AIQuery (
    ai_query_id int not null auto_increment,
    user_id int not null,
    team_id int not null,
    game_id int,
    query_text text not null,
    query_type varchar(50),
    response_text text,
    created_at datetime not null,
    constraint pk_AIQuery primary key (ai_query_id),
    constraint fk_AIQuery_CoachUser foreign key (user_id) references CoachUser(user_id),
    constraint fk_AIQuery_Team foreign key (team_id) references Team(team_id),
    constraint fk_AIQuery_Game foreign key (game_id) references Game(game_id)
);

create table Report (
    report_id int not null auto_increment,
    generated_by int not null,
    team_id int not null,
    game_id int,
    report_type varchar(50) not null,
    report_data text,
    created_at datetime not null,
    constraint pk_Report primary key (report_id),
    constraint fk_Report_CoachUser foreign key (generated_by) references CoachUser(user_id),
    constraint fk_Report_Team foreign key (team_id) references Team(team_id),
    constraint fk_Report_Game foreign key (game_id) references Game(game_id)
);