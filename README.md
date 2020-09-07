![Build & test workflow](https://github.com/actions/hello-world/workflows/Continuous%20Integration/badge.svg)

# Installs

- [Visual Studio Code](https://code.visualstudio.com/download)
    - Make sure you have the [C#](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) extension
- [Git](https://git-scm.com/)
- [NPM](https://www.npmjs.com/get-npm)
- [.NET Core 3.1](https://dotnet.microsoft.com/download)

# Getting the code

Checkout the `DevOps-Module-07-Workshop` repository from [CorndelWithSoftwire's Github](https://github.com/CorndelWithSoftwire/DevOps-Module-07-Workshop):

```bash
git checkout git@github.com:CorndelWithSoftwire/DevOps-Module-07-Workshop.git
```

You should now be able to open the project folder in Visual Studio Code.

# Running the app

The project should now build. Confirm this via running `dotnet build` from the terminal in the project folder and `npm run build` (if it's your first time building you also need to run `npm install`) in the DotnetTemplate.Web folder.

You can now run the app by running `dotnet run` in the DotnetTemplate.Web folder.

You can now see the website by going to [https://localhost:80/](https://localhost:80/)

# Running the tests

## Running the web tests
These tests are in the DotnetTemplate.Web.Tests project. They can be run from the terminal using `dotnet test` inside the project folder.

## Typescript tests
The typescript tests are run using Jasmine, and can be found in `DotnetTemplate.Web/Scripts/spec`. The tests can be run from the terminal using `npm t` inside DotnetTemplate.Web.

## Typescript linting
The typescript is linted with eslint. Linting can be run with `npm run lint` inside `DotnetTemplate.Web`. `npm run lint-fix` may autofix some errors.

# Troubleshooting

## Undeclared variable warning in `index.scss` (DotnetTemplate.Web)

This might be a result of the css directory not being built.

To make sure the css is built correctly run `npm run dev` (for development) or `npm run build` while in the DotnetTemplate.Web folder in the terminal.

# Logging
We're using [serilog](https://serilog.net/), specifically [serilog for .net core](https://nblumhardt.com/2019/10/serilog-in-aspnetcore-3/). This will automatically log:
* Any ASP.NET Core logs with level warning or above
* Any requests (excluding requests to static files)

We can add any additional logs using the `.Log` method.

The log output will go to the console.
