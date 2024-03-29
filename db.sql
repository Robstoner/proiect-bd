
create table franciza
(
    id int auto_increment primary key,
    locatie varchar(100) not null,
    numeDetinator varchar(30) not null
)
engine = InnoDB;

create table magazin
(
    id int auto_increment primary key,
    adresa varchar(100) not null,
    programStart varchar(10) not null,
    programFinal varchar(10) not null,
    dataDeschiderii date not null default current_timestamp,
    idFranciza int,
    foreign key (idFranciza) references franciza(id)
    on delete set null
    on update set null
)
engine = InnoDB;

create table angajat
(
    id int auto_increment primary key,
    nume varchar(20) not null,
    prenume varchar(20) not null,
    dataAngajarii date not null default current_timestamp
)
engine = InnoDB;

create table post
(
    id int auto_increment primary key,
    titlu varchar(20) not null,
    salariu float not null check (salariu > 0),
    programStart varchar(10) not null,
    programFinal varchar(10) not null
)
engine = InnoDB;

create table contract
(
    dataInceput date not null,
    dataFinal date not null,
    idAngajat int not null,
    idPost int,
    idMagazin int,
    foreign key (idAngajat) references angajat(id)
    on delete cascade
    on update cascade,
    foreign key (idPost) references post(id)
    on delete set null
    on update set null,
    foreign key (idMagazin) references magazin(id)
    on delete set null
    on update set null,
    index id (idAngajat, dataInceput), 
    primary key (idAngajat, dataInceput), -- cheie compusa
    constraint contract_data_chk check (dataInceput < dataFinal)
)
engine = InnoDB;

create table raion
(
    id int auto_increment primary key,
    nume varchar(20) not null,
    tipRaion varchar(20) not null,
    idMagazin int not null,
    foreign key (idMagazin) references magazin(id)
    on delete cascade
    on update cascade
)
engine = InnoDB;

create table oferta
(
    id int auto_increment primary key,
    nume varchar(45) not null,
    dataInceput date not null,
    dataFinal date not null,
    procentajReducere float not null check (procentajReducere > 0 and procentajReducere < 1),
    constraint oferta_data_chk check (dataInceput < dataFinal)
)
engine = InnoDB;

create table produs
(
    id int auto_increment primary key,
    nume varchar(45) not null,
    pret float not null check (pret > 0)
)
engine = InnoDB;

create table produs_raion
(
    idProdus int not null,
    idRaion int not null,
    primary key (idProdus, idRaion), -- cheie compusa
    foreign key (idProdus) references produs(id) 
    on delete cascade 
    on update cascade,
    foreign key (idRaion) references raion(id) 
    on delete cascade 
    on update cascade
)
engine = InnoDB;

create table istoric_oferte
(
    idProdus int not null,
    idOferta int not null,
    primary key (idProdus, idOferta), -- cheie compusa
    foreign key (idProdus) references produs(id) 
    on delete cascade 
    on update cascade,
    foreign key (idOferta) references oferta(id) 
    on delete cascade 
    on update cascade
)
engine = InnoDB;