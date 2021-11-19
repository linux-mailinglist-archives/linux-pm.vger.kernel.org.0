Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27D456D63
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbhKSKe7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:34:59 -0500
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:21761
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234712AbhKSKe6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9OfQLA0AKA7JPHjeqkS3J8VG1K5lXyxWUMAkl4iBHWcUC/ZdPO7WOPzSR8mEVVRX2kRvf0P9jsbrAIg11+MwRXhcyxFVdZGg0EdF5Y7IkAj001bEKrxdsfWgmvwnVDNGwHN1IBljqKRs+HxVj2FotosSe8ZLgQFWmmLNKdE/t+9t14vRPxtq3797uZaqsDpsy6u2i0ztS7hhHhypCoitAI2P7uEvc5wtcetJQqEJlghY9wJ0wC4Vj/2e8fWepoadVx8naf1NQLQXIfo3zIMYmEjUhWQXR7NAM4+O6zm4r7eTSYGG+rOSfUyUWAqehRRs4qSfSyuCKcBrVN7IQHAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyhG7Iwmktic/nhBTF3DsMsL1bvubDHmme8VkELaobE=;
 b=TDiM/Fo+VH4xJ7/qEwNpa+YAjaQ66e7onjLe/gclPWsMsWyZNhwjEkwtwp6Az0h93otRGEOfqKmdpQZQJMsvcyj8qCoVHH5jSVz/lYUWDt3wO4Ok7dTFLv0Gr2UnE+SrrguzQ1nFOn4HJ7eR+QPMw70CkXp8STEGYzjH7qJs9KXydBB/csStitL8xuCO9z3fpr46w2wfcHDdRWY5/tPwx9WevLMMnkIcCf0TRKFlVNq8xegMZeUTAqgTKgJgKOyzDmYWlVsITKuZToLDAcne7xsipOuXk7rpDG4aNJ+p0xpiwa6KKMx2go0CqwflZPHsPzQZ3eCOZp5cYlDcyOlL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyhG7Iwmktic/nhBTF3DsMsL1bvubDHmme8VkELaobE=;
 b=CoWL2wp7PVM20aY6pi2gOML5uo1BQzzXV6vB7lH99nRvFQgp4v8+5ReErp+gRR4LB25dq4ONmo30UJz/EO0XDDmmF0fOJ/zOWB1S4T3uZSHLCY9Wx+9zT/VvGcXqolcwbj7qqYJxOWzbn1NUZRvJcMyaMYFrx5V6iBvlgD9oUG4=
Received: from DS7PR05CA0016.namprd05.prod.outlook.com (2603:10b6:5:3b9::21)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Fri, 19 Nov
 2021 10:31:55 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::2d) by DS7PR05CA0016.outlook.office365.com
 (2603:10b6:5:3b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend
 Transport; Fri, 19 Nov 2021 10:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:31:54 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:31:50 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v4 03/22] ACPI: CPPC: implement support for SystemIO registers
Date:   Fri, 19 Nov 2021 18:30:43 +0800
Message-ID: <20211119103102.88124-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119103102.88124-1-ray.huang@amd.com>
References: <20211119103102.88124-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88f3334-6359-4eea-c1fa-08d9ab47cecb
X-MS-TrafficTypeDiagnostic: CH0PR12MB5122:
X-Microsoft-Antispam-PRVS: <CH0PR12MB51222CEFFE79847A2F519013EC9C9@CH0PR12MB5122.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sec3Ph0hX0/L54q2prOBNxlxzCQErJfU9HrNY4OrJMi9N+c3rttZdHsbZlZOQGRWogjg6AtznlLtAbC+tD5mR8R4H1l8uiPQ4pLCcxZygQGhNEzLQmQwAN7DdMicqnnKZDhoh2/PCXb+HMC3ZUbzD6day30+HaXkVE0cO7OtpuMsJ/wOThf5xEp16nIwX3sPHTja/0O9U4pOy2olF1FUE2Jpg+/tHB38uMJgcsSR+gusMatDToJ2xxgrmGnqDm2Qxjp2fFl8RGQQ0LWDdhv4y1nCfKHXEjtwO51k2b2K9qLXHjSko5Qgvn7SqVSWDMI9/LBNfNFkPgqj1YUa2c6nQnMbc6nazQuck6j05jIRIsyhDt5j6gk1lZ/ceF3N9slfgj0WBxFHYvtjMNA69BM6KgPQ/uonBC4EzypsuLax+p4lATXQOFcdJtpi9q32uKisxjc/bv/G7cPpM16a/Q9aAs2uTSgfmxeuU0BjF/9XxiadDebTTtdQbPTn6qWX5pWjGpJbMidhCh8D2XEHppUUNgUENlo52vjqoEL9YKmoJTLkp/GRLppgHEtwfpaKduJ8awAYIDHX3g0BQuv/c20r7nGTMLSIRykPrGBv0nE62yWVDzFrhS1sApMHbsiWxfmqj5A73LC93eYfU/ABuX6xDahiQkRba8QXp3d9Da31nL25DSYirHBSq4EFU0MpeCaOneu4/Ou4PipoQlD/5pKL8j/d2bWYZDQGNoiGpyXUEhA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(16526019)(70586007)(8676002)(508600001)(2616005)(70206006)(54906003)(7696005)(1076003)(6666004)(316002)(4326008)(186003)(8936002)(36756003)(2906002)(110136005)(5660300002)(86362001)(81166007)(82310400003)(356005)(36860700001)(336012)(83380400001)(26005)(47076005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:31:54.9353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88f3334-6359-4eea-c1fa-08d9ab47cecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Steven Noonan <steven@valvesoftware.com>

According to the ACPI v6.2 (and later) specification, SystemIO can be
used for _CPC registers. This teaches cppc_acpi how to handle such
registers.

This patch was tested using the amd_pstate driver on my Zephyrus G15
(model GA503QS) using the current version 410 BIOS, which uses
a SystemIO register for the HighestPerformance element in _CPC.

Signed-off-by: Steven Noonan <steven@valvesoftware.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 46 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a85c351589be..ca62c3dc9899 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -746,9 +746,24 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
 				}
+			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+				if (gas_t->access_width < 1 || gas_t->access_width > 3) {
+					/* 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit. SystemIO doesn't
+					 * implement 64-bit registers.
+					 */
+					pr_debug("Invalid access width %d for SystemIO register\n",
+						gas_t->access_width);
+					goto out_free;
+				}
+				if (gas_t->address & ~0xFFFFULL) {
+					/* SystemIO registers use 16-bit integer addresses */
+					pr_debug("Invalid IO port %llu for SystemIO register\n",
+						gas_t->address);
+					goto out_free;
+				}
 			} else {
 				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
-					/* Support only PCC ,SYS MEM and FFH type regs */
+					/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
 					pr_debug("Unsupported register type: %d\n", gas_t->space_id);
 					goto out_free;
 				}
@@ -923,7 +938,20 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		u32 width = 8 << (reg->access_width - 1);
+		acpi_status status;
+
+		status = acpi_os_read_port((acpi_io_address)reg->address, (u32 *)val, width);
+
+		if (status != AE_OK) {
+			pr_debug("Error: Failed to read SystemIO port %llx\n", reg->address);
+			return -EFAULT;
+		}
+
+		return 0;
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
@@ -962,7 +990,19 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		u32 width = 8 << (reg->access_width - 1);
+		acpi_status status;
+
+		status = acpi_os_write_port((acpi_io_address)reg->address, (u32)val, width);
+
+		if (status != AE_OK) {
+			pr_debug("Error: Failed to write SystemIO port %llx\n", reg->address);
+			return -EFAULT;
+		}
+
+		return 0;
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-- 
2.25.1

