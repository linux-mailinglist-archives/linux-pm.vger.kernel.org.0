Return-Path: <linux-pm+bounces-9001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB5904DC0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 10:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62505B21EBF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBA016C6BE;
	Wed, 12 Jun 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e3rG8H74"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AC2D052;
	Wed, 12 Jun 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180060; cv=fail; b=i6Nifz6BJJxwgRCaxjZancnznnkZSDfzt8BToZOd2DrGyPzGeRUf+fdf08ZURp9FcSG19aKgRxibsh0xn+4ghe38nXJpI75lSMxZILRBPPXTF9fvkuKd7d7YQR709rSLC8RD4fcLDrhZ8FC/EuPBhe0SsPsj6j7xqrx8fJCxF+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180060; c=relaxed/simple;
	bh=0s7S6PjGzVZlRCxhgaa8DGdVFyM06YHubit8nxeXA4I=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QxxkMnzwpmMCUW1Be3HcF25ogipVRCRvK2NWuoXi3Ct/iUEnhpZHyH1xPGfl3QvZgozRIvEk7pxNW8b5CVVzw9IsOFJqto9vorgy9V9vwhh+pduHiFsmiyyXNL+obkM7tl28dMmZmK4DsKKOhvP74YUCbeVGWIWMm33DsyQdJD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e3rG8H74; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql2oWsessVrSbM1TFcWypqIZUj9I8/xkVO9Mzb6XFXExIzT+dQ7WyrJ/Cg/h90jxIzD6M+bT+his/8RNCPVunl9KdXRiQXq7OkzR7RI1e/147XeEaAZQtrIeH78k5DeGpL91f7jf3wYIlckAGemlajG58mGH6VQSKtM+ZiDxE6QkTLEv8eeuV8H1h5Y8kR4gfTmrE+L0AlGsYHHSErxh3JYSQDj37OxzF7szDYWLECFr/dAVtvO1my8pThe3r1fEFCU8D3337njF1sBiYxAY4dvTE4OsX2EHxB2E5P89cxMNaItE3ovwn+wbB6BkumB68aH7uDOrQvxXF5DvwU/bIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOGShOJl5GiWOu/snp/rKZqkKFW+IfGZHjaLNsGU4EU=;
 b=UOIdqf+JWUyfsYLctZc9In6jeS1/rd+IP/Q6staJqZL/v3zytAHCnpTy6XCdH7oKlzsQfEyngu1fpEr0JBmhJp14Gsbb0YuNtNj84cNgH2fveXgTcetJIyQUYvD890G0su+lb1BNo6cL6zHLQWYhL0+CizSFHrHoaUl9a4wDNtTcfim3bGX6ActDshtZxFE5ZxFGEDi17HYhj2jZ2OHiIF+74uLYIRIOpn4zxX4THbj39+liEEED4lpBfiBE/jn0DV89V8VRkLJjyTzwYUCIdRHUULho1Nv4lwaAlp50YLeCaGDGx+iNZz6CuGq9ZO/7Z8Me6u6uSJj9JzTz0p/+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOGShOJl5GiWOu/snp/rKZqkKFW+IfGZHjaLNsGU4EU=;
 b=e3rG8H747iepGa8+v3mQrsQCVXFWhFzYOZIoGmaB2C3aPm6brh9RDtFB5em5ixpyFniDAkDMuMSlkQOXmln04Sl+jcrCQMkB1u0/8CvuhEZOKorjLk6rwfDBCTFWMzPVM/YVGzuhJPsO4+EOJ0pfMxR43rfbyOBX4NXyDUNLxO8=
Received: from SJ0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:a03:2ef::19)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 08:14:16 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8d) by SJ0PR03CA0194.outlook.office365.com
 (2603:10b6:a03:2ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Wed, 12 Jun 2024 08:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 08:14:15 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 03:14:11 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>, <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Ray.Huang@amd.com>, <Borislav.Petkov@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] cpufreq: amd-pstate: switch boot_cpu_has() to
 cpu_feature_enabled()
In-Reply-To: <414f279ebed3b5862b28fe42e1e15c8325c47cbd.1718095377.git.perry.yuan@amd.com>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <414f279ebed3b5862b28fe42e1e15c8325c47cbd.1718095377.git.perry.yuan@amd.com>
Date: Wed, 12 Jun 2024 13:44:08 +0530
Message-ID: <87frtizigf.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be99799-edf5-42e8-15ee-08dc8ab7a6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|1800799016|82310400018|376006|36860700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQu990DOk/wKGHoPWjVWVUO+5j0JI99G/zzERhnLDk80CuUzl6lH5VytG8eC?=
 =?us-ascii?Q?FtfS6OvU7aMUEZPB9HOukahRpBcNRB/C+0x2CJD60ydxwlSFliWzRViTOB13?=
 =?us-ascii?Q?RFd97qaF4nH1Kqv1p7HrM4TYTN+r//YZjv1WQqz1hg10T/D0yimM2GooOfPh?=
 =?us-ascii?Q?OHUOJs3O7MHPPqEpFaErOylqSGeDWW2KsLbgO3222p0yb5+gTtsy7d8PHbwa?=
 =?us-ascii?Q?QTP3e/6alETTETeKtYwFVc20ROk5k21czluriZppkIzkKkxTjJWnQUWea9My?=
 =?us-ascii?Q?1X938D0gpfnWJeW7N132NeRSsp2/IN1N303q1ElInhm+jf+Yol73vwQxXIQ6?=
 =?us-ascii?Q?gqPHQhNf1uzvuOVBKpeK07SxR1JVwmXqeDjMPs14R5iAEKz8HcHeUIe6fCL3?=
 =?us-ascii?Q?pCBQYuf1qrWrJ46l28pzt0eM5Q1BF/1bJy1svHdbytd9BmkVjTIwDyESAXY0?=
 =?us-ascii?Q?6uYoZP3dUB7FqbzIwnQYtNtuMJcg4A16F5UfqzPloge/bG6jWmTioyqHRElj?=
 =?us-ascii?Q?d+zHUVbhVFSrbbnUA/wtLg14fSWUhbrm1/GXUOnbkgk5T/nrhUt53U2A564c?=
 =?us-ascii?Q?DdrUINf6Mctp5icMDq2Sk4BF6ekEQ/K1FVzILs2JBwbDwVc2G6g6YXKBixxJ?=
 =?us-ascii?Q?18GE4mb2HWeWELCJqDigp1/LOJ5h0/70PCfK6iJZvxKdhEJIq6WiFTtbB/JL?=
 =?us-ascii?Q?KYEre/2dMkFI61c2rXbKDoJYLettVFN2+n0HB4vGJWEaFMuHe9YWia/UEL1t?=
 =?us-ascii?Q?rZ31s643wNqRANenB+BD7P9IQyLMc56AeVZPyYuvjl8Pyi4q+ONawxzLeDBC?=
 =?us-ascii?Q?bp3FdbV0rwXG3xiD05CwAnsaLrCUpG50coshOpZmhOkojuo3I/2MtLjoiEe9?=
 =?us-ascii?Q?IVQMx97XgbNLf9tGJEv6Uj3EnCNOr8H/sLAIoHL3S+hHk9ZsncjUoORQBdXr?=
 =?us-ascii?Q?rdosNxbWiScIJZ6tozeUKU3wSSyTtCjxSz5idjzmk4V46oLtM+R0HVPX0618?=
 =?us-ascii?Q?PPEYxp3WmXXn5fXack+Gfqc4S4Vwl6gvff19aw99eXZbzCTexwJo6egNvwK7?=
 =?us-ascii?Q?L4qYdfFTsNCZmhv7fILCfbSCEu699Am2QvOg4HsPUk0nwpnp0z4QzPlLBH8Z?=
 =?us-ascii?Q?xAP3P1B0lfDnr4U5GJbE4Nm5htC1Oxgh13CKWEVyJ/SkAmE6u7x8pYrP+/Pc?=
 =?us-ascii?Q?kknjjbeaK2Be0cjwrZMMOTr4VLZrKS8X6ISp989N5fG5RhrtqtuX3nVRKotz?=
 =?us-ascii?Q?w+Y0oYAmB+IJCHMj12q7XOfFYLoTmIZBQDcqc69v0H4R15sV0OSATKCIVta9?=
 =?us-ascii?Q?VRHltxlxZeUTQ15yLhHGGDxeThilUOxQGYE+Rb7T5ns75UbD7LJ1wQvYakQj?=
 =?us-ascii?Q?KlmPPWy6K0YAvDrtcmDLD/GNj/hBvftZV0MTOkijP7J4rg4OQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(1800799016)(82310400018)(376006)(36860700005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:14:15.8018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be99799-edf5-42e8-15ee-08dc8ab7a6c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691

Perry Yuan <perry.yuan@amd.com> writes:

> replace the usage of the deprecated boot_cpu_has() function with
> the modern cpu_feature_enabled() function. The switch to cpu_feature_enabled()
> ensures compatibility with the latest CPU feature detection mechanisms and
> improves code maintainability.
>
> Acked-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> ---
>  drivers/cpufreq/amd-pstate.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6b9fc24001f2..cb59de71b6ee 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -157,7 +157,7 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>  	 * broken BIOS lack of nominal_freq and lowest_freq capabilities
>  	 * definition in ACPI tables
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_ZEN2)) {
> +	if (cpu_feature_enabled(X86_FEATURE_ZEN2)) {
>  		quirks = dmi->driver_data;
>  		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
>  		return 1;
> @@ -199,7 +199,7 @@ static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
>  	u64 epp;
>  	int ret;
>  
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		if (!cppc_req_cached) {
>  			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>  					&cppc_req_cached);
> @@ -252,7 +252,7 @@ static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  	int ret;
>  	struct cppc_perf_ctrls perf_ctrls;
>  
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		u64 value = READ_ONCE(cpudata->cppc_req_cached);
>  
>  		value &= ~GENMASK_ULL(31, 24);
> @@ -753,7 +753,7 @@ static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf)
>  {
>  	int ret;
>  
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		u64 cap1;
>  
>  		ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
> @@ -988,7 +988,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> -	if (boot_cpu_has(X86_FEATURE_CPPC))
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC))
>  		policy->fast_switch_possible = true;
>  
>  	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> @@ -1221,7 +1221,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
>  
>  	cppc_state = mode;
>  
> -	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
>  		return 0;
>  
>  	for_each_present_cpu(cpu) {
> @@ -1450,7 +1450,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	else
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>  
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
>  		if (ret)
>  			return ret;
> @@ -1540,7 +1540,7 @@ static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  		epp = 0;
>  
>  	/* Set initial EPP value */
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		value &= ~GENMASK_ULL(31, 24);
>  		value |= (u64)epp << 24;
>  	}
> @@ -1579,7 +1579,7 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  	value = READ_ONCE(cpudata->cppc_req_cached);
>  	max_perf = READ_ONCE(cpudata->highest_perf);
>  
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>  	} else {
>  		perf_ctrls.max_perf = max_perf;
> @@ -1613,7 +1613,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
>  	value = READ_ONCE(cpudata->cppc_req_cached);
>  
>  	mutex_lock(&amd_pstate_limits_lock);
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
>  
>  		/* Set max perf same as min perf */
> @@ -1815,7 +1815,7 @@ static int __init amd_pstate_init(void)
>  		 */
>  		if (amd_pstate_acpi_pm_profile_undefined() ||
>  		    amd_pstate_acpi_pm_profile_server() ||
> -		    !boot_cpu_has(X86_FEATURE_CPPC)) {
> +		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  			pr_info("driver load is disabled, boot with specific mode to enable this\n");
>  			return -ENODEV;
>  		}
> @@ -1834,7 +1834,7 @@ static int __init amd_pstate_init(void)
>  	}
>  
>  	/* capability check */
> -	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
>  		if (cppc_state != AMD_PSTATE_ACTIVE)
>  			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> -- 
> 2.34.1

