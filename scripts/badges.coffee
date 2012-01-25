module.exports = (robot) ->
  robot.respond /badges (?:for )?(.*)/i, (msg) ->
    username = msg.match[1]
    msg.send "http://coderwall.com/#{username}"
    msg.http("http://api.coderwall.com/#{username}.json").get() (err, res, body) ->
      if err
        msg.send "Sorry! I couldn't find any badges for #{username}."
      else
        response = JSON.parse(body)
        badges = response["badges"].map (badge) -> badge["name"]
        msg.send "#{username} has #{badges.length} badges: #{badges.join(", ")}."
