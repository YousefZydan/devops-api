# المرحلة الأولى: Build
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY DevOpsApi/DevOpsApi.csproj DevOpsApi/
RUN dotnet restore DevOpsApi/DevOpsApi.csproj
COPY DevOpsApi/ DevOpsApi/
WORKDIR /src/DevOpsApi
RUN dotnet publish -c Release -o /app/publish

# المرحلة التانية: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "DevOpsApi.dll"]
