Return-Path: <linux-pm+bounces-22181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D406CA37B9B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 07:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4634B3A4DD8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255A18F2C3;
	Mon, 17 Feb 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fDmX9kF5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8C18BC1D;
	Mon, 17 Feb 2025 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774354; cv=fail; b=Ar0VdVBD5+pNQP/c9hD79DF1sjpv8xPOpIriZNKPtoFngSyCIm4yZK6/4fuxv+jAO1VTd3mbrSSBUs18Oipj1dvfvlGL3SaF+9zZsr22Lg46p10X66JId6RcJFyhIpN0nYRKNBK6UesqhVpae8ULbUvwU8XXuD2yI3aO+lmOTOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774354; c=relaxed/simple;
	bh=wgTEy2x5zGO+qw16LyBRJzWqvVIyaFm4FpiYXlFIMEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cIpy1RROAtLZEIpcGnl002tjDeX+nHZV6BD+bxhld2eIYxvSg/049D2r2oAhCVTE7hZpJfsflgA2WVtJli5MWFK5omA3W90241lytiZTX27FTXBygB2IT4WkGkf2pgpc1N9GNmviiB1n5r92N8i9N2wC2u81puDN1w4rL7jQTkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fDmX9kF5; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5c6bRMDTnSiLRSDpDuk5tyfAPa1R7x89rH/M+QxPZK7yjkE7F4tuNN1xCl+AhMDaspzaAsRZJ9sSLcQL7Bo/2Yv+Pr/bbM84cGlwtFto3eGDpVnsR5FtwAbN6ezKOLC2Jqd8U9eP0y3pnWCQ95BJ+sz8APIloYIbkRKpXAVxGYa8A8Wq66fSXuS82YtJGoQens5UrszHK82Nu5o2uEgZPA6zvpnC0sffSQpJ1d9fcq6CKGFUdJvlFP2/niRehs+WTkpnxhRk7zn8IPdsCHIEXD3ye5RFJb4JmNb7ISJM/tNH4NOAaJ6HaIev8kYmJzokL2CM2sEWuMCQqySroO1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqsOlFrK2boGFTRir6sGXZdYS33G7leiLs0oygQYz6I=;
 b=jBCcKnV0GTNmrwvq5N4denVBQZqKamEOsuMJXMjyGuuV0N4Kwz5RTV7xeFLSH3xHgzxG4+HUeYjlJ6cfCvHS0R6kIEYcMYHfnaGswXJ0twql3BLxRP6YZRL7Bmg2Xh3BqyXpxSRTi1nDeCazf0znj343F4zLwaWJ/5mCt4IlUMgCNSXFN9h8dMfaN1upiDEw+msRkoHuSZrpbZVqHiShnmgTfWffeB2paqbQneub4+6028NjOKdOiQ1ULfHqHzTLMInyD6ot6T00BVSV41yM2fW3xTjvnN6sTSAkxVkzWEJNa9YqZV1S0YFJznHwLGvIIC5qB+aVJjtvLJ4ijWIbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqsOlFrK2boGFTRir6sGXZdYS33G7leiLs0oygQYz6I=;
 b=fDmX9kF5cyfSEVlCV+Vc83gVlQPC47yw+iHq5ERpk10nyc5rrSDhwBZV2ikMg6YmG2EnaPeMqt7BuByW45lsF0qH7zTY6uude3eeX5AnolRpllH4TW+j9U720dIODPdU6yMl4a+ybBiMCDsh0cdJB69wXprsY6TDu2BvyfpNNpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 06:39:10 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 06:39:10 +0000
Date: Mon, 17 Feb 2025 12:08:59 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 02/17] cpufreq/amd-pstate: Drop min and max cached
 frequencies
Message-ID: <Z7LZg8oq3LqfKZID@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-3-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-3-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9bdb26-e54c-4c00-87d8-08dd4f1dc8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JoLv+mc11uojPFpt5Dd4pDqwo61P87C39S1/TrvqFW/oWVvvcBBW7VgJU5L?=
 =?us-ascii?Q?cASACPhkjLbw6DWevUV2lpPvOqU02tpL0B5qymD9IiASeF2U3PrOcbHBecqn?=
 =?us-ascii?Q?gTH1Yds/kfgX9ix+TWTIFyfdOQhrpGQQvmJqQRGXmuoZ/z7MO1zxunamyZ36?=
 =?us-ascii?Q?bmZzUVY36xCfaHSCSwTGyMb9OkB5pjv5BsC5DTz7T2QNg3UfS5gaI1DWifN4?=
 =?us-ascii?Q?z2gfBALFoNW7SL8Y13+DXMXEjHLms5BVpA2cWNIk4+ffSgqSGRjyGrwqwM6u?=
 =?us-ascii?Q?Espc9Du096m0d9wVA/35zJgvOceu4QReXuHxWLMAdFA+5iO38npszCbrPuWV?=
 =?us-ascii?Q?95SE6RbCktff2B9QEANIk1Jv3xuWI1NIOO3ND2PywsTnrLCcO1LTkS4YKQfj?=
 =?us-ascii?Q?zuaDoeF0Bcnsv/Gm1xlaMjxItzlm+FCwVol5otFaBv8uZWZT0sOjDWMYidBe?=
 =?us-ascii?Q?kQrm6y6QJ+yRbkjZUgvZ4SMGQfaI+usR+q/pq10IXBDA4CnVXw4j5QNGkILM?=
 =?us-ascii?Q?tR+IWiXRETEaOBcYlEL0SEL+Tdn1ftKDg4vUaY2/MEqpCNqQ6nYGGbEXnlqM?=
 =?us-ascii?Q?aW/0OwvASeU6tJtpciIjQI32RupHJkxk6dDKkSa1orDjNz390FtofiogaPAG?=
 =?us-ascii?Q?1r+/qw/kKCxNWKY7Tn2bhoLEhp0xH7NXbs8+EV5aUoWBuCJJO9mwI0pxpvtU?=
 =?us-ascii?Q?p7AfAsadeuBtkZRcj6/EVoNXIxa67mXiFD4imb0C9HFNmK/7o5NO9wlfyu4R?=
 =?us-ascii?Q?1Uo5mOLyLYA1PaUVVw/hgCAwGqTo34oXOmjdOv4AfqwnPs+7e7Es97mmktJG?=
 =?us-ascii?Q?xlYcsjl/WiyLhRSCKrv3xdVjRvLAFGz9OJ3+8Jy88N52vUVK3YaB92xlo5HY?=
 =?us-ascii?Q?TS/QpPliSsOZ28aU9K1khbQPqypF8ZQIMMoHld1/HOflij+YRviw13HHlGR7?=
 =?us-ascii?Q?vT6oEPc0ZHVrViToBfEferRi8i3e2IaJr25TAeuLJ6ypkVGby2QIL+CDQR9V?=
 =?us-ascii?Q?rFagbJvfbsoscD1VChYnoN/J1irSSmbOvCSfkZ2y0EZ8z3zP/NjICzxuTUx8?=
 =?us-ascii?Q?O4jvQenNzfngszxjSTAPsZgjYFXNK9+Pcwwy3zsvoatHZSgsPQ1Q6lHIXGqG?=
 =?us-ascii?Q?muQkUGpo621aLZxs4Z9ozBAA2efVwATEK9gPmX9QHma246x64V2UsQOpGCVs?=
 =?us-ascii?Q?2lh1nRZDqjtgoptiCfpz3TLU+VNFo+/pjRDztNrPNE66eYDycxW59Q3td/3W?=
 =?us-ascii?Q?MOfdF2L2qA0aHak1/piJh5dwuovr65QJxTHJCreprup8gVbV8igSMSUFZ2uz?=
 =?us-ascii?Q?QNn9soYaFpK3uDqoJQQlhyKXPayzpaVI2leXgeO7maGQIlumxGo8srxPUWUO?=
 =?us-ascii?Q?ei6+aI+KouFOUqxVZ4Lq0m88MoNQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vuhn4xm2gz/imcUlZ1fJYXdCBYggKbvpmJfV4XFJmWpChsDyru0FOafydWBh?=
 =?us-ascii?Q?Wcjjk9kscJyU+raFDc7S3bKb3VjFNHq7+6/XqmSPoeq2+bD27SrrwmjRb9EP?=
 =?us-ascii?Q?92mpDwcUnaC2ludMqPUclqgLy/G5tTJUQlJu0msTDXs5VtMp0jAPRsA+uoxf?=
 =?us-ascii?Q?f4gCJg3HuJf4Mvu68mzhI/JXFq90Za1nT822/lvCmVL+PQ54YymlC5MIiBPI?=
 =?us-ascii?Q?HvJFGBucwZvKyIXg0RpOjTEWwHmEv+E9OcGls0Td+TOQz+VV9o9KjY5JlRSS?=
 =?us-ascii?Q?HO4qmmGmX/E/1eYvmFIklsY0idMTh7cptsXGHo9sjLYpqn64yP1bYJz4/M4H?=
 =?us-ascii?Q?59rSRhrKda7rUXGnNmB43Ox1NsoKt9l50EqTnr0v2jGsThtNH1AM+1ywqYS5?=
 =?us-ascii?Q?eqtTdKyD7Kcfmfm7s6HEurmQl/dws2kMnc2NOZzlbwy+x2YUWZqvql3pE5Uw?=
 =?us-ascii?Q?Bt359kwrwM3N6AiH21cjnhIkZpZWgHliD7dkgu4kAKpwQey4jAvA1vjpeksh?=
 =?us-ascii?Q?fTYjb9XsxGShG2WXZ0Y+GjammlRMie1MwpXslPQSmHxq5oAY97MMLzg7DXYx?=
 =?us-ascii?Q?V8upFHPmc0HvfzcqnlDCON1kq8A1vldiKv3WxLZd3Pd1cRC2FP2hgfUHlCeL?=
 =?us-ascii?Q?GuLsXN2t0+a/B7E+PA8zuq1Syo30k2woCjxiqqOCpcasDXRbF4vDawUglWNp?=
 =?us-ascii?Q?zdGeyhQM0UepPPV8k2SkTJg1docW0FqBPMam0noekr46fvqzZGXqIRgJkgTh?=
 =?us-ascii?Q?rH+fvpTV9KmEK/nR/YANbc+PD50tIal5OdAc5F0F7MUHTuGyU5BvMT/8qK/G?=
 =?us-ascii?Q?RpawoEO4bA/qSRU8UAdrvmIE/5SR03bhQEsbBMOx6L05ngz//XzBU2njSPrA?=
 =?us-ascii?Q?kiokhqIkNB5gZz5NRs43jcfIgAEqO+ZsNTkYQzsAFRFe0LHfy5ibF3q2sHz9?=
 =?us-ascii?Q?ei2jtkRhQZR2sj09d2y2HvwQE6xascn/Uv+f9fwSXwHbAFNPWkm6ymQqrgrE?=
 =?us-ascii?Q?vyHk0I2izFF5uJCGonbsZCGf5Ppa+JNvLBvVYjsbRyfAyg3+AXSqnsSwgiYk?=
 =?us-ascii?Q?AoNpBfy4to3U2Bu9FKg6sbuW2uK0qG9BQ4PyEJJTQ2qCSY1JwxHJ3ERBKHzS?=
 =?us-ascii?Q?l4VZQI/TdqQ1zTg9X7Xt0VPp+cxNGIL2KNXroTu4pEkb/UXdCQdcNqD2RfhP?=
 =?us-ascii?Q?zffL3OkXY/IrvYRThvxFSLeJ4vKzwP0cjF2LQ9dLGhrRKF7ZkMRNPrD937SS?=
 =?us-ascii?Q?wHaV13Z2mSH2CgNj4/RrA5kcngco+bOTlT2EB4ylVa4mut+zIRoK5/v4HZJC?=
 =?us-ascii?Q?p0xoz7rfJoQeKKWjJHnwW2yuaUoczmIsRKCb4HC+I5AI3BH8/qoVEdm6rf4Y?=
 =?us-ascii?Q?JcFxzDszgzNm1QGmX8GYXcMf/Qye5RXDGx/FTxXA/BG0TGQsDixKHriqVrlN?=
 =?us-ascii?Q?EkgBpDjQtimlVrsdUj6MLVmx3XKEvlwafgB2scc/iv8FgpAj18WUkMxlbZhs?=
 =?us-ascii?Q?srwAWV8MXfEko66a9pbBusytCc2x+2Bd2KFj1Z1KsfqoSckdKiDKodv5hQn2?=
 =?us-ascii?Q?hMwko55UcXqdRRQwyQ8WXZ5J60F4a6ess9RlSPkT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9bdb26-e54c-4c00-87d8-08dd4f1dc8cb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 06:39:10.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNSY7K83Qf1LOHY742eDaVrThVq7vN3lmp5ut8g5vFUZhzOkYf5EKP5okHBFoj7zluyz4HdjkAxxh9sNWtQBow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

Hello Mario,

On Fri, Feb 14, 2025 at 06:52:29PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Use the perf_to_freq helpers to calculate this on the fly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> --
> v2:
>  * Keep cached limits
> ---

[..snip..]

> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -717,7 +717,7 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  	int ret = 0;
>  
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	max_freq = READ_ONCE(cpudata->max_freq);
> +	max_freq = perf_to_freq(cpudata, READ_ONCE(cpudata->highest_perf));
>  
>  	if (on)
>  		policy->cpuinfo.max_freq = max_freq;
> @@ -901,35 +901,25 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>  static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
>  	int ret;
> -	u32 min_freq, max_freq;
> -	u32 nominal_freq, lowest_nonlinear_freq;
> +	u32 min_freq, nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
>  
> -	if (quirks && quirks->lowest_freq)
> -		min_freq = quirks->lowest_freq;
> -	else
> -		min_freq = cppc_perf.lowest_freq;
> -
>  	if (quirks && quirks->nominal_freq)
>  		nominal_freq = quirks->nominal_freq;
>  	else
>  		nominal_freq = cppc_perf.nominal_freq;
>  
> -	min_freq *= 1000;
>  	nominal_freq *= 1000;
> -
>  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);

So cpudata->nominal_freq will be in KHz here.


> -	WRITE_ONCE(cpudata->min_freq, min_freq);
> -
> -	max_freq = perf_to_freq(cpudata, cpudata->highest_perf);
> -	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);
>  
> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> -	WRITE_ONCE(cpudata->max_freq, max_freq);
> +	if (quirks && quirks->lowest_freq) {
> +		min_freq = quirks->lowest_freq;
> +	} else
> +		min_freq = cppc_perf.lowest_freq;
>

Since cppc_perf exposes the frequency values in MHz, min_freq is in MHz.

>  	/**
>  	 * Below values need to be initialized correctly, otherwise driver will fail to load
> @@ -937,12 +927,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>  	 * Check _CPC in ACPI table objects if any values are incorrect
>  	 */
> -	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
> -		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> -			min_freq, max_freq, nominal_freq);
> +	if (nominal_freq <= 0) {
> +		pr_err("nominal_freq(%d) value is incorrect\n",
> +			nominal_freq);
>  		return -EINVAL;
>  	}
>  
> +	lowest_nonlinear_freq = perf_to_freq(cpudata, cpudata->lowest_nonlinear_perf);

Since lowest_nonlinear_freq will be computed using cpudata->nominal_freq, the former will be in KHz.

> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> +
>  	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

And thus since lowest_nonlinear_freq is in KHz and min_freq is in MHz, this check will always be true.

Shouldn't the min_freq be multiplied by 1000 ? 
   

>  		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>  			lowest_nonlinear_freq, min_freq, nominal_freq);


-- 
Thanks and Regards
gautham.

