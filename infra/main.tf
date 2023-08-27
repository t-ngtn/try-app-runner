resource "aws_ecr_repository" "repo" {
    name = "try-app-runner-terraform"
    image_tag_mutability = "MUTABLE"
}

resource "aws_iam_role" "apprunner" {
  name = "apprunner-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "build.apprunner.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "apprunner_ecr" {
  name       = "apprunner-ecr-access"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
  roles      = [aws_iam_role.apprunner.name]
}

resource "aws_apprunner_service" "app-runner" {
  service_name = "try-app-runner-terraform-service"

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner.arn
    }

    image_repository {
      image_identifier      = "${aws_ecr_repository.repo.repository_url}:latest"
      image_repository_type = "ECR"
    }
  }
}

output "service_url" {
  value = aws_apprunner_service.app-runner.service_url
}