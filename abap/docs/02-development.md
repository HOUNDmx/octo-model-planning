# Development

**_Golden suggestions_**:

1. Code the most decoupled possible way from existing objects or dependencies, leveraging built-in types and functionality as most as possible. Your abap objects should aim to only use existing objects inside its own folder, within reach of the super package or within reach of objects **owned** by your team.

2. Write unit tests for your abap code using abap unit, like mentioned in our [testing](04-testing.md) guide.

## Repository folder structure

Abap code must reside in its own folder, in this case, the `abap/src` folder.

You can change the directory of the code whenever you like, using abapGit.

## Development using SAP GUI/Eclipse

Start your abap development as you regularly would, and push your changes to the repository as early as possible in the development phase.

Check out the [pushing and pulling code](#pushing-and-pulling-code) section.

Make sure to add abap unit tests to your classes.

## Local development (Standalone abap development)

### Required installations

- Your preferred package manager, [Brew](https://brew.sh/) for example
- [Git](https://git-scm.com/downloads)
- Visual Studio Code
- [Standalone ABAP Development Extension pack](https://marketplace.visualstudio.com/items?itemName=larshp.standalone-abap-development)
- [Node.js](https://nodejs.org/en)
- [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
- [abaplint](https://www.npmjs.com/package/@abaplint/cli)

### Recommended extensions/installations

- [ABAP Syntax Highlighting](https://marketplace.visualstudio.com/items?itemName=larshp.vscode-abap)
- [Advanced ABAP snippet generator](https://marketplace.visualstudio.com/items?itemName=BrandonCaulfield.advanced-abap-snippet-generator)
- [Error Lens](https://marketplace.visualstudio.com/items?itemName=usernamehw.errorlens)
- [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
- [Markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [Markdown Shortcuts](https://marketplace.visualstudio.com/items?itemName=mdickin.markdown-shortcuts)

### How to

Local standalone development can be used by using VSCode.

Check out the [pushing and pulling code](#pushing-and-pulling-code) section.

Make sure to add abap unit tests to your classes.

#### Useful terminal commands

- `npm install` installs all the dependencies mentioned in `package.json`.
- `abaplint` Runs abaplint in your computer, based in `abaplint.jsonc`.
- `npm run {script-name}` Runs any script in `package.json`.
- `npx abaplint` runs the specific version of abaplint tied to your project.

## Pushing and Pulling code

[Push your changes](#pushing-and-pulling-code) to the repository, following your team's PR process, to get continuous integration feedback and surface your work.

If you have no PR process, suggest to open pull requests in draft mode as early as possible in the development phase, so your team can see the direction of your work and provide feedback on it as well.

### Pushing/Pulling from local or standalone development

Regular git commands can be used to push/pull code from local to the repository.

Use your preferred method to clone the repository, create your new branch according to your team naming conventions for branches, and you're good to go.

Check out the [automation section](03-automation.md) to understand what happens next on your pull request.

### Pushing changes from SAP to the repository

_Without releasing your tasks or transports, follow these steps:_

1. Use transaction `zabapgit` in SAP GUI to enter abapGit.
2. Set up a "new online" repository. Follow abapGit documentation on it.
3. **Pay close attention** to which branch is currently installed in the system, on your top right, make sure you are on the desired branch to do your changes to. The `main` branch will be active if there is no current work in progress by any other teammate, you can create a new branch on the next steps.
4. Click **_Stage_** to move to the staging screen.
5. Select which changes you'd like to stage, and hit **_Add and commit_**
6. In the comment field, add your comment for your commit, f.e. _"new loop to class ycl..."_
7. Fill the **_New Branch Name_**
8. Hit the **_commit_** button

Congratulations, you have commited your changes to the repository, now open the repository in GitHub and create a new pull request **in draft mode** for your recent push on your new branch.

> **_NOTE_**: If you add abap unit tests to your classes, they can be set up to run automatically in pull requests in our repository.

Check out the [[automation section](03-automation.md) to understand what happens next on your pull request.

### Pulling changes from the repository into SAP

1. Use transaction `zabapgit` in SAP GUI to enter abapGit.
2. Look for the repository name and log into it with your GitHub credentials by clicking it.
3. **Pay close attention** to which branch is currently installed in the system, on your top right, make sure you are on the desired branch to do your changes to. The `main` branch will be active if there is no current work in progress by any other teammate.
4. Click **_pull_** to trigger the pull popup.
5. Select which changes & objects you'd like to pull into the system, and hit next
6. abapGit will prompt you for a transport request, either create or choose the corresponding one.

abapGit will then pull and try to activate your objects, react to any message that abapGit pops out.

You are good to go.

## Branches

Our suggestion is for you to use the `main` branch to reflect your code in the production system.

Any work in progress is tied to a pull request in its own branch, and always in draft mode.

Suggested branch naming to follow `lastName/featName` or `lastName/bugName`. Use regular dashes freely.

Pull requests can be marked ready for review to trigger the code review process.

## What's next?

Check out our [testing](/docs/03-testing.md) section.
