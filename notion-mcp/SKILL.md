---
name: notion-mcp
description: Guide for correctly using Notion MCP tools in Claude Code. Use this skill when working with Notion API via MCP tools, especially for creating pages, updating databases, or any operation requiring parent/properties parameters. Prevents common serialization errors where objects are incorrectly passed as JSON strings.
---

# Notion MCP Integration

## Critical: Parameter Serialization

**The #1 cause of Notion MCP errors is passing objects as JSON strings.**

When the API returns:
```
body.parent should be an object or `undefined`, instead was `"{\"page_id\": ...`"
```

This means you passed a **string** instead of an **object**.

### Correct Parameter Patterns

**Creating a page under a parent page:**
```
Tool: Notion:notion-create-pages
Parameters:
  parent: { "page_id": "abc123" }        ✅ Object
  pages: [{ "properties": { "title": "My Page" } }]

NOT:
  parent: "{\"page_id\": \"abc123\"}"    ❌ String
```

**Creating a page in a database:**
```
Tool: Notion:notion-create-pages
Parameters:
  parent: { "data_source_id": "abc123" }
  pages: [{ "properties": { "Name": "Entry title" } }]
```

**Updating a page:**
```
Tool: Notion:notion-update-page
Parameters:
  data:
    page_id: "abc123"
    command: "update_properties"
    properties: { "Status": "Done" }
```

## Tool Selection Guide

### Use High-Level Tools (Recommended)

These handle serialization correctly:

| Task | Tool |
|------|------|
| Create pages | `Notion:notion-create-pages` |
| Update page | `Notion:notion-update-page` |
| Search | `Notion:notion-search` |
| Fetch page/database | `Notion:notion-fetch` |
| Create database | `Notion:notion-create-database` |
| Update database | `Notion:notion-update-database` |

### Avoid Raw API Tools

These require manual object handling and are error-prone:

- `notionApi:API-post-page`
- `notionApi:API-patch-page`
- `notionApi:API-create-a-data-source`

If you must use raw API tools, ensure all object parameters are passed as actual objects, never as `JSON.stringify()` output.

## Common Operations

### Create a Subpage

```
Tool: Notion:notion-create-pages
parent: { "page_id": "<parent-page-id>" }
pages: [{
  "properties": { "title": "Subpage Title" },
  "content": "Page content in markdown"
}]
```

### Create a Database Entry

First fetch the database to get its schema, then:

```
Tool: Notion:notion-create-pages
parent: { "data_source_id": "<data-source-id>" }
pages: [{
  "properties": {
    "Name": "Entry title",
    "Status": "In Progress",
    "Priority": "High"
  }
}]
```

### Search and Fetch Workflow

1. Search: `Notion:notion-search` with `query: "search terms"`
2. Get full content: `Notion:notion-fetch` with `id: "<page-url-or-id>"`

### Update Page Content

```
Tool: Notion:notion-update-page
data:
  page_id: "<page-id>"
  command: "replace_content"
  new_str: "New markdown content"
```

### Update Page Properties

```
Tool: Notion:notion-update-page
data:
  page_id: "<page-id>"
  command: "update_properties"
  properties:
    "Status": "Complete"
    "Priority": "Low"
```

## Debugging Checklist

When you get a validation error:

1. **Check parameter types** - Is `parent` an object or a string?
2. **Check quotes** - Are there escaped quotes like `\"`?
3. **Use high-level tools** - Switch from `notionApi:*` to `Notion:*`
4. **Verify IDs** - Page IDs are UUIDs (with or without dashes)

## ID Formats

- **Page ID**: `2ddd3bfe-2c39-8100-868f-ddf0b1d54ef8` or `2ddd3bfe2c398100868fddf0b1d54ef8`
- **Database ID**: Same UUID format
- **Data Source ID**: UUID of the collection under a database (get via `Notion:notion-fetch`)

When extracting from URLs:
- `notion.so/Page-Title-abc123` → ID is `abc123`
- `notion.so/workspace/abc123?v=xyz` → Page ID is `abc123`, view ID is `xyz`
