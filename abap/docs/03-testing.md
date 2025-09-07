# Testing

## Unit Tests

Unit tests should be built with an expected output in mind, that targets the desired behaviour required to accomplish the business requirement.

Our suggestion is that you aim for at least one unit test per method built.
Your methods should do one thing and one thing _**only.**_

### The unit test setup

Rely on two things:

1. [SAP abap unit test framework](https://help.sap.com/doc/saphelp_nw73ehp1/7.31.19/en-US/49/18061c005338a1e10000000a421937/content.htm?no_cache=true)
2. [abaplint transpiler](https://github.com/abaplint/transpiler?tab=readme-ov-file)

SAP provides a standard, fully-fledged testing framework with abap unit, that is compatible with our current systems, S/4HANA and also with BTP.

Rely on it as a standard, SAP supported way of testing abap code.

These abap unit tests can be ran/executed in the SAP system itself, and also can be executed in GitHub Actions in our current [automation setup](03-automation.md) with the help of open-abap and the abaplint transpiler, which transpiles the abap code into Typescript.

## Creating an abap unit test

### Creating in SAP GUI/Eclipse

1. Right click your class and hit **_Generate Test Class_**.
2. Code it.

You can then push your test class to the repository together with your code.

### Creating in standalone development

1. Either use the abap artifact extension to create it, copy the shell of a testing class or use the following template:

   ```abap

   CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.
   PUBLIC SECTION.
   PROTECTED SECTION.
   PRIVATE SECTION.
   ENDCLASS.

   CLASS ltcl_test IMPLEMENTATION.

   ENDCLASS.
   ```

2. Make sure to name your new test class like: `<name-of-your-original-class.class.testclasses.abap>`
3. Edit the xml properties of your original class, add `<WITH_UNIT_TESTS>X</WITH_UNIT_TESTS>` after the unicode block.
4. Code it.

## Running the abap unit tests

### Running in SAP GUI/Eclipse

1. Right click your unit test, hit **_execute unit tests_**.
2. SAP GUI displays the results of your tests.

### Running in standalone development

1. Run the script `tests`, by typing in terminal `npm run tests`.
2. The script will trigger abaplint downport, transpile and execution of the tests, and will prompt you with the results in the terminal.

## What's next?

Check out our [automation](/docs/04-automation.md) setup.
