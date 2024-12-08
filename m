Return-Path: <linux-pm+bounces-18744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D29E83E1
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2415C1659B1
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C015535B9;
	Sun,  8 Dec 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QwYWZDxT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C71E86E;
	Sun,  8 Dec 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639458; cv=fail; b=bkL/7BZKKA1Tr755546W1YTyIglZAbRvn8vOho9HHos7gPGfFiRtUXGrBf3O7fxNVpe0D1KVV02MgL5EK2R5EoPvgVWBN5bszOw4Fi6GWNspPMgw/uPI05z2hsf+eIUndg/yKOK084vhlEZbm+SbMxbrFwCNG+kd/yn5TZcYAiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639458; c=relaxed/simple;
	bh=UeYbhWvQcmWInVcHnNY1JbEhvvPPfHrL8JLlYCSFOJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAlU7zucDg7AKplVIUKCQ/htkzk8oKMva4TWEBSzpM6ZfYMJ2hGvHxUQxmxVZq9Y9Ye3QHMyGpZ6NLpRpocT9P2F8lwfkiTuWpC0BwJO4TcNGYR+PANZQgV7jATufceik6wsOgCHcF0B3HZ+W1wLDK6wtma2L5LLe/3KYo3F/lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QwYWZDxT; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0pM/eCsepYnHU2aA42rCTZ+ff9snM/CZiocIJjk80h0FJxbMu4mPDkslGZ20+0z4BTfPAmZzU284VQm3na+Wy2IkpeZjEbLmiAh7Lop67hROin6vbOvBSOL+Eru8+TSgHjJzTi7b6kC0XrDAN9mgWilG98j96/xKU2doUO48ibQX/6jugZzkiwTTuyWznmbj9RKmZTToxVkvCmHVhwdD5XlNp6iu5rH1qrrqHQLk1/aAjMyCsmY3PzzrfTIWnigmFfK/fgxsDXzogm4G7YRZiCRTtUp7LjYpynYDe4dknCefLzaL9ZpS46ZL8AYswVU2jHqFaOVf+jGKxKy7URSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFQ7YJImPddudTRBlzJyzW4I+aKSrlmWqIIyVP4Ca9c=;
 b=qt9I28755lhJrBbwgLSQmk0Rhy1roAaY2BRNCZzDgT5iZNEX1rzcmTVoP/rgd1OVbCmAviaJH26FvKwa/0MDOZe5aP9tPWg8wP60/hD+D880j4aaBPk6tLDcSqXKsPee28m4ZJh7xBGPpNrlStD5+YwCJvQgom2UEMMoJca/fL5oTa4IMxumHMbnTJJZ2KP2XUgUjjycn2PYtAHu2MUgADBjO1v1EduimeRWplF0F1VzzvQiF2o5IlA4UPqbGHrw73ZQ6NAMdvIIW56EkIa504L2ZMsr4WgMWxi+0/YgyLDHxMfm9iHYpc1HSP2luE0i0ydu5Zp/VatisakvCDraqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFQ7YJImPddudTRBlzJyzW4I+aKSrlmWqIIyVP4Ca9c=;
 b=QwYWZDxTNjVYCDBFPU1Kz0PdSSSdTa7ZjwHjGYSyvgaA2nu+ySiotXrBZQ5pZlS3Iq6JxlKH4X0C4mGLvLfVFXOpqcEADrmjoQwtgVSeAaLCzM/tc0TfijxoVEtGq6gedrrHQ5wWyg0aY57mpXYdf8IMFP3T0m8qbH1TYIZTK48=
Received: from DS7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::6) by
 CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Sun, 8 Dec 2024 06:30:53 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::f6) by DS7P220CA0001.outlook.office365.com
 (2603:10b6:8:1ca::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:50 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 01/16] cpufreq/amd-pstate: Store the boost numerator as highest perf again
Date: Sun, 8 Dec 2024 00:30:16 -0600
Message-ID: <20241208063031.3113-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: b75a59dc-eb1d-4582-ccc9-08dd1751dd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pJHhY14kuL47hNNC55dKY++Us3M6jeWRLU5VVW7lqWwH1UphH/SaL8Y3rc05?=
 =?us-ascii?Q?l0ErAXaofbglAZ/c5rxIeu9ti2j3lUumWzMm4P2MCn+57OEmM1hHUxyvA4pk?=
 =?us-ascii?Q?QCBHb13zBoXE2Swy523l2dXsgkW6c3rwcBaFLDA/bOb6sCvss3jpwvVer3Et?=
 =?us-ascii?Q?Aa8Rc1COTrhepPZLvFC30C5AtKM+RSARFR6H1d3hfVMFvrD2Rts6nHHtoDMH?=
 =?us-ascii?Q?dlztrppAsMvcaS++/v2F9scwnDMS87ncq0yNlnjqFEeqhzPfyBAnfpKT6fDR?=
 =?us-ascii?Q?V62jMIYG+GaC4s5T3v3iFcgO5ibMx3lyE47QQHnA5V6Wayz2oibH1k3NwUz2?=
 =?us-ascii?Q?vxtxfZ4IuxOXPZ2TIFMftOJcAgIRB5u2NZeWTKYFLnRkPDIA1IR6aFPSJaaO?=
 =?us-ascii?Q?0G7Y9s2wAv4umrpsHEsG2EE+yjwBNo6+gJZh9EgO/mxomhJidzCiowOYMm3+?=
 =?us-ascii?Q?cAgwRy9BxYPutZA1e9qgKZzwXwxqfUr6rPdlQFYJGhS32m48HrnOD/jTurGE?=
 =?us-ascii?Q?Sa9bgoGu8G1zq7RIMAfH7PF+nCSOfIh/daiTg9dFVmIGvsDQBMGgrsPR8QoQ?=
 =?us-ascii?Q?/s/j7M5LMe7JeK9cYoMih+dwCxtynXvGgDEMe+S+UsrTcs8oXZspBaeTgQXb?=
 =?us-ascii?Q?aw8eUz1MAvjrYdST+aYoZ+kuzSH280P5FTYZ6p7/Og7qbiQHnyA0X4BWxhz4?=
 =?us-ascii?Q?tMJj73WstIBrRWqK+seO5fyystlV4iLQdzX1JPG4DRAh0PR3MjNOzJFl5Q5c?=
 =?us-ascii?Q?cw+ZrqL5XhM8lcl8UN+QLO/78G3L7tIYRVBodWPAT3HACzQDXm5AMCONJN0f?=
 =?us-ascii?Q?rhNvi6bd4htySVe7ClzbQXdY9fgAoCqY1xHil6E40BjvC/MSF0LZ0uhFiUiy?=
 =?us-ascii?Q?YzhL5EEzUt+DG3LOA7h2PWrkYC5/u3jc75Fay1Fu4RkR9DLCHgpFGCdZ4+mc?=
 =?us-ascii?Q?m9BS4ahYwk7TP6RtYyM8yX5mur+GE+p8I/b+tzExp3DXnQQYiSCU1WRqs4f6?=
 =?us-ascii?Q?6Ax6MdrD4HoOimyiC7Nds+UOtTdynrvf/d8hc+QYNpmK35LqNeXFY5MHbFeT?=
 =?us-ascii?Q?ijYvCA8JYOdRPFgrxapL/NiHpptEO/idSVe9UhoO8juVBq9tny0M9Quub3cX?=
 =?us-ascii?Q?otAZgDxrc+d4epcXeNvhrk2AmTVISEqM2KR2YlGfoxjeBMKaSlPpaZXKls1k?=
 =?us-ascii?Q?c1WaFBPnfVylrbjlNkW2jjKe/KVXYsc9HUvDeyew0PY3BTlFYS9ORXbU+nrJ?=
 =?us-ascii?Q?xTnvRjxW0ugyMXEvdNEA+TjHQXuOpmb58/anxrC2+Un4UqZLDVTDkwu5ToWT?=
 =?us-ascii?Q?xxWTTN/8K9FnZ4Z+bv22iee62y7fNkQkHL/rxvfonQo+S2dWJfl3E+IfQfeX?=
 =?us-ascii?Q?doYmAQAfE/cW7021nBthkUEH0lqAZ+g/bQ9gaCBySrsKlZcqMea3l0J5pKTf?=
 =?us-ascii?Q?NzxvaZUW0quEh8A+74wu3/o88LGWLEHK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:52.6233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75a59dc-eb1d-4582-ccc9-08dd1751dd3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249

commit ad4caad58d91d ("cpufreq: amd-pstate: Merge
amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
changed the semantics for highest perf and commit 18d9b52271213
("cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled")
worked around those semantic changes.

This however is a confusing result and furthermore makes it awkward to
change frequency limits and boost due to the scaling differences. Restore
the boost numerator to highest perf again.

Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Fixes: ad4caad58d91 ("cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst |  4 +---
 drivers/cpufreq/amd-pstate.c                | 25 ++++++++++++---------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 210a808b74ec2..412423c54f258 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -251,9 +251,7 @@ performance supported in `AMD CPPC Performance Capability <perf_cap_>`_).
 In some ASICs, the highest CPPC performance is not the one in the ``_CPC``
 table, so we need to expose it to sysfs. If boost is not active, but
 still supported, this maximum frequency will be larger than the one in
-``cpuinfo``. On systems that support preferred core, the driver will have
-different values for some cores than others and this will reflect the values
-advertised by the platform at bootup.
+``cpuinfo``.
 This attribute is read-only.
 
 ``amd_pstate_lowest_nonlinear_freq``
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 66fb7aee95d24..c51026fe636a9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -397,15 +397,19 @@ static inline int amd_pstate_cppc_enable(bool enable)
 
 static int msr_init_perf(struct amd_cpudata *cpudata)
 {
-	u64 cap1;
+	u64 cap1, numerator;
 
 	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
 	if (ret)
 		return ret;
 
-	WRITE_ONCE(cpudata->highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
-	WRITE_ONCE(cpudata->max_limit_perf, AMD_CPPC_HIGHEST_PERF(cap1));
+	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpudata->highest_perf, numerator);
+	WRITE_ONCE(cpudata->max_limit_perf, numerator);
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
@@ -417,13 +421,18 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 static int shmem_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
+	u64 numerator;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
 
-	WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf);
-	WRITE_ONCE(cpudata->max_limit_perf, cppc_perf.highest_perf);
+	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpudata->highest_perf, numerator);
+	WRITE_ONCE(cpudata->max_limit_perf, numerator);
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
@@ -912,7 +921,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
 	u32 min_freq, max_freq;
-	u64 numerator;
 	u32 nominal_perf, nominal_freq;
 	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
 	u32 boost_ratio, lowest_nonlinear_ratio;
@@ -934,10 +942,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
-	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
-	if (ret)
-		return ret;
-	boost_ratio = div_u64(numerator << SCHED_CAPACITY_SHIFT, nominal_perf);
+	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
 	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
 
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
-- 
2.43.0


