Return-Path: <linux-pm+bounces-36164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F85BDD81E
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CF294FE6FE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5B318133;
	Wed, 15 Oct 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lQqmr32m"
X-Original-To: linux-pm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DF3164D0;
	Wed, 15 Oct 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518071; cv=fail; b=Sw09gPcR0g8+ofCDu/gR2SQ2qLcovIxMZROqZjZrJbhLfGpxprf7Q9UriEgEYA363JUGIowYX1grJhvzIm0w7EXCw+cljtjHB+JDRyW15Mul+MkhXqgNAmd80Frt6nUKSK2iQSaSBEW/5xIWpG8LnEHzq2Rv3UFKi4nSIBRS1jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518071; c=relaxed/simple;
	bh=C1wC228XLwss3AfVc/tHHNoCAPJgb6ETqPlkmfQMwb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iAhkmWkaR5Q3dN95mfMigUQUlTGGTGQ3hPF6Gsmqwrpr26wSBxtEurhM/HEXux69lQrv1eX3+pYB2BCvoR2fvMqxjxR22OlSNMBMwodWeURFM/WaSGNaFymcURXY1m244JQLzRyV3kUanYdMgb2BXyfjw93ElIJlhY68Omo1iks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lQqmr32m; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNgZnR8LfAV4DAflDZSuCL1AT72SsFQwhOmTax69ppdqTGwBuTmyjcDeig/pzlwMBWTdjhngVLyrIjrSFnBY7iaa+5u+fxeDxON87jwQxCi6ujnQ8f6GiQPRCJSfBUarTN6zjYbvuQYY9HRqiYVQL8fmUbyFWMQtfWHe1g9knR84isydqfI3IEf15ttX2ojk+VL4b2s2p+L4D+m5Vk/MzoQJzywzhhBfZVIgB++i7gTI0dXA6q3Czd3X+4M1l2LVa1HFMGxhYI5FKAEkKy3r0E6dPmQEK7Jn8TnFXLu7Ft9H9yE4U8ejdmhFgcasz/hxRnlS5BKksMMumjcYuNCf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfJO97HiqqhkYpVt1yuB8xmHfGo7auzemom7K3ZWVWM=;
 b=fpI6NDfPE7k3xtZiUd4aPYid8i8/MBGB0CmXHG4hY0Bm2TE7XyON5P+CgLJj3/n8MMO4kfHWJk4vd67zkRS4o7Cvi39nKwTYDGgh6NDM8nDPQRQTBjS5op+PR9XMo+YbDzjnEEiTl5cILQ9CkVMyDGKwI/kMnXt1QZYeltODCyplRTS1Sql5xmt8tb7QlIoJa99K9i02au6+R+Qal45EywMQaOmTbCjVO9ovDwibFKr0HgNLmdDVJJApP9qjRkl+IDcrYCt18XqkH8kyge+0TN6skWiSIn24QDLjOq6umPAefURbLsmhfk5CMwQEqi+pvYrWkksv0/tdYFRCa6Yqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfJO97HiqqhkYpVt1yuB8xmHfGo7auzemom7K3ZWVWM=;
 b=lQqmr32mM1qL6SZ9eDF+1YUWwlfXr/k3HtVU7Aowslp4UtR6X+rOGlB+B92Q8Bk4YDnzsO0h0yxVHmIrZ2Dvp7b5//XfgpmGjhPCp5u+Dq9SnyEpUcHZuS4tdxOHzeN3FlLtYS5FbPwpZSeAUMYOXW5NB+7pHUxw7F79LVSZt5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:47:46 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 08:47:46 +0000
Date: Wed, 15 Oct 2025 14:17:38 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] cpufreq/amd-pstate: Drop NULL value from
 amd_pstate_mode_string
Message-ID: <aO9fqrHpfWN/mdGK@BLRRASHENOY1.amd.com>
References: <20251009161756.2728199-1-superm1@kernel.org>
 <20251009161756.2728199-3-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009161756.2728199-3-superm1@kernel.org>
X-ClientProxiedBy: PN4P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: d1acdf80-42cc-4443-0c7e-08de0bc782f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7dodP8KtAY8B09yzIV4C4R8xwL0ubk+fzVHVMXzPz8reZvajq4qquEUEfUU4?=
 =?us-ascii?Q?YWKcaHRloJCtAopyRsmQRnbgjycE+f5KSFJLZPB5OrA0bu0bh4FtuB1l/mYa?=
 =?us-ascii?Q?LyS2XjH5ot4CDVx0ulOe6XxtxgcTSZkShsGJzc4YtOCbNNpckjySSEzd98Zo?=
 =?us-ascii?Q?kvG2i+QC+Rirc4rD2dFdsWWEVmIlmT5UkcSVkU9cgqKoQltoJ2j+4DJwRg6O?=
 =?us-ascii?Q?wXuwdWCAnlYI4ZFFEqhFPA3zS3hSeefrzy0VIelJLlPBZWtOpDwMxcETKPHv?=
 =?us-ascii?Q?20YOM33Arl540WHj1MtPyXuLUALBTE1LP29b5L2oCm8uQW4dcnOTPjgUZ8Hq?=
 =?us-ascii?Q?rPeQxPC9m/2niKkRNmjlC86brHUkQ5WWQFbwAMO0t46XrL5ozsKWuPWTmUE8?=
 =?us-ascii?Q?oyvOAY5yz55iDC5HP04zEuZd7frBz4MeUVsR2Q1ifnBEYdLP4pamxPyT245R?=
 =?us-ascii?Q?y2cT+i89U3jWNlmJ0kliifHgqYrcIAVnRJdAoGajxjIx04Ya+SFrHlnVs5ZN?=
 =?us-ascii?Q?PlGBWGUO0hHfqA2Bzys7H+r4nqkOmtDTDVf+7RyvREFNvxCyFEJM5g04InhO?=
 =?us-ascii?Q?bzqT5Tmx9avqIu7QCRYegLyzTq4v4Y3FwwqNdO5Sx+VMW/x6eJf2+cN29n86?=
 =?us-ascii?Q?baIziG72D46OA4+XE/OqC59rTk9V+47NIi64DWGHWkm9nXeTXkwofmxdJ08b?=
 =?us-ascii?Q?5m049EhR29lmZyw8ZA1a+w2Nf8Ojc/K4QfoThA5zKww4IIHki1EfMJAQKA4e?=
 =?us-ascii?Q?C1+d25Ozu5WDVstITYqTZvJmOv0wnisRUgLokx/TKNKMyJ9HKufIvBrB073V?=
 =?us-ascii?Q?2kkdkKczflR3K8fG2K82q71IjNRiMsyRH9259z9VWg3Pj8aHCPyVuBORFcdc?=
 =?us-ascii?Q?zXiakPumfYP1IIJuwpZ7veZzvG0Sc6OKBoelrMyaruxwbfsiNEdG4m6mFIyw?=
 =?us-ascii?Q?JXmsrKZxp1LtADEbjVdWRk2B4aJa9ZTMVEutzDK1FNbmP+Iw6MVXk/bqLPHZ?=
 =?us-ascii?Q?c4C9mC2sKcP/JtfksKGF1ROwtZTHepaZ8Aghtb+FZD5Z4df1gM/IS4CtT2Xb?=
 =?us-ascii?Q?ajed2vXbj9dA3Uuj0F50wz8NiEbTPqUOAnORSCZD/Ye8ajGuPx6SPpY/5tkz?=
 =?us-ascii?Q?YL4RvZFXmDTj3z8DolvsWLPIBmg2x4GF1LM8nwyHa9a5QshnbXHcnbd0zHAs?=
 =?us-ascii?Q?vqhuTxWjtFcPowRWhQ66roopHyvOJm1H21rHwavOoQfzz37+dRHYmCFuGFOF?=
 =?us-ascii?Q?cwkRrzY8TaNE15ZvumkIc2LV7elFRw3MrDJNUTjpQ/cSodErNcYdxZhBNY30?=
 =?us-ascii?Q?TUhYgs25rB5XndfHfMEgM8vBEUeXKQ8BhcnTC15yYgzQTe+FSlk8QqaXXUE2?=
 =?us-ascii?Q?BDT+n7U+Jts6btc3POkDnTiSVrKoA7DYFSsH4lM0cvvHYxRc8OAaVWZZBXIl?=
 =?us-ascii?Q?5OM2oryEbqivSJNtYn36SveQtvWLg0u6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZG4W0++z7jJoiCwHHPNnjexRBYX57kAucyfptyuYghccfM8wJY6Z+L7YhYOd?=
 =?us-ascii?Q?JX16Od4JSp/W1f2fXSIn4ndv9gIPYMMO6U2y4oU6we0/Yt9Eraj9FWFgDkgs?=
 =?us-ascii?Q?u25aynkOSr904Y77J9tTZBb56HKmeT1Rf6w/KFUgVyaeayx7vCQxgKQhGMoa?=
 =?us-ascii?Q?ozZ14f7WHm1RcJRVhjqUeEe9fHUC6+bJ98tQOiHesTvP0o8BIzQw6MhcVFrW?=
 =?us-ascii?Q?mwpDT/2ww8MBah4DQ9uYg6+YzL63Npu1pY/dl1bEqHY+daZWfkGmDoX1sq0T?=
 =?us-ascii?Q?3nKm6JKuCw0d9A3Y/j+AYsGMVrd0vDkeS+QeRRwDH7zxme+i8jK4rqHMCRTI?=
 =?us-ascii?Q?MPVNlR11m+8EfRsN+T4Sn18TV/p4MtT0TeulqMxd92ahdv73FiRw0jbw7Rs3?=
 =?us-ascii?Q?IeXyqy2J8nJmBT+yqp9Nkwqu3be0vJU2p5oLSEbHiGQg9fzrTarEJvGF8hwZ?=
 =?us-ascii?Q?GeTAD0Opfkw+hzWSEvGEckLB2hzEJOyC4WMLp0Gx2Dtmw7VC5YyrZulyz5Ef?=
 =?us-ascii?Q?CSzYL4QYpU2sHXf+A+7wbF11Z4jPMGhAQtAruICVfp3hRnJQLQlp0cYY7y6L?=
 =?us-ascii?Q?TyoPgFZkfVrLyY0IHYPOFcgnibqf/M1gUV1bwx+8qG3vdYw5YdqIu2NTAM/m?=
 =?us-ascii?Q?veBizHxQjmBYfNhYlPcWB5p/uo+s+HUHhy4ui7Wope0J/xftK3NuNvbfhs40?=
 =?us-ascii?Q?Gwemb0flCjn93MgVAULSGVvuaAreLgufj1xQZyTCKFw5RtBwAeAxYKOL8CLp?=
 =?us-ascii?Q?VUHzgnDs+Hl9VG4ikfBXOHBw6RA4Qymdxc4kGX6Ftnrxr0DA1ntMkZleiXO7?=
 =?us-ascii?Q?rj+GW1uYKMctO6A6af4aaFzoBv6ZF3emQzag9ubB4FPCTtMMJD9MikU5lssB?=
 =?us-ascii?Q?ZNvNtM/Pu/Itnwq877MJGMPNZLbrL0axfsvkP9zVPHGx8OVNJhdXchpidV1a?=
 =?us-ascii?Q?nziiTj17NSLuqmOh2PoOhzdR0VDizpexE4WTWo6Vf0VvGZbZYSv1N2HX1urx?=
 =?us-ascii?Q?huPYXDK8gOb/YLc+EjtJ4okEGAjySjHcni5+1RaXUOPdzbNW17rcYVNrlwCJ?=
 =?us-ascii?Q?tg8OkuVk8ptKcjgs2R2AlCX7kv8Mse4Dp8K38zVCfdi1oQhHzS9xxRKoYWJz?=
 =?us-ascii?Q?b31WqM27AVk6GQiStI6Uzl/lnFA5AYluVPkzhaTXOAqpSZsAOcsMybhdhvBE?=
 =?us-ascii?Q?1UFr5HYsHKk60d8EF5IAdRgH9Od++oo/w4x+nvNsd9k6AFwexP4Govo9voDM?=
 =?us-ascii?Q?BFT/SE3e+zp3TVcmZ8ElSePwZ5WVft2P6y8L9AxVchGY6HrmTaYnvM2R1OSO?=
 =?us-ascii?Q?s4JDGtLeRJJUGDTjsiBEtXCUoaJyVri+c2PmimPSpKKgH94qHKMn8oWMj/jo?=
 =?us-ascii?Q?nTa71luNY1cLWH7h7w7g5PgNu6XXNrP9RD0RuqhssTcXLARIGPFti2wHeSHN?=
 =?us-ascii?Q?BieluSiDH5mq6fOzpQt0NM/a/bhb55bjNjsFuxe8/9JHrAwtto+rCtEKxFia?=
 =?us-ascii?Q?/ua6csvHq7cQfacw8vyzNOE6GO9ZsOfDdKX42NXv2nB6GzyW/en4a75xBWeb?=
 =?us-ascii?Q?7wFBbAJhTADte8+p0JF9iLagn9EN8zF1VAgOYOwF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1acdf80-42cc-4443-0c7e-08de0bc782f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:47:46.1627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9f8zhuCVm5fhQsegTFMSlbvjc7x1/fY+zYrkHR3ZSUIWVIWDOAISY21hXCQPTlCylCvJ2Cl+dkzGxr7A1RS3JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

On Thu, Oct 09, 2025 at 11:17:52AM -0500, Mario Limonciello (AMD) wrote:
> None of the users actually look for the NULL value.  To avoid risk
> of regression introducing a new value but forgetting to add a string
> add a static assert to test AMD_PSTATE_MAX matches the array size.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Thanks for getting rid of the NULL entry.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 0bc5013448873..a5b9e5baf4234 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,8 +65,8 @@ static const char * const amd_pstate_mode_string[] = {
>  	[AMD_PSTATE_PASSIVE]     = "passive",
>  	[AMD_PSTATE_ACTIVE]      = "active",
>  	[AMD_PSTATE_GUIDED]      = "guided",
> -	NULL,
>  };
> +static_assert(ARRAY_SIZE(amd_pstate_mode_string) == AMD_PSTATE_MAX);
>  
>  const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode)
>  {
> -- 
> 2.43.0
> 

