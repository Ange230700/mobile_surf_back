# Dockerfile

# 1) Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj(s) and restore as a distinct layer
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and publish
COPY . ./
RUN dotnet publish -c Release -o /app/publish /p:UseAppHost=false

# 2) Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# (Optional) tell Render which port you'll bind to fastest
# EXPOSE 10000

COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MobileSurfBack.dll"]

