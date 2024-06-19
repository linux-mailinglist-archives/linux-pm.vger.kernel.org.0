Return-Path: <linux-pm+bounces-9605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE34690F270
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7F11F23E32
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E8155C83;
	Wed, 19 Jun 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aOOy1Ls8"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF6155730;
	Wed, 19 Jun 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811660; cv=fail; b=M2B0U6bZDJUe/kbtQfL2MLhk1T0cpkeom1DR919yEU8kGBYVHR68pwR9N+lLnyr8SktpFvtNrnHBDyBJopAbgSmfSSgT12VzOEhoAkuIKpzwC20Mv6X8zvpYAT9R/mh287U/BuSGkJ+RQn+3WP+w2U1BQ5ELd2v0zMji8t9W4qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811660; c=relaxed/simple;
	bh=i8eqsDNdLSbpX0zvtYrlJ6MLMAVOl6GOjlMan/f6Ycg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqUzdVkl5tQoa/tDZM0+71DNCiSUx658T1te9GDv8Ddw2olYD49xJ+BCRRFvqNJfoLWgE4cwnryD5596QX6tOv2s6AHMqRMcX+Tkdp5B9M2otPqGVfmOyw+B6/0tg3+w0U07AUqIE+dkaTEixlC3/lhTUHPiRv1oMavd4M4K/mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aOOy1Ls8; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAY1KLRiiTX0qlDvoG6COHcS8cPqYB90gjgDNXGEbnwW3TDFFClkbQTtAyG47mdC/b2GqPPPrmTZYBRwp3tQ8bRu4ETmCXzln7TYM00G39zGWaXEaizzQt5z6yP0Oo+0Lvi7CC7njjwhFhfNFZqw8urPTLDdpyfZhQj4E5qfWulnWBGjV3SyaiZSqvwUYpaALQeg04or9nHiVjkic2AshLXi+a6e5E5XEniyFrH70iE3H8zjIzcSEgeXCxzyh4MocSVFFNzpKodYz6bo4i++8J2Eu+UqhKwndzgWlOZ6PZs9LXUjX4CUnBUBXbNOYiWF/MiwPoC09NtUpw25aGcGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3+50qrB4Yad92PLxPRpV9Koc3tSgHyYMSSXzrds6l8=;
 b=PMwZ8mo0ZvG6eJUSg6lMtAGoggVESHpT1t6/0xTHFd6p+bIP9kDnVl14Y8zrWu3SJCASGfq0MoX7QwfeVLWjacCihCB0Hf4vcq6OlleOteeHcC1zPyuTog8/mqIEZr1lreYt+BXtdmD2+ePlJdEHFgKJ260G/mTxPVct4iW7Tm0lmvkATIrHRa4kS2ObRsMTFTmhOFx0AQ5TITuamuOmCn9tQaMPa5xByiFm92kWHhEWYoD/e1bnAnnpUuSov3ML7ZKDXgAOby9iilhEHj5NeY3EauIp3UgjS779AHU7TAaFzKFTwcRNnRh0W9zew3gwjpX6k3OP3NMdoUHTYkU2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3+50qrB4Yad92PLxPRpV9Koc3tSgHyYMSSXzrds6l8=;
 b=aOOy1Ls8d7I+BnQYddVwYWMtI92j3e6cfjNVD9lQbPx8KZpzwa7WLzWe6lnx5ovZAJbQ+9Ii2XizMpl/ELWpz7Du/E54C4VuqXKBW3K4N7Fl6qjYbaQ+ot2HtOokuQ4pU4RJEdgzbqD9ZmtNRe1vn2mZTnO0IjYJiGVEqXVCL0g=
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:40:56 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::4b) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 15:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:40:56 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:52 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/8] cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
Date: Wed, 19 Jun 2024 23:40:17 +0800
Message-ID: <f1567593ac5e1d38343067e9c681a8c4b0707038.1718811234.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718811234.git.perry.yuan@amd.com>
References: <cover.1718811234.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c01729-3c93-4163-65e2-08dc907635ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LeNAZX2crznG70aWyWDsVoTLg3GTLxBvkwxYhoWhsCtTqpZeRdf5BFgfwPM?=
 =?us-ascii?Q?CpJdC4odAgZoNhnov1QynC8s+OdxOEVwKsrCq8uOGppB8crgDUFrttH8lLuz?=
 =?us-ascii?Q?4S2ehCu4dnsi4zBNX+Yl4Q/2kh9nLpKhErhgByKlt8DN89+KahvdVgM4Zx/V?=
 =?us-ascii?Q?i2TC+oTaglfA4bi8fK8JSyfbXmvQMtZq3kGtTy2buu22O6rwgo69r+Nxcc01?=
 =?us-ascii?Q?3RlRQ46nnWdU63CoaAVQRXz3HZNSHOgTOx3Iu4OOJNiXQoiZkUivnJWScN71?=
 =?us-ascii?Q?5MWq6nEdRkkey3xsF6BvgGscTIkpYJUlJjnk85drqwKwGIHXM/Swdt0bnSAU?=
 =?us-ascii?Q?hK1OhRb0YEAj7WtGv2dhc4bZno9uTcObZfTMwCSkE5osLCFgUI0z+Zf+IXOD?=
 =?us-ascii?Q?MpWUuWotV/x+04kRpCZtBhEG/NfDiNU4aPSom7HYXeuP5YujAks7aFUgOK6/?=
 =?us-ascii?Q?WGl+FiZ9DtezoGEXFwBJL5ZNmsjXHpFG7X8GhCnSuPpcJHgn2UXTvlXJ9Ndr?=
 =?us-ascii?Q?tZ2uIqUz0iQDxESgOcAE0rrSKl/FaxNs1Xyz7fqIHaT5bFRhUBRLaPwhVsHD?=
 =?us-ascii?Q?IEycGHE9468XF4RyO9Me32hS+6iSHvu3r2AhGNaNWMbihjEIsN/9r+HnNQgX?=
 =?us-ascii?Q?UwSMBEMXJ9M/9t4WGdnadUHvFf6BAGaf80KPkixEVEpiMmswy5eiv+VcMJbp?=
 =?us-ascii?Q?BuVS0m6/aSzb9lbenP9J8HlmVcU8yfDfNfOg1Zl6SHVu7OCu8AGwsf31uVs8?=
 =?us-ascii?Q?g3UJSiNRvT73ZinbCS4+A1M9jLUhcW2g4+ApHi1Uw7RmrdUb8ymiZxI5aM7F?=
 =?us-ascii?Q?0NiL2IM3Tqo3EIzOPSJUBx82GNLGU//dEj7KKYNKynaem59kM1r+nD6Gw0hI?=
 =?us-ascii?Q?TtHLFrsywwEiXfalM6+TQeo9a0EyD2TMVuEgJ/zvi+RMTsIvkz18QZMwOmLf?=
 =?us-ascii?Q?NSaDbyz05CV5odl7zGeyQyR7KwRa8R81yysmOlc2c5LsKghy0Cl4j23AucIE?=
 =?us-ascii?Q?++OnkB1wPscU7N2tLhlbSq3R7AL2JUMZB1IKha0vCN/VsiV2j/cA8vGgYfJg?=
 =?us-ascii?Q?hjSUZFvUJC4hunXRpocmyIiA8a2Qx88Jj+S3CKC7pE1JNN0Sa/d7aF3bKVZL?=
 =?us-ascii?Q?zAPf+UKzCOGScbOlVQmPIyN5LQelS0r3JFYWpTGNTA8U4OyVnvFOsxTWeLmp?=
 =?us-ascii?Q?HxqVso8DjK7OY9zAQxFm/0GfsKjhIerv3xJevsMHcewNhb8rmSZYieUYh6e0?=
 =?us-ascii?Q?XT9xr9eKfahry74oHLDUNWfn9lrBBXBKBd+IcMgPypa1LgtrlgEr2Fm+Z7wc?=
 =?us-ascii?Q?TrgDAipfgQs2KoWSALvZ92rWSuKwlarDzapJ5Z+hw6vzxRpTEaFmbnUacx06?=
 =?us-ascii?Q?j7wlhagOU27LrCKbys64bERA5Gi5IncLjcg75Jm1iMRlM36RAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:56.0017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c01729-3c93-4163-65e2-08dc907635ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

replace the usage of the deprecated boot_cpu_has() function with
the modern cpu_feature_enabled() function. The switch to cpu_feature_enabled()
ensures compatibility with the latest CPU feature detection mechanisms and
improves code maintainability.

Acked-by: Mario Limonciello <mario.limonciello@amd.com>
Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9aa220a0e3fe..cb750ef305fe 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -158,7 +158,7 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
 	 * definition in ACPI tables
 	 */
-	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
 		quirks = dmi->driver_data;
 		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
 		return 1;
@@ -200,7 +200,7 @@ static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 	u64 epp;
 	int ret;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		if (!cppc_req_cached) {
 			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
 					&cppc_req_cached);
@@ -253,7 +253,7 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		u64 value = READ_ONCE(cpudata->cppc_req_cached);
 
 		value &= ~GENMASK_ULL(31, 24);
@@ -752,7 +752,7 @@ static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
 {
 	int ret;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		u64 cap1;
 
 		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
@@ -991,7 +991,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC))
+	if (cpu_feature_enabled(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
@@ -1224,7 +1224,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 
 	cppc_state = mode;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
+	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
 	for_each_present_cpu(cpu) {
@@ -1453,7 +1453,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 		if (ret)
 			return ret;
@@ -1543,7 +1543,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 		epp = 0;
 
 	/* Set initial EPP value */
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
 	}
@@ -1582,7 +1582,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	} else {
 		perf_ctrls.max_perf = max_perf;
@@ -1616,7 +1616,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	mutex_lock(&amd_pstate_limits_lock);
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
 
 		/* Set max perf same as min perf */
@@ -1819,7 +1819,7 @@ static int __init amd_pstate_init(void)
 		 */
 		if (amd_pstate_acpi_pm_profile_undefined() ||
 		    amd_pstate_acpi_pm_profile_server() ||
-		    !boot_cpu_has(X86_FEATURE_CPPC)) {
+		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
@@ -1838,7 +1838,7 @@ static int __init amd_pstate_init(void)
 	}
 
 	/* capability check */
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
 		if (cppc_state != AMD_PSTATE_ACTIVE)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
-- 
2.34.1


