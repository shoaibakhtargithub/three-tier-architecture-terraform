cat > README.md << 'EOF'
# Three-Tier AWS Terraform Project

## Stack
- VPC + Subnets + IGW + Route Table
- EC2 for backend (Node/Express)
- RDS MySQL
- S3 static website for frontend

## How to use
1. Create `terraform.tfvars` (see `terraform.tfvars.example`).
2. (If `dist/` is ignored) Build frontend so `./dist` exists before `terraform apply`.
3. `terraform init`
4. `terraform plan`
5. `terraform apply`

## Notes
- Do not commit real secrets or `.env`.
- Do commit `.terraform.lock.hcl`.
EOF
