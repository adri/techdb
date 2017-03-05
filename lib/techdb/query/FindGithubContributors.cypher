MATCH (github:GithubProfile)-[contributions:CONTRIBUTED]-(r)
RETURN github, count(contributions)
ORDER BY COUNT(contributions) DESC;
