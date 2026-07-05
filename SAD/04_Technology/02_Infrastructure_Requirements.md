# Software Architecture Document (SAD)

## Infrastructure Requirements

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## 1. Purpose

This document defines the infrastructure requirements for the **Nexus** platform, including compute, storage, networking, and capacity planning.

---

## 2. Infrastructure Overview

### Key Metrics

| Metric | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| **Total vCPU** | 16 | 32 | 128 | 128 |
| **Total Memory (GB)** | 32 | 64 | 256 | 256 |
| **Total Storage (GB)** | 500 | 1,000 | 5,000 | 5,000 |
| **Network Bandwidth (Gbps)** | 1 | 5 | 10 | 10 |
| **Database Connections** | 50 | 100 | 500 | 500 |
| **API Throughput (req/sec)** | 100 | 500 | 5,000 | 5,000 |

---

## 3. Compute Infrastructure

### Instance Type Mapping

| Service | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| **API Gateway** | t3.small | t3.medium | m6g.xlarge | m6g.xlarge |
| **Order Service** | t3.medium | m6g.large | m6g.2xlarge | m6g.2xlarge |
| **Payment Service** | t3.medium | m6g.large | m6g.2xlarge | m6g.2xlarge |
| **Delivery Service** | t3.medium | m6g.large | m6g.2xlarge | m6g.2xlarge |
| **Merchant Service** | t3.medium | m6g.large | m6g.2xlarge | m6g.2xlarge |
| **Driver Service** | t3.medium | m6g.large | m6g.2xlarge | m6g.2xlarge |
| **Customer Service** | t3.medium | m6g.large | m6g.2xlarge | m6g.2xlarge |
| **Notification Service** | t3.small | t3.medium | m6g.large | m6g.large |
| **Analytics Service** | t3.medium | m6g.large | m6g.2xlarge | m6g.2xlarge |
| **Database** | db.t3.small | db.t3.medium | db.r6g.2xlarge | db.r6g.2xlarge |
| **Cache** | cache.t3.small | cache.t3.medium | cache.r6g.large | cache.r6g.large |
| **Kafka** | kafka.t3.small | kafka.t3.medium | kafka.m6g.2xlarge | kafka.m6g.2xlarge |

### Kubernetes Cluster Configuration

| Parameter | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| **Kubernetes Version** | 1.28 | 1.28 | 1.28 | 1.28 |
| **Node Count** | 3 | 5 | 20 | 20 |
| **Node Type** | t3.medium | m6g.large | m6g.2xlarge | m6g.2xlarge |
| **Max Nodes** | 5 | 10 | 30 | 30 |
| **Min Nodes** | 3 | 3 | 10 | 10 |
| **Total CPU** | 6 | 10 | 80 | 80 |
| **Total Memory** | 12 GB | 40 GB | 320 GB | 320 GB |

---

## 4. Storage Infrastructure

### Storage Requirements

| Component | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| **Database Storage** | 100 GB | 250 GB | 1,000 GB | 1,000 GB |
| **Database IOPS** | 100 | 500 | 3,000 | 3,000 |
| **Object Storage** | 100 GB | 500 GB | 2,000 GB | 2,000 GB |
| **Backup Storage** | 100 GB | 250 GB | 1,000 GB | 1,000 GB |
| **Log Storage** | 50 GB | 100 GB | 500 GB | 500 GB |
| **Cache Storage** | 10 GB | 25 GB | 100 GB | 100 GB |

### Storage Type Mapping

| Component | Storage Type | IOPS | Throughput |
| :--- | :--- | :--- | :--- |
| **Database (Primary)** | gp3 | 3,000 | 125 MB/s |
| **Database (Replica)** | gp3 | 3,000 | 125 MB/s |
| **Object Storage** | S3 Standard | N/A | N/A |
| **Cache** | Memory | N/A | N/A |
| **Log Storage** | S3 Standard-IA | N/A | N/A |
| **Backup Storage** | S3 Glacier | N/A | N/A |

---

## 5. Networking Infrastructure

### Network Architecture

| Component | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| **VPC CIDR** | 10.0.0.0/16 | 10.1.0.0/16 | 10.0.0.0/16 | 10.1.0.0/16 |
| **Public Subnets** | 2 | 2 | 3 | 3 |
| **Private Subnets** | 2 | 2 | 3 | 3 |
| **Availability Zones** | 2 | 2 | 3 | 3 |

### Firewall Rules

| Rule | Source | Destination | Ports | Protocol |
| :--- | :--- | :--- | :--- | :--- |
| **HTTP** | Internet | Load Balancer | 80 | TCP |
| **HTTPS** | Internet | Load Balancer | 443 | TCP |
| **SSH** | VPN | Bastion Host | 22 | TCP |
| **API Gateway** | Load Balancer | API Gateway | 8080 | TCP |
| **Service to Service** | Services | Services | 8081-8088 | TCP |
| **Database** | Services | Database | 5432 | TCP |
| **Cache** | Services | Cache | 6379 | TCP |
| **Kafka** | Services | Kafka | 9092 | TCP |

---

## 6. Database Infrastructure

### Database Cluster Configuration

| Parameter | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| **Engine** | PostgreSQL | PostgreSQL | PostgreSQL | PostgreSQL |
| **Version** | 16.x | 16.x | 16.x | 16.x |
| **Instance Class** | db.t3.small | db.t3.medium | db.r6g.2xlarge | db.r6g.2xlarge |
| **Storage** | 100 GB | 250 GB | 1,000 GB | 1,000 GB |
| **Multi-AZ** | No | No | Yes | Yes |
| **Read Replicas** | 0 | 0 | 2 | 2 |
| **Backup Retention** | 7 days | 7 days | 30 days | 30 days |

---

## 7. Cache Infrastructure

### Cache Cluster Configuration

| Parameter | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| **Engine** | Redis | Redis | Redis | Redis |
| **Version** | 7.x | 7.x | 7.x | 7.x |
| **Node Type** | cache.t3.small | cache.t3.medium | cache.r6g.large | cache.r6g.large |
| **Number of Nodes** | 1 | 1 | 3 | 3 |
| **Memory** | 2 GB | 4 GB | 16 GB | 16 GB |
| **Multi-AZ** | No | No | Yes | Yes |

---

## 8. Message Queue Infrastructure

### Kafka Cluster Configuration

| Parameter | Development | Staging | Production | DR |
| :--- | :--- | :--- | :--- | :--- |
| **Broker Nodes** | 1 | 3 | 6 | 6 |
| **Instance Type** | kafka.t3.small | kafka.t3.medium | kafka.m6g.2xlarge | kafka.m6g.2xlarge |
| **Storage per Broker** | 100 GB | 250 GB | 1,000 GB | 1,000 GB |
| **Total Partitions** | 20 | 50 | 200 | 200 |
| **Replication Factor** | 1 | 2 | 3 | 3 |
| **Message Retention** | 24 hours | 7 days | 7 days | 7 days |

---

## 9. Cost Estimates (Monthly - Production)

| Component | Type | Monthly Cost (USD) |
| :--- | :--- | :--- |
| **Compute** | EC2 Instances | $8,000 |
| **Database** | RDS | $2,500 |
| **Cache** | ElastiCache | $1,000 |
| **Message Queue** | MSK | $1,500 |
| **Storage** | S3/EBS | $2,000 |
| **Network** | Data Transfer/LB | $1,500 |
| **Monitoring** | CloudWatch/Logs | $1,000 |
| **Security** | WAF/Shield | $500 |
| **Backup** | Backup Storage | $500 |
| **Total** | | **$18,500** |

---

## 10. Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial infrastructure requirements |