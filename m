Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5A4403C1E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351992AbhIHPCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:40 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:47937
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351821AbhIHPCU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf/P+DEHB9VU/7HhJLrTUXzHv8vm8JwIcytCSdadstfm7BRZTAAW4ii3bkulosy6yz+JGDpRqQG3MiYsvv+zB/KgZABwT2Wkc4K1AZ0sWLiPKoeS9BDu8XN8fnRW3hm5z8MaY7F7HW8uxgtvi0DBrJxY3Wl2/UJlH+yJroAVRYDUDtdswig10EU4iRkoGHZwFpQbQvFsZy1QeQAK+B3fJapviuAWelSzIlkePNZpmk+S0OSzNGWimBkLCvUD+fb79/ZxawNUPZbiKcySIrESMNyQZaEJwgwyc0xYHavn48mRSU86j1xis82lqjnfhdMLDPrZn5e9oJR1nO86RdzRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=x1CTSNBpCCVRWVE+jlegtlNWM8sebgNmq9tkcGd7Hv0=;
 b=E7ndbM2I0z5M3D0eNX4/rBeN+mDJ5dmzaLoOeBs5+9LiSjwsCqNhS2eZ+9fxoKAF4oFJqwwzrJlUetEigBH4WgxSQery/fia3uAzKzMoufiicoj+xDEclylHMP8X+cX6nT9Xm6jo1mAu3yVQ9njfzNa+eqIOdHC7elSTDQpBV+qrHT+IRCoGn37im2Y8MbNaX2CGJOAYTxOCfHo5EbSwPedAd7VqAAP41o3pmZhhWQJJg05qbX9eE1BWCAOCf+isFsjnLxLkvZ0DZ2GrMnmG1br8Q/ijxPstQE5XABJsmIw8UDqhzvnZTxmYVWXtFtR5FaIZNwxRPgrNz4TqbNGGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1CTSNBpCCVRWVE+jlegtlNWM8sebgNmq9tkcGd7Hv0=;
 b=MtSWF+6N6n40xsPOS75o8SHp6V7ztqeZwmexwgV/h5cVhpir/h+m3i6+swF97ozFxSHMuMniJ9qMNLWlQOFx/YsZWRaRKTiHjkMQrK9bpiYCjuCDa9Ukbp9PgpUFlLLquvcPx1wy9uba1REzoDAD+HjTuX+D/mnjFcoeOKb6WP4=
Received: from MWHPR11CA0035.namprd11.prod.outlook.com (2603:10b6:300:115::21)
 by DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 15:01:08 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::43) by MWHPR11CA0035.outlook.office365.com
 (2603:10b6:300:115::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:08 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:01 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 04/19] cpufreq: amd: introduce a new amd pstate driver to support future processors
Date:   Wed, 8 Sep 2021 22:59:46 +0800
Message-ID: <20210908150001.3702552-5-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908150001.3702552-1-ray.huang@amd.com>
References: <20210908150001.3702552-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d178e28-10f6-4c7c-fce0-08d972d97d72
X-MS-TrafficTypeDiagnostic: DM6PR12MB3577:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3577B29CC775461C25269601ECD49@DM6PR12MB3577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXdRR3c7pnoptZp0IRPEphLFapq6xue5fLY30rttIkk8JrtFnIKG+XNh8Mq8vxmCXfbD2J2SbEsTJkkt2gppUqKWwq7+7At4gX80P6M3GTiyUkKqBXk8SLGCo4TSlwh2grsusTOK6u/vm1Vl5kBtZ73SdSLk8IprTntdz74r5+rww5s9/i/DkQQCvc6gM3uVWXMRtXxZho2PII3UOn+J++hyuqyyMbmEhXmOcvFughD3AFjaaiwxB4UgTx5SmztkK2H2KcZRvol0+jukXC37etjyibUuHRNr2Rodjlgmi3ATLfLdJ8r+dGOX5yv7xmvRAssS9LUmDJLN7G86gscsKoZXSFQEL4/FrLePyiP4v1tVTxNJmXrs+Ia9D/ibFwdkFh1teLU2+CTy5ldbgTm9M4T383YWGYzOHoPQJIl4AwOcEECgzqqEZJL/iQPUZtVWuakqlmLH7NxGOeLTBbJKN8Fl3v5RIyoiDRbx5fK83bXvX1WLC6l7T5b5XIrTWT2b7XziErjK9mG+4rVQ5rLjiUCoTkspRxYkRvuCv5QdxPoGUeoN9U7jZLQfWikAF9pKCJoZmNfvHnSceTd9ikv1LcPrha39d4eb7NW2A5I4m/cUjfDOXtsYZpdT6Vig3EhPDIXb3oP6hy/gJvLL73XGMPqXpM9aheEbCDMyRvV8HmcW43D8Nvikhh0mUuubROwhUSFINFmCcHQWFJURPFHs/ELG8KlgyBoQcSZsHOQ6YyhoS3X2/cF709eDRuGUhT17ZuQeqH7Cwl4GvRtiObb04L/AU4xk67652PvHub5uVb8/QevFVFWGq3Jm1K01dFyQeomahNYG3gNAmTwaQFrGzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(5660300002)(2906002)(7696005)(82310400003)(36860700001)(316002)(110136005)(54906003)(1076003)(86362001)(4326008)(30864003)(186003)(426003)(82740400003)(16526019)(2616005)(83380400001)(336012)(70586007)(8936002)(8676002)(70206006)(6666004)(26005)(356005)(478600001)(81166007)(47076005)(966005)(36756003)(2004002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:08.6154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d178e28-10f6-4c7c-fce0-08d972d97d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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
X86_FEATURE_AMD_CPPC_EXT feature flag to distinguish the different types.

Using the new AMD P-States method + kernel governors (*schedutil*,
*ondemand*, ...) to manage the frequency update is the most appropriate
bridge between AMD Zen based hardware processor and Linux kernel, the
processor is able to ajust to the most efficiency frequency according to
the kernel scheduler loading.

Performance Per Watt (PPW) Caculation:

The PPW caculation is referred by below paper:
https://software.intel.com/content/dam/develop/external/us/en/documents/performance-per-what-paper.pdf

Below formula is referred from below spec to measure the PPW:

(F / t) / P = F * t / (t * E) = F / E,

"F" is the number of frames per second.
"P" is power measurd in watts.
"E" is energy measured in joules.

We use the RAPL interface with "perf" tool to get the energy data of the
package power.

The data comparsions between amd-pstate and acpi-freq module are tested on
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
 drivers/cpufreq/Kconfig.x86  |  13 +
 drivers/cpufreq/Makefile     |   1 +
 drivers/cpufreq/amd-pstate.c | 478 +++++++++++++++++++++++++++++++++++
 3 files changed, 492 insertions(+)
 create mode 100644 drivers/cpufreq/amd-pstate.c

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 92701a18bdd9..9cd7e338bdcd 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -34,6 +34,19 @@ config X86_PCC_CPUFREQ
 
 	  If in doubt, say N.
 
+config X86_AMD_PSTATE
+	tristate "AMD Processor P-State driver"
+	depends on X86
+	select ACPI_PROCESSOR if ACPI
+	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
+	select CPU_FREQ_GOV_SCHEDUTIL if SMP
+	help
+	  This driver adds a CPUFreq driver which utilizes a fine grain
+	  processor performance freqency control range instead of legacy
+	  performance levels. This driver also supports newer AMD CPUs.
+
+	  If in doubt, say N.
+
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 27d3bd7ea9d4..3d4bd7141cf8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 # powernow-k8 can load then. ACPI is preferred to all other hardware-specific drivers.
 # speedstep-* is preferred over p4-clockmod.
 
+obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
new file mode 100644
index 000000000000..4c9c9bf1d72b
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * amd-pstate.c - AMD Processor P-state Frequency Driver
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
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
+	struct cpufreq_policy *policy;
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
+struct amd_pstate_perf_funcs {
+	int (*enable)(bool enable);
+	int (*init_perf)(struct amd_cpudata *cpudata);
+	void (*update_perf)(struct amd_cpudata *cpudata,
+			    u32 min_perf, u32 des_perf,
+			    u32 max_perf, bool fast_switch);
+};
+
+static inline int pstate_enable(bool enable)
+{
+	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
+}
+
+static int
+amd_pstate_enable(struct amd_pstate_perf_funcs *funcs, bool enable)
+{
+	if (!funcs)
+		return -EINVAL;
+
+	return funcs->enable(enable);
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
+	/* Some AMD processors has specific power features that the cppc entry
+	 * doesn't indicate the highest performance. It will introduce the
+	 * feature in following days.
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
+static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
+{
+	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
+
+	if (!funcs)
+		return -EINVAL;
+
+	return funcs->init_perf(cpudata);
+}
+
+static void pstate_update_perf(struct amd_cpudata *cpudata,
+			       u32 min_perf, u32 des_perf, u32 max_perf,
+			       bool fast_switch)
+{
+	if (fast_switch)
+		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
+	else
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+			      READ_ONCE(cpudata->cppc_req_cached));
+}
+
+static int
+amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+		       u32 des_perf, u32 max_perf, bool fast_switch)
+{
+	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
+
+	if (!funcs)
+		return -EINVAL;
+
+	funcs->update_perf(cpudata, min_perf, des_perf,
+			   max_perf, fast_switch);
+
+	return 0;
+}
+
+static int
+amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
+		  u32 des_perf, u32 max_perf, bool fast_switch)
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
+		return 0;
+
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+	return amd_pstate_update_perf(cpudata, min_perf, des_perf,
+				      max_perf, fast_switch);
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
+	int ret;
+	struct cpufreq_freqs freqs;
+	struct amd_cpudata *cpudata = policy->driver_data;
+	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
+		      amd_cap_perf;
+
+	if (!cpudata->max_freq)
+		return -ENODEV;
+
+	amd_cap_perf = READ_ONCE(cpudata->highest_perf);
+	amd_min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	amd_max_perf = amd_cap_perf;
+
+	freqs.old = policy->cur;
+	freqs.new = target_freq;
+
+	amd_des_perf = DIV_ROUND_CLOSEST(target_freq * amd_cap_perf,
+					 cpudata->max_freq);
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+	ret = amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
+				amd_max_perf, false);
+	cpufreq_freq_transition_end(policy, &freqs, false);
+
+	return ret;
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
+	u32 nominal_freq;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	nominal_freq = cppc_perf.nominal_freq;
+
+	/* Switch to khz */
+	return nominal_freq * 1000;
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
+	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf <<
+					 SCHED_CAPACITY_SHIFT, nominal_perf);
+
+	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
+
+	/* Switch to khz */
+	return lowest_nonlinear_freq * 1000;
+}
+
+static int amd_pstate_init_freqs_in_cpudata(struct amd_cpudata *cpudata,
+					    u32 max_freq, u32 min_freq,
+					    u32 nominal_freq,
+					    u32 lowest_nonlinear_freq)
+{
+	if (!cpudata)
+		return -EINVAL;
+
+	/* Initial processor data capability frequencies */
+	cpudata->max_freq = max_freq;
+	cpudata->min_freq = min_freq;
+	cpudata->nominal_freq = nominal_freq;
+	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
+
+	return 0;
+}
+
+static struct amd_pstate_perf_funcs pstate_funcs = {
+	.enable = pstate_enable,
+	.init_perf = pstate_init_perf,
+	.update_perf = pstate_update_perf,
+};
+
+static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
+{
+	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
+	unsigned int cpu = policy->cpu;
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
+	cpudata->cpu = cpu;
+	cpudata->policy = policy;
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
+	ret = amd_pstate_init_freqs_in_cpudata(cpudata, max_freq, min_freq,
+					       nominal_freq,
+					       lowest_nonlinear_freq);
+	if (ret) {
+		dev_err(dev, "Failed to init cpudata (%d)\n", ret);
+		goto free_cpudata3;
+	}
+
+	policy->driver_data = cpudata;
+
+	return 0;
+
+free_cpudata3:
+	freq_qos_remove_request(&cpudata->req[1]);
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
+	struct amd_pstate_perf_funcs *funcs;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return -ENODEV;
+
+	if (!acpi_cpc_valid()) {
+		pr_debug("%s, the _CPC object is not present in SBIOS\n",
+			 __func__);
+		return -ENODEV;
+	}
+
+	/* don't keep reloading if cpufreq_driver exists */
+	if (cpufreq_get_current_driver())
+		return -EEXIST;
+
+	/* capability check */
+	if (!boot_cpu_has(X86_FEATURE_AMD_CPPC_EXT)) {
+		pr_debug("%s, AMD CPPC extension functionality is supported\n",
+			 __func__);
+		return -ENODEV;
+	}
+
+	funcs = &pstate_funcs;
+
+	/* enable amd pstate feature */
+	ret = amd_pstate_enable(funcs, true);
+	if (ret) {
+		pr_err("%s, failed to enable amd-pstate with return %d\n",
+		       __func__, ret);
+		return ret;
+	}
+
+	amd_pstate_driver.driver_data = funcs;
+
+	ret = cpufreq_register_driver(&amd_pstate_driver);
+	if (ret) {
+		pr_err("%s, return %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit amd_pstate_exit(void)
+{
+	struct amd_pstate_perf_funcs *funcs;
+
+	funcs = cpufreq_get_driver_data();
+
+	cpufreq_unregister_driver(&amd_pstate_driver);
+
+	amd_pstate_enable(funcs, false);
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

