Return-Path: <linux-pm+bounces-18746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5E09E83E5
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AE5281A5B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE9F1369BC;
	Sun,  8 Dec 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XO+71rZr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256824174A;
	Sun,  8 Dec 2024 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639459; cv=fail; b=qVVggnkiyYcB1xz1novcTMiH9MsqlAs5zOLyXc8TfTxeyHTsxWzrqoSu2vYHf7kbfUeQaSrPLXwLSaWxMuDat/W0Sw/+BnHySMuiPuot3TMrHjT9DxxUIKeqNo+oa0nDhVt5X1xKMjo1CervbhYdegA4wxnSHGZ7PAhk3wtXSw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639459; c=relaxed/simple;
	bh=1hJEV4TDhoGWDNUVBi1hBVjXPxwh22hJPz7IsiVQiEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbVdvizZxjrBznMUiglN0+WG12pDEts6GlYtcXly3dHvrl8nnLGU26qtkyKrIPOI90VL5sF7KNdoceQDDFO/JeJqiynGujbBmFLz9ZDmsiugaxjCy37M6Fz5osggAJeWov3kpfZqqD7PcSAO5DUrkgpFzNeJBKFNUuBc30rYCeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XO+71rZr; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3a4ok4Mfw8+m1oKd1/N84o4O5F8+ZIxBJ8FuCUXoEelL2sAKVUezBq+Giuj85xvDn0wa5OoDSgY/agccdR4Xk6PFN6sJooCfFX5ec8eoHkR78zgSrrl6K+fXqC8WLA4SH6wDmCS0Bf10HKOF7ld89Ix+krFwvTolwB2i/aof7xH9XI/+sPxlbovFnGmym3b7DEs/hPRTWhiHv8lznFRZfnKGU1HGvkwljdhdJfU1hGZiiNdTiBLlRuXlEZktkmYQrJYhmVh5+bWfxR3cPCDGtgHWK579+FoCP1k1+TpczCgSOwOFbKQqo6ld9ly1METZ8XVjZGw8kXLbG5ZYdgCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucqe8HPLacp3VkKxDehsSMBwOsryPZmCHnwY2O0VS3Q=;
 b=nl0ffdHNIyyt3+XZMapDiAgPr8WKYeIZra5B17pni1jAlsLbRs3O7qbFBHCqCKCrIlWbScNgEau0GYLH1PhHQB1EoIZisLbeXk8Tyww1R+Y+lpz/ktzuATXx9fXJA+S6ohvIW6gDXfkKqsaxp5dP7pcBoe4iLGNI0ghvRAfFFJHCbTtUlgWhumhhtQxgiqOsA0l46n3sZb4GmR0ToTua/7WEQ4VxRay99xVqSybV5JZBBfmV9WwsaD8uDicqblMtUzIrPrxs8BRBEQCSG7j1QxwVFFX1hJKhnkqKWENPJtXQ8W5BBEoBCJ7mTt6kkF7H+QCMy+wHWMZ+LrgNwoV+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucqe8HPLacp3VkKxDehsSMBwOsryPZmCHnwY2O0VS3Q=;
 b=XO+71rZrWE48w0uxzA/4YrvT1jpBuM/9L6k3fMJTb9e5+aVUAmBjn+F6/d+lSHU94IJLUJO4L5T/IrF5LXp1/H4OCZEpmkMkBOz5ZN8gD8uiuSx+087Dee26zmTFtAR31n2JUYclW6DThOJ6InqR8mERn3rPrYRQTR/sq0HzrCA=
Received: from DS7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::10) by
 SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sun, 8 Dec
 2024 06:30:53 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::b2) by DS7P220CA0006.outlook.office365.com
 (2603:10b6:8:1ca::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Sun,
 8 Dec 2024 06:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:51 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 02/16] cpufreq/amd-pstate: Use boost numerator for upper bound of frequencies
Date: Sun, 8 Dec 2024 00:30:17 -0600
Message-ID: <20241208063031.3113-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c81229-bffd-4476-3db0-08dd1751ddae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ncR+OsL7/qNA2raQnaUjXjHylzGbXq/9M2w+Mm/QhzJdSdX90niSduLmcvFt?=
 =?us-ascii?Q?xWo4WIJcN3qjL/7pM92hV1jd5isbWWrdGR1aiPVXE3ZMKizwBHVHvV4VTJGF?=
 =?us-ascii?Q?JlNdf3SmALLnPR0vnKzgdFk37kKhvaaX+fbc2nlug6A4mN4hXHJYFtceC5OO?=
 =?us-ascii?Q?yHjZ0N3hBztNnoW75zM5zMhYArf3X3cHKUgYo8qXqIHFaB0eliws91e1C5V1?=
 =?us-ascii?Q?ThWdKtfBSHTDBpWNLl4wf4D8yfwBN8IbQj/woKX5USQwmCqTrJ0QXAMzwrr8?=
 =?us-ascii?Q?gLWGxiXfoJbP6Ynt9nYlHG4MUYgD/mvqcvZOcJ3x+soVCuCQewcSPKc3WuMf?=
 =?us-ascii?Q?t1Vm2UlNg/Ip7zEBKyO5mCdG6TL7hC5yIM8MGH76gfADBJCQLkF6fTJsi6wl?=
 =?us-ascii?Q?hJkh5luffN7L88jQIPuJaEQ5DKeasKFGPOM7FdBRtHN8cgH9L2Mj5DybnS5K?=
 =?us-ascii?Q?BbviMJGNUrmCWU28wUoHkm3QuTtnaWHL/Vtz4mBNXSLMPqwVfaQCOLlEMTZZ?=
 =?us-ascii?Q?hogM1vNpG3ts1gayzQp3Vlcvw2BDrgMC7uLaK5atCkVrpgOQM8vigvWPDHgA?=
 =?us-ascii?Q?4clLtChF+a8/VWsrRGt/EI3WTnniQOK+mxGU9yolZATybf2/WFSaQN9nxgvk?=
 =?us-ascii?Q?eZRF6Nzp52PEem/8QBXG/Qb8X4tW5sxsEX321LDjChmy2lB0VoMPWliBDtnU?=
 =?us-ascii?Q?gW+wZKEEtoiIYONSJSMPuG6Tr6EZ2S2XpaiYXeCLiRQcHyGo5SEl5HvN8VqB?=
 =?us-ascii?Q?v6kiyvw64quiPuF6UKSzknvmPVIYg/U+oVSt2rqOJP75EJUexvSVcDfnpN/L?=
 =?us-ascii?Q?s68B/4J1NBGX21oODEKnZYMNehLMbIl66yK3VzWL8XsW5xL0/hganBnIWayP?=
 =?us-ascii?Q?p2nR1Md4zRCPBWpvYhQF9FK35WGTuFojvHlderIKIPOHZ5qcOdrk8Hgn9ayf?=
 =?us-ascii?Q?ef5D2v+7vHAZQKFpuENFB9vEkS7IPwFdiLsb1ou1nvDFfQa84TxvVwYM2sZj?=
 =?us-ascii?Q?057LlNlmz+ikwV3g1S2RxqhT+33dUwfJ43PwzeWrGgqiI8DF1Bbs+l6E0NP8?=
 =?us-ascii?Q?kqPo97YKMgkzaVFjNjowmA3stFr4CojSnNAetXHze3cFbNepjwl0HRr0ZEUW?=
 =?us-ascii?Q?7n2VOX1vJG2PkD7ZU8iijGbHq3GuJGnPrfkxJ1C0MuTt9AB8KIJGjSP4PK4X?=
 =?us-ascii?Q?M4+UT64KiRAau0kGirfKwKTmFmm/HisFeg4WjoIjn+5qgQSscipyZRIn8QGl?=
 =?us-ascii?Q?0DgJLeMd2bWXpeXqI8u68l75oSRQz7LKBY+mJVJUd3xzUlenIF6irLf/svJQ?=
 =?us-ascii?Q?SxyloNYaj4lRSzK0qoUMUfiSqymkT+8LDVIRAw5bDFRQCC3Ag4zt362y1MOh?=
 =?us-ascii?Q?DDtKxFQ//Bye1ZzGzOqLt0Cdqxjs3zMt1SRj8xUlWMhSKZLEZhD2o8thNB4t?=
 =?us-ascii?Q?oU6K0t4NTUDw7UpP7C5LdQReB78xq5cr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:53.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c81229-bffd-4476-3db0-08dd1751ddae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615

commit 18d9b5227121 ("cpufreq/amd-pstate: Use nominal perf for limits
when boost is disabled") introduced different semantics for min/max limits
based upon whether the user turned off boost from sysfs.

This however is not necessary when the highest perf value is the boost
numerator.

Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Fixes: 18d9b5227121 ("cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c51026fe636a9..5e0edb65de32a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -593,16 +593,13 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf;
+	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	if (cpudata->boost_supported && !policy->boost_enabled)
-		max_perf = READ_ONCE(cpudata->nominal_perf);
-	else
-		max_perf = READ_ONCE(cpudata->highest_perf);
-
-	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
-	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
+	max_perf = READ_ONCE(cpudata->highest_perf);
+	max_freq = READ_ONCE(cpudata->max_freq);
+	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
+	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
 
 	lowest_perf = READ_ONCE(cpudata->lowest_perf);
 	if (min_limit_perf < lowest_perf)
-- 
2.43.0


