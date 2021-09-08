Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A0403C37
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352166AbhIHPDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:03:22 -0400
Received: from mail-dm6nam12on2084.outbound.protection.outlook.com ([40.107.243.84]:18865
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352146AbhIHPDM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:03:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9HDccRksStruCulp6QouXu+9cFLR/eym+uHL3WTRH+y5Gptr2yNcGgSiLzN2zmkJv1k9q0Ey7Y1BGXgqzkGeANOnZoco0T/HGINe0Y+rNvRVL+GE4Oq65whLlNjsZsGm9fDFCDkyMaH48ZvLcYv3FZHPPN391CNWU/fkOyVahLgYwZOCbUjjw1y8zq2XuXY0JIXgKjIuEPNLlb5yOHhzY5ybDxHhCEeWWsWC9FKlIA6O0wfmPLnuW7j2uUM9E5VDuVIh6oKiObh9gk0PawdFLN+tXbfCUp0Zfqvph+XG9vYKsKdfExU2XcweR/cKSBJ0Paom/8MdwNfRZNDnyRmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cmrp+7el6YRgEkr6/T5xhYYKoMbgAYrrQ/2R4RvOi9Q=;
 b=c9CPuAPv20qK6sRDFh2QjWpXJyPBfVSJEAvMi8AHNEJcs0un/RB1yVMLOqJQSqlkeHYktg3M4AOknhOnuBZgqkEioi2AvFu8LNW2LVUY412dpM5ZVmpnlAOclzCSL1tFWJXDsoF7dgpZIaS6++UfZ2/NPcuwqFciguH05atexgLZTjOKdC1FOvZa9vCGIBB2oozG211kmy3kE0Jz6W2YTiEvWymwRFfk1EXV/PK4kU2il2EZFbNpYPFp+5Nx5AvrkiFqRmtGf9PSuyqdptniG/74ZGBBjUjE+H+XyoqfI5JBJFuL/hyM2HqHKUr76+r5fLf32v9noeb7QeY4dhw85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmrp+7el6YRgEkr6/T5xhYYKoMbgAYrrQ/2R4RvOi9Q=;
 b=saF5g7uvNvcJZMmb5qb9cqXSVEnj0Ug525+VZcpUaB68K8CEizbg6gbudQ2sYLtMR8Bmvrtsg9C5v2qg500Z+A9bcBvrKCpDfNG2ghlvy4P1z70WaKLcYFnQALwQrp4etDqRcsF7NMm0sFJuHp0tdcdVajZVxs2173CSvD0DL4Q=
Received: from MW4PR04CA0218.namprd04.prod.outlook.com (2603:10b6:303:87::13)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 15:02:02 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::fc) by MW4PR04CA0218.outlook.office365.com
 (2603:10b6:303:87::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:02:02 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:46 -0500
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
Subject: [PATCH 16/19] cpupower: enable boost state support for amd-pstate module
Date:   Wed, 8 Sep 2021 22:59:58 +0800
Message-ID: <20210908150001.3702552-17-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 303113ca-3f45-439b-9a41-08d972d99d7b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020308C53937E154B732EDDEECD49@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96dMPKC45FosabsBQZO9/PIFtFRGnb9/MzlArRs1Rk5BsJnRuAWo5zF9xEPFuxaPEQBKNWeUNchVGojHCOEoktO6ZddjPxb2E/Ryz50mfzYcBBhqLckWPdPvZ98T/E39qwZtpHNLMLYCnSNvekurpgI97U8ZLwLSeH9UeGe9okiv3lzwZa/KGtD/Oq8a4P0nEoS5BFUuRrBgtWUJ46PoB9LwdofUiaO/sIIgoXtbrecL5fyPuMcgeJ1TXGpwumC2n4C4Rj2kjwcuEuQQDOmanhMwjCdojsyMXRx4QCFgjgMeFCJY5ODRB4Ft7Ipx4Jgeepw/FZp7PppiP2BPAptDCMNgO/a9JtoNWQc0+KpG3jetNZET2EUhJbR6fhQoTUnDBGqityHcaUMxyZ5aSsc8f1vntaUuCWmwSE+jNR0ZnL8WHaFDthMbZa6LkLKsjhZ/LSSUJwaGkb7M9dGYoESHfEYaGFs1xVNxKHvszUN5UGTTyzdohNqTEyDe0bg/fggsx9JG4UB0lDahIg6Pp8uWXO+qbNcst5KCETLGKu0P3INT5yCG2pmDPmZNFzlJ33tQ/V4eX0vLBS+L3ycfJoFPtqcDaCzgDumjvj520bck8xZf1iZQHtDoxYNIPO6NAM6QvGkLEpc+K9z6QpPMaOAbgdtM/5F+XapALkZFNEDYh//83xWjvmlHEQNcfy3DQEpkz1oyY/GhEc6uE1AB8sQ/1ruoFpcY+YhwAIBd5FBMB5I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70586007)(8676002)(8936002)(70206006)(316002)(54906003)(36756003)(426003)(6666004)(16526019)(186003)(110136005)(336012)(1076003)(2616005)(7696005)(5660300002)(26005)(81166007)(356005)(36860700001)(4326008)(82310400003)(86362001)(47076005)(508600001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:02:02.3609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 303113ca-3f45-439b-9a41-08d972d99d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AMD P-state boost API is different from ACPI hardware P-states, so
implement the support for amd-pstate kernel module.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/lib/cpufreq.c        | 20 ++++++++++++++++++++
 tools/power/cpupower/lib/cpufreq.h        |  3 +++
 tools/power/cpupower/utils/helpers/misc.c |  7 +++++++
 3 files changed, 30 insertions(+)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 3f92ddadaad2..37da87bdcfb1 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -790,3 +790,23 @@ unsigned long cpufreq_get_transitions(unsigned int cpu)
 {
 	return sysfs_cpufreq_get_one_value(cpu, STATS_NUM_TRANSITIONS);
 }
+
+int amd_pstate_boost_support(unsigned int cpu)
+{
+	unsigned int highest_perf, nominal_perf;
+
+	highest_perf = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_HIGHEST_PERF);
+	nominal_perf = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_NOMINAL_PERF);
+
+	return highest_perf > nominal_perf ? 1 : 0;
+}
+
+int amd_pstate_boost_enabled(unsigned int cpu)
+{
+	unsigned int cpuinfo_max, amd_pstate_max;
+
+	cpuinfo_max = sysfs_cpufreq_get_one_value(cpu, CPUINFO_MAX_FREQ);
+	amd_pstate_max = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_MAX_FREQ);
+
+	return cpuinfo_max == amd_pstate_max ? 1 : 0;
+}
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 95f4fd9e2656..d54d02a7a4f4 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -203,6 +203,9 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
 int cpufreq_set_frequency(unsigned int cpu,
 				unsigned long target_frequency);
 
+int amd_pstate_boost_support(unsigned int cpu);
+int amd_pstate_boost_enabled(unsigned int cpu);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index 07d80775fb68..aba979320760 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -10,6 +10,7 @@
 #if defined(__i386__) || defined(__x86_64__)
 
 #include "cpupower_intern.h"
+#include "cpufreq.h"
 
 #define MSR_AMD_HWCR	0xc0010015
 
@@ -39,6 +40,12 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 			if (ret)
 				return ret;
 		}
+	} if ((cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) &&
+	      amd_pstate_boost_support(cpu)) {
+		*support = 1;
+
+		if (amd_pstate_boost_enabled(cpu))
+			*active = 1;
 	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
 		*support = *active = 1;
 	return 0;
-- 
2.25.1

