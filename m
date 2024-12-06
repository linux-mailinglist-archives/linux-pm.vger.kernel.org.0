Return-Path: <linux-pm+bounces-18683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE8E9E6763
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 07:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C537E2814C8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD931D9339;
	Fri,  6 Dec 2024 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EmS8Kw2H"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8258222;
	Fri,  6 Dec 2024 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467434; cv=fail; b=mf+avCZIDAriXqoo0OUkUxyqo9yzVPtzyRE115kzf5RXdRxE2gTl/M3yt9rcRVbiAyVwWDG3s4KD5KEV38OS4sSjTJ19lSv4Ia8VSBbV84VxsS3fmFAvFP+B/f7VINTJopytQ9pghlDdXCZ3TELQAYJD1x6Kx+E/xcnTJg8NMNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467434; c=relaxed/simple;
	bh=yhF4ybqgD9azZvmKSz6S5j6fqxM1oaQ4/LefF608SkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=syDXYnGXDsk0ICfVWWZlUZTImz98z0D7GhCtBOT9DrAyLJ0esCo0+PNii5A4oZy/mySa/L54vbt1ezs1XYQe9vmlWtQ3xqCmQOsWT6ogD2LlWYjGAQtZjC8Z1HNrnMH/1n7idFc512aUid+9qMyCBxg13D6bbVR0PtkqFik7JTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EmS8Kw2H; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWzFxQCdXqWbVrbhd9vplGPn1S+Dv6SYzfR0TfolMfip6fAzwCFbEa7lwFH83vxs+oC8NtJLfg3e6AZmKNsxAiKRJgVAsOP7Kwl6UeJBC3jYWXOODAL6IoflU3w1mIGoZLqK+nYFiLGtep3YkdmPBvCOp2tzyG87KQfqFJfGEprPL9cthQF2Ck+j9fGlsATbJ3UpzhaIfj64Jp3c/Q9Kb23Q7GryDfD8dWd+pV93WWU37NR5H3GQmPbO9K9HC9FJoRpbKBVUkwo2wuXKrjOPzJv+aML6gx9AjuE1hxRA5r+lunaBBg7hlQ2gPTn1+m8jah4q4GZ7/YzK5ANlgvR5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af9293Vn/pphmlsKbB4YJIufkXp+m3+g4BlV1jX2VFA=;
 b=W+ig2wPcHfgVBABsyYMOYqeWyOnOousqULWLxMQ518s2gMG1PhFR6oWh1rNHd20LzxKZpPQPZSeIvyuarsamg9cSYwHSxa8aJ3Do9LiT3ACB2vovsVTE+9TCD5rKNW14pZVudjHhrB1jBCNI3Ny2sPQ8Sn5+CQFiZgMQ8H8pfs60V9nbvu49KpDAdIjoxefJXlePNsIkUnark7RY3a9x1qKWbFAytipvokGxMRPa9SpMCWrxLxtRH6izC3zOWwWjOS20joEdy0Kf3Uv/kXuzM8Wa379VK10k/5E7JWquJ8Qddr2eFcp90hJ64xAyti1xGZ77w4jTtgCMpHe/CWOgSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af9293Vn/pphmlsKbB4YJIufkXp+m3+g4BlV1jX2VFA=;
 b=EmS8Kw2H/A1T8bpzgNobHGt1Cjt5XrWclITWLA7EqcmdPOWF+NbUDez6QoAtwygYXxTfO0+qrTIX6s4AwaqxHVanZaLvUsfursLvBQ4rm1dtGwrRbiWkMWMy85Go3l8cynqVgzk0ofh5eFCo2hfFgF/CYSc6ejePV+eBMb+0LBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Fri, 6 Dec 2024 06:43:48 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:43:48 +0000
Date: Fri, 6 Dec 2024 12:13:41 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 09/15] cpufreq/amd-pstate: Change
 amd_pstate_update_perf() to return an int
Message-ID: <Z1KdHW+j49X158cp@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-10-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: e70a26f6-a3a1-4191-a006-08dd15c156ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7VjxH6vgGjNmFPm9arxFlsnuroa6LGMjhfkaN5XQBHIJ5YA9VAqGssd9BxkL?=
 =?us-ascii?Q?Gvu5vZOskvbiXEsi9BHTJSWwH9+0d/gNBXbJBnemVxxWPYzAEXupUSf6KAlL?=
 =?us-ascii?Q?5NZuefTRspFEysgO4DqXvw+jGgXRP8V1VJ0zMvoMNgHNYQ6ElaBwrTH6b9GA?=
 =?us-ascii?Q?GvUQ1cVkSDL18X99fXJqkZX4RjDMreP0oG7RQvye2n17ow2mbMK/GSrOUBGw?=
 =?us-ascii?Q?tgI0jamvHQogQzLd5gBIJ4eYjFnhQVU+TLEw0R5R84Lyn8JdXwlFbakuXPLG?=
 =?us-ascii?Q?ay0MhJ8Wj+DTwPSdV2/8rVNmJNn8YjPIMI9rzT1LyRn0fHRs4snwVQ4VsKeI?=
 =?us-ascii?Q?hPUhvFOsH+NcOWQTCavp91ti9s9IlkVHGEP7yqBXCfcqknx0dG465q/sW7Bo?=
 =?us-ascii?Q?tC0tQPFqlkOsx5enD/my13KQ+cHTwfgsc5az2fdtdiC0zELGp8IdLDh5KnVj?=
 =?us-ascii?Q?KYvxHJw2kQklndzNfa6deFpNlE9rziSPkmk504UtnTVMOHp6sN4e3oDwjvF6?=
 =?us-ascii?Q?erW/5J1JKDINW9B67ZhObNzWv98XDnpHDeFEajaaCpua1koRibfcJetKCHX+?=
 =?us-ascii?Q?BTPSx8D1ZJEKspZdU4gS9nGKAsOHDgM3jNI9ohiQy5CG7YZtyiiDrhPApvYm?=
 =?us-ascii?Q?m8rKSfFRfCC4zxTeVLVx9tOLmMiTg3HMGY3VIpBhBp/4AQMt4TXwnR37vVmS?=
 =?us-ascii?Q?5eIN/tQorQ/vJ/Fw1L7B1y0xhvXQ2S0FkoaOMzn2dYwQR4zRXxRN0Sz64PMq?=
 =?us-ascii?Q?B8OdZxgXIWFB7zUkYFaq8WqNaeJzXBTCGXdTjGPUpl+hM+4o+yaD1+qLsULF?=
 =?us-ascii?Q?NQyfaRK7lblIte+7Ab6QxQ4tQ49XxVhcvBCL1AwWkKAbhh0Kb81HUrx4OmGu?=
 =?us-ascii?Q?JiYHyctiFVUErrVIcNC9hmZIq5tw0TzrTOT/JKTBknBA5txUciaUh9OAx51L?=
 =?us-ascii?Q?DPNrYjCIq6B81uL0BkhZas4GZ6u8HhlnVPhHFXKD24NpSsYYQx//UEPKFYOW?=
 =?us-ascii?Q?3jZb4o7Hh/T2eQmbn6ZAPD1UYfz+y551/RzqnxFnHH3pLvyzDHtH8/EmmMXR?=
 =?us-ascii?Q?NqYjkQFoq4S9CLHbirk7LRBCq9x32pHPulksO1on4NFCU/6jX6jZ64e9MGVF?=
 =?us-ascii?Q?0qbS94gGsxskpx6jj+QPRnF0cS2X2Qaxui8iZXd6XfL1Yli3bgMVEUhRTaPw?=
 =?us-ascii?Q?u7yPR0IRM0fKbaQwZV9eDoj7Zm1HBEYwI7PmG+udlTHst2k14D4ibYzZ0dsc?=
 =?us-ascii?Q?6hyyx+7yMGpM8wSkTjspXv7kkqszBdfUk9XgNMUbUgr8DFF32LyKohWQx368?=
 =?us-ascii?Q?Oplv25x3TLHmg8SLsy4RiPbcklCaNw2MdpTn8WAO7c6q7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z3iJ0AII+X5su7K3rbOCBgnbCJRE+ZiHbKdqY64v13mJkCOwH7EAiF715P8p?=
 =?us-ascii?Q?N3bsCbKSem4aUJ2zYSdkuKPB5suNIj5ZPaHp7WOTu5w6TajjGzEFfxLqqvtz?=
 =?us-ascii?Q?/KJZ5LZ6cA5/fwr0dyjdosO6Jb6Wrc5KKbdWMB0skUqbuuPgx3jkkybNg+Y2?=
 =?us-ascii?Q?6bTDu+uyRJGFHQP0v4PXBoSMer8Ozz7QAQC0S9ixurwtnbKI47jvmTfHytzm?=
 =?us-ascii?Q?VUwin4GvLNTuSrr/uJZVq2fOpbWevgQ7eGykzn1zsSwfaXYwwGi1L/DfnFES?=
 =?us-ascii?Q?pS05xfKPEHhQHZhRc2kEbZj4BCAcj2Ow1z2b96W7w152sqeHw1f0YNnYtX+3?=
 =?us-ascii?Q?fTW88dBHsY6qfxwbNOmfdI2+8/742vv14xnT7vNUn1moJScVS6ibpaELERqZ?=
 =?us-ascii?Q?1YzlB5gyfNs6Co5LXTUntXsT38WrPet1hOGO6b9x9Homyz4n+vQf41S8Jhv5?=
 =?us-ascii?Q?+rmfI6ToJ6sUfLcyb5ig17GUucTjBojEa5RxTiXbNjGk42GgxZsQIdOtDMn1?=
 =?us-ascii?Q?MGq9/8Dzfzqsldbs8JuVEOBbkm9sookvZSx0oWYoFgUBWPry7Oqh9RleuZYN?=
 =?us-ascii?Q?rcA3DDiRo7faMqMl4LBWwRllZbIS3zXxzl2rfVhbndZmxJDyys2/+MwB16/R?=
 =?us-ascii?Q?3tzNagjasdouXntmCZeuq2AGuvWiW6ASyrFBgASbMXN3vQBsO4/pex4L7ztJ?=
 =?us-ascii?Q?zoJx2uoxeu71HJYQ1IU0W7OKTPYaeRTcoqznOB/r30KY+0LG1FTAXSJAWssC?=
 =?us-ascii?Q?qidVSA6HxrUqqY3kK4lez3pn/Au+AMjGMVtbgJqvVfKRyt8bQMwRcKzgPtSn?=
 =?us-ascii?Q?8LnydLNsY1lr5Skvhn1TVWoVskBylbtp8QgFDdLb87RA3jdi2kdOI5reVo/R?=
 =?us-ascii?Q?ycNAH5Txo2pGDMWZaq88KaEnahy0UTqzAD4Q/TRwCWDQGZYvgGgCcUDjzm/3?=
 =?us-ascii?Q?u9XTrT3gMYhJZG4B9H1+Jw3lIN2kpzeW5x9kROMGrbfwNhB48RRoZOfkNtTS?=
 =?us-ascii?Q?if42RQuQwhUOAp0byM4fnH9ryxzhOIZeRt1fifLJ+AB0hBy3oRA8HNVTxskS?=
 =?us-ascii?Q?OFWXVuPWVzyJ4/V21wTfj6iuBsbn3fvL/pv91ilXKRyrAJI1hrsfp7BVNnGy?=
 =?us-ascii?Q?i5qXPDNyzrNTe8PxUs4gc7JqSMsYcWXnZolxbImHgL/8SdQXbP39ieLCaJ1B?=
 =?us-ascii?Q?7fYvKbXBUE8OfAvxOFGUaXKwbPckxRN+o1rUYXr7J0YBS1BXq7je+9jI2eDn?=
 =?us-ascii?Q?S/Y/iPmdrTh08YJhJXdqRsBlrDJByiyjEjHiGUhMp996XFcWDIIivvZC3F/M?=
 =?us-ascii?Q?aGJNeXFg1zZB4tW3mLt1To79vRoiwyLUbCwmo36HevIzmcnAq/90MnB/tGjK?=
 =?us-ascii?Q?mNfEGvahTACTJiiOo1jy8LOiEAytE9ExeBli6qYkJaBBBbXT1QH6ao6vN+Pp?=
 =?us-ascii?Q?tb1USIXox2kQ4Zdco229YXyvg4kDjMNnX+3EIeUhOC4vZscL+2BqIFkr9iNK?=
 =?us-ascii?Q?0djDRbdzpmGOpeKxmaig2qtkDWLIykFVb3kPqODZkciiYEl5s778N9QwRP3w?=
 =?us-ascii?Q?QXKEbdk3zxW/pSYfzR2uyJAPcRCxuq17FzAhwJpQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70a26f6-a3a1-4191-a006-08dd15c156ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:43:48.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YInW3bxHQ4NiGiaLyebU9vU0zAJyeTWwkZOkA/UVzqsPp8yrTuMg+Tn9k8JUYHBRpZ6E8EkTeBr1SpC5XDjubA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

On Thu, Dec 05, 2024 at 04:28:41PM -0600, Mario Limonciello wrote:
> As msr_update_perf() calls an MSR it's possible that it fails. Pass
> this return code up to the caller.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 464db6745d84e..842e7e3c5eaf2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -251,24 +251,26 @@ static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
>  	return index;
>  }
>  
> -static void msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> +static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>  			       u32 des_perf, u32 max_perf, bool fast_switch)
>  {
> -	if (fast_switch)
> +	if (fast_switch) {
>  		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> -	else
> -		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> -			      READ_ONCE(cpudata->cppc_req_cached));
> +		return 0;
> +	}
> +
> +	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +			     READ_ONCE(cpudata->cppc_req_cached));
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>  
> -static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> +static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
>  					  u32 min_perf, u32 des_perf,
>  					  u32 max_perf, bool fast_switch)
>  {
> -	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> -					    max_perf, fast_switch);
> +	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> +						   max_perf, fast_switch);
>  }
>  
>  static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
> @@ -480,7 +482,7 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>  	return static_call(amd_pstate_init_perf)(cpudata);
>  }
>  
> -static void shmem_update_perf(struct amd_cpudata *cpudata,
> +static int shmem_update_perf(struct amd_cpudata *cpudata,
>  			     u32 min_perf, u32 des_perf,
>  			     u32 max_perf, bool fast_switch)
>  {
> @@ -490,7 +492,7 @@ static void shmem_update_perf(struct amd_cpudata *cpudata,
>  	perf_ctrls.min_perf = min_perf;
>  	perf_ctrls.desired_perf = des_perf;
>  
> -	cppc_set_perf(cpudata->cpu, &perf_ctrls);
> +	return cppc_set_perf(cpudata->cpu, &perf_ctrls);
>  }
>  
>  static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
> -- 
> 2.43.0
> 

