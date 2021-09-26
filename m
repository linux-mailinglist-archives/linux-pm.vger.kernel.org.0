Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0EC4187B8
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhIZJIh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:37 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:12042
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230141AbhIZJIa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1ujwcXshRdsxreNZ7lzoe2f+MxfBr4OLADNhYlX2SqGAaMA90j4DY6qIGnsIp7OhVxAuvvU4xQZL025jpWeFm8Hku5C274/LZAjrwH7TouQBctgQQBauK9pbpZvQ6exjfduYGtrCG5lQIjl2jDKT93p4nEGYKXSg2ZdDs1TgwVgLgfF2VM6AyYKwIowvJi66H+BsFAc98cqoCilVhxBa6MNaLKiM1tvuPEcZM5CVFDQepRlqkOdI847lCTZ1K4YdP+qVCGTiEWK8Xpd0SjZK45T+SR4CmeugngD6zy72EDzbB1BRxgRGTGsWYgh9TrqcqFyNA6C6GAxsROdP5PBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Crpl+++cdS4ZNvFSwl6aILfpX50nJQedkwwHL/y/3w4=;
 b=AEpBbeSXRj/RPCoZt/3j6jAT14JgR77w4NNHL4UHlayIkqdTlstKBPwMOFtJcEGlQgvJIh11Fk5ChZwmYO9/LSH7b1DRmDkFNxiSXe5cIXDQ7z1H8xwtZiqu4GXzuZ8rHJK2CMRJYM3/xAfPZbzIVU/gqFNcDz9aJ+FQ5fWkQsVZoin5qtsUo4Y8Bzvj3zQ9lAPbxrhBYwMEOIgyhHfiqD3E0oZmfFRlXSZsBinwrnpt/V7usWuPJjIGyvtKXzN8pXoE80EGK3f3jQ8G0Qk5jW8e3KrC6dpclCgaQKwE4hH4ITCFOXzt31uywi7ZXv0V7zyMpYhtpzjU5h4OeJjm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crpl+++cdS4ZNvFSwl6aILfpX50nJQedkwwHL/y/3w4=;
 b=LHd85iiBlup5MHGdDBgx/lG41ERqYHIxgOWJkRQhQaHs33ttYd8V9nIuBO+peT99bwfN7jdYIibY8dRVppThZCJGuHhfupBMosEsaf7sSTmuvYusRGwtQgJVAlpD26JdHnqHJyFc39K6NzOG/ip+0rFBHysC049xUtuXuBjUM5I=
Received: from MWHPR1401CA0022.namprd14.prod.outlook.com
 (2603:10b6:301:4b::32) by DM8PR12MB5493.namprd12.prod.outlook.com
 (2603:10b6:8:3d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Sun, 26 Sep
 2021 09:06:52 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::76) by MWHPR1401CA0022.outlook.office365.com
 (2603:10b6:301:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:52 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:46 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 08/21] cpufreq: amd: add trace for amd-pstate module
Date:   Sun, 26 Sep 2021 17:05:52 +0800
Message-ID: <20210926090605.3556134-9-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926090605.3556134-1-ray.huang@amd.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66761513-9105-40f2-5c9f-08d980ccfafc
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54932638B959B1EBE7F69804ECA69@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbaF//Ok+N5bHjUBGicKVmi3PmHzZYVdFEDAQb16bHrQjmlNQkmc1RIOKvWYWH+eWuLkh1htEmUuqUdYEwp07HdJnkULIc9asQx429aanNhBgj8t06bcOiTpMNU3VR3DFgNE0DxtvP3wLdtnVBKBoePR4PDLJczWdiltPzkg/2qFcLsmnQO+tv08ZYvPdQJ7+0sEA83LWACBGvco7s5CQNhflXIzGYCoSvikTMqnzTyKZ1WvR3lgw7VH1cHPEPP1VTlHRmaNQG0qMmzu/HgY2cEq2amyDCSlE3bhgbhREYj7KARPjr4dPP6/qe2+i8z/ghOuM9p+0EGXZZtt5pr0b8zlcW2MaS3UpSnXt5IliFA9KCdTleiHqZGq2/zJpfIf4s+aVJpUjnffBGOAFka0CrVK+4IOqcWQFO73fmA9XL85QjD7pZJZZUXzVO/wlhqnmE7UnM4jJusOvP0mEzJyjlbrQeTzLcrEY7sWj7eyb/jZPGmO6JHAzZgqn6dPRcTAPpzb8r3Duh61kgMmacWo93+gREq9ZQ21x1kAFouD2J4WlAzg/3/XLXE64e4aO+j/iaqQdmre+rITgiuyPZ3E7PKGfxSmtbgvIKlOrHyq6aOM7NG4/9cFPtkSPz1nYoxxyksWXTtcxKi5TAXrwagn0g9l/2qx8aADnI+SQaV67Q9/3C35QzrcPwqg/6QSiYgOcD2J5SOLDoDAAHP1apUuBZaZf2WhEcgJq20gzpFS5EcWDkKbGK1reAZvKB+7cmOm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70586007)(70206006)(7696005)(36860700001)(47076005)(8936002)(508600001)(6666004)(82310400003)(2906002)(186003)(36756003)(83380400001)(2616005)(1076003)(5660300002)(54906003)(426003)(8676002)(26005)(16526019)(86362001)(336012)(81166007)(4326008)(110136005)(356005)(316002)(2004002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:52.0703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66761513-9105-40f2-5c9f-08d980ccfafc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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
 drivers/cpufreq/amd-pstate.c       | 11 ++++
 4 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 5c9a2a1ee8dc..04882bc4b145 100644
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
index c9bee7b1698a..0c9f9c0c8928 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -45,10 +45,17 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
+#include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
 
+enum switch_type
+{
+	AMD_TARGET = 0,
+	AMD_ADJUST_PERF
+};
+
 static struct cpufreq_driver amd_pstate_driver;
 
 struct amd_cpudata {
@@ -183,6 +190,7 @@ amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
+	enum switch_type type = fast_switch ? AMD_ADJUST_PERF : AMD_TARGET;
 
 	value &= ~REQ_MIN_PERF(~0L);
 	value |= REQ_MIN_PERF(min_perf);
@@ -193,6 +201,9 @@ amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~REQ_MAX_PERF(~0L);
 	value |= REQ_MAX_PERF(max_perf);
 
+	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
+			      cpudata->cpu, prev, value, type);
+
 	if (value == prev)
 		return;
 
-- 
2.25.1

