MATCH (github:GithubProfile)
WHERE github.lastCrawledTwitter IS NULL
RETURN github.login;
