// Vérifier le graphe : attendu 18 nœuds et 30 relations
MATCH (n) WITH count(n) AS noeuds
MATCH ()-[r]->() RETURN noeuds, count(r) AS relations;

// Détail par type de nœud (utile pour repérer des doublons)
MATCH (n) RETURN labels(n)[0] AS type, count(*) AS nombre ORDER BY type;
