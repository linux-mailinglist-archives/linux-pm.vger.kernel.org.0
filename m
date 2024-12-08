Return-Path: <linux-pm+bounces-18759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4CF9E8402
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB78163AEB
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA8E156F28;
	Sun,  8 Dec 2024 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WSsbY91l"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF615574E;
	Sun,  8 Dec 2024 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639472; cv=fail; b=mMk1DPWtMyp66taumERdld60Z2Um6s/uVXWNqbbH/tuzTD56nKRYdv1ow8qDWfAZAWTMEA57uUTwcNKlbI+xYIPYSZBKiU0rFFA/DrvRB+iK4Sirw4OEuL9NMCITw+mTzQV1JigtrGvCONoa0V9SuWXrqV0kOE7A1VF9tpERf2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639472; c=relaxed/simple;
	bh=aw9M/hP99koK1j9c0Kt7OIkvWJioIu+97d+9XOaEddI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l444fCLwQMTSJ0ITs/SyAojZjOXcaWTh2rRIZWI9B3Bc7z5l6aOkN5jwI0h/WN+hmUwtxwElr7kwlLuAEBrLm3hhjXEy/DKiNHXfoFTUb6QIPS3ibIq9vR3BG5GwDk1Xr5AiHdZoOI+8+hiOy5lKoUGxTiJPVYD9/liQH0C3nBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WSsbY91l; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnbvApNx+Q7cGRt9NL6kxfTdKpSHF/CgptvOjKBEI8guJTN4eiSN0T6kKDuzZua+HBcD0M3SfOM85gH9dv1Oy05c59/rSpEGUOuPjSQkjRgD2rzQrtQYzgdKl2zv2MRryqcVvjIVEtI6dl/0x2F8dktUrO8esegDjb2yKQgeMfWHnkT5D7kpwde2AW6ZNebb6VNUbSo471KocI4WQnlyXs3sVtcKcESODoxiPZt+/YvUgGyZ+FRKtldniQZJEvHJgGh3Z7CcltuLa1K4Q9WoPzK7fEpiEdvJjgFgaTdc/Us2qFwqtdWiwZGB1DRmGZ9euphi6EYDm/tDNqnixOd2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py5/UWIEkshoUfSScG+iJG7Dl+3UQLTpjqI+k2pSVmw=;
 b=sO1Q6PGVtuJUTyDVD30ajfU19fxhCJ1Rol5STW9bM6/c7a+YtuUBtSst+9w7tnrQPEIOBBsd7yL2dJF5yAWrBabeetMgfi5ykN8jUK9Xrur45GDi+KwNq1oRoh1B8Rw37Ej5KJ7X/h90GRwfgj/Drv3HqVC5X7Jks9gHfCzAurWE6Nb72yJyq2I0oeSUndQ3DAWxJYLw4zqOsJzIUkn2/N8G97zUBQUHwldTKzZefKWyVL466vahIJkql6G7N3Ps1POUxwgHiC4/Xrqdp8BRpIP9KrsH5NuBQxIgv80ECW0hLLc/kyVslJaodjb+2L4HU/5um99+O5oIt9GhN9k/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py5/UWIEkshoUfSScG+iJG7Dl+3UQLTpjqI+k2pSVmw=;
 b=WSsbY91liYCqPp4U8iPGXIk2WzZrTszwlq4Kl9YyAGx6P793/Hm/wmkRB1niGibdRkafK1ARs7TH1joRvqf0MlIDIT+P83GtPNoJpTU6PfMvtjolfPIjtArWlCoczlvwyShRKKiI62rPNQYrAN0rO5Gb8dOHEL0iXcwFzRn09Tc=
Received: from DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::17) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Sun, 8 Dec 2024 06:31:06 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::7c) by DS7P220CA0003.outlook.office365.com
 (2603:10b6:8:1ca::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:31:05 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:31:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 16/16] cpufreq/amd-pstate: Drop boost_state variable
Date: Sun, 8 Dec 2024 00:30:31 -0600
Message-ID: <20241208063031.3113-17-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241208063031.3113-1-mario.limonciello@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6deb94b0-ce99-4a48-5d1c-08dd1751e507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uHzsE2g5oHB4ACY3AuM8HJ13FwxOhEAz4LGSYKYKHrQ1AuL/25odkCIBy9fo?=
 =?us-ascii?Q?NUONNy76KB8FfnOSiU8XT4atuHFzxUJ7ozVzUZmYbfsemYuypxHIC5agUSow?=
 =?us-ascii?Q?qK+pm06f72FYpQgxlRebXeri/rdNVI9Vhm+603DyJGUEep+WdcQaL2IKk4eZ?=
 =?us-ascii?Q?52l9tHVjtbYQwS8EtneNgbkIxmE1MAM21rdSsF9hiMkv/XCi+N6hUs4tdYqy?=
 =?us-ascii?Q?HIvwtY5s+m9NiLhymSFxxCVr/W2IQWLUM/tsW49KvL621dMeLMnX+q78c5Pg?=
 =?us-ascii?Q?3moSe9NEz0qxpFnJRoix97KJRxWtPDRxdf4PNssoSc4+yrlel/Bu6OiCTce2?=
 =?us-ascii?Q?bQpmZ1V3ynqcT5EMCvIZdU69Z14SjL7aBTLNZA3IOVnSJpSedk2lf844XSjd?=
 =?us-ascii?Q?6J5QI2I2Gn9jF8DQQz+Ezma235AkDc5oBUy65b/5ImGYbdPRPxmzB6IIN8xy?=
 =?us-ascii?Q?VsSy2zpBUzztZqI5DYdsBaaPSfEtVbcC7IaK6kCnu92doKAo9jvCh20+CYDG?=
 =?us-ascii?Q?JK+644QbQI/SnpNDkoHAVkwz04nQ1cbx1lRxUHGpoTiJkyrnurJLf49/MTBA?=
 =?us-ascii?Q?rf9eG+6q79EnJfrhf4Ew6y0d2hKrPpe6OHiqZL4OgQfOg/aMdjF6KBngFNnl?=
 =?us-ascii?Q?MALoqN30FzJLvaIX23XjJoLBiFOGqyOjsxBo/H0eAAtpqf0ppKo/XkTwCLRs?=
 =?us-ascii?Q?AKtnDBa58Kr42ILONyHt3Cbz9YjT/aN8KriAxo+bMxIPRQGvaLXt8yRPmOmD?=
 =?us-ascii?Q?DENThkvA9mZsoRFZwjlBwKwZmd/07ftRBERi5Nvkdv8aQEAKHA9V592Yh9Z1?=
 =?us-ascii?Q?NhrHtM2i3mHN7KDOdYXCVcwMzB4E7zvE3H/iigkx4yjCr79rkSI3tbMqkUU7?=
 =?us-ascii?Q?RsVCLFhFdJX2NF74Pq2wEROtvFQVa382SoVSiaYk4cHLGH48RY7iDYNxnMWP?=
 =?us-ascii?Q?xCb4D0vWDBvhuYuvdqIYwM/OdRpnEmrBJuvHz5DHNijUDkcj8lIg3ATKMh62?=
 =?us-ascii?Q?Cm+zJ4AS5/ZoY9v4glsRuTsoo62LesX5z5hvEEUi+m90OEEPO6h9JwgLrSe+?=
 =?us-ascii?Q?xXAExbsYF3L39QQC0HDqxqBxVq9Iszw4pfm1C+ZaraEqC3KcxmunRanrxFEH?=
 =?us-ascii?Q?qZxwWJTqpAXO69Rx2FG1UuCK715DeGAVND8xHomrjj/jE1l0WpVAFMo53piG?=
 =?us-ascii?Q?XSXc+EGJeGaIaRlPKzC7xusdhuOUGOeY5TUt7CMFRfrfW0Kmkbhbw1vjg/Y+?=
 =?us-ascii?Q?bUtN8SkLbGOLx0vt8nN77G1EGrSgxmz4CWH0xOwxnVaMgZLu1On9G4HL53b1?=
 =?us-ascii?Q?Vuo3gwk6QQ4cBJmrE8Kvdgt5BRiBCfCSmC979DU49JNCOLuJHnI752OyevnP?=
 =?us-ascii?Q?RYzd0WyOYaTHrpKnSozZBfPQvpd0PnNc2gGpjPg9R+ePAYUBabgtdxQPnW5q?=
 =?us-ascii?Q?Pb/IiT+kgMf1Kxl8oCXh1shKpu5QKJ5h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:31:05.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deb94b0-ce99-4a48-5d1c-08dd1751e507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493

Currently boost_state is cached for every processor in cpudata structure
and driver boost state is set for every processor.

Both of these aren't necessary as the driver only needs to set once and
the policy stores whether boost is enabled.

Move the driver boost setting to registration and adjust all references
to cached value to pull from the policy instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 26 +++++++++++++-------------
 drivers/cpufreq/amd-pstate.h |  1 -
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a4ededb8d89df..3f6208828c063 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -315,9 +315,10 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	return ret;
 }
 
-static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
-		int pref_index)
+static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
+					    int pref_index)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	int epp;
 
 	if (!pref_index)
@@ -335,7 +336,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 					  epp,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
 					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
-					  cpudata->boost_state);
+					  policy->boost_enabled);
 	}
 
 	return amd_pstate_set_epp(cpudata, epp);
@@ -746,7 +747,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_pstate_cpu_boost_update(policy, state);
-	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
 	policy->boost_enabled = !ret ? state : false;
 	refresh_frequency_limits(policy);
 
@@ -768,9 +768,6 @@ static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
 		goto exit_err;
 	}
 
-	/* at least one CPU supports CPB, even if others fail later on to set up */
-	current_pstate_driver->boost_enabled = true;
-
 	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
 	if (ret) {
 		pr_err_once("failed to read initial CPU boost state!\n");
@@ -1176,7 +1173,6 @@ static ssize_t show_energy_performance_available_preferences(
 static ssize_t store_energy_performance_preference(
 		struct cpufreq_policy *policy, const char *buf, size_t count)
 {
-	struct amd_cpudata *cpudata = policy->driver_data;
 	char str_preference[21];
 	ssize_t ret;
 
@@ -1190,7 +1186,7 @@ static ssize_t store_energy_performance_preference(
 
 	guard(mutex)(&amd_pstate_limits_lock);
 
-	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
+	ret = amd_pstate_set_energy_pref_index(policy, ret);
 
 	return ret ? ret : count;
 }
@@ -1265,6 +1261,9 @@ static int amd_pstate_register_driver(int mode)
 		return ret;
 	}
 
+	/* at least one CPU supports CPB */
+	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
+
 	ret = cpufreq_register_driver(current_pstate_driver);
 	if (ret) {
 		amd_pstate_driver_cleanup();
@@ -1604,8 +1603,9 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
+static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 max_perf;
 	int ret;
 
@@ -1619,7 +1619,7 @@ static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
 					  cpudata->epp_cached,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
-					  max_perf, cpudata->boost_state);
+					  max_perf, policy->boost_enabled);
 	}
 
 	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
@@ -1632,7 +1632,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-	ret = amd_pstate_epp_reenable(cpudata);
+	ret = amd_pstate_epp_reenable(policy);
 	if (ret)
 		return ret;
 	cpudata->suspended = false;
@@ -1690,7 +1690,7 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 		guard(mutex)(&amd_pstate_limits_lock);
 
 		/* enable amd pstate from suspend state*/
-		amd_pstate_epp_reenable(cpudata);
+		amd_pstate_epp_reenable(policy);
 
 		cpudata->suspended = false;
 	}
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 7765c82f975c6..9747e3be6ceee 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -98,7 +98,6 @@ struct amd_cpudata {
 	u64	cppc_cap1_cached;
 	bool	suspended;
 	s16	epp_default;
-	bool	boost_state;
 };
 
 /*
-- 
2.43.0


