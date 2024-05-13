Return-Path: <linux-pm+bounces-7753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA01E8C3A0C
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 04:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4848D1F221E0
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE91137C58;
	Mon, 13 May 2024 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eYhP3cLs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246F137C33;
	Mon, 13 May 2024 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566096; cv=fail; b=SSI3Ps/TxPTf37G5X5VQiVHZ3HTVTALkFzP4/+TRF+zIZ6nlfLz/riNJSOTVvrFiQbVRU/I67cOBnDZausHtBCIGZx2H79ZjQeYqJTt1jpGUc+qfvYAgZhywUN5P8ZO3/mu9pFiAODYSkAbPy9uph0o7E8LFqL8nlWEr2RzOvXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566096; c=relaxed/simple;
	bh=zVh9a/0yKDp3sGnKY2JnJ8CsuSdXubja1/OSCt1QwDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXA3HqZAkCCgxE817Cwqj15/e/vXyaCdd2Q6KF5ig+V+KH5buXzXgxPvZ6/61iW3SV67FylhdxMYDa9jweAmczK1fxuweRlzI/JRS9FOtlZUJCp4s09W+sljaIbQHx7HmwnyYCDSshvslhpD9pDYKPdB4+F6iaXCw6u5vm5SAIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eYhP3cLs; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWVzZJmPMD1q84OTDopnslBBZe1V7Jbj6XYyo/ny2CZEOABnREuDgesdDyhvTkGOpwbnkBOQdGYxFvvLIPEi5ny0HLWxfSZDy54kazIbCnu1ZWEr+jPSf6vlFT+F5c/riqClefiy0V1VuIXcTM4gCIO+rLm1KgHo5keJWkiqKOCJ3lGz2t7QL5Xp850v5TT++v/stx/JAGKs2onGsN5f6Fd45f0aeRO5BAg1j4dJSD53za6vmr7lZ1lRX0rWPgfU09wBDmdZLS/td2EFbKoGoXZwrl4Q9J29jfsY8vOfpp4EebwWU4a3LKrK5wgcSgShfIA5NpIiKX9QSigQP1hW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEpUnXwibqomQ1d/+0c25thkHNS2HxsgdosAK/uUFuU=;
 b=bKwDY4yvU+CsQ/2I1tRi+taYevVHsu0AH0yHCwraMZC7pgY/DckL5AlM3fmZk5sG0pw+vd7dsAxDeNfbCIwpm5Bp7kccyXP5kcUMMH82PrUVGjbT/hvF4UgdHT1y6MSvHIGJ8CeHfl8NMbEUvYWKWjN3gcBTQtCbP4CNtVnfu9mnmwu65Djxn+8wnn1zclPr+txybBac4m7V03avFpSLd1sGEVI0hgWRTQaqKpiY4MrgaLYqk4Y9fQzN0NYQOO8HGhIRCMYAOH6n2yiRx0IaKFVUtceZl8k8cjdsqtWvTH3oLG209adoeHAbkHhtW4D51RkiN6ysyzkHaOa3NNZgQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEpUnXwibqomQ1d/+0c25thkHNS2HxsgdosAK/uUFuU=;
 b=eYhP3cLscuCaAZuEaOqRhTj8lEfFWA8zMq481oq2rmtJYIW5bniFIHNacZi4mhuCEKyh+ep4tTY4JVVcf6KCN5n6RiEcna1/zVLUL/MOfvKQtINoMdWlirNEkwafyGyXVU7AmvucCTSrhmlcz9ik8+5T1HBY/IkUwbUw129cG90=
Received: from SJ0PR13CA0196.namprd13.prod.outlook.com (2603:10b6:a03:2c3::21)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:08:10 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1d) by SJ0PR13CA0196.outlook.office365.com
 (2603:10b6:a03:2c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Mon, 13 May 2024 02:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 02:08:10 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 21:08:07 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/10] cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
Date: Mon, 13 May 2024 10:07:25 +0800
Message-ID: <c7506ec8d6f4c90d2e76c038b3be6a6db82f53c4.1715356532.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715356532.git.perry.yuan@amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4acefd-d9cb-4566-0f5a-08dc72f189f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OjKPWFNqTcvYBqgFXuDVmfbGJ42CfulVgW1qhWOlVWLC5Qv97Ojtp62RuKEw?=
 =?us-ascii?Q?E2tMiOt8GSG9an6ClxZp45MvEvet7S+u1SmRfgwtqxnhr7AHYZuqz/Zvyeyj?=
 =?us-ascii?Q?tUFm295dNLJvCn+dKkzXz8nxEenLq0rmzUIz9sM2ud/Wt9GultN7EFbz9zeK?=
 =?us-ascii?Q?o4k9TIHcC420kv2v7xc1n1y8uHxvUTOYpZD9UFC4zAXuHiX5krLRF94Kc2W4?=
 =?us-ascii?Q?X8Ph0CE4kL5l/cDMyMdPWbdkf+35iSSot1WB2wSfXZj+n64goZFt+gSGqXb6?=
 =?us-ascii?Q?A64ssEBrX3WF72PO7lg+w3KvF3sL0/vfunKXWIsM9NNoV2s/k58FQGMoNGyF?=
 =?us-ascii?Q?049+8307H407z/ipPBQd+tsiS3dsI+EBt7sDRP407JqTzlNNjic2iMvngGqo?=
 =?us-ascii?Q?CLaZJAFe3yTsKZhpci6J+nkH1bsD3O7gWzXsJgOV3Z5r1mm/r+Kl+XRPOUrB?=
 =?us-ascii?Q?lF1XQds/6zPlpDYTi2M6Hf8A/X1nJnsY1oTZYZVIWPpYiaESMS29w83jisPG?=
 =?us-ascii?Q?lXw+pgZqDHtn2pehZcVH/iuEcfCBrJt0iuyUqcejyUKiJR5kI0WTH/Q6lG/T?=
 =?us-ascii?Q?B4b4T3t9TnnUN6qShCBiKbXh3p5260S6BtrRZlQRxeWPg22qTRWLu6csQO3G?=
 =?us-ascii?Q?ABx98brlfBxASMj8J9SosyVOk6GwcQgp1U2eFCiB02Rs7Pf8muD5dd3HLKz+?=
 =?us-ascii?Q?Mcao8XI0MXubVK+cNO7HjcaOjz7L0DYMuu4ienSf0R5/dt5HVtUi1UgB6yrP?=
 =?us-ascii?Q?1YuLwEvKCynb2AYjiKngxODtqzLpS2nIMjWjO12b7gLY5Wj0vKk0UBn7pBLX?=
 =?us-ascii?Q?xM9/t/UYhb9ehe/cVm/Hcv/vlsI+zA9Uiac5raBC6Z48udqGJtzMNTysQs3b?=
 =?us-ascii?Q?hwo26fKXfiv3Lmsv9xuxuKOA9qFtHXq0T+j+hc/BWKOhIuFND2afgTv5rbUN?=
 =?us-ascii?Q?h4Wm/TJeAm5FNG+7eTIZzLSNl+8Bg4KlRZ45T6dmDAimcjDNEb9bt+JpLqkU?=
 =?us-ascii?Q?/zDjmS/DXYihuklpHrn3C/PUgUBJxqT/mXxq159bg9y2jBI2BCZxlicErbmc?=
 =?us-ascii?Q?A7v0nvRxFBvYX2jgfVNweMNB/NQJD1oJDCxwDT/m9bqNJODkL9FrSN/byHls?=
 =?us-ascii?Q?fjOm4jEFpWVRreltmFj+QN99Ql0XiJ0qPtS2VFz1pmkb4h7QBQSm6WBVHz+U?=
 =?us-ascii?Q?jFjwzewjo+FDvXeO4eefUeiuz8AAAlj3+wB0iUkzc9po1/8jSXSK3W4MoCQ/?=
 =?us-ascii?Q?FFTgEtidRU+6n4KcD6kLyLYLz74OzJ97MwM4YNclJolKZviJVMgo23wuGUKz?=
 =?us-ascii?Q?xDl6t03Aq7BMJ8c3N/K491nyYZCIVdrwyKG6ei/pSMsLgO/z8cs/AKH8LVTX?=
 =?us-ascii?Q?xcEIfR6kuIT8K5st6kjOdoel0yAR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 02:08:10.5832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4acefd-d9cb-4566-0f5a-08dc72f189f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370

replace the usage of the deprecated boot_cpu_has() function with
the modern cpu_feature_enabled() function. The switch to cpu_feature_enabled()
ensures compatibility with the latest CPU feature detection mechanisms and
improves code maintainability.

Acked-by: Mario Limonciello <mario.limonciello@amd.com>
Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8b624c79c287..8b8cae1b678d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -125,7 +125,7 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
 	 * definition in ACPI tables
 	 */
-	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
 		quirks = dmi->driver_data;
 		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
 		return 1;
@@ -167,7 +167,7 @@ static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 	u64 epp;
 	int ret;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		if (!cppc_req_cached) {
 			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
 					&cppc_req_cached);
@@ -220,7 +220,7 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		u64 value = READ_ONCE(cpudata->cppc_req_cached);
 
 		value &= ~GENMASK_ULL(31, 24);
@@ -721,7 +721,7 @@ static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
 {
 	int ret;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		u64 cap1;
 
 		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
@@ -956,7 +956,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC))
+	if (cpu_feature_enabled(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
@@ -1189,7 +1189,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 
 	cppc_state = mode;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
+	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
 	for_each_present_cpu(cpu) {
@@ -1418,7 +1418,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 		if (ret)
 			return ret;
@@ -1501,7 +1501,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 		epp = 0;
 
 	/* Set initial EPP value */
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
 	}
@@ -1540,7 +1540,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	} else {
 		perf_ctrls.max_perf = max_perf;
@@ -1574,7 +1574,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	mutex_lock(&amd_pstate_limits_lock);
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
 
 		/* Set max perf same as min perf */
@@ -1776,7 +1776,7 @@ static int __init amd_pstate_init(void)
 		 */
 		if (amd_pstate_acpi_pm_profile_undefined() ||
 		    amd_pstate_acpi_pm_profile_server() ||
-		    !boot_cpu_has(X86_FEATURE_CPPC)) {
+		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
@@ -1795,7 +1795,7 @@ static int __init amd_pstate_init(void)
 	}
 
 	/* capability check */
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
 		if (cppc_state != AMD_PSTATE_ACTIVE)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
-- 
2.34.1


