# Description:
#   Deploy branches to staging.
#
# Commands:
#   hubot deploy <branch>

{spawn, exec}  = require 'child_process'
module.exports = (robot) ->

 # Deploy to staging
 robot.respond /deploy @?([\w .-]+)/i, (msg) ->
    # Get branch
    branch = msg.match[1]
    # Tell the user hubot is working on the request
    msg.send "Preparing to deploy now..."
    # Execute a fabric command
    exec "fab pull_code_onto_servers:#{branch}", (err, stdout, stderr) ->
        # Important - Tell users if something goes wrong
        if err
            msg.send "Sorry, something has gone wrong. Probably worth speaking to devops"
        # Tell the user the branch has been deployed
        else
            msg.send "Success: #{branch} deployed to #{environment}"
