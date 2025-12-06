@echo off
cd "C:\Users\miaol\OneDrive - Clemson University\blog_website"

REM Initialize Git if needed
if not exist .git git init

REM Set branch and remote
git branch -M main
git remote get-url origin >nul 2>&1 || git remote add origin https://github.com/r4miao/myblog.git

REM Stage and commit
git add .
git commit -m "Sync commit" 2>nul

REM Clear credentials and sync
cmdkey /delete:git:https://github.com >nul 2>&1
git pull origin main --allow-unrelated-histories --no-edit 2>nul
git push -u origin main

pause
