Return-Path: <linux-pm+bounces-18676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 857899E673A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 07:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1942B1882D68
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 06:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B5198A06;
	Fri,  6 Dec 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x3K4u4Gw"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDC17CA1D;
	Fri,  6 Dec 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465763; cv=fail; b=hATgLX/E0OaTKbHK2vof0Jc3nvOlOIF2sgTG2U3kZo2aufak+X8ToIa7F2UgRox1C1hWODOCMb/h4QY0ZqqPPtZP0K9D+VqNwNc08taLc3khBs9lEuJ+B4ojyLDUinAqB06SKKSvHaNpvc2QTFyog5/WmQmMKtnXtWGeIDCJebk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465763; c=relaxed/simple;
	bh=WW230tGmJQx0GB8P0mHaBC+NjxvboT8wsf8J82gZc4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mIJz6Fu9lRDC1O6ysY69YC84yY92Y56zcww+ZRGsJk0XbLREflFqotoJgeqMFO212Ls2upM7ltilJ28XR/ke/dI+0JCOoppNv2yXsrJTNGEG4GW1tO2khTydR7DeXqrujBHT+zegXumN1nQhcKkOdBAQhQhjb1jxPLbCtY2pB3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x3K4u4Gw; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxjoGwczwebjR/QrGLlCCnY5QQ87Hph6V8/2s9r8b3kzqy0pjb97YmZpNNvrliR9xeK5zYppe0xD92sgFFo2acHZ3do2wv71Q6q90luhL7TfNPZLHePy9XzxblpIUDJ43xWbjZ2cz/S0mNt/laf4VxdcWBsw2sVcQlHSVShARSnHG1NOKGq8hIQ9nEk9XYXA5jvTPNKA505bqIG+8btMqnTOR45J7PwU7Vo3Loia6LCr2BJdb1yYvzop2ancngeTlfzo6bBDHT5ZJHDWKmrm0fP5mRDx4jpwmC/ruTfNIy26e7q1El0ddoOn9HB+psD4MDiNSl+E0cyh+oi4OL1EvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wjK7Wau/i1O9yuyydOIcqYwNKdU/afi9y1xTTb1rCk=;
 b=JBcLk6Rqcxx1h9w0I4OqHsPTBTAD072H3ZjsYrtnfHK4eyWOoUVDEC/31Cgv3+ZjZZDjOAZJ2d3keLblSmsKs1JfICvgtCI/9vD7ivo1ClxWvvbSYwakKT27dCLPnzAptq1X+dB/389tWZjYziEKtXGnJ2fnbHS/pFOsgpDglcEMjM0H2W7cWzj0DsHGOU/uFqfxbSkFukvgnzFw4I2Mlu+yx+uFIl1JPB7RJ4tIr/vWWyc3DigcVJB4S040qne2xfYps3IKNtpfHr5o4as2g/sHssvch4xiuIL3Nk6QOaXmEr2sT875xil8CZroEX1O/Ilt0p+QNSNxS1O1+Ny7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wjK7Wau/i1O9yuyydOIcqYwNKdU/afi9y1xTTb1rCk=;
 b=x3K4u4Gw6ehSYoQuHe4/Dw9f+dIHnKH0nxPtM3fJqU2snVQbKAqrgyelDosluCI/sp8p9meQDDQjuaGSN88j31SqmjwU371nxu0cT12WsdaYCTEoxoz2X1Uy+sf9Fo3iG4lVI9dJY6BzeH9/J+1PYcp44TRfT+ZfQWYJnfqzaMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 06:15:58 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:15:58 +0000
Date: Fri, 6 Dec 2024 11:45:50 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 02/15] cpufreq/amd-pstate: convert mutex use to guard()
Message-ID: <Z1KWljiXpshduCSe@BLRRASHENOY1.amd.com>
References: <20241205222847.7889-1-mario.limonciello@amd.com>
 <20241205222847.7889-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205222847.7889-3-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c292196-2e1a-43c7-78e1-08dd15bd731d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7RLS9uM34ghO0XNKlpLXyYdMDUXOP09XgxI/ByJ2voHmDySx10NIiJSApo9g?=
 =?us-ascii?Q?XAN0vzG9ZZ5Mg7Pl08Z4EQVq4tZXePHvtWcIgTdw4D6ys1ES/Ps7+DFFzhiX?=
 =?us-ascii?Q?GbyfXUfgo5mbjpxmuuJoF82HRDr5ji9A/z6FSSoKIcOLfJ/CsSXd2pp/6HZ1?=
 =?us-ascii?Q?h5JuLLcZRnIoW70U6hnWZnDSaNSxZS/qJJnek7yNd2lbcAf8GU1GJGYMyU2+?=
 =?us-ascii?Q?gtMdPae1rPbYUEZokC0eEOMDqlQCHUyQ43EQcV8r+GIXbz5vPuMpHoFBX74R?=
 =?us-ascii?Q?YsrsLtpZU33InNRetSZHV+kULAnF+8HhJnWKuDxy+7tRD+QIaGfRQQr+9ByU?=
 =?us-ascii?Q?L87lkc/ARxDhanpFBgd8J+CCS8THqC/Jl7KP6NiJLOLs4/UzjMfuV7mfT/dm?=
 =?us-ascii?Q?wJcRjpcz+GYKayFek1SCZJWPT5eGXytPRlToD55PYEjLMngd3f9YqtLf6Tfj?=
 =?us-ascii?Q?VxJTGFBEctAMQDYdKmob22OJptOAsqYfzNqeExbD7mLntL1TWtP5H1Pk/3kp?=
 =?us-ascii?Q?Y/bQYFpCbN5PnWsauK2lweHLF0CKi6wSJRpmUxSqBM84i3PV5vImzvVZuWOs?=
 =?us-ascii?Q?Gc76dQL23cj7KanAolBWkV2KlyeblUx0yaIMKRoNBblyDIOdti0CMbPvvICm?=
 =?us-ascii?Q?Ineq4JrOTOYyd7Kuu3UB3+PUsR7yOmNjqQVHlqdrNTtVNeru9pId2/V/t/jA?=
 =?us-ascii?Q?/VKt+JS3Fl1mPfOCYBxiSfMQ7urgk7bscUe43OGqDiyz0f9tAOdEpBciewyY?=
 =?us-ascii?Q?+Fj5mQH//Nh599SIEu6Lui0PdX/AS/8Hi7H4r6tdwxUXaAoMLi5ogfvQb3Ol?=
 =?us-ascii?Q?VsW51vnJRN5HC7Ha6VtbyJq181EwzaHHuNdHNrje7XahnC3X2c7wDtpakZSL?=
 =?us-ascii?Q?aj82ArxYa7e2q03jLYDThIWiQm/Pv8u2m0ALVL+Eh27povqieyLVfoofxk5a?=
 =?us-ascii?Q?tRldYVKShesS+ryCV7uilajzrqbGjfmVLXaYH0Ui8jy6K/+ZGTECEQGvqtF5?=
 =?us-ascii?Q?6tDXZJhUSGTni56kanS6/1gvz18Bge2zfCEsDrflqx+9r6GCJc4KeiIeMb66?=
 =?us-ascii?Q?Z7tWv/IIw+XqEtP8AJOXFXoqloljuGZ+h1tWV6wGsYCdlsYJs8XNmJLwjjZ7?=
 =?us-ascii?Q?O9k36HYScFojeranaLYvC80PJXFZ3I0LhUoVeKnt6W+ba8GXmyzuqZ9CR8kg?=
 =?us-ascii?Q?3JVAJ3A6INfMFL5spZQgx1iy6KyoSSr/2m801zuMiGE9uWpjaNEn1TjmG+g1?=
 =?us-ascii?Q?tqXphp/hfQFO0/M6aTRBQUsmxkDvO5W0NnZDWTRmOK2zaoMp4LgangG2PuFI?=
 =?us-ascii?Q?R63ocZ4C9WjLx7j7FKbOYq4ISke3EEAasbHPg41A520OSpjotfEGan1qmBsY?=
 =?us-ascii?Q?49my08Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mosF+k3Jd3MCO2h/aicXFCYNCbz7YKzGMUbUBPhgevfRa+BIQBpU/g2NsXJs?=
 =?us-ascii?Q?2XVwLYW4A9/ZC5X3YgVMfc/QvTR5C1v4F/Ic1px0UFQr/lYNcYPLGpYUj5AM?=
 =?us-ascii?Q?B9+blJwJAzwYnB+1Daek7Lf9RpPr/nCa5neY50ASKPB7dMpk3l8WibeuofJl?=
 =?us-ascii?Q?60YLC08IhRwjtXg7rVfdJm2aou3bY6+z1KKaV37cqtJXAM41okomJRE6XB/u?=
 =?us-ascii?Q?JSw54m//Nj21+GieilwXun+7vOUqfRWAyRUDq8hJBBUWIhTv7EWdZM+eJ0Lb?=
 =?us-ascii?Q?T3bFWD9OctzS9VoltsNPQ3puY/PehAuCXvkH7d7blgr8mzgTSEQVVVAdgSm9?=
 =?us-ascii?Q?r3eUMe6ydxtKaHx+uUeKHfLqJB+gepiJsH23110iZFxzMp+1fJH43R0hiFVY?=
 =?us-ascii?Q?7qVE2wMU00P9PMBqd5/c9Szia/wz+s8oXVRHjzWc1k6/lYELJLipX1bHXtrX?=
 =?us-ascii?Q?Mb5XXiD1GNaWgtWkYooroYYB9E5IJhXs7gk2+xT3Tnud3MO8ld+Og+hM08dL?=
 =?us-ascii?Q?FYJej4z8VSLD+pLQPaI0ZvkGh1oCDRqEf5Ceb3bVyj1+mfI1Sqy80BP8RfsT?=
 =?us-ascii?Q?9s6IoR48g9qbLWg9EBDdlnRADif3SF603TRtqLD6tzYl3KkoBci3+yVjk1K1?=
 =?us-ascii?Q?SIkUHKKcl7elBmrFZje91j4/G7CEgiXkZPQCdUJr83wLO7BH9FbIvfBufPIo?=
 =?us-ascii?Q?qFyki616DMXcfhq7ptHhAMweWLQOEZfTK7wtaqviHVqvL9hKPU30RSPfR76M?=
 =?us-ascii?Q?QiHjQa/6BW9T0LVAWlSFSprTKC+NKj8zLrzDjSC/2Pgl0VCuLpiN/LEOaPwK?=
 =?us-ascii?Q?wj8n7wweFnpUb96FikZEO/cgNFi/x6R9AYMpkls1Z9JNwJMZF9fDSkY8t2ec?=
 =?us-ascii?Q?diGoHJatb1qIhcw+ohRnnfUZNB9z7CvQ/cpXsbLyBdYpPwakF+vTqX8T3SmJ?=
 =?us-ascii?Q?wA5ZP85umEwdq5Z2LJ5WPI3ar5mChvoK72bgtubY3qS40B8q/43cNs1yJJc2?=
 =?us-ascii?Q?38cqoKKGmZ+pUBIPK7H76c+t5R9AHwH9Mimv2QRZLW2P19UftCOsqoazB8Fz?=
 =?us-ascii?Q?eXMBEHgskgk6qlCXCdvDITVmJrEnzALHrDeP24ngJ1hOh1AwjYqxpfzaFcdK?=
 =?us-ascii?Q?8Ssiwoq/Ibl1oqVKRuCIOuczLTxGI5RnU7OTztt/KjOq6P+Dw5ftknOqKIHb?=
 =?us-ascii?Q?vI/gzJSCqd+V0QudXOk9OP78keCqqtz41ShhndJnEfyugpaB+wjeXZaAqlej?=
 =?us-ascii?Q?vv+vJ67i/dLP+4//vnmnnSatkDojJs3vE8//Cpx2DeAbYAn4tqffds7A24fM?=
 =?us-ascii?Q?6pmDuOwAY59/MoxunJkV0lOWvHFjbaKH65HdS0zlVbiADdy384navgW+W/qq?=
 =?us-ascii?Q?3Wqdpz5h8w0mqUofBQHBNXRuxTamy5/kHjjWwsJLmCKAQg85vmkyagQ/ZOkQ?=
 =?us-ascii?Q?ojcCfU7KGopw/HNhQ2Ka+RJn2KqFu37EsLxWY/cVeyUVxj5eQ/EJ/D4M/jgT?=
 =?us-ascii?Q?n6WgECoDf0+a4PwbXQ27bs4jNbsdpqJblctyRcJ8hEAkWDJohr1EWXm0FwEg?=
 =?us-ascii?Q?OBZWieXkflau2NT1LTuJO5ofs9xHx/IucL/n5m0H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c292196-2e1a-43c7-78e1-08dd15bd731d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 06:15:58.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln4NjrcLgyz118NdpK5qoJUo5smpomoD3fjW+K6IX690PFHdRuan2SJFLnR4OIoOxq+BxQIkUqDpo3/ZIhcqSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757

On Thu, Dec 05, 2024 at 04:28:34PM -0600, Mario Limonciello wrote:
> Using scoped guard declaration will unlock mutexes automatically.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>


Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.
> ---
>  drivers/cpufreq/amd-pstate.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4d1da49d345ec..7eb013585df51 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -752,12 +752,12 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  		pr_err("Boost mode is not supported by this processor or SBIOS\n");
>  		return -EOPNOTSUPP;
>  	}
> -	mutex_lock(&amd_pstate_driver_lock);
> +	guard(mutex)(&amd_pstate_driver_lock);
> +
>  	ret = amd_pstate_cpu_boost_update(policy, state);
>  	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
>  	policy->boost_enabled = !ret ? state : false;
>  	refresh_frequency_limits(policy);
> -	mutex_unlock(&amd_pstate_driver_lock);
>  
>  	return ret;
>  }
> @@ -848,7 +848,8 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  	if (!amd_pstate_prefcore)
>  		return;
>  
> -	mutex_lock(&amd_pstate_driver_lock);
> +	guard(mutex)(&amd_pstate_driver_lock);
> +
>  	ret = amd_get_highest_perf(cpu, &cur_high);
>  	if (ret)
>  		goto free_cpufreq_put;
> @@ -868,7 +869,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  	if (!highest_perf_changed)
>  		cpufreq_update_policy(cpu);
>  
> -	mutex_unlock(&amd_pstate_driver_lock);
>  }
>  
>  /*
> @@ -1201,11 +1201,11 @@ static ssize_t store_energy_performance_preference(
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	mutex_lock(&amd_pstate_limits_lock);
> +	guard(mutex)(&amd_pstate_limits_lock);
> +
>  	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
> -	mutex_unlock(&amd_pstate_limits_lock);
>  
> -	return ret ?: count;
> +	return ret ? ret : count;
>  }
>  
>  static ssize_t show_energy_performance_preference(
> @@ -1369,13 +1369,10 @@ EXPORT_SYMBOL_GPL(amd_pstate_update_status);
>  static ssize_t status_show(struct device *dev,
>  			   struct device_attribute *attr, char *buf)
>  {
> -	ssize_t ret;
>  
> -	mutex_lock(&amd_pstate_driver_lock);
> -	ret = amd_pstate_show_status(buf);
> -	mutex_unlock(&amd_pstate_driver_lock);
> +	guard(mutex)(&amd_pstate_driver_lock);
>  
> -	return ret;
> +	return amd_pstate_show_status(buf);
>  }
>  
>  static ssize_t status_store(struct device *a, struct device_attribute *b,
> @@ -1384,9 +1381,8 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>  	char *p = memchr(buf, '\n', count);
>  	int ret;
>  
> -	mutex_lock(&amd_pstate_driver_lock);
> +	guard(mutex)(&amd_pstate_driver_lock);
>  	ret = amd_pstate_update_status(buf, p ? p - buf : count);
> -	mutex_unlock(&amd_pstate_driver_lock);
>  
>  	return ret < 0 ? ret : count;
>  }
> @@ -1687,7 +1683,7 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  
>  	min_perf = READ_ONCE(cpudata->lowest_perf);
>  
> -	mutex_lock(&amd_pstate_limits_lock);
> +	guard(mutex)(&amd_pstate_limits_lock);
>  
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> @@ -1698,8 +1694,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
>  	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
>  
> -	mutex_unlock(&amd_pstate_limits_lock);
> -
>  	return 0;
>  }
>  
> @@ -1728,13 +1722,11 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	if (cpudata->suspended) {
> -		mutex_lock(&amd_pstate_limits_lock);
> +		guard(mutex)(&amd_pstate_limits_lock);
>  
>  		/* enable amd pstate from suspend state*/
>  		amd_pstate_epp_reenable(cpudata);
>  
> -		mutex_unlock(&amd_pstate_limits_lock);
> -
>  		cpudata->suspended = false;
>  	}
>  
> -- 
> 2.43.0
> 

