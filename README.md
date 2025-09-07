# octo-model-planning

octo-model-planning displays an attempt of a barebones end-to-end implementation of a C# .NET 9 crud enabled application that triggers events via async API, which will later be consumed inside an SAP system.

## Features

- CRUD operations for a sample entity
- Event-driven architecture using async APIs
- Specification-first approach, Async API
- CI pipeline using GitHub Actions (abap only, code quality, automated tests)

## Design

![Overall design](/docs/API-design.drawio.svg)

## Assumptions

### General

1. Communication goes one way only (C#->SAP).
2. Authentication/authorization assumes OAuth 2.0, although not implemented.
3. Middleware (Streaming Platform) is not part of the solution.

### C# Application

1. Role management in the C# application is not part of the solution.
2. Volume of data in the C# application is not considered yet (filter vs search).
3. No exception handling is implemented.
4. No logging/tracing is implemented, although uses library compatible with OpenTelemetry, leaving room for further enhancements.
5. cshtml-based front-end, barebones implementation.
6. Deployment to cloud is not considered yet.

### SAP

1. Data of C# application is still required in SAP for further processing (e.g. planning, reporting, billing, etc).
2. System version, abap version or platform not specified.
3. No exception handling is implemented.
4. No logging/tracing is implemented.

## Key design decisions

1. SAP: Flexible, target for abap cloud compatibility, can be run in ECC, S/4 and possibly adapted for SAP BTP.
2. C#: .NET 9, latest LTS version, no front-end, barebones implementation.
3. C#: Entity Framework Core, SQL Server localdb, not containerized.

## Improvements that come to mind

1. General: API versioning (wrapper class for abap, C# ?).
2. SAP: try/catch exceptions, add logging/tracing.
3. C#: Unit testing and CI.
4. C#: catch exceptions, add logging/tracing and observability (OpenTelemetry).
5. C#: add role management, authentication/authorization.
6. C#: add front-end.
7. C#: consider volume of data (filter vs search).
8. C#: deployment to cloud (GitHub Actions -> any cloud provider).
9. C#: Database containerization (Docker).
10. C#: probably like a million more things...
