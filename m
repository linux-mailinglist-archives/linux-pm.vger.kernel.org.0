Return-Path: <linux-pm+bounces-16132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A349A71D4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3321F1F213D5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA061FBC9B;
	Mon, 21 Oct 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aB5E9h0S"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950B1FAC52;
	Mon, 21 Oct 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533810; cv=fail; b=fW2OuXNRP//9/PKMcsjtGy+0/NmkEfoaSH6aN4m4sQoDYuiFF2qdw10sZd4HnfmfioutH8qGnJMvPYrOiA2GhbVcxiVccfXKvqRf14tZfpW/PjaT8mGnbUTN5pTbS6lo7t9yjh4TXMullIMSE9MzaZXSQH0iogAlaXu1HpECWiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533810; c=relaxed/simple;
	bh=WUMJ4tMFtI9aLeB6TwcfcVLz4Cw7Ep78f4agmYwg7+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ait7G2Mn1vO9HHGLMhVSuJcjpySjh6YW/175y+O4nevHEOkIIlZut3PuZf0s+JvhVmqHXwzDEKk5b9uhH+JsdzCCyAdx7BfX7Fg4/UyxGZ4gWcTbpqzgJcsLRzUyShvgT34vAkRs/1f4JqqSo7GnqRgeO2fO8Ty9VniAGHrOVuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aB5E9h0S; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5zOSGQX6iaN1v4srZ1XOtctnBhGhumI6PWwOfbtQFu/bthKQWCn31g9jOMMa7n/eeDHNLcSqiZcmopytQ8QWR+OY4WzxqOhwG3HUL/bZsglky6Z7kYfNiezcSOL4NrF/TGh4u0kkhNH08LKRk5egN5+vSISU+dTYIsOZT6hQvLMKs/pLaiOKJIbhTVRd23xjE9rIrPhzmL84EKCJuvj5NHAj0N2wQCVKnUwnytYS+PnFHUePbGmVKLtxv1xNNGMFuFGJT5bDoc9GG6MFCcmLIwk0bHIw5w3Aqbx8bYsaroF1l+kIGRuVsHn27GJURKVz0yxvArmnpxLqeCwE4iiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG23CyCbUHpkJ8l2ycoJy26nAaExlnKcYSpDGGV/GEM=;
 b=uEH3yB94trQ+eSZyFZDH2TAUiYKEWO76BH10c0qjLnXzmx16E4c4KpCoTJeC78YH6vraYFerXpkM2bBGcWd0MWTcpY71URkOIXS459IRAUf7vekX8Yl22Bajb7bsZFia8rR5/h8WbsWV4Nk9cBPu31c7V3QtYnMxoGrJ+cjwC2UkHWcQgAChBRw9dnORrA4MFcTGnYnmDsNSpcVh1aTh6cV0tSrqSNAJAuirEGOtBZ2NLJYqL187ZcGU4DuDIqjsdZCJsjsuVCkFZKRU7LZphBvBec31cz8wgm3kX2Lo8h1g/UbDjcM/po19jbYyV3I9B9JHtSOXwtEmzq4YTc1UKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG23CyCbUHpkJ8l2ycoJy26nAaExlnKcYSpDGGV/GEM=;
 b=aB5E9h0STnYwlTKXhbDgz7t6xIhB5aAE8Q6lWfnv61tcWSR0EuQozLIoxkdd0/s9F6eT9Nnz7l6BUeuvX6km558AxgOs64Tn/+Moihup8ghDPSCq7nTNpSGhIj0dPYDGCfRy/A1nKp/UpcD+IjhytrZYRE82cg1mmomlPFz6A+4=
Received: from BY3PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:39b::31)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:24 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1d) by BY3PR05CA0056.outlook.office365.com
 (2603:10b6:a03:39b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v4 10/13] x86/process: Clear hardware feedback history for AMD processors
Date: Mon, 21 Oct 2024 13:02:49 -0500
Message-ID: <20241021180252.3531-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021180252.3531-1-mario.limonciello@amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4828cb-97c7-4c0e-9710-08dcf1faa806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ftIeH/a2Aqtt/FYwZyUNfMBnkglowKgTimntiS0uH+4n8nnEKNRq8KlLpar6?=
 =?us-ascii?Q?edpGCBPrtWdAYkO87PryskZTozUksQ61rMEn4/Mo5IL41Zfp64qAyG1U36Pt?=
 =?us-ascii?Q?hh0c4nemp+yqlPBVSBja0is3do1Vd1fOWhSP8VI/ZeiM6Tgv7MQsQin65aKN?=
 =?us-ascii?Q?gNBP/75kb9b7I+u5R+LJ7MWJ/0FNJgq4rR40Av6F+FddKepPQ1qkHsr6aobx?=
 =?us-ascii?Q?flWGXvC2RKPPDPZPRIPIAU42jSzv8DF4VYiER5l4zsztISQ5fIypJA4bdIXC?=
 =?us-ascii?Q?JMbBaW4NVyTmBmoJYESZkwerTNLivGa+NUlRhju8vEQjoBnRzyzOIBYFzK67?=
 =?us-ascii?Q?tcqeNpXHmlaUiWkon7WLTyCMhWdP7sEv+TgekpmizOvwzqvZgkTN/6FTeCYY?=
 =?us-ascii?Q?1DJfHonUXGXtCMFxyObKawvHZPR36eYv0Yuh/iSE9geukve/XxFLtQm1Vm65?=
 =?us-ascii?Q?sQQEtJva1GZOtaV6k5uxIhcfzG+k/J8yPtxVw3ptBk/RtGWpaq3W5dNHsxYJ?=
 =?us-ascii?Q?dr5ukvNMVKkf+jXRyf4gMEZu3VaqwzECVQHmbipBGxJOyVKMZ5VqeI4hiTwp?=
 =?us-ascii?Q?6Syqaz0R1Vq1fMAR3mqXgjTIWy4JXcmsq6UXe1UWd7ZVRDGdpldefQoEauYD?=
 =?us-ascii?Q?YFjZXD/kqD/DCNpKZlXtrR2TauyHhy/52STypUvZA3AdxIcSvH/zZ5akip9z?=
 =?us-ascii?Q?53tv+Ml7IBEsuCpsniOWwnWZSwjqMFbINCnNVXzXcu2pNM0u9UjBJiCE4u9B?=
 =?us-ascii?Q?76H6S+bHYpF5+YkM38ElmCXSV21Sl42mO9BVUJUr7w/a7rTd9a9mbVSCFGaz?=
 =?us-ascii?Q?E0z4/qokayu1EFFuozV4RO27sO3kIi/zKLrZCBd3Voi9BQWsMxRHCXL79k1k?=
 =?us-ascii?Q?JUjKl+D+dF/+FGI62A8+bKsl0IuKf6CbqqJBTomBR2FsCX+dI26MddI3JShF?=
 =?us-ascii?Q?coBvUG5vjNGJEJuaYIjNc0rn2hLolv2Bj6Miem+JJ1G96J9w5g4yeMN/6ISh?=
 =?us-ascii?Q?AU87n1J6wy+SVQcAP/ocfrhmybvjbdRGi3ZJyb8mUjgM+uQ6ArUg6QF/66jS?=
 =?us-ascii?Q?FGGSmpspJR+/4NBHIeYZfcyBzL5aBC2+jAMlzExczuE+dnAns5BhRrqYwnMn?=
 =?us-ascii?Q?n053sbWsc2bi9DrjshZhRAL1r4zUqkwM0OJmFcY+rH59EkBKYkWiWySlJGrH?=
 =?us-ascii?Q?9kTawx6yYk7+LkHcufxbkM+Xiqxh9HIr3Ud08KpIAHyNLV0Pxf2I8GUeFroB?=
 =?us-ascii?Q?o/wClgRmXLQ/2Wc8hIPMngCG7+mxU6QrybLLkr7bbtGbfVW8hwAoxnv8kI8E?=
 =?us-ascii?Q?e67CoaolxdTGzR+A1edYXpycjIMZ/WRm2HorFauppXBasajuyDbugK9Hj6nu?=
 =?us-ascii?Q?h6E9vFRGYfPc2HdRPaNNBSVvT8Y05yn2JgFYDN0ZAcqmwpbdZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:24.1483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4828cb-97c7-4c0e-9710-08dcf1faa806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110

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
index 07a34d7235057..658c8fb4e25df 100644
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


