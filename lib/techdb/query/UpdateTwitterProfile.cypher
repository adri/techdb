MERGE (twitter:TwitterProfile { twitterId: $user.id })
ON MATCH SET
  twitter.lastCrawled = timestamp()
ON CREATE SET
  twitter.lastCrawled = timestamp(),
  twitter.name = $user.name,
  twitter.login = $user.screen_name,
  twitter.avatarURL = $user.profile_image_url_https,
//  twitter.websiteURL = $user.entities.url.urls.expanded_url,
  twitter.location = $user.location,
  twitter.timeZone = $user.time_zone,
  twitter.followersCount = $user.followers_count,
  twitter.description = $user.description,
  twitter.email = $user.email,
  twitter.company = $user.company

RETURN twitter;

