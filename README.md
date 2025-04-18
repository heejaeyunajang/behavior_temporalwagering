# temporalbandit_behavior

This repository contains behavioral preprocessing and analysis code for the temporal wagering task (Constantinople Lab), where rats report their value inference through willingness to wait (see Mah et al. Nature Communications (2023) for more detail of the task structure). These scripts examine key behavioral proxies for context-dependent value, such as wait time and trial initiation response latency.

This repo supports:
- Behavioral data formatting
- Context-dependent (by offered reward amount or a hidden block structure of the task) comparisons of response latency and wait time
- Reproduction of key behavioral plots from Jang et al. bioRxiv (2024)

---

## 📂 Repository Structure
```
src/ % Analysis and plotting scripts
data/ % Behavioral data
utils/ % Helper functions
```

---

## 🧪 Requirements

- MATLAB R2021a or newer

---

## 🚀 Getting Started

### 1. Clone this repository and also the shared utilities repo

```bash
git clone https://github.com/heejaeyunajang/temporalbandit_behavior.git
git clone https://github.com/heejaeyunajang/utils_core.git
```

### 2. Add all folders to your MATLAB path
```addpath(genpath('temporalbandit_behavior/src'))
addpath(genpath('utils_core'))
```

### 3. Run the main script
main_temporalbandit_behavior

