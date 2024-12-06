Return-Path: <linux-pm+bounces-18671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C29E6677
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 05:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6EC282EDB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 04:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE518CBFE;
	Fri,  6 Dec 2024 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GY3QZeUA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4919413C;
	Fri,  6 Dec 2024 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460337; cv=fail; b=l45eDuEFEyWBDA0GcPVL/G9lyq5dktCftlCm6UWArlQ01ygbWNe1Xw2HQoAMDb988KIayDMaGRYYc1QWSWx3BnmwUx/U+z6GRPMQdkzfDKoi1yWJOlyiUa7caiQaCMcEMxXIoA60/aHW2u465L7gd3sVtesirSJiac3fesGEqBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460337; c=relaxed/simple;
	bh=dwv4iiAdvZE87r4K+6Xer4VvmiUMDpnLc3FBtWV6Agk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fPFCUEaOTcsyAodVj7xbKxr3DLsxnFP6zrd4YweiX8BFIVay0xAca3xdy12NpBLPenGT8ttM5Cp4yqiYptnE++tB8wRHnSlo3JKCu7u+77Z2vqF+hf+zpujLDIRdRNft+MD5SaZ5qRTyVJYn3TPWkTSQtgZFfL+BAS0BlMsAGtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GY3QZeUA; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRALw4McalNFph1qOvOwnGAX4aBBOWxsK9hm1N4zOOqYpSQqHFnEZ7wHBetYK0xB3hKLqQDaIdvibi72HwDfXL1IZ05dz1S3QENqTldUoo0qoY59w/7Uj+qBo/ZVlRQhR5wZw3X3zmjt0hlCWHrqZ/4+GWCOt1O1qIZrHaGanQTGF9UL2Vd6CTnQ692xTTNo1odUww11xfjKS8OqGurirUG4ucjpUWF+0tESNiJMDBug0LVByf5xhkP6LuBoLfVh5BarocuiWYj6HBeFKxpaZfEt6lfzBT+/1UqnPlndu6X7E7o9ZO4kzQBJ9+fRc5F8+501JhNd16speM/wnqV3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IQPSDa9AcV2zmJzk7h4IEtY8ms4aHZ+x2go/G2kO0A=;
 b=HTf4v5dcg+k3SWdavwDQDaN4MT+2efxDoL6QJIA/gRhD4WO9H+WhUMOxdFW1DApWA3oiwWsPSpYXt0leO9dMgAoSdTgTX/y0h3SrAXOyxdRdxm59U8OgAXxRdxy5aVYDxC/4fQGORlLE2/cqg0i6btyMBw36yolxdzcNe2gobw2QYxUOBtCbRkI9PF4FHkDMuId6IBFvCljIlJgNgbvECbSpaRejROF43YUQjfGbzi1tolxxrJynyhiPjQwmsrjHc2rI2jIBOdUHS0TpL61upnlMXE9yUXZ9hWUmriFFtqAvyVBlF+4U5QmSJ2FliR4U8Twrzz3XmMrEr2zRph+Ygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IQPSDa9AcV2zmJzk7h4IEtY8ms4aHZ+x2go/G2kO0A=;
 b=GY3QZeUALINz6bY5sk24thD0gX4KPW5YR0LBAf3jXo39JL7pCPXFlb/Xjws6PcBI1ZMpaaLCnc7iBIqdlNughH21c5ZFqrPZllZrX4JbFfKB2BCa+7etIFvGGPWITTaeXSbM7eHcLiy9uaydpijFOyuBA+mYQahiCfmMAayQxqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Fri, 6 Dec
 2024 04:45:31 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 04:45:31 +0000
Date: Fri, 6 Dec 2024 10:15:23 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cpufreq/amd-pstate: Move the invocation of
 amd_pstate_update_perf()
Message-ID: <Z1KBY50447P1nhRR@BLRRASHENOY1.amd.com>
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
 <20241204144842.164178-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204144842.164178-3-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fdac11-d2f5-4f6e-2cdd-08dd15b0d092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yvemg5FwBTLlIjrcwDTgPw+dPWEd/V+Jv/4Y4lcix3Y7deRDc9M2vobHVWlb?=
 =?us-ascii?Q?80BHMqYVOl6QTQRjs6A+/AjkQKoj678qmSp51Unfs+q92x5tjmwDXEUDdaPI?=
 =?us-ascii?Q?Sr3R9/4oNVhElpQlPf4ZgUo889mvQa4oyWgfDbWv/cXUBJqF9u22EBe6pYw8?=
 =?us-ascii?Q?lqgkZ4pLBRl1SImzDl5HSaM/i17XhszqA4TQXd+CU+G8xk3d2aTfc6Tbl08M?=
 =?us-ascii?Q?rgIMLNIEixio5wakYyXNzHwyrya2doFnDhWhTaOg1//Nu674Q0mlgv41aFxD?=
 =?us-ascii?Q?8yjS1VI9ppYI6rgk9aiw8Tyh7SL+UiIeyfchfDxvTCz/sisVRM6Wxkx4t0Q3?=
 =?us-ascii?Q?N3YkWYm2kXsiw2JH2Btxx+PuCzAPBQZmchuYDqz9mYwb9IM/GKi8EXVWjlQF?=
 =?us-ascii?Q?EpWH98SF4amGhLPKWtZpUmj5629KaB6N874qTKfh54inWOEyA5nQkM3IEGNU?=
 =?us-ascii?Q?UA1b8WInBtntWScWoFNyUsIP+6G1LPm4qMUJJsh7QQo7TbITB+1hDNaO9Wf5?=
 =?us-ascii?Q?HDkt20NPiBflqZ/FU/aK2calyWidESwwsA3K9awt5n1URJwvhuPhkGPxUwaN?=
 =?us-ascii?Q?LACmIG75SMcRSZPGLSIyvBHVqxVpFEde1j9/iaxUmyAAIe8dMG164g2kAslr?=
 =?us-ascii?Q?8NVuoqwse7XzTBtCkfMtnZ86euprpW2p6gAw+GrHZNEc/K/tYIcfYSfa6ZCZ?=
 =?us-ascii?Q?ntFUcqDddcBblJfVcMRQkKWLWq3wkSopmvpgRQ23V5KQOKH/bzE+mzimyzSH?=
 =?us-ascii?Q?n2Y6VYLordPPIGs9BtiJKrx8Fn9OefiNNuV950t2cXKC24lVnhW949QTrN42?=
 =?us-ascii?Q?mUW7vvteolBmQ4JxjGmVzWl0sT3Hlk0KE7TGrBDPniDbCmQepJ2CUO0sc3rI?=
 =?us-ascii?Q?1skgsFSkiGgCiZUrOuxpWfJ4cdeHRjcOLaHwGYVay1YKydmsLzm676JRgQ60?=
 =?us-ascii?Q?Qct654IktGFa3e22DYLKCfWwIO+LO20QnT0ZadBZdeimBVEt78GOLgYdJAJJ?=
 =?us-ascii?Q?RpveQcq18iUiiv5AN5w4LuzRcT15T0AvBPOAESruRb6wYkZkQchAZTnLFU5q?=
 =?us-ascii?Q?3Z73g2jnah2QiZClMu8UWHDbotghOsY9mFofJrOg5hzzDPW9S3V33LTYpuHO?=
 =?us-ascii?Q?WbsKNsa8QNHgWAJ09S5cfLHKg2kp2lIWXKfl6ntWZg1pODxqnphW4MR1g3AF?=
 =?us-ascii?Q?lsWL8Az8SdK28zWrhf5RS1grjPvvJRi3CetmGr9KpYzbYurbUf5fDDzMj8Q3?=
 =?us-ascii?Q?lq18XARMnGzhumU9mp10clUGRtqXBPtLQwHYI1qIleB1LaxbaP+F9a6Dlm29?=
 =?us-ascii?Q?d4OgiYf0wRWXnE70LDLS1tUkto8A4yIMufmRsa6vwUI4oQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMph6h4zUSkocP+B2MV5XpgYXyuEj3Y7Hnd++ZIzLANaG9ZVO691+IIjgMzO?=
 =?us-ascii?Q?J2i6yf1H01C3+xn8TnDjd+u2dQ/HiawlqMqNf7YdWtfuHBgLqMFrTH6mYi6b?=
 =?us-ascii?Q?GeR/88l7YPozTYodsgNAr+t3AJDuUZHq1PiDsQrFbnuqBuSidSC2d8VPJ6ZH?=
 =?us-ascii?Q?2Az5JFXylNFhkO72ZLslI90gdnpRrBA2p5MFXEmWxnEwhjfC+dzasens6Uot?=
 =?us-ascii?Q?xZFiqqgKIAZ35PNHLibC2wTfTRHLXbZWESjlltoKuqJ+OylLfZTspfqtslRd?=
 =?us-ascii?Q?GM8cRutAAEVfshKJqSs+mK6tn+rGlcTUKGp/v0t/e2WGEOo+fazt4BahODq3?=
 =?us-ascii?Q?Sb1AWqYnYA3B0bQf2KM66Avn7BeQPLcxljD1uGv5vASNnFym7tk9+I4hPxTM?=
 =?us-ascii?Q?Nd/CuuRbw02LH+9Uzfr4ym7eFWdDlc/RXYdhoZFvFe2oP0EelQdtZ7WzfYjr?=
 =?us-ascii?Q?o8VG1q36kr5iGMi+SJFQka9LoqEUCs1xw+/4TcLCQfWequ4HEN+36U28Y8ug?=
 =?us-ascii?Q?01vUpDqaAZ0McKcaJvrQEiU1AL9AjrhnO76FsKfZuKqs5X4ljbtJ9UhqFW7w?=
 =?us-ascii?Q?sX/bgkPCnqZz6sCuN6Z4gIrW7KOgfdgeRniZTfn3sSh0JN1WbpCj1DLXhlJ+?=
 =?us-ascii?Q?Epi3G5uYBj8y0rph3/nPfFVWecM5p7tJYJo2xUVG/989cDiSUfjPVYXhWsKj?=
 =?us-ascii?Q?TVYzaw2B4rZ+h/9HPokva2BudVtJedK1hoqID0fknJl4TeK299t21BEdXJZI?=
 =?us-ascii?Q?TviLB6b8AmYD8uk5Htdl9QdAIGIxX18gY3WYDyAz4eZggY/nHAWp2jmADStU?=
 =?us-ascii?Q?qVWm/+z18gwfxKcHTX6kD+VhJASmKwsUaekocpx9kIT0EEE+WdyVeTnrqlBF?=
 =?us-ascii?Q?OUP65t8fwDlkALOsrk9CTUHsT3qaKC46yzOfVggQpac58xODrkU/kt98rJY1?=
 =?us-ascii?Q?8zclccQ9nOBQZO2pcH3sMI2AsL88WPE0Q9yyzLOy04Emhu61qM272RPpTSRU?=
 =?us-ascii?Q?qHt5ymZqzg7EBtw/mhbvXaP/3PSD+whw52MRywQta24d5rO6btsd21NN9Oh5?=
 =?us-ascii?Q?T1H9mRMA4A075qLu8AE7eVPVtEki2xLp8jgAH7y/IDWQM7oAwVNk6HAQiPOS?=
 =?us-ascii?Q?72Ic6f8K6rS58HN4fh+DFPdMGSxla2xZqPWcLhe7VUFrRy1hsu1PrR+AJy3p?=
 =?us-ascii?Q?HGmc7Y3Czd7LhsfefpO9yimhPy0el318p/OQoJm+c97RLy6p+5sZD/YWO3vv?=
 =?us-ascii?Q?tO1a0CgSnPSpw47R25YFWAleIeF9ypE1UMCbZx5/XX62JnAXWxpWk6c1eoWv?=
 =?us-ascii?Q?Q0o7+14coqeJpfj6jOFWXC5My0IRBRNTHTdXGqyhr9djvcBvR/Ar0dV5KgZb?=
 =?us-ascii?Q?qDnjULzpSpnaRSM10NqdFslTzVyXeTWmGIyFz/vvG8plLeHqX3rK2eLhZq/q?=
 =?us-ascii?Q?fWhU3UVZZpDgIXXbB+7fnbiVg9cc5IAymxifA7dEi7jxDtVyflfbYJ3XTcrZ?=
 =?us-ascii?Q?9A3cekolg2p3D/pGbKxnPJkU/M96bJHw8aeEfRoEtup9daqzKsuqMfRIyXi8?=
 =?us-ascii?Q?TqHkJjqLy77Zcgna8MziCgyfnePs8nTNlUUMi4l6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fdac11-d2f5-4f6e-2cdd-08dd15b0d092
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 04:45:31.7545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yfx6j2WZedWzFkjjDEsPsaqUJ077lHjPa22xcvxgv+yBjRgGsaWKtUuLBPyjQeiSi+v9sN3Gj6Cwffas5GD4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

On Wed, Dec 04, 2024 at 02:48:39PM +0000, Dhananjay Ugwekar wrote:
> amd_pstate_update_perf() should not be a part of shmem_set_epp() function,
> so move it to the amd_pstate_epp_update_limit() function, where it is needed.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>


Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d391e8cafeca..a1b2393cef22 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -296,9 +296,6 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  	int ret;
>  	struct cppc_perf_ctrls perf_ctrls;
>  
> -	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> -				     cpudata->max_limit_perf, false);
> -
>  	perf_ctrls.energy_perf = epp;
>  	ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
>  	if (ret) {
> @@ -1598,6 +1595,10 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  		epp = 0;
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> +			       cpudata->max_limit_perf, false);
> +
>  	return amd_pstate_set_epp(cpudata, epp);
>  }
>  
> -- 
> 2.34.1
> 

