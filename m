Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23943FD0B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhJ2NHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:07:48 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:21345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232040AbhJ2NHO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUMrfk82SJ74GSzyN3Lt4RIRENNRsmAkLq/AAERjBiS61BaKXoCf5DKmes899yyAyVrKoMsZQiWxgXkG5oCXYyjtkTvEc3WwpohcByvuLUBDBGoW7M5DykrT6QTB00Is4gCHypJZNkWO4qcW+d+BCQUvIGg8q279xCecsgIQvuGOz1x7zwKYYOb+uW5gjOGi/YAbdZIUOJdE0SnLBorB4s6LkBGUK8QhaRzaYHVDtmaG+dRYdCzvSgLbLQ9Ng3Ud5LSjBzlap49MECiXsKwZxKOw7tj7iytdwXsEgqNbHwHwoBgE0DpvA5Pl6iTW5BO79emiuy196y2nNSfnadJAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETquVncU506XWbqhhCDbmpNtGFTe0qd5JCgu9D9iaJo=;
 b=dkHgvGONWXPefDmz5DLw9rlnahxQCMFVNhfq7H4xXhA0oNApnECbwjMKRQKsuAE2bhtjxaetSDv11nrUQeYye1TrmBQEDz0/E604ThD8NCVxHbSPZjai7x/FRuJ68HaJMCshVQGjmCN4ao6a0DIUgUZlTFATJrTYlV0vFHWvfXqct2LpuXX/NS8boCWUqpIVfflms1L0iwHA8A9SKOZ1nY2Txm/GwcdCrKu+cm0qVlD1GjgvWMLAK4K7gdyHfF8r1WJTume8IwPlFF1ldXOgAx7oangPddBGhZUeLpUNITDc7HE3ShDaoUgi9vWDJt15wNNkacD88MTRWhe1Ddu2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETquVncU506XWbqhhCDbmpNtGFTe0qd5JCgu9D9iaJo=;
 b=ub8osPgLudDupegf2XG6jRHSpoPHgTy3uzkU662Kzxo7Fpk77QoA3/ApLiybbMG3MDRgREvXDeFtiFxTu6UarZQenDNENQW2m4uV200A/68mmQy/X9k9PmM5+A590A4V7AccIL1aUgW8LKohLmBgdiK/efsGaza75swyoUr0mHk=
Received: from BN0PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:143::18)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 13:04:42 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::34) by BN0PR10CA0004.outlook.office365.com
 (2603:10b6:408:143::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:40 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:35 -0500
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
Subject: [PATCH v3 17/21] cpupower: add amd-pstate sysfs definition and access helper
Date:   Fri, 29 Oct 2021 21:02:37 +0800
Message-ID: <20211029130241.1984459-18-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b186e00-9c2d-4041-bd2c-08d99adcab78
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24480F58386CBF77731633E7EC879@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqkEQXe/S6CL7n6V9uvv/ARrNkwu6BR80nGZfWUejGPR3HKfxakM7dLXOhaIM61OjL5zab59JeDCMmYbSIvgoJj+CUTAIR+2v+BYdf7Ecqdohiw6IuqJrczQhZeaZER2VH3RIhqGgNGlSfJJfj5F/rp7xn55jexxLw+SsqxB5QVU9VAMUVpiye2FDfdrOkjTk6jA8CStN5AlXRW5gRrAsQ6TrbjdqjcYqcQgqiYAUGaHML6fWFDWNzXyBUzxEwyMUEdS6erC+w3RNn3MS5i90lr6d7vcTcWDRCzZpLghxl83bohuEEtQ1rcfbmSIzUB19QT8fF6MJa2Pq3HaMpxWSBsu9UMkxrSiMY4S+r3k4QNit7o2EDzmYiQuIGc3AS+CnNvgd7J8sE5QCLHegurmtz1B99FxYoVoul1jkZg4w+1J6YUlN0XnXG/TqcAQYr4yAGq9WdFzqKyiq63arlS6cw9WwiQ2bcTlRRxkFR8FCKfMEWTbq+puBTyNVWhYILb9rP8BToCYh9qUaMKHD/Q4IfwsdpK8pflAiHFaNVVs+EncUy3Np8P+LWxqXv0rku8gaTUG4RwmqbkMLcmxkHkx3//T4qGwso38ElQ4scqpG+IBNbSYejgX8XfxIGGzvmR10K8eutD6dUrG6mJJPFlp7Q1WghyoGKjB4fnUVLAlWhanupxkp5W2SdUUINsbUzUQWAGsbXwmu0mQrwkejojPRE6cJ5yOFKBUp4gK8aDKxL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(5660300002)(508600001)(83380400001)(8676002)(16526019)(82310400003)(8936002)(1076003)(70586007)(54906003)(2616005)(36756003)(2906002)(81166007)(26005)(426003)(356005)(47076005)(110136005)(316002)(336012)(36860700001)(86362001)(7696005)(186003)(7416002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:40.9505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b186e00-9c2d-4041-bd2c-08d99adcab78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the marco definitions and access helper function for
amd-pstate sysfs interfaces such as each performance goals and frequency
levels in amd helper file. They will be used to read the sysfs attribute
from amd-pstate cpufreq driver for cpupower utilities.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 97f2c857048e..f233a6ab75ac 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -8,7 +8,9 @@
 #include <pci/pci.h>
 
 #include "helpers/helpers.h"
+#include "cpufreq.h"
 
+/* ACPI P-States Helper Functions for AMD Processors ***************/
 #define MSR_AMD_PSTATE_STATUS	0xc0010063
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
@@ -146,4 +148,39 @@ int amd_pci_get_num_boost_states(int *active, int *states)
 	pci_cleanup(pci_acc);
 	return 0;
 }
+
+/* ACPI P-States Helper Functions for AMD Processors ***************/
+
+/* AMD P-States Helper Functions ***************/
+enum amd_pstate_value {
+	AMD_PSTATE_HIGHEST_PERF,
+	AMD_PSTATE_NOMINAL_PERF,
+	AMD_PSTATE_LOWEST_NONLINEAR_PERF,
+	AMD_PSTATE_LOWEST_PERF,
+	AMD_PSTATE_MAX_FREQ,
+	AMD_PSTATE_NOMINAL_FREQ,
+	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
+	MAX_AMD_PSTATE_VALUE_READ_FILES
+};
+
+static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
+	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
+	[AMD_PSTATE_NOMINAL_PERF] = "amd_pstate_nominal_perf",
+	[AMD_PSTATE_LOWEST_NONLINEAR_PERF] = "amd_pstate_lowest_nonlinear_perf",
+	[AMD_PSTATE_LOWEST_PERF] = "amd_pstate_lowest_perf",
+	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
+	[AMD_PSTATE_NOMINAL_FREQ] = "amd_pstate_nominal_freq",
+	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
+};
+
+static unsigned long amd_pstate_get_data(unsigned int cpu,
+					 enum amd_pstate_value value)
+{
+	return cpufreq_get_sysfs_value_from_table(cpu,
+						  amd_pstate_value_files,
+						  value,
+						  MAX_AMD_PSTATE_VALUE_READ_FILES);
+}
+
+/* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
-- 
2.25.1

