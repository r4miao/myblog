@echo off
setlocal

REM Change directory to your website folder
cd "C:\Users\miaol\OneDrive - Clemson University\blog_website"

REM Check if Git is initialized
if not exist .git (
    git init
    echo Initialized Git repository.
) else (
    echo Git repository already exists.
)

REM Set branch name to main
git branch -M main

REM Set remote URL to DeepSouthTours repo
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    git remote add origin https://github.com/r4miao/myblog.git
    echo Remote origin added.
) else (
    echo Remote origin already exists.
)

REM Stage and commit changes
git add .
git commit -m "Sync commit" 2>nul || echo Nothing new to commit.

REM Remove cached GitHub credentials (triggers login prompt)
cmdkey /delete:git:https://github.com >nul 2>&1
echo Cleared cached credentials. You will be prompted to enter username and PAT.

REM Pull and push to remote repo
echo Pulling from remote...
git pull origin main --allow-unrelated-histories --no-edit
if errorlevel 1 (
    echo Warning: Pull encountered an error, but continuing...
)

echo Pushing to remote...
git push -u origin main
if errorlevel 1 (
    echo Error: Push failed. Check your credentials and network connection.
    echo Trying push without -u flag...
    git push origin main
    if errorlevel 1 (
        echo Push still failed. Please check:
        echo 1. Your GitHub credentials (username and Personal Access Token)
        echo 2. Network connection
        echo 3. Repository permissions
    ) else (
        echo Successfully pushed to remote repository.
    )
) else (
    echo Successfully pushed to remote repository.
)

pause
endlocal
