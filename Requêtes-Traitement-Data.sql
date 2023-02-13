-- 1. DONNER LA LISTE NOMINATIVE DES ADHERENTS DE SEXE MASCULIN ORDONNÉE DANS L'ORDRE ALPHABETIQUE.

select nomadherent
from adherent
where civiliteadherent = "M"
order by nomadherent asc
;

-- 2. DONNER POUR CHAQUE JOUEUR APPARTENANT A LA CATÉGORIE "SENIOR" SON ADRESSE EXACTE.
-- SI BESOIN D'ENVOYER PAR COURIER LES PRIMES DE MATCH OU AUTRE DOCUMENTS.

select prenomadherent, nomadherent, adresseadherent, nomville
from adherent a
inner join categorie c on a.numcategorie = c.numcategorie
inner join ville v on a.villeadherent = v.cpville
where c.nomcategorie = "SENIOR"
;

-- 3. DONNER POUR CHAQUE TAILLE D'EQUIPEMENT LE NOMBRE D'ADHERENT AYANT DEMANDE LA TAILLE EN QUESTION.
-- UTILE POUR LA GESTION DE STOCK POUR POUVOIR COMMANDER LE BON NOMBRE D'EQUIPEMENT AVEC LES BONNES TAILLES. 

select tailleequipement, count(*) as nbequipement
from adherent a
inner join equipement e on a.numequipement = e.numequipement
group by tailleequipement
;

-- 4. DONNER POUR CHAQUE TAILLE D'EQUIPEMENT LE NOMBRE D'ADHERENT ETANT LE COACH D'UNE EQUIPE AYANT DEMANDE LA TAILLE EN QUESTION.
-- UTILE POUR LA GESTION DE STOCK POUR POUVOIR COMMANDER LE BON NOMBRE D'EQUIPEMENT AVEC LES BONNES TAILLES.
-- POUR LES ÉQUIPEMENTS DE COACH, UN COACH SE VOIT ATTRIBUER UN SEUL ÉQUIPEMENT DE COACH MÊME SI IL EST LE COACH DE PLUSIEURS EQUIPES

select tailleequipement, count(distinct e.numequipement) as nbequipement
from coach c
inner join adherent a on c.numadherent = a.numadhérent
inner join equipement e on a.numequipement = e.numequipement
group by tailleequipement
;

-- 5. DONNER LA LISTE NOMINATIVE DES ADHÉRENTS AYANT UNE VILLE DE NAISSANCE SITUÉE DANS UN AUTRE PAYS QUE LA FRANCE
-- UTILE POUR GÉRER LA CRÉATION DE LISCENCE POUR LES JOUEURS ÉTRANGERS (DOCUMENTS EN PLUS A FOURNIR)

select nomadherent
from adherent a
inner join ville v on a.villenaissance = v.cpville
inner join pays p on v.numpays = p.numpays
where p.numpays <> 1
;

-- 6. DONNER LA LISTE DES CATEGORIES AINSI QUE LE NOMBRE DE JOUEURS QU'ELLES CONTIENNENT.
-- POUR FAIRE LE POINT SUR LES CATÉGORIES QUI SONT EN SUR EFFECTIF ET CELLES QUI SONT EN SOUS EFFECTIF.

select nomcategorie, count(*) as nbjoueurs
from categorie c
inner join adherent a on c.numcategorie = a.numcategorie
group by a.numcategorie
;

-- 7. DONNER LA LISTE DES CATÉGORIES QUI CONTIENNE LE NOMBRE MINIMUM DE JOUEURS POUR FAIRE UNE ÉQUIPE (11 JOURURS)
-- POUIR AVOIR UNE IDÉE DE LA TRANCHE D'AGE DANS LAQUELLE LE CLUB DOIT RECRUTER DE NOUVEAUX JOURURS.

select nomcategorie
from categorie c
inner join adherent a on c.numcategorie = a.numcategorie
group by a.numcategorie
having count(*) > 11
;

-- 8. DONNER LA LISTE DES CATEGORIES QUI N'ONT PAS D'EQUIPES JOUANT AU MOINS UNE COMPÉTITION RÉGIONALE OU NATIONALE.
-- POUR POUVOIR CIBLER LES CATEGORIES QUI ONT BESOIN D'ÊTRE RENFORCÉES

select nomequipe
from categorie c
inner join compocat cc on c.numcategorie = cc.numcategorie
inner join equipe e on cc.numequipe = e.numequipe
inner join coupe co on e.numcoupe = co.numcoupe
inner join championnat ch on e.numchampionnat = ch.numchampionnat
where co.niveaucoupe <> "Régional" 
and co.niveaucoupe <> "National"
and ch.niveauchampionnat <> "Régional"
and ch.niveauchampionnat <> "National"
;

-- 9. DONNER LA LISTE DES STADES AVEC UNE CAPACITÉ SUPÉRIEURE A 100 PERSONNES ET DONNER SON ADRESSE.
-- POUR POUVOIR PRÉVOIR UN GROS MATCH OU IL Y AURA BEAUCOUP DE SPECTATEURS.

select nomstade, adressestade, nomville
from stade s
inner join ville v on s.cpville = v.cpville
where taillestade > 100
;

-- 10.  DONNER LA LISTE DES STADES QUI SE SITUENT DANS UNE AUTRE VILLE QUE CELLE DU CLUB ET DONNER SON ADRESSE.
-- POUR SAVOIR QUELS STADES SE TROUVENT A UNE PLUS GRANDE DISTANCE DU CLUB HOUSE.

select nomstade, adressestade, nomville
from stade s
inner join ville v on s.cpville = v.cpville
where nomville <> "Rueil-Malmaison"
;

-- 11. DONNER LE NOMBRE MOYEN DE JOUEURS INSCRITS DANS UNE CATÉGORIE
-- UTILE POUR POUVOIR FAIRE L'INVENTAIRE

select avg(count(*)) as moyenne
from categorie c
inner join adherent a on c.numcategorie = a.numcategorie
group by a.numcategorie
;

-- 12. DONNER LA LISTE DES EQUIPES JOUANT DANS LES CHMPIONNATS DE PLUS HAUT IVEAU DU CLUB

select nomequipe, niveauchampionnat
from equipe e 
inner join coupe c on e.numcoupe = c.numcoupe
inner join championnat ch on e.numchampionnat = ch.numchampionnat
order by niveauchampionnat desc
;

-- 13. DONNER L'ADRESSE EMAIL DES JOUEURS JOUANT DANS UN CHAMPIONNAT DE NIVEAU REGIONAL

select  distinct mailadherent
from adherent a
inner join compocat cc on a.numcategorie = cc.numcategorie
inner join equipe e on cc.numequipe = cc.numequipe
inner join championnat ch on e.numchampionnat = ch.numchampionnat
where niveauchampionnat = "Régional"
;

