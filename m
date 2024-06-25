Return-Path: <linux-pm+bounces-9950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A483F916943
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DA61C20C63
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921BF158875;
	Tue, 25 Jun 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ds+TGfa/"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9217C98;
	Tue, 25 Jun 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323131; cv=fail; b=Do7GWq3WhPsztVPammRwP/IfFptQsC+AuOV8+mYQTYkaqu7ckB3rvAaugSY6//zsj22ATWFy04DoQZXhqUAXKf2uMobkod+JOgAUldJRFq6tpIWNFDg62VwFOvtSQb18q2VfaGg73DFFzQF2XJIVdp7ckAmVEf+yCPTm4QYCZrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323131; c=relaxed/simple;
	bh=8elzZM5EvZ7tDtmit7S/xV9c/0haCEvxZ+clVygvL6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNGhFL9E+Absy7IO1Rd0WJNhCwLdsFO23OHz7awXfHN3RI5II5d4vFnkGCel8B9kgxK5mSqFgzQMKCOkXITwU3po/FmKvpP3/K6gvLx3L/SCC3UKCnWoW0xWlohzE5mzh97tE+BKZ2QkMvLJkTKdAk6q3LLVm8QPi7Nr0P10wu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ds+TGfa/; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvgeurzKjhwVdkBunoPOEHG1UCUNwRcki2dsRXQhw3pZHhld2/uYvPuVxuzqbMW4YKi/YJ0iFjKZktrARDR8Yjh6sfcfH0hHGgvxvBQTlOP8qlNEmX7AQXjtwL0+kFJiN0EcPvYG594qs1+P8TwL2HgG/v3v7Y0D6Z/VC6XVQ5Tdg1qe7HWaRJVHz41P0Sl6JfXNUpiW8cThW9d/P2CJCnBwmjynjsJCjLfRXU1AVocnL9rdmNq04i/JJp8icwWCSWWGB024ASDsdgQpbowa3GUQa/zYXskQ5qBZsKvwrr/BTlTLnYodR3TnXXOjVNqck5d3Yry4hqG997EB5Xh9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFhMmYkaRZ5yMiDzTJtuRgSOfS4U2HFg5+tqxLzT0WY=;
 b=oOvkd233YIkoDiqBF/8Nl1uTuSzP5OIrYC11QaE4W39GVgnf/FhXP73e00Ts7syanjWeA35VQBhgxuJGwXgI1t/aRUTJ/DczxtGYj/xo1Iy2MgA6h2kZQlj+dnqrWmYZQ0O6jBKcXq8pTV0e1wuLpg9ONPYjG+9c6akf2nvCCmvMxT2v8GU8kOqp80ubjvy7jH5HTI2X5opyxEQqX+vV5xs9nJX6eYta2hobYA+aC+TslrEX3LegiGwYCVf3KOoY5FtKT6yICSbYlEaKeTgzW7OR7NbfQQOXQcUdPJVOh+imJXslMEZ5L1hoZJj9Q75PH4CMXMBppma+N5m47hGprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFhMmYkaRZ5yMiDzTJtuRgSOfS4U2HFg5+tqxLzT0WY=;
 b=ds+TGfa/my1tOQenbZn9QxIKCkpHTgnG4offw6Ft1vTQD7G2iulkzhTx5N/bxlc/aTs85Aey5pthwmZxLhmCPSIX+KITtEvrnG7Ge5mIRupZI9xSxOUfaN1yc7W4bH5stmqwrWDxSrbugXYjVDbaoP7krzOA4MIWS0MYhyKO0mY=
Received: from BL1PR13CA0324.namprd13.prod.outlook.com (2603:10b6:208:2c1::29)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 13:45:27 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::81) by BL1PR13CA0324.outlook.office365.com
 (2603:10b6:208:2c1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.16 via Frontend
 Transport; Tue, 25 Jun 2024 13:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 13:45:26 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 08:45:20 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>, <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 1/2] cpufreq/amd-pstate-ut: Handle the inconsistency 
Date: Tue, 25 Jun 2024 13:41:27 +0000
Message-ID: <20240625134127.4464-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
References: <20240625134127.4464-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0eb1f6-1cb2-40e9-0ce0-08dc951d1215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SLK/vmaup7SPCnmqjhYKDScprAu+LQwO9d5szUCY27JzpLGEUknXufh9drVz?=
 =?us-ascii?Q?FcOTyGywgag+IjMkRUfFTxFCKntRaZsuq+Hikyv+xc/PIX8qOulV7iGN3cKE?=
 =?us-ascii?Q?54mmhKLXgCIkIc+wbdPQHhgL6iewyTr9yQYkSpE6Z0T4wHHanvSG7OweESuH?=
 =?us-ascii?Q?vJHFNaTXdDpfAxUXF95dV8FQLb2mr/E0oYiN/yxK0QzI3URuCHleDFzbIonv?=
 =?us-ascii?Q?IqEnFaBIXt6wlba8gDTUXvWsoO+P63+2SfQsn+oO355WQRg28pedplKOccbh?=
 =?us-ascii?Q?MHaXuP/DxgvzS1S+ZzhnrKideJe2rA0ruIBx2QbHml2jntcOJtjXdgR9CR8H?=
 =?us-ascii?Q?rHivmfhBbBKu+y5fG3W2LYjEPXzOZjPYk1WtkiFD7FIdNwMZZCoCgeku1iIk?=
 =?us-ascii?Q?VDgtpDPDHh91UInoKGaheVmgqmky4+s727w/Cw+YTn1yGFgqvAjV46+6ajF3?=
 =?us-ascii?Q?kKy2JvjQwRFHNJJ8scZudwWYULLGTanRO9Ye7vrLqb6I/KUc9hgxPElDTHdq?=
 =?us-ascii?Q?EBTPLzGezdx0ZabW3ImFYtii5Z0eJdVBvOiCtuZerDi2MaQW+HkqlbWsCnU/?=
 =?us-ascii?Q?KqXSYMfpsblr/3T78lbQWJZkW+9HMpbyBTgkg6MrUeatSiAFuqWPb54Xh06z?=
 =?us-ascii?Q?ogXwYwptXHMurhstm+2GoslIucLSv/YQyFXqvrW+VYEl1IAZCdA4fS+ZiBia?=
 =?us-ascii?Q?gYBvOt6P1Q6YFMu8bdvp9H5sN3fU2/N7UQBmI/BN5xDNK32zDw8n9tzxD9zp?=
 =?us-ascii?Q?GGITDarW50JHNYW3K/S8Ys5U8oli6V+iWPL14EMJZqYk97ZxMWuN4lujPv2v?=
 =?us-ascii?Q?ntoKytvGBA1RwVXjdSbvKlDFEB2UFAFgkUv4Nh+72a/mLDbCM/yuvBxLWA81?=
 =?us-ascii?Q?8FfAvE9Dy7Wk9tCDMiJWNSpTOG3dApH5YFESMr/fn2bz3WGKvDTFGu246ZIO?=
 =?us-ascii?Q?73JJYS5v2qridncze+qHZT+fga6pmFfIMkaamQ5pmlYWsk+qM1Vn66OUWz+S?=
 =?us-ascii?Q?WORowO8YV6ux3q7kMQO7VlBLKSk9lBg/ZuDz92OuLw2lMTkv6hDzDvvWn0my?=
 =?us-ascii?Q?pw/IXN1xywK+Q8k2sXq+HGxpiOVp07slRxcEffCah6f46yiX7DlPH2cyz0BW?=
 =?us-ascii?Q?Z0IRCmBFlig0VXSvnM7vx8McykaXaMPh3OVt6tAzJoAc79Ge7qKqVGFVZC70?=
 =?us-ascii?Q?ihaeExMAsCeJYAc2Zy+JFBCST1gX3bSrOMutoPg+wsXVdDADPpAjBxlfKuXM?=
 =?us-ascii?Q?tSbhCDanwsNBK7+bzlOeR+8zYKykCZpt9JRIZiSRe+m3uBgcKfCzKHlTeuTf?=
 =?us-ascii?Q?WDUik0BaeBjJF1pmvz6wR2JRjJYX9aXGbrAiDqgJxlD/bNeKxg3FYgarYmP/?=
 =?us-ascii?Q?Xhoq2INsBt4geUaS2zw5S5l6riPOuzbsSm7iEfRRC6j7jqJ2Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:45:26.8633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0eb1f6-1cb2-40e9-0ce0-08dc951d1215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

cpudata->nominal_freq being in MHz whereas other frequencies being in
KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.

Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index fc275d41d51e..66b73c308ce6 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -202,6 +202,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 	int cpu = 0;
 	struct cpufreq_policy *policy = NULL;
 	struct amd_cpudata *cpudata = NULL;
+	u32 nominal_freq_khz;
 
 	for_each_possible_cpu(cpu) {
 		policy = cpufreq_cpu_get(cpu);
@@ -209,13 +210,14 @@ static void amd_pstate_ut_check_freq(u32 index)
 			break;
 		cpudata = policy->driver_data;
 
-		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
-			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
+		nominal_freq_khz = cpudata->nominal_freq*1000;
+		if (!((cpudata->max_freq >= nominal_freq_khz) &&
+			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
 			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
 			(cpudata->min_freq > 0))) {
 			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
-				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
+				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
 				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
 			goto skip_test;
 		}
@@ -229,13 +231,13 @@ static void amd_pstate_ut_check_freq(u32 index)
 
 		if (cpudata->boost_supported) {
 			if ((policy->max == cpudata->max_freq) ||
-					(policy->max == cpudata->nominal_freq))
+					(policy->max == nominal_freq_khz))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
 			else {
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
 				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
 					__func__, cpu, policy->max, cpudata->max_freq,
-					cpudata->nominal_freq);
+					nominal_freq_khz);
 				goto skip_test;
 			}
 		} else {
-- 
2.34.1


