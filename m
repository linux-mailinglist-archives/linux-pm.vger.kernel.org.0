Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861FD456D7C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhKSKf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:35:26 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:29536
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234774AbhKSKfW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:35:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUeJmRGg+snHjU5AIsupE43R7whWnMeQ396r22b4P8IiyEK8nTv+yPd88683uyoHUbwqnNCSwcpYdzyHXavsEZOa/yTC+j1COBX2JwZMElbqBlp1wxm+xYvFU2YpCjb3jICBxyrM/OJR/8nx7aNOYSb8XSR4JZ3+ip1MPcQc8w9iNTfQVeLxECv8Gy61NqqRDtGGLd6k2XvqnQKw7ROmy+uNXBs69ynsnEjVNxqq1CZYyLRXJxH+I6HW4UNKjvoyAMjSoWP5fJqvRuWtF1hkRiMIKQcTdw7kiFwg6N9WW4M7s70yXQ+vTl6VbS7p6GsOwHIrx24vbyfe35JOyBU/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HimQ2a0IjlsggO31Q74YZ+R5Ds8EnVOO/m5IGwx16N8=;
 b=APN2qAUQZLjWHUE0cBVj7jmPssec5nnARdnB7uhZykUW+wwDOcG8wC1D0omFljx1s1X83ODSFptvoXFsRwptBPu8F/q5tfgJnrLRw7XsS6PehtTSGWtnv45bmxLwDeva/Kci8xWKo/74F/h7auv+AzC3CpRHuquo0nv577WlUo0TK8lGrtZNwA3CNRWRc0J3/gsZsy4i95j9lBFvTg6w0MQ4J6A9uYEzdmxyze7jM2asK28IqXwaeVQigYQZkQwJYJ0SzwdSQ6/tSOo93jwqFMYs+pc/kn3tsJP1KN1O3VI0Veu8/7pZ98HDRfjrNjqY20wcC+nZdPkQd0UcJ329Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HimQ2a0IjlsggO31Q74YZ+R5Ds8EnVOO/m5IGwx16N8=;
 b=c799eIPEYsgZWpLcesh/IoTfpWhhTy4Jy2kO4PqiMuw4TR501BGzSrjaPo2iSkB+GZxB+VHflWeB6G4B6o5h+yt3CEdC5lTqinhDc8qYcTkxkP7ydMeUcQ8aS/auhaCSWy4kon1sYufNXt744l1Goqbm0BqFxn0NrXsM0T865Mk=
Received: from DM3PR14CA0132.namprd14.prod.outlook.com (2603:10b6:0:53::16) by
 DM5PR1201MB0186.namprd12.prod.outlook.com (2603:10b6:4:4d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Fri, 19 Nov 2021 10:32:18 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::d4) by DM3PR14CA0132.outlook.office365.com
 (2603:10b6:0:53::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 10:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:32:17 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:32:12 -0600
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
Subject: [PATCH v4 08/22] cpufreq: amd: introduce the support for the processors with shared memory solution
Date:   Fri, 19 Nov 2021 18:30:48 +0800
Message-ID: <20211119103102.88124-9-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52c6bec0-c808-46f3-820f-08d9ab47dc7d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0186:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0186E7180DAC7EC317AFB521EC9C9@DM5PR1201MB0186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKyucVZBV61Ho9ogg0AD1ywTQXZWihZAmALHPJIfUW92CJ2BSsolkUGetBO2+rtSoaROJvZ4q4BJmA+tlxJRCTNQPUS0M2Zw+cQRevSuhNkezNIZFmMP9oQ+MjiXmoQKxrb0BhPJ6bXQXfujU9ASMTm6m/2uAs6o5PVn3hjm11CEGsa6jw8jHmzwCLacB7jqWQI9RfAmPEcIdfwofhVH8oFSbNFfjLSHUBa8ElkrmWBnyJzXyimCgTErGtKdKfIBe1/tveqbfg4GK9FLNyIvP6xc2JgrPJR+Jwl896SVW9mQ7k1V3J97Uxd/D9CcJg2up/csLR+mApGAbigiqGGZz8gWfvOTV0ClPERFo3kzGUXZZVDOHVsEskdCr6TzAZKjOU1mIePItWQMKoU1LGy9lBeJuHm4sHRFoOprIzqkn5hLCqPJIjkHkyonr/rbkjGfAjr/AaTh7rj1pLZ+jceA3NZ3fAJt6W4RoDEWA7eiio+Dd0ns4vGJONGUWgmjpj5T8CtHOxlC7ksci0MMYB6vFOgOhFVMHsSz55LwHhymqvYHmR6RhBFGfOhJAqP2ovt4EnAownnthGaJcb4ygRxGeDV6zAesufgTShKDF8POWIareosiz3mZY07SNi97YtgqDewtIqDhCU8nFntOugOFJ2aupvAzq1OYqYvA1YsOzZ1PwNFY2ikMLFhrg90g0lRAkjOlT2tMdRalPb+2VDCpqmu7ME6ZXpKG3zMtLFYcBos=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(26005)(336012)(508600001)(110136005)(82310400003)(7696005)(2906002)(5660300002)(426003)(36756003)(6666004)(47076005)(4326008)(36860700001)(1076003)(8676002)(316002)(16526019)(70586007)(8936002)(186003)(70206006)(2616005)(83380400001)(356005)(7416002)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:32:17.9006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c6bec0-c808-46f3-820f-08d9ab47dc7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0186
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In some of Zen2 and Zen3 based processors, they are using the shared
memory that exposed from ACPI SBIOS. In this kind of the processors,
there is no MSR support, so we add acpi cppc function as the backend for
them.

It is using a module param (shared_mem) to enable related processors
manually. We will enable this by default once we address performance
issue on this solution.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 71 ++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4a02a42f4113..14a29326ceae 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -35,6 +35,19 @@
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
 #define AMD_PSTATE_TRANSITION_DELAY	500
 
+/* TODO: We need more time to fine tune processors with shared memory solution
+ * with community together.
+ *
+ * There are some performance drops on the CPU benchmarks which reports from
+ * Suse. We are co-working with them to fine tune the shared memory solution. So
+ * we disable it by default to go acpi-cpufreq on these processors and add a
+ * module parameter to be able to enable it manually for debugging.
+ */
+static bool shared_mem = false;
+module_param(shared_mem, bool, 0444);
+MODULE_PARM_DESC(shared_mem,
+		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
+
 static struct cpufreq_driver amd_pstate_driver;
 
 struct amd_cpudata {
@@ -60,6 +73,19 @@ static inline int pstate_enable(bool enable)
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
@@ -90,6 +116,24 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
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
@@ -107,6 +151,19 @@ static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
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
@@ -325,7 +382,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	policy->fast_switch_possible = true;
+	if (boot_cpu_has(X86_FEATURE_CPPC))
+		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
@@ -375,7 +433,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
-	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
@@ -398,8 +455,14 @@ static int __init amd_pstate_init(void)
 		return -EEXIST;
 
 	/* capability check */
-	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
-		pr_debug("AMD CPPC MSR based functionality is not supported\n");
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		pr_debug("AMD CPPC MSR based functionality is supported\n");
+		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
+	} else if (shared_mem) {
+		static_call_update(amd_pstate_enable, cppc_enable);
+		static_call_update(amd_pstate_init_perf, cppc_init_perf);
+		static_call_update(amd_pstate_update_perf, cppc_update_perf);
+	} else {
 		return -ENODEV;
 	}
 
-- 
2.25.1

