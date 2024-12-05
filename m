Return-Path: <linux-pm+bounces-18653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A2F9E6095
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BE12844C8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365581DED72;
	Thu,  5 Dec 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MhtAvlX7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428CA1DDA0E;
	Thu,  5 Dec 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437756; cv=fail; b=ugBFSjyjiwMeTAiWcMHJUVfIeg8sc19KwpI1dLeTkzPH5uJ2cDPytl9DM8M896VRMMROJYpMBMOE4izg+B5mpLdkIzVy+7dGSLrBFy1q8bolkfTkoWGT5vSOYf/Dk6eWIjDGY807WI7UZ22kptNagdUX0xTDHaQt6298WUzsyvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437756; c=relaxed/simple;
	bh=ptCnKCG8KmQnnvARtgWIvlgTs1AO7GIG4p+hh8QmphY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXJ4jsB5SO2oAl2snrZBbA45MtpTh3gj1pfGD9ZfdiB+KMz7j2xCdhzJbdxCVzlsYwdKenUDwmmXPOQj9KOKcCw0PS6WBqgGDG99yr+jlXL2YxW517upb/OBWtNT8hppM1yfNb2VTwoCGDQHbnuOpY2tikEwA7Xz+SIYoXYe4ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MhtAvlX7; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCFRqkWw2R741lmW91ADQhZqS+G7a3yBv2pKdLsbHRhff1jlxk68BqBqvR/R0ZPiHowDywiWHxM+6UbFxt7sLuo/uD9htpBR9kLe7YrKMllc1ISbB+5BS6oel0ZpSwkuFT8GvKyS+JWvL9wa36wN++VN1D7mm5yDaRpgx+2lG3uyuXwnUwwK0X9lYbsp+XOt8sHQmvW5JPbhqRAssyMku9FnhQC+9qqtbAOggRNttzSNcJA1CrI5XFa3hWnzALpd2IJH7CDwa39l99JMwWIGy/XZAnvUZ6Lnb0m0z23w1hcLSkcatUDCac5DX+zkduC7BT8a/NWxSW6Daid1qrlOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/W3HXm+im+tVDR84or474wpfN3txJm+qA8dG1mFqCE=;
 b=BGmveddPuLpLBK9f7TkyRlyXOaVqTFpIMe5PhbnlFDCu0UuxTe6+nrdq3xVRKUHp4QuaFPqEmBigw6t2rbcA2NMWzpCDB6b6TDXpfFOk2P3t3W01kTmBv3F4oJ5BB4ZfruyoEEDsuQP5k3QpSdu+fhKxfP7KNlesjbzCfw9DbS+Zn6Kicap8gYIeVPT9yxB42GnGnjl2JcVkB3zqPlaLOk9eOSk7p45ax1MVYAEbX+E2Hkx2WU6NiZHrCiiRDAzRosQVEv1LhcjwgYVAGLJtbAg6sWotJSljrAPbamesnkPsqsl4pl0xVta7rj72pi6NANhOtHxQb/8uq7gokKXigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/W3HXm+im+tVDR84or474wpfN3txJm+qA8dG1mFqCE=;
 b=MhtAvlX7qym1t0ud2JR9fhvOSKNefxe1hQdFdadJp/j8EhMO2MmIVvff9h4rjeNMtrb7/2OpzUd17y1rJipLGuiD/P1C1CvRxy2hoU7EwlAOLMJOOYCu5tUswscu1IcnM2bJ1ZNTQS6rxti1jR89DaNYEn/3OAKQvMAGVhx8A1A=
Received: from CH0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:610:e7::33)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 22:29:08 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::74) by CH0PR03CA0238.outlook.office365.com
 (2603:10b6:610:e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 22:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:07 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:03 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 05/15] cpufreq/amd-pstate: Store the boost numerator as highest perf again
Date: Thu, 5 Dec 2024 16:28:37 -0600
Message-ID: <20241205222847.7889-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: a9831660-3f20-449d-6efe-08dd157c3b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S0zRdPbm370a1hf+zKmXFQHQD6ZBLuOJZTzV/0QhiRk4KPpCwme9+7jcgqHa?=
 =?us-ascii?Q?vGiN8x/YUcd5jp6g9pcFkqEEUE+kqPAfMpHuxoDJi9MeKGmoeDaA3EqwtLMj?=
 =?us-ascii?Q?5djzdX/3kIyNV2bzfS2Lkht8xErwdkQ1Lq7Mk8G9AF9TpmWN+TDuvLFFM+Ys?=
 =?us-ascii?Q?zXxUjIqbeyQi8e22yP1Ae211UmuBUmnntdIFHs89mTzmFAGJ0hcbvkQ+fz5F?=
 =?us-ascii?Q?+KqPsRF33ECxSwbbHXIuO4EXz7jU3waSYhJ2Ak5fNosBl9XCV85zLaEtvyDe?=
 =?us-ascii?Q?cn9Jo43XggJPxa7OurslJ4A2E70jR0Eov3COmeL76UtKUSHj7eCVDxS3Y0zQ?=
 =?us-ascii?Q?iHDs99gedFgcrEGvx/To5r98rV9KomSGz1dCybbc874otO48aQeUZu8ey1xe?=
 =?us-ascii?Q?LelJdnyls18eI6LOPD7c/e4n0mtzhIvq9heK3XrP6YVuBUtfjBjPiVHH6Vzj?=
 =?us-ascii?Q?vqg8XeJrICq9Fztk30plCzO7swEGqcWdlmHbf3gOF2GXBAH+T48eU1yRdKDd?=
 =?us-ascii?Q?XU9uuEGle3zHDuCo8vEJ9Bo+4eRcr1GOI84mjMCT0Gugd66Pw9I9pjboo/69?=
 =?us-ascii?Q?KgrcQQdgbZpqYGQ7SR/AGMrQDX2B07vX8zGMNJ0cgVlSXL9IhnSeo+O8fJwK?=
 =?us-ascii?Q?tjltoFueqs4UODxsi4axGfuQMa4JQqPgfDPO3zPINKhrikzG1MqAGcr4Fwto?=
 =?us-ascii?Q?qHJvXinzC7O76XVJzAoyvbNdyXDJYAaWj8SzyEiou/0/sfyFoePsbIqAPzyF?=
 =?us-ascii?Q?amn13qCq2mtY3EMoLrWN0aoyVJWmqrQsXjLablwL0zacficCJMy34pnQ2Vu8?=
 =?us-ascii?Q?TlhoS6yeDMVs4aCnLYyuhI2SmmExemAjVHY/Sqw0SMCRcZkGDq9OxaHDmXfW?=
 =?us-ascii?Q?ZGffuvQF88PG/A98LJdTCWyEi5PEZQwxZCw1kHc3/KO/R+5cvx90ORIB/gZa?=
 =?us-ascii?Q?1oVHx7UNWJaXGYH9eKLujkStuCQFyIrGOX4mZ37yftosT5YZwEPmIDLn6C/B?=
 =?us-ascii?Q?r07anajc6piRhQEmzNo81JMtUfLBZ+0fjS/F6O9nro3tBisaRZRWzT0ryhRX?=
 =?us-ascii?Q?As/MLWRO2X9HXFBKfqCub4biy1e9Hje0vftbrOM6ZU7tVOWCu/kReGhJjQWF?=
 =?us-ascii?Q?cgY2tQO3ZvtIcX9i0TFHDlJ8NCLqIJFA/VihB6ivaGfXZzOK2j2tJ27wiM/1?=
 =?us-ascii?Q?pSt2hvF1qhaf3hI6T7pNeHKU+/M9az/acJMpop1VDXKsPItN1yeuBstteRwB?=
 =?us-ascii?Q?dTLdId/wiJrtr4SGkwgvrW547nmMV9PyN1Gt71DIjifvX49k7t9PRLKU1gly?=
 =?us-ascii?Q?J1itpGhxlNqa9SNaKeclOx7/XnX0E/dVb1N/lLk/Px08UtCBEi/+9jAMx3a9?=
 =?us-ascii?Q?vlsogNa6V81ldKbWwHfA2SxZl55tHAYoLRG3VzI+CcNZ5pv0N8Eh/1vr/+Pr?=
 =?us-ascii?Q?Jv8o3dZ7tfLUtVkUn+C9qtqbjbUFD9Nl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:07.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9831660-3f20-449d-6efe-08dd157c3b9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006

commit ad4caad58d91d ("cpufreq: amd-pstate: Merge
amd_pstate_highest_perf_set() into amd_get_boost_ratio_numerator()")
changed the semantics for highest perf and commit 18d9b52271213
("cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled")
worked around those semantic changes.

This however is a confusing result and furthermore makes it awkward to
change frequency limits and boost due to the scaling differences. Restore
the boost numerator to highest perf again.

Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
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
index dbe014f3c2beb..738f63d70546f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -408,15 +408,19 @@ static inline int amd_pstate_cppc_enable(bool enable)
 
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
@@ -428,13 +432,18 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
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
@@ -920,7 +929,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
 	u32 min_freq, max_freq;
-	u64 numerator;
 	u32 nominal_perf, nominal_freq;
 	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
 	u32 boost_ratio, lowest_nonlinear_ratio;
@@ -942,10 +950,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
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


