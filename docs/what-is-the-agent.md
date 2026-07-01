# What is “the agent”?

You did **not** ship a new AI product. This repo is a **workflow + instructions** for an existing assistant.

| Piece | Role |
|-------|------|
| **Your AI host** (Cursor, Claude Code, …) | Runs the chat and terminal |
| **`AGENTS.md`** | Tells the model how to behave (bootstrap + wizard rules) |
| **`docs/playbook.md`** | What to do in each migration phase |
| **Meraki Magic MCP** (optional) | Tools to call the Meraki Dashboard API |
| **You** | API key, enable MCP in UI, approve writes, physical work |

When you paste the [bootstrap prompt](../prompts/bootstrap-and-wizard.md), the **same** model adopts the wizard role and can run terminal steps to install MCP — then continues into Phase 0 discovery.

There is no separate server or trained model in this repository.
