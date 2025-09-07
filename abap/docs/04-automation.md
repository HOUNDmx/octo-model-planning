# Automation

Rely on GitHub Actions to trigger most of our automation.

## Continuous integration

Abaplint.app is installed in the repository, and is triggered on pull requests and commits.

It provides fast feedback to the developer's code based on a set of defined rules that are configured in `abaplint.jsonc`.

Feel free to modify this ruleset to what best fits your needs in your project.

You can customize your own set of rules.

You can also check out [abaplint available rules](https://rules.abaplint.org/).

## Workflows & GitHub Actions

### abap-ci workflow

In a single job named _unit-tests_, it triggers a clean install of the dependencies of the project, and runs the abap unit tests in it.

#### Unit-tests job

- Clean install of dependencies

  Runs a clean install of the npm dependencies of the project mentioned in `package.json`, by using `npm ci`.

- Run abap unit tests

  1. Triggers abaplint [continuous integration](#continuous-integration), checking the linting rules mentioned in `abaplint.jsonc`
  2. Calls the `abap-downport`, `abap-transpile` and `npm abap-unit-tests` scripts mentioned in `package.json`, which are the scripts that trigger the donwport, transpiling and execution of the abap code, by doing the following:

     1. Runs `abap-downport`, which downports the abap code from any inputted version to `7.02`, preparing it for transpiling.
     2. Transpiles the abap code into Typescript by running the abaplint transpiler.
     3. Executes all the `.testclasses.abap` that it finds in the current project.
     4. Provides feedback in the status of the GitHub Action. In case of a failed unit test, it will show a fail plus a descriptive message of the failed test, with an expected value and a result in the details of the action itself.

## Abap unit tests runs in the repository

The repository triggers all existing abap unit tests when a pull request or a commit happen to any branch with the current automation setup in GitHub Actions.

This section will explain how to add unit tests to the scope of this automation.

### Basic understandings

abaplint transpiler only takes abap code version `702` as input for maximum compatibility. This means all code that needs to be executed for your tests to run need to be downported first, including dependencies, and have to be free of issues with the current abaplint configuration in `abaplint.jsonc`.

### Downporting

abaplint offers the functionality to automatically downport the code to a compatible version for the transpiler, by passing the `downport` parameter in the `abaplint.jsonc` file.

This lets abaplint know that you want to downport the code of the project, and also all the abap dependencies required.

The `abaplint-downport.jsonc` file holds the specifics on how the downport is handled, which code from which folders of the dependencies has to be downported, the output folder, the target syntax and the target rules of the downport.

If the downport is successfull, then the transpiling can start.

### Transpiling

abaplint offers a transpiling feature, where it will transpile abap code version `702` into Typescript, and that code can run in any form available, such as node.js.

The `abap_transpile.jsonc` file holds the specifics on how the transpiling is handled, from which input folder is the abap code taken, to which directory output, the dependencies on what needs to be transpiled and additional settings can be configured under the `extraSetup` property to mock a database, in our case, using SQLite.

### Adding new abap unit tests to the automation

Make sure you are logged in to ghcr.io:

> docker login ghcr.io

- Write your unit test and commit it to your branch
- Ensure you have all the dependencies for your code execution available within the project itself or listed as dependencies in `abaplint.jsonc`, `abaplint-downport.jsonc` and listed as libs in `abap_transpile.json`.
- Add the directory of your code to be downported, transpiled, executed and tested to the `abap-downport` script in `package.json`.
- Test the downport execution by running the script in the terminal, with `npm run abap-downport`. Fix any concerns raised by abaplint when running this.
- Test the transpiling execution by running the script in the terminal, with `npm run abap-unit-tests`. This command will go through all scripts, downport, transpile and execute any unit tests found on your provided input. Check and solve any conflicts raised by the transpiler.

## What's next?

Check out our [Deployment](/docs/05-deployment.md) setup.
