# Dockerfile

# 1) Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy only your project file and restore dependencies
COPY ..csproj ./
RUN dotnet restore ..csproj

# Copy everything else and publish *that* project
COPY . ./
RUN dotnet publish ..csproj \
    -c Release \
    -o /app/publish \
    /p:UseAppHost=false

# 2) Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MobileSurfBack.dll"]
