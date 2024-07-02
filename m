Return-Path: <linux-pm+bounces-10316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514791F0DB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60531C21D67
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3DA82886;
	Tue,  2 Jul 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x5FqVUce"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270342042;
	Tue,  2 Jul 2024 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908144; cv=fail; b=iJo8tMNPmDOOYQPkgnGbF3iy4N0lerIx4XoKzGJiTyHPTPJHvel6RAjLrZJbBZcu792qFO4Gi6gDaYTovUNfxjOdogMrDkMsg/obDQC7Vk5Sl2M69Bp/0oMCXh4886dQAmbsVby+XzoKQBadbhRtRru8aUZQaFxcwmQOoX6TR+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908144; c=relaxed/simple;
	bh=ordm5F/CkREteGUzJJv95f0wfud/s85es7wQGywXzz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjqPEeZB236ney4pdDmSZSqQh5AEZxCxZMZgy/k5nc+J1jnBd6blfSyRMn+9xaUsbySPADGqMUFbXCNfmi522tJiQMQJI8y0/qcclSV/6IN2jU6j5TCgOEdvxtjyhNVWaPJIsT3tFsHYonDoOrHrDOTnSjzLsWHcrQyuM0l/JK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x5FqVUce; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUAHSnwAdKxO2bBalE6haOHL089qvDQmh9F8n/msG0a4ysI8JYbGlhVvO3cEBaiWgtNwjtgcBczTu5m7pXV2hw+3ACiuogjhhRtbRSrriHqCcxAT0EIJKLmRkR4ZpskRTLgSW+Nlbd5zWJsePQltdSY56Ipy7JVnxt7icY3WFmKzqF6ZcC4sFXVBQiLmybPdbSWx1ffdokfZ2rDOKP5z11mp6x4QmWTrjh4mfkla+It8psbNP8fUVYpL+aIJtdJXSppusUfDcEKwGUktJs0LuzOi6We/tYAVabKGEuP7Lw5M4+IGnbzgF4PQ4ewsaNp3B6xcBwFk8PiVJpKQjO8alQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5KBFGHaHIeULCqojUYWygWVhdDvmbAVdxXgSs3ro4w=;
 b=Aw05PNQ3E/4UveIkC2us6u74k7DnnGEFA9RTLwhO5z1BxmE27y+GM7c9FdtL2VOEM5Bpu8+2NtugkAKR+huviF9Kc8ISleI6YY1hSEUVYjKY2FSTQBB4ej8W+GCozEO5BPO5NgKFcEAbd7ndFLj5Pg0rNWHM2ttUeHsciPr4TCoS9gTMJ3DSc/SCQRFzsGs0glvDH4w9DyF+3xiyqk7FdkRRw6dNWWEJPjF4WxHIw4N3gr/aXwQROeTyRDneU2obZ8PWF+8c5GAilOaPOdsV8LqNMpqqFRYUL/1oWXrnQoA8dNBvdlMjMWLSbFoc1Ozy92OKJAeMz52Mp96zfLEnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5KBFGHaHIeULCqojUYWygWVhdDvmbAVdxXgSs3ro4w=;
 b=x5FqVUce97fwHWjo3Kucy/WCscbT1jEwyXVwg5Uh7J2S0hFvT5CGZT9fPjSDX/BBJIWloBGHlpCKSXf+ak8kVok5rSJ7JX3XJy+YW8dwJqHzXnr1f/hKqf3/xAq6cqn+gYCa9UUVFhy6ejlJHjynej0oLuHNBxm/4t6BJNOQ8to=
Received: from MN2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:23a::6)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 08:15:39 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::7a) by MN2PR03CA0001.outlook.office365.com
 (2603:10b6:208:23a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Tue, 2 Jul 2024 08:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 08:15:39 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 03:15:33 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<skhan@linuxfoundation.org>, <li.meng@amd.com>, <ray.huang@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>, David Arcari <darcari@redhat.com>
Subject: [PATCH v2 1/2] cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
Date: Tue, 2 Jul 2024 08:14:13 +0000
Message-ID: <20240702081413.5688-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
References: <20240702081413.5688-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 152131bd-1ea3-4ea8-8382-08dc9a6f28c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wrYP+ZEfX2XcHkod8ointLAs8MmOuLMhk86qQ1d+FHCOlsh/6TLqOB2Jjl5g?=
 =?us-ascii?Q?kie5tLMVuy5FIXRXYMetkoq4nZ/zWLdVMrreNffbeIoJfa+t05u1CXeHUO7M?=
 =?us-ascii?Q?QLoOz/X23RLgIZ+4gtOdyK3ato8LGcsNypPfQzm8EpPA0jvl5o706IzGmqDn?=
 =?us-ascii?Q?kcStwhr5y7JETTyhXIw7KNO3iTCGfbBn8x5EqYTGl2P3Zqdd+0f64h6xqfVP?=
 =?us-ascii?Q?O53ijrJjKxXPje8bef2Ow7tR5SWqbC5V9FXDnoIAGscPo9HWXdFyi2BWEJxj?=
 =?us-ascii?Q?Eq7F9stSkbS0BosDXhGrB7Gf/ao8bOi0oZnsKLgEEdeiAyXa0tdchnr1qsfM?=
 =?us-ascii?Q?6AC3579D99vgXG/M8OPWC2kV17N9WpabOndBpa2bQBGuOMNnZSSlC925rTEG?=
 =?us-ascii?Q?t51gpHcUq+jCNBJ0WEMNaoHInnpQt46KrhcHGS4vPtNd4tbtBPLzdauBqSao?=
 =?us-ascii?Q?X/kLU6dm68tP9uLahNadT8OIMoiRRTvqYFXF5b6jZCHG3bZYNEa+Ov+qjPSk?=
 =?us-ascii?Q?traAOP2mlWGQK6IdyRZ0Fvj6socHitW8qIowR/WNZkzPvYMjI7K3BjZsb4Pu?=
 =?us-ascii?Q?IZvAf6Fh5Wq5HTDgKRxcrKErQTk+iEDmEBTjQo8GNIrEO0ciToKHXX9L6UbB?=
 =?us-ascii?Q?FRc5cRu9RE8AH9lbap1O1dKHmr72dHgBDkuiYln5bUw71tKBXUh1C1BRiMJF?=
 =?us-ascii?Q?7zwe4KO1wYa4+HA9EKiHO0VWMizhenVH3AW1MFG0ycfIB2b6RTM0cJMARr6H?=
 =?us-ascii?Q?6UGwxwOG4/1ybVBqM60Q28zqGxaOr6NbaQW7kpxLpQydt4goDPviUyt3oiQc?=
 =?us-ascii?Q?F2S2OceOl4YfrbP8ar13/63CibCJT94kTqYSaZpLYhY+OhpYkH9Ra7kkwwSP?=
 =?us-ascii?Q?Qjx8mpcUzVEoKYXmOBbgu+EqaoJMcjd9atKvMWn73pz84/i47/qUKr369Ate?=
 =?us-ascii?Q?MO44SIzYfnlrLYRxlnfCARwC1DAbiD9OBhxuvOIDMMOP5zuS2uxuFic4cXCW?=
 =?us-ascii?Q?P1hTAmXmsTQsQrUdbbwV8TeF+wSVL2D3kCXCqbnNvzf/DB9rATJKD3HIHl8/?=
 =?us-ascii?Q?5aU0dYXQidlFxBvK9Pk+o3qiciWxbupbzZzV74728V7J6tesQCx8ETw/E/d/?=
 =?us-ascii?Q?P/4DXs86O9D+d6n8iOqPSowmJeZgOtifxnvhCNRoIjio3suitSafs0P60pyJ?=
 =?us-ascii?Q?7V1AFV5vMZjoCa5rkdLtVwuSsBr688O37aE5y1eVqUyT2QG9B1iLo/4rryPW?=
 =?us-ascii?Q?M0Z0198+1zbpS4SWyM679F21nowmhlhb9jrnruPxmFD3LrvLBW8sJ04UlNPQ?=
 =?us-ascii?Q?IQu4czEh62WeNdItnlyBiozDrutxSLlDCuxGlehdGJbohJ50fUAZDT9NOe28?=
 =?us-ascii?Q?Wa5/jSKWsTnU6nNL5YDDmS75sTngD/EPGIeeE9Kx2XWbiBvykp63y9wA6VJ7?=
 =?us-ascii?Q?Dhl92LXAWERxlUgEP8KOutoUbwvSN/6Z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:15:39.1447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 152131bd-1ea3-4ea8-8382-08dc9a6f28c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948

cpudata->nominal_freq being in MHz whereas other frequencies being in
KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.

Fixes: e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max frequency units")
Reported-by: David Arcari <darcari@redhat.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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


