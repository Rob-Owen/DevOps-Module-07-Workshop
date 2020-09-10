#!/bin/bash

set -e

cd DotnetTemplate.Web

npm install

npm run build

npm run lint

npm test

cd ..

dotnet build

dotnet test