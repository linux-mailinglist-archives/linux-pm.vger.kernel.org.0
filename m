Return-Path: <linux-pm+bounces-15706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B5699FA56
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C5928262D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD020C026;
	Tue, 15 Oct 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JX9nSd/k"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF21B6D05;
	Tue, 15 Oct 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028259; cv=fail; b=mIVuzwnTQ4xtL6y0AarIAX/vdZHi5RjqDES1dl8CVOuYGTssrpJ8A9M2EpjS7/qhozVJ+YODUdMnI0ousdu9FmEIbhxIp+/ThkzmDvluSZW9gpykMlmKCjxsCPICxehVmTLFWVnXXPxfyK5rYzPD9T/q2hFn8sisnKRfItJri9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028259; c=relaxed/simple;
	bh=FfGOHXrQV+BzQyx87XFc12uuuHxIR2WSrbDfsjivgGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuMdlDeXU7+zI8h4cWBREVPSaJdEMNOJaSn7/SibHXh8RCvKjbGooyDlvv1FRa8ZNh63OVkF6Ekct6LzY5gSY19W2aajCMMtIpkw2BTulf4x7/is1+DzE0GupKFgbmFAfjhpVkg82VxDCozxYamf237AavsQ9TS1RPW9EPaAsiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JX9nSd/k; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxrn43GpKUul5OmpNG+a0KNkjDlNr3YL4gRnfTZ/X+T0VxPsdAqqRbiX/OCrXmzI/EBSBPWwe0qZ/wegV1z6wjtnxeBoZQXJ+hfX3ByYuBt7pAHWtHqKDidY5qNstyx3LVOfNlHXDFDn2bj5USLKr4xAxkPHuSis6NBPZDw6sqoqpICDhI6Eyv8n65q0g8AnTu2ln5u7aQasXqmGRF2ibGqak1e+jJl/sMyaAtG+Kr9n8EVdC7DxFveOtmuIO6G6rmzEwSPCU5jZVRuvNbnwz/ct+S9xrsxlio2QxviXdA2mprM4uIq7NQFm65L7+jq/XicWMmp54yM2j0VlkU7zPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7mhArcDsvz28ClQomHYADi+/W+d0cYhOTgJBatda4M=;
 b=TLfxFxab2YSSl0vr7HXEcPB79ftkTea3Wl2zfEAUOEjNYL4/KkWWrse1czY9k/Lf3gGR631exTZzh+LP4/CPu8qb/noPQIvVu0K7w2BlYSOQGQp0qaYjDfr7K6doZWokinT+oL4/7eL/4A1nJWWP3m5+B3hNJdxBLRV51C24rUxcqWjqX9bet1Il5EHOKwEiHdAzA2HXiZBrUKX9bh1UrTKPE3NtyKzlMpPJl52QNMl9kQ5SYFCWzcg+MMsbNmI/EMT/EUbw3wP836L+BO28HwfEzj0odYhTB757iexBbl52R+ADIS/UPDWwiraLBT3EHZTor9d+mPzdVCiVzlxHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7mhArcDsvz28ClQomHYADi+/W+d0cYhOTgJBatda4M=;
 b=JX9nSd/k2gzPqgWx2xU/yrtZ4ynkxetUO5ilZhR6+KqG6lCgKb887M62zdhpsx8X/RHqHbCDPGE4ss9yDme0HSbkFQtAaSduWrSF8TODamOyB9ZM/EUW1yhgFIuLZihASRVQVyfRI7wdJjLT4XKnXggytUn+eJtbyAs9+jSnKYM=
Received: from MN2PR20CA0055.namprd20.prod.outlook.com (2603:10b6:208:235::24)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 21:37:34 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::f9) by MN2PR20CA0055.outlook.office365.com
 (2603:10b6:208:235::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:32 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 11/14] x86/process: Clear hardware feedback history for AMD processors
Date: Tue, 15 Oct 2024 16:36:42 -0500
Message-ID: <20241015213645.1476-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015213645.1476-1-mario.limonciello@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: e50e561b-8a1e-4360-bd0d-08dced619485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dDc8jkKEIoU6pw+1v17N0rN8+7NxDWoJHK6rDRql90mST0L1QWF1bZz8M/Uh?=
 =?us-ascii?Q?Ptjn8jhlYrvs/vpYQxgCV/I1XTq/arC6IkG8d5p7bA7KJXUVr/sTAQ0K4nhV?=
 =?us-ascii?Q?vmusJNweaQ2cwKmHMYe7S29lnmutb1W5ELsu5yS8d67kDm0jO+cqF/nFLMC5?=
 =?us-ascii?Q?xqFaPg9RhKPaTDF9dDRP8x82QLDYmU60HI8LrH9ywj50xupJm1ofbcfxb+eP?=
 =?us-ascii?Q?3MFhiqTdgoHd+cUW6szL3f+wRRADu87Dr2vIMqcT/PgizLyRRx8YvBBwwl8E?=
 =?us-ascii?Q?crr8HoUl7fa+zhmKUt1OaJmu5LEIegLI38cJp3eacy4NL+ayoWjiO/cf/rzF?=
 =?us-ascii?Q?2Qsv7fGKDEg8u/kB7Cpl1256wdN8b5uyTb7kH139+mNqit6X2yQ+0/JVsgev?=
 =?us-ascii?Q?Zgj1lxRlmKyrZTYn3IvmhsibDZPx5i3iQ2dnIaYqcVZv1QiB7YNHw1yATD85?=
 =?us-ascii?Q?ltwVaRiZkEPJK0kIZY3jm1/mo3i+EJ8Js/kUB+ScPP1ydh6fVmFvueW+oqIl?=
 =?us-ascii?Q?1c97RYY4Nub+nzpU3FdjDD2XXgxg36qACEyHWVCGe4O7K1IToUpcQRbn5rOt?=
 =?us-ascii?Q?GfXzp8r6/XmF1gZqpFr/Z9Q2Ki1iTWObYk8iIv1EaYtkNUmBzEnsFHn2QtlN?=
 =?us-ascii?Q?V1sIMgqqgefmVrx4/aL1eTtOt6ocFISB0HSS1K2xbZRNIgPrP4m4+LXhFiAX?=
 =?us-ascii?Q?7zFnLwhZ0xuxeiPW9eiIW7me4idfXSYirB0eFQKj3ZaLc91Y/RbP88K/xr1+?=
 =?us-ascii?Q?R/6uTAm2K6FYE794Ll+b9YRz2c/rGhGJB4zU+ecPpdKynKP+8ixSqSY7V9mt?=
 =?us-ascii?Q?Jm/ho0VSvKgjLjVswCmIu05636fHmT3dHf1nK8/MyUncQkoPK9yopblSHAmX?=
 =?us-ascii?Q?JViirwBxP3b/hBBgAxYo8oik6FmYAZmzdksOFJce00zyYFtCowLQ58Citdgk?=
 =?us-ascii?Q?xvqiHzr6yo90o4BXaqu9XqEvw3LuNOo4sVkfmHTB03Upm6NTFf4SahMzyNN6?=
 =?us-ascii?Q?GNPkeTI006/c7qD0V5w8cjn2l7AIuzk0c/t8+9iGmNgNtj1BBQ32dUuc1ACt?=
 =?us-ascii?Q?Zg10Dc0XVsM2ycSm6l4INXtoSEtDQmBs9bH2m6G/mhjPCKbS899qPHwzBpLB?=
 =?us-ascii?Q?IsxcuoBU6zfKyaL81s2Z4x8af3jb6BgWHAEPwZF4fVi1EAn7+ANaqReXrQ2U?=
 =?us-ascii?Q?uOOT+meAGk5FlvvN1yK87t+zaZyZA2Xpr+lf1925DaezzhAwF6KW+QKxySz8?=
 =?us-ascii?Q?s3MJeJbQ8pto5tSQqplBWwYTjctaHTe/sdsz61TIzrAISR7TRzYlZCh4waBr?=
 =?us-ascii?Q?kKajPKeY71OwKwKbokI6hetjHqq1TI3y6fr6w6oWAaXCF+LyV/FOTd25mY/p?=
 =?us-ascii?Q?RZu0rb7ixb9Ua7MWGm2vQAe4JYRv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:33.8546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50e561b-8a1e-4360-bd0d-08dced619485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579

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


