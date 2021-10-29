Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A189243FD12
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhJ2NIH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:08:07 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:24296
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232156AbhJ2NHi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKsAU/amUsQTr9JVmyciUGmyr2z8QTnUD3Ibe6ZT2OJYIaQSRjG1eUzDPXT9H067+56tdwXIAuUIPf2LPtyZhCHPWJwLcIdWa+PRbbGPj5p+Pl8WUDNodh+CrcvcW27kFPj3xTlY3BMmISi7mcidschc9oeCsZy9Q9oqAFl4VvYcaubFcwSI7DOTwPyZYRVWXmpkk+q2j26RquFVny7DgJRKk/OYQV2yB0YEAASrAtYQfth/Yu5Uir41UGpFIf3TJvkCZwymsMkiyPLyCf+1D2oydGZcVvOf+uMvuk+nIpplnqBWTA0K37DslhloRU/wRS4+1zYJ+lxHdsceazuXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jOvmGDfGz1gJXbaRZTJMWXhjbZ5oq0JFSU8rh7h+kY=;
 b=lSXSW8yJVFlPTsH5GEHp0XeWj++gJqUAEIjpRhJsGK8MigVHGiK7UaLDn2Cwyjx0rB8iYpiw3qh1PbzeuRIeeoYroRhhQiSqHO/GpAZFlj6jiMLgzX3MUAJX5mo6F16zGrfweNcKonsAjce6C4Tfwkeet5D5BEqc8LpqzT4P1PyXcVQ3eDfAZEAs0wPD0WY2NKma/Q4jXm35viy0ICfEyVFAHsbbqEG5zJuVDbZO8jta1O+rRPmvyS9t0gZMVE+pb9/pFo04A0hCBFvaa7Wd76G0hRMAfuNQuo6J5c+OB7r8G7jl9K/h/G4NdKFvXeK38vhYF7M61jExtLX7CIMQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jOvmGDfGz1gJXbaRZTJMWXhjbZ5oq0JFSU8rh7h+kY=;
 b=ABq5mWps2L7Af5Xqs83KaQdN5YOV8qzBWQwu1dg/UHco1dyFtA79jfj2/JPE2Bs1SSQ5UBHrcQqNTjlY9YwzAheC/u/kUt1xbEYodT8+L/p0SO5uV5m/TqaFBaq422ZoIVcy61XQw1PmYmQImW4CMKqWR/YMkJG/PMkqQdYibxc=
Received: from BN9PR03CA0388.namprd03.prod.outlook.com (2603:10b6:408:f7::33)
 by SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 13:05:05 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::46) by BN9PR03CA0388.outlook.office365.com
 (2603:10b6:408:f7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 13:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:05:02 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:51 -0500
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
Subject: [PATCH v3 20/21] cpupower: print amd-pstate information on cpupower
Date:   Fri, 29 Oct 2021 21:02:40 +0800
Message-ID: <20211029130241.1984459-21-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 31c52d86-12e4-4b59-1e24-08d99adcb893
X-MS-TrafficTypeDiagnostic: SN6PR12MB2845:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28459A0C1DA5A40219483A41EC879@SN6PR12MB2845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxa2BydepOxS4xDexmF62lcv4zQWqOdZHxvIsCKVIX8X7BMGpez/5c3BzGuzZ6NFUNY7Ztm4jeJODrGcbasSAUvRHrF0evBasccD0Fg6CyLfw5QRnrRjHaZq+3kciqfY/BQnUnAp6CZyT4Q+OrLZB144L78nfUMuNu91/Wq2lSlcFNAU/hlgBZCjfDvPbFHIGh3Nm8PctFVe0EFFMQwvR/ZZvAQsqtryH69RBV6BV876O74oR1lHJSLn63FD4FRMYpRpNeaoDzFwr+v2jxk8kLFmI6mbbdY8idMad60xXNc1DawLtmktAck94Asj0+JD4J0xLfCkm+wMLro+P9EGO61Pmger/7MKK0cVWCrmnhmklUCmdxmK6n2twmL+iBiyiwljxL4t5PWPfU2JVuhJFDI9EOLLZkPb1lmQqMpS9NI8gm5f07KTAFDtor3xUOz33NXwtvojRa2KxXyLZeayP178EcTh9l9oqsY4oVuv77QUepby8ypnixvKZ+bNGeRka9P34gtgT4QEGpSTXsdalowI7bTFapxp/yI40HmISELW5dx/TYY1phwoYmFzr3UNnLPIB+SxTivSCRW1qEjHDZbcLhzRdehwC29vu22rtR1BzISfXtCZP1LoKhZpvDcHB1MbEjdoSau2moTG11mGOnH8/TN6Jxideab101u39e1/SKUgBW0Max8SD1LdHizEwaEkxv4PiofMASCV85uTWTuz0qbT7ccYse4i8LcMlJ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(83380400001)(36756003)(81166007)(8936002)(47076005)(7416002)(82310400003)(426003)(54906003)(8676002)(86362001)(508600001)(110136005)(5660300002)(336012)(4326008)(16526019)(36860700001)(186003)(2616005)(316002)(6666004)(70586007)(2906002)(26005)(7696005)(70206006)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:05:02.7119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c52d86-12e4-4b59-1e24-08d99adcb893
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

amd-pstate kernel module is using the fine grain frequency instead of
acpi hardware pstate. So the performance and frequency values should be
printed in frequency-info.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c    |  9 ++++--
 tools/power/cpupower/utils/helpers/amd.c     | 32 ++++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 +++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index b429454bf3ae..f828f3c35a6f 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -146,9 +146,12 @@ static int get_boost_mode_x86(unsigned int cpu)
 	printf(_("    Supported: %s\n"), support ? _("yes") : _("no"));
 	printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
 
-	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
-	     cpupower_cpu_info.family >= 0x10) ||
-	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
+		amd_pstate_show_perf_and_freq(cpu, no_rounding);
+	} else if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+		    cpupower_cpu_info.family >= 0x10) ||
+		   cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
 		if (ret)
 			return ret;
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 92b9fb631768..fa38d3da42ce 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -200,5 +200,37 @@ void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
 	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
 }
 
+void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
+{
+	unsigned long cpuinfo_max, cpuinfo_min;
+
+	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
+
+	printf(_("    AMD PSTATE Highest Performance: %lu. Maximum Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF));
+	/* If boost isn't active, the cpuinfo_max doesn't indicate real max
+	 * frequency. So we read it back from amd-pstate sysfs entry.
+	 */
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ), no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Nominal Performance: %lu. Nominal Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_NOMINAL_PERF));
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_NOMINAL_FREQ),
+		    no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Lowest Non-linear Performance: %lu. Lowest Non-linear Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_LOWEST_NONLINEAR_PERF));
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_LOWEST_NONLINEAR_FREQ),
+		    no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Lowest Performance: %lu. Lowest Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_LOWEST_PERF));
+	print_speed(cpuinfo_min, no_rounding);
+	printf(".\n");
+}
+
 /* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index fbbfa6047c83..5f6862502dbf 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -142,6 +142,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 extern bool cpupower_amd_pstate_enabled(void);
 extern void amd_pstate_boost_init(unsigned int cpu,
 				  int *support, int *active);
+extern void amd_pstate_show_perf_and_freq(unsigned int cpu,
+					  int no_rounding);
 
 /* AMD P-States stuff **************************/
 
@@ -182,6 +184,9 @@ static inline bool cpupower_amd_pstate_enabled(void)
 static void amd_pstate_boost_init(unsigned int cpu,
 				  int *support, int *active)
 { return; }
+static inline void amd_pstate_show_perf_and_freq(unsigned int cpu,
+						 int no_rounding)
+{ return; }
 
 /* cpuid and cpuinfo helpers  **************************/
 
-- 
2.25.1

