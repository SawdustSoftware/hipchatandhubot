# Deploy branch to staging
from fabric.api import cd, env, parallel, run, task
from fabric.decorators import roles

# Define your servers
env.roledefs = {
    'staging-web-servers': ['s-web-01.example.com',
                            's-web-03.example.com',
                            's-web-03.example.com'],
    'staging-db-servers': ['s-db-01.example.com'],
}

# Update servers at the same time, e.g. in parallel.
@parallel
@task
@roles('staging-web-servers', 'staging-db-servers')
def pull_code_onto_servers(branch):
    # Path to your code
    with cd():
        # Update your code and pull your branch
        run('git fetch')
        run('git checkout remotes/origin/%s' % branch)
        # Restart any relevant services
    run("sudo supervisorctl restart gunicorn")