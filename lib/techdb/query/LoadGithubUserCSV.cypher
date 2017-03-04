USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:///ghtorrent/users.csv" AS user
CREATE (github:GithubProfile { login: user.login })
SET
  github += user,
  github.lastImportedCSV = timestamp()
RETURN github.githubId

