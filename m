Return-Path: <linux-pm+bounces-15700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308099FA3B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6689C1C23B31
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A747C205130;
	Tue, 15 Oct 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sNLmy7EL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DD1FF020;
	Tue, 15 Oct 2024 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028253; cv=fail; b=PNeIEvxQygVvFcKhQsl2TulXymCTWTO8qdZ0x4K3hu4pBSOZ5+BIqfWfsXAQ4GAcUphvMZEmkYRcEfeA/CoYs2GEdZKLFnYY63l6ACOtZg8pJpJJt0U20SGp6XNlf82npxS5piY4cP0+WecHkFgZIP43YHNq1HyzMoxc1CHeXrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028253; c=relaxed/simple;
	bh=mHDytz31pt5jqGHh5UzTvJkn02Ia2BdJqM4d0D72KEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgyk5NzSSW8H6MCOxyMbl74EIuI4I3Ta4U38yqeu98grxCgw5RspPSt7fSnh/IBVwjSD9C57uyO5cY3F1p5awVNqZICwnW6QoyMeg/SdwSosAfkdfuLxOesdc+MJdY08fDBLW68b7bRjbmmg+yKglOHqv1Yb04fZs+kU13V+sgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sNLmy7EL; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWfLdO+Qx+8ypz3Pifc889rmzP26jr7/keW38ynW4c2nYCkTAurHi7SaMrMtyAHbWqbEsh6SFdLY1YfVRk4daihz8wV7dWNpL/IYek5msGALzuq8e8+TNnbW7iJLD4UWj7ilm4CL9t6SVKrWA2yeBsq4JQXF/agVnNiBugYe7Nyd2/jK/7Hx/i0S55/eVV6suW7GePMFi44/Cde8iKjbeBP4JzdokVXulXzu/vCJ0IiefCQZSCzH6r4jOyBMegRpq5EnHh8REKQbd67MbC/bc+QTY3VmvZk7kUtscHBR4/XASqIzrRzQpsvc7Acqa4ElImR7j6e5GZ/j8gf71+c/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmskUWuvDdElHkKzBiWw/i1hq5DD0P14JWFtBhtrBO4=;
 b=xyiMEaCCYXEtc5e6pVk//Eyi4M64q/CTvY5ZlrM0sWsp2+T1lR9S6zYeEzUWas2a5r+p1M2plB/E9NwI8YVtK3mLJ5wO0VdXRoNO7sBZjrVTsjytBZlm8wPIuJ2rnC/PPGserkF648wlBgZM+zfI9jMOMcRNTQQuKbVRAJ8t8LrBOWsSQGdnUZLXa5gswekePvWnfuQbiPX9EDxu8DoqTbbSGSblF6WxmpSkgnR4dIshDaCiebRgqVIHU+jgTenUjVOudW/3wk3wB6hZjg5cH1TtBrWpikxTEHkSx24kTpkoRyol1xTiR704A6KmjM/uP313GTd7t1aiLFYus/aL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmskUWuvDdElHkKzBiWw/i1hq5DD0P14JWFtBhtrBO4=;
 b=sNLmy7ELxosSh8Wm3R+T2l29klNIYb9NcievyruSMxlFoUJFmqvnNfcfDATOZbVUbRh2pWWstdQevtOO+Ix2K0V+6EL3gyiplN87AdF9OV92pmQoudSPxP1KOFYmFMPRY8IyZo+YpX1mYmPKkC9Cp31WY5WzkgR5G5HpKQdZP0Q=
Received: from BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::19)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 21:37:27 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::ba) by BN9P222CA0014.outlook.office365.com
 (2603:10b6:408:10c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 21:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 21:37:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 16:37:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 05/14] platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
Date: Tue, 15 Oct 2024 16:36:36 -0500
Message-ID: <20241015213645.1476-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 99439761-8e36-4a76-1e8a-08dced61907c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avZrBirUz3n43eZ4Ea/LAM+F/C1gNh+4YJM00uNxp/+sy3cIPObEwWdnKTy7?=
 =?us-ascii?Q?9e7haJ+s3Nwrk1Mi3uSSjQBSSkU83Kvd/cah9vA/bDwCUbpAveZM6Tj4UBOi?=
 =?us-ascii?Q?k4CrzCQns89qynAVbgdaFHXG14ZotU9IOUgrQcrSCoBfqigh2deekPl+1LS/?=
 =?us-ascii?Q?tNY0PT1l9nTcL2l1pZSJm3rEtvjtSJfcP6qGc82hB/gVlKi61toDfBBOAUBI?=
 =?us-ascii?Q?BDK/yd/z7dokwcttJmkCPFDeFdlS7kdJR+6UNPlqSHV6dHhvDmCzww1TCpmF?=
 =?us-ascii?Q?Mruc7Dta0Y5UaVcXDoXkf8HsP9Wf1odywD1mN2qx+KxTnF73k8OfM23AxmCv?=
 =?us-ascii?Q?+1+KXX+bZ+Giz2j69SO/ZTVWob9Z0AtMwx46RpHDaK5ljA6SJXPHVXXb4GP8?=
 =?us-ascii?Q?KutXAUxItqUWN7Lp4ACo/eXgzANxo/+DzMxWr3cBy1HDanDZstNVX8skhVDv?=
 =?us-ascii?Q?SMggrid2/GaepVQoZBHKNOYdWoKz8qVFTrebx0v7YZZ4jpM7ibV0Gq4fpc10?=
 =?us-ascii?Q?YotUKaBFLZIA5LLTlDb86tq0ca4mc1VU1lzZxwXs3yasUS8ry+XV9JdXIAvu?=
 =?us-ascii?Q?JSBpoAnI/XZkqZ2CX416MEKUJ3YECPx1cO4BVBPjeq0/qUMsb7O9dM0m3H0u?=
 =?us-ascii?Q?Xf40CZiC9fPs21RE0Q9nfeHjzuqgmPuPGlZ4pMmBBiiin/F44gXR1hVmeYja?=
 =?us-ascii?Q?Ujnh6fwNo2sdm9ZWPJfHSqGdbGTZFXToqoivB3zsdB1wnNvemHX9cZbuz8EM?=
 =?us-ascii?Q?3rPXIg8ugBhhNUm3BTidkTd5mO3zYUC6qk0C7Za9qu7uJrxu/uXhP1DBobsG?=
 =?us-ascii?Q?dohFf+vye06GS/IPNHhXdcucUkWcUHhpi3UHvdJi7lYZER49jj3EdoJaj3cQ?=
 =?us-ascii?Q?2e2fq6J8c4aqi6HyPhKuaAEWkr3525IXiy7buITFRQCHwmZ3kOVetCw2OZgb?=
 =?us-ascii?Q?lAh3hjI6sk4cKctpsbMgY8NjlyFQpr8pudIgUAlwy6RQk7MjsyzjUK40yEjP?=
 =?us-ascii?Q?nlSsyt+Q6p9qWKGLQdFFwMWzuK/CdUW+9dYmHBz7gLqOBbpVOImpXn4a2ndi?=
 =?us-ascii?Q?bGO0V0TdQ41/7Xfjvg85r6PMuCDRwO9oP4snhxwmiFHVxWg0DbaiAZBzzSM7?=
 =?us-ascii?Q?YdV8eikvrqzdPYmDk+F+gHHYCywiJSiaK+PteWQOEMzuFQb2vqjk1i+AX3Q4?=
 =?us-ascii?Q?8cyX90Ld+vwrPo4cgyZrVWr3fy8+pXWD3Q0IB8nmjmwcnuRzxoOI5OTAKcgd?=
 =?us-ascii?Q?/U1OkLM3PWwvIi2E9CDp0vagNnSusNatNVOd3GhrwULeVk/tZBP3eVzDrygP?=
 =?us-ascii?Q?evehOs/MpuSLP1pZI94tClynij7ofu6u30AEJl6JWGJGBBFhSfW/Ig2e9ji2?=
 =?us-ascii?Q?nKmDGJCCi8p3sGbHzrcP8f0VSp/e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 21:37:27.0806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99439761-8e36-4a76-1e8a-08dced61907c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641

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

All core ranking data are provided by the BIOS via a shared memory ranking
table, which the driver reads and uses to update core capabilities to the
scheduler. When the hardware updates the table, it generates a platform
interrupt to notify the OS to read the new ranking table.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Whitespace (Ilpo)
 * kmalloc -> kzalloc (Ilpo)
 * Drop needless include (Ilpo)
 * Capitalization (Ilpo)
 * Drop needless comment (Ilpo)
---
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  20 +++
 drivers/platform/x86/amd/hfi/Makefile |   7 ++
 drivers/platform/x86/amd/hfi/hfi.c    | 168 ++++++++++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index f88682d36447..c3f69dbe3037 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -5,6 +5,7 @@
 
 source "drivers/platform/x86/amd/pmf/Kconfig"
 source "drivers/platform/x86/amd/pmc/Kconfig"
+source "drivers/platform/x86/amd/hfi/Kconfig"
 
 config AMD_HSMP
 	tristate "AMD HSMP Driver"
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index dcec0a46f8af..2676fc81fee5 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
 obj-$(CONFIG_AMD_PMF)		+= pmf/
 obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
+obj-$(CONFIG_AMD_HFI)		+= hfi/
diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
new file mode 100644
index 000000000000..08051cd4f74d
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
+	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
+	 selected, hardware provides runtime thread classification guidance to the operating system
+	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
+	 These capabilities may vary due to the inherent differences in the core types and can
+	 also change as a result of variations in the operating conditions of the system such
+	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
+	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
+	 resource allocation, leveraging the diverse set of cores available.
+
+
diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
new file mode 100644
index 000000000000..672c6ac106e9
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
index 000000000000..fbbc2c119a64
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -0,0 +1,168 @@
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
+#include <linux/printk.h>
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
+static void amd_hfi_remove(struct platform_device *pdev)
+{
+	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
+
+	mutex_destroy(&dev->lock);
+}
+
+static const struct acpi_device_id amd_hfi_platform_match[] = {
+	{ "AMDI0104", 0},
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
+	mutex_init(&amd_hfi_data->lock);
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
+	.remove_new = amd_hfi_remove,
+};
+
+static int __init amd_hfi_init(void)
+{
+	int ret;
+
+	if (acpi_disabled ||
+	    !boot_cpu_has(X86_FEATURE_HETERO_CORE_TOPOLOGY) ||
+	    !boot_cpu_has(X86_FEATURE_WORKLOAD_CLASS))
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


