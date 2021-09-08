Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B379403C21
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351940AbhIHPCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:43 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:25313
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352015AbhIHPCY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmYtO6RmDCS2gzRVDoljBJjDizR/nC5HBlA8cvXfo9E8gWrCMNdwNkae/Ctl9nhINu4l9qbvIqgFCO99gBFeN+kyw7qw8RVMQG8N/7PDgfjq6SDkRsjkj+tSwo2HdbZlSHa05CSfj4Kr8vq2udD9hmZe7Qv0hcxe0GUAEcA4qGRLJ/n/d/lxR/FA2FCczzYx7BWaqMVylQs0r+SoV5/QZnshfhtDVabESenBiJK4pTVGr7QdnxlyPjs4KjgWVdpkbHIs9+AscOqBV5aqr1afG1UGDPRqCuS4IHGy7FgfRxl9AnzKtPRd+7RVRVCB7SSKqe6sqta4jczo7k40TrllVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GZD4gX9z4G98n+6E/ckRy4Stj5dZwEFnwu5IFI+QCz0=;
 b=BXg9+BuK4lCkHlvI+HHRlxD/rLUL6+/mcxvz2PKB/dLlB2VTZBf67R2inlcrHIbSjkoDIrhDUBCSGXHoqKe5AZMHqaw2wiU9opVTLZluMlNXdR2/Vgga6U/5er5l+cWFWvHRMIqlYHCrRVA+lN0uQnqwZOaHdsDEUuLEuoU7kpjcbV9BseLwmXJi4qmCHkY87KcJzsh2E74FdssCFB2DayMPnDOkRoUBrWDOZmEvTkIgblw1QJeSr92LtFfaQ6teVXGhwBWFpnp2U6UYDtFfdSWCST/lECIVJCRy891B3GoQlVtC0NfijUjeG0lcskwwBMrvKKTYEOo5Q/BBogqsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZD4gX9z4G98n+6E/ckRy4Stj5dZwEFnwu5IFI+QCz0=;
 b=lW+Vu/BfBBEkhCxh+Lz9Qcstf13pfLfli/2owPR7wfjLfyfGxlYliWkwbSKxKxLR/ggwQil+h+WdOF9l1Nt0lGdYnN1e6j26NjZrAarwdahTn0OOs6EVIZXR4LXMw1YTyzXmhYUdb9iN0B9e92dEGSIPNz6NvzEvitDpwFJAdIk=
Received: from MWHPR11CA0041.namprd11.prod.outlook.com (2603:10b6:300:115::27)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 15:01:14 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::74) by MWHPR11CA0041.outlook.office365.com
 (2603:10b6:300:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:01:14 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:01:08 -0500
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
Subject: [PATCH 06/19] cpufreq: amd: add acpi cppc function as the backend for legacy processors
Date:   Wed, 8 Sep 2021 22:59:48 +0800
Message-ID: <20210908150001.3702552-7-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 219fec5b-6fad-4734-3d6a-08d972d980ad
X-MS-TrafficTypeDiagnostic: CH2PR12MB4860:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4860630FCC84E56179E7ECB1ECD49@CH2PR12MB4860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDaNJZnvnMbm/XMsYvBAGMi3AXlNkUJlkKevn8MhAXdFf13xXFw2Qg4BBghTh2sD20RbkJy8dLRzWexKDgYRsztQ8MUvGI1a3iVILds6JJtd2I+zzJY2Hw//tkPscEwPJ0pMn/42tCdy/NWgQmmnh+88aTzyY2mUl7/g5XhVwSqjnzQo7ywEkmhXIXa9SDrH/68cHDQrxh40IoQKpBdcCA3I93qSH3CooBKaW6BRJYnUqL2KcRx9H9NdCc50aECkEBJzJUE3q6bUrLhgYhrmiJwvsVno3muoFGj4Ycm1of2AIs+hZ9ES+1oi6P1sG4eTLG7Df1CTl81ZsDg7IPaql+pwFEjx959XfvrZzhCOEAvUPx9ScmjfoSUzdNzm4aQiL0X79RG4YUrIM+K/fCchU76KqL5tMANERzDD2tCtl4CalLNMjs7bgkQ12w5iojNmrUILd/xMAM17lg8t5DtMgFMAAddqAgk4+PdI/jHsRw3EaEmEhcPEH/Nn9RC6oFm7SaVFKVulOYhmUK81Bo5LH9PemyBeJzf4lK3aPx/IM/U/hP9fKQro3j/22tDKeRFY2/UAvUt+RHttnQcVmrqCb5HZvgslmqNzSqzy+auF4UpoupzTkUjn2puSUDhS9ApgEiEeKeyJUS0iVs1IEZZZIKN/ZiFRViDEcbDHXT9XqXQa5WV04jBlgDWhh3InmIQ6vHppqx3ldo55+oXIKTSJXtny5PU8cHSL2Cidc/BTBu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(70206006)(316002)(8676002)(7696005)(81166007)(54906003)(336012)(356005)(8936002)(426003)(110136005)(83380400001)(2616005)(4326008)(86362001)(508600001)(36756003)(186003)(5660300002)(1076003)(16526019)(26005)(2906002)(70586007)(82310400003)(6666004)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:01:14.0303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219fec5b-6fad-4734-3d6a-08d972d980ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In some old Zen based processors, they are using the shared memory that
exposed from ACPI SBIOS.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 63 ++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 32b4f6d79783..a46cd5dd9f7c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -82,6 +82,19 @@ static inline int pstate_enable(bool enable)
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
 }
 
+static int cppc_enable(bool enable)
+{
+	int cpu, ret = 0;
+
+	for_each_online_cpu(cpu) {
+		ret = cppc_set_enable(cpu, enable ? 1 : 0);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int
 amd_pstate_enable(struct amd_pstate_perf_funcs *funcs, bool enable)
 {
@@ -113,6 +126,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 	return 0;
 }
 
+static int cppc_init_perf(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_caps cppc_perf;
+
+	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
+
+	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
+	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
+		   cppc_perf.lowest_nonlinear_perf);
+	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+
+	return 0;
+}
+
 static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
@@ -134,6 +165,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata,
 			      READ_ONCE(cpudata->cppc_req_cached));
 }
 
+static void cppc_update_perf(struct amd_cpudata *cpudata,
+			     u32 min_perf, u32 des_perf,
+			     u32 max_perf, bool fast_switch)
+{
+	struct cppc_perf_ctrls perf_ctrls;
+
+	perf_ctrls.max_perf = max_perf;
+	perf_ctrls.min_perf = min_perf;
+	perf_ctrls.desired_perf = des_perf;
+
+	cppc_set_perf(cpudata->cpu, &perf_ctrls);
+}
+
 static int
 amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 		       u32 des_perf, u32 max_perf, bool fast_switch)
@@ -370,6 +414,12 @@ static struct amd_pstate_perf_funcs pstate_funcs = {
 	.update_perf = pstate_update_perf,
 };
 
+static struct amd_pstate_perf_funcs cppc_funcs = {
+	.enable = cppc_enable,
+	.init_perf = cppc_init_perf,
+	.update_perf = cppc_update_perf,
+};
+
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
@@ -416,7 +466,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	policy->fast_switch_possible = true;
+	if (boot_cpu_has(X86_FEATURE_AMD_CPPC_EXT))
+		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
@@ -471,7 +522,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
 	.fast_switch    = amd_pstate_fast_switch,
-	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
@@ -496,14 +546,15 @@ static int __init amd_pstate_init(void)
 		return -EEXIST;
 
 	/* capability check */
-	if (!boot_cpu_has(X86_FEATURE_AMD_CPPC_EXT)) {
+	if (boot_cpu_has(X86_FEATURE_AMD_CPPC_EXT)) {
 		pr_debug("%s, AMD CPPC extension functionality is supported\n",
 			 __func__);
-		return -ENODEV;
+		funcs = &pstate_funcs;
+		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
+	} else {
+		funcs = &cppc_funcs;
 	}
 
-	funcs = &pstate_funcs;
-
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(funcs, true);
 	if (ret) {
-- 
2.25.1

