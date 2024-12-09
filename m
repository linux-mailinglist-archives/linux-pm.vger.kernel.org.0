Return-Path: <linux-pm+bounces-18857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E869E9E6B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 19:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9730416685C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD1D199FBF;
	Mon,  9 Dec 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ogb84ciJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AD1990BD;
	Mon,  9 Dec 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770403; cv=fail; b=IQytblnLn5m91sxWJ2azxMa9jjB9P+fJd503URvNgJuUZz7U9jc87rCB62YV1u72+kprXTJtcPUMlzCwMMBYulcGclgCfKRDqpobRGFJ4kZs8zV0W4ThoCEdKaLW8/TJyWLCDgKIxYI8KJUkIO3h7xgyiTuQrmhHw3IXH9VZFUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770403; c=relaxed/simple;
	bh=e/nZKuKpmaNRiIN279sc670kJiapvYTx0Nn8QYHyYVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJKjMYTcIlvH9g2mSgW7lhmy5dkdMLZCMh0qHSDSfHb3qRdLtRgpkdJepniemAWDGnlXVMNrQfWlpAUvSCO+mH7i0hfA1W8/a3EYoLFDffa5kbloT6IwCt7lYURy0fu/6t3Qf3XsFLtkdH+ILTe3S/2bs8k14RB6RI0Mlb/w5qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ogb84ciJ; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMJy/9nRsw+MYPh8MBGXqEwI+J1ZRPG4416uPsPXqX7G5P/arUp9U519p64JqR8UoqlHa4KogpnrLCxleLgkoOJRigNfjQWqn6b8fTV4gelA//BorfhaxZ6qttZI3U6yRKlB1NDjBdb4dHqdTKz6sjAhv68fVMg+3MVd+OvQzMPsQLEKUZ+6BWpUYtW/XBS/lT7KAfjnbxzaTAzxYKz0m+gxmantblb/Z+6oB6zmee4dBeV+vpCgl3wYNpJTmcpqGvRcrsPQjAhqRmYdR+lU3CW551ZV/4nu55Y8a5pLpRF2uc/xnaBjBGsqT4QsJdWgHOnhz2WH9UP9DOe2xj+KGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdiBQkzENdfUo/VGDk/Uh8zIgQac56a333fBQCDwRRs=;
 b=GviEPgf0z2Ta3gNnMYALgYewycE6Ao83+frr7IAKgVyBWQvEVnWEroH0kBasAgDos5K1SiVKCiA1mbgwa3wpQMPRaTHq4/9H9WpL+/eLrrX5WMFbkkCF4d89b8jPMwpp96mO7apl9emj1U0iwJWpY4OxU6Z8ngr2ypWsK+HpHkz0/xpJfQEUksANIXHXPolNt4Gug3nlfr/1XMl1aAGXkHpweNXeZ7NPwT2pCr50M3hDkMI6CrXnhzPQmuBs7fcbD/ZMHxM39B3SG8rhMtXKqqGYq8Vxb5vLEr+aOsGFWTk78iH9M3kizu74mMAeFxn7/jR7SoJ7Sx7io63U4/97QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdiBQkzENdfUo/VGDk/Uh8zIgQac56a333fBQCDwRRs=;
 b=ogb84ciJfhBNGl1XsJ4+UPO/JwTX77JIs8AujRHTZQ1DNxQHNTkOZXDxF0sExMl3rCTLeA6Y8yjPUP7i6irPN5Se+bqe1G9sPMC1iu2aWr/lHc2LucWO3KHcvxEEum6lljT5yLb5FfvVRzawIu8e8cXx3uCW8REXOoSNvYLcVag=
Received: from CH5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610:1f0::25)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 18:53:15 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::c9) by CH5PR05CA0023.outlook.office365.com
 (2603:10b6:610:1f0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Mon, 9
 Dec 2024 18:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:53:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:53:12 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 08/15] cpufreq/amd-pstate: store all values in cpudata struct in khz
Date: Mon, 9 Dec 2024 12:52:41 -0600
Message-ID: <20241209185248.16301-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f1a9c7-290c-438a-1c50-08dd1882bcd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1UQzNHFCQS6osRtvTeg/kbCXFhUPfrfyI6ehqqJaXYPj0FzIB23mC9A56BEx?=
 =?us-ascii?Q?XBa8VyAnLj9JCaUv03oNqx4iPCTDZDyF9Z14FnEfMxtKpjdKN3LZyrQIIIxo?=
 =?us-ascii?Q?56pDe07DuZ+QHK21LA/FP8PAk6f5csryx9Vv62aUmByiwmT3ZYT51xiDzY81?=
 =?us-ascii?Q?3Gj09EY2HAehF2yLsNiypkDh6STmPK77wPXRB8mnIQWt/sXCQBnTNc9/t5YL?=
 =?us-ascii?Q?+HuqK88M/WslDYbDG1o4hqM8dGmPeD11N1SY28Bm2oNX/ZNet0BV2fm0XmDp?=
 =?us-ascii?Q?GZqQ/Ug4dcvqPrPNkGpCGXxH4gHnQ3O4NoMn3QxO7jrZLLpxiEl/ks5q6mxz?=
 =?us-ascii?Q?Jf7yvtDBxk+V7faBHb1Y20WWGO+aryCh4loE3/pNbYmvCNJdNVhBblnh7cXj?=
 =?us-ascii?Q?LgVp1q/Lp3fGc7wPMkAecPiB7gn2dzwvuPj6c7dwvExwAYVJ/fo4oTbNlMfJ?=
 =?us-ascii?Q?XtWnJozIo2tA0GKcxw9aJLo+Yfr/yXFxm1iVbix78x2JhQfmgyNCSKTEa3mK?=
 =?us-ascii?Q?j/HbMAHeeeas4mMU8xYMdnrFICWlawm24qhaK4c4mjeOhX6I01fvVDicu4ox?=
 =?us-ascii?Q?3VH37TJxt2LwJ/QMW3aCX0nyNSST9GeaCartE2PR2DbcrFAnvLKfTCxZRJkr?=
 =?us-ascii?Q?hLrRKNhm+dutfUNU0TdKq1/IZo48FR6OWdtPjpMJYf5ORaJeaY9Tj3qzrgX3?=
 =?us-ascii?Q?Ho3XMqDpXiljmv8lDzn+HCE7mr77yDOs33sHAdaIlVEFx8m1Et2u3iSV71GT?=
 =?us-ascii?Q?yLGjC/TMaLXHk7e8i4jrrS7jjTD+Hyk2KaT5jdGjnn87q5mMg6qpWd8AwVNI?=
 =?us-ascii?Q?oF8Ft2hxRyru1c74nKhqoV7tnlfQT30jebRhDtF1/CaizUZKX5NOcWxGRhJ2?=
 =?us-ascii?Q?s/3oo2Xv7BwUMWxmeB4z5rgwC+KeQjKmAZUndVi0LDIrbZheU9rYF+s/gYXV?=
 =?us-ascii?Q?k84A3E6C1BjIssY12xVhyW/sBS/Q90RSAY6mRzRskQfzy8O5fcs7dp0GeXR9?=
 =?us-ascii?Q?dw7q9HTfy/drWAHmWQ0PM9l6yf+wvttf025cebK6RLHGBkTjn4hVbg7WMGJ6?=
 =?us-ascii?Q?2/51sM9A0Y6CtXwqBGlzJLtq56cX099Smlq2PG6CSUmtqrtoKPFc0C7Pha8i?=
 =?us-ascii?Q?xAbRR0rUu6RzxqbcZZrRRwT+EotRm0o4yNv+ng1VAEY3YlktbIM9f1PAVDG6?=
 =?us-ascii?Q?exN8x1Mli7tF9ybzLK7HUgRZtOoC6TTp5bOW+jsAGeeEpciQNEDtpw4xx7yL?=
 =?us-ascii?Q?2GZAkdx3rKsJSJ8bzp7xfqzpVyHUsNkvPKKQEOw+EO9YD9rrPpmrY5WwD4Po?=
 =?us-ascii?Q?3f9bbSDWNfrnAoG0sdIGm/0iN5cvrFgdVeaPMqZX0J5NdE7D/XHRc7tz+ly8?=
 =?us-ascii?Q?+iYAg27BITuAJu2dDkLQd/aOtx4IYllkvrm7/DsJGV7uWph1uajHWkhuh4S3?=
 =?us-ascii?Q?HDFL32tWre9G9rcK+YQWooVQAX88jJ7z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:53:14.8701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f1a9c7-290c-438a-1c50-08dd1882bcd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

Storing values in the cpudata structure in different units leads
to confusion and hardcoded conversions elsewhere.  After ratios are
calculated store everything in khz for any future use. Adjust all
relevant consumers for this change as well.

Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Adjust checks to use nominal_freq for consistency
---
 drivers/cpufreq/amd-pstate-ut.c | 12 +++++-------
 drivers/cpufreq/amd-pstate.c    | 28 ++++++++++++++--------------
 2 files changed, 19 insertions(+), 21 deletions(-)

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
index 263acce2f4b0c..8a173359c2754 100644
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
@@ -972,13 +972,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	 */
 	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
 		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
-			min_freq, max_freq, nominal_freq * 1000);
+			min_freq, max_freq, nominal_freq);
 		return -EINVAL;
 	}
 
-	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
+	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
 		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
-			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
+			lowest_nonlinear_freq, min_freq, nominal_freq);
 		return -EINVAL;
 	}
 
-- 
2.43.0


