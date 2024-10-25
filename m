Return-Path: <linux-pm+bounces-16477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3659B0A96
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 19:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60271F24B59
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE932003B4;
	Fri, 25 Oct 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oD+FengK"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B191C173D;
	Fri, 25 Oct 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876325; cv=fail; b=NMOLWrXirR2KU9/LJuCw0E8y57aZzU7hnRo11y/RDRoz4BIQKz/kFEg/Arhx35nnnZ2JSHhWUxk9FkJn7ml/WbwdYz/mkkZVk2z1p4YFqVF4aEw1d1dSnuLz45645OFjuzMyzWLmcDwswuv7MsyvCq1s3dQDRm3r4iwGH36oqZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876325; c=relaxed/simple;
	bh=NQ+yEFJhM+ZTPX653596lNPtVUA4KArWkk97B/VjWpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XpsfY/izfVYbk9UcwZ1YCSeoAWFQJKLXUOzq8XBjjkN2Ry8sf2JnH3VzuLhFSSqAgTDCBdU5NGvIEt2FUypGfFi5a2qdGmAxaV4t+n0yIlNPb7ycwFuYGxDmOxhXpJkJouajLqFcOLlwMDULP8DGzkipDMRXR7s4703hKURp4Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oD+FengK; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4Bz+7i3pP9RRmNQNkwHA67l0w5oWbRcQZuKD4QhM4GH/owUZQIaMB+SM9diSu7SxmqEWOhMl3NCPhLCXq3npnxFfCnN8jfNhnQhddA8b/OU8d0r0+7EY9y1x0s+IrvTVcU4pR6WlDcgloQ3IOvqbRhVDejFNFi85nPtgJ4HCpzok5T4HysEHXhy4r1ORg++Wwj/eGv4HwiLh/FbhyBSHLwaOmBbEWZHx0feCoOUuJGusKZ1ahX3ivIlrGpmlURvLdCmVBXI4usEL04LByk231WPh5xijwS93Xjyv8vyQ+TnCtvrp2+FnvuRbxpWFSsqf60z+/pepIBqsD4JVP3QSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqHBwXAH2y3myo1qCC6yqA7DXoSFbjKmPYh9um57pi4=;
 b=NNLgvitPVzdwYq5meHrmoMZUwpdazHqf+wYW8Hduz/wGTuuh6pLavadS0ZdF6TYGO5eGwxJh0hn8ByB6Ci+sf/OUT6DYcj7rod8sn35vR9SMEtpFzc2k1N2tiRMaHfVSxE3fS6MyadRNMaRoaIhl8TVwr1HBhtFvjTreDTbvOCBzrUjGze4PUoOFLz7GqEFnsu8VRn/mTQHWz+90w8zUY/IlEPoL5aZQ7AMufE1+DQ/x5z0TrExXTv6A6rGZP/TBl8xkuUebiP7YvyxHf9XbK4oy4OnzonpCl4PtfUWvqBfSZ6bw897ZoKr+5veEWWawfDKazGs/z7BJQlR0q9p7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqHBwXAH2y3myo1qCC6yqA7DXoSFbjKmPYh9um57pi4=;
 b=oD+FengKHWBpe1uQ+5o8BN2HLOmMzK456sbLTE0UcqF55WKw/zxcZNz0/jBNuTNMUwsvHsY+evvnTmu8amq2CrKmqFgVvESps/XoqG8fVU8aO5dgkgIYwKItL9hjgAD3yIRkix+Ux+YHWKFuL9fjeRaogP8MUkyBt4Fk8FRd92I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.23; Fri, 25 Oct 2024 17:12:00 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 17:12:00 +0000
Date: Fri, 25 Oct 2024 22:41:48 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] cpufreq/amd-pstate: Align offline flow of shared
 memory and MSR based systems
Message-ID: <ZxvRVGrOIj21+eTa@BLRRASHENOY1.amd.com>
References: <20241023102108.5980-1-Dhananjay.Ugwekar@amd.com>
 <20241023102108.5980-5-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023102108.5980-5-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: dab3a253-e328-423b-e245-08dcf5182356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJ2ZDeD8lW+yeJTBTjYg+yd5skxKnTpeqir6SklMlWrkER0BVPxcIrS3AP3s?=
 =?us-ascii?Q?AEIvF/xt/1d85ZdcLuQrwKMWUXPzw1ZaYx4uNUXVFJab8Y49oIlaItWAaRnt?=
 =?us-ascii?Q?6mummG6pgpDM9oCRqfnDY0rClfHlekn6v+FmksAnfA7ETTi/4QnoJt/XkrfN?=
 =?us-ascii?Q?MBCeHj66ZLOp/8uHhHj828oBX4qBruMuemXaG/brLe4uixaLwnvdQJpFBW7J?=
 =?us-ascii?Q?NycF3oVpPVSDhGjt542cpzSQaqBR0ze0UOlO0QIt8AuSaYFKfZxXWZrRItxG?=
 =?us-ascii?Q?RtMVAZb2Uu8XDwQU6e7r/Mt95fdXh7B4dSaVEPYxY/e6woVmUjTvELBY7Et8?=
 =?us-ascii?Q?vqkfaBpmIe/f8NoM5muVlmybGaxIf1YqnMlJJLIm4/nIwochPzV8GSny6+zK?=
 =?us-ascii?Q?3DUhFIZybqdzUafYmcIvztJrLackfKVZZFbdLpC0UvgytRkhUF+vwXLGDkkQ?=
 =?us-ascii?Q?om+BMO3cg5mCYiTlFUnKrTYYI88Z8h8+HkrMaYPc7mn1mIUbpVRh+h4adcSy?=
 =?us-ascii?Q?/Hl5UVvZSHP4cz6MO933BKFm1JbjhuDjd2lfkx8ow2gJSY24OYhAe7YDktky?=
 =?us-ascii?Q?HGRhldB3hsGBLC58RjyFmyVzFy4doD+qthEz4rhuNQqAL92+13DOhtnzZ4p7?=
 =?us-ascii?Q?gKzZVnCLx/QMC6EISfW4og1DWzuS4GsyhYAuq8kLpzFAfIjQBtNPV3xABI5v?=
 =?us-ascii?Q?b9dOuUOPxlkVjrSLhTBXp+hyw7wWilkpT6XDS4KN1VMLw9Nbgyvj2o7SdHWZ?=
 =?us-ascii?Q?pi4ZPECzKxYzjDM7aw7EpoTErNUaVJ9dc77OmYB9RKl+8myWWmz6VyYyTBeI?=
 =?us-ascii?Q?CHPEbpQlqUeWspxurBqdSWqXCBrccG9SxbJMxwmLsez97bFsFZGi+5xxFUa9?=
 =?us-ascii?Q?hTcZ9U/UGZ/08GCyhImiaQXgv5+c5A56NXumY1yJcgdTDJFUqtGogmEXGmW7?=
 =?us-ascii?Q?58eZ86XWNE4+dKWhE8pZpCQpOVOfLVAxZ/KqWmDQRerov5IBblNMif/U37Rm?=
 =?us-ascii?Q?N89deA363ZYCYtEhA/0uic29i8VvIugVVMfzqnZbu41ssyV+II2XygOqFMKY?=
 =?us-ascii?Q?UQAf3SJM18Pw0/OkLDgiPx0TNY+fRQjHe8hwVvEe/uCxQbwUhLOr0hvabxyo?=
 =?us-ascii?Q?O4jimX0lIjLUrO5X+GTw7maVjfb7J3SVwwYXfFLAkl7QJfZOQXIAme2nLBY1?=
 =?us-ascii?Q?WS/XRG1vR7AJaSAGIHYu2YVix/cB4FLYJQ38WNI5ig6X1AkIaSTLjMvg8QoV?=
 =?us-ascii?Q?7oiITeMQqhtuJZ1GZp63Q7GjEbpEV3VYHJoQ2eiVgbbYMbfxuxKhwn8oCcd3?=
 =?us-ascii?Q?W3f4tTpsRIfZjKQXIWcoZCKD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IYlX7Wjg+3enH+GgG6tFmfN5df6kylTDK6c5AYV8QIaAgJGumGNLtL0P5jOs?=
 =?us-ascii?Q?DDu23hyrCXJ80YgDrOeLLd/Ob604JSVkBtcVIlxLqg5mXAQP/oVl4GsYB1Pc?=
 =?us-ascii?Q?6rRoDKtvKs/atSP0Tm2emJVZW37fKU/8h5flCGdDYcJkEePSNPNNK00jW0E+?=
 =?us-ascii?Q?+VPpaAlPToeuStoWtXG9FJVmkNTeVf67Hgw5a6g+5zFXANjbK7CmjhnHuKSu?=
 =?us-ascii?Q?Pwks22aBi3/9SZQcYn7QmDvwSF8l7FDytTdab5PRCMWYinBT5s6OjltztNRh?=
 =?us-ascii?Q?K/jZF85Tf7x5YGGP3i67fN960hoX8hWZOM4Csm/3JzbsnjXMJXg2tQgRTqJc?=
 =?us-ascii?Q?26vxgx4tKEnZd4619HI81m66BMDVm3HkuCM0HJumomhWQklMC+lHz/WVFPnR?=
 =?us-ascii?Q?pXY+lgk5fLNkEBqjGea3b37UdQigCYOt++YEyPTJMHo08vR0nWzZlj2RJQAw?=
 =?us-ascii?Q?D44Qpq9nbgRKVy5TBPzZIFfWUJeBcN2Cy5hHTPcL8XN+0hNfl4/zMbdFLfCU?=
 =?us-ascii?Q?EIZm0I6ouwYpPb9vlVLK4e4lWSq3YQkeBvaLIrluMBEWh9uBTd07JQ8RzD6V?=
 =?us-ascii?Q?Rbh6N0IK1KPbcu2LSuEheRdfWAQZJyOfUzFmGTXcXXviRXqEVB89qIq9Jd49?=
 =?us-ascii?Q?6E4miHjSbNlE+26Gkv92kgpau3/WsMeMYDvGvVrijX11bIlUtRhW62AGcM82?=
 =?us-ascii?Q?rG7A/Zm9MKZv782XW2lE2McRTI85Whf6AJD2vACv2RRc2R5w65huOtWI5VHA?=
 =?us-ascii?Q?pfNPef6OGR2Y75OoDpNsRT7EIDlJPyc5xufwbLy9MHn9EpbDK2wE1421sD1c?=
 =?us-ascii?Q?l2fL6tFagvOqitjRnPYxhykGBrGA6OpOuMeUJ6BLdshbYgg2CIvaxNPGsDxc?=
 =?us-ascii?Q?YB7+uddN+6Ke33QAJYlMeyY0d6+sOLO9+85Re+Bx71PKENBj+57FlqyR1Fxh?=
 =?us-ascii?Q?/9FpCtl0steXYrZxlHI2dmpRA2wkiZ/4beQb/6oYQNYxl0ndnddk16vP7xhb?=
 =?us-ascii?Q?l8XmdfVBZP/71dELvVp+IIly6aWPHvnxVfUhhmFZNdCD+8kOO3GYA9ea17KL?=
 =?us-ascii?Q?saYVt7jRFBgBJ9D24+HpGQ9eax7FVzQdEcxBJSIYSfEG6/vDu+bq/k1C9Le/?=
 =?us-ascii?Q?0LiNoVO8rjuRyoYBH1MPw6Aic0KYM/jm3DdD7X/8PvvnM6MV4F7FFVuzJWxp?=
 =?us-ascii?Q?XsLr0EK6fmEYCNrHNZPxF48xEAe3Q8EVjkdNrx0BOYiLZHOtGoXaD8PfeO+Q?=
 =?us-ascii?Q?E3cUYpXLxL9cUq9gkMPQceMi+bgGMzm3Z47IAzToPGG65aW+g3td5d2WcNLP?=
 =?us-ascii?Q?t91C3plzfRJ46DfDUPH6PYZnQCARKvAQ6i5zXfs8VA7f7r/+2nQbR5U/vsBy?=
 =?us-ascii?Q?wl7m9pNcrOvX/t8I3P1w0/Y9lgwREsz7cw97MeD4KAFta9NivuScrQ3s7Wk9?=
 =?us-ascii?Q?pYiKi4dMpq7vUnhORxJCqJZmMBJujSTpoFIl7zzI/h/Xo4FqfExMN1ve7xCA?=
 =?us-ascii?Q?nGhsZ9naFxma5X5FqHfXd1p8OVgxvmMqde+hCzd6vNSFqGJ9H1yEKQIVnPdH?=
 =?us-ascii?Q?/Iwx1r5m8tN3cjQPWrAXfEP5Wyk6zRnny5Tmd1ww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab3a253-e328-423b-e245-08dcf5182356
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:12:00.3324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: og0uYQH0kGYBc9T96lfyaomlU6TEudy+oeWWPUT1Jw1flgq1nMxHqyAKQYeo6PajByRpLIUdq9EyuayZXYlNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038

On Wed, Oct 23, 2024 at 10:21:12AM +0000, Dhananjay Ugwekar wrote:
> Set min_perf to lowest_perf for shared memory systems, similar to the MSR
> based systems.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Thanks for fixing this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index bbeddce90823..206725219d8c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1658,6 +1658,7 @@ static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
>  		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
>  	} else {
>  		perf_ctrls.desired_perf = 0;
> +		perf_ctrls.min_perf = min_perf;
>  		perf_ctrls.max_perf = min_perf;
>  		cppc_set_perf(cpudata->cpu, &perf_ctrls);
>  		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
> -- 
> 2.34.1
> 

