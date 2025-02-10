Return-Path: <linux-pm+bounces-21662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9DA2E821
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7221883540
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6231C3C13;
	Mon, 10 Feb 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1JMYmsaj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A462B2DA;
	Mon, 10 Feb 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180857; cv=fail; b=Bf1aruL2JPF2DGb/GVMTnvTD71rFubkiFS6TCX+GNtMOpAVj1AbT4yqKtWeQs2CuIZ+dgSxDaFUfjDgN1fkWEtbBG9Nf3Ig0XV+CiA3a4JPo1cQLcIBMpNdLS4AoVthH1Rj94oySQVjUL5kAE1EIYabzr1enABxtCw9CRWXlpzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180857; c=relaxed/simple;
	bh=tmYVCqkyF/x3fGix8oUdJj4Ynaycay1Ih0ByQhDqH0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HR3bOemFpsTnFIPQBwxSZL0O3+PJTLXxTjqDclvYiK4HPjjuS56M7KqzxUyBeanRBFKOZMwHD9ZsnvkBw3lqu4xGTSNLwujfa0j7WNnFU6XK5pPFo3bGohp/IQd9pOr759B6OWhyFEEJkkDakrf7OEPEl5dwakhApV9g+r36JLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1JMYmsaj; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alBcSCGVzgnNmbAGCrfABkMuZg3KPu3b83z8A4EJIdvejDrQ/q+PJzsjw2p/1CwQTOHcjmj0HSTvixQXg18T4l9Kp1LoHWWKoILDWT8qQ1bWx8Ozl/SYYwRnbeVp1mQfIGFThYxVRd/i4XbTvYjMx5AewwZQ5Me7TqQIRnToGtMaGbyTgE5HPnoAbDVZY7dXSIJk3qgHD1wSW+SBJGQ5qHrB3JGGaBG//u01Shy1T3QObD4GGeG8xymG5owQtnDLL8yekk0rRz5EUayE2LXxXKbXT2uiA8xdxUp1nUiX/GIUu922RGXfq2mwJeQclrrfpGWMQJVtU9kyQkMQW0nQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IB2ltcK3VUW/6pqAFCQC3LzpKMIDfhS5osRupCZy5qA=;
 b=w/p2hzBMt7kTsu+s6TYErUdNE2TsdCNBVUIWD6utce5mHWVORALZK7/b12CHSfYa8jR3qt+KV/KBMj84wybCrC+HX2MA1JtdoJayocEDPSuT3UgiQUim7UZGW4k0JGu/PtssQ1Td229SA2Utx5cO61yLRLpo3lGFdF0xvgtNehVCbK579yblzS/qRzoftnbvfo1WoVI2gqv+fH+V8LoXOdg2DeboyLsfPaDQQ3I0Jh+/QQ+qDJEU5F1S44OxPawkyE+qhBWPEIEA4xc3wheqoejuVBF8+A/Hmn0jxfRCwx41ra32BHdBK2SZiow88cGs3K16QHx5Is4ChBxCaeEh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB2ltcK3VUW/6pqAFCQC3LzpKMIDfhS5osRupCZy5qA=;
 b=1JMYmsajg3/oSR1JIf4XuLrZaVfTwvdZZGtDps3rjKLUrm+YSB+IOuPrOv25rmathJ1x8et6Gkf41UH0kMYrgoNZT2LJ1GBVnyYus47hN1nOOe0L5OgAlTAus3Tno51GiXD5QfmoVDwQbeUJBC/YmsXCd2WuPag1X1JF+71kRnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:47:33 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:47:33 +0000
Date: Mon, 10 Feb 2025 15:17:24 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/12] cpufreq/amd-pstate: Pass min/max_limit_perf as
 min/max_perf to amd_pstate_update
Message-ID: <Z6nLLOITCy7H5oFg@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-6-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-6-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN2PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::29) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f9aa77-8ffe-4c64-e3f9-08dd49b7f16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HxsV4C4di5QUXztZjCtnFVVHOqqVyOtqx6fcCS/c8eVH6+tGk9/k7utFqNT5?=
 =?us-ascii?Q?1S4mqeSxfQVjkPSRyJBaPRSmjCaVUhAhhZ5c6qjoqY+MzlOlAHhjCLAsJ8gI?=
 =?us-ascii?Q?jxqMytqcFLhmfXcc0iwXqMYjT55ArDop+Sv5fzkL/WLEkNIiuWTcKKoW6U5s?=
 =?us-ascii?Q?dt8xepLR3jZlHcKGvGHDxFJFOFChMCqzx+LXcCylaVlrUXUOD+FXzB3gJO4e?=
 =?us-ascii?Q?8SCytYChybMBzJaasgNUfssE91sth9jBD4ENDcRjVoPPFMlauBMMPADj++K5?=
 =?us-ascii?Q?7Su2oiB1r1CmIYsJYLVniXt9Jqz/FmGkkJ1hNuLZacepblA5aUAFcDTT/gDJ?=
 =?us-ascii?Q?/LtYdicT2HvXICiKINJy+lhKHxC/P0o9Cgiyr6Y8tUarXzXs4my/1zBLHyam?=
 =?us-ascii?Q?xfZnVtUmiIIrVQqwFesvEvH0TRxyPxyU/4oF2Fv/P8UrdIRAn297qKzyzNqy?=
 =?us-ascii?Q?k8GFl5ttmdIcwk4gtnGPbemDeq3u70rLFcCnnf4+zyllwXGeP/nxVcKSu4hz?=
 =?us-ascii?Q?n9dbU+HXVNMYApT09CrsSMkNKOZsEirOTc7D4GHG7+ZPBCwes5OvHc4fm1lY?=
 =?us-ascii?Q?kOHIZaXKXO7U9LZ18y3Tt7uMhBBo6+f0OaprdEQrj0v7JNKhfyrlzVikB8Qx?=
 =?us-ascii?Q?nUl3N57qWcjQCdQn5mvXKvOUW/KmmW7kEtL3gdXJ7ycj1CwdSmi++UOel430?=
 =?us-ascii?Q?lDhxiWJtKs9xidc2JVFi8fn+iNppQwd8Rkv0l6KUv00i8T2YKtrUpYbqcw0T?=
 =?us-ascii?Q?K1JofoSiwLiCMta0GhK+wODq6z8dEoGBWxNXRnLgsdSIu/YtW/09yhJK8QaE?=
 =?us-ascii?Q?MO/KF5aj0xr2iyR23miEEvYdlaH1cz+Zm55T/J/duYpqo5X8PFjjS5vK+MtA?=
 =?us-ascii?Q?J+JqS4SkV/F8FbqZxoi1Iwv+y6IFuBqYQNVOegHdM3z+R8It6QLXVM1+wWrq?=
 =?us-ascii?Q?Nw1/JchOjWkItcwbNSOi2TlE89BhegTpEP2s7pS+IDwEFrt81xBTjx9hAC/L?=
 =?us-ascii?Q?wN52FA1hDComY1ftAagcCaiVpj2+rXP+ErG4SP/T0rLAngx/KLJd5HWQPz6T?=
 =?us-ascii?Q?x47LRbf4MNjSJrhJ/aFWIXkc1SxGjKLF3RvyeHbnBIilvqiWQUFbx4/UrjfE?=
 =?us-ascii?Q?KW1OIXGvLO6TobcXEAF4LBJcTxvBMoHkqkpgqoCyLjNQKipLRTS5Z3DgTtL1?=
 =?us-ascii?Q?/AlrdXKcuCMXnK9Rg01k9QFY54pbX7CyZLCMngbNe5NMeAz/bN3+OTA60tza?=
 =?us-ascii?Q?Qtx9OsGRkXsHLL7oAi5faRKeuGoqrOtUruZTPorL1BlMi32swB986QrVhoBh?=
 =?us-ascii?Q?xrfepByulQx5Byz9wK7Rpfjxj/9+JM/ojXJe3ZnuKKjSb7+RlW09LX5o+JAX?=
 =?us-ascii?Q?4k8CI4QsVtrzFvCSoksqr8cgVmd8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hcS61Ktobxnbc/zRr53KCYII/oPaf2ULNe9yFncn+IrMXK9iJlrmbSVO2M0T?=
 =?us-ascii?Q?3zqe8J1Btw61a9pFkr0EugxU+q8sdEJCypP8X+uCaVLV6UMBR9dsgOGWF9QX?=
 =?us-ascii?Q?80sBIRSgbGhZICOgkV6cARmmN4XuE9UzkEUGvY1s4QCPr6L2iUDxC/BwFPKr?=
 =?us-ascii?Q?juIz1WBHbVCotF8Y/lB7ymJlQzY8DfJvF87TRAIL5bH6XcN0N8/hvuqTgj7d?=
 =?us-ascii?Q?miLbD7t1nRz3Zz1JRePj9yq/JbTVphSA64pg9cUWxYOqqqFTRiS0B2t+Bxa+?=
 =?us-ascii?Q?1Cbyw6zgsLNHpzKGozyKGQLZLZFo3YyJPN0xtry/DUVl0UzdKhYpib3Oz6KO?=
 =?us-ascii?Q?fvUutYiLgO2Pg1UQgwe7pIdQz/kck3D2O3NPEert6s22Kb6pT7lIR9Big+HZ?=
 =?us-ascii?Q?7Kmo6spK98vdJA2+bj8RobThBDzPNt2h1gJ7mY4Yh3A0D6+nUo/nY4dN4I7X?=
 =?us-ascii?Q?EL9cwIZc7YcIev0RJ16i8efSVe5ZWEG0H66veV9ctLQrgur68L4+pKKP2OF+?=
 =?us-ascii?Q?hpHovfg3jTtx9GQNR7LpMcvrwfJB+12MVKXJeolq+tMEiKW3lqrOWS2MTdxJ?=
 =?us-ascii?Q?SbSvGE6FBP953OT+XVzWIvFty+mxm5MrTUmsmP7R48Zv54AdvLcLsJbiAiZh?=
 =?us-ascii?Q?VqfG8GE92lDM/UE9G/iQoHG8BVyQOnwVLwOxKimMrD8kcPJRIwLzTYtQe8X0?=
 =?us-ascii?Q?+SOf4tntKPfkQcwkpd7Op3G6rtVCHQA78rRR0r2/LIYC4RMmYsWNgLsCF0h+?=
 =?us-ascii?Q?QAaec7yLx+1TmJypLxyx/yb0ee2fnxXHeXw0aenDQv8No0dQuU6gBBUccCPU?=
 =?us-ascii?Q?3KQAgoG64a6lm2EAc3HZ+EcUnKZgt8EqNP8c4uQ46D0XsQI2zltSFxeoEKIl?=
 =?us-ascii?Q?hBwxVs60y8plD6nHVC1VHBxCQIw8Ffmp+1/5r19pSyBPmEW/z2cnm7m1r58/?=
 =?us-ascii?Q?Y/J+ge0Cp13bIMph71esb2W1B6NLT+pW0H1PkI1+AlOi0VtzGmZOjhyVVirX?=
 =?us-ascii?Q?lPYArOurOmXqKoQt34kA+ctdlUK1ONwxR90FCG+8PcYw8cp9aVGECt+wj/pe?=
 =?us-ascii?Q?ZowxZmmWd2K5hgMQNckfe9oUjvGn+4BJgmvxfWa3xRQxLOS1MuP8lM39jqox?=
 =?us-ascii?Q?EFPvWs9v9awKVKQUtvcmYZH3mcqH+cPVdAczq9OSQvdBXRiyFicvOGiUcnZ6?=
 =?us-ascii?Q?eNIjhd6Ef8Ox/f16ox0zxwZ4AvBmTEeGomZRjwD2oqAanSfRqtxt+kWVU2u5?=
 =?us-ascii?Q?a3OLYbkTPKDRDojWkfwnkp2X/taE4Pf5eYOyw7I3a9TI9u+12Rz6bwqe6M5j?=
 =?us-ascii?Q?891YSLBlMcbCoiusHzEXoFtD/Az2qimN1NW3At0sECBxNNRiApB+hsbfeH1L?=
 =?us-ascii?Q?w1rtaxTN8sp4f4Z2o3gHChyaBoh3Idss6QgO+9gZpGOVX3ZmpMxhbthP9uaw?=
 =?us-ascii?Q?EakdK90YK3C1Va4jk0egyAlc4w3lLlGA49EARWXpAgqXrKSNpZ9w272xVubG?=
 =?us-ascii?Q?VBpO3V5uMhtTaij4/Nxjpd9ehF0qPPMOJStO5sKn0pm6RuYWoOouAI9FdKeO?=
 =?us-ascii?Q?s/to6P1I3tLGl07zKCTnHWhIUbp9m+WL4T3k42gx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f9aa77-8ffe-4c64-e3f9-08dd49b7f16f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:47:33.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dmlpsPsPWfdq2XXm0LUdlX4za5cwjcmp56C7iF0GQCz70SRRpV/WE9uvvg9f3k9/9Mf4Zxn8ES96AK2D+TlEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

On Wed, Feb 05, 2025 at 11:25:16AM +0000, Dhananjay Ugwekar wrote:
> Currently, amd_pstate_update_freq passes the hardware perf limits as
> min/max_perf to amd_pstate_update, which eventually gets programmed into
> the min/max_perf fields of the CPPC_REQ register.
> 
> Instead pass the effective perf limits i.e. min/max_limit_perf values to
> amd_pstate_update as min/max_perf.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2926f292be7b..e179e929b941 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -615,7 +615,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  {
>  	struct cpufreq_freqs freqs;
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	unsigned long max_perf, min_perf, des_perf, cap_perf;
> +	unsigned long des_perf, cap_perf;
>  
>  	if (!cpudata->max_freq)
>  		return -ENODEV;
> @@ -624,8 +624,6 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  		amd_pstate_update_min_max_limit(policy);
>  
>  	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	min_perf = READ_ONCE(cpudata->lowest_perf);
> -	max_perf = cap_perf;
>  
>  	freqs.old = policy->cur;
>  	freqs.new = target_freq;
> @@ -642,8 +640,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  	if (!fast_switch)
>  		cpufreq_freq_transition_begin(policy, &freqs);
>  
> -	amd_pstate_update(cpudata, min_perf, des_perf,
> -			max_perf, fast_switch, policy->governor->flags);
> +	amd_pstate_update(cpudata, cpudata->min_limit_perf, des_perf,
> +			  cpudata->max_limit_perf, fast_switch,
> +			  policy->governor->flags);
>  
>  	if (!fast_switch)
>  		cpufreq_freq_transition_end(policy, &freqs, false);
> -- 
> 2.34.1
> 

