MATCH (repo:Repository)
WHERE repo.lastCrawledOwner IS NULL
RETURN repo;
