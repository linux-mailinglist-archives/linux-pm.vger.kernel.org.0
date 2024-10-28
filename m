Return-Path: <linux-pm+bounces-16546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0172C9B2287
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5704280FE4
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98141CC17B;
	Mon, 28 Oct 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kGRsZZdt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B7192D8E;
	Mon, 28 Oct 2024 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081012; cv=fail; b=fVx6W3r+6WmKdbelMcjfUTi1mOLHrCJL5PHLV6/1bRqMZ9Vw/9Tq9YOebkVTajO7OwmFtIp7U6B7ffBfQwuzIpyOkShSCYwRGE3OjdjDB9OPoeQEOVqA+bpE2ss1V8qSmKTOubXYDhUWmeHLrNGZZBG2qjXWOropPoYdie0lCEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081012; c=relaxed/simple;
	bh=WeiwuPFtV668DILjCh+jYeKXuUIMohMCdU2H/SIJEFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfI+uZeq2P5atvtlGUMta5jBpFRtTDVQg+sm5huCOnGBusK4GSISP7GKloGSjf4nW0c+jj017nnx1h6wFrLc8i4y0kORd3I3JgLj0qqq7sg+FhzWwtNpjY/JcbDGhlBWBFJOY2/xkZ+6u0JswHt0Gu5QAn8JGEO78Pg0Pnr+vIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kGRsZZdt; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXzti22TsskghoMgmAMyM5RGwu2hAO0c6Ym1WdYcIcpMiMAERVRM2cRR6bWrbx3+nwCdJ1ZgjKLjmfeXZLhT0xnX+dAQJ9BCPnOKa5ywQsj566XhM+38JyPnfNQd3ONMRjZz0a5AsWLheNq1NOHamLUK4YpdInwB9VVPQhciOFFPXNlYiOSS+mxuNEk/JdU6WLLGNo006S1pzR2gbLWQ7cNzUf+w/hpI+Zds3jQfgY6AQ6UOyhrUIktxeRNCX/wtqW5g37ETUmS3SexNRStmmMrMmE5BIyncQ0lmbMaGIf4dfp68qA71IgcNAXp1N3MrB7XL459NHyax/b34+rHjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrV2O76s3V5JeIAZkW21NWsWDkIGx4rTXtlK/PQ+zN0=;
 b=SFuY5Wk+l2TUuv3yV4YLeY6QOKCmsJWbaF7ZJOraOqBnuL3NWOUFU4TbASTqnGWpoMgdUdkGyWEfFrMGuLSZ4DzEZLqudmHi6qahig5ot5hGHDNjP5G4gl5FduYZdk0WkGeFLRtU4LDkqsrjB+PMw6DJicZUTjbx8h/md6IdPQxgSAN2tbwBZViXeNs/za8P4XxYCzKoMCvg9r7qYl7sew9mLYmEUmuKd3t92skP0kZOmQmLGC407KxWXjLdI8cSG1Ga4x23TbTDI3hloDsRHYwg8nixg95RI9UMB3yc6JHjwRp1haTUJL0HSV1bIbaQVyCvNi9kd7FmkhJveLq5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrV2O76s3V5JeIAZkW21NWsWDkIGx4rTXtlK/PQ+zN0=;
 b=kGRsZZdtHmg3xkX2WkjklL6b6ECEofRI/NG6SssyaUbMVF+G1N1oDOHaxxpBivOYnH0qtNhEVyhZcLqg57NC+0G0YsAIR+CE271sLIz9H4hPFN7y5oAViaNP2c7xpXwrMutlAQKhf388ZadNqV4mi6pGMCzDocKCXXvL1YqVazo=
Received: from BL1PR13CA0199.namprd13.prod.outlook.com (2603:10b6:208:2be::24)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.23; Mon, 28 Oct 2024 02:03:24 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::1b) by BL1PR13CA0199.outlook.office365.com
 (2603:10b6:208:2be::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 02:03:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 10/13] x86/process: Clear hardware feedback history for AMD processors
Date: Sun, 27 Oct 2024 21:02:48 -0500
Message-ID: <20241028020251.8085-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 23312e33-30d6-4dc2-c7c2-08dcf6f4b409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KOj7rhOc7Ix7ZqLUJw9ulkabjJkekFZeW7TSVHvAmSxPDWPuugmNFYgSXeaP?=
 =?us-ascii?Q?7yd80Mu4vSrAG8oeT9iz4OBL2CYDdq2bRVesWf56znEk4S3QstIVhPZt/iXl?=
 =?us-ascii?Q?EZmeWgE4TkCy06TOaN29AdzcgtXJ0bCtxo1Eh3sseMOko/YJQKUVyGr3AjIA?=
 =?us-ascii?Q?xV+3ubJNf5KJ3yP5VvImK6FaNj8BANgbjwXyTtm3p12uT5aAvFBTo4Q9ipLP?=
 =?us-ascii?Q?5z9lasWVeYx+yFGuNqMDA4KQXzyefeda9yzLURqiIpIs8csDDUVrLwo2T1er?=
 =?us-ascii?Q?YGEdRShH9sQYDjHct8z2XAxoDN7r6ihrwmqC0FLcjtPTpqfj44pn2XIIWaIa?=
 =?us-ascii?Q?8620/V1injUsCmNb/LvPrXN1Arwu6KykckYJ/uvQRlr4FBS02umBaZMYH0YW?=
 =?us-ascii?Q?8GqwKHDQLaY84O0xDC1/b/d6w5TAFWR7W/LdqB2EZ+yORcMaSFkX3zKadT5S?=
 =?us-ascii?Q?vdrwHx0oHnN3tiv/yPP5tdNqNvfCGEeH3yTOeZ7IxkTSkuSjQ40aUW3rKbL/?=
 =?us-ascii?Q?HGqPLyPaYeOiujoYwWApEPPSNtRpRItIdE5K4LzMoyLhMrm8tjL6QCi9nOSg?=
 =?us-ascii?Q?WPhwrfFZMkmiroU3KDf596g3KU4oRvFNd6Qm4kbvI6+/FA3N6VUyY4zbCt8w?=
 =?us-ascii?Q?mlkzqbZfJ7tLjmaL1wwCIcxXGIuF6zTjhlFo4NNDEPujrpaFJKjgn2r7hr3H?=
 =?us-ascii?Q?rNnNyNoxXl+2PVImKx2wOdenqG7oHXGCXRmfNvLkGWKmUi8SUMPy6XeE9e5M?=
 =?us-ascii?Q?coowGcZqfsVf0uzhkVCsDRk7/7TNFm6koJTQj35zoCePMJQn2I6ey2R5HkAa?=
 =?us-ascii?Q?3ggOV0rK+FdGVsj6bs+HsM7CvZNuNjXQR71guU9vnd0SK6qKpCnFOraXfNrm?=
 =?us-ascii?Q?O+cDQSfvv47K5Nto9vlMj8wkrAxYO/LTiWsrreRtoOeyNBJfN5PhjC/4UJPc?=
 =?us-ascii?Q?rSwM1ZivuNdLSafiE8Lvg2IhUYo8TYSElfPQnBPVdQzme8sajoRZHkjpQWIw?=
 =?us-ascii?Q?o1RwKC254u1Bh/r6nXTUsL/sX5pXArRHviwLJYQhFJkT8IwNX/23v9WxFYjo?=
 =?us-ascii?Q?duSNPc/BGYcHgIG/k1Iw4YNlbHmHad2egEadGoPuLtIK9HX4vDHBPlTXx4oT?=
 =?us-ascii?Q?H1KaSd9AY332mtxsw2bGzjtn+tqNldF+vfyD8V4lT1WQznA8A1C85+3TRC8r?=
 =?us-ascii?Q?//1YXbbz9B2o+o5thkpNsOnXw3w2dvTLrYzRlKJk+JvpCoKGS2WKtLLSusvn?=
 =?us-ascii?Q?TOnvz9ljAkeABXNtrlPS1Nv/UetCVgdn0FKyfq5n8wtUuBLf9eya38nxuKX5?=
 =?us-ascii?Q?g77ySDTTw5ztA+hECfEOyL6KBYRHNQCYmrIC8pMw7fg2yRiKrlMb5FPC+TRl?=
 =?us-ascii?Q?0svHnCJxuu8VndoUaQV/ACSAbrRSCCfZvhiiRrwgKShSw/x6Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:23.2135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23312e33-30d6-4dc2-c7c2-08dcf6f4b409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

From: Perry Yuan <perry.yuan@amd.com>

Incorporate a mechanism within the context switching code to reset
the hardware history for AMD processors. Specifically, when a task
is switched in, the class ID was read and reset the hardware workload
classification history of CPU firmware and then it start to trigger
workload classification for the next running thread.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/hreset.h |  6 ++++++
 arch/x86/kernel/cpu/common.c  | 15 +++++++++++++++
 arch/x86/kernel/process_32.c  |  3 +++
 arch/x86/kernel/process_64.c  |  3 +++
 4 files changed, 27 insertions(+)
 create mode 100644 arch/x86/include/asm/hreset.h

diff --git a/arch/x86/include/asm/hreset.h b/arch/x86/include/asm/hreset.h
new file mode 100644
index 0000000000000..ae1f72602bbd0
--- /dev/null
+++ b/arch/x86/include/asm/hreset.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_HRESET_H
+
+void reset_hardware_history_hetero(void);
+
+#endif /* _ASM_X86_HRESET_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 07a34d7235057..ed99b5c88ff7e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -57,6 +57,7 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/cacheinfo.h>
+#include <asm/hreset.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
 #include <asm/intel-family.h>
@@ -403,6 +404,7 @@ static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_C
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
+static DEFINE_STATIC_KEY_FALSE_RO(hardware_history_features);
 
 void native_write_cr0(unsigned long val)
 {
@@ -481,6 +483,12 @@ void cr4_init(void)
 	this_cpu_write(cpu_tlbstate.cr4, cr4);
 }
 
+static void __init setup_hreset(struct cpuinfo_x86 *c)
+{
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		static_key_enable_cpuslocked(&hardware_history_features.key);
+}
+
 /*
  * Once CPU feature detection is finished (and boot params have been
  * parsed), record any of the sensitive CR bits that are set, and
@@ -1951,6 +1959,7 @@ static __init void identify_boot_cpu(void)
 	tsx_init();
 	tdx_init();
 	lkgs_init();
+	setup_hreset(&boot_cpu_data);
 }
 
 void identify_secondary_cpu(struct cpuinfo_x86 *c)
@@ -2410,3 +2419,9 @@ void __init arch_cpu_finalize_init(void)
 	 */
 	mem_encrypt_init();
 }
+
+__always_inline void reset_hardware_history_hetero(void)
+{
+	if (static_branch_unlikely(&hardware_history_features))
+		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
+}
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720b..6a3a1339f7a77 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -52,6 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
 #include <asm/resctrl.h>
+#include <asm/hreset.h>
 #include <asm/proto.h>
 
 #include "process.h"
@@ -213,6 +214,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	reset_hardware_history_hetero();
+
 	return prev_p;
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 226472332a70d..ea7f765c6262a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -54,6 +54,7 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
 #include <asm/resctrl.h>
+#include <asm/hreset.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #include <asm/fred.h>
@@ -709,6 +710,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
 
+	reset_hardware_history_hetero();
+
 	return prev_p;
 }
 
-- 
2.43.0


