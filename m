Return-Path: <linux-pm+bounces-9940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFDA9166B0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D1AB243CE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D84114AD24;
	Tue, 25 Jun 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HlWU8BW6"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A214C59B
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316523; cv=fail; b=UWYgp+eB1yF8Iw6SjVWAdcmR+xBqy5JvHz8yq7ESYf7/uRp8p+G0aBawgDNBiM0zfi3N7nLWs/en4dXuFP0nIrNjgODeK8wBhZkFSBOfbBLrL5yIezB4aJCs0pkKwviGpI1xeHlR+vkmo/1aAmmPXCKgaNFi/rNiKNUwRgs7F6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316523; c=relaxed/simple;
	bh=9yQSXMEIZJp3YX1nQB8fe/gc5RvwZkKwDqevK0Ns09c=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NMFGKN5JOPgqcEptzHsqkyEhsN6munqkicf0J2c1jt0eKY92MPTVIiyKSlmGiGenqqw+ONAVrfM8VW9CM3LVeRgpIZvBWXcRNxtdcsDFcbehHIyPpDd9QCh9cmOOfLlF5KDd9QH15Y4gMF3W26wK4hSiA+nTHsaYl6EBe/3na2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HlWU8BW6; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdBajRX/qjsTqrB/tD/cASsPrH84ySKXvF0ADt9RQ91BA5GBdrzlLQz2tilyFcBBRTBh1RNuoM0DHGL8RWrdcv7w94j0/eKA+kkcd8nRWGXWEGq/GW81w3/GNYM9Cucw1tpWCJ/jhl2xJdGT5ciho+Nu6XJqymk8tJ3jTmGB4AQlKz9bvtItwUqWkjahqQqEAIGV+5LXzW3dbFckodrMP7YG39eGr4/cH6cZ9YZQieIxaOEXsJutjFS7cP+F4EgmpYEnxCi/hwU4RY04lhjXTWeVSwbM+lP+3VUiQBZnlQ4z8LrWgWwMH3fz/iDlzwjrAgAsjXrOPImeU9cVqW5yNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTFGLpOUPAhiKBf8WCIxBdVR2Aa0r4N4nhKxl+M9lfo=;
 b=XbrmhTotGR/PolaIEw+jsOUsIXVgmjbhu8aW+OrsZo1oLWqtS+E4swyh8kEXa4D4GNz134T97qXYwx92e3alosaQpGCS6MH/SVjn6GZKxR3xtyZufiSFunfYbjfHhhg3As/4F8L8rL3MwnaAxZ+uYrnZvqLs3jPABZh899lxKn0FEUxMBsoLFeYF2xXw//n/rlY8LbxpRiPGF9NwTuvToIw8RzJvw4RRTs9StMvkRxLoNGMueM3fOw1zgqRe1ALIL4X965/t7bZr0U67Bt8Rvd6Gt7xdPBTzE2aKIVyVCvwmEu/A1PfBB45agyiiPEl6enfUsR3Hx+OnnXeo/xjrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTFGLpOUPAhiKBf8WCIxBdVR2Aa0r4N4nhKxl+M9lfo=;
 b=HlWU8BW6FGTWrKTcJCFhW76NfhOLSxILM5ndTZGc/gpFkGWg3FWOA9nI5KsrNNuSS7+ea5SGK8ZGCiegvy8jhNntcXRPNpRAV4dlxoiPKU8fEEXPBANXVkcZYTimKXEFXpHuInqUc9Azc+0xUXiIBfUEu6Jsz9iYoX465qWqjpg=
Received: from MN2PR13CA0028.namprd13.prod.outlook.com (2603:10b6:208:160::41)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 11:55:18 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::96) by MN2PR13CA0028.outlook.office365.com
 (2603:10b6:208:160::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Tue, 25 Jun 2024 11:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 11:55:18 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 06:55:12 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, <perry.yuan@amd.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Sibi Sankar <quic_sibis@quicinc.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
In-Reply-To: <20240624213400.67773-6-mario.limonciello@amd.com>
References: <20240624213400.67773-1-mario.limonciello@amd.com>
 <20240624213400.67773-6-mario.limonciello@amd.com>
Date: Tue, 25 Jun 2024 17:25:05 +0530
Message-ID: <877ced2q5i.fsf@BLR-5CG11610CF.amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 91638868-b0d2-40f8-18d7-08dc950daf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yt7ZBBoc8mU8wqyq6rIYeggo7IzzW33t468xAMeCFfiYtyoCD+Xy5LI0AAa6?=
 =?us-ascii?Q?BKVSZQvrIoXczvsYdcaZMdErQvPMCOYo7726QP6a7XM635pZ1c07/atpn2TC?=
 =?us-ascii?Q?LVh5PlL31x84nIJqajhJxFLDljc6/SOPl2NGyFs6u/hlxc+05/owuKgglqEV?=
 =?us-ascii?Q?9AjVRQqRUcyAIt6+PbUDnn3C4fyBWuhx6CRhNzkki5XiPkhVGZgQwm9m4CGH?=
 =?us-ascii?Q?pf8cbIwMjXWjE0ogtvm2uRnPH7llNu4u3g7zNmkyJeIEWzQ7tK+0vhyI3p6g?=
 =?us-ascii?Q?YJpME57SiJwztfTDBw2c5DCBKqXU6yPPcFmTZRvhU5jQMHB5L9X5vKsshkdK?=
 =?us-ascii?Q?DCoUdkw2gQ/M36ywlQI0lHKhQlkRU1WSITQxaG3/HgzqLIX1pmyAOURC2N/G?=
 =?us-ascii?Q?itHwjGg57VHrfkuKBlkxeh/53jWwmIsIfY06yB5LXt88gC7ApXJfx3rEhd0A?=
 =?us-ascii?Q?zUydWFmk6bolra0CqtCAV3IKSyGe4fkSu11i7gi9q25jTvEzhXpBVWuP61nc?=
 =?us-ascii?Q?RVPs+TNQ6NntfTjXFvyShNyaMZP8qv8xXe5Po261JUY4Yfi5rD6mN1LSb6R7?=
 =?us-ascii?Q?MuU15g6i0PUhcOOCRcst4No6xNjuB2XcmT2mxwQUfgr1sQH5mkzGwmC90/5I?=
 =?us-ascii?Q?gY1+R9Q2j2WcufEa0TIS17QUi1MQjvVpmvtO2QGjXEfKiGY5mhR7nnLMnK9P?=
 =?us-ascii?Q?We26f9b3T44lChAZSJmzslxMU6cg5GxtjfHseYT7FZty01iF1+mCQ/5VuiM9?=
 =?us-ascii?Q?Xw4U9NK/d/615/INy6eswRwjyKkx4laWAMHr4PlsxAD+ji3d5BGCiCTBgwOH?=
 =?us-ascii?Q?mWcZTaYBxwnnM+qIO94SB6dg06yhdy8YhqhOaX8gOCAquVdFVSlvkRtPpUl7?=
 =?us-ascii?Q?+z1s7VMBmQnlS95CXxYp3sn+eKUiSbnCvkhgNcc9M78fh75m6tCbAf3rS0PN?=
 =?us-ascii?Q?z++W0ITynd2GD7i1oxoZ+qq0TbET/pKXIrQRAMwGucCaKkPOrNnHqpblLvfX?=
 =?us-ascii?Q?A2tlWpcFXHxVKShbUHfCDec/8Ugf6kxMcdZkwyOolQgIMdd2Sj2vIas8Lwnm?=
 =?us-ascii?Q?jOtrq/U3pHgws+qPb7EpBIrseB6wuioTXEZ9CqXqAzBcEQEqXjQYgII+/QzN?=
 =?us-ascii?Q?3R0pF2sAAkQHuheesiDaUCI0jkkSTTwDp33chrAc6CtB2G0EvbDzMj8qDUbf?=
 =?us-ascii?Q?AScOM0WFLvXxLLLp7YlCJodFXnjmaC5hciu0FSHId6izlCtYh8iI0Q0Q7bVE?=
 =?us-ascii?Q?Hvf1OWdNXaUvct7YhH0bHnStyS8sZKd38ulJkseYofZYrrTpf7Jlc2NoQqd8?=
 =?us-ascii?Q?Z9qrmwIngU+m0BIgpg4gVcZ+fVpcC/NZxnOTHr2PyUUAxRISoFc2Aa1j+qe6?=
 =?us-ascii?Q?bd2QozvysdS+iMcQIkTzPdOeyouC871kml6rqbK03OothFy2QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:55:18.4730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91638868-b0d2-40f8-18d7-08dc950daf2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541


Hello Mario,

Mario Limonciello <mario.limonciello@amd.com> writes:

> The behavior introduced in commit f37a4d6b4a2c ("cpufreq: Fix per-policy
> boost behavior on SoCs using cpufreq_boost_set_sw()") sets up the boost
> policy incorrectly when boost has been enabled by the platform firmware
> initially even if a driver sets the policy up.
>
> This is because there are no discrete entries in the frequency table.
> Update that code to only run when a frequency table is present.

Thanks for this fix.


There are also drivers such as acpi-cpufreq which have a frequency
table, but the boost Pstates are not advertised. Thus none of the table
entries have CPUFREQ_BOOST_FREQ set.


>
> Fixes: f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on SoCs using cpufreq_boost_set_sw()")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Yipeng Zou <zouyipeng@huawei.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1fdabb660231..32c119614710 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1430,7 +1430,8 @@ static int cpufreq_online(unsigned int cpu)
>  		}
>  
>  		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> -		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +		if (policy->freq_table)
> +			policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
>  
>  		/*
>  		 * The initialization has succeeded and the policy is
>  		online.


How about something like the following:

---

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 37f1cdf46d29..be5f4d3e9c1d 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -140,6 +140,7 @@ static int set_boost(struct cpufreq_policy *policy, int val)
        pr_debug("CPU %*pbl: Core Boosting %s.\n",
                 cpumask_pr_args(policy->cpus), str_enabled_disabled(val));
 
+       policy->boost_enabled = val;
        return 0;
 }
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 10e80d912b8d..f604389b9cd6 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -18,6 +18,10 @@ bool policy_has_boost_freq(struct cpufreq_policy *policy)
 {
        struct cpufreq_frequency_table *pos, *table = policy->freq_table;
 
+       /* The driver has explicitly advertised the boost-capabilities */
+       if (policy->boost_enabled)
+               return true;
+
        if (!table)
                return false;
 



> -- 
> 2.43.0

