
create table ADMIN
(
    id       int   auto_increment primary key,
    email    varchar(80)  not null,
    password varchar(255) not null
);

create table GUIDE
(
    id  int   auto_increment
        primary key,
    NOM      varchar(50) not null,
    PRENOM   varchar(50) not null,
    IMAGE    text        null,
    tel varchar(15) null
);

create table MODEPAYEMENT
(
    id          int         auto_increment        primary key,
    methode    enum ('virment', 'cheque', 'cmi', 'tashilat', 'espece','autre') not null,
    reference  varchar(255) null,
    montant    float                                                            not null

);

create table UTILISATEUR
(
    id   int   auto_increment
        primary key,
    cin      varchar(10)  not null,
    nom      varchar(80)  not null,
    prenom   varchar(80)  not null,
    tel      varchar(15)  not null,
    email    varchar(100)  null,
    password varchar(255) not null
);

create table VILLE
(
    id int  auto_increment
        primary key,
    nom   varchar(100) not null
);

create table VOYAGE
(
    id    int   auto_increment
        primary key,
    idAdmin int not null ,
    nom         varchar(50) not null,
    description  text  not null,
    idImage      int   not null,
    idVille      int   not null,
    dateDebut    date  not null,
    dateFin      date  not null,
    prixMaj      float not null,
    prixMin      float not null,
    maxPlace     int   not null,
    placeReserve int   not null,
    constraint FK_GERER
        foreign key (idAdmin) references ADMIN (id)
);

create table RESERVATION
(
    id         int auto_increment primary key,
    idGuide    int   not null,
    idPayement int   not null,
    idVilleDepart    int   not null,
    date       date  not null,
    placeMaj   int  not null,
    placeMin   int  not null,

    constraint FK_AVOIR_MODE
        foreign key (idPayement) references MODEPAYEMENT (id),
    constraint FK_CHOISIR_GUIDE
        foreign key (idGuide) references GUIDE (id),
    constraint FK_CHOISIR_VILLE_DEPART
        foreign key (idVilleDepart) references VILLE (id)
);



create table FAIRE
(
    idUser   int not null,
    idVoyage int not null,
    idRSV    int not null,
    primary key (idUser, idVoyage, idRSV),
    constraint FK_FAIRE
        foreign key (idUser) references UTILISATEUR (id),
    constraint FK_FAIRE2
        foreign key (idVoyage) references VOYAGE (id),
    constraint FK_FAIRE3
        foreign key (idRSV) references RESERVATION (id)
);

create table GUIDER
(
    idGuide  int not null,
    idVoyage int not null,
    primary key (idGuide, idVoyage),
    constraint FK_GUIDER
        foreign key (idGuide) references GUIDE (id),
    constraint FK_GUIDER2
        foreign key (idVoyage) references VOYAGE (id)
);

create table IMAGE
(
    id    int auto_increment primary key,
    source      text not null
);

create table LIGNES_IMAGE_VOYAGE(
    idImage int not null,
    idVoyage  int not null,
    primary key (idImage, idVoyage),
    constraint FK_CONCERNER
        foreign key (idVoyage) references VOYAGE (id),
    constraint FK_AVOIR_IMAGE
        foreign key (idImage) references IMAGE (id)
);

create table LIGNES_DEPART
(
    idVoyage int not null,
    idVille  int not null,
    primary key (idVoyage, idVille),
    constraint FK_AVOIR
        foreign key (idVoyage) references VOYAGE (id),
    constraint FK_CHOISIR_DEPART
        foreign key (idVille) references VILLE (id)
);

create table LIGNES_DESTINATION
(
    idVoyage int not null,
    idVille  int not null,
    primary key (idVoyage, idVille),
    constraint FK_CONCERNER_VOYAGE
        foreign key (idVoyage) references VOYAGE (id),
    constraint FK_CONCERNER_VILLE
        foreign key (idVille) references VILLE (id)
);

