output "parent" {
    value = pingone_user.parent.id
}

output "children" {
    value = jsonencode([{"id": "${pingone_user.child1.id}", "limit": 100},{"id": "${pingone_user.child2.id}", "limit": 200}])
}