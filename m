Return-Path: <linux-pm+bounces-15490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301459992A7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21AE2832C9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA321E9099;
	Thu, 10 Oct 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oftkFEqM"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209971E8837;
	Thu, 10 Oct 2024 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589078; cv=fail; b=gFs3Lx80RZ815qWcHBT+rlXemd7uSLGbJwD+JewNH02n5dhR7lC+mtfo2ook2/NpzP26OjgKuKFnvvLdRMZGTkHUNOa8+/oXLLeoY98ltF6MCm6eY/geIOrGYloA56LvqtWcgipAiuac7c3dN88uS19G+suyWoglu6rARGHaWWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589078; c=relaxed/simple;
	bh=ZzdKf25essOhTSEl7CEOYGzVkjWlZQm3t6Lml/7nNpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb0DSh0hwWr+PFoMvJycOOTADopjLVJvKR1rcuH8trl+TlTKBGD2Y55N0PLxNRxGHm0Wpz6+vldhhkUOhxRBtgnO4+7CXwam8qvOab6y4gMmwPJ63WU+vllOzwZxii0t92HUIS7wdb8jeKrcUpZoXsxOKgzfbzVVyy/yhIdvyPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oftkFEqM; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWnx+3rtV5ZMd41Ysl3LUV7utw2pwDwjff/oEsS5oWHAmuTbyXIudSdnY4lmLqEYljsdPS4cKo56EKO8TtrAm8iJvkDdJVmtczMGOQfMlnNTcWPdkacvxbtPYFy/3ATc9GbIK31frBMYTdtjg4hMgkrRNUfRZNrot2tPPxR3jryByORyCBzWb4n0j2pQp/iKsVqoprd0MI3lUtJ4yX9wH1gSaUnNlPVUjy8h06yxmtkbx1pZ/+NgL5r8y9versOCOST4j1HkKXtZn7s4d4ODIZQm6JV8p9EEE1LULFgJcFot/y/MoYaJXXzMDhOykPHXMLezB6eslmxwsrdJg4DchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XopSamKjRL7VvB996UhiT8spS68ru0hhPjos/RZF70c=;
 b=yjc61pOYBcM3OXniyh2vBwP49Uzp804rbeaghfzOz70xEZBOgwqn30eMRaMdvaZ5vaP9JLbbJOWVd8oqKRvuvf+qXzTmq1AtS74wkuUZKGiw/rRE50K2qTyIJqIGVZEZX5bk7fb9u/a+ke0PVBGlukYNR9JHi5gL/tyTKb6814YyCT43ipxfxUB6SjMrGB6unlPC2OAw5sofSLazJwPkq2Ji8fGQfXOXyA2Xz9rNgXGfJDMiX6cYm4BpaQTIilpjhmljNtbSmdf1R/Pu7vXVGPwiCniDJiyaCq3e6IZ4n8a87CVyEDtDmXH5G1hExOUMJiyiWQwlZA38LsODKZRr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XopSamKjRL7VvB996UhiT8spS68ru0hhPjos/RZF70c=;
 b=oftkFEqMoAQi1rKkJopL2YuRxlIDdgrJ15xUQ7GyjwJmdWcV14hsUWnkUPU/pQ6blTUa3HXKJk0OCEQJ8M4FDfU86KZ0aTYkNvGO2ps6Z4+3L2LXZ0GpUTiH3se7y9rpwEGt+00TWAbz8p5C6N0HT+vOHG7xPyguXuDipzWWWJI=
Received: from SA1PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:2ce::7)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 19:37:53 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::a) by SA1PR04CA0003.outlook.office365.com
 (2603:10b6:806:2ce::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:49 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 11/13] x86/process: Clear hardware feedback history for AMD processors
Date: Thu, 10 Oct 2024 14:37:03 -0500
Message-ID: <20241010193705.10362-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010193705.10362-1-mario.limonciello@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: a1071107-5749-43ec-3008-08dce9630874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5vUuDEVW5M+9u4+LIAaZNJQB1TBRQH8bSKmjTWpL9gxBUtW3z/1ng4+8ur9g?=
 =?us-ascii?Q?cZWLlNAq3v96KJOaZ+DIuZRIf2gSwrK1i5cq/pYy9xMcxOc+ekdwOJXt8jdy?=
 =?us-ascii?Q?rCMtTXgVrbnPtLylPbloyjIzqPR/6nmksOGAWaGNBDqZ1P08TkHVRV66VWvg?=
 =?us-ascii?Q?nLJGxvj2IVbTFlmA2fGWafodGV7MDBzv6W+BDx/zC5Fikcalx2+oeMTXf611?=
 =?us-ascii?Q?YrBzAqQkIkVpWAtCiEO7jaZczgIEsO9NkpEO7t406yaUN2MUC2TH3ObQ1/UF?=
 =?us-ascii?Q?2Fvzrz3m/GvwNRfG/vqujUZRyDFdstGsz8QhFjq6ihxlfsXAA1Els9jJ01dl?=
 =?us-ascii?Q?o2y236DdBmx3Zepuc/Bp2mZHpqS/BtCPFIGxJH6SehoDtcL43c/3+T7tVfxT?=
 =?us-ascii?Q?Dww29vgS2/w8AAyebXm7eknS72/hfDj2oKS6XDFV5GBHOGCf+bOZaYsBtXHW?=
 =?us-ascii?Q?OtV8yTPwgcOibfI8GK3dtfwfmCQc+o3pU4CRf28+jMnnWnHqzbSE6BD7kjjm?=
 =?us-ascii?Q?jOgH3zQaumyx86SyP+sB09yhDjqGfRXSP1AxBuMbKoAw4d50v6bc2NTemaPr?=
 =?us-ascii?Q?THFoWxMUTkAEgKA/KCrlWauBY1nVbUUu1u+WFG39z7/jQAB+EfD5tFtk8BH3?=
 =?us-ascii?Q?u2L/tIKXXrzKcTZq1NjPuN+hdmb8C4/tofEDpBxWqeg41NaApuDzC3/T17y0?=
 =?us-ascii?Q?ZceCLJ4/5fAlMLRzMRyOuj9InZqB6wrlkGpRwSMbwfFEE9T1xIoNMDM5+L2W?=
 =?us-ascii?Q?Sy5taFnUA1uAu5rMLNq1LK/jDHuznoF9DGCYVEomyZmKMzh/DH2PZEA0lIhi?=
 =?us-ascii?Q?de90Vf0xlhHI2tP08K/8n4TbtZ3Ntwlk/xgU/L+r/ipJ+ELGT9EIBx9AZ17m?=
 =?us-ascii?Q?iAgmoh2d6nFcwj1JgUUMW8T7dFud7Ll0TktaEexqtRjz5NeLXMpbpIFQx5Lw?=
 =?us-ascii?Q?Z/QJonrzzjm2EDn4DJqxycjpOZZYMSGYP6xNgX3zi8EZp/DGL7BIqRLpyG/k?=
 =?us-ascii?Q?8qh2mZ4LywBh6Yk3R3rcA2ZBajZRNWcPdHXleHRrf8EHN3mJIW9nwH6PM4dZ?=
 =?us-ascii?Q?UZhLozfsdUkqcwX3DuymZxt3skuBbZ3SaciT1uA02AXJBhFDfRl4WHe8H/S8?=
 =?us-ascii?Q?ah+aD8OhSMX4RAV5iTTrT2ZUxZpb5R5rVVbBLr2IAfHNFu2uJjtero6eUlA8?=
 =?us-ascii?Q?j/GWBxE1twvdTUZAUP0gw03nDyzh5v1vZzd/icxfjq6lIUFguNRx/3qMAw6o?=
 =?us-ascii?Q?FAT73DzUKRtr7OO2u5s/z4jrB736C+2ZBGXE5JXv1ZMuF0j4JDv0DEjH2W7D?=
 =?us-ascii?Q?yoN1VSH1ye8JzepsFuYiICNUvQVDYwBT8IExaKf9MX9nIoZvCbRkppCJeiFC?=
 =?us-ascii?Q?oi7J8xtFsVtgCMhHejFtO5QRJiFa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:53.0602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1071107-5749-43ec-3008-08dce9630874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175

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
v2:
 * Fix function name
 * Use static keys
---
 arch/x86/include/asm/hreset.h |  6 ++++++
 arch/x86/kernel/cpu/common.c  | 15 +++++++++++++++
 arch/x86/kernel/process_32.c  |  3 +++
 arch/x86/kernel/process_64.c  |  3 +++
 4 files changed, 27 insertions(+)
 create mode 100644 arch/x86/include/asm/hreset.h

diff --git a/arch/x86/include/asm/hreset.h b/arch/x86/include/asm/hreset.h
new file mode 100644
index 000000000000..ae1f72602bbd
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
index 07a34d723505..887821e97e54 100644
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
+	if (cpu_feature_enabled(X86_FEATURE_WORKLOAD_CLASS))
+		static_key_enable_cpuslocked(&hardware_history_features.key);
+}
+
 /*
  * Once CPU feature detection is finished (and boot params have been
  * parsed), record any of the sensitive CR bits that are set, and
@@ -1844,6 +1852,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_hreset(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
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
index 0917c7f25720..6a3a1339f7a7 100644
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
index 226472332a70..ea7f765c6262 100644
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


