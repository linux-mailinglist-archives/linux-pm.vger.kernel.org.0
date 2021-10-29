Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3EA43FCF5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhJ2NGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:06:41 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:23681
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231714AbhJ2NG2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdKafSB6+3uiT6UMQ7cUfp6kAKaJbtrKvo/Lbw7+5o6+XppIMDJ1tYUZj0AtO3ddC85QAqww1O3XSC+21FA2PxJfqpUyC46bd37aoUmh529tammb3qvyhB9vqjU8/OY7yVvwEzMEHwAxp6Z7ITkgAhVj9YRlWXWXPMfsF9OZCx64QeVwWcivG0sMv1seyzE0vGx2lRhl5uPA0Y2+VVdPhDbkrEbOTFL+YPtVnWoEUjxwjgEYBHPF4keDIZ2vLk7t6+Dyt7NQUaehEnwqN7x7ARTwBJZVTKDGa/1hiQ9pi9QEwPx2q0/anrnX4x0EpHy1XLBEEdpmOtJfvK6/zEu9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gABS99kGbwHXiaMTvBfN9jVsP0ep/uAVa9mhBUjwt0=;
 b=SdlSi+5K8VDpR+Tz7NpCs332zQZ7blhrTeFap0EO8eHbamwi6hM1JbYoW9DA8yR1C25w80OMdUAPI+RNZljSkWfqs33iO3tY8W+QnGOI2SECZyv8yoCmIXjAbHGthlui1ie1OeJsRppDNUox350ewBC7iI9FOKctTe3dd6FffV5xyd8yNeKqvuXk1pBYp8pPdUMun9SXs1Eu8tyT4sVizLEtBO30BuPqNrV0VBnbWTZZEz3EjdnXeW4rbg811klYM9MNeH8gVN71YDAKkNIFIIizJtha+T1xJeu4oYJbDWgV+PK7Q8vIWkp8Ci/pW9hiPMq3XcIjbG8PNh1VUotyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gABS99kGbwHXiaMTvBfN9jVsP0ep/uAVa9mhBUjwt0=;
 b=yocttNqiM4zy4y2Q0FMMz93BVPVzxbRk0x32aSxB9YjW7SZpJA7vKCGCXIpj9qseZdBbK3/XXeaNmBelTMPwKR7o/W7TyV6prIacqfZBIf9AtYmJMmuKUlS4hXJrxS/LZLYYXLWo6wbYVTvQ3Xqnwe8wn3otmLhTtuxj2tKgjFY=
Received: from BN6PR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:405:4c::20) by SN1PR12MB2415.namprd12.prod.outlook.com
 (2603:10b6:802:26::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 13:03:57 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::61) by BN6PR1201CA0010.outlook.office365.com
 (2603:10b6:405:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:03:56 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:52 -0500
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
Subject: [PATCH v3 08/21] cpufreq: amd: add acpi cppc function as the backend for legacy processors
Date:   Fri, 29 Oct 2021 21:02:28 +0800
Message-ID: <20211029130241.1984459-9-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2302096-d2c1-494e-2f9e-08d99adc911a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24159C8E9E9254DEB6D32897EC879@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEaQvijcXNu7FcVcas38QELywIzn0NqZvBah+yXB1jAn8ajW0xrP4QjBFxeonxMW1dwY/st1Mf97JukiwzVvLipG4lD4zZCn5Z+hAlzraJCveFjBJybzWBkOOIuHuW/eyY0JAIyZXj2ycQEIpn4nVnHFoLFqoWazQc7ZLc1YCxdy37P26ZYuGAdw98ReLs84CeSIY2Y1lN4C85ZcxJHaqL3NSdepRHqc07x1jfs4C3GwR2SFmg/dEFLZ5pUe9LbEMBWMw4QQat7BCqAk2/6byiqcgAivQSUlhpjy/5EQYdj+uOsKt54n8neOVrcPrlfAftUrFTO9LWL5r0T7bBK/W43aCHFttbfBDfCcr4Xbqlyl2GW3wnfEZw6sLH0G8XE3OgGSf3r2Pen3vBPg9GeJ56Ba276tP/zwZuh5d3lZlsO1iEc4s135DkXDC7QfxHkN3oeN07MVjhNiKC8mwjK9lHjMLKIfCr19jAYvatncpV/7bzWXI+1/FIJf5cHy1IXzOLk4rY8926BAZXEpXLmTvn57TKnzGqUQtQRa/Eia6UY0je42rqfnClXQ8jwYN//LYhSBVZCeJLsdmCArhskcHBPMgWwWtB/IhEERshCri3/eW2YmyZxP1nnnRfkpZmDyuEnjf4Lh91HtU5wLc2eACVM4VH11V4eztyXi5s8Ll/Dcx/rCCspJpGEmIpUllG1NQ28jSM22fRurtlCGmNb5iVB3hJ5XiQNyxHlny0bVScQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(1076003)(8676002)(7696005)(83380400001)(2616005)(6666004)(8936002)(336012)(36756003)(356005)(26005)(70206006)(7416002)(86362001)(81166007)(70586007)(186003)(508600001)(16526019)(47076005)(4326008)(5660300002)(82310400003)(2906002)(316002)(110136005)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:03:56.7091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2302096-d2c1-494e-2f9e-08d99adc911a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
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
index 55ff03f85608..d399938d6d85 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -73,6 +73,19 @@ static inline int pstate_enable(bool enable)
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
@@ -103,6 +116,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
@@ -120,6 +151,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
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
 
 static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
@@ -346,7 +390,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	policy->fast_switch_possible = true;
+	if (boot_cpu_has(X86_FEATURE_AMD_CPPC))
+		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
@@ -397,7 +442,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
-	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
@@ -421,10 +465,14 @@ static int __init amd_pstate_init(void)
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

