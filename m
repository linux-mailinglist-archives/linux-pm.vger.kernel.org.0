Return-Path: <linux-pm+bounces-15484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C2999284
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CF72859DD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F51E0B98;
	Thu, 10 Oct 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Pftdgdm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1221CF5C5;
	Thu, 10 Oct 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589071; cv=fail; b=eDXkwkvGSLyfGDdA6v7qEuhfdf+rZ7PTmKv7y6CQHFZnLZ409hX4E8tNtwL6iv/SO3YcOZ4cb2Q2nRuNJdTt+hHOL9KOoZF9Wo91g91FjDmu7DGrwM4MRXN2gDQy+VsnNn6LFs1qsMncHdl42hm4tUk7XusVPJSbwB9ARp47hCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589071; c=relaxed/simple;
	bh=PUoWolRt+kVsR0Vo5T1pDdfuqYinHX9XGoPT9sehMlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ok1z9SBIJR94gCCfuLXqSB/kjN9sgoj+2TACSeeMPhRdA5bS9QjNz2enzyBtPzlnbZPiylebMwoAsTUz2CFo6rQ/JZZAffaa/D7Ut0UW7Jy4GVqGRmUzR/hPWfjaxzieyMfKdWDlN+J8v35KXuYo/nYdl3uxG7b+rp9MO6XOft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Pftdgdm; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fimk36T467cEgSYyTkR04EUhAxj0FgSy2qOcP9kX0I3156hw+m4PN6mXygdDBsxm3ME6QAQH/q0ORlwNQY4KM52kJfcOBcRcnBfvIEEPG0m38tyzrcnklYl4jaPHDNGbhB09tPKbjFJN8drl+pyON1pULT42Bq0W0JZnixkNtLjKQBRM16Je4NS4V9x6XtNpxJrez1zrWXgJ0QX3ATD71zLkh2HnaTe4vl6Mde18IKpPcV9CK2rp3+4WBKModpJdUOqGcgHx008Fp3enp8yJWB7+YVlLBmhBDgnpUSG/n3wok94xjToU3Ew07vFYBUUVprb2du74bcisPETGnVl79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq0DugTKtOYzkF1f03p2oOVPCBi6aK7stT66UpT7usA=;
 b=N7m3SaR8A/THv2TvqqvG25BYeIoCN9MKALpIGspwOu/aR9lW0S6rUHSWBUeKQuY+1RSkPy8n6TiFOImw0CoUvYgu2BDCfr0Os3eoSBon+rsr66kVvkXRPURE3dkIImczXZwAQ/TDhVlC1hiumRiRhqCGr+qFVudoJ8q4FtIfcXTCsmc9sh54j1Lc415YVlpvAMGah3z2SW81y2D4cqs+zAv7g5p8TTAETpYGwlv8GYPWIJXw1oA8WsrB2DeRY2vsRub4gT7iZM9QTGpc96Rd/26tKPUsZ+4HHYutYmYc+1MzbOZZ1EO8EKOEq6tWQs4Zo0DqVjnqbktG3kt724NXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq0DugTKtOYzkF1f03p2oOVPCBi6aK7stT66UpT7usA=;
 b=3PftdgdmB6xtOe7Y5W7+O3G9ZnEiHef1y02ispAUw1O1Wq1c0qkTjCgldDBaH/AhNwMiFvLcfEckiWAdWofXjHneDTFL1Xp4utIvQ55AUbfabj/a7QEIpo44gsE58ztHUezUR4z4gk/9lY1im4ETXKn6hcoc+gb549YwkEyxTX8=
Received: from SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::29)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 19:37:45 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::db) by SA1P222CA0164.outlook.office365.com
 (2603:10b6:806:3c3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Thu, 10 Oct 2024 19:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 19:37:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 14:37:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
Date: Thu, 10 Oct 2024 14:36:57 -0500
Message-ID: <20241010193705.10362-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e8579c-eec8-45ef-6e48-08dce96303cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IqVBRPWC+6p75ZRovi3I7gpbbF6B6TWVmGTay70dB40lHP99usghIYxD1yu4?=
 =?us-ascii?Q?wqB/V8Ejuw6sD5jFqykwHAnToHQF1FwGKTnn4c+jQFe/RyxVVRYp2WXOb5H1?=
 =?us-ascii?Q?3gKzKuS8PgpjlfMRPq8qC6GDLJz7imPw91QTHlbEVdhEhdAUQFjHhZu5Aclk?=
 =?us-ascii?Q?/4V+GA54v6yICO9dYoKyLAWRrc0baKZbuHkVTHmI3zjbF8ouooQrfYAESYfh?=
 =?us-ascii?Q?5+uHjvhFQDeOe9p9YHb2bQ45ohQtLit56fkUSY75sK45csE/Xnt+m6F4wO12?=
 =?us-ascii?Q?uq4Csa65CP1WXOj5XhaWhWllWQY7VItZ8B4b2i0CqEXbH9Uq89FBIm0ct7bP?=
 =?us-ascii?Q?F0yfkWB2JMvCMaFj9AAphc6K57dcgwia96D3Ei6Kg9Qukwc+EPguryh+vFuK?=
 =?us-ascii?Q?nNBqObFWtODAVF8VuH+MlVCFW1TzgIgSz0IueAY+eWmjWFdBoAZvVg1c4eJ2?=
 =?us-ascii?Q?y+0pSm6rxm1MW6XM4pmWon/36QN4oKL+eQRW0zGGL6XwdK31tXoFoZw11ERp?=
 =?us-ascii?Q?wK8nocR6y0n2xJEWnSw/vsNF8m63XgfoSJw2IvYOor0oNiBXTtsPv/BgZzNh?=
 =?us-ascii?Q?NDRu4kS4fk+pM7yrcFp2dsVojCFoVcLpmBvSS63L2QkIxTRvQYBBmKDCFunb?=
 =?us-ascii?Q?T2jPGZ0DBP5vz+Eho/53Tez/I0c89EaHFbQQyn3Qwog0HDLdzuEk5sLN4HNv?=
 =?us-ascii?Q?6udU/gOjhix6XZvwGBZR4wducxCVIpKAjKhRf6Lyp47e5FTptdT+0sj6cqxo?=
 =?us-ascii?Q?IKj9PUNjG2QgWPwtm4zd0g55C9lRbHeLGQdidD2qr72PWzZBqtzyGDYXrbtT?=
 =?us-ascii?Q?8tziURSpL7Nofa8f31pniUYh68gtjUxPLcH7fJO8hX6L6Ugfq76f+pfXab8z?=
 =?us-ascii?Q?0R0SmVLO35V0wLDOWOEn/8M6mrqz+Nf1i2E3rYSVPnJIJVKdSvMZou1UmdRo?=
 =?us-ascii?Q?cKe4IpSgna3ojc6VdOth0ynFv1ijcFEPkFRQrojsK+/wlkW7YnjL12zXJ773?=
 =?us-ascii?Q?ebkF2I6MsYjhCOMznpt4lkR2vC2nOiKUjN1HlSnCNbTSRA3GQ2yXLEsDdV3t?=
 =?us-ascii?Q?8eo55KZ7dAWfxNTxC4wHnB3s62kQWN/hFkrLnPPVlrGIpTSK0kSp3Lp2VSlp?=
 =?us-ascii?Q?WfrJUrnW+n7SmTnYVYwzsywz1trL85SZ/OnJBcUJOg99ppjZ0+cnu1CdCCs2?=
 =?us-ascii?Q?1Rc0+nhvKwysrUf7SvbwPH8mr1y5KDGQTtFCyLwiJW1axQlQhk/prAlrH0+M?=
 =?us-ascii?Q?PW0hjsyT9V1EPNhZtrUJEiFBcbNGmyP1wjYGCmrxPIO+5A/byYEdFgZ3OSP7?=
 =?us-ascii?Q?XtY3v8OvfRNPN5UC/jOwqKoZ9ag1JNG8mTmzqHzmeCDp3o/U4LT8dCFu4pLC?=
 =?us-ascii?Q?mHj0rREbLB3VzCd9XcfBZUgl4g6U?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:37:45.3815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e8579c-eec8-45ef-6e48-08dce96303cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

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
v2:
 * Drop unnecessary select
 * Make tristate instead of bool
 * Drop error messages
 * Drop unnecessary function declarations for init
 * Fix cleanup for amd_hfi_exit()
 * Drop unnecessary variables for upcoming features
---
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  20 +++
 drivers/platform/x86/amd/hfi/Makefile |   7 ++
 drivers/platform/x86/amd/hfi/hfi.c    | 169 ++++++++++++++++++++++++++
 5 files changed, 198 insertions(+)
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
index 000000000000..da2e667107e8
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Hardware Feedback Interface Driver
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Author: Perry Yuan <Perry.Yuan@amd.com>
+ *
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
+#include <linux/string.h>
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
+} __packed;
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
+		dev_warn(dev, "failed to get supported class number from CPUID %d\n",
+				AMD_HETERO_CPUID_27);
+		return -EINVAL;
+	}
+
+	for_each_possible_cpu(idx) {
+		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
+		hfi_cpuinfo->amd_hfi_classes = devm_kmalloc(dev, nr_class_id *
+				sizeof(struct amd_hfi_classes), GFP_KERNEL);
+		if (!hfi_cpuinfo->amd_hfi_classes)
+			return -ENOMEM;
+
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
+
+	mutex_init(&amd_hfi_data->lock);
+	platform_set_drvdata(pdev, amd_hfi_data);
+
+	/* alloc data array for hardware feedback class data */
+	ret = amd_hfi_alloc_class_data(pdev);
+	if (ret)
+		goto out;
+
+out:
+	return ret;
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
+		pr_err("unable to register hfi platform device\n");
+		return PTR_ERR(device);
+	}
+
+	ret = platform_driver_register(&amd_hfi_driver);
+	if (ret)
+		pr_err("Failed to register hfi driver\n");
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


