Return-Path: <linux-pm+bounces-18802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4029E9011
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBEC2813AB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D92216611;
	Mon,  9 Dec 2024 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hkcOiLzB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8652165EE;
	Mon,  9 Dec 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739904; cv=fail; b=UUDAVwvffCXZg9R6Z99++MoYa0fn6hO7K8W+1K6MjIIYy2MlsbEcHui4UTfhgFETkiAioHbDvCXJ6blUYOYQjsoyMTCAN7Hmk/J5ARgENzO+gpJDOFSEE2CJj3SeQLKIlqMbfPzJbPU9wBCP7j0G8g7scTxXUfbuwOm2UaY/N/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739904; c=relaxed/simple;
	bh=9XxiKw3j5XfOBNXpguDxjhzEUVWyGM1x8XGQDnDlCrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kT2yA3TYmsCdrR2L4FO1HWJPVSTYt0Ua+9ibzRayzz3WLxHjQPfgV/Rxu1Ldf5fna3P05u0zmB/jUkL7AUreOpufl8GWGxotkWUwd0hKh0nwAiHQKOOBdL5CxaVPmrt5FNtfyqgGDOGJW52vBby12fR/873VnBYn4ZTbJ66g2YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hkcOiLzB; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQvlRP4iW9kByw3Ci7b+t+Ahst4lmLFb0qOM52y4SeGbAImwjc3RZJGIoVPkep4O2QksjB8ehCaQUNcHzaPhCjAEp24Q5i3LR+zIa5L264vGlFGSjOGusPqjPsE05pwhkNAh0e7p6b6Bx2kOo4DxUGtB1KfptRISfHgyskblxmuBScTtXS7tGIuQtDi2YDsEraghU7Kpn9vXF2hJYlnz3KX0bxVv5UssVap5TRMjWjf78fFAnY4R4syx6N6muvdPUIzFGU8J4VQC5Oct+ny8BVHHPKKwDWB8H0Atd8BWTWRRkq9EzdIn9VNs0ZlFbx9BwAXPj71NCMmUX4tRXov3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nyJWe88IV9e7chT0r9nzh71trX/vQgu7nUImJ1XAsI=;
 b=cFfxyydLXoFXlDZEy1pGnizDmHkHV5H1SdWwDYblnJFyVNY1gga/oKCdiuGyVfvUbPIBmma3CeZtYGS57IMpGzDAARYgFb0q7lfVI3/Ff/BOFyTdQl8Gmq230NCHjjHJCQAyqc4g2pdWQPo3Wcwbm5N5hjks+JFP54P+UL1plhEmizoPbzmxOkMPyZFVddjaGPLCzXOstCy9spGwj8YDytpxwNy83t6vY1YS0/pBiuHK4xGm578Rz7SQ67IZ6i/CMEhSO/HOFalVB3XycrfW2QjRRj8rR0w7iXxQO2RrIFw/Orh8Zx7KDW2gSo/sWPyTf/7rZpuuCJO6aftvuHe3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nyJWe88IV9e7chT0r9nzh71trX/vQgu7nUImJ1XAsI=;
 b=hkcOiLzB4+PvI1vZ6+CpRskE8WFaUegKm3UlUQ4gQRRMaRZaV1MBY6WmOfc2KZTBimrHwBSsOyjg6EmpI5AW6I5qfFBUh186yNGdA44g/F7TL+hZ5bAF0ZIC23AlrMMjvQofOeZoXEMo5ThaHYr0nsgIQo9INQBU4r1x71Dxzz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 10:24:59 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 10:24:58 +0000
Date: Mon, 9 Dec 2024 15:54:50 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH v2 16/16] cpufreq/amd-pstate: Drop boost_state variable
Message-ID: <Z1bFcicdCUgVNCGw@BLRRASHENOY1.amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-17-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208063031.3113-17-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PEPF00000182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::52) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aeeace5-a994-4dd6-601b-08dd183bbaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xcLfN/6IaFmM9AHmAMWmxRPdsP9kpQbZHb8fHh6tlOWazM9ErWB0kc8XLeX9?=
 =?us-ascii?Q?zmRtETJ+ENYicK4k3teTYFavb8MwwOV+//rov5y+Km/cWNCSTyxkRgZ5Qd5u?=
 =?us-ascii?Q?uTjhUqzlek/8Xe1raW2qjrw5Hravr3iN7GFIC1Z6Wrmcmmjpt5k7dcER/UB0?=
 =?us-ascii?Q?ubaF5WTmqHW0E8Ban7Q8P7SqHwRp9tsbRL3lOAbPMVx7IFarr+FVSTpf/RVl?=
 =?us-ascii?Q?3HPl9mY4Qe7quqEccw3eL/7gawBRs5OZHGJO5JbO7Wa/w4Me3USMp1d4juhp?=
 =?us-ascii?Q?65uk2zSB0zr9sX7E+Dteg/6i58tb6gGOboev+N7g6Q97QQd9V2KgLACDYxzA?=
 =?us-ascii?Q?Haxxv5e2T6yUacQ05kd2ZyCJhNYvXGvAD0vdBodmSxyoHD2Rq4MgBS4+O940?=
 =?us-ascii?Q?/KzcjTlG2LGocK4rsUEw6BQQ45FX7tfgWC3CNV8L8KVtZ7ZMIPbmmhoALXGS?=
 =?us-ascii?Q?pRdz2kZ5xAJj925tmUjVtjdOlr8DUYaZ7RX7vYpXc572BCtuzwXcJt3Q9JDR?=
 =?us-ascii?Q?vc5oc4UHtXfGWoDgsRd1oJkVNM+fWwl/lFVNjXgKLkRfjoYbFDM7/Wedr9rP?=
 =?us-ascii?Q?mBA5jW7lru1PZ9xNaoPSl8LLC5qljwFBjtSnuuW2tbZsuG72ThWhHPBohQeO?=
 =?us-ascii?Q?wgU2TNKQIbaeGSaq40Q+JU4zgM1qIq+3qIAHioGKavStXW3mtddZofAxHOjZ?=
 =?us-ascii?Q?w0fdjApJ5MZI+FvPy4a/45GvBZkAQVF90wG5eK67gXnhPV+goLxLvPORL+Nh?=
 =?us-ascii?Q?LWjQayponG5hZtvm34dlBDpCkExc5P2lBGKiAGFgfogXXGjPK/UhHvGq2OMv?=
 =?us-ascii?Q?FOf3voU53Ihs/t5K7A0STnu2DcOxJu2owDxyWh0QCp/6nvdTFdymkOoh3HlZ?=
 =?us-ascii?Q?6Ceo6YGYHaOficgnbfztrxsRKFN8F1vkfTenbtUb0+3AO/d4hhnQB/RP2ZTy?=
 =?us-ascii?Q?vWrytZZoXNzoznfIhksygJkLDRehfy2qlX9yIQAgtu7xsqpyp8EI1pLJrVoT?=
 =?us-ascii?Q?DYWc1slQniX7RU2F43RM6RTub3wdTCcYoSGmREEcwZ1eu4mogSLX5eGvAPHu?=
 =?us-ascii?Q?OCU97agQdBmK3cxJzcuMCotu9zKKyFe+1nMaMC2XGudpneczuxfjY5A4x/ne?=
 =?us-ascii?Q?JQwIYJxFTII8siYUkufNy4GjnRoRCi7w+MXA5sMo154k7vNXCWYaU/9OfFuU?=
 =?us-ascii?Q?gfvQNCcTrg3Li9TRbweYzLOK0+wPQ+Qk3jCq6j9Yh9QC0G5oL2RcT7m57gMt?=
 =?us-ascii?Q?cW5Xh6uuE/wPw5zxHzJeQqX+0BZ072fHU0UB++ToOwCCBvNNzUDLSFTwLRD4?=
 =?us-ascii?Q?53oRXGRA+t27kiMo0hyAbE6ICRqw9qfJWUvZjAqCwHzxXOvtYwyyKzaWc/QR?=
 =?us-ascii?Q?6c7g5EA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ucMzcKhGG5bo9uKH21rvYJhJpQl/yu4aCoQu5e7+u6CNIRrIExnHR3wafYBj?=
 =?us-ascii?Q?+2bvKBo7LiDLKcrTIpnS+Io7iNPC6dD6oqLHwpsSQdvlMQyvMl2p8GEGBziM?=
 =?us-ascii?Q?LHeoIftfPnZRnfaIGVmsWdp6CTNZEk6uLZcHOtrFVKnmElCY0PIO2WSdpXts?=
 =?us-ascii?Q?y/ESoW7SJgtNW7TLqRB0zDlNnb5yu1MnIomnrB+9hh6Fu88bmnk5nK/EwjWx?=
 =?us-ascii?Q?jo6k6qR9PtxHimMUnsRBfuR0Ec/Cii8LpHmgwPyvNeAXEwHB5IFLGQRAX6Fg?=
 =?us-ascii?Q?Z619QIpu/TZrBewFrzL9l/9cSPc37LQl5LYFjKFhe7QcdaO0fwPguBcTKOj6?=
 =?us-ascii?Q?lkSDQjmA6UEs8aKkHl06oohSI4Qzo97B96E6/4jZGc9wC3R7+2HDlx6J4gQx?=
 =?us-ascii?Q?a1RpSf0JqzhRSNpwAoP9gvtgLShIyd3QoLDelUHC1W/uuLvy/8WFnV1Fstlq?=
 =?us-ascii?Q?+3G2XCII4cI5uZTivRTjhcKzzPdobsWGOy+4whjP29Cqr1UHofhHunK28RE9?=
 =?us-ascii?Q?ETY33Jy363bd4nncd3rA0h9VAFHplES1wPH3Pff4xBKNZAzzj6mlLIePHckI?=
 =?us-ascii?Q?hwEkUI+H0MeZaMgruMEb03fHG4gaAzuekxb8a4ooAdpesBUlUtXNQniU1Rr8?=
 =?us-ascii?Q?QBv8m348YvrNR0/j64uhvv2OC7AjLf6atSYwFLZ0+7XWTPyVeUdIQLpSzBhK?=
 =?us-ascii?Q?LxUkpMbwLkS/PkMPvE5sUj48uR+PF7yghqyoiWq8t4bNJ0AzC4qKG48hKaoB?=
 =?us-ascii?Q?Qmxg38W0PfVTYT9nwMlHb4xFb2g2f6d+1jEVc3qp5iD1ecT9yCCKEmJE78Ax?=
 =?us-ascii?Q?BsDP8osjZDIoDw2maAUNIMcyF5HmpEp+Bf/2i88H0bEUzYVXTYZMmzsaVIJO?=
 =?us-ascii?Q?Z+FWLcfnu3TNSVNGpXVnw34y4NsP8pbfMWWm54r1CMiiznPQc9j1UGka5/KJ?=
 =?us-ascii?Q?iI80bZz0bYhiMDLfqObqcH6tnAF0DlZYW1kFaxecj0CVAA2J8a63KsmelQbd?=
 =?us-ascii?Q?icNP2B9jj8hcdEjcpRHk+qLO3lfqVgNWLiflRQNtZysIVuSy4dp+EoM+A9K4?=
 =?us-ascii?Q?631sg1BnKn7iAFnIY+0FbPkrTkFSa6+3p4tJc9LVyTp+WAgb/LCoex1+HERN?=
 =?us-ascii?Q?xKgjeUamRIZYTOfN8vrBu5vHgBxWqPNsLq3Om0+gesi97jFZ3kLdCknDewAi?=
 =?us-ascii?Q?XXBGL6N2NyrmHszpNfPbotNdGNOmbiy1B28UPHpU8ZqrYChKw72yoe2qcDai?=
 =?us-ascii?Q?cQkdUCkA0rFEGVL8/i3zIqU6k2wN0xIa5zJAsJcGHK8VnSmaD+pQgZ1wPbL+?=
 =?us-ascii?Q?+s0QkqajQDnuqUL95oE5tPneJMEwEeaac/bp1ODcZ6NK+N/ZDNoKEjN1uYaK?=
 =?us-ascii?Q?HuH4/y6mtGQsxkM2iI1nEEhoD1TUT5lnk/Ip16aavifhhnVtI78HBm3c0ERY?=
 =?us-ascii?Q?8ah8iSmj01rcE0sNwKVNhrfMkh24SJBhqaqsGTXLkS/i2Qr1ZplB6l5lu7tX?=
 =?us-ascii?Q?zN5q/yyQ+wZPUlS7TtI1Rb8SAfDH8bX43PSuMgv20oClb5wMJDejjkWZfr+D?=
 =?us-ascii?Q?gn6ZQCORpg/8VKMOG/SH7R9Of8OXpGig3qK/vbbX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeeace5-a994-4dd6-601b-08dd183bbaf7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:24:58.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BTmOn/Llo6HmtDnRehU8BKfUUiKmuPAelyinQqS5k01eLbrGo12h9fF93uDbzIx7Nf/7i4LYLDgeH9yitmOIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694

Hello Mario,

On Sun, Dec 08, 2024 at 12:30:31AM -0600, Mario Limonciello wrote:
> Currently boost_state is cached for every processor in cpudata structure
> and driver boost state is set for every processor.
> 
> Both of these aren't necessary as the driver only needs to set once and
> the policy stores whether boost is enabled.
> 
> Move the driver boost setting to registration and adjust all references
> to cached value to pull from the policy instead.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks for cleaning this up.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 26 +++++++++++++-------------
>  drivers/cpufreq/amd-pstate.h |  1 -
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a4ededb8d89df..3f6208828c063 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -315,9 +315,10 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  	return ret;
>  }
>  
> -static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
> -		int pref_index)
> +static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
> +					    int pref_index)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	int epp;
>  
>  	if (!pref_index)
> @@ -335,7 +336,7 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
>  					  epp,
>  					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
>  					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> -					  cpudata->boost_state);
> +					  policy->boost_enabled);
>  	}
>  
>  	return amd_pstate_set_epp(cpudata, epp);
> @@ -746,7 +747,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_pstate_cpu_boost_update(policy, state);
> -	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
>  	policy->boost_enabled = !ret ? state : false;
>  	refresh_frequency_limits(policy);
>  
> @@ -768,9 +768,6 @@ static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
>  		goto exit_err;
>  	}
>  
> -	/* at least one CPU supports CPB, even if others fail later on to set up */
> -	current_pstate_driver->boost_enabled = true;
> -
>  	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
>  	if (ret) {
>  		pr_err_once("failed to read initial CPU boost state!\n");
> @@ -1176,7 +1173,6 @@ static ssize_t show_energy_performance_available_preferences(
>  static ssize_t store_energy_performance_preference(
>  		struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> -	struct amd_cpudata *cpudata = policy->driver_data;
>  	char str_preference[21];
>  	ssize_t ret;
>  
> @@ -1190,7 +1186,7 @@ static ssize_t store_energy_performance_preference(
>  
>  	guard(mutex)(&amd_pstate_limits_lock);
>  
> -	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
> +	ret = amd_pstate_set_energy_pref_index(policy, ret);
>  
>  	return ret ? ret : count;
>  }
> @@ -1265,6 +1261,9 @@ static int amd_pstate_register_driver(int mode)
>  		return ret;
>  	}
>  
> +	/* at least one CPU supports CPB */
> +	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
> +
>  	ret = cpufreq_register_driver(current_pstate_driver);
>  	if (ret) {
>  		amd_pstate_driver_cleanup();
> @@ -1604,8 +1603,9 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
> +static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>  {
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	u64 max_perf;
>  	int ret;
>  
> @@ -1619,7 +1619,7 @@ static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
>  					  cpudata->epp_cached,
>  					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cpudata->cppc_req_cached),
> -					  max_perf, cpudata->boost_state);
> +					  max_perf, policy->boost_enabled);
>  	}
>  
>  	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
> @@ -1632,7 +1632,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  
>  	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
> -	ret = amd_pstate_epp_reenable(cpudata);
> +	ret = amd_pstate_epp_reenable(policy);
>  	if (ret)
>  		return ret;
>  	cpudata->suspended = false;
> @@ -1690,7 +1690,7 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  		guard(mutex)(&amd_pstate_limits_lock);
>  
>  		/* enable amd pstate from suspend state*/
> -		amd_pstate_epp_reenable(cpudata);
> +		amd_pstate_epp_reenable(policy);
>  
>  		cpudata->suspended = false;
>  	}
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 7765c82f975c6..9747e3be6ceee 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -98,7 +98,6 @@ struct amd_cpudata {
>  	u64	cppc_cap1_cached;
>  	bool	suspended;
>  	s16	epp_default;
> -	bool	boost_state;
>  };
>  
>  /*
> -- 
> 2.43.0
> 

