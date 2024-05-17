Return-Path: <linux-pm+bounces-7927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520288C82E2
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A401C20E29
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6942D1B809;
	Fri, 17 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pZfhYN0N"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94017BBB;
	Fri, 17 May 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936627; cv=fail; b=netDn0k+OR95sfb5W5b46OJqv4vRxqukm4iMNW3X3NxyaDxNpPCobn4ajzb+URV/C34xjhV9aQYqSD6WrQPlPgOTGmhZVMPZbSipcn5qwIB15HN381yGlA89NxhplfWG0EaS7Z98U0tR1GUsOxZvP+Qt36vHvfxnFwDyx1iB7Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936627; c=relaxed/simple;
	bh=1OTGnPxQor6Mn308hLBGR/chM8SbYOUWbMYUKkF5G2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o3CckWJQD2/zmUeq6KflMu0TyX9kvFeFAl1y6aFEO9CN+zTbtlS/4kfqkKGOwWH8wWkaFdHIab38U6SJa2J4VYEaXF5J13FK5epjQwxOn7JnFlI0pTlwH6nQg2doCs+CUOPPg6EUzxbM4RiL758woOwbRI3AhILGNwXAvfZ+PAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pZfhYN0N; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU09ot20yxLNWUKl+oWpvMZa7L3lV1FEboXUce0dUIzJQRvc7GqrfrQToTfJZGYQMSx39T2ZBUBjaukO/+efzQhTPhDSmx4SrzfH6jyGafmDFughUxlBbz73vxOrSNqqp+TE4ln5mv7X167WscYj3W7ubZeKPdLniG2faeokFxkqAhKsvIJ3DN14fqWBtcfn5KTyy3HnjVoRdVKq53tGIoGhYRT8/YagecrvYkwd5QY+4rDCKlL2Fc//gdDgEkgGfyOEvVyrYfjw9CdyoruTX0XFJQZiVgj1hm529QEZAthWMUsyyj0+SBG9Y2uMTUOwPQpL0MznWXd769a+ZcSrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ1Mn3/ODQ9FcO8OuGtBAnlomTKRbIKQ9AdMVacf8pI=;
 b=kMNU8kWYdn+0676CsRfsCDPUDnqjEYwv0GmprsmBDAWghOcs1klovswfiYscf1FS3Enfm6cjg+nVTmuJdru7+9tdO2xqYsEej9/1drGskTnmhYYSODcOiamGMWRw8Eb9AmyfEagpHCOeJiZUFXWVtd7XkcUmKChoBFSwwIQGyqc6j4fyNjGAm4a67335nZLvKPJ5QQ9v4uWEmL7njeHHKChxRp6FHWoTYAhuIqo/MY7NdsVbKxBh3irOd0j6ZPEVOei2jLEjmPWudtzZh//I3ciVFDLidFHzJJmq79hQeApSKyU0gyofFxfr8HtplLWDFLJkUi5UebSwOMB6GWEXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ1Mn3/ODQ9FcO8OuGtBAnlomTKRbIKQ9AdMVacf8pI=;
 b=pZfhYN0NfvKYEYGG9y0EBw5QMQHmYEdqdc6xXAiSFiVV7+oFhgrbjpvaPrJ0lfNOOBBUoDWzAzqpYT0gEpInycSDYYqK5JbuncePdFNmqfztLeSyOWTwFQwEVtrjjzuKfRNwg+mqEMQkYQVc2UV20dar63cRWvx3hVwaaFHoUAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Fri, 17 May 2024 09:03:42 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 09:03:40 +0000
Date: Fri, 17 May 2024 14:33:26 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: Mario.Limonciello@amd.com, Ray.Huang@amd.com, Borislav.Petkov@amd.com,
	rafael.j.wysocki@intel.com, Alexander.Deucher@amd.com,
	Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] cpufreq: amd-pstate: remove unused  variable
 nominal_freq
Message-ID: <ZkcdXuHjnLzgSCnq@BLR-5CG11610CF.amd.com>
References: <cover.1715356532.git.perry.yuan@amd.com>
 <eafcb44942942f2a4489980066712b9e505a76a1.1715356532.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eafcb44942942f2a4489980066712b9e505a76a1.1715356532.git.perry.yuan@amd.com>
X-ClientProxiedBy: MAXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::36) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 558d0b94-81c2-40ac-137e-08dc76503e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/FYLxBXqAZv9Qbtj0sHdGLyF53VBG9HwgqY0h2nWhi7ESzjQTAffKawwcSt3?=
 =?us-ascii?Q?dFc8M9N/JJo4Z1clfT11qqC+lZJWKwaME6hzPYlM9CwS+nHhZZoMaGLjd0Jb?=
 =?us-ascii?Q?ffbQJDL+4mFbuSsyt4s9dl2OloHbZxd0AaYjR7pWC5n1nLgKzjM/qzzxutqK?=
 =?us-ascii?Q?CjpKjcoUefC1LcyEMtkM35KVOatu2jbkiZE6Nr5fmuC27Plzk/XlaJ8jjTlt?=
 =?us-ascii?Q?y1KsCeXe+fsrOfvofPnVYpgVFsUa3jexxi83bJe19TegRVUqKmJuaNvfU2QI?=
 =?us-ascii?Q?ozvIRUenQCqnExrMnMYxpyzCMfwXlgnT/UjJvPWyCSg9ViDlX6pk/49TX2PN?=
 =?us-ascii?Q?1uoObBPDN37ZR5YdTMZn1CU1PpZb1UhOiozR7X09aHFrWKHSm1nW7BFF5sQk?=
 =?us-ascii?Q?gqgXlJHMjm1NSHsj3UgUln8QRu9FbtkYNU4Z6KYJyX3XhAE2GCNZqOrJSrHO?=
 =?us-ascii?Q?GOHm+RuecFd81CcB2pVOGEwJSaQsauvzOyfPtkCKqZa3ol+yPmFKfNwGUB+x?=
 =?us-ascii?Q?QfRi4JDF+kUd7WimQE/5nnVEC2vuadRhO2ONerR3+08WOvUm4TFObDQchDSw?=
 =?us-ascii?Q?pagRn2m6ODVgJzVs3kWnaoqNOSc4MzuI5EsX/gFqRwx9Cs31B0OxXLr2WrsJ?=
 =?us-ascii?Q?Wngsa9IeOpHC5xCix19vRCaucvFueMKVkgFBIEvMSUw808r+Efkkng/MAnmF?=
 =?us-ascii?Q?GP7KDOYegwxC8mCfSQgkSWIv0r1vGPDi5iHDlytrh+chPDDR+ccWxFMY5OHu?=
 =?us-ascii?Q?G55J+prOOqEnxxGCgcZknieCmHGg5E4lIUHCSrGexLRDfDw3R2t31hyigMOg?=
 =?us-ascii?Q?Zn+Ejcvpx95PXIeAVC6bIq0erPFeYeluhlRZD9Bqkk+LpZWEznR24QM1QskI?=
 =?us-ascii?Q?SUnGDMemDIB27cPiighs6ESInvD5wVvIduTLc3tMQLg29TC37w+l7a/iPVbG?=
 =?us-ascii?Q?M6XX3VW5EKUe+XrLvWM76EJPN29OVnX7E6TNQpQkwklcjq98avdriLdetZOV?=
 =?us-ascii?Q?M0kP3ykw/3EsPMPVt+8DvVUtBNQYr6wRa3v51uo7bNTTetxM941FT/soD/GL?=
 =?us-ascii?Q?hn4bAeY1Ik8x2YLWv+6L/H/CSe6h/QIn26brHrIhxsGAJLwlVccpgmt2V24H?=
 =?us-ascii?Q?GWSQcMKEGYmtwgyO/rUIfx3hcvinc+jza0e32ncYQjuEo7mFXoNp/nkNqlb1?=
 =?us-ascii?Q?UAYFNAyYrm1aLYkgOhjFdYFKw5vN6GFF7gJU1Nzf3l0ew+6pkJmWf43Csp0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9c4SXRMyyTOGXGNV3nkBQEYrg6CBoVZVnwFNisuwAteym9eDo8QMq0y09H/j?=
 =?us-ascii?Q?SkttP9pc+aDVuJ2iQr3d3gcOwwqARIuBCqyIPhd6jgCELMb9yagXGGZsaP81?=
 =?us-ascii?Q?4kdK6kfw6FDL1obh29Wyj8oBHGeL6wQgE88DA6wpdbiSF9CXK+fuTheMXtMy?=
 =?us-ascii?Q?qS4idTMRR1Kk7ReuC9bSztgBwYof2yOq2C135y22YHr2S5QtqRIH2luZ2wel?=
 =?us-ascii?Q?LKN4zuPJ/DkBQ5HoIOjD0pqbxg+ZgS5pVDqFjloi5FWLrilmJuOX0KOUWCHk?=
 =?us-ascii?Q?U6fADmTRPV2irPwpahdp+CMj/Afru1HNrfQnTfuDGF//b5N2ZyiuZggGmFBH?=
 =?us-ascii?Q?xD4vEJuufT1JTW07PP7QmYO5ANa5+cjgyEPccPoEgCswpsoTIxsq/k7n3HfH?=
 =?us-ascii?Q?0Cxg01RPLbsDpCno/segUWAAma3/cpwORXx91wOx/mzmi0vcEtyZcI5lOpME?=
 =?us-ascii?Q?/qeZeP0vlyWSKj6AsQcNGsxhdgHqM9tx3AbP4op1RLkySxcRaJeDjO6pCHBB?=
 =?us-ascii?Q?CAoNd7zf/6EHiKPH/l83XbVozBWAHZ++WlIN5Uw7yjZATeO8cGvmtOrLTMty?=
 =?us-ascii?Q?xK2c6+Jy5B+C37JyOiMWUQPV3n7rd3JUeGGfjbV1dFQGUyxyYHQjfSvoNwdk?=
 =?us-ascii?Q?QVLyXxxhHAm6ZmDbrtzmgM5klvWDhs74UaLpzVtz20G/UaKaA2QXfKr/JXyN?=
 =?us-ascii?Q?lRFzBqV4uXtbwKNruzm6+TRgYvwfIWMSXpl1u6SxzdmtTzIsoqQoGyhf1Xk2?=
 =?us-ascii?Q?z661PxAnt/yR3QWs80Z4ivvpdidAgJTp/EEBhOIBvhv066T4uSnSV0rbSJYU?=
 =?us-ascii?Q?vZjjtsoqMasLwC7v7Zs+fy3YBcd18RxLrjnL42j+yEP9SIQDIQtpw9tWIjc8?=
 =?us-ascii?Q?/uaXzSDFJc/1pkqaqn/lSAXetaETDyxbxcvMmTmV7bQno8lAm01tHtl/PRg8?=
 =?us-ascii?Q?XzR+nRbFbbjRWJ3EMX9u6K+hg8NCgQg6SvQ0S9U64e6OwOGrSlbAEX7yJzJs?=
 =?us-ascii?Q?Vkr/artNZoUs3Zb1wwNcg1xOQMevskUoNVejNBbad4hUiHCZhGeaZMgAn4PB?=
 =?us-ascii?Q?WSWzoy56ShAStXiM3LT+TriuAMbulLeClBqYBxSWSFPmc5VOvcK1LAK+ieUo?=
 =?us-ascii?Q?8lRLTCMJWfz7lJDPw/rqo8E1RXARBxCbc55cLvjoC90IrvaFpt+GjkuxbyZq?=
 =?us-ascii?Q?918kOcxvLeQNdi9K7wjp7BM3ocGNgC7Hqrc+Bot4Qi6dJHQk5lQ4F7nxtcAP?=
 =?us-ascii?Q?3yTG5VXtoK54mK5A3ljwoho0s9Ef9GJZHrAozU3Jafo1KIWx1kPIQFAqnRYT?=
 =?us-ascii?Q?Lpo3l4hsTxoZhdeMC3YCOSEwHRR2UhbB3cfretzN/PxZX/jX228T/rhACQoO?=
 =?us-ascii?Q?5L2M+rZkeJJPypSNX3bAt1/KUzdC/ISfn4+Zd8RD/29oR6xVnHdlxiz1eIRd?=
 =?us-ascii?Q?AXOwZ7KDrcgfSkafnOl77iOZb9CRDrl39XGyYxNqkq4/psFXYD5rIJwJYrdb?=
 =?us-ascii?Q?e8spdghsHTuLNIkDyXJzAFYedoywzfCwIYJu8BG6+GM27r9LiJvuP6e4XKmG?=
 =?us-ascii?Q?AAdiLXuJbxG9FssDk3tw2fbA5Enjn5k59TV8bA95?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558d0b94-81c2-40ac-137e-08dc76503e79
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 09:03:40.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKV70TgC3tQJykyuwn0KFMkPu3MX2urCBCGaQQCXrbQHr34dCfodrVRpwxyGxVA8gkDLulPJtmieos2HGRy3nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681

On Mon, May 13, 2024 at 10:07:20AM +0800, Perry Yuan wrote:
> removed the unused variable `nominal_freq` for build warning.
> This variable was defined and assigned a value in the previous code,
> but it was not used in the subsequent code.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202405080431.BPU6Yg9s-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 614f6fac0764..9ca22e94f3f3 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -912,7 +912,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int min_freq, max_freq, nominal_freq, ret;
> +	int min_freq, max_freq, ret;
>  	struct device *dev;
>  	struct amd_cpudata *cpudata;
>  
> @@ -943,7 +943,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	min_freq = READ_ONCE(cpudata->min_freq);
>  	max_freq = READ_ONCE(cpudata->max_freq);
> -	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  
>  	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
>  	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
> @@ -1363,7 +1362,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>  
>  static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int min_freq, max_freq, nominal_freq, ret;
> +	int min_freq, max_freq, ret;
>  	struct amd_cpudata *cpudata;
>  	struct device *dev;
>  	u64 value;
> @@ -1396,7 +1395,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  
>  	min_freq = READ_ONCE(cpudata->min_freq);
>  	max_freq = READ_ONCE(cpudata->max_freq);
> -	nominal_freq = READ_ONCE(cpudata->nominal_freq);
>  
>  	policy->cpuinfo.min_freq = min_freq;
>  	policy->cpuinfo.max_freq = max_freq;
> -- 
> 2.34.1
> 

