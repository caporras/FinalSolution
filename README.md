# Terraform + Docker en AWS (EC2 + RDS + ECR)

## Resumen
Infraestructura de ejemplo que crea:
- EC2 (Amazon Linux 2) con Docker y user_data para ejecutar una imagen.
- RDS PostgreSQL (administrado).
- ECR repository para alojar la imagen Docker.
- Security Groups: SSH restringido por CIDR y conexión entre EC2 y RDS.
- IAM Role para EC2 con permisos READONLY a ECR.

## Justificación de elecciones
- **Computo**: Elegí **EC2** (instancia `t3.micro`) porque se pidió explícitamente acceso SSH (restricción de IPs). EC2 permite SSH directo y gestión sencilla cuando se necesita montar/depurar contenedores.
- **Contenedores**: Usamos **ECR** para almacenar la imagen y `docker run` en EC2. Esto simplifica permisos y es nativo en AWS.
- **Base de datos**: **RDS Postgres** (versión moderna) — administración gestionada, backups y seguridad integrados.
  > Nota: Postgres 9 está EOL; en el contenedor incluyo `postgresql-client-9.6` para compatibilidad si fuese necesario, pero RDS usar Postgres 13 (soporte y seguridad).

## Requisitos previos
- Cuenta AWS con permisos para crear EC2, RDS, ECR, IAM, S3 (si usa backend).
- AWS CLI y Terraform instalado localmente (si vas a ejecutar).
- Llave pública SSH (para acceder a EC2).
- GitHub repo y Secrets para pipeline (si usas GitHub Actions).

## Cómo usar (manual)
1. Clona repo.
2. Edita `terraform/variables.tf` y cambia:
   - `ssh_allowed_cidr` por tu IP (ej: `1.2.3.4/32`).
   - `db_password` por un password seguro.
   - `public_key_path` ruta a tu llave pública.
3. (Opcional) Configurar backend S3: crea bucket y DynamoDB table, luego habilita `backend-example.tf`.
4. Inicializa y aplica:
   ```bash
   cd terraform
   terraform init
   terraform apply
