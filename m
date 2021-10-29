Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D935A43FCE6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhJ2NGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:06:14 -0400
Received: from mail-mw2nam08on2072.outbound.protection.outlook.com ([40.107.101.72]:64608
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231674AbhJ2NGD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSC0bJbLUG2wYn2hfp9fd1AUCmULk/cf8h9TP5cDPyMdnbGxds0C4rTA489q2Z92EeCkin8y9L9Eh1yjvh3MAE6RQVdIt6TGs9FmHXpInJaWuzANmw/m2lI4iHaVN7YRFVEEoca7MvtjzSYumKNzOJVpM2pDLhPojMLPeqbqsmSYwFx21hmMXrGqxH6q1LtH2syIN4bVfhy8E06rI/MA9cl5XJgMqzWCXzwxLVBoDHb3xBx/HbNv10QgKidX0tHBm36KcZCJ6yZ05bmxCpQSt8p24e/Zi2dAV5AQyNdtnyAU1GFYPQaIzC3GFE54584G9wS08/rDRRobQYuHFQKOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxqAWVZ7OUr+GD/VOpHPqRW5RhLg5vXlS2zB9tCsU0o=;
 b=UXspX6jwyTmpWkI7rw1ZEVKCqnqFO1D5IoELkxI/uhJjxlKSissRCg3XqqfewDFiwUcZkysgJ3MGPCCh2GJRNWnWyyC2gj/TB/imoLASCt0SR2atr73ZRg7i5X+ur9pMRXMtRXTc1d1SN0Cw3nM1UBA7xpwdzy/gsm6OK6lpWs+H9Z+2P7TrxZj3VLCsRf4wHVxtEdQ7hKJ5a0hnvnymoy3asuNoDKgnHEe0cQtIMBZWa3zwWjD/fME0ewrKacM3nNc2mC6vucCeX8gLE1hg2xPAToW+TTn5iGFpj2u+SMRvHk/CxfW8QmMt+xN52PigUtVpF282BOXxTVkfBj5Trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxqAWVZ7OUr+GD/VOpHPqRW5RhLg5vXlS2zB9tCsU0o=;
 b=EV5hi/kOejqjO1KFOC/ycz/bvDQoju0YthshPPeFq1OrTRrVmrrZDIrF2CWqo5a7niDWGtTfnBZmfPGGhl0TKwb/JiGGG1wlzfNFutlcIwMHgnHguQ5sOTf8P70CQC5qS+Ue/FC15JFiTcmyllo9TG0M+5cmtgKqBDbdi6fKMOA=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by BY5PR12MB4834.namprd12.prod.outlook.com (2603:10b6:a03:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 13:03:32 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::c2) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:03:32 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:27 -0500
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
Subject: [PATCH v3 03/21] ACPI: CPPC: implement support for SystemIO registers
Date:   Fri, 29 Oct 2021 21:02:23 +0800
Message-ID: <20211029130241.1984459-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb807444-c7ae-408a-6acd-08d99adc82ad
X-MS-TrafficTypeDiagnostic: BY5PR12MB4834:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4834C19E4B33D6709EC275E9EC879@BY5PR12MB4834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wF+9pSIDNOiZTncqy7T3reXoABYTXnrvrgVaajlVXdoqADByz5g1/XnBAYxrZmQKwVcfkqKyywOOYRaQI+lwhmzL5AJXgMHVUUgVuRITMKRP4JjNSngMoem1+GSvdBVIseNlO5Xqy2f0d51lfJGlvvDWh31ZAET2FsEXemCLOx89zd4iQE5FyocWpqRikHPANfRMktgUgyapLzBT48spFCcZRDAoMbzFaITvNPdjRzahBZAzvcoD8+sAc0Vpi2zlwEsWHFv9Deh/yWN573AdvMZ6ST2j29vn+/J0br1Zrjk3mg8FxYTj+Fi+E9taJaFaUrN92acCaU2Fjt+GS6eUnh9sHcI7+T2Zo4AQLJuxWL/1LNscfOTyXKafqYY6ncI2Q5yi4F1aYPdp1JyzI3iG0jb5u8nelvI1cop00cOPj4hxiDuu47CjF5zunqupYtYbqdoQc5vdCo/5j6zyCn8NkOWVz4topf6llsnhOL1HwGXHi6Mx078IrvYRl/RUrowfOrhgInOy4NGUiaR8ro61dfHJmvMpGDyxpk/PUPXrJ7GKVUNeExSwl6PvU8Sng9us5LZLOEde34/i0/RhVesl1A9X040rWVIMsAYgX7jdV16rzN+x0wzmemAf2Z8EnN79fKOZqgr3R612vFlZXb7AWgfTkliyoFKH7WGO0XHXALG9eInC9RzOz+bzaLsvvsCxlS/yo0S8Fl7qSmC5VmXymGUNBRn7PWQiJLC66vBiBLw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(16526019)(186003)(5660300002)(316002)(2616005)(426003)(86362001)(4326008)(336012)(2906002)(7416002)(1076003)(82310400003)(70586007)(70206006)(26005)(508600001)(36860700001)(8936002)(81166007)(36756003)(356005)(7696005)(83380400001)(54906003)(47076005)(8676002)(6666004)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:03:32.3802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb807444-c7ae-408a-6acd-08d99adc82ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4834
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
index bd482108310c..444c7a4605ad 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -759,9 +759,24 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
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
@@ -936,7 +951,20 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
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
@@ -975,7 +1003,19 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
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

