Return-Path: <linux-pm+bounces-18659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EC49E609F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D92284A14
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068F2101B5;
	Thu,  5 Dec 2024 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qrxsnnwv"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA21DFE0C;
	Thu,  5 Dec 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437759; cv=fail; b=sFzBhcqb8GU+pVmVslyJpiICqpJXVN4crhD7rGEnF8EZXgkx82Bz3SuXpDzOEMh35I+32pfqoR57brMk8l0x8trv1hqPV3EIuUDqds8+7jX7dAgRGGYcG5AGkZ9mMelYkDzxj7VKq8Wf2XNJr4Q2o7K0SVFPREXw2zAYgS8vjQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437759; c=relaxed/simple;
	bh=i/s/Zg5VPoNLessyqRI4MpioKonJrrbODTjg5YA7V1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNljSF2GidIMVi9xRu+tBibMtaE9zYzql0z4rBVw0Wcbo0Sl3XJZQhAVruMYcJ7PEm7w5sc2maJxHVCKkxo5oJwRljtupz+MKJM8zxhJOh3EPeAJW4tKV2zXwkr7cVDFbZmXSPHvNBniAduNM6iiTUOCLgvG9g7/d4uEv5SJGCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qrxsnnwv; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkTHOJCzPmywZfuGN3bG1+mxjICVQWAPXxUZXMI9EeKHoCBrczfZmQOrH1nDreBCivBnJgnoZeCMnYlO6KT05lMZLb6nUpvtOM557XfnAikOW+oxfjJsoRKRDyUKc6SuVx5twOthBE+1lzj2Fjcqp9qb7UWmrNXwBpOeHixc/so0IwiqI5HtVr+N7E+CAc0ndyxTiudFYe9V9vIYfe9AAkHzVVgw1Ud/dXDJPstRShvO1/m2BiCAy+VNx068rum5JfQHdT/0birOR1zU+p6x3wLlU4T4kN/RB5e6QEb3/L9YumWBPPaa3mEFf5DKPpY7UlIgmPBAAtgBCKmW+yGVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/9QYGafS02qTWYb6l0ms4blLonCSa+pLGay2gdNG+U=;
 b=h+BaWyWrcQA+L/HkM/rVOogoPjHwOQUDdantFStg50nlZl5n1d30e5zpCBvvjh2+QEed1BdhSHT28fuuAsn07v3PPxy3wHDQwkZjJoEoP6wYPPQ6y4eFN9pBcMfxiLgJPbynUqJQvM9zWBbBBqsGuRkOccViL+hpG5UdSWWW4IuC5FsUjBzbBx0K04AdrxtNv+jvg6DR9is9MxhfWNoy3YWQJfwtg0Ee8Vvq27e/2kEwsGDJXqLPmMfuiCTe7HPIRb4YJy4++4wur30r6a5Oc8wQrtSfCnVt3OAcz1skAYS3/8kH5xXo/z71BRsR7m6/QtmwN1Pv6YSKuhVV2wkdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/9QYGafS02qTWYb6l0ms4blLonCSa+pLGay2gdNG+U=;
 b=qrxsnnwvLFdsHXbfwrwxryjXmKDBdFl5E0jWfEvFq2rmyIYTC9TQm6Q0M3tU8MNmAB6DxOnQnAyiOjLQygb9DuuHVNCuZMQeEm4adNtr7fyVjgkhr3XilqAGWM+m4X1D4vtuPVUX204L437pMLaO0JGjpc3+V9wIxYHqtYRRuCA=
Received: from CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 22:29:10 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::8c) by CH0PR03CA0217.outlook.office365.com
 (2603:10b6:610:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 22:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:04 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 08/15] cpufreq/amd-pstate: store all values in cpudata struct in khz
Date: Thu, 5 Dec 2024 16:28:40 -0600
Message-ID: <20241205222847.7889-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205222847.7889-1-mario.limonciello@amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: e61af534-86df-405e-5f3e-08dd157c3cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ahof5tLOXuTmKJsNsRv3SdbaBigGG9paNmChVBxuXQ9gT+8H+9G1MUzdvlW8?=
 =?us-ascii?Q?Vj51N1lCh1fN0w9JaLP0DydeO6dPj/CyyoDnYkf1QHYrP1XFw6yVfoT3mhtP?=
 =?us-ascii?Q?rxmOLLcyvsm7IuiH6WZb/gGfQIhMOJpFoZsTzHa49keHhXeN2mNAihqDsrqE?=
 =?us-ascii?Q?tJ8csrl40cuj0S3Y5/vepU1EqbLaP2E5Uci60u0TDruM4obHEcQ4JBYUO7ve?=
 =?us-ascii?Q?h0e/aV/Mqu9ab2+9hqG1xOe97OIipU6bLYYnvgawVGjkrIH601HJpwMCMkJX?=
 =?us-ascii?Q?kQUns+EuOtYajkkgzwdxK4J1xm4LYmz5ukKK33CE5mNYfhzt85iqrQIfHZQR?=
 =?us-ascii?Q?/ZTHoM+Db+ThadYC9DsyuZO0bLUilY5fAteWIdtavTcXpPn9qVOXGfr0ITGg?=
 =?us-ascii?Q?/BrgzN8QSjmUL7pfJOkRxxi0y62YuMFVVTIKAe/QfY82s/4UHfcdV8EydTW+?=
 =?us-ascii?Q?tIAcNM8R26Biyz+cpYB0iNWKemwShkwSUCe677mN4khDWOn1e+5Aaj2jIGa0?=
 =?us-ascii?Q?D1ou3ABlccfpVpEjcPi2ol2LkbI+oW31WC6Pwux2J7pVXr7FsFzz9fCe4kWV?=
 =?us-ascii?Q?CwAGxZWAlaBuPfjaCA714Cm7itIxaPJyATVUE6RjI3eYCHocd9L+cb0rygCP?=
 =?us-ascii?Q?pVqCOn59a9AA+vWabMlkQBgzwo0d3znO49gb2bNUx2IZeJgop0ODTNboYRA1?=
 =?us-ascii?Q?N3mXrwiKgoAc9TFzvXpJZjDb9e71ys19R3b6DyaRgXyv0FrZSu4+6F6Cv7xw?=
 =?us-ascii?Q?9KlTvJSydHWkj1H4G5PybGWniaV7sbvv13/P8GvO81SYlatASSO8CDqzP/RL?=
 =?us-ascii?Q?z02Axlfgc6TE+AOZ2iCRpzaxTK50t/qv1FXDeLAs74h4mvbp55qjbSH9EZ3Z?=
 =?us-ascii?Q?3y77vuQm/IJcU2zKuKHVMjtVbq1AEN9e8UjvDKeBNOBSbXmrSnx7l0MfhOPb?=
 =?us-ascii?Q?/X86yj9kydAWMCwovTG195UZmjieyjrxaXYUgcHH4p0YRz6WpSrVtDHVFLUZ?=
 =?us-ascii?Q?yXL660uk6rEe4uxP2pgK9ndcAYYkJmDKfSDAUtwG9eEVzJCmVz+Wo7Ogu9jw?=
 =?us-ascii?Q?R32aJWG04o3CZbgg7xGUTeaghGNtN3xgCCzcNSWmgzqaM/Q4dXOuHgZPFgul?=
 =?us-ascii?Q?i8syrL/JRtHNwac/JFlAhXW5rR9IrwjbgaPs4z6+GKHaX3GPliK+wrY1LjSR?=
 =?us-ascii?Q?NYtul5EbHbvNOQMgPMdkBMmXVoXGR4+rZ8P9rI8wTfyu2CDZJzGfzCwOWDvD?=
 =?us-ascii?Q?o85IKrG2fCnKznABYIkuk0xM5QRhV6mFvrdzJZf+Yo2yQkLl2ZZHO4/mUCMu?=
 =?us-ascii?Q?pGkE/+t5PwKYaG7GrXjt/x7MPc9hBV8Ig7o2is6bO38BaLFtaXtciRg5o5wN?=
 =?us-ascii?Q?vNox6Eeew3jPlbwaE1FGkC7moUX0lNNbsDqWG5U5NhDkLI8QEUFVPJCdmgEZ?=
 =?us-ascii?Q?SoBYNyZNwM+60ACc6DOEMUFpeCz/cB4V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:09.8276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61af534-86df-405e-5f3e-08dd157c3cf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

Storing values in the cpudata structure in different units leads
to confusion and hardcoded conversions elsewhere.  After ratios are
calculated store everything in khz for any future use. Adjust all
relevant consumers for this change as well.

Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 12 +++++-------
 drivers/cpufreq/amd-pstate.c    | 30 +++++++++++++++---------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index a261d7300951e..3a0a380c3590c 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -207,7 +207,6 @@ static void amd_pstate_ut_check_freq(u32 index)
 	int cpu = 0;
 	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata = NULL;
-	u32 nominal_freq_khz;
 
 	for_each_possible_cpu(cpu) {
 		policy = cpufreq_cpu_get(cpu);
@@ -215,14 +214,13 @@ static void amd_pstate_ut_check_freq(u32 index)
 			break;
 		cpudata = policy->driver_data;
 
-		nominal_freq_khz = cpudata->nominal_freq*1000;
-		if (!((cpudata->max_freq >= nominal_freq_khz) &&
-			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
+		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
+			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
 			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
 			(cpudata->min_freq > 0))) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
-				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
+				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
 				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
 			goto skip_test;
 		}
@@ -236,13 +234,13 @@ static void amd_pstate_ut_check_freq(u32 index)
 
 		if (cpudata->boost_supported) {
 			if ((policy->max == cpudata->max_freq) ||
-					(policy->max == nominal_freq_khz))
+					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
 			else {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
 					__func__, cpu, policy->max, cpudata->max_freq,
-					nominal_freq_khz);
+					cpudata->nominal_freq);
 				goto skip_test;
 			}
 		} else {
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ce70d1bfa55d0..464db6745d84e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -739,8 +739,8 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 
 	if (on)
 		policy->cpuinfo.max_freq = max_freq;
-	else if (policy->cpuinfo.max_freq > nominal_freq * 1000)
-		policy->cpuinfo.max_freq = nominal_freq * 1000;
+	else if (policy->cpuinfo.max_freq > nominal_freq)
+		policy->cpuinfo.max_freq = nominal_freq;
 
 	policy->max = policy->cpuinfo.max_freq;
 
@@ -940,29 +940,29 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 		return ret;
 
 	if (quirks && quirks->lowest_freq)
-		min_freq = quirks->lowest_freq * 1000;
+		min_freq = quirks->lowest_freq;
 	else
-		min_freq = cppc_perf.lowest_freq * 1000;
+		min_freq = cppc_perf.lowest_freq;
 
 	if (quirks && quirks->nominal_freq)
-		nominal_freq = quirks->nominal_freq ;
+		nominal_freq = quirks->nominal_freq;
 	else
 		nominal_freq = cppc_perf.nominal_freq;
 
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
-	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
+	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
 
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
 					 nominal_perf);
-	lowest_nonlinear_freq = (nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
+	lowest_nonlinear_freq = (nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT);
 
-	WRITE_ONCE(cpudata->min_freq, min_freq);
-	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
-	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
-	WRITE_ONCE(cpudata->max_freq, max_freq);
+	WRITE_ONCE(cpudata->min_freq, min_freq * 1000);
+	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq * 1000);
+	WRITE_ONCE(cpudata->nominal_freq, nominal_freq * 1000);
+	WRITE_ONCE(cpudata->max_freq, max_freq * 1000);
 
 	/**
 	 * Below values need to be initialized correctly, otherwise driver will fail to load
@@ -970,15 +970,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
 	 * Check _CPC in ACPI table objects if any values are incorrect
 	 */
-	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
+	if (min_freq <= 0 || max_freq <= 0 || cpudata->nominal_freq <= 0 || min_freq > max_freq) {
 		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
-			min_freq, max_freq, nominal_freq * 1000);
+			min_freq, max_freq, cpudata->nominal_freq);
 		return -EINVAL;
 	}
 
-	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
+	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > cpudata->nominal_freq) {
 		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
-			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
+			lowest_nonlinear_freq, min_freq, cpudata->nominal_freq);
 		return -EINVAL;
 	}
 
-- 
2.43.0


