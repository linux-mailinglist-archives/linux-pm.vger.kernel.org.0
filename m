Return-Path: <linux-pm+bounces-10008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D914917774
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61691F21D75
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16913A405;
	Wed, 26 Jun 2024 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s+a0hQga"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D960F4FB
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376619; cv=fail; b=BqAMxh3Ju9mMvRzkpeTSvUpdk4QkTbrc0nlSq6O8mSlATU9wWvc5yyO+Q4vz853T1NkzFsAdfjVjCxw5pgQqYvOF+6MX6oy7spBK84P1D4yuyJrZHqioDt4G5PVJ9RqPDCaLDh8VeyY4iKV4Kiwll+Wc3GNwVqgfiWqhu+9qNB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376619; c=relaxed/simple;
	bh=EtlHeOXddnaPm7+KDbEAfIkew6WeI0OHgdi8XvoSvSQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dj+0ldW1CWZm2icbkrK8tMml/WQfnYcu5XsJQibT9hEQpntGjFrzxTDQE/8FU74aR8niWQ2I05K0upXbjAJ1FtY+f76IdiqAvy+eK6MlGYMARm1xII/OE9QU3mYjo00F4MAh0FDNMSxXdmS2XYF9hTzUNP1vZJhhmGSBRC4l4LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s+a0hQga; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJi9NmxStSh4h3VMQx/Axpf+udcRHdnlN7B3mq/p7tAUEW00QkH0mjx0q18ZQIPzn9a1sLFggZ1wJQmNl6MIftFQkaZv6V8zO7WZvceXCRevzHdRAhvvjRc2P55KAG3Dg7abNQDqbyrfbsFgxktI/EeUMQpw08acfmImF56WymelyokRiaSn9jFKN8nZqSohsQkW8DDvoaL0kF/P9mJSidgXQdMGab6jtk96qvu5FSX++mix7sBsJq+M/gtcjz+pmDJ7RyxaiB2EMYHts6i4/C6qt0wH4mDHEdW8C2oljsA7aqsuh6+w8nH/jxQvG949OlotajZ9JF3VX5sJ4Bl4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3lys2WEUNFEbm4NxtJrsfDfvPwh6kHnOqOtoetr9XI=;
 b=JRbsXF/qEQyWpSGSeLO14Z0jTWefD6nNijzucotzTyvVZq3HlqxmgQd5jVCoC0eK7TZGiiHTPpP5wJ4TQ3RIQJJQTaN+cXLV/ko6AvQZTacNn7AtmVHIfY/DC0bGK/piTnPfi0QAmf9hWkfuPyW5lEH29/zeyO4za0wstW7EI5nrZI307gx52A25S3qycut5v8zbAZ3DSg407hHRZxLKsK3Gcfq2mv9CsE1kExm4JX9w+nvuuEHQDhYExy3Y7s8zl52HLlO5eL8tNhpopgLdQghDq7mEXSOTnfRdekPHpgYrRbDwKWiC4tgOghmZHxkbkH6wwSIZwhTtzzIsAMlnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=natalenko.name smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3lys2WEUNFEbm4NxtJrsfDfvPwh6kHnOqOtoetr9XI=;
 b=s+a0hQga3pvD6CpQavlRvoe39YHpGMgdoHT79ZT6eFM9D/QdYIX05sOei1aPj9ZRr95Va7m3uKwF4rZ8W8asdz2b1MU0mUVB/VQl1Z9hUgCKkoFMD0PTVZOu5t+3xSC26tkDallA2kmUpLoQ2TLIEs1glEGFgkdVq5fqGQ4shT0=
Received: from BL1PR13CA0321.namprd13.prod.outlook.com (2603:10b6:208:2c1::26)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 04:36:54 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::23) by BL1PR13CA0321.outlook.office365.com
 (2603:10b6:208:2c1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 04:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Wed, 26 Jun 2024 04:36:53 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 23:36:51 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: <linux-pm@vger.kernel.org>, Perry Yuan <Perry.Yuan@amd.com>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: Re: [PATCH v15 2/4] cpufreq: amd-pstate: initialize core precision
 boost state
In-Reply-To: <20240626042733.3747-3-mario.limonciello@amd.com>
References: <20240626042733.3747-1-mario.limonciello@amd.com>
 <20240626042733.3747-3-mario.limonciello@amd.com>
Date: Wed, 26 Jun 2024 10:06:45 +0530
Message-ID: <87pls448wy.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a8b9fc-d82a-4ba0-18c1-08dc95999ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?diCn/EKJpcI/10UQVgXZGA0w3xO/irdJ1JJyI41HN29XFkNKww3pQ4LGr83q?=
 =?us-ascii?Q?yVPjdNpxpI13yb+lvqSHgnOf1RGO66lmq8IPBkDqXtJ1ydOKHVWDDm7h5cT8?=
 =?us-ascii?Q?O33mR9LUtfvXevqD68tzt07opmz8BaktDYj5OCB920cImABNd2BBEGRc23Te?=
 =?us-ascii?Q?x8Li7H3o+z2eybB0kgyIL4x0rR8/T5p0pwd9mSqu2PkgjLqw6f9BoB+b4ofV?=
 =?us-ascii?Q?OfnSSc/6dJ2wSyWUQfIKUgUzj+PYqBvKfBBju8Nbrd9aLNg+DXa2+cas+rw0?=
 =?us-ascii?Q?kuAR6VDOFk6aGaL0oTEZEELBOAPadBc+oRC4AaMKA2HYakujq4vtjUmPBSmx?=
 =?us-ascii?Q?GenSi5C2mu+W8UlOH8g6OP9mYYISvEl2Gxw3aV4sfcMWQZuY721H2rkwZcD4?=
 =?us-ascii?Q?IAp7TD5WF5j1LJQA01cr3cLXmXZckD0YC6BdE5f84vUcNU21szVW6pPNChSL?=
 =?us-ascii?Q?oPcTZMTvmCrowvj/1qHYYuvn8ckhKzdvht60DXfo4zXHvCJQQJJAwxx9ICzA?=
 =?us-ascii?Q?m/FIBY9yKjoXK2b1sXUrYL/IVy3JYIbj5J6dsvoGojwF6fxHHwal2aILIrtU?=
 =?us-ascii?Q?4j2J0lHEBbuN4eeAImRKqQH/AHdwGsWTEzbHv9vmSOGhXWUjxvfrC7VsIdhb?=
 =?us-ascii?Q?QW8xqbMQjaQ7+00W8iZSUER0nN1Ig0pLua3G/hb2MiR7d+e8mhrrt4lRghWY?=
 =?us-ascii?Q?gOTP81qhBd8CIF79xsgiidFkAB/Cv2x+Ez/3V7DyQELMIUNv8zTyS84acT7q?=
 =?us-ascii?Q?tbXHrEh7SHggNB6ZSHAtwgMDMQk5/2k5gPOZ5gq5oERcttjbMPpuvqSqYT0d?=
 =?us-ascii?Q?WqFXV+0vQOhdxfm3aH8/ikiFezstDyEuGiavq+woEeWx51poszzCrHzs1oX5?=
 =?us-ascii?Q?dhsFIdEXeEGZNEZ9ySbnDKOrhUIxhcaWUVdnRttYpqK1lvWh7Ca7VNlnskTh?=
 =?us-ascii?Q?MUiVsyn9Maluru2+5Ky5jWaD4EqhSHl0aIGMfjyTIMEF20XuHrYY5EKKi84c?=
 =?us-ascii?Q?Zr83iAxdprpe5FbI8MhlKp0rF8rjP+zdD2dFqDvRXgyh1pUgEttHXBSarJWv?=
 =?us-ascii?Q?lIR8FV31XdXUxyEtwCnd/5Ukzxh79EV4SBIzu08E0fjbRoucVJFcSzuHY6ae?=
 =?us-ascii?Q?nWHfXpZoH0CXDBK6yrE0vG4LG/hbgZqgzFT0269KGaEoGj1aB28Zrb4aB6K0?=
 =?us-ascii?Q?SPNNs3oQ/xu1PEAD7NPB73xr66ZIXSEVV3SX1Is9ka4Dd+QzndE8RIc6sbeb?=
 =?us-ascii?Q?3fvzNHBNduBeY8DkrJycDwHSjmNVnYBRXM3OAobYp+m/fTSn/Y3AuM8bNQ1d?=
 =?us-ascii?Q?IL9XVxZitt07IFKxBd9xK7iTKFEgKrT3ZcopTZ8DHDaixYzTt7PdCGOXnJpZ?=
 =?us-ascii?Q?CXCl/Mo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 04:36:53.9964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a8b9fc-d82a-4ba0-18c1-08dc95999ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

Mario Limonciello <mario.limonciello@amd.com> writes:

> From: Perry Yuan <Perry.Yuan@amd.com>
>
> The "Core Performance Boost (CPB) feature, when enabled in the BIOS,
> allows the OS to control the highest performance for each individual
> core. The active, passive and the guided modes of the amd-pstate driver
> do support controlling the core frequency boost when this BIOS feature
> is enabled. Additionally, the amd-pstate driver provides a sysfs
> interface allowing the user to activate/deactivate this core performance
> boost feature at runtime.
>
> Add support for the set_boost callback in the active mode driver to
> enable boost control via the cpufreq core. This ensures a consistent
> boost control interface across all pstate modes, including passive
> mode, guided mode, and active mode.
>
> With this addition, all three pstate modes can support the same boost
> control interface with unique interface and global CPB control. Each
> CPU also supports individual boost control, allowing global CPB to
> change all cores' boost states simultaneously. Specific CPUs can
> update their boost states separately, ensuring all cores' boost
> states are synchronized.
>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v14->v15:
>  * When turning off boost only reset frequency if it's set above
>    nominal frequency


Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 117 ++++++++++++++++++++++++++++-------
>  drivers/cpufreq/amd-pstate.h |   1 +
>  2 files changed, 96 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index afcf398574f6..db4fbd8d1e06 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -679,43 +679,105 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	cpufreq_cpu_put(policy);
>  }
>  
> -static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
> +static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
>  	int ret;
>  
> -	if (!cpudata->boost_supported) {
> -		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> -		return -EINVAL;
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(7, 0);
> +		value |= on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +		if (ret) {
> +			cpufreq_cpu_release(policy);
> +			pr_debug("Failed to set max perf on CPU:%d. ret:%d\n",
> +				cpudata->cpu, ret);
> +			return ret;
> +		}
>  	}
>  
> -	if (state)
> -		policy->cpuinfo.max_freq = cpudata->max_freq;
> -	else
> -		policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
> +	if (on)
> +		policy->cpuinfo.max_freq = max_freq;
> +	else if (policy->cpuinfo.max_freq > nominal_freq * 1000)
> +		policy->cpuinfo.max_freq = nominal_freq * 1000;
>  
>  	policy->max = policy->cpuinfo.max_freq;
>  
> -	ret = freq_qos_update_request(&cpudata->req[1],
> -				      policy->cpuinfo.max_freq);
> -	if (ret < 0)
> -		return ret;
> +	if (cppc_state == AMD_PSTATE_PASSIVE) {
> +		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
> +		if (ret < 0)
> +			pr_debug("Failed to update freq constraint: CPU%d\n", cpudata->cpu);
> +	}
>  
> -	return 0;
> +	return ret < 0 ? ret : 0;
>  }
>  
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  {
> -	u32 highest_perf, nominal_perf;
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
>  
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	if (!cpudata->boost_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EOPNOTSUPP;
> +	}
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_cpu_boost_update(policy, state);
> +	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
> +	policy->boost_enabled = !ret ? state : false;
> +	refresh_frequency_limits(policy);
> +	mutex_unlock(&amd_pstate_driver_lock);
>  
> -	if (highest_perf <= nominal_perf)
> -		return;
> +	return ret;
> +}
>  
> -	cpudata->boost_supported = true;
> +static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
> +{
> +	u64 boost_val;
> +	int ret = -1;
> +
> +	/*
> +	 * If platform has no CPB support or disable it, initialize current driver
> +	 * boost_enabled state to be false, it is not an error for cpufreq core to handle.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_CPB)) {
> +		pr_debug_once("Boost CPB capabilities not present in the processor\n");
> +		ret = 0;
> +		goto exit_err;
> +	}
> +
> +	/* at least one CPU supports CPB, even if others fail later on to set up */
>  	current_pstate_driver->boost_enabled = true;
> +
> +	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
> +		ret = -EIO;
> +		goto exit_err;
> +	}
> +
> +	if (!(boost_val & MSR_K7_HWCR_CPB_DIS))
> +		cpudata->boost_supported = true;
> +
> +	return 0;
> +
> +exit_err:
> +	cpudata->boost_supported = false;
> +	return ret;
>  }
>  
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -968,6 +1030,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	ret = amd_pstate_init_boost_support(cpudata);
> +	if (ret)
> +		goto free_cpudata1;
> +
>  	min_freq = READ_ONCE(cpudata->min_freq);
>  	max_freq = READ_ONCE(cpudata->max_freq);
>  
> @@ -980,6 +1046,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.min_freq = min_freq;
>  	policy->cpuinfo.max_freq = max_freq;
>  
> +	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
> +
>  	/* It will be updated by governor */
>  	policy->cur = policy->cpuinfo.min_freq;
>  
> @@ -1005,7 +1073,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->driver_data = cpudata;
>  
> -	amd_pstate_boost_init(cpudata);
>  	if (!current_pstate_driver->adjust_perf)
>  		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  
> @@ -1420,6 +1487,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto free_cpudata1;
>  
> +	ret = amd_pstate_init_boost_support(cpudata);
> +	if (ret)
> +		goto free_cpudata1;
> +
>  	min_freq = READ_ONCE(cpudata->min_freq);
>  	max_freq = READ_ONCE(cpudata->max_freq);
>  
> @@ -1435,6 +1506,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	policy->min = policy->cpuinfo.min_freq;
>  	policy->max = policy->cpuinfo.max_freq;
>  
> +	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
> +
>  	/*
>  	 * Set the policy to provide a valid fallback value in case
>  	 * the default cpufreq governor is neither powersave nor performance.
> @@ -1456,7 +1529,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
> -	amd_pstate_boost_init(cpudata);
>  
>  	return 0;
>  
> @@ -1718,6 +1790,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>  	.suspend	= amd_pstate_epp_suspend,
>  	.resume		= amd_pstate_epp_resume,
>  	.update_limits	= amd_pstate_update_limits,
> +	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate-epp",
>  	.attr		= amd_pstate_epp_attr,
>  };
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index f80b33fa5d43..cc8bb2bc325a 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -100,6 +100,7 @@ struct amd_cpudata {
>  	u64	cppc_cap1_cached;
>  	bool	suspended;
>  	s16	epp_default;
> +	bool	boost_state;
>  };
>  
>  #endif /* _LINUX_AMD_PSTATE_H */
> -- 
> 2.43.0

