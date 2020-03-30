[
  {
    "essential": true,
    "memory": 256,
    "name": "terraform-myapp",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:1",
    "portMappings": [
        {
            "containerPort": 8080,
            "hostPort": 3000
        },
        {
            "containerPort": 8081,
            "hostPort": 3001
        }
    ]
  }
]
