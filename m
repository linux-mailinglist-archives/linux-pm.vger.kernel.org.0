Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD7456D79
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhKSKfO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:14 -0500
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:33409
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234766AbhKSKfN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqZJvfBwnR4mPYnDu67Ouf4MwFmNV26C159trBHBioU0PiAp3OJ8S7DcpN8UGWxGN9IEgupo8YWPeU443GPgSFeb7Rh4P5zn9lmdGfIbZVK6LmyW4zA6FJOr1xVG85ziffiIC6Ze0j/y/P1quSHy7bmhGC0+RitvessBL+kD+YIOHxEY39bS9CyMBQL7wm1nM9QUBW/8fxO889R0d25vYtJU7K+iQag5IS10YMGM+b+8MKVmC0lBmvz3QGy1USbAKlsZhZpUv7dZHsNcCeBmp/W3j2aPnj6PGkjO82XtJsgu0j06bbKwn4moO034caZG9lTXpOXj7OZk9yX4gcszGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blMtcVDaXrR1QUBza7eXiA7893iYvWpOdinSaTE9Dqg=;
 b=hvNl5Hc/oq0uDlMtnxVthqp2qSdQnoUeg4v96a5GQMDXCzL+jJz6jNicb6WA1h8+lirNWgxju5hHXC9bBxISEMdRiUNBbhvnos7klqJOto5LaaFne2Smwzxwm3MpyKFupuCgVP/WdGc1GzWVRznsjSzH13olPuz+F/a9+R1VPwyNmEdCaie2sFBGIlngfAH7izyJipVsnNgzmtG26C/a5WE5NuVHUwanea6sGiNg519CzAe9uqCGIobxeuPF/XM4titHxfs3CjVTcVf5r/+p5lHo6dxILwMkUc7Q34Seck5iRHeun0CNL1jDNA6wpor9mI4xcx6eR2u2u97q/ChM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blMtcVDaXrR1QUBza7eXiA7893iYvWpOdinSaTE9Dqg=;
 b=FdlocI6VgKBQqqZjpQ/GvCj37FhE5INZNqCPL8hSD6gby+eP0w8BcZXsXSAZaMWvRUPrSW3Bd/YyUuABQsyPTyDBdBqFyT8KkJWXfwpwbs1UpW6I5vSxTsryBT3D9SkwSC9+4qwyt0HZbAh1y1CEqZqBCI0Y/p2S8IGbvtMlHKU=
Received: from DM6PR10CA0020.namprd10.prod.outlook.com (2603:10b6:5:60::33) by
 CH2PR12MB3878.namprd12.prod.outlook.com (2603:10b6:610:2a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Fri, 19 Nov 2021 10:32:09 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::13) by DM6PR10CA0020.outlook.office365.com
 (2603:10b6:5:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:09 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:03 -0600
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
Subject: [PATCH v4 06/22] cpufreq: amd: introduce a new amd pstate driver to support future processors
Date:   Fri, 19 Nov 2021 18:30:46 +0800
Message-ID: <20211119103102.88124-7-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119103102.88124-1-ray.huang@amd.com>
References: <20211119103102.88124-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f8bc542-2b07-4c3a-d597-08d9ab47d740
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38784EDA6B20B7AF2CEDAA5DEC9C9@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deNLTHpkaWnIST3LOKjtotUrippEh3nyVGbubYhhoeO6vH8plOTuPZn8QUvJVskkp8FajX3NplkU1GGn0EHiE4QnGt3MklPMlvrmTP3uZLmkFhNmOlqaVwUc6+StPTYW/ZTulB346WPx20U0bJpsOWHEVG64bQq1+emtME8/1HbXtXpQ2nURC+ifTgThYQvSv9jntUQ2QG90Ays+O1VZLjphIgzQkMLpvB8G4KrB7PNBRxGaNU4uRTEgN6B7L4ZEcMK70R8g8rf4YkhS2mnBW0spudgCptmY18/yBZGxlJQm257X6ZxWmlnLvYDXb7EVHsgI4b8CdtpRBHFU8aXjc3hhnjTxJ+w8MK/o4CLPlXOIGB6UWQ7RTRCXEtS7Snm5TJK6AbCqCJR8y5HHlK7wa62rTm2E77x/pBkKuWzGIZ49+5q1d9MIYRDXx90ApwEQT0tg90odap0kPVDVq2UNSAcD+xGU5pceL7g/j6dZvxosI0DVAWtHSE/c6IB5IH/OWQcGJW0g36zWohHo/pO8doDNa2u9wjKFrNS5XCVrTugoVP8nZ+vZDmwLDP/F3CQuJHf5tEP8P7on2bb5bZctVcNDnM1cJx/4J9Gw3yAW7fxti3+NtBpFy/yjkzvGVAQ0BLj5pWSXPwSiHp6grS0P43feE4+tdHS7hOgnnSSWgNNvGYCS9Xee91vpQJL0KgMixHUoSefe5iPTkiU/ItCmsiFGlF6PUDCfhEOXpV63Q9e2rKCHK9mBTVseIFtX7/D5KCl9JwSl3sMkRY17/RXxwUvMrb5TpjN+cJfW3WtTMMz05WOiR8nbwxIhzRCgdcOI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(30864003)(316002)(54906003)(26005)(110136005)(966005)(16526019)(1076003)(508600001)(8936002)(8676002)(186003)(70206006)(47076005)(2616005)(82310400003)(70586007)(2906002)(36756003)(7696005)(4326008)(336012)(6666004)(36860700001)(426003)(7416002)(86362001)(356005)(83380400001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:09.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8bc542-2b07-4c3a-d597-08d9ab47d740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

amd-pstate is the AMD CPU performance scaling driver that introduces a
new CPU frequency control mechanism on AMD Zen based CPU series in Linux
kernel. The new mechanism is based on Collaborative processor
performance control (CPPC) which is finer grain frequency management
than legacy ACPI hardware P-States. Current AMD CPU platforms are using
the ACPI P-states driver to manage CPU frequency and clocks with
switching only in 3 P-states. AMD P-States is to replace the ACPI
P-states controls, allows a flexible, low-latency interface for the
Linux kernel to directly communicate the performance hints to hardware.

"amd-pstate" leverages the Linux kernel governors such as *schedutil*,
*ondemand*, etc. to manage the performance hints which are provided by CPPC
hardware functionality. The first version for amd-pstate is to support one
of the Zen3 processors, and we will support more in future after we verify
the hardware and SBIOS functionalities.

There are two types of hardware implementations for amd-pstate: one is full
MSR support and another is shared memory support. It can use
X86_FEATURE_CPPC feature flag to distinguish the different types.

Using the new AMD P-States method + kernel governors (*schedutil*,
*ondemand*, ...) to manage the frequency update is the most appropriate
bridge between AMD Zen based hardware processor and Linux kernel, the
processor is able to adjust to the most efficiency frequency according to
the kernel scheduler loading.

Performance Per Watt (PPW) Calculation:

The PPW calculation is referred by below paper:
https://software.intel.com/content/dam/develop/external/us/en/documents/performance-per-what-paper.pdf

Below formula is referred from below spec to measure the PPW:

(F / t) / P = F * t / (t * E) = F / E,

"F" is the number of frames per second.
"P" is power measured in watts.
"E" is energy measured in joules.

We use the RAPL interface with "perf" tool to get the energy data of the
package power.

The data comparisons between amd-pstate and acpi-freq module are tested on
AMD Cezanne processor:

1) TBench CPU benchmark:

+---------------------------------------------------------------------+
|                                                                     |
|               TBench (Performance Per Watt)                         |
|                                                    Higher is better |
+-------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
|                   |  Unit: MB / (s * J)    |  Unit: MB / (s * J)    |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|    acpi-cpufreq   |         3.022          |        2.969           |
|                   |                        |                        |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|     amd-pstate    |         3.131          |        3.284           |
|                   |                        |                        |
+-------------------+------------------------+------------------------+

2) Gitsource CPU benchmark:

+---------------------------------------------------------------------+
|                                                                     |
|               Gitsource (Performance Per Watt)                      |
|                                                    Higher is better |
+-------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
|                   |  Unit: 1 / (s * J)     |  Unit: 1 / (s * J)     |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|    acpi-cpufreq   |     3.42172E-07        |     2.74508E-07        |
|                   |                        |                        |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|     amd-pstate    |     4.09141E-07        |     3.47610E-07        |
|                   |                        |                        |
+-------------------+------------------------+------------------------+

3) Speedometer 2.0 CPU benchmark:

+---------------------------------------------------------------------+
|                                                                     |
|               Speedometer 2.0 (Performance Per Watt)                |
|                                                    Higher is better |
+-------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
|                   |  Unit: 1 / (s * J)     |  Unit: 1 / (s * J)     |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|    acpi-cpufreq   |      0.116111767       |      0.110321664       |
|                   |                        |                        |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|     amd-pstate    |      0.115825281       |      0.122024299       |
|                   |                        |                        |
+-------------------+------------------------+------------------------+

According to above average data, we can see this solution has shown better
performance per watt scaling on mobile CPU benchmarks in most of cases.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/Kconfig.x86  |  17 ++
 drivers/cpufreq/Makefile     |   1 +
 drivers/cpufreq/amd-pstate.c | 398 +++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/cpufreq/amd-pstate.c

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 92701a18bdd9..21837eb1698b 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -34,6 +34,23 @@ config X86_PCC_CPUFREQ
 
 	  If in doubt, say N.
 
+config X86_AMD_PSTATE
+	tristate "AMD Processor P-State driver"
+	depends on X86
+	select ACPI_PROCESSOR if ACPI
+	select ACPI_CPPC_LIB if X86_64 && ACPI
+	select CPU_FREQ_GOV_SCHEDUTIL if SMP
+	help
+	  This driver adds a CPUFreq driver which utilizes a fine grain
+	  processor performance frequency control range instead of legacy
+	  performance levels. This driver supports the AMD processors with
+	  _CPC object in the SBIOS.
+
+	  For details, take a look at:
+	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
+
+	  If in doubt, say N.
+
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 48ee5859030c..c8d307010922 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 # speedstep-* is preferred over p4-clockmod.
 
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
+obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
 obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
new file mode 100644
index 000000000000..8b501a72c3dd
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * amd-pstate.c - AMD Processor P-state Frequency Driver
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Author: Huang Rui <ray.huang@amd.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/cpufreq.h>
+#include <linux/compiler.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/uaccess.h>
+#include <linux/static_call.h>
+
+#include <acpi/processor.h>
+#include <acpi/cppc_acpi.h>
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+#include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
+
+#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
+#define AMD_PSTATE_TRANSITION_DELAY	500
+
+static struct cpufreq_driver amd_pstate_driver;
+
+struct amd_cpudata {
+	int	cpu;
+
+	struct freq_qos_request req[2];
+
+	u64	cppc_req_cached;
+
+	u32	highest_perf;
+	u32	nominal_perf;
+	u32	lowest_nonlinear_perf;
+	u32	lowest_perf;
+
+	u32	max_freq;
+	u32	min_freq;
+	u32	nominal_freq;
+	u32	lowest_nonlinear_freq;
+};
+
+static inline int pstate_enable(bool enable)
+{
+	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
+}
+
+DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
+
+static inline int amd_pstate_enable(bool enable)
+{
+	return static_call(amd_pstate_enable)(enable);
+}
+
+static int pstate_init_perf(struct amd_cpudata *cpudata)
+{
+	u64 cap1;
+
+	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
+				     &cap1);
+	if (ret)
+		return ret;
+
+	/*
+	 * TODO: Introduce AMD specific power feature.
+	 *
+	 * CPPC entry doesn't indicate the highest performance in some ASICs.
+	 */
+	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
+
+	WRITE_ONCE(cpudata->nominal_perf, CAP1_NOMINAL_PERF(cap1));
+	WRITE_ONCE(cpudata->lowest_nonlinear_perf, CAP1_LOWNONLIN_PERF(cap1));
+	WRITE_ONCE(cpudata->lowest_perf, CAP1_LOWEST_PERF(cap1));
+
+	return 0;
+}
+
+DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
+
+static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
+{
+	return static_call(amd_pstate_init_perf)(cpudata);
+}
+
+static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+			       u32 des_perf, u32 max_perf, bool fast_switch)
+{
+	if (fast_switch)
+		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
+	else
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+			      READ_ONCE(cpudata->cppc_req_cached));
+}
+
+DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
+
+static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
+					  u32 min_perf, u32 des_perf,
+					  u32 max_perf, bool fast_switch)
+{
+	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
+					    max_perf, fast_switch);
+}
+
+static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
+			      u32 des_perf, u32 max_perf, bool fast_switch)
+{
+	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u64 value = prev;
+
+	value &= ~REQ_MIN_PERF(~0L);
+	value |= REQ_MIN_PERF(min_perf);
+
+	value &= ~REQ_DES_PERF(~0L);
+	value |= REQ_DES_PERF(des_perf);
+
+	value &= ~REQ_MAX_PERF(~0L);
+	value |= REQ_MAX_PERF(max_perf);
+
+	if (value == prev)
+		return;
+
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+	amd_pstate_update_perf(cpudata, min_perf, des_perf,
+			       max_perf, fast_switch);
+}
+
+static int amd_pstate_verify(struct cpufreq_policy_data *policy)
+{
+	cpufreq_verify_within_cpu_limits(policy);
+
+	return 0;
+}
+
+static int amd_pstate_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	struct amd_cpudata *cpudata = policy->driver_data;
+	unsigned long max_perf, min_perf, des_perf, cap_perf;
+
+	if (!cpudata->max_freq)
+		return -ENODEV;
+
+	cap_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	max_perf = cap_perf;
+
+	freqs.old = policy->cur;
+	freqs.new = target_freq;
+
+	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
+				     cpudata->max_freq);
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+	amd_pstate_update(cpudata, min_perf, des_perf,
+			  max_perf, false);
+	cpufreq_freq_transition_end(policy, &freqs, false);
+
+	return 0;
+}
+
+static int amd_get_min_freq(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	/* Switch to khz */
+	return cppc_perf.lowest_freq * 1000;
+}
+
+static int amd_get_max_freq(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+	u32 max_perf, max_freq, nominal_freq, nominal_perf;
+	u64 boost_ratio;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	nominal_freq = cppc_perf.nominal_freq;
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	max_perf = READ_ONCE(cpudata->highest_perf);
+
+	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
+			      nominal_perf);
+
+	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
+
+	/* Switch to khz */
+	return max_freq * 1000;
+}
+
+static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	/* Switch to khz */
+	return cppc_perf.nominal_freq * 1000;
+}
+
+static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
+	    nominal_freq, nominal_perf;
+	u64 lowest_nonlinear_ratio;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	nominal_freq = cppc_perf.nominal_freq;
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+
+	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
+
+	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
+					 nominal_perf);
+
+	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
+
+	/* Switch to khz */
+	return lowest_nonlinear_freq * 1000;
+}
+
+static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
+{
+	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
+	struct device *dev;
+	struct amd_cpudata *cpudata;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		return -ENODEV;
+
+	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
+	if (!cpudata)
+		return -ENOMEM;
+
+	cpudata->cpu = policy->cpu;
+
+	ret = amd_pstate_init_perf(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
+	min_freq = amd_get_min_freq(cpudata);
+	max_freq = amd_get_max_freq(cpudata);
+	nominal_freq = amd_get_nominal_freq(cpudata);
+	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
+
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
+			min_freq, max_freq);
+		ret = -EINVAL;
+		goto free_cpudata1;
+	}
+
+	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
+	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
+
+	policy->min = min_freq;
+	policy->max = max_freq;
+
+	policy->cpuinfo.min_freq = min_freq;
+	policy->cpuinfo.max_freq = max_freq;
+
+	/* It will be updated by governor */
+	policy->cur = policy->cpuinfo.min_freq;
+
+	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
+				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
+		goto free_cpudata1;
+	}
+
+	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
+				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
+		goto free_cpudata2;
+	}
+
+	/* Initial processor data capability frequencies */
+	cpudata->max_freq = max_freq;
+	cpudata->min_freq = min_freq;
+	cpudata->nominal_freq = nominal_freq;
+	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
+
+	policy->driver_data = cpudata;
+
+	return 0;
+
+free_cpudata2:
+	freq_qos_remove_request(&cpudata->req[0]);
+free_cpudata1:
+	kfree(cpudata);
+	return ret;
+}
+
+static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata;
+
+	cpudata = policy->driver_data;
+
+	freq_qos_remove_request(&cpudata->req[1]);
+	freq_qos_remove_request(&cpudata->req[0]);
+	kfree(cpudata);
+
+	return 0;
+}
+
+static struct cpufreq_driver amd_pstate_driver = {
+	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
+	.verify		= amd_pstate_verify,
+	.target		= amd_pstate_target,
+	.init		= amd_pstate_cpu_init,
+	.exit		= amd_pstate_cpu_exit,
+	.name		= "amd-pstate",
+};
+
+static int __init amd_pstate_init(void)
+{
+	int ret;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return -ENODEV;
+
+	if (!acpi_cpc_valid()) {
+		pr_debug("the _CPC object is not present in SBIOS\n");
+		return -ENODEV;
+	}
+
+	/* don't keep reloading if cpufreq_driver exists */
+	if (cpufreq_get_current_driver())
+		return -EEXIST;
+
+	/* capability check */
+	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
+		pr_debug("AMD CPPC MSR based functionality is not supported\n");
+		return -ENODEV;
+	}
+
+	/* enable amd pstate feature */
+	ret = amd_pstate_enable(true);
+	if (ret) {
+		pr_err("failed to enable amd-pstate with return %d\n", ret);
+		return ret;
+	}
+
+	ret = cpufreq_register_driver(&amd_pstate_driver);
+	if (ret)
+		pr_err("failed to register amd_pstate_driver with return %d\n",
+		       ret);
+
+	return ret;
+}
+
+static void __exit amd_pstate_exit(void)
+{
+	cpufreq_unregister_driver(&amd_pstate_driver);
+
+	amd_pstate_enable(false);
+}
+
+module_init(amd_pstate_init);
+module_exit(amd_pstate_exit);
+
+MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
+MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

