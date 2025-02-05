Return-Path: <linux-pm+bounces-21380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09643A2892D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C346166620
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B222B8A4;
	Wed,  5 Feb 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EiovUN2u"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0F22B5A8;
	Wed,  5 Feb 2025 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754827; cv=fail; b=qa6Wlbzg1jwcAM/XbzXj74/O/xXieQ46KJJx2UySqUfgUhl7pSsxAoVJytq/hGQ09AO0rphxARvQT1Zq5l0lGI84pu/ARDtaKSy5dAaomPn5C6o98nVEq4zU5oJB9RqQlRhnoELdpUhSca7TpxVTW3N4sGbCpA1QQLJzay+/fwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754827; c=relaxed/simple;
	bh=wTSF5fgVXfC5kUHdv8A8W78sCv0giz+4dvZn8DNUpI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oo51lqKjfbnCS0RlyJ3GF2W3go3hmPbE6selm9Zwf8/+ldZWUxLTYEBAZJdhaPajpWTDWckEX4ahLBme2mJHZ80QZnsiIYPElvHrPsz7UqMhPgHyPrS4Mxbiig8Tz6CKyXXn39ffcphnO1XAv7+6ud7LRXFpr9K3gYLlya0NKVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EiovUN2u; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mT/ktPVkHfJ287/G5kvkB2xLxHxT7GSL/mTE9Qx8/u+Q9+qyJpQu63wIB7raqm1WmTM59FuhAYTIvrHNQoL7GyEFxfvuNqq42koqmBqvHgvaXG2R3OfqZnGcxmXpUNf55XNHAGhXvMCh5a3tPqSE9XqQva9T78f73acEyntPMDh5zqM/Y7LgRvfcZ0T6bMyRvlcq5BiqEhFiNm+7T0ou5H2n0t9WOZFyW/k/HkbnHKpKr7SlWy7Z8OVaqnp1S3p2MTGhF0WAym7wvGrXZLPayBN1F5MaYj4rA/+cGubtc7TcMbKDR2rXRlOA+LlW1t5tmsF1NI8FlT9vtCzPbxMiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrktLn/e5uykyLGC0LERBYvAn34f/WvResqCWM43ZG8=;
 b=TeOTzIj4LXS0m9au11T/MDPTqnSmc5CkqIhoatMPboM3wdwaIeeXSksAXxsj9Ih6bzd+Pl+r0uKKjPvffZ6IYE1zspzrPOylREp2kIDIy7yfh29GU3lZK3FZOJDnlzlX8WNF6AU3djGmne1HUdgf9wIh0XwAWbqQQo8UHs3DPJ1V5QvJDyDe0+tfkn49/D6Vi/bZaUfiMgAEAhNaP103re6MSes1wHjuDqhTJgt35dptn+d24Klc2O0ZY2wpxekTzHGjd0uRrcbzqACLL1oM3QWCHmEbDSF28ICR1jQXzFv/6Es8Kp/qNPifhgVXzOIpIbIBgJMwjO7bZF4iKvpOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrktLn/e5uykyLGC0LERBYvAn34f/WvResqCWM43ZG8=;
 b=EiovUN2uKDAdxRbGKz6w9kOaPUn8rPVGcCZe6P+xvKYwb59Ir+bz3+A0jOWEbiZiilqeQvXd1VzMhoO7uLbIy370JJ/a3f9tjS0iPdXMyuLG/vrwyO1fzJOOq6tXYuIggtZQR6Zk2S9WJa7rpeng6/vBJP4bxnG/dm0fixhiwGM=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 11:27:02 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::95) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Wed, 5
 Feb 2025 11:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:27:02 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:26:58 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 05/12] cpufreq/amd-pstate: Pass min/max_limit_perf as min/max_perf to amd_pstate_update
Date: Wed, 5 Feb 2025 11:25:16 +0000
Message-ID: <20250205112523.201101-6-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fb39db-6cfe-428f-1f8c-08dd45d80307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qJaaPwTwPkNxb1ICQPT1Nwr1Lg5KTptOYOCa/kMlXeQ4/yLWcuR4PVRkSDy?=
 =?us-ascii?Q?F2zkX7aKzZIzpddCAmYT3kmfKTNpPIgYWJOXJ5afN/tg5cY9V1KP/5PTlaZG?=
 =?us-ascii?Q?BJhvWwkgdH5bQfYCCiv/MLYdt9ZZO2fmA3WBgTsj7jbRNyLQmn/Ut701U/Cg?=
 =?us-ascii?Q?yOzzhiW3W0mCWaRX0FqetPED61las6uXxJK7TiPnVjQoXRRh/TjDm3OWeN91?=
 =?us-ascii?Q?ghZnmv6+keU/fJOQjgXIWnrVo75gFDGU00XgjtOKARmj4IUO6SXY606sA5AF?=
 =?us-ascii?Q?2x66jrBAkQB/FYOSFbvE9Fw15LOP9O3vIgRtV+00eGIlF1E4X4dFcyaLU7ra?=
 =?us-ascii?Q?R07ChW2E0cXE2fHUJJFV+WPnC/MsB6BnVc1VRlSKknYnJeZHGfNb63X1mlxR?=
 =?us-ascii?Q?4e6wgq8NyDHj3NjWZWAuj/5mDiCbLTr39sgv304EQ+VIB+paLoj8325NrWfH?=
 =?us-ascii?Q?F7iLi75bxlZejxvjYjq2uCcXnMrh0Kqn7Bj0LAeqL/M/PerjIU4EFcNs8zhn?=
 =?us-ascii?Q?4PxZT0SUu5uCb+UXIAiHJG0zowpRjnxQaPx2UzRp1oCjgMvO+Wt7NsI8L9+c?=
 =?us-ascii?Q?XU/ufGHszMI3nVrTl7aLFPDwMVriOGzLb7BoRaAX78j1xmJn1dlY3Y7BH7rJ?=
 =?us-ascii?Q?MdJW2Q1w7GVp2CacrNnwKw0ot4DwAe62ZfeXVj03xN0kg0m8RBtml0pPo5Q0?=
 =?us-ascii?Q?WhECyArO82jV6SlpH3xuOQAfSCxdNnp6IuTaBpMkVb7rl0zQbwS/dQv//gPp?=
 =?us-ascii?Q?7ItA5OvJLqrgtxs42Yg3M+j8VuChYI81xo7chnew1CJTDx9vvUlow3EkuYW0?=
 =?us-ascii?Q?BFJt3DVWSq64aP7G/yv1TNi8zZO5Sc37Cxmk28Muuw4yYADxhJWGSB4Z2E1S?=
 =?us-ascii?Q?I0Jl+aVJula2jD/svIPZCnQPYe9phEI1TBAmQexGPFOZjag4gPRsgqpScQmo?=
 =?us-ascii?Q?jbqtafcWpc/8rItKg8mfhs5ITm8KOH5g964YEdBZ2mbKA4p7xckds4X0vCOa?=
 =?us-ascii?Q?LEM9o9EkAx1Wt6DOmRyOrURrri3lm8qBe/u0aqw/rS9FOTAd9dskh9+opJyp?=
 =?us-ascii?Q?fZb0jxJaLcPVooxZwvL8DyfCPBcOMuUv7jCahSV09whQBY9RiBA3jJcRbgal?=
 =?us-ascii?Q?kDLF3QUD3WDWrDijATybVAjiNM0mMYt20ftZ81AsjHkF0nRERjnNeXyVeZO0?=
 =?us-ascii?Q?SibDGdI+thWf9twsac9041OxIipQhfeF7GAXhrhbzrw9Lu1ED5K5AgtcZ+l4?=
 =?us-ascii?Q?zbGXOJjaysE7E/BroT87+1guIlu9C2Xxhodu0Qxi+7WEj3DvYi9dDgxhfzXv?=
 =?us-ascii?Q?HwAMsE5P9eat2AeEhLxbLXtxjM6+nCj81U2WQDKlAgZZ4TZthZ5rsgjkBT5D?=
 =?us-ascii?Q?8yyoI4f4yVUseMt5tweZAWOKVoms4/Xwa8vCcYJImSc4OGSbSstcjVwEnGDS?=
 =?us-ascii?Q?pR4dSH7psdsrsqPZYgShj/tJkOwBJiOYyDhsGNJdaaUvSNifon9drWYYqF/u?=
 =?us-ascii?Q?Gd3OV+F2ovQbvJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:27:02.1435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fb39db-6cfe-428f-1f8c-08dd45d80307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425

Currently, amd_pstate_update_freq passes the hardware perf limits as
min/max_perf to amd_pstate_update, which eventually gets programmed into
the min/max_perf fields of the CPPC_REQ register.

Instead pass the effective perf limits i.e. min/max_limit_perf values to
amd_pstate_update as min/max_perf.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2926f292be7b..e179e929b941 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -615,7 +615,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 {
 	struct cpufreq_freqs freqs;
 	struct amd_cpudata *cpudata = policy->driver_data;
-	unsigned long max_perf, min_perf, des_perf, cap_perf;
+	unsigned long des_perf, cap_perf;
 
 	if (!cpudata->max_freq)
 		return -ENODEV;
@@ -624,8 +624,6 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 		amd_pstate_update_min_max_limit(policy);
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
-	min_perf = READ_ONCE(cpudata->lowest_perf);
-	max_perf = cap_perf;
 
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
@@ -642,8 +640,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!fast_switch)
 		cpufreq_freq_transition_begin(policy, &freqs);
 
-	amd_pstate_update(cpudata, min_perf, des_perf,
-			max_perf, fast_switch, policy->governor->flags);
+	amd_pstate_update(cpudata, cpudata->min_limit_perf, des_perf,
+			  cpudata->max_limit_perf, fast_switch,
+			  policy->governor->flags);
 
 	if (!fast_switch)
 		cpufreq_freq_transition_end(policy, &freqs, false);
-- 
2.34.1


