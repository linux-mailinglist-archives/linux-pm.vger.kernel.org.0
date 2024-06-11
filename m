Return-Path: <linux-pm+bounces-8923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A65890372C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 10:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F80E1F25A52
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392BA17B41C;
	Tue, 11 Jun 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HXYHvEhp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7294117B411;
	Tue, 11 Jun 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095993; cv=fail; b=AFA5mM/txuF67NB/2NjmqTWwkU97fqSE/TAdyQsbz0DKA3KRG39gOBs4C086uP84VbWHIBzupdAPatlgZXdLmZfODgUNV6+tjOjTJqpDsrYW1dz6Nr2jAW+053r8dayqviuxMJ6CYjI458nLNTFGU5Lay8KfRGKs2oR1IM9LOD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095993; c=relaxed/simple;
	bh=dq7AmCvLIboyMl3++ORrMtduRucr1CRl1K6MuyX+JCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bor8sOCcLnzsH2pJDCuDi3cjfHClOjOLlRB3qFdhpVZSPC9BzCzRHK9JD3sIgyng4LwBqwMFlpWZSesY+51AaQpcRFFQqVOYUCwBjfUhdhd8iZonHQtC3qo+d6azpblStqzvfyPG70AGagq5VbK7IOtC07ywVtZY/+9bFB698tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HXYHvEhp; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJZ3e8aLxhG5WAXPfNW1KIpbCkEtJKyAjugcaqAbnfaHNECBawxxRwnYfL0KtzgtttmJyxKbxPXah62u+AxKIbTH5mtjOcoORGq4k3CNXvkTHHotQKYvxpaGbpxK2x6vTSxywPZWyOigpUWr1cSJwnC0csE/nno+kK6UbWCYotGfYrifIzsU3vePemr6K382kMA7eBxhJQASHsKOAubU21xq0+LFfln7+ZwEdE+1T531BzAuH+YEO3AKGOlDXRgsppvLcF7tnaFdYMxCzoSMw0ojYknBIHjLdfwP59sqaKTlFkNdV2yS/MleemTHbNs1mM8Y+F8AW63tADlNNtToAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hBpYrUokvCbHTp5B5iV75sgdkUhRth3XxIbjMSNxbA=;
 b=dBWOm3cZ+unI1cbovMXjapEdZmbQs11wxx7rqqtF01xjUCCP2V+UNhjpr6bzyunfL4vfHDclJ8Cg4t6e/J4IT7Bb+KyRLyucfEB2LgxoMu0thh7blREHBNVuJLWSrPRmKeBZTMjyhbI9A87oxN1njrEIYXA6zF7bg8KQDgfRKhMu9xkTPdoGjGRsPQn7JQVzIri6MU8Px0ynNIihGMdAwoHAjlbZ4tzB89O/Gun+xeKS6TR9IxfRfXnZbo9BZLr6+goA2dputg/4GR11m4A1yUyO0WHQrBlzgm977gslxl5vmvZONGvkZkKJHOR8ToQdEtmI5RTz6xDjJCW9RPV7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hBpYrUokvCbHTp5B5iV75sgdkUhRth3XxIbjMSNxbA=;
 b=HXYHvEhpvRHaVVDrdQjocBV/4rZ3OexFnnv+k5KtWaWWjbWOUah/CU0eZV0BZNtvtNJYZeKCXEzk7ZEPoW8YnhEc9DjSeyHr3tWDDyZOVSOUtjX5mO4CSWVD9sJZmDNBQS7X5mZ/0e8v7G5ISjE5jvY2iIID1sCXo4C9Ip2R794=
Received: from SA0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:806:130::7)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 08:53:07 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::78) by SA0PR13CA0002.outlook.office365.com
 (2603:10b6:806:130::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 08:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 08:53:06 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 03:53:03 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/10] cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
Date: Tue, 11 Jun 2024 16:52:23 +0800
Message-ID: <414f279ebed3b5862b28fe42e1e15c8325c47cbd.1718095377.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 5267730c-44dc-4162-1f68-08dc89f3e9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGFZhcnTdw4MGa3NUJj6H2YfmK81BY0h87WaVFiJD33xGwvYSQr0tgycwbPj?=
 =?us-ascii?Q?MBDCjN6nAWVy1dieCHKR3wW55Aoh9fkfaxmIGZsJHt6rI0FfEVH3U/NXPsMF?=
 =?us-ascii?Q?hEtwCqyOX0dPo1v2axo902Ukazf/CkGZCcAGXyGXP9FBLw/5e1Ha6znKF89M?=
 =?us-ascii?Q?ZxOm3uwaCt/P641jo48Gr/cHjbcxGG3QRQmGHJNxzMg3aTnk8cnbV37APFvE?=
 =?us-ascii?Q?ssfT8izSe0eHd/z44KP8ldbbYFndSybJRk+GxJXjwVmqpDUANPJQIUPqq2X4?=
 =?us-ascii?Q?ZEzueiSll43HtYyC9G3N5I5+MkvqaFjpHuF2OPYI3rIRdCE4+xtope3j9Yvj?=
 =?us-ascii?Q?4hLYLgEgYJsqvtPvrlCA2ww0wP9WUtnEV21m8uTn9Z1m0SaHIO4IoEdpWof+?=
 =?us-ascii?Q?MMN55nnAWA4X5CkbHWkWCsssUKFIVfnd63ife/EIHKYs6zzZ7Kp00DKhajEv?=
 =?us-ascii?Q?YCGkqw0OEa2Zke8IvXI6OCSZ+Fvfo+Jzu19CYkxFcJ6MP7NYWE1jFe4s3BWe?=
 =?us-ascii?Q?9CQFWmG+XJOP41XoXnb+rHwF+Y/UtlH52Vi0471VkuqajG4XDq4dNKKj+koS?=
 =?us-ascii?Q?vFDeuveHIRw+2Cbz+VRW5cEhf6Ft5D+qSzCVv7iOh6F19R0eJi7VmxBrpJxF?=
 =?us-ascii?Q?GugVd5ZeCgmjF+M2RcusGsnSqH3ECmY0yWpgCMK40bLA3GrPF1SPEGY2ekG+?=
 =?us-ascii?Q?lvyJ1GkUBIjQzjGOqy1ULGlDNnKzWDe5dXhfCZM9o8AdZAiwMloIG1sgxa6g?=
 =?us-ascii?Q?tujBbDNbiOzeCOBOI/cUA+W+XtCYfMBtgXzqTZOMrf4ixplIdkXF79kYbIef?=
 =?us-ascii?Q?Le/BNY41WvEY/gig6ITjxnXI0Q18StZqGS5Lb1GwWylwuJJ3LWJw12iyPRuM?=
 =?us-ascii?Q?pDUncAv4ZgSCfxMpRFo62j3gj7GnbtGtIFuF8QQbWnMkc/pRJTEYcyYLXK86?=
 =?us-ascii?Q?QT0j/+aOXS9SRT6q2D8P6NYyYh5q7xRZxo5NfgPoaULrSXof6CZUj5f/pPOe?=
 =?us-ascii?Q?yJdS1laR1UnxgRNQN87+FaD6zb4SzfLSnRENsqZ72ODrLLIKEDuGp9f67vl/?=
 =?us-ascii?Q?kDnbP9VSELYuHZDYYEtNamLZr+NW8NGU0K5GNaL26S06ZGWo6KpmVuLRZDxL?=
 =?us-ascii?Q?4K072SUOgvvtCLRZJysUZXpCny3r8uWPepBBSUHINBMQxjlUaz5Pg1Fz9kFj?=
 =?us-ascii?Q?GCrAewPnBrEZ30nEx54qKOd0D1/lfOM7i1nthjpJUqO3YP7g/dPWLz0rvHe+?=
 =?us-ascii?Q?iDBHq/oPzh5SHHNvgSrnmg2aJ+ASu3ibYSMH3u4vsVZbnNwBwqrFqGdhPB5D?=
 =?us-ascii?Q?xzTfqfxj9F3btvSHN23UAi+YTq8qjJ1JgW42dRI2MfzKhGY6hLJdfQ/kKtEV?=
 =?us-ascii?Q?NKy0AoiHfc1KRSHDISzqLnbUe/OoMsy7Qa1+05QIRH2NSHmkMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:53:06.9915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5267730c-44dc-4162-1f68-08dc89f3e9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

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
index 6b9fc24001f2..cb59de71b6ee 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -157,7 +157,7 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
 	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
 	 * definition in ACPI tables
 	 */
-	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
 		quirks = dmi->driver_data;
 		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
 		return 1;
@@ -199,7 +199,7 @@ static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 	u64 epp;
 	int ret;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		if (!cppc_req_cached) {
 			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
 					&cppc_req_cached);
@@ -252,7 +252,7 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		u64 value = READ_ONCE(cpudata->cppc_req_cached);
 
 		value &= ~GENMASK_ULL(31, 24);
@@ -753,7 +753,7 @@ static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
 {
 	int ret;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		u64 cap1;
 
 		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
@@ -988,7 +988,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC))
+	if (cpu_feature_enabled(X86_FEATURE_CPPC))
 		policy->fast_switch_possible = true;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
@@ -1221,7 +1221,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 
 	cppc_state = mode;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
+	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
 	for_each_present_cpu(cpu) {
@@ -1450,7 +1450,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 		if (ret)
 			return ret;
@@ -1540,7 +1540,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 		epp = 0;
 
 	/* Set initial EPP value */
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
 	}
@@ -1579,7 +1579,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	} else {
 		perf_ctrls.max_perf = max_perf;
@@ -1613,7 +1613,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
 	mutex_lock(&amd_pstate_limits_lock);
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
 
 		/* Set max perf same as min perf */
@@ -1815,7 +1815,7 @@ static int __init amd_pstate_init(void)
 		 */
 		if (amd_pstate_acpi_pm_profile_undefined() ||
 		    amd_pstate_acpi_pm_profile_server() ||
-		    !boot_cpu_has(X86_FEATURE_CPPC)) {
+		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
@@ -1834,7 +1834,7 @@ static int __init amd_pstate_init(void)
 	}
 
 	/* capability check */
-	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
 		if (cppc_state != AMD_PSTATE_ACTIVE)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
-- 
2.34.1


