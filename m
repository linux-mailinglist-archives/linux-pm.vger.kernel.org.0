Return-Path: <linux-pm+bounces-18704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA39E7379
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A521F1888018
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5AB207DFD;
	Fri,  6 Dec 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a4iK7ous"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250391514CE;
	Fri,  6 Dec 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498398; cv=fail; b=QbSIGs00spfm75GyQyw5Va9hQq8tzTLVTgeLv8xV9L7rDk7S5KdtXlxDtCyHR1bXo/dHNR7xkXL835F7zl7jMx+rPzTqHt3AVQm0v95L6y1e60YSLpFithsF3ZwPuwPNE6ix7s+Zx9bnZ1qL8EnQQgucd9dgxvWiWb6Z5Nq6as4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498398; c=relaxed/simple;
	bh=8DfUI8h+eJM2cNuwbI66pBn9VOn2bCBqJSdrTiWQgds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eO276Xz1qXH5yBUmyJRlbgpXsNgyuSdgnUVfgamCouGQFR8R8On1kN2Vgo53DF8gcrzJaMAPKTbzblTSgipxIHmYLpsuCLzoWe4P9ID9gfyWGfxCA5O4bibODoWfDTptqXUlYjXXxUc5W3tb5OFlNvnKeiJDdrCABiwUkGyyByI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a4iK7ous; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbyCixA6ANIImcDYt1vuXJUOVXSdtQVgL+WHz1r2OMHEqCVlOHlkvm12WM42NvBfwB9S3AtH0G+4UMs2ojTc/vdgf0irzGdk5Y68uSs7OwiOOKmFVp1m5Dd3aWDaVTSsJ1+UN/BDtYwpk72xoVPgXw44LY0Mu1FbZN1KWe14IS7lW21iZdeaWJVq/DDAyDb3t7aWLDgFeAkMDhevXEs7Tw/9LnVcxelDXQhz3nQocnazyz4RWlHAiNkt5F0ddwN8sNEHfU1zxIOFEsP7Wv7XjlEcOkBfH4Oi8DXo4T6MODYYATWlpp6xd0iczk60z3uKgKgAQnOYVCZqvBtUArg8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3xMy0ufxzV0RKZQfKPT9Zy1sKEhnj/GV2uxVBdkeGI=;
 b=Y0Hibu3Ki0GeQ/Wz+hlSarKXjE+z3F/YP/9ZzaXclAEJoondnn0u2mdrwslYdOhpTIsRbUKqHqrp9CMbzkOY1ZoBtWwBbXl1s5j77088BY3a+4JanXduUmJcZhHfu6+ZO63VXpRlSOrVap+QPcz7sykiuOOV3dc12D7ri2gFfizJxskz2l7VkinfnYpNdkuXDBMMRygLXVAN0IQtkl04cGWozcJw5kNaWXUyKmyQUsN8aa4pgwAK47O9b2fI7qvZUeDZ5lWYAc8qZ1qWQ3XSEM5Qld4VJEd4yQYwzH1fTptIZpCQTPFMJ2p2V8njTxC/OOm9w1aYNHGQp18zVoOrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3xMy0ufxzV0RKZQfKPT9Zy1sKEhnj/GV2uxVBdkeGI=;
 b=a4iK7ousifQdTdQAUvPoMSuy8PChuKQoCTocMv2akpfVejOU0bo78Pza8fbd4GcffGOO6k6BoUw2WJOldHSQY5SJ2Azxb50xR92aSS6MW+S2EcorpreCx8cIkHntqAj2g/JonK5kVmcHH0sJ9TkqJzsPaB13KUfojTtyO1J6ApU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Fri, 6 Dec
 2024 15:19:53 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 15:19:53 +0000
Date: Fri, 6 Dec 2024 20:49:43 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 10/15] cpufreq/amd-pstate: Move limit updating code
Message-ID: <Z1MWD2gZR9NnGR5v@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-11-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PEPF0000017A.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::45) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: e8060d3e-5239-49fb-52c7-08dd16096f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?miz2zosoMT1RigHHevhIAOQci9JeBsJJlWMgqO8/YWZDGh2neSan6OU379Dm?=
 =?us-ascii?Q?UY3m7vePOgnxQ0ZdDK7kOr6Y+rEyv5CEq0ViapGEadgA78PQlbcxEZfYugS/?=
 =?us-ascii?Q?iGTzOuRlUMADqbn+UndY8CbtVK20yB72U4JINbrvD/NgeybIJNkJOznqZTSt?=
 =?us-ascii?Q?D4F2rv3UA87K5Rq40pY3zQCg7Dr3veJl9fOHnD56wtrIDXqqle4YKRzDH48r?=
 =?us-ascii?Q?cfzq+EC6WrPnDKP6u9c8aR3l8xlA5uNgMHHXvbNvDQBkG+/3I5GLBNdOU412?=
 =?us-ascii?Q?a80rixVUCjhKI1QCMgzpFpZnPMNtpvAznTL+4EnclyYEhe78KMHMjis2xFTK?=
 =?us-ascii?Q?qkUj3lzy0JN2Oe1ciWuVU3cGKWdIjQjCfzNzPfNT9vncNSLKIOn4VIwDE/Na?=
 =?us-ascii?Q?JJXGMQiAPK4C6ltv7SlVg0AUMMB1MtvWmkLM4cIi5q2McLA5MCCVaF+ERatW?=
 =?us-ascii?Q?6VMmdS4a/h6Mnx28BZEu6MJ2x+yRzQrOPzxrBxKF4UgwZcfU0Sxq5AIgKLLl?=
 =?us-ascii?Q?XVLqbofi4pOyQcUfulIWf2QVpuwJG+CAjCfwBCyR8efzEtev/nNA3EDaWvrE?=
 =?us-ascii?Q?QaJXU673SD64nUL+D7mBX/chSlMoxpBgpiJ6LBm2Drs1KC8Xb9PWCNNe3KBY?=
 =?us-ascii?Q?HT6guXSVNGtoxPk7+gNeOicXwNFaEO1Yi29iVdEJfA6zEN4XfZB4iXu0Xwjb?=
 =?us-ascii?Q?e7M4xvqtFbwdC+SNL3aUyzv70Pwd3r2aVrRmD+UGQD1rf2Xc5F0VBBdhTwvE?=
 =?us-ascii?Q?rwmwmqK64oDVkkkcZjW63CKyDSfHPrzYUr8JrUnDzbytjlW2duCJUw0vprrA?=
 =?us-ascii?Q?R+josYZ8E0ZhNC6P1Osbc4KCCgsbBP+pzWXnkoYlB83b4wY44vwFHn2BVP6t?=
 =?us-ascii?Q?3dvFhrimqtRbnOwFHpdgr6kiD2u2g1/Em0b2U76Cinuk53zDRi5WI1sUK3Cr?=
 =?us-ascii?Q?bENGD5BAkSi86hg+SrH5o7ilWDF002JgtmAoUXRbQQIABTUcr3uhs5NYDnnf?=
 =?us-ascii?Q?DHkuXsT9oywiEZUHNt0jfpjz0yUta59mtQrc9Xj5BhSeV+hvXn75mJlF7rJf?=
 =?us-ascii?Q?ymfrg4m0p5nRaZ8q5IY1UDh3KdF7pYloJOBw4K5jSL47/QhLpLgw5Zzcr2lV?=
 =?us-ascii?Q?Mv00QcZ6nsVWw8fSfcmuTYtd/jNYQZ0dpK7zA7+deBnHOlW3llRzxM8XszZI?=
 =?us-ascii?Q?iDz5b1eBnRFnSIFUig6gG7aCdJ9o+mz6XKt5os0ZsdnCuX7C5DyHMXMPBPHO?=
 =?us-ascii?Q?cMppgVMAy8RE9/Bnj46PDBLNV4vFaZ3Lpr1/DDyhosSk9DoPtphQkNeptZon?=
 =?us-ascii?Q?y1/Z5jl4+zrk9nVJXBkLzi1BSG4RyDzDFHbIR0ORrlV0BlaemLfdM/PLhBHu?=
 =?us-ascii?Q?DcfE+m4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sxdjM/7UJrodXr79bsSetE03ouEo2lgOdmYeZbZi9qvrXuwmVNKn69/gVB/U?=
 =?us-ascii?Q?zm5gcraP88HUzrwegAqTLs9PvEmgllrGyuP+JALDb7gth4EDCJvaY5nznMTw?=
 =?us-ascii?Q?JTI64hMgVPpj1kc0oYf8hSNm8nviS2vZqoIE4GvXiHrmJC/i7lDxLIGhjI3c?=
 =?us-ascii?Q?DO9ZcPaFaMGS0nJ59P3Dn8AigFbz9eGmPwNjABv5IK2ao2vBzQKcxalUB0bP?=
 =?us-ascii?Q?HkhiQj+7SqnsnUJCQSv8srhiXINLp8gSaOfwqoDx07ttsqIfbb8qZ+dAYQtm?=
 =?us-ascii?Q?TwpRzTzJv9aidWa0ttL6sx/kdwzqGMQurXixFTIn5FqX7CPdajH3dx3h8JMP?=
 =?us-ascii?Q?PhHSC/qW9syD0Lj02jCanY57M3OTcUyKEVvjWVTgvot9yTpzxK/RzI+m521g?=
 =?us-ascii?Q?eNYsd1cFyDblSj1bV6mRiKHxf976rQ/sHpHyaFEyPpqR0zr6GsbhrD8Qqqys?=
 =?us-ascii?Q?XTtGvz9lj+kJKLyOn26mQnlk+uGobJAWkd3OX8+biCnkFYdiVplm7lMKi3ak?=
 =?us-ascii?Q?SZEh1CoCU/nCYUthjmKVxHwqpbKEh/BmjiMIFWZFoVyj0knIW9JJedGq+9kQ?=
 =?us-ascii?Q?OVybRXKPHWxMy3HAefENaOLhLz5jQTs7MnHofp2ospGZWU3yELG48FWCb87X?=
 =?us-ascii?Q?Ob5yrMpsCM3cGAtAn5Po0lz01J3Rgl8A/Tc9fCnVuI/BAsDRkQylXT68pRyn?=
 =?us-ascii?Q?iCce7zUeUxZ5Rp7wyYPRQD7+sJ39HStB9sbThzz/KtkbOcpFu97RU5+3NG6N?=
 =?us-ascii?Q?mcddpbltl7p+UKxw32zhS2/mBojPXin4zWEUxJG/GBkAg9pTwZn/1ndCHWtx?=
 =?us-ascii?Q?Iw8OajGeFN7n2MkqKOcig5jA80x1l4r97GneJBFCvPbMGOnNNR88mO+DV3j6?=
 =?us-ascii?Q?U7LoFqwEFTmM5v2ScU8KAU7HuDzQKWqWd8jj1tUbbJWAdlZpJq3vhusq3E7H?=
 =?us-ascii?Q?0qsh4I/NJE7dn5SpwJ7fAPjdxDkDu0xOWuMHQsp5dELgx6596idt48BpNMZX?=
 =?us-ascii?Q?e1cDyJ98PGTGzseBVjmwOihAbBIFTgR1M+o1sf/4BdJ9u0vKptzAPZjLd5Rs?=
 =?us-ascii?Q?GTUWO0bNt+sI2qUm2HOX0S7MlaJMrdNFaNg1enXB7fS0pSwWqEAXhVUXVYwM?=
 =?us-ascii?Q?0Qh2tUdztmX5l55nh6E2YSRNCG0SWH3EXR7hRtK9Zk/iCgUjX1pXWnGzoT2X?=
 =?us-ascii?Q?j6zijKReLtPSKu1xM8dVDiAl0cG3bC9HKj4kvPW63PbRLC7YoCwxFWjLbqyQ?=
 =?us-ascii?Q?xME3XAsvGfANlxGuoDmwkz11pwjD98p0BZJvFvptGs5iyVNgEw/MERf/RNnS?=
 =?us-ascii?Q?YRgy6dVt8xOVPWLA80wWRYNOsu+sSYoA8dWx9r324ay+p2Orv8hRmxQnOgm9?=
 =?us-ascii?Q?gPozfV10UI2wtPvXriA9SEmnHAPYE6SibRLOl35OfmS+GWma9NkieBje9uAL?=
 =?us-ascii?Q?dYBL5ZcIrZLE6OWTP+9373kN4Xiloize7EcjzZJE0KCOihsC5s+gLWQyXAff?=
 =?us-ascii?Q?WtRy9HKYfrb4VklYcAQkCLmAz5sLxBfp9u8mHMD0Oj1CXM2lyVf++L68HQ9Q?=
 =?us-ascii?Q?k4hHHNwCdcWUgI7DVzvBQ6Xln7qEq1swWEAachMU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8060d3e-5239-49fb-52c7-08dd16096f40
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 15:19:53.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7N5wcBd3h4IUSSPINe8pHNT04Pdkfxh5pHOo5ptzY/ULDc87d42+fJF4HRYl+S7PcQrQYMvfh45iGW75Oa9LgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720

On Thu, Dec 05, 2024 at 04:28:42PM -0600, Mario Limonciello wrote:
> The limit updating code in amd_pstate_epp_update_limit() should not
> only apply to EPP updates.  Move it to amd_pstate_update_min_max_limit()
> so other callers can benefit as well.
> 
> With this move it's not necessary to have clamp_t calls anymore because
> the verify callback is called when setting limits.

Nice catch!!

The patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 842e7e3c5eaf2..5ee53b45c1ca1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -537,10 +537,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  	u64 value = prev;
>  
> -	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> -			cpudata->max_limit_perf);
> -	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
> -			cpudata->max_limit_perf);
>  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>  
>  	max_freq = READ_ONCE(cpudata->max_limit_freq);
> @@ -616,11 +612,9 @@ static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  	min_limit_perf = div_u64(policy->min * max_perf, max_freq);
>  
>  	lowest_perf = READ_ONCE(cpudata->lowest_perf);
> -	if (min_limit_perf < lowest_perf)
> -		min_limit_perf = lowest_perf;
>  
> -	if (max_limit_perf < min_limit_perf)
> -		max_limit_perf = min_limit_perf;
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +		min_limit_perf = min(cpudata->nominal_perf, max_limit_perf);
>  
>  	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
>  	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
> @@ -1562,28 +1556,18 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u32 max_perf, min_perf;
>  	u64 value;
>  	s16 epp;
>  
> -	max_perf = READ_ONCE(cpudata->highest_perf);
> -	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	amd_pstate_update_min_max_limit(policy);
>  
> -	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
> -			cpudata->max_limit_perf);
> -	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
> -			cpudata->max_limit_perf);
>  	value = READ_ONCE(cpudata->cppc_req_cached);
>  
> -	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> -		min_perf = min(cpudata->nominal_perf, max_perf);
> -
>  	value &= ~(AMD_PSTATE_MAX_PERF_MASK | AMD_PSTATE_MIN_PERF_MASK |
>  		   AMD_PSTATE_DES_PERF_MASK);
> -	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, max_perf);
> +	value |= FIELD_PREP(AMD_PSTATE_MAX_PERF_MASK, cpudata->max_limit_perf);
>  	value |= FIELD_PREP(AMD_PSTATE_DES_PERF_MASK, 0);
> -	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, min_perf);
> +	value |= FIELD_PREP(AMD_PSTATE_MIN_PERF_MASK, cpudata->min_limit_perf);
>  
>  	/* Get BIOS pre-defined epp value */
>  	epp = amd_pstate_get_epp(cpudata, value);
> -- 
> 2.43.0
> 

