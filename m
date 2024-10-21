Return-Path: <linux-pm+bounces-16127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50549A71C4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 20:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98126B21116
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692DB1FAC2D;
	Mon, 21 Oct 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EN08nwFp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA61F7080;
	Mon, 21 Oct 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533807; cv=fail; b=g0/bX9ATpoJ7GFbGq2HB4xpjIu9qc6d3AdkcRyiO5mzew/YZRjmeXDP+V17sf718Hzf1gHZepeHGayU6zv2cacmgaNQl5rtLet1uVDiqfTMoe55nJik6r4JnE74ftUblM/0LhIa4AqNF9grCauKP2wZ9W4+qum8z6pGhXyUAsB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533807; c=relaxed/simple;
	bh=FMXxcAYCUpYvrbOwzrI0908deBkfN2DM4IP6aO49UC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYE0XggaiQ1gLo/e4koN/7J7ZU8DFABORYN2EpLpodsHsKjNJSatorQgewCV71+AVO9Fxy784iV98zjg0dp8JNLdllQ2HUgg/YhQv5GJIxVGoSUln4AsVU0Pgzhump+fitx4bYcwZV83pL/t86qknD9ATTPMtsnz4SqTR05URyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EN08nwFp; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Art2FYSp5iVHlaPiSybnzetK+3uwSvXexpfwqaGBKFQIPsZWklBCxW3Ui4P1f4/c1X4SYNAuNlFCSCYmtjqB9bH9Ua/t4++zJltjpf7I3cKUrFyB1AoGS5v7LkKyp1TkEng5WnRLfFpSabXKH/UwXA58VuaF5wD/HIOXSK0ugZr3vdV6jNqnQJWBetxeqjg976vg0LfJRKrvmBsVeJMB9RjtEjf5J2cF9OOYGoHjqmTWKggpi3JFt+u3S+xxB0o+5HtLoDOC/gB7F1PgoZ0Zuw5Ag1lxqatAq34jpzWRkQASYB1Ipygb26vN3n5qsEK2sf7cxf7iQlCM7f1OEwNoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/abZ9mE+1cfNBVOQSEkjqWzKqCwIiNXmKNb82IkBGo=;
 b=Pnk+4rf0PB2r+y7t922PEArC98CVA8zWx+S6/QhT40QKx4r782X13qFwU9oMvsorlUvRReqry8JxjFLqEhTvhyxBMsKrUZLWD15j0NCOqNE815VGUgLK0TzrzvqXY1M9FgUOyRKGSA4ljISSknN709Kri9cCQ5KQM+0XexxV1ProEsH+uptQeCbMTD51TIXCkVGzW0aYq5zbrmxTnyGuUBo6RFdH1qnQcPsSpkj6WjL55OTDwNJEWSKAcxjRJ5QI1ULnT4yeU1ASrSOkMAZzfs1edVPL94Hw7cYVy2r0nF8h7SYlwC+5/Era50G+r2bhiG6FKWNSeT0E2tzN68mFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/abZ9mE+1cfNBVOQSEkjqWzKqCwIiNXmKNb82IkBGo=;
 b=EN08nwFpxPJlUkdMNyPq5efV7Rw/+g2fdMHJTcUNd7a872OuhmQZCKyu5BojlKaFJ+XN7jQymjEJYLsJlPq9Mzvsz28ZmZDx1a+XgHoTcjCdSt3vqBzJt9JCvtSLmpt4T70wNelc2AXHla/Nut45K7iK87CliRZMyAVM7J7t4/E=
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:03:20 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1c) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 18:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:03:20 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 13:03:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 05/13] platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
Date: Mon, 21 Oct 2024 13:02:44 -0500
Message-ID: <20241021180252.3531-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: b7988896-b3bc-4ca0-c359-08dcf1faa5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QCDd80lQG95wNPp29MWUFixMPZOYupuslQLWgAArwX8zP09SGLEhUkWL9Ofo?=
 =?us-ascii?Q?fON9AaVr6cmhBc5VLupJvilQxj0vSGcU+X4J+QtBfHOeSaQeES+DR5RBVg9P?=
 =?us-ascii?Q?LkX71C7mI8lkwN1el6eo+Nb/NtHY9WnwoqP73xI0Os8AXRY0tziuoJ2rFVjH?=
 =?us-ascii?Q?snjwZIfmiK7eXsEzbgQqx3M6uQe9gX+0BfVzDnNOCcVpwVU6HA9wW9UzmEji?=
 =?us-ascii?Q?dTp1rEO99RITYMYzC2/z1tMn2eqksHY4PGKw0jpr5JoNPvXvAWxwjocENHVN?=
 =?us-ascii?Q?S44YnZ4VIUwU/ygE6AYM9J7K+FEgOmrl/xq7ZhxRkkAlD6DSIQDBBOmct1o8?=
 =?us-ascii?Q?WOABBAemujpfN2HkKtlPY7fqGamy7Z5I+JxSbeXyBdaT6D2wtvMJMiTzhagk?=
 =?us-ascii?Q?nnjQw2t+Wv6A8pIxFdr5juAHcRVixmThmTbfbZ611cIHemijZGJWR4T/yvDd?=
 =?us-ascii?Q?3es17ph4GopCOVjNEImf2C73E+/A2v8F1mkrb+B7BnANol04qZ14dDMEm6Me?=
 =?us-ascii?Q?P0jL1s2c8890bAJNWalfYAcjxzvbhoOR/mNpV5syJLKhFt8bF/qAv9F8/iGu?=
 =?us-ascii?Q?i6wySgfhPx+lF+k3RvPPVc504IWk+u3Dbg2JP292wCZCmhNa/9A2ZND5uziX?=
 =?us-ascii?Q?gILMz62V2Ic/BuOsNfEMVpL57HWrF2e5878JEePfOxBZrUCgHMQs6vl8tlZ0?=
 =?us-ascii?Q?4hSugJke7vDEblLmpQNXwzINUjBTs7LsL1tAvfVH7okRprUmwZ7Xzx+bjmIS?=
 =?us-ascii?Q?U53jSHdh/EaLQu40l2CS8VWJdzaiNYQA7eUW51pYO/QH7njiS16fDiejU4wr?=
 =?us-ascii?Q?XJrPYzmVGRLhb/v5h4EE8NnapxIAlkW0s/vMR6FwUdmmC03xM3kIeLREtQAc?=
 =?us-ascii?Q?JWa8zoN6qnhAy0s3mczV3Oeg0laR7k1Pr4Oji7yIt9osbA3my5bewJOUuJLY?=
 =?us-ascii?Q?2FadytqFm+v2Rde99ToLeJPGrzDpC6Dw5opMvNSzVfRQ7Nu1sQrQXVwS3NYe?=
 =?us-ascii?Q?BHofmzQXY6zWtoSmxRWgYmFrC87RPvpqA9WV6rBFOkdMnE/z/OmJCHYUY1MI?=
 =?us-ascii?Q?zSrv8QLQpk73ix/Fh6RFVVR6EWHjzIF2veW75ZASAoJTQ1xGNJnM2oYHLsAx?=
 =?us-ascii?Q?Sb9XSVqHG/3P0YuIWtKB2aP+NdqJVrYsgDwPRWgzxJqYA+VoiFjnj7YEZyTt?=
 =?us-ascii?Q?hynwQ2vtk0bj2vVKm+7JxlD4/qNXwnjy/Ina+ix7fX9EO+ejMHZwnPFFb9zS?=
 =?us-ascii?Q?J3jnVW4SuO84ByjbqD99dSsUpAxyN7sgX4p3fdyMbBgAT6LWqow+G/wrHZrV?=
 =?us-ascii?Q?/t0hSms+DIfMKjQHVROe2FTf13gGJr+rmeLK25scaeCFPMFin07tKeu6j/1c?=
 =?us-ascii?Q?57BCXlu+uzTh+kGIkk0LpD4/JyOWpoBqUfuEbaHdEMIICN8jaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:03:20.6171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7988896-b3bc-4ca0-c359-08dcf1faa5eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

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
v3->v4:
 * .remove_new ->remove (Uwe, Hans)
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


