resource "random_password" "wordpress_admin_password" {
    
    length  = 10

    lower   = true
    upper   = true
    numeric = true
    special = true

    min_lower   = 1
    min_upper   = 1
    min_numeric = 1
    min_special = 1

    override_special = "!#$%&+-"
}

resource "random_password" "mariadb_master_password" {
    length  = 10

    lower   = true
    upper   = true
    numeric = true
    special = true

    min_lower   = 1
    min_upper   = 1
    min_numeric = 1
    min_special = 1

    override_special = "!#$%&+-"
}

resource "random_password" "mariadb_user_password" {
    length  = 10

    lower   = true
    upper   = true
    numeric = true
    special = true

    min_lower   = 1
    min_upper   = 1
    min_numeric = 1
    min_special = 1

    override_special = "!#$%&+-"
}

resource "random_password" "mariadb_replicator_password" {
    length  = 10

    lower   = true
    upper   = true
    numeric = true
    special = true

    min_lower   = 1
    min_upper   = 1
    min_numeric = 1
    min_special = 1

    override_special = "!#$%&+-"
}
