Return-Path: <linux-pm+bounces-7559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DAE8BDC46
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 09:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3021F251A4
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 07:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747E13CABA;
	Tue,  7 May 2024 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FXbdXgz9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EC13CA9F;
	Tue,  7 May 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066178; cv=fail; b=upPtB273cCgs4Gdfhl2/XqdS6Qb4Cy7YnqLi1b5LnaoDgJdTp8HEJqH2YdWnQTtshCL0IjwO1/+dYd8Ea63BdHzggVs2BSP9w2IpQM8Og6p6AtEbI5R32Y9VzdY8m07hVU7z1Dyj/nh4LNnGhu6bOKVcYyQwRDKiQ9n4twRuXsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066178; c=relaxed/simple;
	bh=WKG3EVGmU9irOmmfKjFVvvyMaG26ewP04Bg43EUgtws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIrtumhifFJbKSVl/6XgtyB6GgrMTZD5TsoQPmx4pesJbwPz5iNMx9mig9t5CbSyhlmXKcys7173n+ntt3YTpvahvrZBv/90Q7DGPG1xP2LOeHYWjWvxh3hAOV+dRgwcknHY4pvpvX2CJ1y1dWhbfQcLBJSvvg5yG9mN033KIYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FXbdXgz9; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4zjrZKs/W/DKvGpBdt/QB6TZ26Uox5S9s2XStScen6avPfNSFL9pTUNbwb4Kv2aGb4moMkEaKj4SEfzbOd+meVj9ikEBqOgLkW1tP/d2u3ZB12yelzZ0d1TMGxj1lSfWgm5CP9/y4OHbv7CPCDYeTyTnsJfXurWnpLG0SDNkFC9BTjjzobYVODHuXR8fV9JSIacDFqG4EqzVUNZ/VYl6+aRrxRdUhWTFAq3dzf3EQeGToYKlnLGQXh4+hl07cFd6V5XyxELSF1RNPu1VyLq+gWHKlyMWcBWEmfVD5lbnaAUgdTvUfJFiMlILJtuRUnNUq8LiistpOw+LGrv2UKcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsnbMAC232AhVn+BNUKVtGgVGDE9wZaGwTtXub/bu5U=;
 b=Ml2OUO9cuAq4eZ9bBXiDUwhlrDZaWyXX4AZ7LDaPzvfDKxQ32rSwF9Uv7kzrzLL0etE+N6AUAfY0RuTPaD/Mj7YQ/tKjEB3CSIniS+xYyWW29yuoBhcEduVoFBjPFa3knTN1XK370/1npcbqDWAUXEaMTscoVbFOgcdP50OJNKOADwGqa6aQPKVxsEuvuuDrb3RI2/ukmeSbkX8jt4qRvn/kuDP9t6Y7bLScuxJdg/05rn363yorqAWOWbIYRFjLpMZ08mw9OssMW1qfPZ5vadOgv9axNex+q6+GbHkgtyTA27IuF/5QCvJbHADTxcM5bHSiHYpPt4o+y2MF30CdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsnbMAC232AhVn+BNUKVtGgVGDE9wZaGwTtXub/bu5U=;
 b=FXbdXgz9IUQqiJfNn4ppzQORQtywrZTjeP2wHYkVxyKfvH74lHT1UAU3FINoY8yJKLLedKY5SjfHX0+TGc3uBmD5p3hz/+yD5ZNWmlgeJJXgxKxUIaGPPx+JGdkGtsmVmeF1tFcBToWqft5bjG6uB2623h6pDL5xXIh2YReb4+I=
Received: from DS7PR05CA0030.namprd05.prod.outlook.com (2603:10b6:5:3b9::35)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 07:16:13 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::53) by DS7PR05CA0030.outlook.office365.com
 (2603:10b6:5:3b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 07:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 07:16:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 02:16:09 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 07/11] cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
Date: Tue, 7 May 2024 15:15:23 +0800
Message-ID: <39ce335d80306e7e9ed9e169994348e1f65e1679.1715065568.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715065568.git.perry.yuan@amd.com>
References: <cover.1715065568.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab48c55-58f1-45ea-64e2-08dc6e6593d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HDmSiUCGO/IkHOV5MSWsIaVWsdq172jo6C3cOEpAuQQtdDp/hP1CsaEzkRJ1?=
 =?us-ascii?Q?ViWZJ94EaYUivInSagguISFYW28yp672Mq0O9ex8u4926YLrLH/KtPMyHEk7?=
 =?us-ascii?Q?SENVXueG99/F+pS7MfaTxPq1RE/aPYEAqRosSDvsZjC89Myh7oAJYt6gPmQX?=
 =?us-ascii?Q?LxbcwAw+btyahiXVvqRD/t2/nUcTYWAYyZ0Ujm2GzQVVxv17xW1XcXOMp8rF?=
 =?us-ascii?Q?Y896cUcrqfhHWB17vwR8NL7CQlznH+kpfrlSUmY1KHJfkmnu7QG7Y5ey1w4J?=
 =?us-ascii?Q?fpWj3sRxlG46QKrqLQDPr8P9R2Fsp6etOUuYArDWgAWQH2vKCapbDeg4W2rt?=
 =?us-ascii?Q?aKnHVeWMBrNejWxreF3N3R0rzcFdkdY8hgAG9C0w0wMgVkvAxZa9wHbD+uf9?=
 =?us-ascii?Q?AJRSA1SvfIWpjMg1mFco4qQybFclVmqqdqsWI+zVyQuvA5GsIawyqaQiNK3T?=
 =?us-ascii?Q?oEqPm6SeXwroGN5XwmC+wCJWMlV/iB7omNISZKu4anmF8gvxckWirgSqvTIF?=
 =?us-ascii?Q?H4njfoALGJVkh12rnwyfRz2o4w0yEJP6pdpluEtxdkcDwORRBz6R+hH7dgwW?=
 =?us-ascii?Q?wwOQms/YAULSHUyu2jmpkt/xzqc2iUhSyItgBbB7I0KNYdSN512ivxQrxh/d?=
 =?us-ascii?Q?zQgFpjrq4NHqXiB7EvJhihMBemyne44Pg9IjkPTlb1O9C9uKdTWg5W/35Hl5?=
 =?us-ascii?Q?glBT69C7D7EmSW/IEyER4Z6R8NwtpLb/XOcKZL/TZH1FXrd1dzouCyBquN9V?=
 =?us-ascii?Q?PqWareqNMEsLrJQhsp2fWuEQQXgVUVu2l6Uc3aKrQnmPJ1gF5mlfJ+DkAfqO?=
 =?us-ascii?Q?FjBp95evrzJ4O4JzEI1NjD7QfsWK6/iwNf/Y4CFv9gXAHf5ohGbRue/BOZoH?=
 =?us-ascii?Q?Ne4Id2BFKzSjRR1xujYkZKV+1/lGbkOzaBompPH7Ds+pzc2bLvU35NtkWIoh?=
 =?us-ascii?Q?es1mMU1DY4iCvGPQ7b9DfeB1qYe5GVju+yeUVIeEbLbOV7ZDYPngbK93eXKD?=
 =?us-ascii?Q?pY1/yy5DY54ewCDKoXzzSoMGn/CrdKlLzDaHHR5faAj6cnLLd6duXdlMfHdN?=
 =?us-ascii?Q?AdSXMf8p/Wm6Zk2nQB5tnCSfBWcSkBrKM8ceJfO06wfd82fET3bm7KRpn7+O?=
 =?us-ascii?Q?3IKeHbHk3tF8xl3xeoOtkioiLJfZoj/Q6DLfDEYZ44A3468TC8tTxMsO6Hso?=
 =?us-ascii?Q?GcjB8f8KURf9iF0tp9DWLDlLbxLuFt5kgkzIdkP2xmTWPYSPiSonnO53MBMf?=
 =?us-ascii?Q?ccbxiTWNpQM3F9eObrZhx40fR6cMAJbklceni/nwduvb13ZjT6o4MFu6N7Fp?=
 =?us-ascii?Q?BK/zfCqAd1+qfPbfKG9TLKsAZxTkr/0bJ7N78Lk/QZ7UT+Qx9C9nu/gXCTNK?=
 =?us-ascii?Q?vFz+3rHTpn8P1R7n6HCLvwqqbz0O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:16:12.9818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab48c55-58f1-45ea-64e2-08dc6e6593d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606

replace the usage of the deprecated boot_cpu_has() function with
the modern cpu_feature_enabled() function. The switch to cpu_feature_enabled()
ensures compatibility with the latest CPU feature detection mechanisms and
improves code maintainability.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e94b55a7bb59..7145248b38ec 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -124,7 +124,7 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
 	 * definition in ACPI tables
 	 */
-	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
 		quirks = dmi->driver_data;
 		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
 		return 1;
@@ -166,7 +166,7 @@ static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 	u64 epp;
 	int ret;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		if (!cppc_req_cached) {
 			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
 					&cppc_req_cached);
@@ -219,7 +219,7 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		u64 value = READ_ONCE(cpudata->cppc_req_cached);
 
 		value &= ~GENMASK_ULL(31, 24);
@@ -705,7 +705,7 @@ static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
 {
 	int ret;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		u64 cap1;
 
 		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
@@ -941,7 +941,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC))
+	if (cpu_feature_enabled(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
@@ -1174,7 +1174,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 
 	cppc_state = mode;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
+	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
 	for_each_present_cpu(cpu) {
@@ -1404,7 +1404,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 		if (ret)
 			return ret;
@@ -1487,7 +1487,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 		epp = 0;
 
 	/* Set initial EPP value */
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
 	}
@@ -1526,7 +1526,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	} else {
 		perf_ctrls.max_perf = max_perf;
@@ -1560,7 +1560,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	mutex_lock(&amd_pstate_limits_lock);
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
 
 		/* Set max perf same as min perf */
@@ -1748,7 +1748,7 @@ static int __init amd_pstate_init(void)
 		 */
 		if (amd_pstate_acpi_pm_profile_undefined() ||
 		    amd_pstate_acpi_pm_profile_server() ||
-		    !boot_cpu_has(X86_FEATURE_CPPC)) {
+		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
@@ -1767,7 +1767,7 @@ static int __init amd_pstate_init(void)
 	}
 
 	/* capability check */
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
 		if (cppc_state != AMD_PSTATE_ACTIVE)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
-- 
2.34.1


