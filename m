Return-Path: <linux-pm+bounces-18751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D29E83F1
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 07:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D599163062
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 06:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837B148316;
	Sun,  8 Dec 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="orwbi/MW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E7145FEB;
	Sun,  8 Dec 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639465; cv=fail; b=SXv/aO2vUsA2aJ9ul6UxRBtH0kViBHdzCAmc52CQHQZLlqweMCTLWQtFVGFhM+uIx8mPDJhLeb5FZ5zD5UsMaqfTXvPcSkV8GFFgwJ3iG/rORM2XQweZdFMZdFc8/wsyhKC6TWLWaG8RihZDupj26aeZrY5/yioefTMWor4VNVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639465; c=relaxed/simple;
	bh=6MTHRL5MHUSp36pwBet7p28UW/1GIbDwH06pyPCfy2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGY1P0kv+w4wvWO9gUKgv8DRGf/uSQbfM6pKos+7iE2GVamP2IxaTBwiL7x0BEm7T3M2/GWypppGwzo+5IfXUInTwoMPgepGzKtKZBmaWeSCuNYrxKYLb5Us6nxaFlHbPVlJ992kgW9jmIHFToKhNNL+yzdxRwaiu6zqlKGoJdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=orwbi/MW; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orjMCa2o4IrM8ziN+W8/pOsCTn8pbiQEO5dEXwyBx/t5OA0FNZX6nZQ3que9MKGNl7JA6TwQym173iu/0qZ2H6Eby5i+b0/H0+XScGrE2D0tx2x5O4bvPhv+zGglPDR3jLGKEJe/Gx8yk5tvsQfxpMnK3zKucqYLcY8gCTPRIs1LwmDdn+uZC7vLvSD+wRf9pTHveKdUuEKCOESe2QqkDAba1zAWw4saWq+TPlCnNbQEhNZot5uYB7j6J7NQbQFZht0PG9x8T9IbG256esm8tTQG0FlOg1Eo1tegmOg4mFwNLxtk3Gk01HNlUEdzKst1CPMhlqA6HwBSK+x958+OHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saJk+iuS5VELA3XAGJetWjnvUPeLQzFGvShlQkEJD4k=;
 b=VtGjtr1ynVbgq+2J0BIbX0wzX2Q3LgGMxs4PfXb/a6BilThawpPy6ulk3hsPxApCiMUdxGgcplB16U+Zxwj8f+AIuY73KLOISCLPvgEkm51BN+N3mQArocE+WuBAUaKu6GI6k2uruHVfPVcis8cbrgIpnogXkntOUXON2iL2fF60hZplk2Ifxc3L+WOGZd5ZOL0fTpRNumub5Z2w4+6oPSPI/U6xvewCWPqsNXO7WBnuAn3m3oQUogZP8GGP4w5dLNEBZMmSVbJGAALlP5NRphxk4JqGPrhoktZlUgCDlC5xFPQWPyaIKlj7hQMMRc/SOP5HxwZ65YoXtvs30NlawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saJk+iuS5VELA3XAGJetWjnvUPeLQzFGvShlQkEJD4k=;
 b=orwbi/MWzVa+rX1Z8LZr+OsfVDrA4cNrUJjF2QwaMzJVtPIzLfRSkD2bgzMGl2oTnCrdD2gCQVe8dxCJ82ptq98DYIhEc0xSv25sypRucWDg6ihwKskPvGPIepSP2WA+DsF/RwfqyaAaOjSr9cFJOm4iw9WC3wJflID+xSNeFrI=
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Sun, 8 Dec
 2024 06:30:56 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::22) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Sun,
 8 Dec 2024 06:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 06:30:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Dec
 2024 00:30:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 05/16] cpufreq/amd-pstate: Drop cached epp_policy variable
Date: Sun, 8 Dec 2024 00:30:20 -0600
Message-ID: <20241208063031.3113-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: ab363126-cdff-455a-a485-08dd1751def9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQAzv7bXDYluqLL7FmXIsDuWvXfRiWe4ZYakwffNlCiGDq+vN4tRf+vIapWs?=
 =?us-ascii?Q?dfoz9nLs31X3SdLElAPy1WwJwTUrBarGteq3cm5IMGDm0T4exPAtQHG1qSw5?=
 =?us-ascii?Q?grzFePyFnRKuCpn9rMGr8ri9ydzlgAvuQLWHvPdixMrAmHe73/fVg+8tFaqY?=
 =?us-ascii?Q?Phy5yVOETZs8HytxTbt0c/ZoxMUtkrNdHUR524Lgr2D262EB71hnwwrTBwHm?=
 =?us-ascii?Q?0ONyvM1FNbfiLW75uhTZDpFKvS/ifkZpPdUmKs03UIXSHs6S1Tqqcp6SgXJf?=
 =?us-ascii?Q?Sj4t0guXY6DqaNK/XzhSoLmYy9QhV0XFj+rlLgr7eLG5zUY54BoeDJ/u6TDN?=
 =?us-ascii?Q?tR7x8qQKVu4PQCjRL6D86+Rt5EbsnkDNiRj0mLUKi+Bh5fCLw7Y5lExnRiCk?=
 =?us-ascii?Q?Xm9BroVq05FL2SMjSGRh3z7/4q7amf+lFCvOLkLwfeisMVryTuAdqw4wwTgY?=
 =?us-ascii?Q?1kYTuxyRS7dSaQkpyx6AeLNZi8yfjlt9y30zUQosIWSeEp7j1Bz/X/ooQu/x?=
 =?us-ascii?Q?JLKE2hQj/2QWYS0v30Ph8HVZ4DESSxv2NsQEVHMOZB+BukAQxGXOhDTVT4ek?=
 =?us-ascii?Q?YO/0VDr2SaJMkMSBjzTfjbTpaW1XzBdJETf27oMURf7JvdVPFqDoxUYLUQJq?=
 =?us-ascii?Q?gy/owiPQHoo74slDgN0L0v2J/3xWC5e3VawCp0Go23Eb/gnlv99UOrDAAXwD?=
 =?us-ascii?Q?EEsHPunj7q1+7SszP4dKd6QesjasRsbg2PdFXknKG3qTXCiD+BUB7VJQ1Fn8?=
 =?us-ascii?Q?nIwhn2XZhmUDEIjMzOa24ldeIII+tTh914xVFlRCLYVKK8QyPh7Vov5TeIoc?=
 =?us-ascii?Q?CjzoBHjdvTxGLMp7t6lSZmHP9w8lBcdCrQNrZ5ONky/qVpJuhx+sZG4u287y?=
 =?us-ascii?Q?Ihwj10alU2qKBbRm/agPxBP6YhWy2+6Bm58WXtnPhNr+vL1qLOOkZnz0wkiw?=
 =?us-ascii?Q?dH9ISn3np/4XNoOjpmMNoF9TfMIkZKUcymeIzuvt03bNs04s+AkbQAeYCgJ4?=
 =?us-ascii?Q?tUULtAFEgZnfG8zOaMMR3v9enLXE9qGhtzGepSJvLipvqZr+m0c/5r0gsMRa?=
 =?us-ascii?Q?3Nl/RsRsypnq3kcpKKRbBn93pXeEZaSb63lOjCatWwTBoP6V3UkDt91YWwFn?=
 =?us-ascii?Q?REHCOaVg/ZbWldEFr1V0eVvu8llVhoHV1XlGQbLTT/i1o9r/CAsLbuaeO26g?=
 =?us-ascii?Q?EQBpH14PbHmELTAfFbukofQJ+wTCxyQyklABVpCY6i28V6GSeh5LWXkj1rXk?=
 =?us-ascii?Q?tohu+j9oi4+iIcdiSy8KyG7pRXdTYIHa556lDoUHCnRZ9wIOiWbPe4IzWr/M?=
 =?us-ascii?Q?1jKWAL/FF/+aUPBQlJr4pvTwfqDuNqZ5MxaW7RnC1J/7rxgqZ8jSW0SQgCB9?=
 =?us-ascii?Q?zl+OItfoz2U3KmXaeiQ6hGrM8eMOHCN9cw65yzQuRJkZJAbTMkYduKXMaAYw?=
 =?us-ascii?Q?ij5NEC8uBMaV7ZNgg7q0JwU/SNJ3CsGj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 06:30:55.5452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab363126-cdff-455a-a485-08dd1751def9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838

epp_policy is not used by any of the current code and there
is no need to cache it.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 ---
 drivers/cpufreq/amd-pstate.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6a96d3a24c77e..dd25e7e615984 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1478,7 +1478,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		return -ENOMEM;
 
 	cpudata->cpu = policy->cpu;
-	cpudata->epp_policy = 0;
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
@@ -1585,8 +1584,6 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(0);
 
-	cpudata->epp_policy = cpudata->policy;
-
 	/* Get BIOS pre-defined epp value */
 	epp = amd_pstate_get_epp(cpudata, value);
 	if (epp < 0) {
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cd573bc6b6db8..7765c82f975c6 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -57,7 +57,6 @@ struct amd_aperf_mperf {
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
  * 		  AMD P-State driver supports preferred core featue.
- * @epp_policy: Last saved policy used to set energy-performance preference
  * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
  * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
@@ -94,7 +93,6 @@ struct amd_cpudata {
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-	s16	epp_policy;
 	s16	epp_cached;
 	u32	policy;
 	u64	cppc_cap1_cached;
-- 
2.43.0


