# Use the Coderwall API to retrieve a user's list of badges.
#
# badges for <username> - Retrieves the achievements earned by the given user.
module.exports = (robot) ->
  robot.respond /badges (?:for )?(.*)/i, (msg) ->
    username = msg.match[1]
    msg.send "http://coderwall.com/#{username}"

    msg.http("http://api.coderwall.com/#{username}.json").get() (err, res, body) ->
      if res.statusCode is 404
        msg.send "Sorry! I couldn't find any badges for that user."
      else
        json = JSON.parse(body)
        badges = json["badges"].map (badge) -> badge["name"]
        msg.send "#{username} has #{badges.length} badges: #{badges.join(", ")}."
  
  robot.respond /endorse (.*)/i, (msg) ->
    username = msg.match[0]
    msg.send("http://coderwall.com/#{username}#endorse")
    msg.send("http://api.coderwall.com/#{username}/endorsecount.png")