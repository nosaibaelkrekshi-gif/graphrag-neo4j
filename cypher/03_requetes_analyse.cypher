// =====================================================================
// Requêtes d'analyse du graphe scolaire
// =====================================================================

// ---------------------------------------------------------------------
// 1. Profil social d'un élève : amis, clubs, passions, difficultés
//    → combine plusieurs types de relations en une seule requête
// ---------------------------------------------------------------------
MATCH (alice:Student {name: "Alice"})
OPTIONAL MATCH (alice)-[:FRIEND_WITH]-(ami:Student)
OPTIONAL MATCH (alice)-[:MEMBER_OF]->(club:Club)
OPTIONAL MATCH (alice)-[:INTERESTED_IN]->(matiere:Subject)
OPTIONAL MATCH (alice)-[:STRUGGLES_WITH]->(diff:Subject)
RETURN alice.name, alice.age, alice.hobby,
       collect(DISTINCT ami.name)     AS amis,
       collect(DISTINCT club.name)    AS clubs,
       collect(DISTINCT matiere.name) AS passions,
       collect(DISTINCT diff.name)    AS difficultes;

// ---------------------------------------------------------------------
// 2. Trouver un camarade tuteur — raisonnement en 3 étapes
//    Bob a du mal en Physique → ses amis → ceux qui aiment la Physique
//    Résultat : Carol
// ---------------------------------------------------------------------
MATCH (bob:Student {name: "Bob"})-[:STRUGGLES_WITH]->(m:Subject {name: "Physique"})
MATCH (bob)-[:FRIEND_WITH]-(ami:Student)-[:INTERESTED_IN]->(m)
RETURN bob.name AS eleve_en_difficulte, m.name AS matiere, ami.name AS tuteur_suggere;

// Version graphique (pour visualiser le chemin dans Neo4j Browser)
MATCH p1 = (bob:Student {name:"Bob"})-[:STRUGGLES_WITH]->(m:Subject {name:"Physique"})
MATCH p2 = (bob)-[:FRIEND_WITH]-(ami:Student)-[:INTERESTED_IN]->(m)
RETURN p1, p2;

// ---------------------------------------------------------------------
// 3. Élève le plus central du réseau (nombre de connexions)
//    Résultat : Carol (6), puis Alice, Bob, Dave (5), Emma (4)
// ---------------------------------------------------------------------
MATCH (s:Student)
OPTIONAL MATCH (s)-[:FRIEND_WITH]-(ami:Student)
OPTIONAL MATCH (s)-[:MEMBER_OF]->(club:Club)
OPTIONAL MATCH (s)-[:INTERESTED_IN]->(passion:Subject)
OPTIONAL MATCH (s)-[:STRUGGLES_WITH]->(difficulte:Subject)
RETURN s.name AS eleve,
       count(DISTINCT ami) AS amis,
       count(DISTINCT club) AS clubs,
       count(DISTINCT passion) AS passions,
       count(DISTINCT difficulte) AS difficultes,
       count(DISTINCT ami) + count(DISTINCT club)
         + count(DISTINCT passion) + count(DISTINCT difficulte) AS score_central
ORDER BY score_central DESC;

// ---------------------------------------------------------------------
// 4. Détection de cliques : groupes de 3 amis tous liés entre eux
//    Résultat : Alice, Bob, Carol
//    En SQL, cette recherche demanderait 6 jointures.
// ---------------------------------------------------------------------
MATCH (a:Student)-[r1:FRIEND_WITH]-(b:Student)-[r2:FRIEND_WITH]-(c:Student)-[r3:FRIEND_WITH]-(a)
WHERE a.name < b.name AND b.name < c.name
RETURN a, b, c, r1, r2, r3;

// ---------------------------------------------------------------------
// 5. Trouver un professeur pour aider un élève
// ---------------------------------------------------------------------
MATCH (s:Student {name: "Bob"})-[:STRUGGLES_WITH]->(sub:Subject)<-[:TEACHES]-(t:Teacher)
RETURN t.name AS professeur, sub.name AS matiere;

// ---------------------------------------------------------------------
// 6. Degrés de séparation entre deux élèves
// ---------------------------------------------------------------------
MATCH p = shortestPath((a:Student {name: "Alice"})-[:FRIEND_WITH*]-(b:Student {name: "Emma"}))
RETURN length(p) AS degres, [n IN nodes(p) | n.name] AS chemin;
