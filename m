Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF09456D7F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhKSKf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:29 -0500
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:31782
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231810AbhKSKf1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E519mPzdVwI9b7cS7TiY2CWxzuEhjWLoebZRXoNej+/sUQazeOSFDLPQn/nZjN7VrgGWzhQrGX1oLtui8nBYpG5kVpuSZJsF3ndxSxLEJGz2gUxa0o0GEAwqeyIjjrZuwhBZ3hWrHmvRrpOmJr9HX3hV/K7jFQgTn1rnrtv12bkZ5abnliO4JWWF9Khnkv9/9m1bRnX9jwp4oI0H80XBNwZxRnjG2gjaNnWzghzT0P3e9xTqNtX2QonJviHXW6hrO1ye3P+YtPvxWF9IGn93rThmRCe2oC3eMpWMEYS85dz4zvOTBzYVFH1NtjBCCDak4McibzMO4fs4ulfeEyr/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAAodE0I7jDc6mG4/vVSun+91fZPipK6LmbAHp3jZfI=;
 b=bFGuBtQOsuzsECFOny1gqU201yIhD/fKBk4WBMDzj+aLXUML7IqM/MMoBfQp7Bvn41pY4FXSvbCoSKWNOJNwYNvzQ5q8Zkr+qwjQlwHqGUpLAo19Ic23NXNk3O0oXywxZSn6Ad9oLMcrob5W7ZQOH650kuuhbRnTDjpH7qF0mg85nEN6K95xIscGrU2KGQHX5uOMQceEwxRSJiVNs4XgROlpfaU8LxR5+t1aWUStV8twsTQLYgHamg8eEH1SCOl/KHoEnq95DXN60KOu7dowlxQgrhjZ9qKKSVXN/fIYKXLBuGFgWknJHKwxFzeRTctDsERgU5QZuwuWNGU9KDEnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAAodE0I7jDc6mG4/vVSun+91fZPipK6LmbAHp3jZfI=;
 b=U3nO9oXlBMHL49ZU+qSJvkM5hP51CU6Ux3w5n501aL4ykkxJxoMyS6W+BkvwI6JsgCC2IAnPxz+ehsxAu3ngNkB3+NzPbeP6g8niAGqLi3PoB54wQBnj12iV5eEgCTTM/EnNUyH4vxUCa2COJuS7hqkZnALDrbpsWj+QqN7xnlo=
Received: from DM6PR04CA0030.namprd04.prod.outlook.com (2603:10b6:5:334::35)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:32:22 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::3d) by DM6PR04CA0030.outlook.office365.com
 (2603:10b6:5:334::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:22 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:17 -0600
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
Subject: [PATCH v4 09/22] cpufreq: amd: add trace for amd-pstate module
Date:   Fri, 19 Nov 2021 18:30:49 +0800
Message-ID: <20211119103102.88124-10-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b1e598e-2c5d-4672-ebbe-08d9ab47deef
X-MS-TrafficTypeDiagnostic: MN2PR12MB4440:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4440D2F0CBF7BBB294DE59E8EC9C9@MN2PR12MB4440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQPIL2f+8sQuc31q7k83wM3OAHN1ODmZgpyJXSsp9j4jvFCqfWlIbPhGXIIsrvNUpaQLTlC1WGLmxeQ4kkTZ0DfgJbjf+AMcuNVXUjBi5wAvSvHKZOFswV0MkbuCkdinv06Gr8x/oNFISp2PB7f2QAUheQVjttGJh2f9e/gTN/Y7o8qxjfQ4Odr112J/kI3LdQhDk86hSTbmFOgjxeG8UyLKR4Kq6skydkTSwT+Eh7lhexHtc/yokp0ljq7jVbTwQ6Fo6jCkXBAFCbbdv8GlTeCNUcSwNYmmoECLlMBmOTWKgQEk6sMuksdRQGmlacTfsTqo/1gBXJHA6TacKf77eKNHBmaE3BWl82WeSpigxvN9STxktiqC347jwAyuA9QyGgSE4cte9Rt3YqP1cFToCvihwiZVUtEIg4JXkzT6aa4Zf2jcPbG08Qs5wRPjlUefsl0k61a7J/ogiHEKA7FMp/LCHcZsXoJIx6XXAwdpMK0e+lXMrTk2TG0kF7PdUovVMb4HABw0xST0qggWAXZObfRYXl0CkjgJTcrsh+mj64Z957iTiuZlVRnB+ojYsrOcFsguNynM+dVQXBxGZhKeGCCJig7JHjFWSG9Vo247vczWRkESdXumuGgA3JN5C3Dmh7HeSGaAD/JYjY0TJynR1MCYQn+8QPq605Cvn39ebVIF5oazM54Kji3brwsVpfynI6LEnkMLSDdHaucRo/7fWKK/WRKvFTy9ilcoGR2E/Wc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(54906003)(316002)(36860700001)(36756003)(110136005)(8676002)(8936002)(186003)(26005)(5660300002)(83380400001)(16526019)(86362001)(4326008)(336012)(7416002)(47076005)(356005)(70206006)(426003)(2616005)(70586007)(6666004)(7696005)(2906002)(508600001)(81166007)(82310400003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:22.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1e598e-2c5d-4672-ebbe-08d9ab47deef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add trace event to monitor the performance value changes which is
controlled by cpu governors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/Makefile           |  6 ++-
 drivers/cpufreq/amd-pstate-trace.c |  2 +
 drivers/cpufreq/amd-pstate-trace.h | 77 ++++++++++++++++++++++++++++++
 drivers/cpufreq/amd-pstate.c       |  4 ++
 4 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c8d307010922..285de70af877 100644
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
@@ -25,7 +29,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 # speedstep-* is preferred over p4-clockmod.
 
 obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
-obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
+obj-$(CONFIG_X86_AMD_PSTATE)		+= amd_pstate.o
 obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
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
index 000000000000..647505957d4f
--- /dev/null
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * amd-pstate-trace.h - AMD Processor P-state Frequency Driver Tracer
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
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
+		 bool changed,
+		 bool fast_switch
+		 ),
+
+	TP_ARGS(min_perf,
+		target_perf,
+		capacity,
+		cpu_id,
+		changed,
+		fast_switch
+		),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, min_perf)
+		__field(unsigned long, target_perf)
+		__field(unsigned long, capacity)
+		__field(unsigned int, cpu_id)
+		__field(bool, changed)
+		__field(bool, fast_switch)
+		),
+
+	TP_fast_assign(
+		__entry->min_perf = min_perf;
+		__entry->target_perf = target_perf;
+		__entry->capacity = capacity;
+		__entry->cpu_id = cpu_id;
+		__entry->changed = changed;
+		__entry->fast_switch = fast_switch;
+		),
+
+	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
+		  (unsigned long)__entry->min_perf,
+		  (unsigned long)__entry->target_perf,
+		  (unsigned long)__entry->capacity,
+		  (unsigned int)__entry->cpu_id,
+		  (__entry->changed) ? "true" : "false",
+		  (__entry->fast_switch) ? "true" : "false"
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
index 14a29326ceae..5e080d0dc45f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -31,6 +31,7 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
+#include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
@@ -189,6 +190,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~REQ_MAX_PERF(~0L);
 	value |= REQ_MAX_PERF(max_perf);
 
+	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
+			      cpudata->cpu, (value != prev), fast_switch);
+
 	if (value == prev)
 		return;
 
-- 
2.25.1

