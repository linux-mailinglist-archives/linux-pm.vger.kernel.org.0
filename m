Return-Path: <linux-pm+bounces-21378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007F4A28928
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FE4165E34
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B322A4D9;
	Wed,  5 Feb 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m2rlafo7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345322A4FC;
	Wed,  5 Feb 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754795; cv=fail; b=ghsmHl/7a3Uco40lWk355ft8PW8MsVjbI2XonbL+l11geSYz6zLwe/q2iLuUkJMNCevTZA0LQ2gBgCPuWal6X2qtP7p0sFT97UbCgVedI9QtTKuPtnlhzPGripKwgi+L9oqe1J1KUyWF32E22Cs7/qpB6lpKX5AHkO33Zx0Rwbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754795; c=relaxed/simple;
	bh=ieA1rwEDqKn5DjsSrTtA3BlBh5QPUY1S8LVhu6Ea6II=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvjrZKkdxHw2IQ2I3l7qizYRVz2muwHj0iiJq53Gnk6Nby9YeOJetAlGALOx83v6Of0JXCkqtJX8xkOuT+RdxZwPY6hGUJw38pGChkkQSGwlbm+WdaxCnF1m0kCgBDxVB2p/78Q4YSOKseJJWXggiiL9Cs5yW4Y63Y0ivt6L/ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m2rlafo7; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZ06Fo0aLbqIRV78DLX4W8T40hEWSChEITz3LnoVAkJ0644HhNnN6ifH04Mr3CXRcOZV42u2UfrMv9Bct3WJCmbw+KJNd6wsKFxB3ZTjv/N4moeCjK/5nR154A3Rh9nv5V810vbF/rm+xnc7YC5KHoeYQ5+U/ROa9LKaPS+QkBPm0Ompr2Bw9PF3TyEVzP9knf01s1XAiMfLYXiRUw8FaNR8RtCNpZRv+5THChUOYioRvm/pR85aIQDEM23bCpjObEu5ZnCOEYOTpvt+GWh4Tan3bA/3RYd+xKq+Jb7CagqlNa8UfaV2k+TxmgBFfm4lfzB0SAOVufH6LVPUVinR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3DcJNTr0OAKE56hBxicNA2UW3lqbrRszpTinE8WSIU=;
 b=Y1FVIypDiewhFUQg9yVRb/xK4dVd+UU0oSdpvsoqGRXWKTIiUsn99gay2U3APNLC1vi5d0cxN6xIfIFUlyAgjny1b8Ybl9Y5QK8DlTIYDcidAAPm9xOyNWkeP6JN2xB+OqkCIoZh60Ew4g4f7LG1Rv6/A+fAQpo1Xx9rIXU1dklzqLqFkGbUtkvCVQHKq8h4EvvZKo0WyqTB/pymsCThT2nJTdvKBjfD/nHZhZ25wIDvnn/fhE7EV4Eot/1U760fCN8G9fcVo9pHjdPWzqPqkm10k5H+2eM/zy2R8Erbsiwl4Xx1RF2QQD/307I5RicWspRM9TmU4AgrWAKH/IFefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3DcJNTr0OAKE56hBxicNA2UW3lqbrRszpTinE8WSIU=;
 b=m2rlafo77yoAKmyHLLhFuAqqISoYrXRhjLX4wJfnzpNLONxpbnO6nBIVHmyp8F067gd4Jmp257fuEf28hYYs6M2t99wrnv/vzEjEvt0b7G9/Kg9t6JIl7sDgbRtI7cwhBzLO61MRkAZqwg+82+meD3TNnCYr2D8l4ExkGz1mcE8=
Received: from DM6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:333::13)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Wed, 5 Feb
 2025 11:26:30 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::7b) by DM6PR03CA0080.outlook.office365.com
 (2603:10b6:5:333::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 11:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:26:29 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:26:26 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 03/12] cpufreq/amd-pstate: Modify the min_perf calculation in adjust_perf callback
Date: Wed, 5 Feb 2025 11:25:14 +0000
Message-ID: <20250205112523.201101-4-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: c3561a49-ca2e-432d-f09f-08dd45d7efda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eyMJdoQ2nQ/Ri3pREdSTrrwpLnAq8iuNJgYUU5F31OZYQqR2YTWZtmFhQjdu?=
 =?us-ascii?Q?ifFFg++Vi0Yby6Rh1d1um8s2UgJhLaXPX4qiV5Bk20d/JtUrw5XKV3TGQaRz?=
 =?us-ascii?Q?8y5o3vmDqDSB8t/KoHGTj+I/cItVAWwgWtrM/abMjLLXa+4Ui/5z26g6Lu/8?=
 =?us-ascii?Q?xW4IHXqgWJ3O3KtvQcYsKzK/XfVHkC5oPF+97XnIJ2o6jpeNXkqfbufSSN4d?=
 =?us-ascii?Q?84zI89eRRBm2LwRZ9uKwxzdd9BIszC49gehl6EMbax6mqQWWfVqhkqwYFHCB?=
 =?us-ascii?Q?XTRbnUD9SKdN033tGMAp/aqfrzGy3ubzWlAtTVHVvLXMGG9vPtO8lnS2Sulp?=
 =?us-ascii?Q?4eZUsx66DPat/phECFQM3kd2JO27S1o7h3kJUrQUt6vX2qR9OZSCc76ArLt3?=
 =?us-ascii?Q?bXrTgyIewGUjnD/ZqxS1jv9rNlQjLz47Mfl06YyPZqXA5ADpnhsv1LP4Yjzh?=
 =?us-ascii?Q?UwD+KCSnWTnqQN3kL6rceMnToVaHQasJErT75hA4kmCgDSD0HCQlXpQBMbuC?=
 =?us-ascii?Q?avADKdwOvvhsvzDbKnOxd40SXEyOMXr7FZiD2FY374HsnaJQaWrmjmPIdWp9?=
 =?us-ascii?Q?Imurd6/UBbVeJD4uV8kr+EbI2HKXjRy4BXSO6GGy0zmJr8wXusL8oRmfK8jg?=
 =?us-ascii?Q?PmwB2Ax8Hp2uiourJQQN5pu2x2a6BHJQUDBmskYjwfacbeUNDyi0apW1xmW1?=
 =?us-ascii?Q?URbdFNOhlvnDGh+i//9owebZPQxFuQgucRkk6f468hYkUxBFZLiXu3VW6VFH?=
 =?us-ascii?Q?KgD+6eeTldZxAgF+ecljMfw1PoWat3/RGjQkM4FwZ/UYlxBzBE8PJxMFaV4w?=
 =?us-ascii?Q?BHb816LcDorvh2rnxcLzuNSQZ0Vr5+sUKlKA4+SFPVGM8v8IL3FpA84pjKk3?=
 =?us-ascii?Q?RduPo80TlKPa7ME3oWVtFf13U+aM5s87rOc+cuTYB2Xe//fftZQABMDkIduT?=
 =?us-ascii?Q?EkMqUDPrvseauYaWFj9T1dq4s1cK+VcwI8SWb0NunZ1sds7MNM87FVQccXR0?=
 =?us-ascii?Q?g+KQMdCLJP7VMHx4oMjlrXrRIBGEpqh/1m4lnpuUY5y2Zowil9448U85y0HP?=
 =?us-ascii?Q?o3ulh+kT249nd3EiLrRwQqQoEgK+qN7bxQP9bJUIAGc0sB8DSTaEnA1cKtpU?=
 =?us-ascii?Q?ZLsmAOCs3aupz4Ptjl85qruayKGZTC8CGl5mBTe/9kWpUX4Qsc+jYhOI2v83?=
 =?us-ascii?Q?M/6EGhHxpieb5fNvUNfJrSsuzA42KrQ9Pg+qko44L7QxH5s96gnbpMtE2YGg?=
 =?us-ascii?Q?o+3M1h+Dwf9FgP/CvCptrA9WegaPDkgjnN60Is7fd4+U/CckXMg3d/dmbEIy?=
 =?us-ascii?Q?sTLvjfslFlk4qEwsR6HieUd7CVaiBIfb3d7WDP5gf71D3uqQ9y/pF04HyRG9?=
 =?us-ascii?Q?Va4+tkopP9bRmLfOFlP90i11gQ8adHEsSnQ6e8k5W/x37e6pEKeLVFMEpwJr?=
 =?us-ascii?Q?39QGksQXRD7sphmGHz9q9TzEUpA0RcwK6WWEmQzBXDUn+jOqjFLFr0jt8bhm?=
 =?us-ascii?Q?VgL+Yh4r118y6F0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:26:29.9772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3561a49-ca2e-432d-f09f-08dd45d7efda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781

Instead of setting a fixed floor at lowest_nonlinear_perf, use the
min_limit_perf value, so that it gives the user the freedom to lower the
floor further.

There are two minimum frequency/perf limits that we need to consider in
the adjust_perf callback. One provided by schedutil i.e. the sg_cpu->bw_min
value passed in _min_perf arg, another is the effective value of
min_freq_qos request that is updated in cpudata->min_limit_perf. Modify the
code to use the bigger of these two values.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9dc3933bc326..a23fb78a442b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -672,7 +672,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long capacity)
 {
 	unsigned long max_perf, min_perf, des_perf,
-		      cap_perf, lowest_nonlinear_perf;
+		      cap_perf, min_limit_perf;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
 
@@ -684,20 +684,20 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
 
-
 	cap_perf = READ_ONCE(cpudata->highest_perf);
-	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	min_limit_perf = READ_ONCE(cpudata->min_limit_perf);
 
 	des_perf = cap_perf;
 	if (target_perf < capacity)
 		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
 
-	min_perf = READ_ONCE(cpudata->lowest_perf);
 	if (_min_perf < capacity)
 		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
+	else
+		min_perf = cap_perf;
 
-	if (min_perf < lowest_nonlinear_perf)
-		min_perf = lowest_nonlinear_perf;
+	if (min_perf < min_limit_perf)
+		min_perf = min_limit_perf;
 
 	max_perf = cpudata->max_limit_perf;
 	if (max_perf < min_perf)
-- 
2.34.1


