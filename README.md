# Daily Motivation with Ollama CI Demo

This repository demonstrates how to integrate [Ollama](https://ollama.com/) into GitHub Actions to automatically generate and publish daily motivational phrases to an Astro website.

## 🌟 Project Overview

Every day at midnight UTC, this project:

1. Uses GitHub Actions to run Ollama with the Llama3.2 model
2. Generates a new inspirational phrase
3. Saves it to the repository
4. Builds and deploys an updated Astro website showcasing all phrases

Visit the [live demo site](https://emasuriano.github.io/ollama-ci-demo) to see today's motivational phrase.

| Dark                                                                                     | Light                                                                                     |
| ---------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| ![Dark](https://github.com/user-attachments/assets/07323868-7446-47ef-a627-c90426e79e9c) | ![Light](https://github.com/user-attachments/assets/6e258cdd-4b4f-497d-a925-17f3b1a062bc) |

## ⚙️ How It Works

### GitHub Actions Workflow

The entire process is orchestrated through GitHub Actions, making it fully automated:

```yml
name: deploy

on:
  push:
    branches: [main]
  workflow_dispatch:
  schedule:
    - cron: "0 0 * * *" # Runs every day at midnight UTC

jobs:
  ollama:
    # First job: Generate today's phrase with Ollama
    # ...

  build:
    # Second job: Build the Astro site
    # ...

  deploy:
    # Third job: Deploy to GitHub Pages
    # ...
```

![Visual workflow](https://github.com/user-attachments/assets/5ebba5fe-4a77-4375-8a43-b5946dab0475)

### The Process in Detail

1. **Phrase Generation Job** (`ollama`):

   - Installs Ollama on the GitHub Actions runner
   - Runs the Llama3.2 model with the prompt "Give me an inspirational phrase"
   - Saves the output to a Markdown file with the current date
   - Commits the new file to the repository

2. **Build Job** (`build`):

   - Runs after the ollama job completes successfully
   - Checks out the updated repository
   - Builds the Astro site with all phrases

3. **Deploy Job** (`deploy`):
   - Runs after the build job completes
   - Deploys the built site to GitHub Pages

## 🚀 Features

- **Fully Automated**: No manual intervention needed
- **Daily Updates**: Fresh content every day
- **Simple Architecture**: Demonstrates CI/CD principles with minimal complexity
- **Fast Deployment**: From generation to live in minutes

## 🛠️ Tech Stack

- [Ollama](https://ollama.com/) - For running Llama3.2 locally in CI environment
- [Astro](https://astro.build/) - Fast, lightweight web framework
- [TailwindCSS](https://tailwindcss.com/) - For styling
- [GitHub Actions](https://github.com/features/actions) - For CI/CD automation
- [GitHub Pages](https://pages.github.com/) - For hosting

## 📁 Project Structure

```
├── .github/workflows        # GitHub Actions configuration
│   └── deploy.yml           # Main workflow file
├── src
│   ├── components           # Astro components
│   ├── layouts              # Page layouts
│   ├── pages                # Website routes
│   ├── phrases              # Generated motivational phrases
│   │   └── YYYY-MM-DD.md    # One file per day
│   ├── styles               # CSS files
│   └── utils                # Helper functions
├── public                   # Static assets
├── astro.config.mjs         # Astro configuration
└── package.json             # Dependencies
```

## 🔄 How the Workflow Runs

1. **Scheduled Trigger**: At midnight UTC every day
2. **Manual Trigger**: On push to main branch or manual dispatch
3. **Sequential Jobs**: Each job waits for the previous one to complete
4. **Permissions Control**: Minimal permissions for security

## 🧩 Extending the Demo

You can adapt this pattern for various use cases:

- Generate blog post ideas
- Create daily statistics or reports
- Update documentation based on code changes
- Produce daily artwork or visualizations

## 📚 Getting Started

To run this project locally:

1. Clone the repository
2. Install dependencies with `npm install`
3. Run the development server with `npm run dev`

To set up your own version:

1. Fork this repository
2. Update the `astro.config.mjs` with your GitHub username
3. Enable GitHub Pages in your repository settings
4. Ensure GitHub Actions permissions are configured correctly

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## 📝 License

MIT

---

Made with ❤️ and O
