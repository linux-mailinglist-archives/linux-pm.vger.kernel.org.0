Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8A456D8F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhKSKgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:36:05 -0500
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:38907
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234855AbhKSKgA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:36:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAidMHGEGbX4hNdA2ZHMXr+FwE8VwJ7tMpXhkNeYbWt1la7i6MBS7sCS9ifyn4OI9dPqrtiQ0HUwkTcYuoa7JF2Nid3J0E5ZPgyzxTMzlbYO92u6vJLjSpzQUsVdNU6I6p7EgZazYICQJP73N8RSu0nqBUMHndVguFQj/aoDcGiyu3tELFKboL+sIvgq7Y6HeAOno3ni8w16ipLz+YZ4va+GHx1q31r9E3+Yujd21dQ9rRWMva1x+hZgEPNFH4MimUdA4OPYvcrnDKQ1guAo78efzCm4qpLjlhlR8Ege0QKjz6Ol/Upgp20bo2Hs8qnVU9LvR1ym4M1Kz8e7npmIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k/zus4Ykvg9YQ8ScAPNoaxGrxYCilniKi+hCW4Rdes=;
 b=NRD6epBbq9JLpWRr7wLFcMlQK0oRZeQ0r940lNlqyFgH+eC4Lq09c7GHurI1uksjT8G0Vi6yJ/D82R3Xk3NYtwPWBj2ORPUgQ91BrJUVRwCLuxBRno+vQB6NvoGEgFFUE+Jbd0Iq/0BiyE80hDL4IIiFljtRy00cC3OeyhBolN+xMxJjk7KSLc+/HZg5xwYYmOUgN0XEiS9vCvUWNE7mIl7KEi/quL9mPFTkCjcHGlJeOCJIxgwIoHur9bDKv7xcvLDEL9pQlORL12mK9s60JEbSK0mVbLyiR9BuvoU34uIhniMUvzYrvpAhup2QZAn4jGAht4qRyDbsph2gDTDfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k/zus4Ykvg9YQ8ScAPNoaxGrxYCilniKi+hCW4Rdes=;
 b=GBAQk8LzDaScKUnbK62VCz2y6IVf63u/HSYuznQxlRA3u1Ad/3FLpRxeGqZABkbd1u75/Kb5XKHu0hTNarnP0Z1by1mDE03WUfJH3JNz49sBFnSq0TX0flRrz5rDSTP02P0elJdnCQloDm3gpL+inYijBOF/ghKhEbTdWHk7VT8=
Received: from DS7PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:3b7::6) by
 BN6PR1201MB0033.namprd12.prod.outlook.com (2603:10b6:405:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 10:32:57 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::aa) by DS7PR03CA0091.outlook.office365.com
 (2603:10b6:5:3b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:57 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:52 -0600
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
Subject: [PATCH v4 17/22] cpupower: introduce acpi cppc library
Date:   Fri, 19 Nov 2021 18:30:57 +0800
Message-ID: <20211119103102.88124-18-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d11edec5-ce19-4fa0-01b2-08d9ab47f3eb
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0033:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0033AE748CA042D345A623A4EC9C9@BN6PR1201MB0033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ns38yTMLH+1IdlTN4x7N9gPvLTmc1suGAoilN3uylLkBqBQJJf3KQffHOPTCOzPhqXgsE7YK2ImhbnaV2U8m0xw9bILxiR9fIMUT6VBtiNaDnciLcxn15NoJ31bR8McT3AvQ8Qi4z2N1O+1Q+f/8TBxxmmRzTIH0TkZ1pTbwIxYHoxwxJQQfOykvZEPTF6WsMr8CwV1N3u0hygdTDnkDo6KT2WHqZGUOf8kuJFf7j4vltfXPprS6obhvuqh27MQPQ2rC4okafbHW3PTQVFG3gLt6chGuMLu4kwmx6qJEvBIebMGlS0I4Z7MRwDarMRm8fKwE+9MZN/wl0Ch2DNOpObHZb4ZNmKcGIx61+4cLpo6IwCr+sthlM3U8iHgHI68wjyUFCmX/C6Fhh8dHKXRWjC6SJCuk3Z/odJfhXXHZh05Pv4tqarZn5+qVfpbbpubgm6e7QeGYmE4Sl6DIjnRCRmqQnMGh/z03m0gthXbaQw8NkqTkAqGwfsoJBg0OOBHFBk8W2WI4Pxv9NAE+fb++B2ECgh5oBbyj78YzrUZtXjJf4EujxJaJid8WaQzDfMKMPhw7sLiT5N58bwoc3vZq58EB20PuPELr1qQFptBSc2zmiftEUF+9zLkGUcSJgo8jTZrWQzaDyzDNPtuE+IWL/36RHJI/wsFEs8uyovcnVmRb7fnw0RKHWZ0tVut/DMvei9mL2iuiTwgdxQfSe6KMdYKY7h3GFOI/K/R6o9VZOsg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7416002)(1076003)(316002)(7696005)(2906002)(426003)(70206006)(508600001)(356005)(8936002)(8676002)(26005)(5660300002)(110136005)(81166007)(54906003)(4326008)(186003)(86362001)(36860700001)(36756003)(82310400003)(47076005)(83380400001)(16526019)(2616005)(336012)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:57.1888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11edec5-ce19-4fa0-01b2-08d9ab47f3eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0033
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Kernel ACPI subsytem introduced the sysfs attributes for acpi cppc
library in below path:

/sys/devices/system/cpu/cpuX/acpi_cppc/

And these attributes will be used for amd-pstate driver to provide some
performance and frequency values.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/Makefile        |  6 +--
 tools/power/cpupower/lib/acpi_cppc.c | 59 ++++++++++++++++++++++++++++
 tools/power/cpupower/lib/acpi_cppc.h | 21 ++++++++++
 3 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.h

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 3b1594447f29..e9b6de314654 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -143,9 +143,9 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/cpupower-monitor.h \
 	utils/helpers/bitmask.h \
 	utils/idle_monitor/idle_monitors.h utils/idle_monitor/idle_monitors.def
 
-LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h
-LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
-LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
+LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h
+LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c
+LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
 override CFLAGS +=	-pipe
diff --git a/tools/power/cpupower/lib/acpi_cppc.c b/tools/power/cpupower/lib/acpi_cppc.c
new file mode 100644
index 000000000000..a07a8922eca2
--- /dev/null
+++ b/tools/power/cpupower/lib/acpi_cppc.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "cpupower_intern.h"
+#include "acpi_cppc.h"
+
+/* ACPI CPPC sysfs access ***********************************************/
+
+static int acpi_cppc_read_file(unsigned int cpu, const char *fname,
+			       char *buf, size_t buflen)
+{
+	char path[SYSFS_PATH_MAX];
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/acpi_cppc/%s",
+		 cpu, fname);
+	return cpupower_read_sysfs(path, buf, buflen);
+}
+
+static const char *acpi_cppc_value_files[] = {
+	[HIGHEST_PERF] = "highest_perf",
+	[LOWEST_PERF] = "lowest_perf",
+	[NOMINAL_PERF] = "nominal_perf",
+	[LOWEST_NONLINEAR_PERF] = "lowest_nonlinear_perf",
+	[LOWEST_FREQ] = "lowest_freq",
+	[NOMINAL_FREQ] = "nominal_freq",
+	[REFERENCE_PERF] = "reference_perf",
+	[WRAPAROUND_TIME] = "wraparound_time"
+};
+
+unsigned long acpi_cppc_get_data(unsigned cpu, enum acpi_cppc_value which)
+{
+	unsigned long long value;
+	unsigned int len;
+	char linebuf[MAX_LINE_LEN];
+	char *endp;
+
+	if (which >= MAX_CPPC_VALUE_FILES)
+		return 0;
+
+	len = acpi_cppc_read_file(cpu, acpi_cppc_value_files[which],
+				  linebuf, sizeof(linebuf));
+	if (len == 0)
+		return 0;
+
+	value = strtoull(linebuf, &endp, 0);
+
+	if (endp == linebuf || errno == ERANGE)
+		return 0;
+
+	return value;
+}
diff --git a/tools/power/cpupower/lib/acpi_cppc.h b/tools/power/cpupower/lib/acpi_cppc.h
new file mode 100644
index 000000000000..576291155224
--- /dev/null
+++ b/tools/power/cpupower/lib/acpi_cppc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ACPI_CPPC_H__
+#define __ACPI_CPPC_H__
+
+enum acpi_cppc_value {
+	HIGHEST_PERF,
+	LOWEST_PERF,
+	NOMINAL_PERF,
+	LOWEST_NONLINEAR_PERF,
+	LOWEST_FREQ,
+	NOMINAL_FREQ,
+	REFERENCE_PERF,
+	WRAPAROUND_TIME,
+	MAX_CPPC_VALUE_FILES
+};
+
+extern unsigned long acpi_cppc_get_data(unsigned cpu,
+					enum acpi_cppc_value which);
+
+#endif /* _ACPI_CPPC_H */
-- 
2.25.1

