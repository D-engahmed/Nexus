# Software Architecture Document (SAD)

## Compliance Framework

**Platform:** Nexus
**Version:** 1.0.0
**Status:** Final
**Date:** 2026-07-05
**Author:** Ahmed Abdullah Mohamed

---

## 1. Purpose

This document defines the comprehensive compliance framework for the **Nexus** platform, covering regulatory requirements, industry standards, and internal policies.

---

## 2. Applicable Standards

| Standard | Description | Applicability | Priority |
| :--- | :--- | :--- | :--- |
| **PCI DSS** | Payment Card Industry Data Security Standard | Card payment processing | Required |
| **SOC 2** | Service Organization Control 2 | Security, availability, confidentiality | Required |
| **ISO 27001** | Information Security Management System | Security management | Required |
| **ISO 27701** | Privacy Information Management | Privacy management | Required |
| **GDPR** | General Data Protection Regulation | EU data subjects | Required |
| **CCPA/CPRA** | California Consumer Privacy Act | California residents | Required |
| **PIPEDA** | Personal Information Protection and Electronic Documents Act | Canadian residents | Required |
| **LGPD** | Lei Geral de Proteção de Dados | Brazilian residents | Required |
| **PDPA** | Personal Data Protection Act | Singapore residents | Required |

---

## 3. Compliance Control Mapping

| Control Area | PCI DSS | SOC 2 | ISO 27001 |
| :--- | :--- | :--- | :--- |
| **Access Control** | 7.1-7.3 | CC6.1-6.8 | A.9.1-9.4 |
| **Network Security** | 1.1-1.4 | CC6.6-6.7 | A.13.1-13.2 |
| **Data Encryption** | 3.4-3.5 | CC6.7 | A.10.1 |
| **Vulnerability Management** | 6.1-6.2 | CC7.1 | A.12.6 |
| **Incident Response** | 12.10 | CC7.2-7.4 | A.16.1 |
| **Logging & Monitoring** | 10.1-10.7 | CC7.2 | A.12.4 |
| **Business Continuity** | 12.10.1 | A1.1-1.6 | A.17.1-17.2 |
| **Training & Awareness** | 12.6 | CC7.3 | A.7.2 |

---

## 4. PCI DSS Compliance

| Requirement | Description | Status | Owner | Target Date |
| :--- | :--- | :--- | :--- | :--- |
| **1. Firewalls** | Install and maintain firewall configuration | In Progress | Infrastructure | 2026-09-30 |
| **2. Password Security** | Default passwords must be changed | Completed | Security | 2026-06-30 |
| **3. Cardholder Data** | Protect stored cardholder data | Completed | Engineering | 2026-06-30 |
| **4. Encryption** | Encrypt transmission of cardholder data | Completed | Engineering | 2026-06-30 |
| **5. Anti-Virus** | Protect against malware | Completed | Infrastructure | 2026-06-30 |
| **6. Secure Systems** | Develop and maintain secure systems | In Progress | Engineering | 2026-09-30 |
| **7. Access Control** | Restrict access to cardholder data | Completed | Security | 2026-06-30 |
| **8. Authentication** | Identify and authenticate access | Completed | Security | 2026-06-30 |
| **9. Physical Security** | Restrict physical access | N/A | Operations | N/A |
| **10. Logging** | Log and monitor all access | In Progress | Engineering | 2026-09-30 |
| **11. Testing** | Regularly test security systems | Planned | Security | 2026-12-31 |
| **12. Policy** | Maintain information security policy | In Progress | Legal | 2026-09-30 |

### PCI DSS Compliance Activities

| Activity | Frequency | Status | Owner |
| :--- | :--- | :--- | :--- |
| Self-Assessment Questionnaire (SAQ) | Annual | Planned | Security |
| ASV Vulnerability Scan | Quarterly | In Progress | Security |
| Penetration Testing | Annual | Planned | Security |
| External PCI Audit | Annual | Planned | Security |

---

## 5. SOC 2 Trust Service Criteria

| Criterion | Description | Status | Owner | Target Date |
| :--- | :--- | :--- | :--- | :--- |
| **Security** | System is protected against unauthorized access | In Progress | Security | 2026-12-31 |
| **Availability** | System is available for operation and use | In Progress | Operations | 2026-12-31 |
| **Processing Integrity** | System processing is complete, accurate, and timely | In Progress | Engineering | 2026-12-31 |
| **Confidentiality** | Information designated confidential is protected | In Progress | Security | 2026-12-31 |
| **Privacy** | Personal information is collected, used, and disclosed appropriately | In Progress | Legal | 2026-12-31 |

### SOC 2 Audit Activities

| Activity | Status | Owner | Target Date |
| :--- | :--- | :--- | :--- |
| SOC 2 Type I Audit (Design of Controls) | Planned | Security | Q3 2026 |
| SOC 2 Type II Audit (Operating Effectiveness) | Planned | Security | Q3 2027 |
| Control Testing | Ongoing | Security | Ongoing |

---

## 6. ISO 27001 Compliance

### ISO 27001 Clauses

| Clause | Description | Status | Owner | Target Date |
| :--- | :--- | :--- | :--- | :--- |
| **4. Context** | Understand organization and its context | Completed | Legal | 2026-06-30 |
| **5. Leadership** | Leadership and commitment | In Progress | Executive | 2026-09-30 |
| **6. Planning** | Planning for ISMS | In Progress | Security | 2026-09-30 |
| **7. Support** | Resources, competence, awareness | In Progress | HR | 2026-09-30 |
| **8. Operation** | Operational planning and control | In Progress | Engineering | 2026-12-31 |
| **9. Performance** | Monitoring, measurement, analysis, evaluation | Planned | Security | 2026-12-31 |
| **10. Improvement** | Nonconformity and corrective action | Planned | Engineering | 2026-12-31 |

### ISO 27001 Annex A Controls

| Control Area | Controls | Status | Owner |
| :--- | :--- | :--- | :--- |
| A.5: Information Security Policies | 2 | In Progress | Security |
| A.6: Organization | 7 | In Progress | Security |
| A.7: Human Resource Security | 6 | In Progress | HR |
| A.8: Asset Management | 10 | In Progress | Security |
| A.9: Access Control | 14 | Completed | Engineering |
| A.10: Cryptography | 2 | Completed | Engineering |
| A.11: Physical Security | 15 | N/A | Operations |
| A.12: Operations Security | 14 | In Progress | Engineering |
| A.13: Communications Security | 7 | In Progress | Engineering |
| A.14: System Acquisition | 13 | In Progress | Engineering |
| A.15: Supplier Relationships | 5 | In Progress | Security |
| A.16: Incident Management | 7 | In Progress | Security |
| A.17: Business Continuity | 4 | In Progress | Operations |
| A.18: Compliance | 8 | In Progress | Legal |

---

## 7. GDPR Compliance

| Principle | Requirement | Status | Owner | Target Date |
| :--- | :--- | :--- | :--- | :--- |
| **Lawfulness** | Data processing is lawful, fair, and transparent | Completed | Legal | 2026-06-30 |
| **Purpose Limitation** | Data collected for specified, explicit purposes | Completed | Legal | 2026-06-30 |
| **Data Minimization** | Collection is limited to what is necessary | Completed | Engineering | 2026-06-30 |
| **Accuracy** | Data is accurate and kept up-to-date | In Progress | Engineering | 2026-09-30 |
| **Storage Limitation** | Data is stored only as long as necessary | In Progress | Engineering | 2026-09-30 |
| **Integrity & Confidentiality** | Data is processed securely | Completed | Security | 2026-06-30 |
| **Accountability** | Controller is accountable for compliance | In Progress | Legal | 2026-12-31 |

### GDPR Data Subject Rights

| Right | Implemented | Description |
| :--- | :--- | :--- |
| **Right to Access** | In Progress | Subject Access Request (SAR) implementation |
| **Right to Rectification** | Completed | Users can update their data |
| **Right to Erasure** | In Progress | Account deletion with data purge |
| **Right to Restrict Processing** | In Progress | Processing restriction controls |
| **Right to Data Portability** | In Progress | Data export functionality |
| **Right to Object** | In Progress | Objection handling |

---

## 8. CCPA/CPRA Compliance

| Requirement | Status | Owner | Target Date |
| :--- | :--- | :--- | :--- |
| **Right to Know** | In Progress | Legal | 2026-09-30 |
| **Right to Delete** | In Progress | Engineering | 2026-09-30 |
| **Right to Opt-Out** | In Progress | Engineering | 2026-09-30 |
| **Right to Correct** | Completed | Engineering | 2026-06-30 |
| **Right to Limit Use** | In Progress | Legal | 2026-12-31 |
| **Privacy Policy** | Completed | Legal | 2026-06-30 |

---

## 9. Compliance Dashboard

| Framework | Status | Progress | Next Audit |
| :--- | :--- | :--- | :--- |
| **GDPR** | In Progress | 75% | Q4 2026 |
| **CCPA/CPRA** | In Progress | 60% | Q4 2026 |
| **PCI DSS** | In Progress | 65% | Q1 2027 |
| **SOC 2** | In Progress | 50% | Q3 2026 |
| **ISO 27001** | In Progress | 45% | Q4 2026 |
| **ISO 27701** | Planned | 10% | Q1 2027 |

---

## 10. Audit Schedule

| Audit | Type | Frequency | Next Date | Owner |
| :--- | :--- | :--- | :--- | :--- |
| **PCI DSS** | External | Annual | Q1 2027 | Security |
| **SOC 2 Type I** | External | Initial | Q3 2026 | Security |
| **SOC 2 Type II** | External | Annual | Q3 2027 | Security |
| **ISO 27001** | External | Annual | Q4 2026 | Security |
| **ISO 27701** | External | Annual | Q1 2027 | Security |
| **Internal Security** | Internal | Quarterly | Ongoing | Security |
| **Data Privacy** | Internal | Quarterly | Ongoing | Legal |

---

## 11. Version History

| Version | Date | Author | Changes |
| :--- | :--- | :--- | :--- |
| 1.0.0 | 2026-07-05 | Ahmed Abdullah Mohamed | Initial compliance framework |