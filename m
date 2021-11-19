Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA192456D99
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhKSKgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:36:25 -0500
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:12768
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234979AbhKSKgT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:36:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5c/XOoYwm4AruX85wUqTv5LrX25Lcel8vmyxUmJBoIKaj9ePCcYK7OApJ9IuHI+FFtqP9sZmefh2eMM6784J+DJl4aJpmRlSEhOo2kOYvNm6djalJ0IqYyRHZkfLb7hyrymrCP88LD6Q+WKPLLc0LZ7SKGfjY8Srg4Vrta5uAdwve0JQIO7foQ1u7ogvOvVhY6Fk1JUpaE2Cm3U+0+aUgoi+FnEuRYspx2xTaH+VvuVftD6NmhZWFgxvD99fCzDqmF3fjhrfvCgLyRJhEMF3ktLB81Euw2Yp0KNbI8glxnU1Dqskigbw69qVoo2m4AgPEfd+/UEv3wlULfM81uQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfLxVQRzjwsSqbRDBQgrmnDJa48dVM0mI0y6dk5QTYk=;
 b=fgnCEuxYjZ0J1/4SiWzVHIjXp31okFb3npPw2GKgzIVCntviRVaO0VQrIUNo/G0cEHcFmTNMFzKiKny2sXoNlcig42NRU1NJyyWSEThVycwqglXGBLjHCWkY/sGHo0DAf90noh72fI2GOcEtK3OlRDgrEVq/x7Qk8EFAfM1RiRLW0jQkum8y3rz5wc2/6eKoliF5RrsWmaLBwGCmFBFWVQdTTHviLEpD5XCrVr36uCapb0agRxf22RBVpBp69sjWotThKnnMXt4aoWOsZWrO2jOQJ9w5ePUSuVWTPsn7BXln7rWsD76J1IATNPGvDpsMAyEQSy1pARUrAdHda1bpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfLxVQRzjwsSqbRDBQgrmnDJa48dVM0mI0y6dk5QTYk=;
 b=hcNlBvxYpLNjp3tSoy6MtpEszd65I305kyCHg7kPZ6P9VT/CjgFSndbqugc51/lX7sCBpLibu1YTJ/sJjOEWsFPcI5gM+r9BodhTqZIC/FBB8b30Z0ATvobTlRLL7muxqD33GDVihPDu77H664kEREhv4HVciv8NIHsDQyBzTyY=
Received: from DM5PR18CA0094.namprd18.prod.outlook.com (2603:10b6:3:3::32) by
 CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Fri, 19 Nov 2021 10:33:15 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::9d) by DM5PR18CA0094.outlook.office365.com
 (2603:10b6:3:3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 10:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:33:15 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:33:10 -0600
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
Subject: [PATCH v4 21/22] cpupower: print amd-pstate information on cpupower
Date:   Fri, 19 Nov 2021 18:31:01 +0800
Message-ID: <20211119103102.88124-22-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4fd4ca95-58dd-4e5c-987a-08d9ab47ff02
X-MS-TrafficTypeDiagnostic: CH2PR12MB4136:
X-Microsoft-Antispam-PRVS: <CH2PR12MB413619969B201DBC3836A2EAEC9C9@CH2PR12MB4136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzXk85RhfO2NHOEKR0Fd7J+k2PQvfq+nXzvg1BVg9m5TtktPRWE9m8qr00bfq4unzckdHtQuIbb/UDwQVfx49n++82keUVPCie4O6q2TKIESnFdU7/kFII8j705f+uZsApq7dHMZw540tI4nwKQoQRXSEutcshDo325ANsgkxNvyYriwqnopjEC50eJkVp9BteBzJCn9vPeA9bnhXZxxSiTwn7oiqGs3NhjgkQTqED45eF1E7GZ3vMX5gt4ag8a6QC9oSw5Y44WFPmNQtvdBG3Vs7SScO9JLNTzSCVKC6OtfGUKrD2udOp97552BQPQWS/qCMYTYQ5QLOnMi/iQAyVaZLzRVgNxIs7yPnH4QNazK32DrcEjuSJzKyaZf2a0szYNPYQZaooeVPblWeYxFkNX2X3FcBiyJBtu4kePyopdbVeJjQ0maDkPYnyFIRRdeqLzjIrrmMC282TSjNZA6hUI+VCqHjaqhYBbJTrEslDcnESN5Jmy1KXFU5OLt1bmefffsAFCn1euKiN4CEWjY6hE63ZqHfyJ3+EE+AfHbkEPgg2CbVvO9AXrVT/sQSe3yxqkGV/x4lqKUxJxDky70TBDBkYFWynvYJdqnY5xNvcxBmYEHfZyg2kPci11uQzC5t4CqwPW8yml2eEcUsOB6VexpasPIaU0s8HeOb5r7UGI+TDvrXkp/g5IXIzLTtAwFbX6YyPhWk5cAa9h0OFRD3ZCJA86OZNp9VOKSzlC3waA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(5660300002)(1076003)(16526019)(508600001)(4326008)(81166007)(356005)(82310400003)(83380400001)(2906002)(47076005)(7416002)(336012)(316002)(6666004)(70586007)(36860700001)(8676002)(7696005)(2616005)(8936002)(36756003)(186003)(26005)(110136005)(426003)(70206006)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:33:15.7254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd4ca95-58dd-4e5c-987a-08d9ab47ff02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

amd-pstate kernel module is using the fine grain frequency instead of
acpi hardware pstate. So the performance and frequency values should be
printed in frequency-info.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c    |  9 ++++---
 tools/power/cpupower/utils/helpers/amd.c     | 28 ++++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 ++++
 3 files changed, 39 insertions(+), 3 deletions(-)

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
index bde6065cabf4..a1115891d76d 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -193,5 +193,33 @@ void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
 	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
 }
 
+void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
+{
+	printf(_("    AMD PSTATE Highest Performance: %lu. Maximum Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF));
+	/* If boost isn't active, the cpuinfo_max doesn't indicate real max
+	 * frequency. So we read it back from amd-pstate sysfs entry.
+	 */
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ), no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Nominal Performance: %lu. Nominal Frequency: "),
+	       acpi_cppc_get_data(cpu, NOMINAL_PERF));
+	print_speed(acpi_cppc_get_data(cpu, NOMINAL_FREQ) * 1000,
+		    no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Lowest Non-linear Performance: %lu. Lowest Non-linear Frequency: "),
+	       acpi_cppc_get_data(cpu, LOWEST_NONLINEAR_PERF));
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_LOWEST_NONLINEAR_FREQ),
+		    no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Lowest Performance: %lu. Lowest Frequency: "),
+	       acpi_cppc_get_data(cpu, LOWEST_PERF));
+	print_speed(acpi_cppc_get_data(cpu, LOWEST_FREQ) * 1000, no_rounding);
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

