CREATE CONSTRAINT ON (n:GithubProfile) ASSERT n.githubId IS UNIQUE;
CREATE CONSTRAINT ON (n:TwitterProfile) ASSERT n.twitterId IS UNIQUE;
CREATE CONSTRAINT ON (n:Organization) ASSERT n.organizationId IS UNIQUE;
CREATE CONSTRAINT ON (n:Repository) ASSERT n.repositoryId IS UNIQUE;
