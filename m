Return-Path: <linux-pm+bounces-21660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D86A2E818
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262BD16333E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4481BEF85;
	Mon, 10 Feb 2025 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ECGkGHOH"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8D2E628;
	Mon, 10 Feb 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180724; cv=fail; b=iTEBoNv53y7gEXwnpbhukLPuJ2gcsfby0Rb5vM3UWcynZRkLsN20tB8/i65g/hoOT8Xnu6whuwGWBoDUZnF6TTUk6DbgDHWeaDwb4eUNy6vH9oQyR3fH/fJdskAc1s10gm0ChTO69Lc04LySLmUohIFwRw3iWQGBrXMMGnjOEWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180724; c=relaxed/simple;
	bh=0RxWQTySCz5HLwpVixblAkLcctjh4AY3uISjjoz+vrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XG6uouFpOqdn1KjfW1DEHGVik2IA2IP3UWfaR70DcwTQskjtv0Ab3J/raXhbVdeUFqvYeXSNaZM3YGK0Z/tvoWLSW8G02eqBj6T36+9nSu1uHHqIoSNdRvnqf80A+J+2Q2pFeHnqNcPnftu2S8MhbPYIsTj9tjHX1Nws9QUdnPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ECGkGHOH; arc=fail smtp.client-ip=40.107.212.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwGYjpOupW8b6e73oZz5H0FjJUKWo3bn6Sd194o2o/f+bwsOrjpGHcuzQGW7McYE+ng2RWD+fuNkLBNDtJmNMhZ+AIrQbfrq6JC2wv93BFgqD6+iLGLQl4PNStWCCMmt3xn43pgevEbMQg5ZzjstOeMv/qDHBHwBiTFURro8LkEkffBVg4V4kqJt7SmbRnItLqH9cdpH++3D7HLkkMYeNDu6HLy1tn92f2FtFuoUUW/hPz2DYzzGJqF2KfMFKHqPMd5qeAhn6kH0mkUqU7QVRAISmlKZ35fTDtd6WhbO26/K8zxSrSuJDK+sQJMUPJ/EjgoccY1qIoCop6aPu24RNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BreUHTFyNiXOmHo2BHNIggsttftwVSSNmHW6pyxm+WA=;
 b=TELEeX1QI4FQk3moLaKjxuMq4pLsPr76feZi+RurQtCmpGMnP7Vc2AHiMTpA6rruNfDa7SYwyENx3n3zqbojnkiMhDS1kzPA0RDLmzuVdgDh/G2dD0P1xZpw/ga0ETDijKxhTVmLSvC8J+0t6pc2EjdyIWhVdbxcJF3jh7jEpy9P9UM8Y3CJ/u1bi0p5S/3N2qtuLTVdjDUdmISPjVKoWhzwKhqaYUqvMPcX5PNQE8lllt3Ki+6Mq7Mci1j+SgB+MuyYCImbLB1V+K6ZnYHfgOtPUhPwLl1fCucCtdP/PoYa8gDuUbJqR9ozLGg/Nd8d7WXf5+DLwb7mLvtPlSM0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BreUHTFyNiXOmHo2BHNIggsttftwVSSNmHW6pyxm+WA=;
 b=ECGkGHOHUJl6yQF0eezUaLndeLbRTh+bqZJFvNEq0H4jFpITiqj4HEGM7DaOxZ/qFZkNRKG9dvaZPMnx5JqSoQ8g+491C9YuyTOFARmO4Pj//8fsu0eDqgxR5CNP7zJgMJ3hlaw4eTWQ2a0aGAWGUwaJp9LQJJc8IpkZyRX3/6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:45:20 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:45:20 +0000
Date: Mon, 10 Feb 2025 15:15:09 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/12] cpufreq/amd-pstate: Modify the min_perf
 calculation in adjust_perf callback
Message-ID: <Z6nKpQTWqh59/zY8@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-4-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-4-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN3PEPF00000184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4a) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 391b3638-5564-4251-01ae-08dd49b7a198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E2WEYLbUf3wWIY5fewC4j7QyCLvcGi/F3KmYG9A+nxk/tUIh8uzhwzTE2N0t?=
 =?us-ascii?Q?x7bOuJ5j8OCIbiwjZ1uaOUqrRZaD3JRBqA+B46Zvxg6Ih1GLYPi9b8Goli+I?=
 =?us-ascii?Q?2hnFK8tQA6mGRmpaLuw57EzeJ7DU3kA/ouPf0shk+pJfUwNN6JQktAaSdxFq?=
 =?us-ascii?Q?9ZuzElYslX79WHoLbdq0UtCUsyrCY4nukwMdxN+cNry2kjJCFBNoIF0vAQjC?=
 =?us-ascii?Q?rT8XOhO0yvzdi+/W08JhH2kX0TSQnOk+w65kPDHIFiw6CS6Bua/QIApVDcyO?=
 =?us-ascii?Q?9++zR/2l5S6XIkrHqW4k8W8c71lH0slB+1b9K3BlyIfyGsBDlg5NLE5JHmIK?=
 =?us-ascii?Q?xwhrbN0PfU3oNzspfJVzKO6e4i/1nCujDxwTjMDxVA3CNiVFtXT+2bCVpwdy?=
 =?us-ascii?Q?Y8RQnN/9hhUhbvYQDoYhNkyCa/sPq7dnJ8aa6B9R1sPFZWRCNxVWmiLyitCM?=
 =?us-ascii?Q?xuFtBRovJkX/wFB4P+/N9gptCFlts10G6MxsYcjvRCKYFvI0lf3HKZEL3VCm?=
 =?us-ascii?Q?4RgnxZNsFCf/Z7Vgpiv/OChpMepoqqe/uK7thj/sPC/VG1YUo0Yi9oqLML0b?=
 =?us-ascii?Q?fULTOP+WVO12cSc7go8ZJBfzTEAvOJU812609uqeei9DsKrdXwi+cbWhXHXB?=
 =?us-ascii?Q?AWhaLHVRkkK0k7feYm99EnbxE5a7TS1mrzRDSFI6CeGJkuLTtIOVaYSKzdXt?=
 =?us-ascii?Q?NRCEVvkhxiGN6Yk+cr0sD2smEJkVf2aJePVtl6pOw4GxzcZV1QRLfjgmPSnc?=
 =?us-ascii?Q?/JBu1DCx8vpsgv1NEm0yfx9rXseu6UHIr/KIrpVO08+CsomBHW7twLlOewHI?=
 =?us-ascii?Q?8bTMziEuxbeHDgl4dtCanuzSezTgKPaiVaMy1i60x00+6Svcmg4h6GfbBLhl?=
 =?us-ascii?Q?lOC6WUr0Atb+kqPDF25+x9xs3qCyoRDrKwGbYZ+PK19LNb6jcSTpLG6rWAPY?=
 =?us-ascii?Q?xacX2C+a3qDqo5ojZ834hrCtGzLE+CWWNl6GpuJaloRHEm1OhsPUVIjX67Wv?=
 =?us-ascii?Q?k1jYDEyX9qMBFsjp8lt0meEY3yvvNWN07ZtBs8CNK4GHEhnEKDJNxBSd96YR?=
 =?us-ascii?Q?wr2WZAtj80PXTRp2D3Potw3cXxSBu7f1ZytvYswgGbbFvnAm4UGSFo4BB7Ji?=
 =?us-ascii?Q?aR8ananqbT4Hn+PeIG56LSlMAIifi9JVV7ETI7b2QwFsgtI6dQlU7lqZt+G0?=
 =?us-ascii?Q?ye/yAyZUjGmj9aQY9B7QR2SfA6yNzMTMOnSUItOEEpqmhTNfu8sX5SWVfLfx?=
 =?us-ascii?Q?Oi8WaIhBhKeM1sPmj6G0ohuVtu3+fPZQwHewtF/hr/ysHRF8PmKi3PzJKwow?=
 =?us-ascii?Q?GRyEMkiRrHHVVAkq8BjGUFzhTQK0YZ3+8jYsb5dfJvRgGUNlbTx+7Nqqd5dS?=
 =?us-ascii?Q?EYG8qomczT7L1itcx3se+HOvNgy4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KmpqmivXql4NLUDgvWQt1LJaoDAJoGIbCugnALxrTYK5bCpMrObWKZ7CQ9nX?=
 =?us-ascii?Q?l1VQYUrhwwU5Jzk3T0b+qu5m43cxzNB7ybRlkrnpI/12bwiG3bO5AcXdfQmH?=
 =?us-ascii?Q?UFBweo0cuKo3pZf6VW45xdfZdIessYh72qg5M3rAQw6D4GaNsw5bz68vCLgc?=
 =?us-ascii?Q?cVYDwdnEJfO7epP5DcDuPCVD5IdHEL/PmTVSRqtMX0uH9HeZRmNY9Xcvq7CM?=
 =?us-ascii?Q?n2X6ccW2hufSJQkk2AfhaBhQU6QTT3j5nf7QM9aCjh/BF1qPOWFcFuRMfD44?=
 =?us-ascii?Q?grdlflgGrsTkpE9lZTmEAWaDR/OCnwVdjD680NjnIJG4M63wrqqKBleMmK3E?=
 =?us-ascii?Q?hJVDyfppAfBwhrLUe7yfTdy8z3cyrDHfsN4sY8R31kN0cr6jYf2mDq0c/Pd5?=
 =?us-ascii?Q?IF+1xbIvgfgYKLPaTDefkIfs9r19dszH82gCVQ0HIl9J1MbxS2EYbncz9F04?=
 =?us-ascii?Q?8u32v9D+ITX3qU1QUO6ECKTOXRhNr84roDcPGGIF9INR1d9oIR9dS12mUn2j?=
 =?us-ascii?Q?DI0ihWnddbffCro4t2zuG8avgMTzsNDrEWnCgeR8eXvc8dCdOaoxlA5AGOed?=
 =?us-ascii?Q?txFHOBJr9L18G/ChMiR7CuPJVmF9RpLMtPPNtihSlFJjc6pG2JosFZWA2QYp?=
 =?us-ascii?Q?93/Ty1F8r8G72LdHlQ3XzXBBRjVbc0H/y0zq0lb/652HLS57p1WI2MyXebFR?=
 =?us-ascii?Q?Y8fy0bG4i7aBSJRJAextVhaOHJIJL5fqI6b8MPGOR9B3SpRq/QeG9nGc3VoU?=
 =?us-ascii?Q?i2AGgO4rM1ZFZVQ5ctsbFapBsPhrIKRNY2rv/XAX6s9bjdhZXF9UKHFgoQqm?=
 =?us-ascii?Q?uv7PVobnjFSr2tlot+5fz4t21by0itYl9N9ItpYEMQZGX/2tkwJt82IAtlyj?=
 =?us-ascii?Q?KC2pnEV50uvoVRFWNI7e5LYuly/NATeLN1yJdcApyGW0zewVBc722ImKb8lo?=
 =?us-ascii?Q?gQaPomz43Vtk7nywpu2R0tfQDku7IBDhSLd0SvVgUYQTKDsm0vCP4q4DunH1?=
 =?us-ascii?Q?3tfGKKjA4OqgWFsEsk0dEFBuy/1qs4aF3X0p5mBQ/864BSWfVyg+QccxbqAX?=
 =?us-ascii?Q?QKwRTh4FI9D3TVNOUYKvykF/n4DQJvuz2G15E4tt2iOnTTh2RKf5KE53iH+d?=
 =?us-ascii?Q?ue/U6LRBa0HR0bdaZMiCdFz6jnGDMn1J2+ybYOaT7EMAmS+q6qIz9Z0VUPsP?=
 =?us-ascii?Q?Bt4QGkfdcIM8WBbEvtqr3oo0UfRWNdp0iJR8xa817gvZPf5+ErDHVhXJbima?=
 =?us-ascii?Q?nqpQqtPnVdA78sZvREmUpgvaB2R2wP7DYGB9N7ZfLikG1og517l0fYC1xi5W?=
 =?us-ascii?Q?Qc/8VupaGwGko2+BM/jO/4EC3NnG7pSkVP5p7J/W6jJcK1i+QTtZ5s139v9U?=
 =?us-ascii?Q?4meqoHGqcxof/2AlPvVEJYtsSycchzz7nmPkdo1/kJxrgbodsMSh6C9YNlz6?=
 =?us-ascii?Q?hYZatFXahuMz1pyHKrCYLqBG0C5oUb3hUAd1LrJc55YRCpUGM2itzKqawV+8?=
 =?us-ascii?Q?rKyovAQG7ko0l281i5ZUPKNIkJUxRC6Fcz/Vqd/7qPzxpGuehYMjMAn3Bwjn?=
 =?us-ascii?Q?90RwXS8tCSngS+uqWjSLmcWxZzMPMTJ30z6L6htC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391b3638-5564-4251-01ae-08dd49b7a198
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:45:19.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0gNGIGki8A9V06Jz+9ym5hPAi6bBQyjnfQa1yWi+EpvUZ896vLJb/qemopSOBEc/fcxAPNO6dI1qyuE4vXhdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

On Wed, Feb 05, 2025 at 11:25:14AM +0000, Dhananjay Ugwekar wrote:
> Instead of setting a fixed floor at lowest_nonlinear_perf, use the
> min_limit_perf value, so that it gives the user the freedom to lower the
> floor further.
> 
> There are two minimum frequency/perf limits that we need to consider in
> the adjust_perf callback. One provided by schedutil i.e. the sg_cpu->bw_min
> value passed in _min_perf arg, another is the effective value of
> min_freq_qos request that is updated in cpudata->min_limit_perf. Modify the
> code to use the bigger of these two values.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.
> ---
>  drivers/cpufreq/amd-pstate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9dc3933bc326..a23fb78a442b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -672,7 +672,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  				   unsigned long capacity)
>  {
>  	unsigned long max_perf, min_perf, des_perf,
> -		      cap_perf, lowest_nonlinear_perf;
> +		      cap_perf, min_limit_perf;
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  	struct amd_cpudata *cpudata;
>  
> @@ -684,20 +684,20 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>  		amd_pstate_update_min_max_limit(policy);
>  
> -
>  	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +	min_limit_perf = READ_ONCE(cpudata->min_limit_perf);
>  
>  	des_perf = cap_perf;
>  	if (target_perf < capacity)
>  		des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
>  
> -	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	if (_min_perf < capacity)
>  		min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
> +	else
> +		min_perf = cap_perf;
>  
> -	if (min_perf < lowest_nonlinear_perf)
> -		min_perf = lowest_nonlinear_perf;
> +	if (min_perf < min_limit_perf)
> +		min_perf = min_limit_perf;
>  
>  	max_perf = cpudata->max_limit_perf;
>  	if (max_perf < min_perf)
> -- 
> 2.34.1
> 

