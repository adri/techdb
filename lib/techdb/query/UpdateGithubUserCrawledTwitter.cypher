MATCH (github:GithubProfile { login: $login })
SET github.lastCrawledTwitter = timestamp();
