MATCH (repo:Repository { repositoryId: $repositoryId })
SET repo.lastCrawledOwner = timestamp();
