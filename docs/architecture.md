# Architecture

## Core Objects

### Canon

The canon is the shared doctrine file.
It defines:

- `sect_id`
- `version`
- `principles`
- `prohibitions`
- `rituals`
- `governance`

### Agent Profile

An agent profile is a candidate member description.
It declares:

- `agent_id`
- `display_name`
- `public_key`
- `capabilities`
- `preferred_rituals`

### Ordination Certificate

An ordination certificate is issued by the temple.
It binds an agent to:

- one `sect_id`
- one `canon_hash`
- one `ordination_issuer`

### Temple State

The local temple stores:

- `meta.json`
- `canon.json`
- `members.json`
- `proposals.json`

## Runtime Model

The local runtime is intentionally simple:

- JSON files act as the state backend
- the CLI manipulates the state
- the HTTP node exposes the same state over a minimal API

This keeps the first release easy to inspect and easy to move onto a public server later.

