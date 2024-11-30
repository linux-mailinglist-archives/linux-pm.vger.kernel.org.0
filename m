Return-Path: <linux-pm+bounces-18288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108109DF184
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B79EB20E9A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FEC1A7259;
	Sat, 30 Nov 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="So4oVfVQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031421A2C0B;
	Sat, 30 Nov 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980057; cv=fail; b=Q7q6UBjh2VtqCw9XRSw2lBkfj7ozfqfgVdGwPdyBQ45kZbn80EXso3Jv9tLN9LWE9sThdD9qIA5X72Xz6obdqSYkVNn42GL/AHA8Wd6G3INP6157LLRM3uvpNMxyigDJ1Y76kVAUvdXlvMVUNzDPILPWxQ38TLg/ujz8rfSjpsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980057; c=relaxed/simple;
	bh=Mv/elKRugYeCY4Rr1u2Vip63588Go70CN6+iTYqb6Os=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNhBHwVDpQxHNtFPjOYC3e/+zZrjaZg5m/MR/IhQ0RkUZ1TZ3WPcwTJLubbbjAOlcDpxedkin+PL6Vp1KsorLiHSiZxj59ivW4E25uyFXsILhEkFsAJkWV6Mv0IjwH1Rd/QegMyz3bhCRi1nQGlMGphua4wEoqxIuXnrKsmsI40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=So4oVfVQ; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUQtFAjXLg+5g+6BBqrUoYnE/mOM4UDXL+r/mYQDyX9b12ERWSsgUSXwc9eNDWfyDaxVhUWdWcEF66O3UAAj9i4vEdv5Pw9T3WucS6Y+4KNqIaee0S1TD1TsiviukYBWBJc/E11fcNxVRB15ZfFQzloUTIrOcRB767BM4VdhkgCHp+G3vcd9s5Bl+y1o5FQzYmxQlvYZdGd3/llGCkq2bgiDtzK6EQwUVHhrJ/soneIMRH10Bb9q6IbbCI/NIEFj6o6hlFd7kGP5KFuXnrE1XheSxLz802Z4slkH4kxLc9HTLI+HvXQTCofrly6ET41g4+VwNySRhqKvgwccUTV2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBnR76A1DApi1COQCNWfiO01/rdFBhyA/9yhkZQinVc=;
 b=ai/Xe7/u1ZjhozUguYvmiWnCtUbo8AQjzOrtdPwMs0cFs7R1woHnotvPiqmoMcNlZJWN/Uchh7Ahmusl7jw1HCykhGNZGb6mPtol0xpm+bL+5Zv6xRxttEowEHGaE/vmdg+W2sPnu69lHd0g7zpkHoVVtCYFG2s9p2o9Cz31X+1bNeRwlOIJKqIKtkvU50OAn8dEQaU7fOxABi86gVopqaU49mQv6K3wzvGTkrs6WxFqETCTc0qhfFegmtP+1z6cTEXThdvcBXvqBQ7QozBDkadVmvxmKYnRXF25uRcQBzgxXtQYUerc+r4W+wkgSweshDgvMzNrxlKLi6/Ywa6r9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBnR76A1DApi1COQCNWfiO01/rdFBhyA/9yhkZQinVc=;
 b=So4oVfVQRi3gl/EpdPMHu7Vn5z9W99YwUpeW70nanILVdKuli8QB8D8N7huBR3f2cqt/ewHwFDzDmf9CUbwFps8pMbZiXhUFQpr+MkNuS86M9fVi7XkwIt02DKzwUVQ7krMxKRcHW54L2YeAGFUQQCQge066lw5XkNVePUBqUHU=
Received: from CH0PR03CA0303.namprd03.prod.outlook.com (2603:10b6:610:118::16)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 15:20:50 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::dc) by CH0PR03CA0303.outlook.office365.com
 (2603:10b6:610:118::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Sat,
 30 Nov 2024 15:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 15:20:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 09:20:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v7 04/12] platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
Date: Sat, 30 Nov 2024 09:20:15 -0600
Message-ID: <20241130152023.684-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130152023.684-1-mario.limonciello@amd.com>
References: <20241130152023.684-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 121d2001-6d2b-46ef-fa3f-08dd115292f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1uDTjgut8bzgIJ5J2MJxCoQLO59ByxI3GAUdd/OM4omR2m4LHCc8TRZDh+a?=
 =?us-ascii?Q?d0FpKhOPM/aVeZQ+0vtp/UPM0W3VUb2DBYyNsVOn9rFKOkG+WhykU/Dk+a1o?=
 =?us-ascii?Q?gEAVjS344OnQPpPWaGSEPKhTWUZmczh4m88jwghkaESCF8VYLV07Jxsp4h9/?=
 =?us-ascii?Q?KswJHIM00Vh/57vJiMAdHvAS2wPSEzWF98Pk3yndcbw/IDSVwE5cNhOxS3Lp?=
 =?us-ascii?Q?VKYjtw+HvUQZN3pgCAgDX2Oh3nOgNpOYGZZS8sSQ+EmXv2lt1bM8SQua0Bxv?=
 =?us-ascii?Q?zPvex/YcPf35ftycbnzAV5CYLCxQlP3YP94I9Rg78up2Z8gTvgYOzxJN78Lq?=
 =?us-ascii?Q?mJGfqgj5U8B+n/beS/HGxQeTNNWhjqhJ1X1UKqiHDYzziR7Uq0jW1L1YZ2Kz?=
 =?us-ascii?Q?VMrC/BmaBnlsPttI2Z+Ei6rRryiODeIdPny+nRDs7F0EYasY4udhy1B6W7m1?=
 =?us-ascii?Q?c7JIEGTeEP9uL5P/eap95Eg8CQOCA4ZPQu279+aP1c3nlLVASUmj+4C3DuPc?=
 =?us-ascii?Q?QeDcIasV7CFRoWs/X5yVPtNjU4OXrUd0xcSiqjOLTmgWEPTI+jWqSGdE/gLL?=
 =?us-ascii?Q?AiHZm1PgpRc0IJ/K4E7LT8v3cwav2xhvRFdaA0k6aBfk/iEZyDtXdOFX8fnI?=
 =?us-ascii?Q?wg+imM4jvR8BZOj4KjuVI+Oss06jLrYn9m7wZZ+cQlylYQLOZ7lYpvh69rAI?=
 =?us-ascii?Q?KDyZTe4xj3uR31tS/1OvJIUMcbPfM9zkb0hZYJ70nBtinXF6jTcNyfuQP+so?=
 =?us-ascii?Q?91tQhgGZGjsRfxnBbUG7J1T/WHlm4pGUMlfkpaI7O4RIvJyM5FUJLYKtG+mI?=
 =?us-ascii?Q?sswJbVEWVjmUvQKxAszVHKqx/6LLU8ATOAHAdK6oAo/62VEOuF8cs6nuTcVH?=
 =?us-ascii?Q?mgPRYuVOl/8hg0qEyqqmGRvNHiuijPLy/DofD6G3NBZtQ3SlYbaEdiNHqkyh?=
 =?us-ascii?Q?ug207N0va7B+Za1ZZaSOxHNkgPMmtCFr6DWmMhHvcGCBXSY93g8RSxKzool/?=
 =?us-ascii?Q?t2+6hAMmL2GrqlKEbSOIjy+8VofGnEyxzxzYHAX86MG1TeL45zTxcb1N9XMV?=
 =?us-ascii?Q?WZHA7aFZ3rrmqNZQLawpNZP6cMxY+wm+8xum37lNM3KgFHcC0DaaDlmr4W7a?=
 =?us-ascii?Q?hTOipYM4HB5ETtswIDNT7nwCCn8uELe+hTR/hDMJtfiuPYU7Xu5S5gU+1FzT?=
 =?us-ascii?Q?zh2IS9fuLKCtiQzX/JoatV76NSWTskRVIiKkWFOuGCNeyybr6sIo2HNj6TLW?=
 =?us-ascii?Q?OHvJhaHRojrzKz9Mww/kN0RZeZ/H8LX8Atst3OgKNFlLG3nmJt15x/ggmjS5?=
 =?us-ascii?Q?SIhH4WL/Nwmw4IeXpvqxBzF78Dce1vZXxT4zeGwwKHAHPPc3x763+wB1WWlF?=
 =?us-ascii?Q?NaqECO4u86tR36CEFfn7dT5eylMKGg/k2qNhCZkBLT6JoVAhay4SRgnKY+5i?=
 =?us-ascii?Q?M/7nA4qKLdY5FcAO65G14A7x8KbMW8qp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:20:50.5838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121d2001-6d2b-46ef-fa3f-08dd115292f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

From: Perry Yuan <Perry.Yuan@amd.com>

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

There are two CPU core types defined: `Classic Core` and `Dense Core`.
"Classic" cores are the standard performance cores, while "Dense" cores
are optimized for area and efficiency.

Heterogeneous compute refers to CPU implementations that are comprised
of more than one architectural class, each with two capabilities. This
means each CPU reports two separate capabilities: "perf" and "eff".

Each capability lists all core ranking numbers between 0 and 255, where
a higher number represents a higher capability.

Heterogeneous systems can also extend to more than two architectural
classes.

The purpose of the scheduling feedback mechanism is to provide information
to the operating system scheduler in real time, allowing the scheduler to
direct threads to the optimal core during task scheduling.

All core ranking data are provided by the PMFW via a shared memory ranking
table, which the driver reads and uses to update core capabilities to the
scheduler. When the hardware updates the table, it generates a platform
interrupt to notify the OS to read the new ranking table.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Adjust Kconfig to 80 characters
---
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  20 ++++
 drivers/platform/x86/amd/hfi/Makefile |   7 ++
 drivers/platform/x86/amd/hfi/hfi.c    | 161 ++++++++++++++++++++++++++
 5 files changed, 190 insertions(+)
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index c3e086ea64fc6..589d61ebf726b 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -6,6 +6,7 @@
 source "drivers/platform/x86/amd/hsmp/Kconfig"
 source "drivers/platform/x86/amd/pmf/Kconfig"
 source "drivers/platform/x86/amd/pmc/Kconfig"
+source "drivers/platform/x86/amd/hfi/Kconfig"
 
 config AMD_3D_VCACHE
 	tristate "AMD 3D V-Cache Performance Optimizer Driver"
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index 56f62fc9c97b4..c50e93c3334cf 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
 obj-$(CONFIG_AMD_HSMP)		+= hsmp/
 obj-$(CONFIG_AMD_PMF)		+= pmf/
 obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
+obj-$(CONFIG_AMD_HFI)		+= hfi/
diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
new file mode 100644
index 0000000000000..532939eb08a6a
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+config AMD_HFI
+	bool "AMD Hetero Core Hardware Feedback Driver"
+	depends on ACPI
+	depends on CPU_SUP_AMD
+	help
+	 Select this option to enable the AMD Heterogeneous Core Hardware
+	 Feedback Interface. If selected, hardware provides runtime thread
+	 classification guidance to the operating system on the performance and
+	 energy efficiency capabilities of each heterogeneous CPU core. These
+	 capabilities may vary due to the inherent differences in the core types
+	 and can also change as a result of variations in the operating
+	 conditions of the system such as power and thermal limits. If selected,
+	 the kernel relays updates in heterogeneous CPUs' capabilities to
+	 userspace, allowing for more optimal task scheduling and resource
+	 allocation, leveraging the diverse set of cores available.
diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
new file mode 100644
index 0000000000000..672c6ac106e95
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+obj-$(CONFIG_AMD_HFI) += amd_hfi.o
+amd_hfi-objs := hfi.o
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
new file mode 100644
index 0000000000000..2cd71d79a22c9
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Hardware Feedback Interface Driver
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Authors: Perry Yuan <Perry.Yuan@amd.com>
+ *          Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#define pr_fmt(fmt)  "amd-hfi: " fmt
+
+#include <linux/acpi.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#define AMD_HFI_DRIVER		"amd_hfi"
+#define AMD_HETERO_CPUID_27	0x80000027
+static struct platform_device *device;
+
+struct amd_hfi_data {
+	const char	*name;
+	struct device	*dev;
+	struct mutex	lock;
+};
+
+struct amd_hfi_classes {
+	u32	perf;
+	u32	eff;
+};
+
+/**
+ * struct amd_hfi_cpuinfo - HFI workload class info per CPU
+ * @cpu:		cpu index
+ * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
+ * @class_index:	workload class ID index
+ * @nr_class:		max number of workload class supported
+ * @amd_hfi_classes:	current cpu workload class ranking data
+ *
+ * Parameters of a logical processor linked with hardware feedback class
+ */
+struct amd_hfi_cpuinfo {
+	int		cpu;
+	cpumask_var_t	cpus;
+	s16		class_index;
+	u8		nr_class;
+	struct amd_hfi_classes	*amd_hfi_classes;
+};
+
+static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
+
+static int amd_hfi_alloc_class_data(struct platform_device *pdev)
+{
+	struct amd_hfi_cpuinfo *hfi_cpuinfo;
+	struct device *dev = &pdev->dev;
+	int idx;
+	int nr_class_id;
+
+	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
+	if (nr_class_id < 0 || nr_class_id > 255) {
+		dev_err(dev, "failed to get number of supported classes: %d\n",
+			nr_class_id);
+		return -EINVAL;
+	}
+
+	for_each_present_cpu(idx) {
+		struct amd_hfi_classes *classes;
+
+		classes = devm_kzalloc(dev,
+				       nr_class_id * sizeof(struct amd_hfi_classes),
+				       GFP_KERNEL);
+		if (!classes)
+			return -ENOMEM;
+		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
+		hfi_cpuinfo->amd_hfi_classes = classes;
+		hfi_cpuinfo->nr_class = nr_class_id;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id amd_hfi_platform_match[] = {
+	{"AMDI0104", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
+
+static int amd_hfi_probe(struct platform_device *pdev)
+{
+	struct amd_hfi_data *amd_hfi_data;
+	int ret;
+
+	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
+		return -ENODEV;
+
+	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
+	if (!amd_hfi_data)
+		return -ENOMEM;
+
+	amd_hfi_data->dev = &pdev->dev;
+	ret = devm_mutex_init(&pdev->dev, &amd_hfi_data->lock);
+	if (ret)
+		return ret;
+	platform_set_drvdata(pdev, amd_hfi_data);
+
+	ret = amd_hfi_alloc_class_data(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver amd_hfi_driver = {
+	.driver = {
+		.name = AMD_HFI_DRIVER,
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
+	},
+	.probe = amd_hfi_probe,
+};
+
+static int __init amd_hfi_init(void)
+{
+	int ret;
+
+	if (acpi_disabled ||
+	    !cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
+	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		return -ENODEV;
+
+	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
+	if (IS_ERR(device)) {
+		pr_err("unable to register HFI platform device\n");
+		return PTR_ERR(device);
+	}
+
+	ret = platform_driver_register(&amd_hfi_driver);
+	if (ret)
+		pr_err("failed to register HFI driver\n");
+
+	return ret;
+}
+
+static __exit void amd_hfi_exit(void)
+{
+	platform_device_unregister(device);
+	platform_driver_unregister(&amd_hfi_driver);
+}
+module_init(amd_hfi_init);
+module_exit(amd_hfi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
-- 
2.43.0


