-- Active: 1685437711224@@127.0.0.1@3306@m2i_db

DROP TABLE IF EXISTS compte;

DROP TABLE IF EXISTS signature;

DROP TABLE IF EXISTS apprenant;

DROP TABLE IF EXISTS cours;

DROP TABLE IF EXISTS responsable;

DROP TABLE IF EXISTS formation;

DROP TABLE IF EXISTS formateur;

DROP TABLE IF EXISTS formateur_formation;

CREATE table
    compte(
        id INT PRIMARY KEY AUTO_INCREMENT,
        email VARCHAR(255),
        password INT
    );

CREATE table
    signature(
        id INT PRIMARY KEY AUTO_INCREMENT,
        signature VARCHAR(255),
        date_jour date
    );

CREATE table
    apprenant(
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255),
        id_compte INT,
        id_signature INT,
        Foreign Key (id_compte) REFERENCES compte(id),
        Foreign Key (id_signature) REFERENCES signature(id)
    );

CREATE table
    cours(
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255),
        id_formateur int,
        id_apprenant int,
        Foreign Key (id_formateur) REFERENCES formateur(id),
        Foreign Key (id_apprenant) REFERENCES apprenant(id)
    );

CREATE table
    responsable(
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255),
        id_res_compte INT,
        Foreign Key (id_res_compte) REFERENCES compte(id)
    );

CREATE table
    formation(
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255),
        module VARCHAR(255),
        date_debut date,
        date_fin date,
        id_responsable INT,
        Foreign Key (id_responsable) REFERENCES responsable(id)
    );

CREATE TABLE
    formateur(
        id INT PRIMARY KEY AUTO_INCREMENT,
        name varchar(255),
        role VARCHAR(255),
        id_for_compte INT,
        id_for_signature INT,
        Foreign Key (id_for_compte) REFERENCES compte(id),
        Foreign Key (id_for_signature) REFERENCES signature(id)
    );

CREATE TABLE
    formateur_formation(
        id_formation INT NOT NULL,
        id_formateur INT NOT NULL,
        PRIMARY KEY (id_formation, id_formateur),
        Foreign Key (id_formation) REFERENCES formation(id),
        Foreign Key (id_formateur) REFERENCES formateur(id) ON UPDATE CASCADE
    );

SHOW INDEXES from responsable;

-- quelques requêtes SELECT pour certaines fonctionnalités

select * from compte where email like 'n%';

select name, email
from apprenant
    LEFT join compte on compte.id = apprenant.id_compte;

select cours.name, count(*)
from formateur
    left join cours on cours.id_formateur = formateur.id
GROUP BY cours.name;

-- - afficher les student et le nombre et l'intitulé des formations qu'ils ont suivi

select
    apprenant.id,
    apprenant.name,
    cours.name
from apprenant
    left join cours on cours.id_apprenant = apprenant.id;

-- - trouver une requête qui permettrait de créer un "plan de table" hebdomadaire aléatoire pour les student d'une promo (pas l'air évident, mais une des réponses possibles est au final pas si complexe

select * from formation 