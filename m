Return-Path: <linux-pm+bounces-18680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5389A9E674A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 07:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2518E169332
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39431D5AC8;
	Fri,  6 Dec 2024 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TMEnanHO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B0C8FE;
	Fri,  6 Dec 2024 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466439; cv=fail; b=rharojKwrANpR/lDnHgHxmFSPZkvHexsCEXvr1+yHkq5Ru1KWzXHGfv7k0IvPFClztjNJOoC82hQ1DoVJbmHyxLbzCIMJLGpL4S2nC6syTewpNBJz+NORoLmSIoLHzrF03ufu0oVP95nFFyhBbtbSQ64MkmfjuE4NU4CYK22D3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466439; c=relaxed/simple;
	bh=xk5Jxo/xfN5ELtHXfFwsIm6MTFWAVdHVrrSRvQ09Pbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+vakxwwK7lRYNElQ4pJIg3PSOCNpBj/WZ0O6qU4+FmmUOXClBfUuJHkCKiAJwnOlkF7LkvvOYCZ60I+OhfPCXM/2S3Xd4Ntu1cYJj9Dgu7THgZNDHvmNw1gg9dlsXW21FNg4UEQ3slRSZGcdInzcwFyFodtgG+EDos2hlHvwqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TMEnanHO; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnzmH2cIufAYT3J4UKYAAfBp4xHLLkuc4H07HD3yc1UBhjnsHL06HsrZanON+T7960R9jxeq5bsr3toA47aiDY5HrFiYpKSolXWfsEMbRTWLnU4Rr/jPAY/btYRpVtKpXb0yqaG8MiAW3Wo5fyu/gtoMgUKRhB+vidKcDDzXkY8+M2k7lWjMSDZmUukHcz5n+adnQvcsJubkyeNq/iddXPFwCj1zMfkDyUow77pDSq1P1uGklUDd1bqA47+wHOyZ+Ioy/Dx48jVTRyHdAIIXegXuwZvBt7blMeLwI3F0mO6VaRI1roxPEKSZf7uKNyKO9PBex2P5CeXkrPkMTHEQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd3uCw6fnlYeAoBBKWgR2g0rICEaXDJI9v//S3ec85M=;
 b=UTwOsT1/JwtffOUFdBT87tHwWBPeRQovqlzwStGAQrk0V/68xBG/UMQs9fl2QuloMh74zzYQJjpdVBCPAzXSx3T4i24Cy5x2huMG4mqw/PTxvDa3i1qvqXBXyZxuZ10IWvflAQpC1au1k8p/AHNXPxJrmUehJ6mrFF8rzxW3i4w/m+7Fo3GFywdxmVVbbwMPVuwhaIczv4/o0yXE/HSCpBLRuP47y44bE+CydfOhfZbDp+VqxNz0ul0KoeZYz8MDJy46tJSTd5jeTYFw0MpESYuCDCRJm5Jdv19+Db27daYijEt8eiqowVSMDXQ+kDRhkBnJjI1hp+3C+ACBE4aiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd3uCw6fnlYeAoBBKWgR2g0rICEaXDJI9v//S3ec85M=;
 b=TMEnanHOVufUizAnMXc5Gk8pyPWSZ1U3Q4OTOBWI5O3gNgnCjDL1vk8rOwuHuykaaTGSdA/7TR2tRZvVIiiiujy0S8bB8+LaQK9COfKYJ2MysMdW7OLj2Ee1aQXyKDfAzncWB4I39iJ6gwfblL7sWcNueawqZNONWuh62icZY6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Fri, 6 Dec 2024 06:27:13 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:27:13 +0000
Date: Fri, 6 Dec 2024 11:57:05 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 06/15] cpufreq/amd-pstate: Use boost numerator for upper
 bound of frequencies
Message-ID: <Z1KZOeFtzqTeSZny@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-7-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-7-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a408f6-1e34-457b-24a5-08dd15bf053e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s/6t21R5UuB8THdUnWWu4E4Bkn3AzwdaduY22BiH0W5n0f9ZcOt83wZBJAsG?=
 =?us-ascii?Q?RJ07zKkqH/4Hmvuu1MzI+XgAY4y5qG/nNowEoXYJ6tEExx9pfWogXmZcfWQH?=
 =?us-ascii?Q?ELMPZXiiQiwxmg8ZWTqf0nk1Cvjof6hZPjumHda9acrWVGQqwev3M7+tAKdI?=
 =?us-ascii?Q?GYWlgxXHQzcxGYZD3OVEeU//ddhBdr4aXcdCQPKzz3ExkkrT9ZUWeRXD63GT?=
 =?us-ascii?Q?fJOTaxYvOU6Fd0OQy3iTUimP+IbRoEyNtIdXXnvrqmhAiFdPSm2C48KBeCA2?=
 =?us-ascii?Q?vcx3yMDLQPqLeAp48Nsi4qVqnfv1+l29h2alwru9ikqN+OCrNrI2GsJrl+rI?=
 =?us-ascii?Q?ssbXsme4GL1q9TiuNJ7hrODdQinSrHsP22D3rtqW7hEffgcBtSj3gT0Qer0T?=
 =?us-ascii?Q?BMZC4Msxq6g710K+UYoOeTpgqojrEW11J6XdQxL77h/6afbBdxSfc+TGc4P/?=
 =?us-ascii?Q?WoL1HeCOJ8rlzrsAGWy1a5f+WxcE3SzADXzsRVreZKpz3cZAGqA/3AejLX69?=
 =?us-ascii?Q?0OUPanhWgNaBWpaQjzjXGMnAOOXPrQn0T8EzmWulkolZrgCEkV6WmFmdr6/f?=
 =?us-ascii?Q?odmnec9maurlXmedBNtws9n7LjeEDA5BvH1l+peuoul27ka9Lbmu5z27wqoY?=
 =?us-ascii?Q?7sNaU4S7q4f/NzeCmOBo/fzGQcrgvSYq4DtNYbibfoGQqE+e8ivHce9Gvdrf?=
 =?us-ascii?Q?eNYZ0ES99Nac0RaUZgTlSUmbB3ceqV0YcG4on7iiegcgpT7DDOToyyFGshH3?=
 =?us-ascii?Q?km2fjTLJbOwwxniTVgdSzCztREJE6pgUFYiFmqggIhteqbPl5XCOrpb6Jpq0?=
 =?us-ascii?Q?gTw9/3Uskj2YrgIpSQEV4c6iPtjUXIEHcSydSJ2bquAINAO+fIUGAZOBFhjb?=
 =?us-ascii?Q?BgX8Ecqp9K8d8pXYPLReUKhT4bbD6/aP4j4GD9cFt2a4Y7xtk+ontTVbggPG?=
 =?us-ascii?Q?+UcO9QLfCXt73vqiwdEPdGCrIYJNxZhXjj3zZqGcwY0Byhy5W0hYGtPdIt1P?=
 =?us-ascii?Q?T+DkXBtMHrz1P0JLyVLg69IjaIzUW8CbB3iFYDe1W+9j7KWGhZdwOXAy2HFz?=
 =?us-ascii?Q?jWb/vVudFwb/P0iNiExRncv2pGnrj1KpWiJ7ufapAgaXEGJF9KlKFixnQuzb?=
 =?us-ascii?Q?fpWeLJhrsrQX7ry87r/7t9XzdM7hReocbV5k7IAqeJ/jyHmH2kX2LQ3xckCF?=
 =?us-ascii?Q?JOcuqBqwbXH3XxXYOCYaq+B95d1QhFaQKa6ht4+KtFx5D/mfLj4Cyxs1cyod?=
 =?us-ascii?Q?ZrDCxBGOXtnqx22bIiiNxp4JxIa1s4h1wx5H5GvyDJ7v33ChMOd7xr+09Ijs?=
 =?us-ascii?Q?xENklyqEqr454gCEvhDOreU3RXxqoHmbDOIsSO4kHegfx4f2Wy+0R+ROmPhn?=
 =?us-ascii?Q?kWgZwP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ELWstDR8GROm33hcquCrES6Wb4FaG8fcGUPQ6ewn+GdYbKBJyFzajF7LncXI?=
 =?us-ascii?Q?9AN1+4KLv4y8SvCWt3NkEYcIfGfoPwsD13JRXMg04UO6VStFyzRusGKXjrJp?=
 =?us-ascii?Q?K5tH9bl+F8stpcDzIMyY+DYNooIa9wnCdxO2Nh3CsQE9iYmOhLYRuzl4yxNH?=
 =?us-ascii?Q?iDEuMyt8Dh5VlNO7FbnUdb8jm8eIbJx1HWVCWCcVmGGAI7ttzsM6cRxGEFaJ?=
 =?us-ascii?Q?JyfXwTotNdQcxInQWPMqEwnasfQaYmbMf2iHYjrtAKrwJT1mbOaC+SbQYWtQ?=
 =?us-ascii?Q?kBhitcEBVW1xFFCCFvOn5U4wfFqCIDYlgjwrCAtY6AnjitV33ZiRVe6Lc6Av?=
 =?us-ascii?Q?QKUqjdJO2SsE+EZ0ZvVzWLNi9VaBRQmc4iGvIvu4zXKausA46LmRJk5auCGd?=
 =?us-ascii?Q?lXSsLh73VcSkrqh9RCIQLzDwp7XutsjavcKYFb4bKTKardTU3zYXtmSL1Mcb?=
 =?us-ascii?Q?KspG3idNKxCRWDmouSYtVGlIiUvnVyPTOhAMx3YcUv5nzMXEsTsbgI6JzSZI?=
 =?us-ascii?Q?1KkbtbESvKi2fa6s2mLCtXslAX2lVcleVvZhs4Tf8D3FqUyFBUWfupasFjfG?=
 =?us-ascii?Q?fnJNn98NLtanx2rNJ593D7rtAw7wEoNIaUedeMKyiol77Z/RaDQBBCO02caY?=
 =?us-ascii?Q?8xEfM0dn35mjCTHF6g04oNOGZ75zASFQQBq9fjW41NPq/ANIU9YpD2Cxv1EO?=
 =?us-ascii?Q?5BZXCvZcx4U7K1knwd6ASHS2AuSycw8kcreXhl/vab1u4lJDZMP1KoRGKv1F?=
 =?us-ascii?Q?LtrxWiRHJs/JcpJLXWDTso/3aID5at1COtGCcp0G0pP7RsIe5/etmmDet1gA?=
 =?us-ascii?Q?p83Z3Lg8iabl7laac1S+m3e+pyE4Y0E7SDRqs9fcSTFgBZ3NqQoJGc2xPQ8I?=
 =?us-ascii?Q?PYGUflCEFb/vAn0lVmsjPsHvSPZ5ITwx/wWHIBLvuCJxOXUzLH5ob1Sj/BWA?=
 =?us-ascii?Q?q5lVEaKI2YgOmImdQlm1bmsbJ5lgp+j5MQ9x5hsiCJ6oex9yFuOfMiAaH6CU?=
 =?us-ascii?Q?4w3lXIyX1A+zUZjeF1h9ac4Fhw4GBMYdpoqPW112OB+MqVjcLg1nOHJLhUt0?=
 =?us-ascii?Q?0EIaRFm90ahutRrZNIQXPoXU+rK0c1ftfebDsBSsSzIzwHkAW2JIDGjzwNuf?=
 =?us-ascii?Q?vV8tU/kLjfi/pSSZUp2iEYxs5gd+iJyEPa6h0IIYBHfu2ZI1A51+Ew4lDpl7?=
 =?us-ascii?Q?hTtAJKLRyOmGPl/L2BF4xMCcfuaxZvdRCKhieiGfoQJlt6RBuWyqs/yahPy4?=
 =?us-ascii?Q?FaxJtpYYGydzaWfDKBs0cgD56rWlSpupvdShtN8U0d4SDCFH13Ye4Y7D2L9L?=
 =?us-ascii?Q?Aduyzf/lcO2AI7HfG3p7ANwDEeNSDWg7d1huPKtATWkTt9NLQNjLRaqWJUxh?=
 =?us-ascii?Q?/s1d/IKPbhiWmSmZtbvRAYZdh9FIhMC4SKnjrinGQ05Djy6qqdT7kAeB4rCF?=
 =?us-ascii?Q?2aLObbfDQkJhp18DPhhPryue9OcNraYRyiO7D1zq1K1oxTslGTGYh9Tx3Fre?=
 =?us-ascii?Q?wpojcIZrHX/ZuiLcL5B/SpfhC+q9ZQ8Xhjse1mpOubF24KUOw1KzlTdU8J5d?=
 =?us-ascii?Q?7iXBV0T0NYYme02xbyItFz4MPcX/BG5Qa1rlHKp2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a408f6-1e34-457b-24a5-08dd15bf053e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:27:13.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CIuGf88naFTMToxCGrQ0/isUWzTs4OMnaLTwDtT5cdJWBcuDZzZTmjXJAh1YjUUsWf5die2sVn5Pgj0ybjA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

On Thu, Dec 05, 2024 at 04:28:38PM -0600, Mario Limonciello wrote:
> commit 18d9b5227121 ("cpufreq/amd-pstate: Use nominal perf for limits
> when boost is disabled") introduced different semantics for min/max limits
> based upon whether the user turned off boost from sysfs.
> 
> This however is not necessary when the highest perf value is the boost
> numerator.
> 
> Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Fixes: 18d9b5227121 ("cpufreq/amd-pstate: Use nominal perf for limits when boost is disabled")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 738f63d70546f..14bd6faa3d730 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -601,16 +601,13 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  
>  static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  {
> -	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf;
> +	u32 max_limit_perf, min_limit_perf, lowest_perf, max_perf, max_freq;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	if (cpudata->boost_supported && !policy->boost_enabled)
> -		max_perf = READ_ONCE(cpudata->nominal_perf);
> -	else
> -		max_perf = READ_ONCE(cpudata->highest_perf);
> -
> -	max_limit_perf = div_u64(policy->max * max_perf, policy->cpuinfo.max_freq);
> -	min_limit_perf = div_u64(policy->min * max_perf, policy->cpuinfo.max_freq);
> +	max_perf = READ_ONCE(cpudata->highest_perf);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +	max_limit_perf = div_u64(policy->max * max_perf, max_freq);
> +	min_limit_perf = div_u64(policy->min * max_perf, max_freq);

Looks good to me.

At some point in the future, we should consider using nominal_perf and
nominal_freq as the baseline for the freq-->perf and perf-->freq
conversions. That is invariant to boost being enabled or not.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.




>  
>  	lowest_perf = READ_ONCE(cpudata->lowest_perf);
>  	if (min_limit_perf < lowest_perf)
> -- 
> 2.43.0
> 

