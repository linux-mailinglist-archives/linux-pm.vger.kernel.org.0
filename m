Return-Path: <linux-pm+bounces-15093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7C998EBDA
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 10:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE167B236AD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E372F13AD32;
	Thu,  3 Oct 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3AjduqNx"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC3482ED;
	Thu,  3 Oct 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945205; cv=fail; b=VX1fv+koFl7MfRP6/2Dl9YKgYJsXs+baGTm0IUPSBms/ECMbOjnZc/Up9oinwVqW5kWDbnA9M838vAb51yUfMNX/+vKuWSAOmDmb+RaUmy2aqCZAI1ktc5rvMifd5y1Vvxb/pHBXi9JatU6QjXhP+C/y0FJtqlpCyTUeZpAUowk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945205; c=relaxed/simple;
	bh=syqBg/BiHojtTZhVA3ErNEbK223lK+APjIhM3AUnR5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CH3/To9gGob/oi03Tc6dworBTYH3uMFqw1wEej8y9cebzHcOAMUOHYDKV2PeFCvineKQDqpjReELMb10rTN6KGcl1tEyqtRWF/ai4WgPQcbgmubLu1ro4wfXe7JLnGiSbl+5chwuQGsFTw9EGgKckiTK416XX+Qe1ac5NpG/P8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3AjduqNx; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIFpX86ZBGg2sPwP/WDd6FpadLwmFfb+80xaevC2vN467DnlOPKIvDwvLP7/bLwiWbjtIp9f0WBIEZwFInY1ib9yAIRH10jfd6nbi8DSBK58a/69YNXZM/xdSWkf83HE2Ds/XbHR79msC5sLWJ6WOyRATVSPZ0/iBTj2BFkOt1emKxHgrDlpTF9C9QvA8HYXcdKYZNWYvtVouET+z9ifTJ/+oY2bYj3BWayJbRiwT10uDd75KEVG5SKlnD93HDaGp+K9Jo/fR16hghaRt8K6Gpv0jn+qrYx42NSH9+d3tgCEmjE/CYvEVTRYm5RLYPmIe4ip+JD1IKlaojs6EB0blQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkcq0w1o0GK77QGsu+bKbA/cAyb0bpUrcB8TJZC3AMk=;
 b=LtksVsKRwiEBEypDIEpNeAuHF8TUIia+rLEZPBvMa02/RwK4EDx7OEyToKdlj2PgjqinIIBnI+CQR1yPo613HaHgzjKqDgnrtizVsF6Tp/vWHa5LL65ey8FS8swdAoiIQ7YZDi3gHrzm2KMOn7Ge0QobpnxmRHuYvIYkaLEkhv5xPR6B3rySb62x+kzuOc5kL/PWwhIz5pwrjY3p7F6Ls1xhhaufj6v0l1ABvtpJ+SgvluljkwktIreuAbOxBS3N6XN1nVqill7k/CeS9lOULVOmoSPkSbUwMAMzHCilhBCH7Fn6sBbkTKMqDqOICRSbYdjbCDDewQjN8BMESsXl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkcq0w1o0GK77QGsu+bKbA/cAyb0bpUrcB8TJZC3AMk=;
 b=3AjduqNxOXPRndQtr7EJvvXn5ZFweHfp7a+DQfuU1wYCpZBH9sSwSg4Y2pqpyL/tf8WjWqkd8vdqH+OKiUme6HuIpmXpdTgnyWVSXjlIH0d0Cr9Nj0+b4bFLyTTxXSOFCgvV8n3Dizsmyp/pf5TctwVIOwkTvK7FoUkXuwzvzJk=
Received: from CY5PR13CA0011.namprd13.prod.outlook.com (2603:10b6:930::16) by
 SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Thu, 3 Oct 2024 08:46:39 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::d3) by CY5PR13CA0011.outlook.office365.com
 (2603:10b6:930::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9 via Frontend
 Transport; Thu, 3 Oct 2024 08:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 08:46:39 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 03:46:35 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 3/3] cpufreq/amd-pstate: Cleanup the old min_freq qos request remnants
Date: Thu, 3 Oct 2024 08:39:56 +0000
Message-ID: <20241003083952.3186-4-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: f0406083-d0bc-4822-1df4-08dce387e5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bXcLbrvjKpN0t7MpoZIf99sjOG3auNl1kh+iJ9IfkD5ASpwXG1GsE+eduaUu?=
 =?us-ascii?Q?/bcjqxbZtGu1Jref1t2z6WNFbBw5S7KPxR4cuhYHYwMEnJZyAjvOlaT4jV5B?=
 =?us-ascii?Q?lCBxQlLlNecehtBor6nyOjZd52W+hAP5o9U0m4Pe7aDwouXnkZAAhvKYwIDV?=
 =?us-ascii?Q?GEu10QzleDsXgNq/fl1lRlT+yCfQm9BAlHpoFnff75IzSdDDvAt0H2mzIeJ5?=
 =?us-ascii?Q?sbF/vU+kC7OmmqRzCBQzklS4GCQrmR8ZZkhKu7tcAIfymctcvmSHgIJVr4tN?=
 =?us-ascii?Q?IA5datHcvI+j/vY1DJc3z5GfZFNoCyfjcjqztSeA3CBwXa3Sg5bmJPot/Whu?=
 =?us-ascii?Q?zuapAhUJ12tS0civN38PPuoEp4qVWAZVfexj+jw+6o1HkogmZEz68B4IrkjM?=
 =?us-ascii?Q?954ps05LeoXl+hMyX3psy2joIklXSRW8dugx9p8KwXyVGchkeSKujQ7RLVcV?=
 =?us-ascii?Q?ZkVw/+4ZUMzuaZbDIDWaRnl8ZFffb9VJnD1B8gNjvpNa9EaHcV4NLMzRSuV3?=
 =?us-ascii?Q?ixAG7AUtMVX8y26tFZTtxWZivpLwlHkJK1VdcC3YXu+MWypJh4EMFSdVvteQ?=
 =?us-ascii?Q?ysPskad04m8o9wKHZNILY0bQqFVmv71Q85EoXC7KYr5awuYRn9paTnXVh2T7?=
 =?us-ascii?Q?K0mZBUsj+4aFxXVkBtL6vnVXh6L8AaAQVoZTh/17PdxqPlEA8wfVofKQBd46?=
 =?us-ascii?Q?ARhIiMqOkroOqv2Zty1BtbpX0MH9LYONvHgvCYQgi5NGFVRPCgokDULf+6Ap?=
 =?us-ascii?Q?CjDl/WrPjLzKvV4CuMF0ProOcPHJurwlRfEz5jilDLWqW+4OvUN9Lddhn+6Q?=
 =?us-ascii?Q?/DHisKjG4Xc+ubdjyOS+fjbZ6QjObt+xrHkVurM1oJ5XBu4JxZeoQ4ZU9t26?=
 =?us-ascii?Q?CR12SrCbpMKOMNg26/jZSVEqNhKDTAbqHAz93CBpyQ3nx1tGlIaMDnGQrEWr?=
 =?us-ascii?Q?SzgNTEQ98l+GJUBHGqPprG8+bWO3GsDFC2ChvyOjUuvU9bX0DE5uICrX7q3A?=
 =?us-ascii?Q?dsKjMEyxgRKg433qwc4h8oZk1P6c3dqY9RWj9nI91y9Nheywcr4Pj2usbz2D?=
 =?us-ascii?Q?7CNHHo6xyZMWYAFStoJNHEZ61VpIzL41TDjbvdoraelPiV6pjdhBt79nlVVq?=
 =?us-ascii?Q?9DnvylnbdAsLUmbIMm3SlPS4cVM2E/rHaUaz2kC7RuULgYIDT0O6ubSelbYw?=
 =?us-ascii?Q?1gEozUGJnXpvWKNLSNOlnKpU3j+Rq/x0C/UzUD8C40GtMB4ddRWr9IsPn/m/?=
 =?us-ascii?Q?SleGBJU4xV6skA02EYTRvYaO2+2ZWyYM/+E7QP44qo+IQOPV5bFLq6hyLIUA?=
 =?us-ascii?Q?p3yBWr6XJjahRxasqgKR9mElSo6o+KuxJEJzjCa8tILZcYs5eVXizak+Rz3/?=
 =?us-ascii?Q?m014aEP2oErtvKyI+b5XVlL+sra4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:46:39.1572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0406083-d0bc-4822-1df4-08dce387e5b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

Convert the freq_qos_request array in struct amd_cpudata to a single
variable (only for max_freq request). Remove the references to cpudata->req
array. Remove and rename the jump labels accordingly.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 19 ++++++++-----------
 drivers/cpufreq/amd-pstate.h |  4 ++--
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f8abae9a0156..cdc08d2ddd52 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -696,7 +696,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	policy->max = policy->cpuinfo.max_freq;
 
 	if (cppc_state == AMD_PSTATE_PASSIVE) {
-		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
+		ret = freq_qos_update_request(&cpudata->max_freq_req, policy->cpuinfo.max_freq);
 		if (ret < 0)
 			pr_debug("Failed to update freq constraint: CPU%d\n", cpudata->cpu);
 	}
@@ -963,17 +963,17 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
-		goto free_cpudata1;
+		goto free_cpudata;
 
 	amd_pstate_init_prefcore(cpudata);
 
 	ret = amd_pstate_init_freq(cpudata);
 	if (ret)
-		goto free_cpudata1;
+		goto free_cpudata;
 
 	ret = amd_pstate_init_boost_support(cpudata);
 	if (ret)
-		goto free_cpudata1;
+		goto free_cpudata;
 
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
@@ -995,11 +995,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (cpu_feature_enabled(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
-	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
+	ret = freq_qos_add_request(&policy->constraints, &cpudata->max_freq_req,
 				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
 	if (ret < 0) {
 		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
-		goto free_cpudata2;
+		goto free_cpudata;
 	}
 
 	cpudata->max_limit_freq = max_freq;
@@ -1012,9 +1012,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	return 0;
 
-free_cpudata2:
-	freq_qos_remove_request(&cpudata->req[0]);
-free_cpudata1:
+free_cpudata:
 	kfree(cpudata);
 	return ret;
 }
@@ -1023,8 +1021,7 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
-	freq_qos_remove_request(&cpudata->req[1]);
-	freq_qos_remove_request(&cpudata->req[0]);
+	freq_qos_remove_request(&cpudata->max_freq_req);
 	policy->fast_switch_possible = false;
 	kfree(cpudata);
 }
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cd573bc6b6db..643e2a71827d 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -28,7 +28,7 @@ struct amd_aperf_mperf {
 /**
  * struct amd_cpudata - private CPU data for AMD P-State
  * @cpu: CPU number
- * @req: constraint request to apply
+ * @max_freq_req: maximum frequency constraint request to apply
  * @cppc_req_cached: cached performance request hints
  * @highest_perf: the maximum performance an individual processor may reach,
  *		  assuming ideal conditions
@@ -68,7 +68,7 @@ struct amd_aperf_mperf {
 struct amd_cpudata {
 	int	cpu;
 
-	struct	freq_qos_request req[2];
+	struct	freq_qos_request max_freq_req;
 	u64	cppc_req_cached;
 
 	u32	highest_perf;
-- 
2.34.1


