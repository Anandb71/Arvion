# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability within Arvion, please follow these steps:

### Do NOT

- **Do not** open a public GitHub issue for security vulnerabilities
- **Do not** disclose the vulnerability publicly before it's been addressed

### Do

1. **Email** the maintainers directly at [security email - add your email]
2. **Include** as much information as possible:
   - Type of vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### What to Expect

- **Acknowledgment** within 48 hours
- **Status update** within 7 days
- **Resolution timeline** based on severity

### After Resolution

Once the vulnerability is fixed:
- A security advisory will be published
- Credit will be given to the reporter (unless anonymity is requested)
- A new version will be released

## Security Best Practices for Users

### API Key Storage

- **Gemini API keys are stored securely** using `flutter_secure_storage`
- On Windows, this uses **Windows Credential Manager** (OS-level encryption)
- Keys are NOT stored in the Isar database or any plain-text files
- Keys are never transmitted except to the Gemini API directly

### Data Storage

- Arvion stores all data locally using Isar database
- Data is stored in your user profile directory
- No data is transmitted to external servers (except AI queries to Google Gemini when you use the chat)

### Screen Time Data

- Screen time data is stored locally only
- App usage monitoring runs on-device
- No usage data is sent externally

### Backups

- Use Settings → Export Backup for JSON backup
- Use Settings → Export History for CSV export
- Store backup files securely

## Scope

This security policy applies to:
- The Arvion desktop application
- Official releases from this repository
- Documentation and associated tooling

Thank you for helping keep Arvion and its users safe! 🔒
