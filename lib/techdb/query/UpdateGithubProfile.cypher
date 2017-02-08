MERGE (github:GithubProfile { githubId: $user.githubId })
ON MATCH SET
  github.lastCrawled = timestamp()
ON CREATE SET
  github.lastCrawled = timestamp(),
  github.name = $user.name,
  github.login = $user.login,
  github.avatarURL = $user.avatarURL,
  github.websiteURL = $user.websiteUrl,
  github.bio = $user.bio,
  github.company = $user.company,
  github.location = $user.location,
  github.followersCount = $user.followers.totalCount

// Link GithubProfile to Organizations
foreach (o in $user.organizations.nodes |
  MERGE (organization:Organization { organizationId: o.organizationId })
  ON MATCH SET
    organization.lastCrawled = timestamp()
  ON CREATE SET
    organization.lastCrawled = timestamp(),
    organization.name = o.name,
    organization.avatarURL = o.avatarURL,
    organization.url = o.url
  MERGE (github)-[:WORKED_AT]->(organization)
)

// Link GithubProfile to contributed Repositories
foreach (r in $user.repositories.edges |
  MERGE (repo:Repository { repositoryId: r.node.repositoryId })
  ON MATCH SET
    repo.lastCrawled = timestamp()
  ON CREATE SET
    repo.lastCrawled = timestamp(),
    repo.repositoryId = r.node.repositoryId,
    repo.githubId = r.node.githubId,
    repo.githubUrl = r.node.githubUrl,
    repo.name = r.node.name,
    repo.homepageURL = r.node.homepageURL,
    repo.isFork = r.node.isFork,
    repo.isPrivate = r.node.isPrivate
  MERGE (github)-[:CONTRIBUTED]->(repo)
)

// Link GithubProfile to starred Repositories
foreach (r in $user.starredRepositories.edges |
  MERGE (repo:Repository { repositoryId: r.node.repositoryId })
  ON MATCH SET
    repo.lastCrawled = timestamp()
  ON CREATE SET
    repo.lastCrawled = timestamp(),
    repo.repositoryId = r.node.repositoryId,
    repo.githubId = r.node.githubId,
    repo.githubUrl = r.node.githubUrl,
    repo.name = r.node.name,
    repo.homepageURL = r.node.homepageURL,
    repo.isFork = r.node.isFork,
    repo.isPrivate = r.node.isPrivate
  MERGE (github)-[:STARRED]->(repo)
)

RETURN github;

