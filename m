Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DBA403C24
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352042AbhIHPCo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:44 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:22880
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352028AbhIHPC1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1Psp6lPRCpVsDKtE/HCN2+EmQ8Rzr1QZrBQNaitHSfYOXAxYmhIo2DymvoNR4ILH1O0oza5TG7bCcAF6kHMI0xEydpPRHUOEDnlb13ZBydzaGQWQyUL/AszpSvcTUJTKkykFZdoUgkfUY/c4crsWn40f0+LicQMIaZgUPCvXy/f0xIG3l7uIrjTI1ibRQhR69wui4UIr72IAD6h9gwYjs11kR6v0Jj7d3dqZ8p2va2TAFFWoaqUaQpxEgvcvuQi5xSZKRVfgqXCr6SjSrIFViA6KOLFBiIR4tmoZad1jES/twpprvgbWyJeGvDmj4QtdpNnuOREcVfLqUejchgsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+MMaxpoA1pj2VeOMvmf+vhiHZubtbC+jmD+2ab7dzMw=;
 b=Z4CQKR0g2jglvfZbxG02QOvnp2mOcSSSWTVm5nkTtsfaqgRoIBZdd5ydeoNPFQ/Vrh5yWs+xaumVhrlq0j8IeRR2zyXZP6AYXE/0LeWSnQe5MRipGwiNPp33uZuOsunwr9gc7765+4EGho0+eOBYz8faRWTwmEcWVrqNddEyx2wDawyckHaB4GociMXjqLb0JVwpAs1p1vTlAiKzwgjMskV/s12lnhUCImHEzEGu2/bpWjv0uxFaPJ4Rsr2w33wtgvM4weT64gp9Jk5ba5FesAyOxEUH2bHXJWbgIFFoBxMreG+W2D06f9BTwVM73J8UDLNVkDt2npuvYz+O34816g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MMaxpoA1pj2VeOMvmf+vhiHZubtbC+jmD+2ab7dzMw=;
 b=48hLxwtudvXY0JHzMSVbhB7Z037J14s7OWM1YDq5zdmy5fveiHyX2Walh5FpcDIXulQseT8ANFZM9va2XKtBkvQJqPnuNfjwIcBT+MqQuuV87x9miy6D/beyCJFq8c0YtdpJpgAZuhAOeQVct6FYoXrHipJGcEdrgQQbKZipgVc=
Received: from MWHPR11CA0037.namprd11.prod.outlook.com (2603:10b6:300:115::23)
 by DM6PR12MB2764.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Wed, 8 Sep
 2021 15:01:17 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::ca) by MWHPR11CA0037.outlook.office365.com
 (2603:10b6:300:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:17 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:12 -0500
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
Subject: [PATCH 07/19] cpufreq: amd: add trace for amd-pstate module
Date:   Wed, 8 Sep 2021 22:59:49 +0800
Message-ID: <20210908150001.3702552-8-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9edc7ddf-d191-42c8-d58c-08d972d982a0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2764:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27640B05C6915F8B5FF16B58ECD49@DM6PR12MB2764.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXd8Mc6kegzy5iogNlL0Uqw97i3z6/4cIN9JjJpa/VFQrTyyiNUYcCWnLK7Zwmff7+Hz0Gyq6PbBDltvmMVdKhrW9uN0JUriTnpTd5YUtzpOz4xz/yPSlzZ8zzkKNegIYRuEn6ty/pKGdH1qV99MI/bwf8Xn6sEg61IWZYqFlIUjg4blY9pH/dVGHWGlJik28p0r4B+2nERgYcjkZkTjD3boEWJcw4+GaA+JfW/iKeCSQoavWzDUUwmyu5rmG2+2ZMGYpxrqNy6L0QglGUNiDXJ0SuuKXCcrf15Wc2/BQQaKiTu51KcE0xhJ3YKR7ymZHQSeWwZk25jjrb22z7iEPWZQo8m9zUlzn0emi0JxCiCB0B4s3xnkrF8A4rFtwvxEuVDNWV2Ub4dtIUDBtITuvchNPIqoWlzA/hafNubcd9/bxN2azMQu0BGr6isGxUu/JW4bMoTNXLuKpBD2DXaa7qeo76/gVGsIMFPY1oNi0nqi4xfNb5pdtkVylHMOQky3I0nHGpGda+9JeScfox3nHZvFUwlR+R8XOjVO7ee0nruxZid09CAhs6XHljnmCXaWU2UwP+WwMKZeg/L8aqu4vipYoc1PdUTHWHZWvTi5WWpFL71DB5TMCdZy8HGrgwLKpb2CEKwncJ4MMnmBR1rICZBcf1ybqQTzI0eOruschkGTAi58+jp3ctgH/RTmc1ITMtdjUImVO1VvZqSm89oL5qLfGMCMa8Xi9p3+0Vr7mPARO5izEJRNWvixK0sU/JgO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(82310400003)(8676002)(70586007)(4326008)(186003)(5660300002)(36860700001)(336012)(70206006)(86362001)(2906002)(2616005)(83380400001)(8936002)(426003)(6666004)(47076005)(16526019)(36756003)(316002)(82740400003)(26005)(1076003)(110136005)(7696005)(54906003)(81166007)(478600001)(356005)(2004002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:17.3034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edc7ddf-d191-42c8-d58c-08d972d982a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2764
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add trace event to monitor the performance value changes which is
controlled by cpu governors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/Makefile           |  6 +-
 drivers/cpufreq/amd-pstate-trace.c |  2 +
 drivers/cpufreq/amd-pstate-trace.h | 96 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c       | 19 ++++--
 4 files changed, 118 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 3d4bd7141cf8..c1909475eaf9 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -17,6 +17,10 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 
+# Traces
+CFLAGS_amd-pstate-trace.o               := -I$(src)
+amd_pstate-y				:= amd-pstate.o amd-pstate-trace.o
+
 ##################################################################################
 # x86 drivers.
 # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
@@ -24,7 +28,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 # powernow-k8 can load then. ACPI is preferred to all other hardware-specific drivers.
 # speedstep-* is preferred over p4-clockmod.
 
-obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
+obj-$(CONFIG_X86_AMD_PSTATE)		+= amd_pstate.o
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
diff --git a/drivers/cpufreq/amd-pstate-trace.c b/drivers/cpufreq/amd-pstate-trace.c
new file mode 100644
index 000000000000..891b696dcd69
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate-trace.c
@@ -0,0 +1,2 @@
+#define CREATE_TRACE_POINTS
+#include "amd-pstate-trace.h"
diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
new file mode 100644
index 000000000000..50c85e150f30
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * amd-pstate-trace.h - AMD Processor P-state Frequency Driver Tracer
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
+#if !defined(_AMD_PSTATE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _AMD_PSTATE_TRACE_H
+
+#include <linux/cpufreq.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_events.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM amd_cpu
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE amd-pstate-trace
+
+#define TPS(x)  tracepoint_string(x)
+
+TRACE_EVENT(amd_pstate_perf,
+
+	TP_PROTO(unsigned long min_perf,
+		 unsigned long target_perf,
+		 unsigned long capacity,
+		 unsigned int cpu_id,
+		 u64 prev,
+		 u64 value,
+		 int type
+		 ),
+
+	TP_ARGS(min_perf,
+		target_perf,
+		capacity,
+		cpu_id,
+		prev,
+		value,
+		type
+		),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, min_perf)
+		__field(unsigned long, target_perf)
+		__field(unsigned long, capacity)
+		__field(unsigned int, cpu_id)
+		__field(u64, prev)
+		__field(u64, value)
+		__field(int, type)
+		),
+
+	TP_fast_assign(
+		__entry->min_perf = min_perf;
+		__entry->target_perf = target_perf;
+		__entry->capacity = capacity;
+		__entry->cpu_id = cpu_id;
+		__entry->prev = prev;
+		__entry->value = value;
+		__entry->type = type;
+		),
+
+	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u prev=0x%llx value=0x%llx type=0x%d",
+		  (unsigned long)__entry->min_perf,
+		  (unsigned long)__entry->target_perf,
+		  (unsigned long)__entry->capacity,
+		  (unsigned int)__entry->cpu_id,
+		  (u64)__entry->prev,
+		  (u64)__entry->value,
+		  (int)__entry->type
+		 )
+);
+
+#endif /* _AMD_PSTATE_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#include <trace/define_trace.h>
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a46cd5dd9f7c..ea965a122431 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -44,10 +44,18 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
+#include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
 
+enum switch_type
+{
+	AMD_TARGET = 0,
+	AMD_ADJUST_PERF,
+	AMD_FAST_SWITCH,
+};
+
 static struct cpufreq_driver amd_pstate_driver;
 
 struct amd_cpudata {
@@ -195,7 +203,8 @@ amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 
 static int
 amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
-		  u32 des_perf, u32 max_perf, bool fast_switch)
+		  u32 des_perf, u32 max_perf, bool fast_switch,
+		  enum switch_type type)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
@@ -209,6 +218,8 @@ amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~REQ_MAX_PERF(~0L);
 	value |= REQ_MAX_PERF(max_perf);
 
+	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
+			      cpudata->cpu, prev, value, type);
 	if (value == prev)
 		return 0;
 
@@ -250,7 +261,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 	ret = amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
-				amd_max_perf, false);
+				amd_max_perf, false, AMD_TARGET);
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return ret;
@@ -288,7 +299,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 			       amd_min_perf, amd_max_perf);
 
 	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
-			  amd_max_perf, true);
+			  amd_max_perf, true, AMD_ADJUST_PERF);
 }
 
 static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
@@ -308,7 +319,7 @@ static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
 				    cpudata->max_freq);
 
 	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
-			  amd_max_perf, true);
+			  amd_max_perf, true, AMD_FAST_SWITCH);
 
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	ratio = div_u64(amd_des_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
-- 
2.25.1

