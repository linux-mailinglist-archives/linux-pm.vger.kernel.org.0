Return-Path: <linux-pm+bounces-18658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B131A9E609E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 23:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384AA18844E4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26644210196;
	Thu,  5 Dec 2024 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GeKdqR85"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17A1E0090;
	Thu,  5 Dec 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437759; cv=fail; b=ZHddiLW8a1fTOoKPSrC3tMqvCM037kB3mHAlv7gbrEtWapMNxJLk2qB4NOpdP2LiAu/oxkrMtiNOuRaoqZ77k4Hes/lgR/DJZKmiSni5sLcSyUMYma9/x6Djdmv7F0i6KgYJDfsFvPo110w3eynCFh3HH3AdVcS53gcGPbflwR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437759; c=relaxed/simple;
	bh=ejKTT11QWN4h66aCEp7BHVUzu6WJrWW0cxYAohKcWl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awJIv8UTvo7I4u+0ai/zWxvg2/gBZHwjr2fWZ5q7StnzPgcAFnkS39xxV8ULqWURAYcVymAiADz9dCSSt1SmxW9gh1utywhSiHeSskyUuNKiFNdCTnKa2Fy5SLlifziMRYb1ryU60LiLBbXs4PfYRQapTAZJ8nsT1bL0VXvcHSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GeKdqR85; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dn+RbSNbx6pHH6Rmcr7yv24AlgdfhUo8Gw1ND/WM8P1+kIgyZPARktznltv3YtRi85RPqn77Aa1KoUa0WfB+NlYORrwBUNq/R9mRhmC2/hKCi1cJWxVNQ9k/KmfB4hfhZGvmHjsxFJ8Ep5WUFeQ5fSkbIzNzV9J4cqaOqFrJS3zu2SeBZnMZbJPew8DBFzW4wN82VpNWGhDSuyK+8rSmwzPF6kivZPFPGJ9rxiFhegLvwc3DDdTwv49Qg/qmy8znRPFmR9JACbUrMUTkq/b3+1aSPe4AG3mfdYeTsXRU18eF9nCBqibyVOE/TQkw0utoO7I1TSncwphfqhOrvOY7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCgyY4h0FU1RhF552G14VAfkfhqeyBKcbA/DP5aAFM0=;
 b=uoMVgzqPDfNzpNT2WjZ5175XbHG+I5/3utczI4QyYnkFWnhy1XvShj7XL2T8B/HRVMhONZKmUhdUufapfmVmxrDXwF3vYnkgBqpLMRUNKvDiADpDEdh00RP+aQPbYe0p71Wu+6Ggpqk99zuhkxb+gmMRRHDuDdLWLeTzf+wPGYO4q/w4ejmV0vOMrwAO6ydgukH8BuxeePUDaLIMh1oV/4IUZjWHl5cI1Feu8Q/UE53QhLMRCl0Xuif13hKEYfOqRRPVa/m3qcy+CLKBNIhze8fXZR65HcrSXBJW2bsQk53Qd5dqwqTdCfrh4GNZbe/fWTWgdagFbNRiU20iZWnT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCgyY4h0FU1RhF552G14VAfkfhqeyBKcbA/DP5aAFM0=;
 b=GeKdqR85pFeB7NImiRLr2N59Ug2RZy6+sKA2xeowu48ZTecM3POaaQ7tLAGa88mbJRPabdFS660vZNm7zkkZoIIE+esjrEoXvQ03ZJRXgax2zijzXa1xi37pO9sYAKf4Nl873yxnFw9u+jiSh1C0wfRs9kTo2oL75GSeVytQy18=
Received: from CH0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:610:e7::33)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 22:29:11 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::8d) by CH0PR03CA0238.outlook.office365.com
 (2603:10b6:610:e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 22:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 22:29:11 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 16:29:05 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 10/15] cpufreq/amd-pstate: Move limit updating code
Date: Thu, 5 Dec 2024 16:28:42 -0600
Message-ID: <20241205222847.7889-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d17384-2514-454a-2e3e-08dd157c3dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/JNMOvctAnWEPC0K7E8zVPi1u9t3wn/iq3zfKwrq7/iOCT15ZNPzjNG9k1p2?=
 =?us-ascii?Q?PtTcJRXBPzLcwlx/00Ktk/yXGQMyBjsCUQEPaBG3ARIrrgH2ROkFRdLPz9ES?=
 =?us-ascii?Q?C1cPW/cr3ZcAImT/dw1MozHGskZGD03Cvt0cfbqovNM/mEwx/+o9qHVWd0PP?=
 =?us-ascii?Q?+ibeb2seTGuDXthZbVSePyVRPpjYh3r4dn5uTeB476Qnbqe/7Gl9X9NTwZfD?=
 =?us-ascii?Q?SA0TmqHJocP2YRVtO09OlLsn1riET9y5SgpRTwqXak/bugOAGBYmM47pcNB8?=
 =?us-ascii?Q?NAJh0w5+/Eq+CSm9URhEwndHoIYnkUbDoB7ZjOveQP8RvoO0u/e4W6vGd+O7?=
 =?us-ascii?Q?IN/2c0B/jCU4SGXL0v8SOML6LZTK/5knHROUlntRP4i6MMxBpXGt7TOYtRWU?=
 =?us-ascii?Q?oMHYoI96b1koabXw+5T0iqrKYnlHeNFjimYPoxNocaygM9gngVHyKcPY8bI8?=
 =?us-ascii?Q?dNwPZxrefCXmRtYTGGrQ9n6v8++grJo40Sb+8JQS8vrVvRbokEchFS7zwpsP?=
 =?us-ascii?Q?cDvQGIJVqeIiN2tCMY3FcmF13bKsgsFsegtywOL4+IeRrhb8NS47JFxRtMib?=
 =?us-ascii?Q?klfHAIkp3w09f6YLM7cMeIWb44ukgYHuvwUVWyxRY/ShrYZRFZqKJIUJWxBe?=
 =?us-ascii?Q?u7eAYLq/odNQ2JIAjb7kFL27+ZcC9i0EnoorkGBvD/J6l5nR7XdChupNgE2J?=
 =?us-ascii?Q?aANbiLJsgTpwvzQMXyCMWs09oPYyF6bDgG6aGPu8+VF1T3azvp46+dycmpdI?=
 =?us-ascii?Q?yuDhh4aSydF3lj2B/DekpQkOM0JwmkAcJbttbnzeUXE5bCJJEutt0mICiXCY?=
 =?us-ascii?Q?HyEh5d//7WWiJNaVCsazIzdmeyUD21y7kBxZj9dPfac5mDez9MSXpS908JOz?=
 =?us-ascii?Q?P29i+Yl9I2QlFUVsNrC52kIbuAqRsj3sBkWStDT+dRX3YZkEf7NQKkdMzAde?=
 =?us-ascii?Q?gyKPfnl3jD3yO8WVbGmSZZF2PqNPvhu+FimYz5rsHx+CRLhStReP5AJ1M5NX?=
 =?us-ascii?Q?6EMQjpxLuV1kqR26dKGHx1W3PeDtOzungw0Ydopxa6kGam47j/AeHum7ZVDW?=
 =?us-ascii?Q?uxnkgSNRIZC0Ae7Cn3eWgKVYWS187gJf/dZrBBTqqYFpmQCSA18dPGfJ31Aj?=
 =?us-ascii?Q?Xzy2lazwI62v5C9jeNFwdMvuwVdekUcx1nUqpK37t3oAJgVcVelR+54SQVnb?=
 =?us-ascii?Q?ZcFJszjctgFHHXgGUrbT53puJ39bIRh9YicHee8GAB7oNW0K92IxTElSpGhp?=
 =?us-ascii?Q?aTvhRIkmnOeveY2wgx/B7gGhjworPBgbKdmN05jsGyMuZm11A4gw6x/ikZEu?=
 =?us-ascii?Q?kOqoWg4PNHgG0IyONbkQ5Dhw62aaUcBkxh9PEExIvNJMjUNTYJBxsvAGixqi?=
 =?us-ascii?Q?bKhLRf49EJLpaMCv1LYG4vB5gWsrar+Ldgf/I2YyEjAseusdalAEmRRdsdvD?=
 =?us-ascii?Q?DbWO7JLfwaRD6e6DIfzgbKi33bgXzajv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:29:11.2026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d17384-2514-454a-2e3e-08dd157c3dc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

The limit updating code in amd_pstate_epp_update_limit() should not
only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
so other callers can benefit as well.

With this move it's not necessary to have clamp_t calls anymore because
the verify callback is called when setting limits.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 842e7e3c5eaf2..5ee53b45c1ca1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
-	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
-	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
 	max_freq = READ_ONCE(cpudata->max_limit_freq);
@@ -616,11 +612,9 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
 
 	lowest_perf = READ_ONCE(cpudata->lowest_perf);
-	if (min_limit_perf < lowest_perf)
-		min_limit_perf = lowest_perf;
 
-	if (max_limit_perf < min_limit_perf)
-		max_limit_perf = min_limit_perf;
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
 
 	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
 	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
@@ -1562,28 +1556,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 max_perf, min_perf;
 	u64 value;
 	s16 epp;
 
-	max_perf = READ_ONCE(cpudata->highest_perf);
-	min_perf = READ_ONCE(cpudata->lowest_perf);
 	amd_pstate_update_min_max_limit(policy);
 
-	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
-	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
-			cpudata->max_limit_perf);
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
-		min_perf = min(cpudata->nominal_perf, max_perf);
-
 	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
 		   AMD_PSTATE_DES_PERF_MASK);
-	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, max_perf);
+	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, cpudata->max_limit_perf);
 	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, 0);
-	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, min_perf);
+	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, cpudata->min_limit_perf);
 
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
-- 
2.43.0


