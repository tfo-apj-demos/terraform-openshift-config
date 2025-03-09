terraform { 
  cloud { 
    hostname = "tfe.hashicorp.local" 
    organization = "gcve" 

    workspaces { 
      name = "ws6" 
    } 
  } 
}

resource "random_pet" "this" {
  prefix = var.prefix
  length = 200

  keepers = {
    timestamp = timestamp()
  }
}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"

  triggers = {
    # This will change whenever the pet changes, causing the sleep to occur
    pet_id = random_pet.this.id
  }
}

resource "null_resource" "this" {
  count      = var.instances
  depends_on = [time_sleep.wait_30_seconds]

  triggers = {
    pet = random_pet.this.id
  }
}