Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D34187CF
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhIZJJa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:30 -0400
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:27873
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230482AbhIZJJW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:09:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn42Bhz4jSsYD2BXPJTZ3uqnlukAvJFf35d9Czz2wm0D4ZzWdGuxt9DieVOk+XN9MSs04HdetQO2SXKnuWmqloIdq6QiZauroku/RTkhpkGPgHJ86Xf+x4ypAnfNLDvCPJsuCGOBckzK2L2zaWKfntb8fc5w/2kB79MtIObdT6HICwQZusvhjFk7EnQqwvVpi6EJLAod6VpiHRMf/018MrZIplKdH+Lwo8xFUGvEb/ClYgsEfgMgxf/qR5TqLgYcODE37Z5Z831HMLB3Dbu7EiXm2nPYwzrg1sn1DlDUP9zVWQsXBpUf58+EAexX6EHe3fhL0oaMgpcTXSUhCqD0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XhiKBVvvQhhKvH0Gfg+rigCanfSzd9CKNnis27B5WT0=;
 b=atb7Dww+H+0GQYUUpZxSQyXzR0N/rMbUDqL9kLVNuSm8fhhHtHdZN+Xh71FLsHH1OkU6Iv3z5yAmnZpDMR7je/+yLxQCKL87tPeTHOuP7A2crTSVtXbAnArMpVuOouDR09rGkEtEykK3xjuTyPbX5i5+IHp4PsuxbsYaAOr8eCw8tcjsIYnw6hHJugvFQClIEFTCm/mIqNwcZ/iUkZEQONCVe1lV+Cen/otgEn50bkgV81AFkYeGOz3CbIDbSIBl0QGeIaOd01XahJBVe64c1PenC6MtBEQLviTxOwfQvqzdmKORllEEWk/5eNCpU6t7twCrLPhbykhjGFLnO7wQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhiKBVvvQhhKvH0Gfg+rigCanfSzd9CKNnis27B5WT0=;
 b=kU2eRk5u4WaaCnyjuZKjQBCkgBeqdQRhN+9M8iDrLfxUtW5Aa6KLxs7vtpkOCchSgZRsL9So5qPs1zW+4Q1+jVLkMRsdp3lGLNMDQg12Cq+igmnZANik02CN1S7kFxUNHDhSQhPZbdgdvl59Wt1VAEfwGTTOF1Zh/MDdnO1uVrE=
Received: from MWHPR07CA0017.namprd07.prod.outlook.com (2603:10b6:300:116::27)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Sun, 26 Sep
 2021 09:07:42 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::fe) by MWHPR07CA0017.outlook.office365.com
 (2603:10b6:300:116::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:41 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:36 -0500
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
Subject: [PATCH v2 20/21] cpupower: print amd-pstate information on cpupower
Date:   Sun, 26 Sep 2021 17:06:04 +0800
Message-ID: <20210926090605.3556134-21-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 968e830b-4b84-413d-79ca-08d980cd187d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5139:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5139874ECBA2C6F494169FE7ECA69@CH0PR12MB5139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZlSRjLYkosBSRfqh3JGjwYfjTkODcVa/6vIH9LyuaXglBpjyrY6HUZWuD/odNDq68EE9E7mx8t3DPgdXWUouNUh2wXq1q5cLBheBC8/j1sxXjYMktabek0Ar8Oh+BPp/Aq8dzeYXdii772/+v1w6/AbywmK38mjlk83ecc/m+fqja+OSb/9CkMNTXxN+zXXAF/eURekWDAmdWTRRQlBAeWPdKOGXrOF3+hJgdRumnBCwHGyf67p0qA3mw14iiomvOlflDrxFS7tk3ZcEIJX8R34JNK/VAVgyOi2wWpJf6QZ9IqgFFyeyIdVF3kProku/ccGaqCJGmKONYWZasw0tLjzUaZG8muNwREG9pTZmAItlrrciE2z83O+aQfq7IDvvkDcsvuFIJb6e4Blt7J894RWoTnXUZwO/5Rf4GaoQTJ5AcPlvGGVoBKJ8ND11Q/cAANVgtY2SVK+dkbhhwmANCENMJVzm41Ue1pMrQYddq+7UGBmOW4cv57fsT4zQPQZ7xLSG36w1ALqv+6E8D5gwzBwCcBkDwK4csxraV7o6LhjoCoGXtJBVAZoRp8f4XUyV5AUPpKEf/f9xHv1VY1PgLOHztpHk1TXxkWrGovNFBaepY1GtwNain9Ne+nZnPXCMoCUh3DCaL4Hp0r8k/xPg2iF5h3muMIyS4ViqGwIquVQ5hBeEBqNr83YlWSqy2vg5PYbluLITVM6oDByiR3JLKaUXztgFh9KvzZ7BHrhyR8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(36860700001)(16526019)(81166007)(7696005)(1076003)(26005)(8676002)(6666004)(110136005)(508600001)(316002)(54906003)(8936002)(47076005)(356005)(83380400001)(70206006)(336012)(82310400003)(2906002)(36756003)(186003)(86362001)(5660300002)(70586007)(426003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:41.5714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968e830b-4b84-413d-79ca-08d980cd187d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

amd-pstate kernel module is using the fine grain frequency instead of
acpi hardware pstate. So the performance and frequency values should be
printed in frequency-info.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c    |  9 ++++---
 tools/power/cpupower/utils/helpers/amd.c     | 25 ++++++++++++++++++++
 tools/power/cpupower/utils/helpers/helpers.h |  5 ++++
 3 files changed, 36 insertions(+), 3 deletions(-)

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
index de68c14574c0..d68d052ee4cb 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -202,5 +202,30 @@ void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
 	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
 }
 
+void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
+{
+	printf(_("    AMD PSTATE Highest Performance: %lu. Maximum Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF));
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
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_MIN_FREQ), no_rounding);
+	printf(".\n");
+}
+
 /* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 0b0f6a55354e..80755568afc4 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -141,6 +141,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 extern unsigned long cpupower_amd_pstate_enabled(void);
 extern void amd_pstate_boost_init(unsigned int cpu,
 				  int *support, int *active);
+extern void amd_pstate_show_perf_and_freq(unsigned int cpu,
+					  int no_rounding);
 
 /* AMD P-States stuff **************************/
 
@@ -181,6 +183,9 @@ static inline unsigned long cpupower_amd_pstate_enabled(void)
 static void amd_pstate_boost_init(unsigned int cpu,
 				  int *support, int *active)
 { return; }
+static inline void amd_pstate_show_perf_and_freq(unsigned int cpu,
+						 int no_rounding)
+{ return; }
 
 /* cpuid and cpuinfo helpers  **************************/
 
-- 
2.25.1

