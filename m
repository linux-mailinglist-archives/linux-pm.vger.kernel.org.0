Return-Path: <linux-pm+bounces-18858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732C89E9E6C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E122166454
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416B19ABD8;
	Mon,  9 Dec 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NZP/I159"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E01991BF;
	Mon,  9 Dec 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770403; cv=fail; b=H8Pk77vbnb74Ug68DBN/nTkcepJZSM+y4YH61cF5Uod/04fxV3B9SymZJfWHK8MApacmdqYhqu6KZW61Bz7zJtXZaTd77QVFeri0awHIwAki1y4GV+BXnOoMqo2GP6tcBC539R9kpsuOll3z+E2steTtbgvpwGcHv7v05JmLcGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770403; c=relaxed/simple;
	bh=LQbVt5UTqakgrgRPhjSC+F66lLYCils0aKWae30sb1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUxnLboPz55xIIOFsY8gJRwVnk8O+K8HyXm688pdPnfjLb5oN3VB4BVFXBYOUlvUywpk+qJqJkMxZWN22l2+rJJOzXL9phJdpHY12gTaG9FbMqkmMoQTnez8pyTjxmP3xLD1KwGuV8ItggnWZjOvugD85ke8dCIBf72aP58YfAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NZP/I159; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQzZWp4vWPGxtektQFkQUntMgYQPPxQ1bb6DbaMIZD356b1Y/Y+oiZ+n5z8u9FT5qV9oe8LbEz8zdhThBDv5z/2w5/g83zxxV2B/1CrWumMs++sQo4oLi+HDnZknlXawnVPdTsGScRXPdqatfqmti7MSeD+fVVEOGh3BOZzp/yF/6wPkPSGjd+unDi24mMocqCuF4vHtj2Q0em9OydmXfKFah8ELnYWFgAttHfc08iq7ELkAHqB7f8cnl/yz8603tYR5nd+UHQ50w1pT1vyAS8A39x6HNQxslrpf98app8ZoFud8gNOjG+Ei2+Z05hEL3UAemNY61gFSixkJv1YGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2iCgbCIsoW8ek4q1G5owfCjTWqZdu2I86kI10nIPJU=;
 b=JdWAjCIWefDCLQOc8uglC2Eiwuj01NoiNDCa0ftnXKMamiBrM6hXcvE2aIGC/EddAYYKawzmDyuWiNZHMtkXfbYxcKis4xSQI+MZvEhx003KyUIJa1k7/G/ZhevvoMarXqaNsRBUHXx9Ykr1Yhqk4oHB6/Y7lmcSLPtBKO33lT+R99fPNlauHLzSGQJBa3RsSXkGrUn4RgCq26Rjh9LDYcJQbq3ZBGT6Hmt4c03BPn74YZFUqNFOsk2Rq3jHPgnRRtzAakFkw2E3molQedJyW63QSEBLYjcxPJH8iJX1GVk7anHm8BCY4/gOIXJGSF72GRE6WlfFGeZKKoDPaK1TEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2iCgbCIsoW8ek4q1G5owfCjTWqZdu2I86kI10nIPJU=;
 b=NZP/I159iORKrbdlGJmSsy22DbZyyNg8IRSA04We2htbwHSELew7FU6r5SBTIDETQHD+jcH30sHUIregIDw3uI2KHIvlpL7rPvEgPMagKL310SrmMNLONQnd4M9et1kiFb57uRheUyF8VejW/TOLtQFSycvfcDWHClsONnaIsMw=
Received: from CH5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610:1f0::17)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:53:17 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0::4) by CH5PR05CA0008.outlook.office365.com
 (2603:10b6:610:1f0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.11 via Frontend Transport; Mon,
 9 Dec 2024 18:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:16 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:15 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 15/15] cpufreq/amd-pstate: Drop boost_state variable
Date: Mon, 9 Dec 2024 12:52:48 -0600
Message-ID: <20241209185248.16301-16-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209185248.16301-1-mario.limonciello@amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 14474434-b823-42cc-4962-08dd1882be0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eNmLjhPcD9nORovnbObWcTdExX5E92VZ4JEZQ9GOVFrqo7J2B4lq5QwwlWUm?=
 =?us-ascii?Q?LoazpDqeA2Dv5wwYvYB3wYCooRoTUJQZsxrf8iM+tkloNeMaduwMObu0hk2d?=
 =?us-ascii?Q?OZrkrVZzhDw72sAZLOk0eueF8spdJvFab+TiWZsIvrX32wVDP7iM/QKtSKdm?=
 =?us-ascii?Q?n0Zbe6KzGHw5xDPDIhvF43q/XpOcsQkXQ1nNZ7HEZe+cij70h0umHtNiDVNK?=
 =?us-ascii?Q?hJ734CI5udx88MFZYrvCrPuqZ+pr7vHQsEUI4vrDyzYIBsENxYKtoNwcn4UV?=
 =?us-ascii?Q?EMp5PQuNwhSjmEYGbHI75B1O6kjLQaX/V4r+LvX9kE6cZSVB5LblE7/WsXIW?=
 =?us-ascii?Q?4JaAQERkPHqOMAjKdtn3SKE9qDhH1uaYSVHlcIHmzod4u6JbzFGuQVviEBGK?=
 =?us-ascii?Q?T/73qOor9ba1cQPE6f7+avl9vYZL4yb9OA4Rb0WNajC/qxM0vaDCBQPln6d8?=
 =?us-ascii?Q?WRXuB6sz4zWSEMQBsQ8NVN/2slVPI7FCpYHm1MvPblg4E/do+edHZV8Zw68O?=
 =?us-ascii?Q?O/Xc866yaRU7shd7a1lkN/6YWhX51GK2GLXEtJad+MvvDKsvd3L7B58Gk7xp?=
 =?us-ascii?Q?vn4g0Iw4egaGGTcLUxGhKe+rfjpeKY6CDAkKXbFT5H/QHcB0bCOZEg072Fvj?=
 =?us-ascii?Q?4i6Igioy3CQKTTcDwqwnyJwwXk+NfTjynQLeXOQjFHDhzUig0C3ZSBlLTjVj?=
 =?us-ascii?Q?th54eCzW7tK+jSp7EB6nwtpG8vBvWF8tsLqhKTAJ6GxUxzvbtryBFAj4KzBP?=
 =?us-ascii?Q?oMzqJ1TsTxuumDQeyp0p/KS/VYSaVDIt1XBIaAliBU7vpMON02qkX2Nvx/pb?=
 =?us-ascii?Q?9b7RHWklfVy161xKsySax44eimw6WPbj8Si2NigkR92TCv7wEIYyXSUZbBra?=
 =?us-ascii?Q?yvAUW3jXLQrLfTEVgTjXXctCfgXTDxYAWR/ZoxU9iK/ruGVQwAQMDywdDrLm?=
 =?us-ascii?Q?6hH99Y0VpqascIQ1A4/91IZuxOBc9cvmItYup4yq1Cdrh9GWkfOzLoCIy1nO?=
 =?us-ascii?Q?anR9FWZFHpg7VA0q3k7wN3bX+eBFJ+6JWxGkNjBhXX5IyiN9mQRqCKxFhUce?=
 =?us-ascii?Q?iWqU90a/tC+b0rvK3U3fxItThZZPRZsDAA0cyN/IzO85IgFhOQPzZOfsEjRm?=
 =?us-ascii?Q?fy4jsGetGoA6Paf69MASGHQUdGKagZyOaKA5Zm9FzWiR05uN90vvzgYBAQgC?=
 =?us-ascii?Q?h0HFeLlBp02rnv4hv/++LZqUwvzMm+WywKwpa195wP27btw0gojdHZH3QPQJ?=
 =?us-ascii?Q?6crs99nGOx3g/UaeC509PxX1FIeIZ3mU4dnYEyoJ238LeZ2K2skI/JmTve7B?=
 =?us-ascii?Q?2AKhBnsP6Wr1a0DHx5rSyOBsNQPnysLRAo57i3ABRAj/mdVQ+dSALDa/2wyw?=
 =?us-ascii?Q?oJbM1jc28lo+ar3/qYROraoJ0u7r+oLxjLGur/M19CNxNXuHvAQ0UOJRFeeL?=
 =?us-ascii?Q?Q2Ej/oRF3WEddjt1NbDBiAHSMm4Juz8H?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:16.8857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14474434-b823-42cc-4962-08dd1882be0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409

Currently boost_state is cached for every processor in cpudata structure
and driver boost state is set for every processor.

Both of these aren't necessary as the driver only needs to set once and
the policy stores whether boost is enabled.

Move the driver boost setting to registration and adjust all references
to cached value to pull from the policy instead.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 26 +++++++++++++-------------
 drivers/cpufreq/amd-pstate.h |  1 -
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 308d30a25f100..f31703dbb754b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -316,9 +316,10 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
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
@@ -336,7 +337,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
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


