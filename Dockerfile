# Используем базовый образ для сборки
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Копируем файл проекта и восстанавливаем зависимости
COPY *.csproj ./
RUN dotnet restore

# Копируем все остальные файлы и собираем приложение
COPY . ./
RUN dotnet publish -c Release -o /app/out

# Используем базовый образ для запуска
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Определяем команду для запуска приложения
ENTRYPOINT ["dotnet", "proj.dll"]
