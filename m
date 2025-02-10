Return-Path: <linux-pm+bounces-21619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E6A2E368
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093491887CEB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 05:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72391607AC;
	Mon, 10 Feb 2025 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AOXamfLo"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A262F2A;
	Mon, 10 Feb 2025 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164355; cv=fail; b=Tz6TY6qJaIU0bOAoLDGlbs2w9bgwb9SUDDw5dsOzLFPpvYxdZY+1KMwXVFOnLUErENJ53Apf2++oZecnfrpxFiR97Bn29vnw4ziNKnvK0OGvx43Lis6pEfDPewyoivum4FIjejhgsLY64CYqSOwpvLKFCjsqNQLqBB/WvNQ5Kpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164355; c=relaxed/simple;
	bh=1VcIWqR7DdLQeTjkP8btwghc5EnGWRI4W0g4B/oHhHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qTjuYIOBogbsJmh4Nang4p2QxC9F8ui3w7oQzDroDhJuam8mFzZuR2x0noXm0P0lJ2UU9jUoEKiHr6bkY1bI8ysExy4agA2AcfuIWxHS3XQ4fBgNNT5ehkgXHIfRUqAJkhumXiK/Tl0Se13bEqy49fjcr3yZXa/gqJwGpiYhLpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AOXamfLo; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6lgf4ybRtU0HF/67gTtr+dfjCp3Oys0iXQvru1QVmvQn296WgujRg6a9SQnzEStLNwz9fpHwu4Ho0TKyPh1qtvL9UCBBk169Y0kvUzeCzct+JwLL9negihU1y0OtApMwAJxhw+DDI16V9UaFgH56k5np0blz+hqJRydayqBWkDwGcNq2RcSfwrQHBIYrtguis2m/v3+OM6xjJvro7iHMrlFpVpgOSUaXDN/NyY5ry7jlsqqp8r+e/JM3g0CAlK/Et1BlbmYvh1IihX5F9yaLlw+UAlrHtGnoxUedoLGeHydIhtZoeKG1DneZA95ll66myVOuZPZXAixhUlDN40Jcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdooxCJqdBWgzbJRekn45aQDQL25Kposm40A3gf9mEs=;
 b=FhUWZ+m4WBV4XYntzXAI/Q3PdZ1o3eGur92pt+Hw8KInlhlFwlEgokqjOgtBZmWsPE6iirFLMtB/F0abwb74BxzwRHWxr5894Nkhk+VOEKGsew4QkmiAFxElDnQ9T8FvZlv79tTTQ+84wERL5uZSlNUsMHnfM2A6ITwrh3lqWIZXimt3EdGuKPAZo4zwAsluPBaCTQUAQiu/rMKE7SW37VcVAshC+V2xUuTNJ61qmSJNZqfG0jd4jgRqP2wN/t5F6XxtIM9nWW1Kl2FfdwXnUoHrvJSlzOTGXWPQgbj0c7dnmi4rXkrryQvkeYO9X/vkMdikXHZXdyRSFzZZgbwyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdooxCJqdBWgzbJRekn45aQDQL25Kposm40A3gf9mEs=;
 b=AOXamfLoYrWzTAkktlFKfiEY0jh9bakM63h5uVsWr4gDq0tOflOo3PvAUJ+2DTTVJmgeigRaiAhO4S67YBALTVTiHXd8NZHq7Nuode32NcLJOqdC91vDeG/7a/x6DI4yqhQA5/RPCJRvemPZuvDk75CWvgtpVfD9KD/hrgdYDEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 05:12:31 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 05:12:31 +0000
Date: Mon, 10 Feb 2025 10:42:23 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/12] cpufreq/amd-pstate: Remove the goto label in
 amd_pstate_update_limits
Message-ID: <Z6mKt1Wjvo4yuGdT@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-2-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-2-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN2PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::28) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 08755aa5-8c5d-4538-ff87-08dd49918551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?45ehvbB/m7cR3s4ZhPPDQrajT2SUAq73ZaVj4kQjI24lxuiEtXIDfRbPj+pW?=
 =?us-ascii?Q?UzNwrLtvmauV4vpaX7oF75gqSo80LJMb4wf3Lid/TDmK3TT2NbdfC4IfBZrx?=
 =?us-ascii?Q?HpRYlayju649Z3TSQog7VVrsqe60NpKyxgH8YIBJ4kCUfHOsXXUB48mKVllC?=
 =?us-ascii?Q?XSOr+AJkVDKucy73Vk7328HVfTDXMt6Eqr5bWYdBKZZauYQhC31DFXNt3yn2?=
 =?us-ascii?Q?BwBXXg2vxdt3y/UHtgQaKhTz0ohIGqb/pmz3KIzzVQ77zQBEDezs6YjYVpbU?=
 =?us-ascii?Q?AKUGFxSO6d5RKOOlxQjnl070011umAjvyOtw7Dqs+DjBkDhZOlRWa43Xcao8?=
 =?us-ascii?Q?NXgtRmDqnrQrDnDuflnBlgJrOD8nnpLux9WY/Z9Xuwe/8rq+xwv/AAwrim7j?=
 =?us-ascii?Q?QvOuK8F/mJuTgfmLO/nsdrWbPBgjdXLDJciPzHScAiHSuqdLVldHQilGjgHw?=
 =?us-ascii?Q?JFH4ZePvKU1rwBHdY2S1dl19/MjgNt/R7wvzh3oAKzqp//fMpgaJbT3/nhud?=
 =?us-ascii?Q?iKU5VGr/TLckS83V6Ax2+j9uKJdXF5gK7dITPWs7ZEv7O4j0Eqvbo/mm/YIA?=
 =?us-ascii?Q?VfZ2/Rth75g1Tl4JN9B4mDdwspKQwuW7fivOq73fIepNddUqcaC/W8j/Bbic?=
 =?us-ascii?Q?Jptu282hbysDkz7Pk+isL4zzt08SbdLMkAMcZYJNXkneJeMplkW26bOZFsN2?=
 =?us-ascii?Q?4C735+BncsDfZJB/VwoA+GPpDPCwf5VI045TkY4HJg+yZ/LN+05kGPSWCyzV?=
 =?us-ascii?Q?u9sPkQCP+plmNGNU9iXVJ3UBGpxIHv2KHLaqQ9qUKXHtttHfwlJ42FwxSluu?=
 =?us-ascii?Q?cATpozjgEPoyqzQmnTLaePJYAOgvWxxILabVa68SjrNinWgNEX15WLqppBIA?=
 =?us-ascii?Q?3YDdvB9So2sFx2jNa+1WgtYJUXdyy6cq95+9P4+wupOaYO9lNU6YvfGyUo4A?=
 =?us-ascii?Q?Sl1DtQ4kmfc+RVevcFG+mKRW7OZzp1InYLUjc56ZzLNuOEiWW3nMayhGRpDM?=
 =?us-ascii?Q?OkGhsiqbs6TYzoGX4BGNf3HuTagl3FDuE3e7IOra4mFdLsXZNqCQeTpTqxT8?=
 =?us-ascii?Q?rCaI3fPmAW4fDZxOd9Slhh05aHQ+L2GPS4f49pACGy+BANPh0uzPi1n671aE?=
 =?us-ascii?Q?KRVowk3a6gGEQW2fy3KHuVJmeu8ZGMyH/XZAEeO1Ek2ajRPfKg/nB2SXEsTY?=
 =?us-ascii?Q?RKz3kwYMLxx6H9QYjFZlfOmfk9o2TK+xwC8JuB1b9dz+W/BNxXc2ypCYKTSr?=
 =?us-ascii?Q?wQtWqCFrZyc9iokUBMSe+W8mLO8BwdtV6J6zQ+/No1QjStK4wDOmnM1XoxvV?=
 =?us-ascii?Q?9GM4laettRm0zD5XuZn1cjArVhjm6Hn78IJFAOC2ZvaZ5o+506HdJeqnQTWW?=
 =?us-ascii?Q?+p5PCHNpCr2wr1tkzkSxqBwcIDjm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dHnv5p4mAAS4kb/ZFyIZdSdOPJXEeb+1K1Bacf6gsazhQ0hTQKtcS3MZuQhd?=
 =?us-ascii?Q?83mBLEIAmVc0uOuEB9otAbzCtyyuIsuFEULDBGW4ZnaJscBtXDg+uQxwg1Ln?=
 =?us-ascii?Q?7htGhRxgvn5abpdCHS1lWmyc8HOhvkbQDZzcZjRf66FfsFdYD1H4eAMAE/HM?=
 =?us-ascii?Q?/tVETJRKPM7ClOTnQthdns413lCH5kzSlBA/vUmWbbATyEp1SXxRfxP3+5+2?=
 =?us-ascii?Q?6WnYBQpAnVwck1BZwzddk12ppLrqW9R/ZdGISUczzSLRAsFtxv36ANIN6Kli?=
 =?us-ascii?Q?xDE6Z/kPcxa4BCi6Kfhzo48vMoYiQcSN4dVaH6sNouyscxFxpNrrll+x6awe?=
 =?us-ascii?Q?1vKS36FrqcYpXT2lQdouVVZOR7scrZqhDQxNtf4V3hVD+6ny4Dg/cVNxNmbR?=
 =?us-ascii?Q?sNto8eOn9bHyR82VIwouWzHHEcklTXpKEloqkfc8jlQEEDUdgeA7IpuEridN?=
 =?us-ascii?Q?0zpZVflKgPzjvA8di1iph/mDKjGdRCK9Exo9rRcXzb6mhuBncAd5u4RAu6ei?=
 =?us-ascii?Q?aX69u5VlpGgr3T/kvLPNcUjxvjtDqRl6GsbW/hfie6y8lkXV4JGAlauXxNNB?=
 =?us-ascii?Q?7QkG2nKBL6rqbDdzBboGTvBiDA8pbN0ls7SpxV/WLrloAjxJM2lf3oz7YSRt?=
 =?us-ascii?Q?F77iQBv/oJKlCxKQ2J0oJS/zp9zoU7anNq8177TpoJ5Xqw2Vz6agntn411uR?=
 =?us-ascii?Q?A6lnH45HiMS7FtnCSpRBRLX7THw8tu78sPhuJY21rnJsEyzLOrcIr4dYmUBU?=
 =?us-ascii?Q?XoZ8iapI9buLW3sRRuVQhyXcvkAvbUJkKsojlgXX49zaf5ONWh9PJJKz1eVa?=
 =?us-ascii?Q?fL4NP/K/Ll6MghkdYl7aKJYFBa0o1cu29cCDdk2UazPKPItXVd5SSB1yqZ8Z?=
 =?us-ascii?Q?pAH6zF3NWU1YOkOzSzrzmY2X9IGJOfEzEMqDaDRlyPQg4NfHvLcWgzb2uuTP?=
 =?us-ascii?Q?NNMCKmFrc5TPBAhtaXaJkpr0rzpwV1wuS2FS79E4gl1aeLEZfD5/MwAaGdPd?=
 =?us-ascii?Q?GK9z+lejqnXylZAIngUJjB6A4SoQ4Hsn7hp7jJH1A4oPtElMn4jclsIswcde?=
 =?us-ascii?Q?g4Bs4iGGp4LjIpjSUa7orcsHtsLuFdX6zHN7HJTNc2c6SBXO6lgEA2L3t6EL?=
 =?us-ascii?Q?Lm4PdDiFTx3SJ7LArE/pwPmEeWcsg4comXY5CRm/bVUyYebLMBVX1Rpgxouo?=
 =?us-ascii?Q?gBid+xrhvPeEczASYFJr59Guk+oqZ8aIW6/Wk00jbb3VmQJZUVoVTGMpRk1a?=
 =?us-ascii?Q?tT7cW9ACtHaZhiCiSQhDHwq3Avd049nhWAWW6x5ed/+Npjfl4vQg3HFm9kgY?=
 =?us-ascii?Q?ilLSh4/dM7Uy5xxDzYoWi8YOyq0gjLFKwsTemu4evkkqNikCdnZGcIAzDyiU?=
 =?us-ascii?Q?UTY0rJsrzD3mYk9VWsLbHbkRC3xBdKpB8ReQ9ngFwGrNxbZgrepn8AxeRTaZ?=
 =?us-ascii?Q?innjFhBmZYSjUeQSHTwMDr/rT38EAQrnjFLvNADvgyir+kMj7QcQSxkRddLN?=
 =?us-ascii?Q?+jEnbhqoYg9U1FXdmLv5A/wh3trpMTqfxjbqwFkQRLRSmK1tgTNiFS1DlD+9?=
 =?us-ascii?Q?LbLeggFsoPG2aka6H0BjSheG6FUM3OpdwXnV9TBt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08755aa5-8c5d-4538-ff87-08dd49918551
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 05:12:31.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/AEmv3UHWCBYl1N+vcYfoxqB3RvS8VqDs+OKJGLppa843XBZAMWN8nNdSr6eUXn6EL8NXCKLBqhuO9usrDOZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

On Wed, Feb 05, 2025 at 11:25:12AM +0000, Dhananjay Ugwekar wrote:
> Scope based guard/cleanup macros should not be used together with goto
> labels. Hence, remove the goto label.
> 
> Fixes: 6c093d5a5b73 ("cpufreq/amd-pstate: convert mutex use to guard()")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>


Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7120f035c0be..b163c1699821 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -838,8 +838,10 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_get_highest_perf(cpu, &cur_high);
> -	if (ret)
> -		goto free_cpufreq_put;
> +	if (ret) {
> +		cpufreq_cpu_put(policy);
> +		return;
> +	}
>  
>  	prev_high = READ_ONCE(cpudata->prefcore_ranking);
>  	highest_perf_changed = (prev_high != cur_high);
> @@ -849,8 +851,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  		if (cur_high < CPPC_MAX_PERF)
>  			sched_set_itmt_core_prio((int)cur_high, cpu);
>  	}
> -
> -free_cpufreq_put:
>  	cpufreq_cpu_put(policy);
>  
>  	if (!highest_perf_changed)
> -- 
> 2.34.1
> 

