Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD54187B1
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhIZJI1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:08:27 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:7648
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230092AbhIZJI0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:08:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBoWFa2WMn7msnAmn+CS87YsYe1IG7xU5lejES0V+QOr9BXFVDn/pEre2a9EDpVRyGyZ1y1lkDA1DACtJ3wKRCCd6q/tG8FckuqUJAu2Dmwfyn492Cqvl28dRjNJypBO4gT2kO5cAY7Le4MF0eQJkITMPrxooRCeGBqDBmJov1Ad8FI7LtPPRzAKGJx7uBFEp+q+jA8FSBSHR3GzP5vPS1NAmRLv0WRzmH/tQ+BhoTJN1QkLA3fwc4woyuGGFwX3sNMFjFYdh63/mNsOutO/tsUEALYXEBnDuLLtgk90GLD/VP/B4mIOMtk56tNjOeNCgvaVdxXTlBLrYzHIUd/IFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KYk9L/BHq4FYhzcsLsHj7oDc4uezoCbs0tBDaUrfxwc=;
 b=eehUqVfoyAES/OsogFO22eIa9vdFsBRcEx0Y27PjgAT3AYAAb2i0ugRBrzLffTeTdQHjN/Q8vwVXsxGjQo0tkHMB8whIcA3z0ZKV2Ah7lSPoXtdFgeNnZDma+B6mu+VibQfto4XkWDauIAcCzGHFyeSpFicyBtvYcAv1zgMOaBkJuckcA2Oy474p+b8AjynHM7xiYpNILcmNQx2K6L96iFKyyGElNKv4jdSgL5Lz6IKl5yZzRd1RUJJmIqOQP6YsBK2MwHDtE9Gzr4htWDvuJy5yYgbM0/05oo30QzmpNitVOLQeP2hTFRc2hVQ69lhDKUvJ39zfoDl7AlgYcCMCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYk9L/BHq4FYhzcsLsHj7oDc4uezoCbs0tBDaUrfxwc=;
 b=QqGGYMRcik+M0YUK8YmeiqVxzPgnxENWMwuceul+I3neb+ZqRgII24IkwMmJCWpeh68gXCY3UFS4QiXLPWaauKuqmQOxNwEnbLpEdlYvdQfj7jUvPgmRmPxLuDIghCLtALrSaK8Bso7ht0Xul3jCEz4i46rBC9euASsZgc0KnQA=
Received: from CO2PR04CA0136.namprd04.prod.outlook.com (2603:10b6:104::14) by
 BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sun, 26 Sep
 2021 09:06:44 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::d0) by CO2PR04CA0136.outlook.office365.com
 (2603:10b6:104::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:43 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:38 -0500
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
Subject: [PATCH v2 06/21] cpufreq: amd: add fast switch function for amd-pstate module
Date:   Sun, 26 Sep 2021 17:05:50 +0800
Message-ID: <20210926090605.3556134-7-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 466198cd-99eb-44dc-0ff2-08d980ccf5f2
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:
X-Microsoft-Antispam-PRVS: <BY5PR12MB387699B39921F5C08ED88FACECA69@BY5PR12MB3876.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWkg9WiqcwM9JpeugJf3jHtFjSzVZwNu44/bKC4ZS4NR+zV12zUNfwWeq9U/mpP8EcQZE8VIYmJ/gswFMkmQxVlPdMxFqtJDuvCP7lS8XADQydnBZy5JhratS3vLhEFaLCpdsKlwmLpT/C39XRfoNw6cxQgXdEe0058QLl7uPxxyaBqdPVU2fRBUiJJsLySDcGtjHavX1tvbg2Qu00rRykcRI7ycjTmRYuyGh9dqpzPtTCCFkRLMSYqffen/wYA5pxDwXYbYAEIPkzDtiMigxlkXq3OLltLFX51qrzXOKuV1yBvl0nVKfDMqCYUQurhS+TATqnqD7NZBrgxNb42YFuAHISvncCqhs3jrslv6gRwgPNGyPykt7RnrqErYOtY6eJGwL2hV9iVdIlWLXelfVckJ+2+VExluRz0nY1dtTR5bRG+ShrnaPC36AlJlrMtOiNQqNzMeFXt8IfZnYtvAKT+G5oLD6/UFtc04yTjDGMrDzam++dHdrzK5cS+1StSRw2aj6mqb4DHDl3NepPLP/R0m4tIVUC9A+ZH4l7oLJC/6FhJsj+oc7byeSDqzANqJNtaVvClS65u1yYEX+7S2ahBJzgGcwDUjRB3SX/3f3OqM3mfXB1NUXgBEAABkh202LJypBx+ll23s4NaxShofctSs4wDK8MEZKNqnO1svx3icguiAKms2XD19hY9AdbrtGfn9kYsnUumoLTdOoXwlV2B5rEAa8ZvQah3rS3IOigQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(508600001)(7696005)(82310400003)(83380400001)(26005)(110136005)(86362001)(316002)(70586007)(8936002)(426003)(16526019)(54906003)(81166007)(36860700001)(8676002)(47076005)(70206006)(2906002)(356005)(1076003)(336012)(4326008)(36756003)(5660300002)(2616005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:43.5982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466198cd-99eb-44dc-0ff2-08d980ccf5f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3876
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the fast switch function for amd-pstate module on the AMD
processors which support the full MSR register control. It's able to
decrease the lattency on interrupt context.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 693d796eae55..aa4610ad186e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -195,6 +195,41 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static void amd_pstate_adjust_perf(unsigned int cpu,
+				   unsigned long min_perf,
+				   unsigned long target_perf,
+				   unsigned long capacity)
+{
+	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
+		      amd_cap_perf, lowest_nonlinear_perf;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	amd_cap_perf = READ_ONCE(cpudata->highest_perf);
+	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+
+	if (target_perf < capacity)
+		amd_des_perf = DIV_ROUND_UP(amd_cap_perf * target_perf,
+					    capacity);
+
+	amd_min_perf = READ_ONCE(cpudata->highest_perf);
+	if (min_perf < capacity)
+		amd_min_perf = DIV_ROUND_UP(amd_cap_perf * min_perf, capacity);
+
+	if (amd_min_perf < lowest_nonlinear_perf)
+		amd_min_perf = lowest_nonlinear_perf;
+
+	amd_max_perf = amd_cap_perf;
+	if (amd_max_perf < amd_min_perf)
+		amd_max_perf = amd_min_perf;
+
+	amd_des_perf = clamp_t(unsigned long, amd_des_perf,
+			       amd_min_perf, amd_max_perf);
+
+	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
+			  amd_max_perf, true);
+}
+
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
@@ -333,6 +368,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
+	policy->fast_switch_possible = true;
+
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
 	if (ret < 0) {
@@ -385,6 +422,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.adjust_perf    = amd_pstate_adjust_perf,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.name		= "amd-pstate",
-- 
2.25.1

