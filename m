Return-Path: <linux-pm+bounces-21621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FEA2E36C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994DC164919
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 05:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF1186294;
	Mon, 10 Feb 2025 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TWEivoyZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0515ECDF;
	Mon, 10 Feb 2025 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164407; cv=fail; b=QS5CXI9tnJuHd1LgqBzHX1EMz53DIoXuirijgmZjYBMfggsNsM9VuwdZghV1XLAaZ98ihlPXfTH1FiVPj0GPlafFAh1ij7pxi61yTuCujaZNd2wwGPKP8YGpCGoVidLSYwzao2ce0eLqlHv770pgygpBkW4eKR2uUJvfmXh4yyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164407; c=relaxed/simple;
	bh=D0MQ8hHqfaJdsWc14tUfgVeo3g325DYhiWv2JmWZQXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NqhCFwG33wtPzbby56lROxgdycROWk+6ldYPPszYrp/VY77AlBbsgLFNaqqBjBh747v08K9H6Q4lvJlc30Kv9jug2Pun+IKqXrsTMYg72495Wc4gatvZbxaxSsvAFuE+zFW886x0t32xR370tw5D334WbmPOgNZJ0p8/4ONbgME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TWEivoyZ; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udI1MI0GeGD2cxzoXcLm1NcDJ2dXwu19Iw5/luS0KIvfoSg0CIW3ZztlhA8VccZX8uG9z86zOITMgMmR/crJmyHAG/F9tMNDtYygjiqh3nQs1AHqnT9NYBinKDkgwoWG8xFIzFRIszPtvTAzYDM2nf4w/3AETLnHlBISULQEBHsLun/R6JmawvF29/SRlouwpFkZVJZOkWZo8BaVMxFV2BhNUPmGSQcJKxPMSxK8xcz87r9uQJsZ/ZPjMPZ+2R5kj6lfeXX/tIyQO025HNqG0sYsxHbmTn1AVTHQ88utBoyV7SglZ+9NRr9nUeDtgCaet+IBH+D26knQP25wVJZ3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBKHRYqGmkoU+fIIbXUTcItCkg1Crj6bzq/LcdN6N5s=;
 b=dyNNZioZohAuNWl/lqDlbmiKPrcVhstHvV3cd8h7RG8apWwxktgpB7JJ/EkBSjpRtFrCJObtByNFnI+vsdlzuUwZcrpOpaOAVb6klB8UvvLuQIfF6gR4pd2VkBOBAsitc0Jv+XMmEMNo4dFU+j4qgVfLi4UAvVHjCBNU+cva/kd2nb2/rwoTI3BP5BlgLGQ+I0FryQujRFg6kh9rkQAfGn9JywOtzD9fMxprAbV7TQSTpVndavt95hVmMveCbBeFfg9rE3P6YYeVMvI6dQMEjdt9pGNstPwdDLKbPEH4U5IIg82RYlhNnDwtLLL+uE/5zvMKBqBwPvYGNuMxg+dWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBKHRYqGmkoU+fIIbXUTcItCkg1Crj6bzq/LcdN6N5s=;
 b=TWEivoyZiliZmAtLp99oaEvOd0DZuzv8uFNISq98QufDGn+giaOVgAVPbN1daakGTouHFyKkI6qKprfPIaG0w5UjA6H4XTzB+ZlnybZfBWu95GzcpO6SrE2O5wGE7qjCkOTdKCMUz8jgE3MmHvQU2+rhP/F8HR7/LXOk7FzKkC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 05:13:24 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 05:13:24 +0000
Date: Mon, 10 Feb 2025 10:43:15 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/12] cpufreq/amd-pstate: Fix max_perf updation with
 schedutil
Message-ID: <Z6mK6/Mo6Q4dxZ9N@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-3-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-3-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: a177b1c7-e52c-4d61-5e79-08dd4991a4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JVto4Cq7tVXaRNbgJfkGyl7QvGB97DK9Va4fi4AKeDek0N93JQAupUdxxV4k?=
 =?us-ascii?Q?dD7jQFjnoxYB5BUh/UmsxDrrMmUY5iXV3Mf69jBjbkiJ4KtYYsYqf4x6oTc6?=
 =?us-ascii?Q?l0EA7Dzp0mNr/KFUCx38wOG3Js8xrj3J7Ki8D5ZedIBAm8j2Zs6zKRXGjKAj?=
 =?us-ascii?Q?XX5T1OZp5jRxWSmS+xqd7SZMbo3QDiKiuV2mhriC/9Tq2W2vYMVXAphRucUP?=
 =?us-ascii?Q?I1hbVgo9kbAtUC/QMj2QuNiagPm0JweIuVfbJnWzwS/1KSp6ulDC+5/rpt6n?=
 =?us-ascii?Q?p/Mqz8803nGnr00OWm3S1ay4zHD6xpa0gXlLMK77PlsiLlCRd+zcG2vVBxP2?=
 =?us-ascii?Q?Xa4BpzZ4D6vHsoAjoxuCXD/bsVrcjxB31cnuCJb2ODmsIIWRIvHSbwSgDAfM?=
 =?us-ascii?Q?PxFchCtRW1c1RiE8rtbXmOpf+XfD9oXtDXU+S1PYQIsWixys+DiwuItkKGeQ?=
 =?us-ascii?Q?privxWcrEkSCes80YajykganwITlas9TLr/PVZ13NfCZajRvzs47fEFkm3Ux?=
 =?us-ascii?Q?MEaVqv3gVEjOZs0u4w/VB4d8eskCnma6YgaKnuicqW2PZRyr/mawkXBXCech?=
 =?us-ascii?Q?2i7GFiRlZQKHO7kxMaGHbo9Oa9vaf2qEpLb8IIUO9LEWXQ82HAetoNK+ePAt?=
 =?us-ascii?Q?6eNlIuWitCCJORVa5uC88jlZNc5fmagYWcd5RAXSi9pexNxug88J45RAWkGO?=
 =?us-ascii?Q?LvN3xcX0FhU9SGGMhg5YZcb9xH+nNx5XZ0VGdpIzu1lsd7ZgpXqEGR77r1zc?=
 =?us-ascii?Q?bYg0TjWB3i2g42e4MjJIGgwJtY89IpKyVPgm+zoUPRvAOgz7xt6ftL1Lqzaz?=
 =?us-ascii?Q?k3UHpCsuXy7cf768kCgxzREBljzGsClYa1CmH31lKh8QdC2DJSrvLVmnFhN1?=
 =?us-ascii?Q?y6yS3m4fAVvOykC6euCDg22nRGmYd6h1d0WcxD8oPjPVsHa5/Le+ChbqDddi?=
 =?us-ascii?Q?6+o+onGVQtEW0vELe5Wr7bsbT1uhFvpBK4MsfsnqkABsVRRQE2Rae1Xz+XIF?=
 =?us-ascii?Q?uuhTGIJj9mS1OQbr07h27TcMKQ6WRvvkFbGAoywBBFL0HsY+A8nq47TzEx1E?=
 =?us-ascii?Q?qdCu6RKR8sjRc+SKuXO4GkY43O/kuxY8aDQ4oBQINT2f2k5JkxiC11HGONRD?=
 =?us-ascii?Q?7q3fhAEPC3X6zEvqfDA2NThdNTdTIgSFizM3wSYfWwOAu2QBkqR0Up9P80LD?=
 =?us-ascii?Q?SKn3Js/cnWtLLESe36iv+ykxGd8aV3LsqXkfrIhXRE8DumBzDfNnksmZ17l7?=
 =?us-ascii?Q?Hl4m+K5XDwYxTucxIvUddTdosoTQ3xQzanlkd9yWHBkYzHN896SKluZEetXt?=
 =?us-ascii?Q?ntG5Vgy9vvLkf41CpRettadZDQeaiSidRcsFOYMhKPbPsFoqCExRlQYX8Qkg?=
 =?us-ascii?Q?BUaWJGAn0iEVZGZ9JLHthn8l2D+B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9S7NRlbBdf8LGF8Qq1T7BZgLMBGM/ybGQhskWyqsCNIZpZ+pxQriiKGU5v+j?=
 =?us-ascii?Q?l6+R2ualJmPurmpWvI63xWO1zK2E51B7gJzRX6+l1Nrqe0zRrwpPdoJi/6NP?=
 =?us-ascii?Q?+j3IVhu5L4fvjytj/24B/SgauJGWgX7jKSO5e0SKmzq4bGCjI8HmAr8MbrAq?=
 =?us-ascii?Q?+BLukEQIe0qPnNTGUBsBicoPqPbxGABLtBTFP1DzeXjOHKhOx+v2W5vjtqhV?=
 =?us-ascii?Q?fAORvKshKTOLkvKtxHRIai3M5T4z9UV44qj0WAyAoG2iyN0iDuNdPW4tP9RE?=
 =?us-ascii?Q?nCjVdMr/KJfmFR/nUeCOilOC5H/UXMTFBvri1plRH+JdVpJTJ1+rhWLC2mOF?=
 =?us-ascii?Q?1MxVV9MnYh7eP6PxOiB4CFWLAvjl96Gl6NkY55z3mgy8ncyFOtXmfTZh0TtC?=
 =?us-ascii?Q?fAC0cdCl4zOBGcLsBGIaBjNOtv2ebAkWFAyggHwKD/qaSK/PCnj4ZKG38kTa?=
 =?us-ascii?Q?shbJZDapzxDsIllBPV6JR1yKeOnfPf/mbgtNIyPkwxcQ7kbX75+nHAEFnG/T?=
 =?us-ascii?Q?w7DzkjGnilDrCMLv7vjzKaknGEftRcuJ+vV8rbUpP/c7ELiy2ODaZZCj8S1I?=
 =?us-ascii?Q?7QddtdefOwBxfv6eC/G1XlaPN2L+5j7QivwejSSFhMIRbVUTdWa7aR4lPkxD?=
 =?us-ascii?Q?Tjkno4rTjm/t1odspZ1Xihmgnmvh6oOlosjePm7mW1iM8DHEMJSOD4oDIMOh?=
 =?us-ascii?Q?VgyCC6SLmPPnTlKciyNYNDH52ZSzhaY/kBDnB3SgvqkklkeJJyC2/ch/capY?=
 =?us-ascii?Q?JEl5WFLQp0TtxD4eWNAm703sBl0MYSHlA7uN9f+Oj2RpP6vSlxl7focccck6?=
 =?us-ascii?Q?5zGB0eza1aRqLkf6C8Yf4oH3gchveVczrwDmf4isupBjLVqoPbO9TQ28ySmY?=
 =?us-ascii?Q?aDzZ0DJWghTX5GMMPssIgUJVUqwCXHkmvl1aG0fTP9QXQDv0UT/foyqXFp8U?=
 =?us-ascii?Q?jUxc1U9PKE9kxINhKJg95nVvOmsXjS/At6bU0eUMKuBe6DS6hILBFNJG23Gu?=
 =?us-ascii?Q?XjiGDxEJq5Q9hKOnbbZrMdtmfMYJ90qm9J3u7tMpfU8dmEUDDmaHkL9nvdaR?=
 =?us-ascii?Q?Z7QQZtGYj64vfkFLOKYDClMCbQH8L69B4mr2/6sQkLYS1D1OA4FtJxlRt58S?=
 =?us-ascii?Q?SdT/5S1C0yU/Lmm0ln5F6uhqfJ/1vKHC1UlIEY8rA+iDtMRfbePylfgizyAd?=
 =?us-ascii?Q?W/1pvLSivVe2+yYh+vttcIr9M4pMB2PEOo4oHiYGhQGumq5DQDHjKjhJZzPF?=
 =?us-ascii?Q?8aWl4DiX6UExV0GCYggPhsKuUzHfTpKZzSW/G/o242pFZGSqfVUOY/CaJgFd?=
 =?us-ascii?Q?Ig+MmnwhXBb0u1LGn1YCudTA1uBss5SiTZyeU8GN9vR8m9CQ/5TMt+yK8nY1?=
 =?us-ascii?Q?2mugVjsuRmJdb8LmECJp5t+RZUJ9OrtziAqpVkqv21fQCCs//i/3KTz3nYo5?=
 =?us-ascii?Q?oM7AH/4opKwtKlJWeRk2s6O5rgj1pDgHkD74tFjZdbI4+vSxFjwRXyc6HDjh?=
 =?us-ascii?Q?iXhjxI9UVvfUpnc5ZYF7qk/QYqbBZzj++4EzRZKrt7euUzTTtpvid5Puh0jV?=
 =?us-ascii?Q?lw1lUSCgTxx86nFFNgMCePHc7dz7bK9c85N6T7Eg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a177b1c7-e52c-4d61-5e79-08dd4991a4b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 05:13:24.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OTbk9h0Kezxb3BiBDTpZMTNp88dASYzpdDBEN6+e6sZLTO9HO5TBFtxlhkbYvBR30jW86ZwFroKms63x0+59w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

On Wed, Feb 05, 2025 at 11:25:13AM +0000, Dhananjay Ugwekar wrote:
> In adjust_perf() callback, we are setting the max_perf to highest_perf,
> as opposed to the correct limit value i.e. max_limit_perf. Fix that.
> 
> Fixes: 3f7b835fa4d0 ("cpufreq/amd-pstate: Move limit updating code")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b163c1699821..9dc3933bc326 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -699,7 +699,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (min_perf < lowest_nonlinear_perf)
>  		min_perf = lowest_nonlinear_perf;
>  
> -	max_perf = cap_perf;
> +	max_perf = cpudata->max_limit_perf;
>  	if (max_perf < min_perf)
>  		max_perf = min_perf;
>  
> -- 
> 2.34.1
> 

