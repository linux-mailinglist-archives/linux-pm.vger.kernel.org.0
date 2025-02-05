Return-Path: <linux-pm+bounces-21382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC34BA28931
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73C31888A2C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7E622A7EF;
	Wed,  5 Feb 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IGYO6jU9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7BC22AE45;
	Wed,  5 Feb 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738754864; cv=fail; b=T3/kdAAfC0nOy18LQ7h6YZ8qfExNEts3jGCeAxbtblm/lAQFEiHMUtBClLmfZk98X/Guef6I89BLxqzZW2KCmMFcO1AAbJ/R7qbalMZvraYfTxpH+tuArFCmJSutdK00uT4BmXVWC2WNixKraF7sU4b2pD/JoL8aaG2YqWxSyWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738754864; c=relaxed/simple;
	bh=iyLstr2IVbAVHx4O7AmFjyOscLqFbUhkTzLjjri2nqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WC6gN2FtdUqe5bt6MWPqp5goxS+IwGqqRI3L4FC6bP4eUUts3pITNbLe+w4hu2gDtpEPAdNP9gMREzKlXLw6dbS+CsdlJn4TMY2cPuX3OXc04qqwHGWukfx99hUADNnWHncGweuHoXSJn60b6huuMbS8QZfLW1MZX6tCC98whig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IGYO6jU9; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjpFm5YgqkXep2fSZ5xyUERaZcbDawkkhqqYp0LZaWotzqADfpNzDITBbO708qjB2GoMyUl2AF8uEtL7RAOo7xf9nW23CL46a/eymjPp6yvv+jIH0AdxLZgDAL3ajoMAtiajpUEvDvXInYy+NMUPqOlOPgMhr+LdB2Z9ZPF7NU8EcyU5VDQJkNVVEL1Zgm8TRfVPYS0R4Hiwr4xgQ586I/NN3lsv60DslGR/39vAmtQCOJu2pHsKptKeOw/RkAU4xlk0DYevGuRC+jcQNQgeRKOyEmQZR2mx3RUbT8LeF61OgNGlArwhucf4AUM2kgv/cGolFf2eOxBV5MKo0qDWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI9JizZ8Rz/2JvxA/UaGTsuj1P1fXJh3L4t2VN379WY=;
 b=rbI8/ck/1ZY16TE5uctXF1mKUQKTNc3VGExlXSuhSGq2D/7jKpb6QQlqkYqeJbNzUkX0hNnK2Re1xaL8Iu10aVmgk0iaHYnJ+xFTIt+g/NE7hscYUQ5zdBXMUYsORROQl4zqvoHDlkO4FDP0FNj4srpcKjA8VWCK8QlY8wEITS0Dce0LnsvT+9LlGHgEsWCTcoTPsluUUpd0ki+injBTl+PtEJZFVvc0JlTSA2JavdekzUoXyUj2SgEKDtUw6EMCJdiKRMIG+sDs5Mc3TNQ7Tj0JSOsCO3h0d684aiPeVS7WFLpzkxSRuFBJwtnyWgNZzyw3ldLhV0RWCxVc/UbItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI9JizZ8Rz/2JvxA/UaGTsuj1P1fXJh3L4t2VN379WY=;
 b=IGYO6jU9pRTlMDKOXmc9vGPs3VzdQYuVz9Pxt3qcNlzDXwUtm8eHohWYdx0i662yc6yWBkfrBjdwyyi9qvUaGxcDNO5b1BTZvWZA2Zrf4CeWUFphWjeu267h+c1wbLVEZqGxISLC6sBEeSqgl2TC4fDVbdp7r+AYargAMj2rtrE=
Received: from DM6PR05CA0051.namprd05.prod.outlook.com (2603:10b6:5:335::20)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 11:27:34 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::1) by DM6PR05CA0051.outlook.office365.com
 (2603:10b6:5:335::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Wed, 5
 Feb 2025 11:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:27:33 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:27:30 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH 07/12] cpufreq/amd-pstate: Modularize perf<->freq conversion
Date: Wed, 5 Feb 2025 11:25:18 +0000
Message-ID: <20250205112523.201101-8-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b1aaab-5f03-47e1-db24-08dd45d815df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tf19k7vD5QTx3p61bgYozm1nfQiJevtMrRuesNPKqSblx5tAhSboEcxl9O1B?=
 =?us-ascii?Q?pnQz4CZFeYaZOa0M9G43b/dlB8KD04TlVB+xE1gi79/fRh1FcwQPppsIIgkh?=
 =?us-ascii?Q?U1HGphTGyHCeBg/H8Nk3ivGToVW1bRx7/0P2TyswFWK9kCd34pcFwlmzonM6?=
 =?us-ascii?Q?X1EzOgwxkh2IPkX5ohELjBuMKXCtgAXxRToQBjMsCLBDMQiKCSFSeXoeD3v3?=
 =?us-ascii?Q?QEuA0DTxt/EjEVnUDkm0sKtpXc6erL6VlFjeDV9HdJ8FuK6AEhyxqJwSJiJC?=
 =?us-ascii?Q?EdXWnEg9CwcN0M9EMxIKwEcfOAKr0f3d64dS5bm3GWYfTk9l5k7gzXCTqNQG?=
 =?us-ascii?Q?Wq1Je4PIlK0nybHNRCmg/E3LG/hSYQQychsNt4NAFs9J47jMRdGDHr9QWsr4?=
 =?us-ascii?Q?3bDjT8y1jkR/QnY7S4YLNAjD4X7gRK3JXUkUgNNHHv8eN1FM+TxAqbBb8if4?=
 =?us-ascii?Q?0TXmQrqmLpEBVQjKZm26xQ6cqV2eUwQXrOr9q7oBC6a4eycRWI5S7WKLiqk0?=
 =?us-ascii?Q?sfx2N7X7oJKv3DJH5sBN6moNZT9iFdO0DYwHuQeJzoe6InfY5GuKNvV4ViNK?=
 =?us-ascii?Q?80HRMtMp0Cvdla2OxlPdI5YoSqjowVSCjPAPnwjQMEbsigzKMbO5KjvV3OcD?=
 =?us-ascii?Q?WSwl3sM4LZcq0+Uh2A6D3FiYwY8mTD4dU9NOUCC8HaL5SsfuJtqoeYe5Y211?=
 =?us-ascii?Q?hZzwMaX8AgHYy+XcaCxJ9c+LK3GNpQsCaMxvpLXFnbFMucLhn9m3ouelBrsS?=
 =?us-ascii?Q?ldcocoU8TQ2Yiked65OcZ6FEXTq3fSm9PBplxL1seXC0IES0P0Xg+QGq2LGj?=
 =?us-ascii?Q?RU6E+IBTNwuDLZ4jcLLspwK4/9jRkcDX405RayQ/t1TepoRiuc8WmRTEdQ3n?=
 =?us-ascii?Q?N4njQos8ZYg9N9RlDanx5+LbsAl/ii6tL7uFr0Vk5Lf7srkMfXrE88c23xRh?=
 =?us-ascii?Q?1AN1l0IsjEXilNZPTuQuwfmE9r6p4sk2FJaF6Kjp/8jbnqSP0UsE7TwynXE5?=
 =?us-ascii?Q?zrihm4Z2+EAy839BFyeuuoAcggisVVVxWM1C3rmi5xPgU9IwEYtqA3G9WKsx?=
 =?us-ascii?Q?r8yRWEX+woCrlc/p5+wkxxcl5fiOLSH5VY8SP6PUnNcCda3aBPDQsCdKzmWL?=
 =?us-ascii?Q?jYnocL6wjKUKozy5grOicyRZs5oUqvvmDM6o+vKsWS5ZzbyqNoknOrRiDc0D?=
 =?us-ascii?Q?WxNvmcu890cd0Sa1wpNndZqP99v5j+RCTT1FYrtkgK0yA/9r55ze+L7bX7gF?=
 =?us-ascii?Q?Rmw/8a7q+DRinfofbC14RwuuEbjasZZaH5D2QEBslbp8R4XZCA7wy0C8cSvP?=
 =?us-ascii?Q?WzYHK7ibVTjq2JIWT4WZKim2vH2PTluM21UD2CIvA2QgPrtDC+NemKNfQLB4?=
 =?us-ascii?Q?qNWcHXOQiSuo5gcBY3okIIhx6KCTl8VHMqpvodKTheaa9LXKPZOLVBuu2QK+?=
 =?us-ascii?Q?Fj074mOQ7J73iIA1QkOccrwb3d83bQ9NNuOGoQX+nAk97XcoqnFPkHAux1yc?=
 =?us-ascii?Q?MajX+wlT1Ms265U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:27:33.7629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b1aaab-5f03-47e1-db24-08dd45d815df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

Delegate the perf<->frequency conversion to helper functions to reduce
code duplication, and improve readability.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 57 +++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dd4f23fa2587..346fac646eba 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -142,6 +142,20 @@ static struct quirk_entry quirk_amd_7k62 = {
 	.lowest_freq = 550,
 };
 
+static inline u8 freq_to_perf(struct amd_cpudata *cpudata, unsigned int freq_val)
+{
+	u8 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * cpudata->nominal_perf,
+					cpudata->nominal_freq);
+
+	return clamp_t(u8, perf_val, cpudata->lowest_perf, cpudata->highest_perf);
+}
+
+static inline u32 perf_to_freq(struct amd_cpudata *cpudata, u8 perf_val)
+{
+	return DIV_ROUND_UP_ULL((u64)cpudata->nominal_freq * perf_val,
+				cpudata->nominal_perf);
+}
+
 static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 {
 	/**
@@ -534,14 +548,12 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
 {
-	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
 	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
 
-	max_freq = READ_ONCE(cpudata->max_limit_freq);
-	policy->cur = div_u64(des_perf * max_freq, max_perf);
+	policy->cur = perf_to_freq(cpudata, des_perf);
 
 	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
 		min_perf = des_perf;
@@ -591,14 +603,11 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u8 max_limit_perf, min_limit_perf, max_perf;
-	u32 max_freq;
+	u8 max_limit_perf, min_limit_perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	max_perf = READ_ONCE(cpudata->highest_perf);
-	max_freq = READ_ONCE(cpudata->max_freq);
-	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
-	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
+	max_limit_perf = freq_to_perf(cpudata, policy->max);
+	min_limit_perf = freq_to_perf(cpudata, policy->min);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
@@ -616,21 +625,15 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 {
 	struct cpufreq_freqs freqs;
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u8 des_perf, cap_perf;
-
-	if (!cpudata->max_freq)
-		return -ENODEV;
+	u8 des_perf;
 
 	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
 
-	cap_perf = READ_ONCE(cpudata->highest_perf);
-
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
-	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
-				     cpudata->max_freq);
+	des_perf = freq_to_perf(cpudata, target_freq);
 
 	WARN_ON(fast_switch && !policy->fast_switch_enabled);
 	/*
@@ -904,7 +907,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
 	u32 min_freq, max_freq;
-	u8 highest_perf, nominal_perf, lowest_nonlinear_perf;
 	u32 nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
 
@@ -922,16 +924,17 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	else
 		nominal_freq = cppc_perf.nominal_freq;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
+	min_freq *= 1000;
+	nominal_freq *= 1000;
+
+	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
+	WRITE_ONCE(cpudata->min_freq, min_freq);
+
+	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
+	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
 
-	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
-	lowest_nonlinear_freq = div_u64((u64)nominal_freq * lowest_nonlinear_perf, nominal_perf);
-	WRITE_ONCE(cpudata->min_freq, min_freq * 1000);
-	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq * 1000);
-	WRITE_ONCE(cpudata->nominal_freq, nominal_freq * 1000);
-	WRITE_ONCE(cpudata->max_freq, max_freq * 1000);
+	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
+	WRITE_ONCE(cpudata->max_freq, max_freq);
 
 	/**
 	 * Below values need to be initialized correctly, otherwise driver will fail to load
-- 
2.34.1


