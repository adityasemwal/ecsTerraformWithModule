[
  {
    "essential": true,
    "memory": 256,
    "name": "terraform-myapp",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:latest",
    "portMappings": [
        {
            "containerPort": 80,
            "hostPort": 3000
        }
    ]
  }
]
