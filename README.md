# Mock Investigation Case App

A mock investigation case management application built with **Flutter** (frontend) and **FastAPI** (backend). This app allows users to browse, filter, and search investigation cases, view case details, and track case status through a visual pipeline.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Backend Setup](#backend-setup)
  - [Frontend Setup](#frontend-setup)
- [Design Notes](#design-notes)
- [Tasks](#tasks)
- [Concerns / Known Issues](#concerns--known-issues)
- [Observations](#observations)
- [Contributing](#contributing)

---

## Overview

This project is a mock UI/UX implementation of an investigation case tracker, integrating sidebar navigation and stats components from existing internal projects (LEADS-Frontend and Investigation Cases) into a unified experience, styled according to DDL branding guidelines.

## Tech Stack

- **Frontend:** Flutter (Web)
- **Backend:** FastAPI (Python)
- **Font:** Poppins
- **Branding:** DDL Design System (colors, spacing, components)

---

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured for web
- Python 3.9+ installed (`python3 --version`)
- Google Chrome (for running the Flutter web app)

---

## Getting Started

### Backend Setup

Navigate to the backend directory before running the following commands:

```bash
# 1. Check Python version
python3 --version

# 2. Create a virtual environment
python3 -m venv .venv

# 3. Activate the virtual environment
source .venv/bin/activate      # macOS/Linux
# .venv\Scripts\activate       # Windows

# 4. Install dependencies
pip install -r requirements.txt

# 5. Run the backend server
uvicorn app.main:app --reload
```

> **Note:** Ensure the virtual environment is activated (`source .venv/bin/activate`) every time before running the backend. The original command should reference the `.venv` folder created above (`source .venv/bin/activate`, not `source venv/bin/activate`).

By default, FastAPI/Uvicorn will serve the API at `http://127.0.0.1:8000`. API docs are available at `http://127.0.0.1:8000/docs`.

### Frontend Setup

From the Flutter project root:

```bash
# Install dependencies
flutter pub get

# Run the app in Chrome on a fixed port
flutter run -d chrome --web-port 1337
```

The app will be available at `http://localhost:1337`.

> ⚠️ Make sure the backend server is running **before** launching the frontend so data can be fetched correctly.

---

## Design Notes

- Remove the top bar from the layout.
- Use **Poppins** as the global font family.
- Adhere to **DDL Branding** guidelines (colors, spacing, iconography, component styling).

---

## Tasks

### HIGH-PRIORITY
- [ ] **Tribe Selection based Rendering** - Implement tribe selection based rendering where user selects a provider_key then render (Dump workspace). 
- [ ] **Pipeline** - Modify the pipeline in the sidebar. This should match the original's mockup design.
- [ ] **Information Box** - Implement information box / metadata box for each source tribe expansion and add the action button use fmt bytes or fmt count to convert the data. Based it from original mockup design. You can find it in the sidebar.  
- [ ] **Add Source** - Implement Add Source Functionality. 
- [ ] **Collection Tab** - From finance workspace. Implement the collection's tab (from to - start collection in the original mockup frontend)  

### LOW-PRIORITY
- [ ] **Sidebar Integration** — Port sidebar navigation component from `LEADS-Frontend`.
- [ ] **Sidebar Expansion** — Implement expand/collapse behavior as seen in `Investigation Cases`.
- [ ] **Dynamic Table Width** — Calculate column width dynamically based on the largest word/content length per column.

---

## Concerns / Known Issues

- **Scrollable Pipeline** — The pipeline view needs to support scrolling (horizontal/vertical, TBD) when content overflows.
- **Tribe Expansion Tile** — Text overflow (ellipsis/wrapping) is not working correctly on the expandable tile.
- _(Open item — add additional concerns here as they're discovered.)_

---

## Observations

- The **Main Content Widget** updates/changes when a source is clicked, indicating state is being lifted or managed at a parent/controller level.
- _(Open item — add additional observations here as they're discovered.)_

---

## Contributing
When adding new tasks, concerns, or observations, please keep this README updated so the team has a single source of truth for project status.