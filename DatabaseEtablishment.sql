BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "COMPOCAT" (
	"numcategorie"	INTEGER,
	"numequipe"	INTEGER,
	FOREIGN KEY("numcategorie") REFERENCES "CATEGORIE"("numcategorie"),
	FOREIGN KEY("numequipe") REFERENCES "EQUIPE"("numequipe")
);
CREATE TABLE IF NOT EXISTS "EQUIPEMENT" (
	"numequipement"	INTEGER NOT NULL UNIQUE,
	"tailleequipement"	TEXT,
	PRIMARY KEY("numequipement" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "PAYS" (
	"numpays"	INTEGER NOT NULL UNIQUE,
	"nompays"	TEXT,
	PRIMARY KEY("numpays" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "COUPE" (
	"numcoupe"	INTEGER,
	"nomcoupe"	TEXT,
	"niveaucoupe"	TEXT,
	"nbtours"	INTEGER CHECK("nbtours" > 0),
	PRIMARY KEY("numcoupe")
);
CREATE TABLE IF NOT EXISTS "COACH" (
	"numadherent"	INTEGER,
	"numequipe"	INTEGER,
	FOREIGN KEY("numadherent") REFERENCES "ADHERENT"("numadhérent"),
	FOREIGN KEY("numequipe") REFERENCES "EQUIPE"("numequipe")
);
CREATE TABLE IF NOT EXISTS "CHAMPIONNAT" (
	"numchampionnat"	INTEGER NOT NULL UNIQUE,
	"nomchampionnat"	TEXT,
	"niveauchampionnat"	TEXT NOT NULL,
	"nbequipes"	INTEGER CHECK("nbequipes" > 0),
	PRIMARY KEY("numchampionnat" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "CATEGORIE" (
	"numcategorie"	INTEGER,
	"nomcategorie"	TEXT,
	"agecategorie"	TEXT,
	"numstade"	INTEGER,
	PRIMARY KEY("numcategorie"),
	FOREIGN KEY("numstade") REFERENCES "STADE"("numstade")
);
CREATE TABLE IF NOT EXISTS "EQUIPE" (
	"numequipe"	INTEGER,
	"nomequipe"	TEXT,
	"numchampionnat"	INTEGER,
	"numCoupe"	INTEGER,
	PRIMARY KEY("numequipe"),
	FOREIGN KEY("numchampionnat") REFERENCES "CHAMPIONNAT"("numchampionnat"),
	FOREIGN KEY("numCoupe") REFERENCES "COUPE"("numcoupe")
);
CREATE TABLE IF NOT EXISTS "ADHERENT" (
	"numadhérent"	INTEGER,
	"nomadherent"	TEXT,
	"prenomadherent"	TEXT,
	"civiliteadherent"	TEXT,
	"adresseadherent"	TEXT,
	"datenaissance"	TEXT,
	"teladherent"	INTEGER,
	"mailadherent"	TEXT,
	"numequipement"	INTEGER,
	"villeadherent"	INTEGER,
	"villenaissance"	INTEGER,
	"numcategorie"	INTEGER,
	PRIMARY KEY("numadhérent"),
	FOREIGN KEY("villeadherent") REFERENCES "VILLE"("cpville"),
	FOREIGN KEY("numcategorie") REFERENCES "CATEGORIE"("numcategorie"),
	FOREIGN KEY("numequipement") REFERENCES "EQUIPEMENT"("numequipement"),
	FOREIGN KEY("villenaissance") REFERENCES "VILLE"("cpville")
);
CREATE TABLE IF NOT EXISTS "STADE" (
	"numstade"	INTEGER,
	"nomstade"	TEXT,
	"adressestade"	TEXT,
	"taillestade"	INTEGER CHECK("taillestade" > 0),
	"cpville"	INTEGER,
	PRIMARY KEY("numstade"),
	FOREIGN KEY("cpville") REFERENCES "VILLE"("cpville")
);
CREATE TABLE IF NOT EXISTS "VILLE" (
	"cpville"	INTEGER,
	"nomville"	TEXT,
	"numpays"	INTEGER,
	PRIMARY KEY("cpville"),
	FOREIGN KEY("numpays") REFERENCES "PAYS"("numpays")
);
