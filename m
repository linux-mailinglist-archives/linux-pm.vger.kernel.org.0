Return-Path: <linux-pm+bounces-7629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C908BF6ED
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CC31C20FAE
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9834B364AA;
	Wed,  8 May 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OmTEmCyd"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4492E40E;
	Wed,  8 May 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152900; cv=fail; b=DIOCavzctb6pJI7KtPOMRUetcYDpna2WyGVNOqXXgHIHLKP+AEtIa2HFGsEwFtl75hpX5UZ3lN/iLQY3oabI75W045dwjEzIr0oZFA+kEN8zvyuwioEB+haqZUGbBU09des+MtNGM0qcIKR+GMvaR4cKpYrkPGaHrIn8Q/kD2X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152900; c=relaxed/simple;
	bh=0dghC9Gb1tCE887cWqM58tpg82BP2Al8QCSx8BHQYTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPeihnA15UdiGaM7kF92yX8KwLDEAdWMp46tl21W9WvB9wX4g1jWm2yhtEItDsZKUww/z/EmF0Q6ES8ijNfuAU+hpLnaKL95+zw0ypn4YZWCPmImLsD+MjJ783nf4hDzHLkJps33bpz3SmGh/+RU+UcqdJu4YlLmW4oKyBphpgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OmTEmCyd; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HspvGWzMfN3wBl+laJIlGipAw76W/7C576TuXdANA5g22SwNrYv3R6noiaxyLhRit1DpUu5CDQEqxO5QiZ6xzul7P8K0GQlET0YwW25qfpyHseAX0HfRc3cSxG8G7LUAWx2y9f3cstXeZCTSs5MT75W59hq1GJvK0T0pUjqqc7v09Ex2Jo9bPKTznt3qGDWTukEjYL89QJbcn9rT1FO/rsmVCJAv5rzkazm0P5cpinWAJ4XD3GEFqpLPSlbCfGandf8c9FH81zfyN8LKIWwoGHaqbZuiOn0txSFslsGu6Gin4AuG+CGCvHQZR1RJvPztyoRBaz19/Z1UEe4MnQ7SVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDFlRLzJYPYSSOp5lp8EMyLfuSjXwx6x1lCUhGk8YMk=;
 b=ZnUi8+nhBqEpbmLJfFJFhKuYUUUt3jc3MinC+Hr0XPsiwL1mQROyKUK7Wdijrl2J0k3sp5mJEL+fVpg8kdD/VDQWnVpPFUnxGPqd3boVfk7faj4dn+wzwi6HhH9qflT2ffEWlycfTTWwuYY++DIis4p+86OJ5PgwS/R4NukPIS/S1UvBu4huMDzzPA7K9sRr7U5tSfnAkTrIL8eJVWuMiv/xPPsvCU7l5x84l4wqEi4z7T9hqUMVW2E6J4UHtfF1EF1JQRc7zqWjToCkzueqi8huLYz29Cly2DU7Z9SnIK7HxYJus7GlGhpBNc03BXsnL2+GH4uxSbuGmKN2vWGk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDFlRLzJYPYSSOp5lp8EMyLfuSjXwx6x1lCUhGk8YMk=;
 b=OmTEmCydKPg62b1lAPs8672su0+LxhDS9UUjvJ/7yRu2zhLAVaVga2wIacGKbtO2GjYbqySu+0Oq7itVFpw3jpI6SvYQGhfLVnikMlGYMyWgv3GnrPC+5ExULrarKi0jLiFKKzEt35lJH8Gw7tSEi0SEvcJ6GIjtQbxI0Nx90Jk=
Received: from BL0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:2d::36)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.43; Wed, 8 May
 2024 07:21:36 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2d:cafe::ab) by BL0PR03CA0023.outlook.office365.com
 (2603:10b6:208:2d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 07:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 07:21:35 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:21:31 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 2/7] cpufreq: amd-pstate: initialize new core precision boost state
Date: Wed, 8 May 2024 15:21:07 +0800
Message-ID: <72f480a529166892148d6a5c774b5ede37037fea.1715152592.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 312aae9e-907d-4a49-0672-08dc6f2f7e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gxh5rscHvjPMHEgFOKKDL5rZ8GrJyU7CB0GZeNGAmDXFpAlBiuJJcvTA7NfE?=
 =?us-ascii?Q?GxtF+frsyd/iJ/2LRBVMLw7cpvM29moO5UT+H7FSGDwQAjtllmhq4le3CqJZ?=
 =?us-ascii?Q?MJo59IJY5AS9RVIj809pPENAiTkE22MNUi8U5d8ruFte/IN6nyR4/Xj9JrLm?=
 =?us-ascii?Q?Z7E3ByxfhhzgSKz1vVi42hFbus61bHkbno5n9tbkYSv7RBE4LlVOT7+CChHG?=
 =?us-ascii?Q?CMRPBZaL1AwVaGo/uKoVfT459uFwynW7gB6v+5T5x6Om0KbaemtZmJ+Z0hak?=
 =?us-ascii?Q?9TGJqMGmEJQbNGGZc66Bo3LwtXLDP8iha2nMl7KFZ4EYExmUVMYrw6QjQP3P?=
 =?us-ascii?Q?2auJR8QCTn8R5W4QGKWyDj3252AwRa6I9TrPbVDEJp8pTDLj2G1ReUCAEBRB?=
 =?us-ascii?Q?RJeD+zE2mizO0lw5CS7E/Jh0A3jbtrDVopv0p791CbuBBig3ZS0B+jn7DJe5?=
 =?us-ascii?Q?iA/DNhrOsjEQ46bBQN3xSMMzrxIiPfwCcJ/HzQsz71oAHBxWtqqXXnNcsFWd?=
 =?us-ascii?Q?Gne4ZarcUq10pBTOeNWbNPdMu5Iug1uLGCbjLv2ijaQo47P09taNpIjhhPAU?=
 =?us-ascii?Q?7FyXgjY24bT9KOYNsyPAX73LL3mQdKDZiQ56jTgBrQx8N15c3N1dT9/VAWXH?=
 =?us-ascii?Q?52U7Vjj5hLmKWkGVpxplJZ0UtYEHlVuLTzqwamaPNtR9rASel9oZc0dLJXMy?=
 =?us-ascii?Q?p4aha733BvfF7DSGtjpFGn9R6hZsj71k/6aeGqvs1S4BRp52VP3zKNi1q1Az?=
 =?us-ascii?Q?rp98q+ze3gh7gq8pFDhzxtUzh4fOJYfwlF/eFbMCWqJuufHn4zmiAvaDRg8Q?=
 =?us-ascii?Q?uWp8+JM9SseytVg8saR8b+v7qoB+hiVAigxofuydqRoyrugAnSadcnQITHqF?=
 =?us-ascii?Q?xUFQl//sJnobs7zmDAfD+mBvwd5pfUwKDhpBVpND99tZQWyl1begepzecfsl?=
 =?us-ascii?Q?tIIGYz34iYrZ30WqFF94dG3wTbubKvghxLZPSyvtA833xiLdE48fCOk7ecg6?=
 =?us-ascii?Q?XN/lOJXYR9VWYMmU1B+rTnockJnIEz/p509oezJCgg95QTFCqgYewyfC9BTt?=
 =?us-ascii?Q?C9zMRD4hdKDlhVG/X0SmMaHvWgl35j3hi6JuSwgKRCMEl4fRI9VTkZGT8Zqc?=
 =?us-ascii?Q?Kc3G1z3sCzLXbCxbz6F5mNjJtp8T5wThomEjYKO0qTvgN52O2NR/voKzDtlO?=
 =?us-ascii?Q?9e2C6+jrfNyBMyG6b0iPvA3qilf3AMyQerxfJWtL3NRbE+CU734ocePVDe+1?=
 =?us-ascii?Q?LarJ+eUrFnpql0GrebdRi1kcrzcjmcPzqlWo1z7JS1qm1347vgRSuHp8zhoG?=
 =?us-ascii?Q?s9cbg3H7ZETdCArUY65J2y9g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 07:21:35.5961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312aae9e-907d-4a49-0672-08dc6f2f7e83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694

From: Perry Yuan <Perry.Yuan@amd.com>

Add one global `global_params` to represent CPU Performance Boost(cpb)
state for cpu frequency scaling, both active and passive modes all can
support CPU cores frequency boosting control which is based on the BIOS
setting, while BIOS turn on the "Core Performance Boost", it will
allow OS control each core highest perf limitation from OS side.

The active, guided and passive modes of the amd-pstate driver can
support frequency boost control when the "Core Performance Boost"
(CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user
has an option at runtime to allow/disallow the cores from operating in
the boost frequency range.

Add an amd_pstate_global_params object to record whether CPB is
enabled in BIOS, and if it has been activated by the user

Reported-by: Artem S. Tashkinov" <aros@gmx.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 45 +++++++++++++++++++++++++++---------
 include/linux/amd-pstate.h   | 13 +++++++++++
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2db095867d03..f7dab0f7b452 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -68,6 +68,8 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -647,7 +649,7 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 
 	if (!cpudata->boost_supported) {
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 
 	if (state)
@@ -665,18 +667,31 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	return 0;
 }
 
-static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
+static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 {
-	u32 highest_perf, nominal_perf;
+	u64 boost_val;
+	int ret;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
+		cpudata->boost_supported = false;
+		current_pstate_driver->boost_enabled = false;
+		pr_debug_once("Boost CPB capabilities not present in the processor\n");
+		return -ENOTSUPP;
+	}
 
-	if (highest_perf <= nominal_perf)
-		return;
+	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	if (ret) {
+		pr_err_once("failed to read initial CPU boost state!\n");
+		return ret;
+	}
 
-	cpudata->boost_supported = true;
-	current_pstate_driver->boost_enabled = true;
+	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
+	if (amd_pstate_global_params.cpb_supported)
+		current_pstate_driver->boost_enabled = true;
+
+	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
+
+	return ret;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -899,6 +914,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -954,7 +974,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = cpudata;
 
-	amd_pstate_boost_init(cpudata);
 	if (!current_pstate_driver->adjust_perf)
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
@@ -1361,6 +1380,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	amd_pstate_init_prefcore(cpudata);
 
+	/* initialize cpu cores boot state */
+	ret = amd_pstate_boost_init(cpudata);
+	if (ret)
+		goto free_cpudata1;
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1414,7 +1438,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 			return ret;
 		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
 	}
-	amd_pstate_boost_init(cpudata);
 
 	return 0;
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d58fc022ec46..8ba5dd4d3405 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -134,4 +134,17 @@ struct quirk_entry {
 	u32 lowest_freq;
 };
 
+/**
+ * struct amd_pstate_global_params - Global parameters, mostly tunable via sysfs.
+ * @cpb_boost:		Whether or not to use boost CPU P-states.
+ * @cpb_supported:	Whether or not CPU boost P-states are available
+ *			based on the MSR_K7_HWCR bit[25] state
+ */
+struct amd_pstate_global_params {
+	bool cpb_boost;
+	bool cpb_supported;
+};
+
+extern struct amd_pstate_global_params amd_pstate_global_params;
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1


