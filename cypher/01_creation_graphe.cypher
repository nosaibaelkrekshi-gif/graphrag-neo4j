// =====================================================================
// Création du graphe scolaire — script réexécutable (MERGE)
// Résultat attendu : 18 nœuds, 30 relations, 6 types de relations.
// MERGE ne crée un élément que s'il n'existe pas déjà : on peut relancer
// ce script sans créer de doublons (contrairement à CREATE).
// =====================================================================

// ----- Étudiants -----
MERGE (alice:Student {name:"Alice"}) SET alice.age = 17, alice.hobby = "dessin"
MERGE (bob:Student {name:"Bob"})     SET bob.age = 16,   bob.hobby = "gaming"
MERGE (carol:Student {name:"Carol"}) SET carol.age = 17, carol.hobby = "musique"
MERGE (dave:Student {name:"Dave"})   SET dave.age = 18,  dave.hobby = "sport"
MERGE (emma:Student {name:"Emma"})   SET emma.age = 16,  emma.hobby = "lecture"

// ----- Professeurs -----
MERGE (dupont:Teacher {name:"M. Dupont"}) SET dupont.specialty = "Sciences"
MERGE (lucy:Teacher {name:"Mme Lucy"})    SET lucy.specialty = "Maths"
MERGE (martin:Teacher {name:"M. Martin"}) SET martin.specialty = "Litterature"

// ----- Matières -----
MERGE (maths:Subject {name:"Maths"})       SET maths.difficulty = "moyen"
MERGE (physique:Subject {name:"Physique"}) SET physique.difficulty = "difficile"
MERGE (histoire:Subject {name:"Histoire"}) SET histoire.difficulty = "facile"
MERGE (chimie:Subject {name:"Chimie"})     SET chimie.difficulty = "difficile"
MERGE (francais:Subject {name:"Francais"}) SET francais.difficulty = "moyen"

// ----- Classes -----
MERGE (a101:Class {room:"A101"}) SET a101.level = "Terminale"
MERGE (b203:Class {room:"B203"}) SET b203.level = "Premiere"

// ----- Clubs -----
MERGE (info:Club {name:"Club Informatique"}) SET info.day = "mercredi"
MERGE (theatre:Club {name:"Theatre"})        SET theatre.day = "vendredi"
MERGE (sport:Club {name:"Sport"})            SET sport.day = "mardi"

// ----- Amitiés -----
MERGE (alice)-[:FRIEND_WITH]->(bob)
MERGE (bob)-[:FRIEND_WITH]->(carol)
MERGE (carol)-[:FRIEND_WITH]->(dave)
MERGE (dave)-[:FRIEND_WITH]->(emma)
MERGE (alice)-[:FRIEND_WITH]->(carol)

// ----- Appartenance aux classes -----
MERGE (alice)-[:BELONGS_TO]->(a101)
MERGE (bob)-[:BELONGS_TO]->(b203)
MERGE (carol)-[:BELONGS_TO]->(a101)
MERGE (dave)-[:BELONGS_TO]->(a101)
MERGE (emma)-[:BELONGS_TO]->(b203)

// ----- Centres d'intérêt -----
MERGE (alice)-[:INTERESTED_IN]->(maths)
MERGE (alice)-[:INTERESTED_IN]->(histoire)
MERGE (carol)-[:INTERESTED_IN]->(physique)
MERGE (carol)-[:INTERESTED_IN]->(maths)
MERGE (dave)-[:INTERESTED_IN]->(chimie)
MERGE (emma)-[:INTERESTED_IN]->(francais)
MERGE (emma)-[:INTERESTED_IN]->(histoire)

// ----- Difficultés -----
MERGE (bob)-[:STRUGGLES_WITH]->(physique)
MERGE (bob)-[:STRUGGLES_WITH]->(chimie)
MERGE (dave)-[:STRUGGLES_WITH]->(francais)
MERGE (emma)-[:STRUGGLES_WITH]->(maths)

// ----- Clubs -----
MERGE (alice)-[:MEMBER_OF]->(info)
MERGE (carol)-[:MEMBER_OF]->(info)
MERGE (bob)-[:MEMBER_OF]->(theatre)
MERGE (dave)-[:MEMBER_OF]->(sport)

// ----- Enseignements -----
MERGE (lucy)-[:TEACHES]->(maths)
MERGE (dupont)-[:TEACHES]->(physique)
MERGE (dupont)-[:TEACHES]->(chimie)
MERGE (martin)-[:TEACHES]->(francais)
MERGE (martin)-[:TEACHES]->(histoire);
