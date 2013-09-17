# Description:
#   Deploy branches to staging.
#
# Commands:
#   hubot deploy <branch> to <environment>
#   hubot show branches

{spawn, exec}  = require 'child_process'
module.exports = (robot) ->

 # Deploy to staging
 robot.respond /deploy @?([\w .-]+) to @?([\w .-]+)/i, (msg) ->
    # Get branch
    branch = msg.match[1]
    # Get environment
    environment = msg.match[2]
    # Tell the user hubot is working on the request
    msg.send "Preparing to deploy now..."
    # Execute a fabric command
    exec "cd #{RUN_FAB_FROM} && fab staging.#{cmd}:#{branch}", (err, stdout, stderr) ->
        # Important - Tell users if something goes wrong
        if err
            msg.send "Sorry, something has gone wrong. Probably worth speaking to devops"
        # Tell the user the branch has been deployed
        else
            msg.send "Success: #{branch} deployed to #{environment}"
