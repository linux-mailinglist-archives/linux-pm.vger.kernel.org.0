Return-Path: <linux-pm+bounces-15576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA4299B670
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 19:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D758BB2214C
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418984A50;
	Sat, 12 Oct 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PeEx+el4"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286F1B969;
	Sat, 12 Oct 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755158; cv=fail; b=hYtpqUOu7y+UX+mhNjNuPAxK7v4wF9pC9GNFtpl8PXd3Bqd2LtS5xUzf3fcvy5TzOe4u5nptUYU03ul/cjf3GBFy3PgTsycbsbduhIT10XlFstSPwKFYmBDOJOnlhjn028XhD2TOiDoErsW9aqLbleSjb17r5q6f5YLMrDLyzmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755158; c=relaxed/simple;
	bh=/rQKjGb3gfjDEWfDCFCw3t+9kxdaxazhPcQ/vgoiItU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/Kwrz/V3+Z6q+OM76r9FBrWAn51TeisE+6dpEo3KXYsDeJ9Kwm9dMTnQfW29K0hjgiJTyUR5qdLMMjM3WwvTvVSCL3Ev+pY5viEiHSt1PoAMdTqq7qSQGh0OcL+EssDmrOsT2K23y33+2IU886lD/s0Lcz0JunQni+2D/20sgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PeEx+el4; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7/KMNu4uJzkzmf80fhNnKS2yZlUiQ0X3qHJuxMCIFdGey8sSW6T6ndiCfShNUSjFCuXLONsLiXu/GUfDFBkaTJr+SoQCORNnaSKnzaaeGq0pcHMUb/wINSRtUshjylXLvmetAfdIIfW4cDJc/RvCeGQfjMLWuAXeionJmkPmusMz1lDtLw/Yp4tqvPyB1BzSnr8XvPz0/Tr6RMaeWKXklvs0MgO9sEvQZ2cdeWPXLuraLKvGizQiLFihevLn90jXEn7GdUrrK1uMfoHAJcErkiI5ws/CitYWiim/MzP8yitfqGBuitRHXd3wJj6erWr4DR2RSnv1iH+5yr2N3mQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc4Fjdbllc8QQ2qfQV/5WR4ypUsKxafQbgOWjGqFgUs=;
 b=Ht0KKaV23DZDdpE3cu6YVpEmii7YwRfeFsKubd0iaQSIsGiostB4FddM5Sh1Sb7HO47Ien178LrmykGbKdcB3N948BIg8+jwdl7eu3iwQCWHAxvP4qUej5iaCw5KLFsrwFi6Fy2FxolZywb/jVU4mzoF9ossBL1CsKZ4PJ/XcgYUkR/cfc025D1wbv8rKDCMjy8ZVd/xS4r99rpYEGu632Bq/BnFDnH1Spqe9qWM2zAObfxedgzHN09upA1SC3aanAwjZa7XN/ebrgzbNtAioCi9I6z92h0u7r+vQ2/QItcG9tHD5eO2NvmgvFuQsgMDDfcaMqxVr8Bwmz66tXPstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc4Fjdbllc8QQ2qfQV/5WR4ypUsKxafQbgOWjGqFgUs=;
 b=PeEx+el4/Tnxy9JOaYRE4B5o7oZKP3XMXPbd/sypcjr9qyRj3EHr0Z3RlKrq2eYfonDHpwhY1+CgFO/V2V58hoICXjyJVepHPFOaHI8DWq6FEyj9IdOXhwgWa8DKDe+fa2eZA6cejM0njwDWPsJAYLAXLKszaKoNz6B+n6tuKkk=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 17:45:53 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::7d) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22 via Frontend
 Transport; Sat, 12 Oct 2024 17:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Sat, 12 Oct 2024 17:45:53 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 12 Oct
 2024 12:45:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/4] cpufreq/amd-pstate: Don't update CPPC request in amd_pstate_cpu_boost_update()
Date: Sat, 12 Oct 2024 12:45:17 -0500
Message-ID: <20241012174519.897-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012174519.897-1-mario.limonciello@amd.com>
References: <20241012174519.897-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1f1886-6527-483a-1e54-08dceae5b7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BVeawdgu4134W11VHuZ158EevXy4QkT+rilQydvOvPcHbPFXqQMz7pLiSmyM?=
 =?us-ascii?Q?+pOaBA4CBnfNxkjeW0HngxarVsF0uc7BIipRPnRYlfdVmArGv+BJHUYrDbhv?=
 =?us-ascii?Q?luuyRTCe0c7KQkOrXlcrS+vDKGrJJTcQCaqyqER/wKAYxxB89doAS3XeANHM?=
 =?us-ascii?Q?VZWgJGAM//mlFp/kJXTTrXJAB9KhP9Z4oFTm9zoHSStQWNaJuplxT2z2PAKH?=
 =?us-ascii?Q?H/fk390GZrpzSfYUNs+e8zfnOOO0m9v4GnxJwhBictaBl+8FXaS957T4Bjkx?=
 =?us-ascii?Q?Xoc9OCwAmjkWyXGzMak3/iTYX8GWRod5NdOpBIB9tHNZa94UPvP2sqbq7zCx?=
 =?us-ascii?Q?NwId4ZrFZQudjjLDohCJyWQS+luV+hdAi9o1HYZgr9GpA6kZU3EA5ih+Mq/t?=
 =?us-ascii?Q?lyf5HkuT+BhjdQt1QmFu/p1hQGSeNiMv4KQuH96I0aKV1szkfcnL1rbwZ2sW?=
 =?us-ascii?Q?JRrrgwKPHvivPcI6bNSYQlX3tlds44xprRInHnBhhFzcMLzK+XJUpMtRc6qK?=
 =?us-ascii?Q?nEJec+LjltsZZuiMwiBxQFbT2ytqeNEU5iJdUP1rc7SL65SA8IBccYdVvDOR?=
 =?us-ascii?Q?iEn7MyXZtSxwIYU5QB5mttQAInyp6eKSwXMva7q/TxuaDU7wymUJjSlmJP6B?=
 =?us-ascii?Q?0fyC+AS43bxCKVQHw+txJWMmxntpLkEItX3H6EJyzgGGiTPXGzOjeE+VKmON?=
 =?us-ascii?Q?Qpl1x4wes7YZjPU0vEI3CiKXRl1li/1Pl32U8ww9fe6VEibbG7ubFwyzyNba?=
 =?us-ascii?Q?lofDoxcrng6v9mweCkjoeMrHcSz03681+oLmlABdQOnDKziHHUNVNH4GDLYb?=
 =?us-ascii?Q?/hYfpweitlgXBBP3Tn5z5SM7R5k2Ax9nXVP788kaR7GjyFwnlTo2gHTn0ynH?=
 =?us-ascii?Q?a/RGKDsKU5CblosnudOkNpPuUuPRVa5lJquThDK/EzahI/v7YPDRcyBic0u5?=
 =?us-ascii?Q?2ii7dE5lp2ffh7L+tZIFfVOzkM1o6ECOteAM5G11608MiAV+FFUjy1D5B7L3?=
 =?us-ascii?Q?KH52Wnp6YsxUUO13MB+UvdSpsdLwPinfBr1iRve3couLHn0SFmGsy7A7Zjqn?=
 =?us-ascii?Q?8q48g38Z3vEjm56o6E3Tw1ryt7NoGbDTotuUBgIqedBPWvw0y9DW+0qfgGbw?=
 =?us-ascii?Q?b2jcodc82o/5Vv25eZd1VbrA6wuhmENrRXlPQVBVSmxR8ibVFqX/PkOvdThm?=
 =?us-ascii?Q?jC6wNcexAMbab0DNuyZYtfPDV5FNH2XRTiOOAhYQfr3VJpVewqMps4aZv2ES?=
 =?us-ascii?Q?k1xdmTM1lCyQ6dHeoNdMYRXEbXWSLxmkWnha/enuMCOIBU8FnWIT4sIk3WIQ?=
 =?us-ascii?Q?IttZ4KuA/JwDuOWXopC3Rcrzq56MkIn41HJCX9B/5gtaVFPvWiX5xuC4Mcug?=
 =?us-ascii?Q?xDbxarzDvT/ALfPNAZm5bqWIe7gc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 17:45:53.0289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1f1886-6527-483a-1e54-08dceae5b7cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324

When boost is changed the CPPC value is changed in amd_pstate_cpu_boost_update()
but then changed again when refresh_frequency_limits() and all it's callbacks
occur.  The first is a pointless write, so instead just update the limits for
the policy and let the policy refresh anchor everything properly.

Fixes: c8c68c38b56f ("cpufreq: amd-pstate: initialize core precision boost state")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index dfa9a146769b..13dec8b1e7a8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -665,34 +665,12 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	struct cppc_perf_ctrls perf_ctrls;
-	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
+	u32 nominal_freq, max_freq;
 	int ret = 0;
 
-	highest_perf = READ_ONCE(cpudata->highest_perf);
-	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
-		u64 value = READ_ONCE(cpudata->cppc_req_cached);
-
-		value &= ~GENMASK_ULL(7, 0);
-		value |= on ? highest_perf : nominal_perf;
-		WRITE_ONCE(cpudata->cppc_req_cached, value);
-
-		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
-	} else {
-		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
-		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
-		if (ret) {
-			cpufreq_cpu_release(policy);
-			pr_debug("Failed to set max perf on CPU:%d. ret:%d\n",
-				cpudata->cpu, ret);
-			return ret;
-		}
-	}
-
 	if (on)
 		policy->cpuinfo.max_freq = max_freq;
 	else if (policy->cpuinfo.max_freq > nominal_freq * 1000)
-- 
2.43.0


