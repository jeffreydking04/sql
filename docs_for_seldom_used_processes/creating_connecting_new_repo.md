# Connecting Local Directory to GitHub Repository

## Create New Repository on GitHub
1. Go to GitHub.com
2. Click New Repository button
3. Fill in repository name and description
4. Choose public/private
5. Don't initialize with README if connecting existing directory

Do your .gitignore firsts

## Connect Local Directory
```bash
cd /path/to/your/directory
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/username/repo-name.git
git push -u origin main
```

## Tips
- Make sure directory isn't already a git repository
- Create .gitignore before first commit if needed
- Verify remote connection with `git remote -v`
- Check branch name with `git branch`

## Common Issues
- Authentication: Use personal access token if needed
- Remote exists: Use `git remote set-url` to update
- Branch naming: Many repos use 'main' instead of 'master'


## Creating .gitignore
1. Create file in root directory:
```bash
touch .gitignore
```

2. Common entries to add:
```
# System files
.DS_Store
.env
.env.local

# IDE/Editor files
.vscode/
.idea/
*.swp

# Dependencies
node_modules/
venv/
__pycache__/

# Build outputs
dist/
build/
*.pyc

# Log files
*.log
npm-debug.log*
```

3. Check status:
```bash
git status
```
to verify ignored files aren't being tracked

## Tips
- Add .gitignore before first commit
- Can add patterns with wildcards (*)
- Each line is a pattern to ignore
- Use # for comments
