Return-Path: <linux-pm+bounces-21674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349CEA2EAC3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93691617A5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1011CF5C0;
	Mon, 10 Feb 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wK6G8HXN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209B19342F;
	Mon, 10 Feb 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185900; cv=fail; b=BCvplPLn5lle7X98HsUd112JI5fK6ot0xf1v++CsD5/rxNLnvl/h1VXFoYsN6G0J4cx7woezuKg3aTdqXuhdxC0U5KypbllS9uCwecO7vBYtV44oHo/pFy4MEHQcRhoNJDEWKZPtwOQILEBuDz13/A2feRp82aygwyNJZzVy+vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185900; c=relaxed/simple;
	bh=UkmVub/S3tTstFVEzBbP6v7QeKhb1xvoyQUl+belIso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lm9/Juy6C5YMmZQP8aPesxrJBzYrgVMAWMNuHDk5uorRPkH9UUVt4fciOmWy20M+xdARc31frLsPH7BjX0z5t4Jueb/uXQM6JsQWKXxGVcNWSvXKOyW2lDrLxCzazNi4qnQU4kKm6geAaXSXuySLfGCKpMB6jfLKjMhfO4uyV4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wK6G8HXN; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3P39+JJnq49hVb1u2L1+4pctOtm8wG0rHiCnP0H4WIPgmalOehNAp8qXG2Tkrw2Nq4aSUFa73jhWqWJglcfuoyQMeE4tjYxJdbFOhW9qYIi+KH10Te+oNHiAKErC5rZK6UPShBeFAry/XD7av17lBBHfVKd6ysF2+/tnY3i8fRteZGRgpBTN4uas8e/mcfNVSKEBDC17TRZSPxAAnZR5WkpGVEs3UmQB5lZMGrzy5G8qFHloeCTiab+jopl4ZIylWRlvqYLnq/3cf6j4a83LLdRgzahbiloyzpxX22d/ZGDYcNc9+B1JiHbD8X0MRkpRzkVFb3sOhkQYYCWbigB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox2Jvq5tS31SYW/SHCoYx5e7uQF7s1gbu8p71g85QhE=;
 b=x2YpFKiTxr5q9h3ziDxEJ7XXvi4fCCG8k5aZBLZ828lclT5AyhkvK26LsyNKrZ+k07sT1OG1hxs2VNqhio/C3nyqWEj8xQ9ijlzyTdG34axA1dioPq2ygDXyBiQyvfZiP25Tx/I9We+1PVZg9UtJEOC3CqSNocrmHIiFV/RW+kRJvyMI5Mpu1EPfeUxFO5TxxcXHQpAGwqSIL0i+A2dpzqOjBR42YSOyGp8cYpWrkcM4P4VS3uDxHWDm1FngEjKW/C6wYMfBTOGhHlb8gSM7EUmHzg93dfffRlZuQHIWIzOMO9sb7agDwqexTrhstmWrAVJGRDaZIVDppSAVyxg+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox2Jvq5tS31SYW/SHCoYx5e7uQF7s1gbu8p71g85QhE=;
 b=wK6G8HXNrNqnSW+G71eq9NB+WqMlogKi62BPnfv61Q3+0ygAVAJu5m7IFzwx9G4jBCBsXHOhoqOIcb5/Lpvwi7fbCSjm1ZBakgrC9MP2FKXkw4A6h9rSlyYXO4vAOYE09wrSJm4O9xvqyKChE0m/B7XhI+OeMmaTcSCqg/aOioc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 11:11:36 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:11:36 +0000
Date: Mon, 10 Feb 2025 16:41:20 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 11/12] cpufreq/amd-pstate: Use scope based cleanup for
 cpufreq_policy refs
Message-ID: <Z6ne2MUPwl5fcxRb@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-12-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-12-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: b629c8cc-c255-4e5e-0da1-08dd49c3af04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L0DQbo26SUopHCVMXtV9iC+13HxcEO/9PzgmBhMGfVMZ1U72BNz3PcfIVQL6?=
 =?us-ascii?Q?JO4yM4zZOuJ62LM7RLRHWEZ5PALPG48+L2eWQHG8Z0AlseWe2StELkFhqKDU?=
 =?us-ascii?Q?Sx/Wj4700ysbM1Z6jAUOWixDhjC0FgAjTX8LkelkiBNb4lwwldwlIhX5kp7w?=
 =?us-ascii?Q?5E8mBBm6VBtS++b02e8NOTct4RhaN6Wvto8dqD4nYdif8/0WAMyTeOZtTsp1?=
 =?us-ascii?Q?Gd1wvOK0/RXfma3U0aRYmkZpaUL6542/BGSGVs1J17NvW376OLXH3rjw9Cs9?=
 =?us-ascii?Q?SdB34fouAtYHSw9apgDuhF0LSRNf8R3fMl9M0wkm0VI0HD5eBfldNwKX4LRv?=
 =?us-ascii?Q?XXKLdWrCp6qrhN3C2EDoal2t0O3cnusbtNVl6marFGY6NMIHpRdMGYiAHv1R?=
 =?us-ascii?Q?bEMHWvrWenzAgV8kay0JyTf7Szg9si7/ufRI/A3brgm9RYRYvQ9oBjpwdeO1?=
 =?us-ascii?Q?yvnqR1ucTe7lCxKghLlPidzxxudGYnvdKM5a04Wy4KtB0kLHPeW8i6blBoXG?=
 =?us-ascii?Q?hFn3u7qnXJg6zMJrZvWx+DjBQO8iAcGfnoZUTF3o7h+OFObNxZHv04QzeBpQ?=
 =?us-ascii?Q?gXaOq7ZwGaHecH6kIAC6PLiGKXgEnQ4Jc3thD/UesFKVPlH9UatWDMYCtF/I?=
 =?us-ascii?Q?GD8ACg7hnOLG9XOmf9PqdyS0c5I/dDbL5BNIQaxTQxH/v78AapuuefpxoCx8?=
 =?us-ascii?Q?K+nu13yTnJJNhualyGKPRGUfGtWPUxhAzYdJmkmg4V0+ENVsxs1JKlDeY/8M?=
 =?us-ascii?Q?NyQtCsFO955JWtSwRwpIPEegUWQTUKrjnx/stwZDHHXfG2XjbHpxVysMxOmB?=
 =?us-ascii?Q?JkT42lOE9fn+D573qIO98T+QYjaGLc5Cix8a2Vi8XuBBkurJzMMkNycUxPUd?=
 =?us-ascii?Q?imP+TLcTvGxL74KEPOomSShKLk8gBS9tMP30RnklzyA4m3ZozptFtB1m9sN6?=
 =?us-ascii?Q?KtDs7qHA4/b9AeNumMaCYZO7YFB+HUfGYdewU5YB/Fh+5YAZRTnxFBxV/o9o?=
 =?us-ascii?Q?4wpmub/h1RFtjHOFNGz+Lz9EFFUXA6azXSorXCJW/XvyHWfI4h/PjDl1TCNY?=
 =?us-ascii?Q?SWnNAYBjbZsO+FiRZO/CaY9uT04uKOiAwXI93RpwmVfBPEQHbWXctvYYrHt0?=
 =?us-ascii?Q?f+OX5dQqYvcA3UKdToOt4VM/twYRZhIdvI2Uprgln8QTLzyyNqO1Is7muOFO?=
 =?us-ascii?Q?4QF8c0oSUUDWwbpIimgpCXblEp8DCe5IPq4b8BxCA4mRpQRFSChd0NhYl0ac?=
 =?us-ascii?Q?qHcTRBPhlsLIgGAp0O0OAwXhRO/fGxFnNCl+w0Ak9GtcelePbGXo4jy2ZIsA?=
 =?us-ascii?Q?l605ILpGe41OWr1cp3oAhUTF3S0p5+D+6YPfMD7JySGT54O5B5EODM4JyNLA?=
 =?us-ascii?Q?TmRwg8q+uSfVKoa3CbRZ+o5if8uG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPDgvtCq/qxuDPtTIj0hXpiVvNy9DUA37cHL7nyFlMp8ZRWfh/+zp3DI9P6c?=
 =?us-ascii?Q?j1+PLy/aBPWafZRl8dg75+iOwkEGXZCHTr0S0tydIb0PmJs2p3TFB/uaJA2K?=
 =?us-ascii?Q?BFTM/lFr74J0B9H5WCokE9Lf4pG50BWEaot+JSbcGpjGAFSicSavfhCDhVdv?=
 =?us-ascii?Q?KUxvlzhnVGXII0QKQOO85yIkGa1IdHdkPZ/kZFgbqM2RtWJCdGmHEM2xLUQf?=
 =?us-ascii?Q?1WQYov+uXNf1GbmES8Ejn7wJvbORTb23Hed/o4+9A2tOwDTsYJ/V+9s21iW9?=
 =?us-ascii?Q?Hp25+2vUt1aFFqtCEroqXQyM569d/C4MYddclRQrqB28zbY5KtE9bEA1LCqG?=
 =?us-ascii?Q?A9Wo7xN+xk+q8WTMkL0jJUUkkfBtp1j0lB4aHeKptdD0W3iXkNB73/E1bxZP?=
 =?us-ascii?Q?6ReZMdSNB/pKIHWnWYKfOSESHMzuui9UiWHdXin4mXdgZtRvcrjJP5eEBIaQ?=
 =?us-ascii?Q?XH+Twowohs3MFiTFQMrR48oZw17/Oqdeq2gFcUU4NAqLxY+ziab8vjWcgeW+?=
 =?us-ascii?Q?rzfAOB91Qk91eW1iU6SsAtKXoTS4Se28zcmqOjKtyrb5yzKpD2qOhzT30UCl?=
 =?us-ascii?Q?XGOluOukqoJIBhv20+SFuy/xlcB9WLT+xsnF6FbeZJQlNHqc0J7YxTYUtzX9?=
 =?us-ascii?Q?x2v71YrJj+l5J2LqMVx7Lx9z5xFxzyXJf/cxodF3PaouPgsUrxNRIPaWvPe1?=
 =?us-ascii?Q?yhFb81pv7kit7EImsEIN6T8OKokI+VEA9TB9Bgf4+gDwz7iz+Y07Cdk7AFC0?=
 =?us-ascii?Q?BAZOnyGw3nM3nH3h8Y6y6BmqOfMOkkfUnT0vFYBLqylfyz7/wJeJh9S01L9h?=
 =?us-ascii?Q?1LyzAxwxIQWif/l1ZA2qc2yBaC94ZqTawbwdynC7W4CbRnzWaEPY/T6CoIyS?=
 =?us-ascii?Q?bmDDZYcNcj0RT5W3XsGlxi29b2b55baya64u7ftC/N/utAFbdd18A66UzCyJ?=
 =?us-ascii?Q?LdCK6k8ijpQDImdiaDqjtShSevxg1TqyMWEZtwsWUGecceDIOyJhFiKv6C8+?=
 =?us-ascii?Q?0OEjWvVp5cYjasKidX3SBOgwHs1zD7s87Hoo4eq/v3qy50hF4H37DECl+ypS?=
 =?us-ascii?Q?Gfoxs8VaETe5c7vmuli8yIpiGx50MJRaKBZac2Pnan+9B3mBxO+nTzK9bX7r?=
 =?us-ascii?Q?YE26BLQKMkilV1NF7z+UnThzZRufMsGCiSPqVQHtNoZDznbC24JH1yJR3dwW?=
 =?us-ascii?Q?wE82UwkxdCUH12R6XTL/oJGhGoypizrCgA2FOgCp+lgVPtOWwMGcMyMCDocN?=
 =?us-ascii?Q?lyZdxwkFQJaD6YwiVQoMZ/ZlvJ2vZmCiu3kmx5i8iiiDALF9Th/RiH+7vlRR?=
 =?us-ascii?Q?8wh7YjWgJkfgL6dXt3xFRQUrscdj6oe1hGfrs/u60H2duUAO1FA7utcXdGbF?=
 =?us-ascii?Q?qJUEp+ekaPa00DFFxQD4irxWQT9g0yM8yBuLv1H7yy45RL68oN3rb2ZvmJeR?=
 =?us-ascii?Q?riXZBW67oWXQsXXJF+6QWBdDZSbE5Kicli3rF1G+9sOdEvvPDnGFa+4zaYRk?=
 =?us-ascii?Q?hDtbd4JOvhFCSSrmwRYzZJbcnMZE4MRMYMsLWkzVI/BF0K1C7gTtbVA06rMp?=
 =?us-ascii?Q?kOSPwPJ19SDEBH0jdRtUYPn0tmfSvQ6yNotfbIhg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b629c8cc-c255-4e5e-0da1-08dd49c3af04
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:11:36.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAJur7HWCYcCaBKzZ2S+vA6Zi30lV2tY4VJ+RpBpyYCL5Yp0I0lozNLSHSWU9NQZBEeDIraGsnPynLwb9v1zsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

On Wed, Feb 05, 2025 at 11:25:22AM +0000, Dhananjay Ugwekar wrote:
> There have been instances in past where refcount decrementing is missed
> while exiting a function. Use automatic scope based cleanup to avoid
> such errors.

This is a nice fix! I wonder if this can be used in other parts
of cpufreq. Did you check if there are other cpufreq drivers/governors
where we can use this destructor?

Other than that,

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.


> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 25 ++++++++-----------------
>  include/linux/cpufreq.h      |  3 +++
>  2 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6a604f0797d9..ee7e3f0a4c0a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -548,7 +548,7 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>  static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>  {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
>  	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
>  	if (!policy)
> @@ -574,8 +574,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  	}
>  
>  	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
> -
> -	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
> @@ -587,7 +585,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  	 * amd-pstate qos_requests.
>  	 */
>  	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
> -		struct cpufreq_policy *policy = cpufreq_cpu_get(policy_data->cpu);
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> +					      cpufreq_cpu_get(policy_data->cpu);
>  		struct amd_cpudata *cpudata;
>  
>  		if (!policy)
> @@ -595,7 +594,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  
>  		cpudata = policy->driver_data;
>  		policy_data->min = cpudata->lowest_nonlinear_freq;
> -		cpufreq_cpu_put(policy);
>  	}
>  
>  	cpufreq_verify_within_cpu_limits(policy_data);
> @@ -678,7 +676,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  				   unsigned long capacity)
>  {
>  	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>  	struct amd_cpudata *cpudata;
>  
>  	if (!policy)
> @@ -710,7 +708,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  
>  	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
>  			policy->governor->flags);
> -	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
> @@ -824,28 +821,23 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  
>  static void amd_pstate_update_limits(unsigned int cpu)
>  {
> -	struct cpufreq_policy *policy = NULL;
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>  	struct amd_cpudata *cpudata;
>  	u32 prev_high = 0, cur_high = 0;
> -	int ret;
>  	bool highest_perf_changed = false;
>  
>  	if (!amd_pstate_prefcore)
>  		return;
>  
> -	policy = cpufreq_cpu_get(cpu);
>  	if (!policy)
>  		return;
>  
> -	cpudata = policy->driver_data;
> -
>  	guard(mutex)(&amd_pstate_driver_lock);
>  
> -	ret = amd_get_highest_perf(cpu, &cur_high);
> -	if (ret) {
> -		cpufreq_cpu_put(policy);
> +	if (amd_get_highest_perf(cpu, &cur_high))
>  		return;
> -	}
> +
> +	cpudata = policy->driver_data;
>  
>  	prev_high = READ_ONCE(cpudata->prefcore_ranking);
>  	highest_perf_changed = (prev_high != cur_high);
> @@ -855,7 +847,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  		if (cur_high < CPPC_MAX_PERF)
>  			sched_set_itmt_core_prio((int)cur_high, cpu);
>  	}
> -	cpufreq_cpu_put(policy);
>  }
>  
>  /*
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 7fe0981a7e46..dde5212d256c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -210,6 +210,9 @@ static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>  static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
>  #endif
>  
> +/* Scope based cleanup macro for cpufreq_policy kobject reference counting */
> +DEFINE_FREE(put_cpufreq_policy, struct cpufreq_policy *, if (_T) cpufreq_cpu_put(_T))
> +
>  static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>  {
>  	return cpumask_empty(policy->cpus);
> -- 
> 2.34.1
> 

