terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.67.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}
module "contos" {
    source = "./contos"
    managementgroup = var.managementgroup
    
}
module "decom" {
    source = "./contos/decom"
    childgroupA0 =var.childgroupA0
    managementgroup-parent-ID = module.contos.managementgroup-parent-ID
}
module "platform" {
    source = "./contos/platform"
    childgroupB0 = var.childgroupB0
    managementgroup-parent-ID = module.contos.managementgroup-parent-ID
    
}
module "connectivity" {
    source = "./contos/platform/connectivity"
    childgroupB1 = var.childgroupB1
    childgroupB0-ID = module.platform.childgroupB0-ID
    
}
module "management" {
    source = "./contos/platform/management"
    childgroupB2 = var.childgroupB2
    childgroupB0-ID = module.platform.childgroupB0-ID 
}
module "identity" {
    source = "./contos/platform/identity"
    childgroupB3 = var.childgroupB3
    childgroupB0-ID = module.platform.childgroupB0-ID  
}
module "sandbox" {
    source = "./contos/sandbox"
    childgroupC0 = var.childgroupC0
    managementgroup-parent-ID = module.contos.managementgroup-parent-ID
    
}
module "workloads" {
    source = "./contos/workloads"
    childgroupD0 = var.childgroupD0
    managementgroup-parent-ID = module.contos.managementgroup-parent-ID
    
}
module "businessunit1" {
    source = "./contos/workloads/bs1"
    childgroupD1 = var.childgroupD1
    childgroupD0-ID = module.workloads.childgroupD0-ID
    
}
module "businessunit2" {
    source = "./contos/workloads/bs2"
    childgroupD2 = var.childgroupD2
    childgroupD0-ID = module.workloads.childgroupD0-ID
    
}
module "resourcegroup" {
    source = "./contos/platform/connectivity/resourcegroup"
    resource-group-name = var.resource-group-name
    location = var.location
    
}
   module "network" {
        source = "./contos/platform/connectivity/network"
        location = module.resourcegroup.location
        resouce-group-name = module.resourcegroup.resource-group-name
        vnet-name = var.vnet-name
        vnet-address-space = var.vnet-address-space
        subnet-name = var.subnet-name
        subnet-address-prefix = var.subnet-address-prefix
    }
    module "storage" {
        source = "./contos/platform/connectivity/storage"
        resource-group-name = module.resourcegroup.resource-group-name
        location = module.resourcegroup.location
        primary_database = var.primary_database
        primary_database_admin = var.primary_database_admin
        primary_database_password = var.primary_database_password
        primary_database_version = var.primary_database_version
    }
    module "compute" {
        source = "./contos/platform/connectivity/compute"
        vm_name = var.vm_name
        vm_sku = var.vm_sku
        NIC_name = var.NIC_name
        ip_configuration_name = var.ip_configuration_name
        IP_allocation = var.IP_allocation
        encryption_algorithm = var.encryption_algorithm
        rsa_bits = var.rsa_bits
        size = var.size
        username = var.username
        OS_disk_caching = var.OS_disk_caching
        stgacc_type = var.stgacc_type
        publisher = var.publisher
        offer = var.offer
        OS_version = var.OS_version
        resource_group_name = module.resourcegroup.resource-group-name
        resource_group_location = module.resourcegroup.location
        subnet_id = module.network.subnet_id
        
    }
    
module "security_rule" {
    source = "./contos/platform/connectivity/security"
    web-nsg-sr1-name = var.web-nsg-sr1-name
    web-nsg-sr1-priority = var.web-nsg-sr1-priority
    web-nsg-sr1-protocol = var.web-nsg-sr1-protocol
    web-nsg-sr1-access = var.web-nsg-sr1-access
    web-nsg-sr1-direction = var.web-nsg-sr1-direction
    web-nsg-sr1-destination_address_prefix = var.web-nsg-sr1-destination_address_prefix
    web-nsg-sr1-destination_port_range = var.web-nsg-sr1-destination_port_range
    web-nsg-sr1-source_address_prefix = var.web-nsg-sr1-source_address_prefix
    web-nsg-sr1-source_port_range = var.web-nsg-sr1-source_port_range/**/
    web-nsg-sr2-name = var.web-nsg-sr2-name
    web-nsg-sr2-priority = var.web-nsg-sr2-priority
    web-nsg-sr2-protocol = var.web-nsg-sr2-protocol
    web-nsg-sr2-access = var.web-nsg-sr2-access
    web-nsg-sr2-direction = var.web-nsg-sr2-direction
    web-nsg-sr2-destination_address_prefix = var.web-nsg-sr2-destination_address_prefix
    web-nsg-sr2-destination_port_range = var.web-nsg-sr2-destination_port_range
    web-nsg-sr2-source_address_prefix = var.web-nsg-sr2-source_address_prefix
    web-nsg-sr2-source_port_range = var.web-nsg-sr2-source_port_range/**/
    app-nsg-sr1-name = var.app-nsg-sr1-name
    app-nsg-sr1-priority = var.app-nsg-sr1-priority
    app-nsg-sr1-protocol = var.app-nsg-sr1-protocol
    app-nsg-sr1-access = var.app-nsg-sr1-access
    app-nsg-sr1-direction = var.app-nsg-sr1-direction
    app-nsg-sr1-source_address_prefix = var.app-nsg-sr1-source_address_prefix
    app-nsg-sr1-source_port_range = var.app-nsg-sr1-source_port_range
    app-nsg-sr1-destination_address_prefix = var.app-nsg-sr1-destination_address_prefix
    app-nsg-sr1-destination_port_range = var.app-nsg-sr1-destination_port_range
    app-nsg-sr2-name = var.app-nsg-sr2-name
    app-nsg-sr2-priority = var.app-nsg-sr2-priority
    app-nsg-sr2-protocol = var.app-nsg-sr2-protocol
    app-nsg-sr2-direction = var.app-nsg-sr2-direction
    app-nsg-sr2-access = var.app-nsg-sr2-access
    app-nsg-sr2-source_address_prefix = var.app-nsg-sr2-source_address_prefix
    app-nsg-sr2-source_port_range = var.app-nsg-sr2-source_port_range
    app-nsg-sr2-destination_address_prefix = var.app-nsg-sr2-destination_address_prefix
    app-nsg-sr2-destination_port_range = var.app-nsg-sr2-destination_port_range/*//*/
    app_subnet_id = var.app_subnet_id
    db-nsg-sr1-name = var.db-nsg-sr1-name
    db-nsg-sr1-priority = var.db-nsg-sr1-priority
    db-nsg-sr1-protocol = var.db-nsg-sr1-protocol
    db-nsg-sr1-direction = var.db-nsg-sr1-direction
    db-nsg-sr1-access = var.db-nsg-sr1-access
    db-nsg-sr1-destination_address_prefix = var.db-nsg-sr1-destination_address_prefix
    db-nsg-sr1-destination_port_range = var.db-nsg-sr1-destination_port_range
    db-nsg-sr1-source_address_prefix = var.db-nsg-sr1-source_address_prefix
    db-nsg-sr1-source_port_range = var.db-nsg-sr1-source_port_range/*//*/
    db-nsg-sr2-name = var.db-nsg-sr2-name
    db-nsg-sr2-priority = var.db-nsg-sr2-priority
    db-nsg-sr2-protocol = var.db-nsg-sr2-protocol
    db-nsg-sr2-direction = var.db-nsg-sr2-direction
    db-nsg-sr2-access = var.db-nsg-sr2-access
    db-nsg-sr2-destination_address_prefix = var.db-nsg-sr2-destination_address_prefix
    db-nsg-sr2-destination_port_range = var.db-nsg-sr2-destination_port_range
    db-nsg-sr2-source_address_prefix = var.db-nsg-sr2-source_address_prefix
    db-nsg-sr2-source_port_range = var.app-nsg-sr2-source_port_range
    web_subnet_id = var.web_subnet_id
    resource_group = module.resourcegroup.resource-group-name
    location = module.resourcegroup.location
} 
