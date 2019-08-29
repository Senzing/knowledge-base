# Create Senzing GitHub repository

This is a checklist of what to set when creating a new GitHub Repository.

## Create repository

1. Visit [github.com/Senzing](https://github.com/Senzing)
1. Log in as an administrator
1. On [github.com/Senzing](https://github.com/Senzing), click the "New" button
    1. Enter "Respository Name"
        1. Use only lower-case letters, numbers, and hyphens.
        1. Avoid use of underscore.
        1. When appropriate, use prefixes to help in searching for repositories.
           Examples:
            - "docker-" for docker-based repositories
            - "mapper-" for mapper functions
    1. Choose :radio_button: Public
    1. Check :ballot_box_with_check: Initialize this repository with a README
    1. If appropriate, add .gitignore
    1. For "Add a license", choose "Apache License 2.0"
    1. Click "Create repository" button.

## Configure repository

1. On repository home page, click "releases" link.
    1. Click "Create a new release" button.
    1. Tag version: 0.0.0
    1. Release title: 0.0.0
    1. Click "Publish release" button.
1. On repository home page, click "Settings" tab.
    1. Click "Branches" tab.
        1. Click "Add rule" button.
        1. Branch name pattern:  "master"
        1. Rule Settings
            1. :ballot_box_with_check: Require pull request reviews before merging
        1. Click "Create" button
    1. Click "Collaborators & teams" tab.
        1. Click "Add a team" button.
            1. Choose "Senzing engineering"
            1. Change permissions to "Write"
        1. Click "Add a team" button.
            1. Choose "build"
            1. Change permissions to "Admin"
    1. Click "Security Alerts" tab.
        1. Search for "Senzing/senzing-engineering" and select.
        1. Click "Save changes" button
1. On repository home page, click "Issues" tab.
    1. Click "New issue" button.
        1. Title:  "Initial content"
        1. Click "Submit new issue" button
1. On repository home page, click "Branch: master" button.
    1. Create new branch.
       Example:
       "issue-1.[your-name].1"

## Populate repository with Community Artifacts

1. On your workstation,
    1. :pencil2: Substituting the new repository name for `xxxx`,

        ```console
        git clone git@github.com:Senzing/xxxx.git
        cd xxxx
        git checkout issue-1.[your-name].1
        ```

    1. Populate the new repository with the "Community Artifacts" found in
       [github.com/Senzing/repository-template](https://github.com/Senzing/repository-template).
    1. Modify `CONTRIBUTING.md`
        1. `export GIT_REPOSITORY=<new-repository-name>`
    1. Commit the branch.
    1. Merge `issue-1.[your-name].1` branch into master branch.