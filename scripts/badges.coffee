module.exports = (robot) ->
  robot.respond /badges (?:for )?(.*)/i, (msg) ->
    username = msg.match[1]
    msg.send "http://coderwall.com/#{username}"
    msg.http("http://api.coderwall.com/#{username}.json").get() (err, res, body) ->
      if res.statusCode is 404
        msg.send "Sorry! Couldn't retrieve any badges."
      else
        json = JSON.parse(body)
        badges = json["badges"].map (badge) -> badge["name"]
        msg.send "#{username} has #{badges.length} badges: #{badges.join(", ")}."
        