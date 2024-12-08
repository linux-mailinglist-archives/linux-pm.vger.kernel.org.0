Return-Path: <linux-pm+bounces-18750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBBA9E83F0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295ED1884854
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5770D147C91;
	Sun,  8 Dec 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bZlsY4ET"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75481145B16;
	Sun,  8 Dec 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639465; cv=fail; b=Om20VB79nVUxGxoi59HoK/cOxTK9kaYqUz95J+0t0YL7FrRj/NSl1BtmlvIcWI/aBtHMH23zGKCklsO9AR8I97fxkrDnOam+DdY9SHF24n6vL7lHZMqqyQerrEJoVTYn3XFZFbm46LzDiNIKDZCxA9pxDgRySEoO/iVlVP13PvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639465; c=relaxed/simple;
	bh=e/nZKuKpmaNRiIN279sc670kJiapvYTx0Nn8QYHyYVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OssDIUepAYQ46QX8N5iekFG39mWRKkj9UOrncQ9R9ZtMDMC7/SoAqeTq80oH0pwkySbRrqzVa0SzFZJpk1rmYjUswu0M6ZOSIplhLjBRLfRmbQl+47fgVKndbEPSfavIGMKPyq8w451mu6Bdx30e3LHxnF6ccLpeLzm+4DHZDik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bZlsY4ET; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1eRlaJsXU3iILpSCCKul/L7PEy1oCgicIyKbdQvZRvDRzrh1cy2wf5dTMqGlIgVR8ORfLEogyXUl52Ha/IU3lRZWvLnNxGcfMPcgyBdv8AAFvXThLj7Cv2mPXvaURq23Pd8huzlsQPlsN+ZshUav01P4tE0FsOvAM0FyCAjU3YvkYCLBmQ9poA44beV9x3YGMnLp/LmMsGaF0PR48WUIXqxR/4+G9kXXwutxncT4liHAZ/CjeCw/bPHJcUlUsefOptAgBqgnbic2E7u9JfUhbCA6rLTvozwJQicQxHHHADfih8+SqKVuKqgCKxL3pELeqnXajWPxDruKhIab9b/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdiBQkzENdfUo/VGDk/Uh8zIgQac56a333fBQCDwRRs=;
 b=uni5sUS97yxWBs9rrZppj1n1T58CRyzwJfxk8tC1iRIiLgHg+S0+UJHRCh/LLJppLC7dKdFfXqWVcA46qd+GA7ehpbmLO7eiGa2glYk+OnAJb2aMStoJye/tMnB7DODNPEK59z4kTgKOJ4JYzM24Q7CTfYyMHALJfsIuZgvxSYkQCQtwEKCC9/n6P/uDqIjhBa9DlayLINSIZNRZnKvnopRFvHILwhDN5Qh8bbh83mzsMh8ZXABD4PPs4Y8hgboAcp74jBpQ1F2QdxsdFPRZoSvyxUWxaWKza74mZ+B/nH8o7rA8NdKjMahRMhwmvNxGMxcnj5CuvZql/PUbJGkXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdiBQkzENdfUo/VGDk/Uh8zIgQac56a333fBQCDwRRs=;
 b=bZlsY4ET0XBwAx3FVXw+bKylMJis8PLRLHe6XAh9UVYnnXl6W1its2B9izxkadrGO9KB03Zgt7MzGjTQT5Q213uXnMiTEegGrJdJ3D7IyUbJpMBecNgLnU7JvabAsF+VyfmYtchNGZhhh2TPhcT8SWyoJuwaaiul9j5tYoKnyi8=
Received: from DS7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::16) by
 PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Sun, 8 Dec
 2024 06:30:59 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::12) by DS7P220CA0011.outlook.office365.com
 (2603:10b6:8:1ca::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 08/16] cpufreq/amd-pstate: store all values in cpudata struct in khz
Date: Sun, 8 Dec 2024 00:30:23 -0600
Message-ID: <20241208063031.3113-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f56ade-561c-45dc-b616-08dd1751e0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lwAgSYhD5cH1KqCOCZtUW6QnbcnFxMYmHHEMKr+E0i2ISt0xAvHELG2FYq95?=
 =?us-ascii?Q?fSEK7CVx3SZg1llYGq7cHrPXV5VV5NzOtE1Q1U48k+83G/nbvQKpQlCPVt1e?=
 =?us-ascii?Q?gKIsTVzARqdtgGbOIb9YNG/mXGLkbus4JRycPw65KXx1uE5n+z/IGl9LE16S?=
 =?us-ascii?Q?+QRax9UBeuBwo0fs1XIDhiYtmd3cob10m7T9iQVz40glMjLi5OH7N0Pix0GC?=
 =?us-ascii?Q?VdJ3S6eDQkacqQo7gTERZf3DBiQopVzDYwYFiqUaCEOVcZS42Iy+0S4zOZXu?=
 =?us-ascii?Q?yh9q2h0IY0jHwlwOoJAea59ZFeNYYv9j8TBfuQ8TXamGqFaKBTO5qzB51JeY?=
 =?us-ascii?Q?8DcHcIL02RPUHAJZ1NAvtvC4yuJQo6EguHmKP56xUkarIft+9jz9Y4Ioh/r3?=
 =?us-ascii?Q?UmGqhS2ARLW2Ani71zpeHVlMoS7P2JEMiA9BXuTu/T6WGuAZsonRgAv49ct+?=
 =?us-ascii?Q?FuHSWdxbIMdzsKrhekaOCOK0cr9eNhvBO69sgVXUalGGqK34kQWSpWGjP1a4?=
 =?us-ascii?Q?CbJrvrfrw5ljbH6ZN0ZrQKPQmdRvp8Bq7H9tUd9cM9u8a/KnYZ44FiqzMFkN?=
 =?us-ascii?Q?gScMOuRIFw1VWg+5OR2iTo9AWciaypYz9gcwPIFeYUtMFUcHCeTxFxwGZHU9?=
 =?us-ascii?Q?XvRQQ1GLbziwmOEjPnbxIArHya6NVpju1dZ94PvpeMePJLHmFB0+p3yIZt1h?=
 =?us-ascii?Q?QKTvxMmqrfUJcb/GqKn42VR6FjlJ4V8o54DXbUPmaVKzumn3QlbvK/Y4L3N4?=
 =?us-ascii?Q?k1YPuppvaGPE91VQYjY1XFPynbgHaIP5ErmbokWOGZQULeS7yt8HvOP90zpT?=
 =?us-ascii?Q?PDeYUAkP5sBB8ZYbT41YtuxyLwokTkMWjEHyponp4CpFBO5Hrd3kSzIxsZCM?=
 =?us-ascii?Q?DbNQv2+x0t8Q2P6OHY3M1GQD0HPPFsARHFCLcnN4paM4dcKwVOaMNMnWI977?=
 =?us-ascii?Q?1vYSPriU4Y+sFPFMo/V5DmVqEpAQmTdhD8rkhc/kPXG6Cbl8atQWm1B97eam?=
 =?us-ascii?Q?//B/7a6Dxk6WzB0pqd6B3CXkhoRE56OWNLMf0boAbimBhD+6h/Zw9TAjeyxp?=
 =?us-ascii?Q?BwBf34Ldhzrm5p11+sJMhGeLu9BV4aWTuGqnzPmMZNEKEpjdd9Z4nGMz0AM0?=
 =?us-ascii?Q?rxbi1eBJxxdjXyeRJLD+7oDKTfQ577xq6e2vlH01va3fbEDqRKtecfzDgyr7?=
 =?us-ascii?Q?G3neXrxSMvnXteQqUYEjCKfhjl4xNEIon3ipl3bv8sToKp388xsSXOtXfX4E?=
 =?us-ascii?Q?2bbvmtOtirP1jqKszdmyuvkXINWXiS73FqRf1qryD0B+BVr71axPJVp1D5OI?=
 =?us-ascii?Q?DVgsz4ImW1oq+0q92fdzjP3hU7IAzUJXLPXiz1yfl9LqKGjVDFBTWF2d3iJo?=
 =?us-ascii?Q?QW0ltPkjoE4PUbkuUE6ck/1DxB88SxW8MId1iP0qe6csS1A+XWUT/418YQeA?=
 =?us-ascii?Q?9B5EOHuIt3HpBjm8qLJ9PTIOS2JkWTMw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:58.6389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f56ade-561c-45dc-b616-08dd1751e0d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356

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


