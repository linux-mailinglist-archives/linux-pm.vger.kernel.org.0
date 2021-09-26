Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B184187B4
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhIZJIe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:34 -0400
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:3491
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230134AbhIZJI3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1VzPSHSBnoMZwLB9OzZEzLrcjWK6Mvndn35JGFTwF/Y5AyNYthbMk+DaYtid7qiGHxqSzAzD+ZzOslJut+RiyVoLf8Hj73XP5yGTVn19e65z08zAur4ZgmL491+Q+HGFiJD6ZdEeNxhWdVmI1oFI6WOi7qhXYSR4pSRlKv+yTNBII+PrZIGbjqNQP6p6gAy/k6EfAasg9WCQ9ugUoifOdKR9AVWwf2wqQeHFb8Uw6H+vuWD7ggnAS3jz3SZMHXzN8Lol50CQXyiAN66qodPpPc/jsXA3+t8iU90bH0Hd5bye1qjde9trc1omxs9gyWkn7MrYhsTH/yJZqa9c+HXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+6cj9kVyoPHdeVSRCi3R+0wd7pnLeyZ56Ot6eWsqbtg=;
 b=I/KrtPRp2Ll6bBkCh1bkOKmcpBonNgMLEOhDAVQlY8RpwRnZUZW16yxPyUlcMsLD7kPJ3ocG9/FDyEQbKjeKJLIOfnhIVTE5BEW2GXnBsYK+TNv2bFLaz7vyl5XZ5upzzKTFf9rTtZ3H+Z4TiQ0HYjMUXzxlwt3EH+tpJGGrPZtzihoE/8gb2YmKg7jvIZxqEC0VGKrM/N+tui/+YQbAUEQxSB77rm9WrI/P6UsII/eqtAbvieAFsEntze374OQMXI4p2q3g6e6a2zhMHS1TZqG+rKnPOSN0ETP26WTTtu/IbH2hgmgxmAwGShZRaiUn6qGkLA4ptR1LZffA4Ge57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6cj9kVyoPHdeVSRCi3R+0wd7pnLeyZ56Ot6eWsqbtg=;
 b=ZIY8ZQyT6nvXCzrnWm3ClL2TXg5hbZulvPynHSSdEc1F26gs413GugdWri4D4KqvvuBxOSj7eDI0mzcDBmVu2BhTFLcjz4yNbTEp0p5tioqmnahKjseNCERSWiILAbLRFUsYx3pYMA7diIBcnaqkG6PW3IU2q+AA0B6RPgEOETM=
Received: from MW4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:303:8f::15)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Sun, 26 Sep
 2021 09:06:48 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::1d) by MW4PR03CA0010.outlook.office365.com
 (2603:10b6:303:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:47 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:42 -0500
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
Subject: [PATCH v2 07/21] cpufreq: amd: add acpi cppc function as the backend for legacy processors
Date:   Sun, 26 Sep 2021 17:05:51 +0800
Message-ID: <20210926090605.3556134-8-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba72f9c7-1c11-4641-7120-08d980ccf868
X-MS-TrafficTypeDiagnostic: BY5PR12MB4856:
X-Microsoft-Antispam-PRVS: <BY5PR12MB48564E19F254D850B6116D1BECA69@BY5PR12MB4856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnlXSdpZ/djSIbvmaFqOXXKP3KMrIcR2U5UJ53ILLjV5s+IaLJVNf9nyGpqdHhb9p+oJ427ClFDtiPrdssQekKe/jk8kCQH3tSFUNHIIZb7RFdv88uQgWeizSkaXKNTGqN6t5ZLeHQwGdlyLWTydgyOVWqneWfMPuLpTza9cWor/fUojQIua2aVDbvFYuDGSZAzncxy/0KlQwThvNZKb+y9HFa+4lbH8zDlGpCvgc9/NYIq/McqMmc+sVqBmAPXoKgjvHjFMs49FFk7+GFtNobaysOoxa0HzLJnMLM6WsWEAjIzNrAx5xZ/y040sb+JfGgUs5Q4md1bcoQeemcHubnqkFIwzjP2XkfdVBjYUb36JQLYNbhADkc1JTdaZj6BV4HvEp0VJMGAHqG+xIfmFNKGfnGprB6m1fzmAHijD7oqqL0mcIXax2PmB2sTKKoQopYLdWa2XnFGVtdX2Rd9/5+kRNArQrBUuNv1JDHyzs5Y7LuoKJ6A6xYj86TSnMLBi7llrakyNe9+8xGiU05vCKBCkfC74zDQLhEvOq+IfwSEQrKtdlqKXjZJ8pj++vGys2wpbg7H5jiZgp1ZlZlk9rqXx1/IK+oP1XGY0/fjyisSeTi6j1GX7IzM8LVH3OZvCMTugl9qqTnXjjU1UNE5e7mmMZkiTNXAeE/ze1yX9iw/iK4VOq0MiIgw123KxvgQb/f8vzUNB2RNvQ6IY1YPaECW5p6QCXE8Hm4uhlw2SO6g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(110136005)(54906003)(6666004)(508600001)(83380400001)(1076003)(81166007)(26005)(36860700001)(86362001)(426003)(7696005)(47076005)(2616005)(186003)(4326008)(70586007)(336012)(5660300002)(8676002)(70206006)(316002)(16526019)(8936002)(36756003)(82310400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:47.7284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba72f9c7-1c11-4641-7120-08d980ccf868
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In some old Zen based processors, they are using the shared memory that
exposed from ACPI SBIOS.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 58 ++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index aa4610ad186e..c9bee7b1698a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -75,6 +75,19 @@ static inline int pstate_enable(bool enable)
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
 DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
 
 static inline int amd_pstate_enable(bool enable)
@@ -105,6 +118,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
 DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
 
 static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
@@ -123,6 +154,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
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
 DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
 
 static inline void
@@ -368,7 +412,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	policy->fast_switch_possible = true;
+	if (boot_cpu_has(X86_FEATURE_AMD_CPPC))
+		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
@@ -422,7 +467,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
-	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
@@ -446,10 +490,14 @@ static int __init amd_pstate_init(void)
 		return -EEXIST;
 
 	/* capability check */
-	if (!boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
-		pr_debug("%s, AMD CPPC MSR based functionality is not supported\n",
+	if (boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
+		pr_debug("%s, AMD CPPC MSR based functionality is supported\n",
 			 __func__);
-		return -ENODEV;
+		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
+	} else {
+		static_call_update(amd_pstate_enable, cppc_enable);
+		static_call_update(amd_pstate_init_perf, cppc_init_perf);
+		static_call_update(amd_pstate_update_perf, cppc_update_perf);
 	}
 
 	/* enable amd pstate feature */
-- 
2.25.1

