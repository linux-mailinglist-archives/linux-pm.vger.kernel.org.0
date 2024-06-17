Return-Path: <linux-pm+bounces-9286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3390A653
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB0B28A4FB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B46E188CCE;
	Mon, 17 Jun 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EOVsW1nU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5E18FDD9;
	Mon, 17 Jun 2024 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607645; cv=fail; b=DiliCD6craGG7IbxpAhPSce2Cne3DbDHjRgX4t+G9vX3mHrU4Z/A592ZAhk3dDVVz4TQtScJ3IIhfrROEHyxaJNFVQPuX7ZwUVkZ1dKXAH5iNmP3NIQa0+1zj74mcAzEKr5iEPSjv9QGCEfc21lBAVmgtcoRbozg8zRKOy7mSgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607645; c=relaxed/simple;
	bh=i8eqsDNdLSbpX0zvtYrlJ6MLMAVOl6GOjlMan/f6Ycg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAaC5NGXrCg61jC768+CKwzOQT+F9SBNT81SugpqeywrOLR10QxOUMPxw2cXTkwb2MmJboAETDPtY5XEPKHUKLdoJHSx6cQfCBpajaA/gRToNBkOunTZnzhOg5qnyLDLnTEIXTL1GoDKLZKYvasUichZbJOSrMs13WSypwv+W9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EOVsW1nU; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us2Gnmq2A+GePe4G41t30XREiNnubeY1/SmVHBcIIQ9mhJCOdXjScXgvoyOPzp3yMYLdK24z6uy2sppi3pA9uV5k0aaeaoy9mQekA6KOexNpj20tXxrJq1/CwU9jX+ScZp+MXkggttVZHDhrOAqZ1LKITP/kYKsXxf7BlqB88utI8W95gSHaQ/18Islv4RxAcbTH/awObA8xIR1JJrT6eMqCNDmAAmr9iRiauze98DlISBmX02QOSQPsRhlZSaKL2eJ1uwLzU5CR4xTPeq4KzK3Zu9Zr/B7t0MlmTBXr3CzVBPfeb8zql9moUQ10ROUw5pwsk80Jw7T/DS+VzOo3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3+50qrB4Yad92PLxPRpV9Koc3tSgHyYMSSXzrds6l8=;
 b=CjDa6MDTHf52lBZ7Ac81uBI2mABA/R7TB8K6Bd4x/FyBkrzbNkhU79VEWzdnNyZvahoR71p0DolHdngZSWViecItMNzxswSLWAa5U3nZ2h8ZaSREh9pRq+KNPXqRSZ9yFD3fpkn8u34i4Lc9C3ukrv2F0lJd/bCvrPpeRwVhUNJAV+BN61TNV9rkpGF47ZuTu78Zqn08T8IeUjWDkc3jd9xLNnIhIWD+xuoLJ6moyLDYYIm7TWaFkRm+rOLMapkUNVUg81yJWjhEkecat+NaJM1hhlD8cmyktP84H3BXx68q8Nz5+09lJq1gqdFT5k5p8f66IgIPDJHBLy66UzRIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3+50qrB4Yad92PLxPRpV9Koc3tSgHyYMSSXzrds6l8=;
 b=EOVsW1nULvCM4spL4iPMEnnnZOKy9U0HY7RSpK3I5HwRZSnOhCRJCDZaf7GrbZE0hMaANAJPwYn2xsLOdM2/vS2IjPNU55aLl/qigYsvGIHscs5/kViJ4rGd0GwwvvADP82J515wJahSW5GLJvJBYDsK3sfMjcQZxs/a5KYYVf4=
Received: from CH2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:610:4d::23)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:00:38 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::4d) by CH2PR19CA0013.outlook.office365.com
 (2603:10b6:610:4d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:38 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:34 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 07/11] cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled()
Date: Mon, 17 Jun 2024 14:59:09 +0800
Message-ID: <6c594d6405e87f28df74410aa1a4dfe6596e0ad7.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8be93e-80fe-41cf-142e-08dc8e9b318c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0J8+Fu2oyzI1AWVXQNnD6aB9ZlDG2z3uBZkppzxIEqVWop/l+l8MUaxtdQ5q?=
 =?us-ascii?Q?oHUpz0m8nGRTBnLW5TtPAWmrXZoNg5l7Y208tXCrR/gVSCXH+/axAixz/58w?=
 =?us-ascii?Q?NMKptimbgyN2RhpIwtjPVbYIF0lmeJndzLNoDwoeknxYe75a4FEVQx1SBC6Z?=
 =?us-ascii?Q?4jX6FWn7stYFZn7SVyuC3MHdLiTVgzobMspi3qypd3g0HWu5lAcHSilxciRx?=
 =?us-ascii?Q?uvBQ8VOchoe+fraLzKzkgjMb0cMSvT1fFZ38klI4ncvoN+GcnBbaT/tgPaqt?=
 =?us-ascii?Q?UWk4nIGAmCZgRrZZ1cNHtKAI2lYFRD9Kd80tpXez13nrFN0dawK+12Xy1nOK?=
 =?us-ascii?Q?j/OPbHzqqFOuo+VDtV+nroWhCLI5rbTo7/srLPkKdUj5aSq613dm6f+H13qD?=
 =?us-ascii?Q?ZZ9LIP7i80pfXNz8GmksQ/YQvPF7o15rvjJ4nt/Ib9vVA9OpGx9YgdZRe50P?=
 =?us-ascii?Q?ED0oYQp8SOsj2ACjCogQX2hO/tZdXNxCGj8D4+dAOaQrget78B8KbcKvU2BF?=
 =?us-ascii?Q?GhoiBKL9w3Feg+eV9Y3+uM5RzeGZ5qHH2MSciQ0CW9gC37SK/gwmJ4ps9RXL?=
 =?us-ascii?Q?lJ3gwSffApeCRGwpTmA9rR1UyvPr0e4ktDrnk7BftQtUuqJzAlyiLXJoxcmW?=
 =?us-ascii?Q?uEWpNG/Px+vDbAd0RwqBQBleF8OiOaqORVTLl2pqLsZ/ubKLr/lgvCt+f7LF?=
 =?us-ascii?Q?MCffL4vYrPtoldgAfWb1xMmMadRMedFKGby2CKkJfUAjspFkAq3JGBNSP17R?=
 =?us-ascii?Q?uzNxcUTCUjSdaLCXGVQocXUtKLjGhniBPuAQX8ehJSG8vI+pvjdvGmE7cqFF?=
 =?us-ascii?Q?1As7ST11W7WhHuJqPpLZdeCTl8AYlz1z+lSKoxewFrGDe05TsZl8RE13fv84?=
 =?us-ascii?Q?DhDTMS9yktIKHVSN1+D6LM/j94Ys+MIGB4vxE8JLzbQzPJF6Ao9o9lQIr+ku?=
 =?us-ascii?Q?5R7+7B/uzKJBTosD5A7mkYhjIbfmjyAAtkzFIBc926eAzFiOn5TkW1RZYdtx?=
 =?us-ascii?Q?DAbWGKlv6TirWp9ByLecWBeTQFAmDNCE0Zb8X4lYfr6C4ufDqb/M0J7go6fU?=
 =?us-ascii?Q?cfM+nw2uDaphsass+1M5iTS4Bau8s8lo/nDOHvXixsIFF8C8hzWa6APxqFLF?=
 =?us-ascii?Q?YCY+xueqqTjXKPwCyVNi3DGFPtF763n5Lm1y4obaw0Xse5WLQjRcu4uSDmi6?=
 =?us-ascii?Q?vrtNF+uE+aitmP0+w6QFxH9nGjc6hGvagt9SEd5ytb4fkDiyVx0obBlGljiK?=
 =?us-ascii?Q?+OB6xK21d/b9gKKFVT6OApj8qwO7tt+MTTTTrOv8TyK0wemD+lHtuHT6JZYw?=
 =?us-ascii?Q?ERUpLX4BjYYWHB6Kkb9HrSY+JvLBQ+oF1M1dhTWRi1mStokh2OQ4+be+f7+Z?=
 =?us-ascii?Q?QK5/jawNEfPkAEwiEEOG15p/o3zxc8qNOWrNH+VPDAZe43FTVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:38.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8be93e-80fe-41cf-142e-08dc8e9b318c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

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


