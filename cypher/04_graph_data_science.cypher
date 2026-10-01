// =====================================================================
// Analyse avancée avec Neo4j Graph Data Science (plugin GDS requis)
// =====================================================================

// 1. Supprimer une éventuelle projection existante (sans erreur si absente)
CALL gds.graph.drop('subjectGraph', false);

// 2. Projeter tout le graphe en mémoire
CALL gds.graph.project('subjectGraph', '*', '*');

// 3. PageRank : quelles matières sont les plus « importantes » du réseau ?
//    Résultat : Maths 0,37 · Physique 0,28 · Français 0,28 · Histoire 0,27 · Chimie 0,27
CALL gds.pageRank.stream('subjectGraph')
YIELD nodeId, score
WITH gds.util.asNode(nodeId) AS n, score
WHERE n:Subject
RETURN n.name AS matiere, round(score, 2) AS importance
ORDER BY importance DESC;
