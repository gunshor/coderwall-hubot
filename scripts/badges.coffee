module.exports = (robot) ->
  robot.respond /badges (?:for )?(.*)/i, (msg) ->
    username = msg.match[1]
    msg.send "Checking badges for #{username}..."
    msg.http("http://api.coderwall.com/#{username}.json").get() (err, res, body) ->
      response = JSON.parse(body)
      badges = response["badges"].map (badge) -> badge["name"]
      msg.send badges.join(", ")      
