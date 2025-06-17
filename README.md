# Kong Konnect Terraform Template

This Terraform template provides a modular approach to managing Kong Konnect resources, including services, routes, and plugins. It's designed to be easily customizable and reusable across different environments.

## Features

- Modular service configuration with support for multiple services
- Built-in support for common plugins (CORS, OpenID Connect)
- API documentation and portal publication
- Environment-specific configurations
- Secure handling of sensitive data

## Prerequisites

- Terraform >= 1.0.0
- Kong Konnect account
- Personal Access Token (PAT) with appropriate permissions
- Developer Portal ID

## Quick Start

1. Clone this repository:
```bash
git clone <repository-url>
cd konnect-terraform-template
```

2. Make a copy of the example configuration:
```bash
cp example.tfvars.copy example.tfvars
```

3. Update `example.tfvars` with your values:
```hcl
konnect_pat             = "your_pat_here"
konnect_server_url      = "https://us.api.konghq.com"
control_plane_name      = "your-control-plane"
control_plane_description = "Your control plane description"
portal_id               = "your_portal_id"
```

4. Initialize Terraform:
```bash
terraform init
```

5. Review the planned changes:
```bash
terraform plan -var-file="example.tfvars"
```

6. Apply the configuration:
```bash
terraform apply -var-file="example.tfvars"
```

## Project Structure

```
konnect-terraform-template/
├── main.tf              # Main configuration and provider setup
├── variables.tf         # Variable definitions
├── services/           # Service-specific configurations
│   ├── example-service/
│   └── grpc-service/
├── example.tfvars.copy # Example variable values
└── README.md          # This file
```

## Available Services

- **Example Service**: Basic HTTP service with CORS support
- **gRPC Service**: gRPC service configuration
- **External Service**: External API integration with OpenID Connect
- **Internal Service**: Internal API with authentication

## Security Notes

- Never commit `.tfvars` files containing sensitive data
- Use environment variables or secure secret management for PAT tokens
- Review and adjust CORS and authentication settings for your environment

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
