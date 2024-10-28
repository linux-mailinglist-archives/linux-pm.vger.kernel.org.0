Return-Path: <linux-pm+bounces-16542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCD9B2275
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9235A1C208CF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A3D1922CB;
	Mon, 28 Oct 2024 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VoD/2auJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F6190685;
	Mon, 28 Oct 2024 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081006; cv=fail; b=gBs1i1GF1D3PFCS0KZQmWAbppPCTuVn3ZjhZmpCn86F3WvDs7x77xmdPcItafQjTckNgHsaSmIh+AK7QJZTD2qB6mIdb3YupHoy5AIZz2ClFiqPAu8uflVegOjAYSmX0QbBWZIRimTHayQXjSKPS/dkSnC/KWet5BSAGpNAdvf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081006; c=relaxed/simple;
	bh=bDG6YPlTYyO5FxN5nPIcCuN3qUVAj9w1jUAV5gAiOVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkjMNHymeva/2lI4L6nCT+ehiEK7uLSZc5z1vdYIimugYWDieDdfz/RGM4c/iETUjrw8Iy07B9xaq5LH+FxI/sFCXxH9nvFrlhuVsdzdLdI/wC5I68Bv8KX26peWYoUcPv8K8cgyvYYSBN5p37NpmHQg4b1as2EO70IWjyO5rwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VoD/2auJ; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+VI8SfQwaG9hRB6gLv8D0VUPop3eMWBfLbwbHLXlCHJYA4tw0J5ugSfYjiQz0SWmCeI/BTHnKkRk0CEVome0WnznSULhVoOwaERJwBXdS+kbh2hSoHRXAPyrRTf7p8G28GlGBxdPFo3UpXxEsoTX2F9ZDdngA67O6Dv1Wg45VAAAXjkPvaPtnxlA9ARYgnVfBC4wnUazKRzVUI9Z4Zk1rkotiSDwO02pCx+zvs4VDR6aYDnQeImBMZS9eatzSH0UNVyvQz9m3rr7nAo4gj7MdOco4yWm1//bDvHIe33M8C8WK9cyrqpB0KVpOA3kN6oT292GuPgu2mwNLVhyBvQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIWBewZCbvsLy2Y8C+VvYVLy64BV7JfQyT2KFRrIq2g=;
 b=ptn6ytXHZVwnIduTzjNNbUAWH/ai3RhJL1oXKrazug28bN1k4G9rBYX3aCz4LrOMxSDgOCIJr05IQR6USwNi7sTvitEFbPbQlfkDmWoB3nDFPeY5BPpqn7G1RDTTD4PoCPbpXlZEhxhR2y/MTDGFeQap5q4J/o+1GKP2YEHXBetNjYplxkcSMiTt2msEoVaRBvLA1T6HdG74q7WOSHrgk0Pfa2az/uqTw876RofTKmYrVwlxEC+e2a1hI8kKBV7kTgFybJ2W1ucvS232rwkjfBlpUBNSbgPA5P1CPSQ6BZZnZA8UaMHigBuJltQBebQIie9suzWV3IFwQvg/SwsTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIWBewZCbvsLy2Y8C+VvYVLy64BV7JfQyT2KFRrIq2g=;
 b=VoD/2auJ77YlOrSJbhBPU3NfMAkYAeaECgchB1o7S+6E96kqCdNVPfOEVowUiLw3e2z9OkRkqOTDGbleelHDIf4g9OR1Tav02LnuL3ZGYoe8LyE8sdczQBta5jDkoa3FgGuIQ4nNrEED97hI9G7oUT39oifIBYEtNZuaNnl4oZE=
Received: from MN2PR06CA0023.namprd06.prod.outlook.com (2603:10b6:208:23d::28)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Mon, 28 Oct 2024 02:03:17 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::d8) by MN2PR06CA0023.outlook.office365.com
 (2603:10b6:208:23d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:03:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 05/13] platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
Date: Sun, 27 Oct 2024 21:02:43 -0500
Message-ID: <20241028020251.8085-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f485666-def7-436c-13e8-08dcf6f4b08f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwJB1hC+b/c7AtFxpJ8jY7JIs/GbDHtlLevQCL3TKPcS6iBI80vCOflo62xa?=
 =?us-ascii?Q?xElgyVjI+xCKlmw0IcyPqtAfavOfjW/ukjScyUZCrY7K1fyP1hnjuC0cgDgW?=
 =?us-ascii?Q?DuNzEoutDz8qVbfyafEymC0AQfeLYl0CfP0TITDY35AgdVc4QWertzyurSta?=
 =?us-ascii?Q?MpHG2nlmwyADWOGeq4v488f6I6EhdAKkDetEI623uDmLAWUqqX0Xse8qTaqd?=
 =?us-ascii?Q?FEfNdLsWvGL0GHtGsqQGItWoMN1MjueA+CKGEAE+GOoa9bilv6wG0/WtZb5K?=
 =?us-ascii?Q?NA9bIm68NaLs+QuNLQEVU/SEk3x3eZ0cOMO7apSk71uOau0bhiyUn+IxNMJ6?=
 =?us-ascii?Q?Kzc6YpR9Hbh0m4N9BCkwTH1FQ7Z0HIZdG10XycHFjSzltkWf3KY665+eAte+?=
 =?us-ascii?Q?9Sn6KLdxm22gAPX4K+WadRZfXD1Cc92LxiKT+rX6ITioyyoVCFF0+YU24tsv?=
 =?us-ascii?Q?C7TNwGAlkTiaGr2MxY+Hmu01NBfHNuLsFQrSenc33hRNGpgYqWzrc1RRYYOd?=
 =?us-ascii?Q?ywFKVcvAadWHwfX9umJbTcorMehOsvbDmR2b1XkTamH+gA7vA6M19y2x/1x5?=
 =?us-ascii?Q?KEWYGqKapPwC52Z74DXaiM/1RcPzqrB+mSKBsS0DPmXW/CxCVt2P+3dZra7a?=
 =?us-ascii?Q?NXVvpi5IQShxc6bR8eimYwxrO28NR9RXYxuaAgEaAiOcb2vqweup023oJeBr?=
 =?us-ascii?Q?infN5s55Lstk2YDy4+4eAL2lC/cHfQDBAgurlKlvsFZ8CEBwU0aDns1e7vyF?=
 =?us-ascii?Q?1z8BT+lrQs3yNDwLNohjDXYTpnbaH2MU4Zi0euuqfxdeYFyLx8/fle2BkN0x?=
 =?us-ascii?Q?4rKqjJBk2K7ILwTbqU5GelwO74JWpoTLVH4f01W9RcXyyhNARtIWVrm4L/U7?=
 =?us-ascii?Q?J0aQPK3Y9C+PCiEy4hNnDg+Pgt+XuFxqbONXr/R3uijmLngX2G58q+qtcuEZ?=
 =?us-ascii?Q?N2YLHpVf4BZjRxraZBDO/kDge1bIHKD/0HzOPlooQPEucTdj976lTJX7/RTg?=
 =?us-ascii?Q?+4fabKrQzwILWvIzPWyhFThLHDqSv85KnyXsZJozxauZpkAxVGtqnBiMDw+Q?=
 =?us-ascii?Q?DvVqlBZrUOMR1BJ3IfRGFol7qkNpVTEZjpjOQh0t+sxEYlsLyTu/Lf6OUSP1?=
 =?us-ascii?Q?SMTZ1EyWlQ/hSZhqObEyRzCnbL7OoYECd/Ib7v+CS21cXTAqUL1XuFenit6a?=
 =?us-ascii?Q?epURGbSVpoZeONtJ73FEC4ZD5OZJBrNKJ/332UWil22PhwlVu52ya/Soehd5?=
 =?us-ascii?Q?LV1C+gbBRQZTujo84Y4OgFjCrw6vxK2V9oBvR8CkKT35V56XRgrpljEN+Dtj?=
 =?us-ascii?Q?Xzcdo/Ind5FM9ieV0LTfeX84MEIx0mnpF8+6PKut5xYFIkf1dKfLPb4VfW95?=
 =?us-ascii?Q?+2LAL5keT/lCuRQqACKH9iaR9rLZuepKLVEXbqul4WKIobYiCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:17.3762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f485666-def7-436c-13e8-08dcf6f4b08f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542

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
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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
index f88682d36447c..c3f69dbe3037d 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -5,6 +5,7 @@
 
 source "drivers/platform/x86/amd/pmf/Kconfig"
 source "drivers/platform/x86/amd/pmc/Kconfig"
+source "drivers/platform/x86/amd/hfi/Kconfig"
 
 config AMD_HSMP
 	tristate "AMD HSMP Driver"
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index dcec0a46f8af1..2676fc81fee54 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
 obj-$(CONFIG_AMD_PMF)		+= pmf/
 obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
+obj-$(CONFIG_AMD_HFI)		+= hfi/
diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
new file mode 100644
index 0000000000000..08051cd4f74db
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
index 0000000000000..a92fe74b415e3
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
+	.remove = amd_hfi_remove,
+};
+
+static int __init amd_hfi_init(void)
+{
+	int ret;
+
+	if (acpi_disabled ||
+	    !boot_cpu_has(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
+	    !boot_cpu_has(X86_FEATURE_AMD_WORKLOAD_CLASS))
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


