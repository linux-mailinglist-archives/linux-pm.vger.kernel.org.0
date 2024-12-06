Return-Path: <linux-pm+bounces-18682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC82B9E6761
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 07:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8297E281001
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6691D63CB;
	Fri,  6 Dec 2024 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="09ZWq4lb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5ED58222;
	Fri,  6 Dec 2024 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467402; cv=fail; b=FoWcGnUrJ+ey3QwLRTtnrf5FjBZBeXLURKiJewc944xsa7KiM7higzXGnV7IOx4F++7ALe+OWDMmfx+EBLXuMOoo43LxM9hyYUgJPWQ2mv+zmTg/PdHkH/rGs+hQLvEmPXvxRE6YGr6CwDmreJrW/sv/l83fRSyNayqjmDZsjW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467402; c=relaxed/simple;
	bh=8YO7hnmNngb4C/Rfhb5nkaHxqVq9euoDtp42aiRYxlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MlNwr2OM9AyoEIcayyHXc7KWe1eRGQtjKC4hkCJpi/4tixYzSCfO4e8VZxZ4OiEoQmox2Kvhs0vQjrkSFpUPbheeut++/owSFZ8+/+D+c+ces1578KSga5N9GE0y4adkYAG3GU8EBe3ojh8On0OCP2FAw7+bbyWS4/JeWMGVWNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=09ZWq4lb; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T90FckrKD5En1N1xoc8VkKxBQtXypfno3JQLYWlILkSa4hfFPjDXZpYN9PjLmsPQ8bJjpzTZE4fKX3Tv8bs5ttajUuRyYt14FSqBRdXwUFnvzGAO9v8K/2/q0HBWSOiH7L0BNxV1T/P+wyFrsk5Y7yT5OD8G71dfgJT4OknZ02EVTACitl3xc2UfLdsUpk9MHJRKKR8yP90nF3Zo0yzIufdP5vGd1HrW7hOOCS5AlT6qjKfLPI18o7RKPtiLQVVf4QDe/2s7FuEjcElpAOXGeX2puXQDIZMghOdeqQDAwCpL+EFl03a0TIqO2pXahu3GDPP5f8VEfO44B/YkJndo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwVmAtaozzQmK1Ft0NGtiwvr4E3Hj4HAdztFmgAef0U=;
 b=FRmP1XJ0a4syeQDSo8hXL3HecX2ZAVLbvJwP80ALz4dgNcAzLufULvRj4LoZJwPqRN15YSAFOvmYVazf6SQDDP/jxvKwkD94J99St+dj4q/O2okExXJf/CxyI2cY3oRjWZeminI1K3QLnT8WGkNgI57oGTgjaXZKJDsIryIB7IgOQMDk+JSWUFhPRP0N9jN/apk2D75qQhXf+720lEuoYaQWYO8w7/wKzr8r9Ukrs15Zwu0K4UnaPAtmM7bkBpBomq42MKNxOVpW58OoQuOVZJE+DJbrT3U/3nc/baPEHXfsZfCVYCbaE6XWclhYnV9zy/xpsP20Jv6LVc1U4TM3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwVmAtaozzQmK1Ft0NGtiwvr4E3Hj4HAdztFmgAef0U=;
 b=09ZWq4lbAR55WwtFh778xF4V50CyFZbHAJ4Ib3iZIOMxQHPlcDfC5qQtEoFmMqw1qoTGwsRiJiMWxq65ftXjc6nVMUEMhZi2xzWrRkzMBzcu5FMPf6BLzLS3tMLoLS3gHbSSsA0xmh9TIgBe+Ice8lh81K6mWTCNUSR5LxcfM3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Fri, 6 Dec 2024 06:43:15 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:43:15 +0000
Date: Fri, 6 Dec 2024 12:13:05 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 08/15] cpufreq/amd-pstate: store all values in cpudata
 struct in khz
Message-ID: <Z1Kc+UNjW3QNJPMm@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-9-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-9-mario.limonciello@amd.com>
X-ClientProxiedBy: PN0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e174fd-0a42-4b0a-a0b5-08dd15c142d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Oq90Edv/XqXDR6F8yL9Y9Kbk4Fttdf8oGqOhSwATQcmR6oUzssV5/iGf93m?=
 =?us-ascii?Q?o0HFQ9bTKzi6FGWwItf5ev5Pj9mg3WmQbhOHJ7Rf2BVyyig9Rv6u3YW9Fhy7?=
 =?us-ascii?Q?tSoEsar5n616GOR2SigTG3hQpv5/fOSxRlc7BjkdNRowViZRA1ls2fSnnapo?=
 =?us-ascii?Q?eJswxGFbqfMidOcvlxBo2oEUuZG5aQuwUi7ZyVAGv+XzEplR5BLlUORRCihb?=
 =?us-ascii?Q?M5Je/6F5H+bznIuXlUYoc+3DH5pGaAlGQ9sdOuaJ+kOI/Ia3+ayDpIb9raPn?=
 =?us-ascii?Q?mtDxQuffGH3kbm2+IJlO/Kd2EZfMefZ+fBtqIBZLvAP3Km0QTDA+qGgtHN/O?=
 =?us-ascii?Q?VqQKDHs3ShEFP91VlVADd118YNcr8GCN4fzf8URGafHkZ+9y6KHzkTBSY+hw?=
 =?us-ascii?Q?qnDwZdRfWOcNGkfV1qSoRRygSJfwhHVKsJCEUFMcYjThq4OEF9G6ixgUsNf/?=
 =?us-ascii?Q?x4HH1cv4MDAhZ7YOFtgKSHDZw7ZuAi8ZWLf60x+MIBcGce1lO7Aixpgw3h8t?=
 =?us-ascii?Q?qGUWUeDmeDLVTrHa24jQ/tKV3ZFquFzI5uC9vvxcas4+4ds6QbcET2CE87o9?=
 =?us-ascii?Q?bHfBCcIM9EmVrbQLolcnMHNKE2CpsK2JhzxpkFN9rQdm4r9rUxnMuSdcKZ3z?=
 =?us-ascii?Q?yB+96Hoq0OdwAQEiDzYhSXueJuWU5tyq468ugfuN0cM8ijioOwYhXAFXsLEe?=
 =?us-ascii?Q?XtDCFlN3zGC+uZwK653Go6GzSIUTWBA1A6lNjvGkITCvVEOaYmdZZKExAkLG?=
 =?us-ascii?Q?JlyQXWk5rCIFj2Fb5w0ZD5z6OrFfE+Efxhl64H/q4T5iSLDYp0BtMFa8V7d7?=
 =?us-ascii?Q?CF/7ah6qYfaXF00OV40cVonwJMfsiRZy60EO2ArfslpkOM8fUiwfJg4hiWkT?=
 =?us-ascii?Q?+jn3UC5Gbq5K2UdL74rPe5iYhgxFu3oMDcE1E+VwIpPXKKl5ASvYHPTjYqk6?=
 =?us-ascii?Q?Yx+XM6kwkvD1PKnyW35ijV1RDGPCyA3L3ZS+Km70XT2xqF7rNGNi3ZvWSehj?=
 =?us-ascii?Q?Z0sUKIOLEUmiNESoxROnu84jMVmNLWI/XNPAWEaN2dJoQ4mbpM+P8DY/aOSn?=
 =?us-ascii?Q?z29GWLlFiYI6Av7yJDEXOdvG2uzkHmjErxYbekwDgDWZHcC/N6hLU241sJhX?=
 =?us-ascii?Q?0dOJOmjXIQfCoaUOek1IE4a0RfZjRXCMEpzVcDSpGnUZMklN2Q2Fwgw2cmDm?=
 =?us-ascii?Q?lUPYAzVbyfJnlI5llp/qJFeWvjhCgIw63ttcpF+Rawv3zjv1j/Zf+BRsuxCw?=
 =?us-ascii?Q?cqURe/ch+9zTKE/aKcMhV4aoD7pN8ohpEodu7/XWiVKu/gZ3/NnvJtLsA62A?=
 =?us-ascii?Q?AQ9d2KlRsYHURuLp60SXWp1TfWtraMjcPF3koMO9p4u8ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zwHCJuWOecbyPZgjHtqCbbEXMtnVNVlo12QqWZCp0Hz9NCy+1F4394ME7IN?=
 =?us-ascii?Q?rTkFXw4W27j+rGCvdwg7BSF82bs4hV3nNQ/IWIm6fu+lpqkGUtIVH9C0o4jf?=
 =?us-ascii?Q?iROnCdnX5Esypwr+yjSNenskpeKdL1jCWPE0j0ur5KSgTchKSaQ2AmoUbwoq?=
 =?us-ascii?Q?4v0lGmGLRROWYak1Gq9yWRATZhI737Q7mtUZModh+25CrbXJYfWlX283fEm2?=
 =?us-ascii?Q?wMO2O+7SsI5J9l023Izf5OpoGme4XR2CP0dnSxvHhnTWT5dlf6yZnM6MztIB?=
 =?us-ascii?Q?expGkpg2LKm9DA/knVi30QJp9+WWm79rBPBuNkVPZg+bz1boXNsiYY+ZIqES?=
 =?us-ascii?Q?PC6VXA1WdHnQPq5dmsV4KC4a2kL6YQDYEqpfDWXnoZ4ABbAFwKtPOJTK5t8n?=
 =?us-ascii?Q?wd2I/4hgon0ZZBNd6xYLLp6hSRjDXBX79vAkuU/HxZxtwmQH063YZklFUfPR?=
 =?us-ascii?Q?hmBPGAUhoqa+DIE3eNCJp4qWSNrtGff3YoghLdQ8HzjP+mbluG1d0rp3/jDU?=
 =?us-ascii?Q?ibjlMYg8aKBULAL4wQubB9t+9lXzXCF5yxFR3aB2Q1it05EdKZRZ5O0z3Mgh?=
 =?us-ascii?Q?xDopzaDPQWMCC7Rf6zrJAbEn9ZkeJtwSoa0UUea1Ikvis5wo2I6Y+HLaI9zd?=
 =?us-ascii?Q?vOSynjEfPb3IS1edCorJZItjGh+rFxurAw/wyh9/1FMNXeVrsTjzr4jiiX5k?=
 =?us-ascii?Q?WEG5fPxkAiwGyt6uxS9fNl1MOvFmVkgeIRGyP83jvMd2qNyfKqR4xu97I+JC?=
 =?us-ascii?Q?K5E/lclZ/ISo4ck19j0qD3sjwbBl/fOy7lFvFaLw4BMlJFcIEB8cnGXGJeDQ?=
 =?us-ascii?Q?gz3That0Z7IQj+HV5jq8K/Ja3cgoN1LgdOnt+PqEgfu6FgJ3xa/+uHj4WiFA?=
 =?us-ascii?Q?/aie9uLnPuoyeYG1wVHY9Ame/+yUrUDCJZveIJnkEwdvrkz0sCsV7mJUTuYS?=
 =?us-ascii?Q?mBUDC8Mf8E0IOBiH5DdhjbvmHrhQQkBSM77wgSu3z5ZFOvCTUD18vHyAcW+O?=
 =?us-ascii?Q?wCwvFW8PMOwSvZ0qxtsysBUVzjTpUE0JUjuvF/YpwI9rqSrsGjGrGzKSGpDj?=
 =?us-ascii?Q?EHajGZBH/VcNzi8zlqqXpVm7O+g8olD8W/+/VYpHhlMDIxrpfITQdciDDnT/?=
 =?us-ascii?Q?MoC2BvF0W/mH2hdjB/7xy6Z7C4d2n5H/5xxtFcgMSrTkM6MuSUafFdOqe/TY?=
 =?us-ascii?Q?UOAZgHecUHnCHOTLWwLzsPGz2JBUx7d7ltt3AoWiLmEFAvSjfPUr8RBefWSo?=
 =?us-ascii?Q?iGkoDax/pEuxnFrQroZsTY5rUCub2Cd8qrQlX1MELT9SkQuTKiWmbSx/DdLi?=
 =?us-ascii?Q?rHS8F6pQaw7c3r07ZeKEVa4VRCGVAq70lyx9xJfu1wrMbhluno8LNAk9f4/z?=
 =?us-ascii?Q?MokQ6IQzhODzZiy1vxjpBgpq/OiDfZyqJ1dnMJyuAdKwU7IXGhuRAUyHBx/u?=
 =?us-ascii?Q?XeABBk3kFpAKNuyUcbAk7EnA96bjexwTbx1UQHoQlV4RLPYAPkaKIfBrVVQT?=
 =?us-ascii?Q?YaRhET5JP2sNIjap4o7KwjOy1yEr26CIACv1Sw/5c68IdE+e3kPuAzuJ9IwG?=
 =?us-ascii?Q?pKmZMh/bkkohAEuFB5pD/lgmCfTwrqvBN1ANvBfD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e174fd-0a42-4b0a-a0b5-08dd15c142d6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:43:15.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJmAX775QBfPDvG6OoyC+x8YFeBh9/yzOysWHtkxss5PkpWK6W947qqNgeoWV2l9zqmk+IpQ9sktrQs9f3SQZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

On Thu, Dec 05, 2024 at 04:28:40PM -0600, Mario Limonciello wrote:
> Storing values in the cpudata structure in different units leads
> to confusion and hardcoded conversions elsewhere.  After ratios are
> calculated store everything in khz for any future use. Adjust all
> relevant consumers for this change as well.
> 
> Suggested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks for cleaning this up.

This also makes the code in-line with the comment for cpudata->nominal_freq which says

 * @nominal_freq: the frequency (in khz) that mapped to nominal_perf

Couple of minor nits. See below.

> ---
>  drivers/cpufreq/amd-pstate-ut.c | 12 +++++-------
>  drivers/cpufreq/amd-pstate.c    | 30 +++++++++++++++---------------
>  2 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index a261d7300951e..3a0a380c3590c 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -207,7 +207,6 @@ static void amd_pstate_ut_check_freq(u32 index)
>  	int cpu = 0;
>  	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
> -	u32 nominal_freq_khz;
>  
>  	for_each_possible_cpu(cpu) {
>  		policy = cpufreq_cpu_get(cpu);
> @@ -215,14 +214,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			break;
>  		cpudata = policy->driver_data;
>  
> -		nominal_freq_khz = cpudata->nominal_freq*1000;
> -		if (!((cpudata->max_freq >= nominal_freq_khz) &&
> -			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
> +		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> +			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
>  			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>  			(cpudata->min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
> +				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
>  				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>  			goto skip_test;
>  		}
> @@ -236,13 +234,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>  
>  		if (cpudata->boost_supported) {
>  			if ((policy->max == cpudata->max_freq) ||
> -					(policy->max == nominal_freq_khz))
> +					(policy->max == cpudata->nominal_freq))
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>  			else {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, cpudata->max_freq,
> -					nominal_freq_khz);
> +					cpudata->nominal_freq);
>  				goto skip_test;
>  			}
>  		} else {
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ce70d1bfa55d0..464db6745d84e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -739,8 +739,8 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  
>  	if (on)
>  		policy->cpuinfo.max_freq = max_freq;
> -	else if (policy->cpuinfo.max_freq > nominal_freq * 1000)
> -		policy->cpuinfo.max_freq = nominal_freq * 1000;
> +	else if (policy->cpuinfo.max_freq > nominal_freq)
> +		policy->cpuinfo.max_freq = nominal_freq;
>  
>  	policy->max = policy->cpuinfo.max_freq;
>  
> @@ -940,29 +940,29 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  		return ret;
>  
>  	if (quirks && quirks->lowest_freq)
> -		min_freq = quirks->lowest_freq * 1000;
> +		min_freq = quirks->lowest_freq;
>  	else
> -		min_freq = cppc_perf.lowest_freq * 1000;
> +		min_freq = cppc_perf.lowest_freq;
>  
>  	if (quirks && quirks->nominal_freq)
> -		nominal_freq = quirks->nominal_freq ;
> +		nominal_freq = quirks->nominal_freq;
>  	else
>  		nominal_freq = cppc_perf.nominal_freq;
>  
>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
>  	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> -	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
> +	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
>  
>  	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>  	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>  					 nominal_perf);
> -	lowest_nonlinear_freq = (nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT) * 1000;
> +	lowest_nonlinear_freq = (nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT);
>  
> -	WRITE_ONCE(cpudata->min_freq, min_freq);
> -	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
> -	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
> -	WRITE_ONCE(cpudata->max_freq, max_freq);
> +	WRITE_ONCE(cpudata->min_freq, min_freq * 1000);
> +	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq * 1000);
> +	WRITE_ONCE(cpudata->nominal_freq, nominal_freq * 1000);
> +	WRITE_ONCE(cpudata->max_freq, max_freq * 1000);
>  
>  	/**
>  	 * Below values need to be initialized correctly, otherwise driver will fail to load
> @@ -970,15 +970,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>  	 * Check _CPC in ACPI table objects if any values are incorrect
>  	 */
> -	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {

> +	if (min_freq <= 0 || max_freq <= 0 || cpudata->nominal_freq <= 0 || min_freq > max_freq) {
>  		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> -			min_freq, max_freq, nominal_freq * 1000);
> +			min_freq, max_freq, cpudata->nominal_freq);
>  		return -EINVAL;


We don't need this change. This looks odd since we are using min_freq
and max_freq from local variables, but nominal_freq from cpudata.

We may just as well use the local variables in all the cases since
"cpudata->nominal_freq = nominal_freq * 1000", and thus won't make any
difference to the checks above.


>  	}
>  
> -	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq * 1000) {
                                                                         ^^^^^^^^^^^^^^^^^^^^

Simply replace this with nominal_freq ?

Because both lowest_nonlinear_freq and nominal_freq are in MHz at this
point.

> +	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > cpudata->nominal_freq) {
>  		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
> -			lowest_nonlinear_freq, min_freq, nominal_freq * 1000);
> +			lowest_nonlinear_freq, min_freq, cpudata->nominal_freq);
                                                         ^^^^^^^^^^^^^^^^^^^^^^

Likewise, this can just be nominal_freq
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.43.0
> 

Other than that,
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

