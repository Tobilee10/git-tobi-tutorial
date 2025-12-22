##                     TERRAFORM CAPSTONE PROJECT

##              Using Terraform to Deploy a custom VPC for a
##                 Multi-Tier Web Application hosted in AWS

## Introduction:

The project will use Terrafrom and HCL script to deploy a highly available, auto-scaled, web application using EC2 instances in AWS.
The project will use Application load balancing to distribute the load across two
availability zones in AWS in Oregon (us-west-2) region.



##               Required Project Resources :

1. A custom VPC in AWS
2. 4 subnets, 2 public and 2 private subnets in two diﬀerent availability zone
(us-east-1aand us-east-1b).
3. An Internet Gateway to be created and attached to the VPC, use IGW as the name.
4. Two NAT Gateways (NATGW1 and NATGW2) to be created in the public subnets, one each.
5. 2 security groups WebSG (allows SSH, HTTP inbound and all traﬃc outbound) and ALBSG
(allows HTTP inbound and all traﬃc outbound)
6. 2 EBS backed EC2 instances (Instance A and Instance B)
7. A target group, WebTG
8. An applica?on load balancer WebALB
9. A launch template and an auto scaling group
10. Instance profile using IAM role to connect the instance to SSM


##                 DETAIL EXPLANATION OF THE RESOURCES USED
## VPC AND KEY COMPONENTS

## VPC : 
Virtual Private Cloud (AWS) is a virtual network environment that you create in the cloud. It allows you to have your own private section of the internet, just like having your own network within a larger network. Within this VPC, you can create and manage various resources, such as servers, databases, and storage.

Think of it as having your own little "internet" within the bigger internet. This virtual network is completely isolated from other users' networks, so your data and applications are secure and protected.

## INTERNET GATEWAY
An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet. An internet gateway enables resources in your public subnets (such as EC2 instances) to connect to the internet if the resource has a public IPv4 address or an IPv6 address. Similarly, resources on the internet can initiate a connection to resources in your subnet using the public IPv4 address or IPv6 address.

## SUBNETS
A subnet is a range of IP addresses in your VPC. Subnetwork is a smaller network in a large network. 
A Subnet is a segment of a VPC’s IP address range that resides entirely within a single Availability Zone (AZ).
Subnets serve two primary purposes:

    Segmentation: They divide large networks into smaller, isolated zones for better organization and control.
    High Availability: Distributing subnets across multiple AZs ensures fault tolerance and operational continuity.

# Public Subnet
Public subnet is a subnet within a Virtual Private Cloud (VPC) that has a direct route to an Internet Gateway, allowing its resources to communicate directly with the internet. 

# Private Subnet
Private Subnet is a subnet within a virtual private cloud that has no direct route to the internet. Resources in the private subnet reguire a NATGW device to route traffic to the internet.

# ROUTE TABLE
A route table serves as the traffic controller for your virtual private cloud (VPC). Each route table contains a set of rules, called routes, that determine where network traffic from your subnet or gateway is directed. 

# EIP
An EIP is a static, public IP address that you can associate with a cloud resource (like an EC2 instance or a NAT gateway) to enable it to have a consistent, public-facing IP address for inbound and outbound internet traffic. EIP requires an internet gateway (IGW) because the internet gateway is the specific Virtual Private Cloud (VPC) component that allows resources with public IPs (like an EIP) to communicate with the public internet. 

# NAT GATEWAY
AWS NAT Gateway is a fully managed, highly available service that allows instances in a private subnet to securely access the internet or other VPCs without allowing unsolicited inbound connections. 

# SECURITY GROUPS
A security group acts as a virtual firewall for your EC2 instances to control incoming and outgoing traffic. Inbound rules control the incoming traffic to your instance, and outbound rules control the outgoing traffic from your instance.

# IDENTITY AND ACCESS MANAGEMENT
An IAM Role is used to grant temporary, permission-based access to AWS resources for trusted entities like users, applications, or services, acting as a secure identity without needing permanent credentials, enabling secure delegation, cross-account access, and access for AWS services (like EC2 instances needing S3 access). They provide temporary credentials, following the principle of least privilege, making them a security best practice. 

An IAM role is similar to an IAM user, in that it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS. However, instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it. Also, a role does not have standard long-term credentials such as a password or access keys associated with it. Instead, when you assume a role, it provides you with temporary security credentials for your role session.

# INSTANCE PROFILE
An instance profile is a container for an IAM role that you can use to pass role information to an EC2 instance when the instance starts.

# APPLICATION LOAD BALANCER
AWS Elastic Load Balancing (ELB) is a managed service that automatically distributes incoming traffic across multiple targets—like EC2 instances, containers, and IP addresses—to increase application fault tolerance, security, and scalability. It acts as a single point of contact, ensuring high availability by routing requests only to healthy resources. 

An Application Load Balancer functions at the application layer, the seventh layer of the Open Systems Interconnection (OSI) model. After the load balancer receives a request, it evaluates the listener rules in priority order to determine which rule to apply, and then selects a target from the target group for the rule action. You can configure listener rules to route requests to different target groups based on the content of the application traffic. 

# AUTO-SCALING GROUP
An Auto Scaling group contains a collection of EC2 instances that are treated as a logical grouping for the purposes of automatic scaling and management. An Auto Scaling group also lets you use Amazon EC2 Auto Scaling features such as health check replacements and scaling policies. Both maintaining the number of instances in an Auto Scaling group and automatic scaling are the core functionality of the Amazon EC2 Auto Scaling service.



