Return-Path: <linux-pm+bounces-18756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675F09E83FB
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295D416329C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3051552E7;
	Sun,  8 Dec 2024 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U7cAFKaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133414F9ED;
	Sun,  8 Dec 2024 06:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639470; cv=fail; b=Ig81mdWTWILi7VAZSktv0ng6VtdReMlj7M507J9NftEhwaLcDtDzUGdlWwfB2S04+ZY7I0YsyhbmKtY5rrDBuBsRmXaEETHJCZmYIs3PdH4y0YuAvd95bYokMVaqbB+QX2gxG3Qznldi3Mem39O14FoW3ndqbvrYxuIq0FnNPh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639470; c=relaxed/simple;
	bh=w1yI5QkgpQrkmWxndiGo71mmwJD5DXNgj8Ik+AytcIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdyxUGwaF31v9HmLtypuDxbW+MXouH2tGfaZtXSZzvF0WyAdy7R2n+XdpYXoj2JIdC8+Ayt1KUI8DxIhNG6pDj4s5KWY4aHbqq6MpD7+eq3Icqo6c9yfG3Ue24kCGsjYOdQJeVyeJX1DfS1jrXJxvZNCictCIRk3sHTWZLFAnSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U7cAFKaQ; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InybHUWTAmm9K3spMJbBzFTkTkf8Cza8N9DnjONxZORNDax/ez6DCX+qXSzaUKdYoFShFz6WUzaLNH05LEoGGA3WZkZ6D20ay21VCatIPTSF3tu97oAsR4hESmSCk3wgYZ9fxKDdNHtUCmL+p0gd0yHP21L6HRZLj57+OJgfZ+cyC6aTh8hknnjwez8KoXkVAZrK2rpmArrrJTe2D8sChNOIx4/F48bcY9qHQZAWXcBL9+KGnqmKuUU+FDTOtRq1NPyBEofMYeSQnusgP21SycWwHO2YEGWRfxc0HG5vhAHz4Ulo+IGYt6y0Fz2yoQve9axnbFhkvCiljwXkufTSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sscEtimuOUJemviRepZcMyYZsAU2LYLD1Lv9VJgc07c=;
 b=HdWJ2+JE74CRF2IeAdWEgNj36ybRmsHB3QbOILQ/LurjDZDrR7EMuZwMdHk/kWkiVLqXtcLN2luX+ZKlRQZSbnOy9xb+OcGKCPNdCWdMWdKt9G435ro+6+aIprQhUwEmGBK8HaERD0zd0GaET8QnzZlEc5wkUp0cgd+sY+CmWyD63v3PWWENGOqgqS0ohs3CsazphitbgDKnU9ZT0wdWtzaTtVtY4kRe2+/trrzz2faCWDc5Pmv2XFMBvgtc8mOJNBvx694YUMk8exBXkM3Tn4EcoxAu+w475Ci9U8S8cCfftU+VEIWS62S9IqrY0JOfKHIkGrEq1rasRX8qM0acnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sscEtimuOUJemviRepZcMyYZsAU2LYLD1Lv9VJgc07c=;
 b=U7cAFKaQbKIeADoFp3MmMXWbc7X2FJUjTUz6WnnsMl4cSc+GLYRcr9Zz4n3JHVPR83EIR3XKGjS7w8Dy96/7jWuiP7ob91PFlq6Lmwd8as0cRrgl3jkjsw8/tzq9Fuz2vxqcZCZuEXZOVjf2TIySnBmubNir/q16IjpIfDBX5A8=
Received: from DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::14) by
 CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Sun, 8 Dec
 2024 06:31:02 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::a2) by DS7P220CA0007.outlook.office365.com
 (2603:10b6:8:1ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:31:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:58 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Dhananjay Ugwekar
	<dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 12/16] cpufreq/amd-pstate: Always write EPP value when updating perf
Date: Sun, 8 Dec 2024 00:30:27 -0600
Message-ID: <20241208063031.3113-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: d894fe7c-517c-4b5b-030e-08dd1751e2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXSHmkYCAKZazVIuhPAy15cPvF1OQ8k9lpFk+/yc3hZz968v+U0qjC5EeoYQ?=
 =?us-ascii?Q?Vm53rIFKRJuCglCC+dPP8J1mcwDX/NIJmCl75yBT8amEgLS7+zZ1V6t0i9RT?=
 =?us-ascii?Q?ABzGohOGwDI0ZmF5B62PfCuTBSSJ0LD8zXNcjEKs7U6WeNXmWj9RDXY1lTpX?=
 =?us-ascii?Q?6VnU37iTLpS5/1NPiAaTz2xaiIsCKhbN2odnhkAnxTpWAo/SmpgQhDmsZ3g3?=
 =?us-ascii?Q?jxtl+jFII5+CF2YUti6Tc0/n8j3hvY3i9uebqEyabeUMzHY5cVmJ0vTOlOQP?=
 =?us-ascii?Q?LCSiA3+4zguXCSB23ZRoorYgqdo6BurE1xbdiMmY/j8xs7R3ke2Lgleg/xTL?=
 =?us-ascii?Q?LR7b7VPLLyQ33+yiSvPmyTBqUCWL9tfyiLZQcS5R94Y2KZupz6TFc1nb/2Rm?=
 =?us-ascii?Q?87ea+6ekrbdVPAQWMyMBgmNiiEEbH3sJUm8bDwSumLukuOIxCi8sgLfuIQ3X?=
 =?us-ascii?Q?ZQNOhM1OU8Cr+DjmLHS1EYZDJ26v4HBOzFni4MUOFhFDrSTwG+lKyg1y/3XK?=
 =?us-ascii?Q?U/09dDvcjE/iju0IAFH627R6T0tkMJJ6qvIMUY0CsHLsQ37wAbOtjuPlbCKv?=
 =?us-ascii?Q?RSZ28LEyWT8WL8llEBu8tnwP5lGagX0skhzQsE2hj23BtA28VWZKbjAqOBhv?=
 =?us-ascii?Q?DrIdT8WnQO7ix5aBAOy8vgz5/RuY1YyZ1DTYjWx2+Qmw2dwvD41hRaGLBklW?=
 =?us-ascii?Q?PtAUnOFM3a0/tV8xw+T2p4JSJ10ZGHbYla/qmRpf7AM35ByL7aOi9BGLIDET?=
 =?us-ascii?Q?miMwOzdrC7LvR7Wl88XfprmZoKuidSvIa1ruCc0WdTADFE5P4Pd3J8UY2wHk?=
 =?us-ascii?Q?BmMsXRFLOtZoVJQArqimKZK4d6xIEQsoafgzGCT86KFAOZBJEW+8YQ38c/25?=
 =?us-ascii?Q?W61ald17Np+KqCLqn9cQQjnQo3+eKxkMbassiqR5Ov8axQvxFwS3YL5bbbqM?=
 =?us-ascii?Q?RMGef7ECBTPXBjxCcZqe0sZIL/a1PX7mS2yilkPc3gG3d58L6JNVuSBflNZX?=
 =?us-ascii?Q?KNYPmJT3dBI+lOrfPRxK+brtERALGOsXqgoGBU/0sFbhNpGfRAzrclLUXmrh?=
 =?us-ascii?Q?ovan2ZOk578ssk0b6+iK/uydvZMdq4PlIBR8uGpBrOsCaO396bJRZeRuYAkM?=
 =?us-ascii?Q?VleZQFuQK4yg2yldfVB2SOaMrO+dBUQzI5QeA9TB9n8iv5C5AJb8nDkfL8ai?=
 =?us-ascii?Q?kgJaiS2M44Cp8VNL/KPPumTD6JW0eV+y+Mozmzxv7/txOb5IEHXFMn4JYWgi?=
 =?us-ascii?Q?+HV1/ed4Yv448h5hl/AFvs/0T2IdhQ07MTmf917HV4MQ/BUG61NTGRcPfXfT?=
 =?us-ascii?Q?2UE5dhawaowTdHLmVHa91pxu5t4NMR0wI9Bpncc2rq2f1eyB3FAzMKt1DvU7?=
 =?us-ascii?Q?5V1i4Wu8doP4haJYT84jVafpgNaMJ+PvNhM/FIuN+sUmO6dJl6/OrXwxQO/1?=
 =?us-ascii?Q?MP2cP6mmpJ1nslhs4slbPUtJSFtU3+c/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:31:01.7170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d894fe7c-517c-4b5b-030e-08dd1751e2a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

For MSR systems the EPP value is in the same register as perf targets
and so divding them into two separate MSR writes is wasteful.

In msr_update_perf(), update both EPP and perf values in one write to
MSR_AMD_CPPC_REQ, and cache them if successful.

To accomplish this plumb the EPP value into the update_perf call and modify
all its callers to check the return value.

Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 71 ++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d21acd961edcd..dd11ba6c00cc3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -222,25 +222,36 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 }
 
 static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			       u32 des_perf, u32 max_perf, bool fast_switch)
+			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
 {
+	u64 value;
+
+	value = READ_ONCE(cpudata->cppc_req_cached);
 	if (fast_switch) {
 		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
 		return 0;
+	} else {
+		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+					READ_ONCE(cpudata->cppc_req_cached));
+		if (ret)
+			return ret;
 	}
 
-	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
-			     READ_ONCE(cpudata->cppc_req_cached));
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+	WRITE_ONCE(cpudata->epp_cached, epp);
+
+	return 0;
 }
 
 DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
 static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
 					  u32 min_perf, u32 des_perf,
-					  u32 max_perf, bool fast_switch)
+					  u32 max_perf, u32 epp,
+					  bool fast_switch)
 {
 	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
-						   max_perf, fast_switch);
+						   max_perf, epp, fast_switch);
 }
 
 static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
@@ -459,12 +470,19 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static int shmem_update_perf(struct amd_cpudata *cpudata,
-			     u32 min_perf, u32 des_perf,
-			     u32 max_perf, bool fast_switch)
+static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
+			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
 {
 	struct cppc_perf_ctrls perf_ctrls;
 
+	if (cppc_state == AMD_PSTATE_ACTIVE) {
+		int ret = shmem_set_epp(cpudata, epp);
+
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->epp_cached, epp);
+	}
+
 	perf_ctrls.max_perf = max_perf;
 	perf_ctrls.min_perf = min_perf;
 	perf_ctrls.desired_perf = des_perf;
@@ -545,10 +563,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 
-	amd_pstate_update_perf(cpudata, min_perf, des_perf,
-			       max_perf, fast_switch);
+	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
 
 cpufreq_policy_put:
+
 	cpufreq_cpu_put(policy);
 }
 
@@ -1545,6 +1563,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u64 value;
+	u32 epp;
 
 	amd_pstate_update_min_max_limit(policy);
 
@@ -1557,23 +1576,19 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		WRITE_ONCE(cpudata->epp_cached, 0);
-	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, cpudata->epp_cached);
-
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
+		epp = 0;
+	else
+		epp = READ_ONCE(cpudata->epp_cached);
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
-		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
-					  cpudata->epp_cached,
+		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
 					  cpudata->min_limit_perf,
 					  cpudata->max_limit_perf,
 					  policy->boost_enabled);
 	}
 
-	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
-			       cpudata->max_limit_perf, false);
-
-	return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
+	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
+				      cpudata->max_limit_perf, epp, false);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1602,7 +1617,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
+static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 {
 	u64 max_perf;
 	int ret;
@@ -1620,17 +1635,19 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 					  max_perf, cpudata->boost_state);
 	}
 
-	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
-	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
+	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
 }
 
 static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
 
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
-	amd_pstate_epp_reenable(cpudata);
+	ret = amd_pstate_epp_reenable(cpudata);
+	if (ret)
+		return ret;
 	cpudata->suspended = false;
 
 	return 0;
@@ -1654,10 +1671,8 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 					  min_perf, min_perf, policy->boost_enabled);
 	}
 
-	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
-	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
-
-	return 0;
+	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
+				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
 }
 
 static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
-- 
2.43.0


