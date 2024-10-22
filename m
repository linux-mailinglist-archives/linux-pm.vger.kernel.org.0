Return-Path: <linux-pm+bounces-16182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3349A990E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 07:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50270280FC1
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 05:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924CE13AD2A;
	Tue, 22 Oct 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EVlCzZLR"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0A135A79;
	Tue, 22 Oct 2024 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576770; cv=fail; b=GGfXeq/ngXJYb04aGULeZRl65T1ZyWOTXNxHD1ZgocdB9hh5CdILDpx7yYlLmRpI4gZ0uMcJt5fVI2n0IYDKM+q258UqnS+mhQw9pmVgXYvgTYdk2+lgn0h7UKf+S2CvxCtosvDC92xpcwu+hl4Z51IEP7z8iNJsUp/VOXeiB40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576770; c=relaxed/simple;
	bh=6Z3Ow94PThh4JWBT9Yj66+wl5Y83g2EJFXDhHsiYJ+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ux0guNIjnA6DAlxABTzLNf2GOCfPMBeagKK7CQoUa9zQRWbVZHDy+C8WIzGnUXKlT71X0KbkVQGZbM23qAniQXORzkxL58gILopjHla9iSeNNmPPfIyf9UU3nJkzlKHFUChVtvOj1hzBLpGM73pzQMuu4X6xvCY7cy5IFhbiEl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EVlCzZLR; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVVV2BGqk8cJaic1PukHFH/2dkGSr0MJfBVcc4+b6D6VVMrfzULwluHWxZG092l7bVGDGhBAN/WLfJgO4y85pQYw384gZyEYa3vJcVaue6ygzQKjHL66MCa2yyodvnkl/1U68jlg1FiGBlkYUsFynlZrPYMqcCPImmjcKephtG0KTU3KXBhyV/vdUW52NpaqwU6q750NGjWSnB8fAsvNqF45dRSKaEmuLYDESjMf26pADHcSVbaFDf6GTuxaxz9/w9BMh2EaS+YrihYx9si09hTrRR4/Y5YB4d3YOJN+kMgwURysb4906mn6G86iDF3nZKBjbSwG/o8RKHFH8Y4OUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5XMRnKMJnvF5o8V4p0HMkERNM6E+FLeRnA03h3IgiY=;
 b=EQJmm8htw2bHUbhKioAbAAaXHBEMzIB2J1kvux//6/n1fPTIn8aUJimo4w0vZJ6EFuAkQaQZbjl7P6LQhP7ct4ipwryCS7YnLBSicY8wXFg56K402PqRAzgMEkF5uK1TFTEg62BvciD329syULNIOAE9fVByZB+lAiunqMrv7d/AH14g8wUueDbQIjc7Afj6Tnlrze2EyH9+E5tqG4a6/Y7FByCRquMvqs0NT7DKYeFsC/yI6NgmI7V9UEM1hQ2lV5BlkzFErMQyWKBMKYXYN9kgb4ehHMs76NN66tJCADH4NOMeIRUqEtrC3vlSnKWwLjoNb0uLnaBRp2mYAPE4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5XMRnKMJnvF5o8V4p0HMkERNM6E+FLeRnA03h3IgiY=;
 b=EVlCzZLRnW61Q+aoJwYZXymn3OTD7izC/8bOot0mWdo+HKvOrcDZaNVqmQFMv36xUH4RYh8se/A9lVBj1/sgwlIAdLQyPPcg5ohu7BO18JTox1Ss3W71K0ItIcbcguh8seIKqHeO4OvaKZKDMf2MiHbVnCCF1LXBxaT6wYZIixQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 05:59:25 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 05:59:25 +0000
Date: Tue, 22 Oct 2024 11:29:12 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 08/13] platform/x86: hfi: add online and offline
 callback support
Message-ID: <Zxc/MHYdFR/kTlbp@BLRRASHENOY1.amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
 <20241021180252.3531-9-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021180252.3531-9-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: f9eebe01-a10b-4831-c642-08dcf25eaeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uCUgqc7QzyLgPXMUdXIaEIXn0UniLAeUDUYYQFcef/WrRKPgRkNpmAA3oFXd?=
 =?us-ascii?Q?UlWMyxfES9GvEpxNg5HLrMIQTfRyoy/pXC91pewwIDJw2DopDHqMO2uxnPPe?=
 =?us-ascii?Q?jB6BYxIx4yNvN+dJaYT3el/I+c/PpuEgneGiWLrdMoc4SrkPU8rDrJdViv6h?=
 =?us-ascii?Q?6wCfgxn3BTeyvCcNH+2dZ62Kr2r0xGsGDllYy1AWhCbQ75sDe8NHO/LWjDxp?=
 =?us-ascii?Q?X4NLdlnRRov57HmWKIUAtXRhpZsJWg+j+SX82+A814hrL2ceCK1KNjTTDcIb?=
 =?us-ascii?Q?tn7z4QUwYl321cVmJEcY6KGHS0yuqjlZii45k8QbLeXh1M0S/wpAMsrHADTW?=
 =?us-ascii?Q?VRz1cnb7c0wL28w/+P2/JgOkzD+RZszqEVWNERw0ORCT+94AeiMrqynYTjoE?=
 =?us-ascii?Q?Ozd01v40LWpP/KgLUv5kSLgBrt0pH8mSNeJSxG3OxpVBf/DlP+7XWaThXUSI?=
 =?us-ascii?Q?Vq4qB1atZNCQs7XTc2Tseq/NJE2jnBMGKMinBRUY1NDE6z+jwRhdzk+QCjHR?=
 =?us-ascii?Q?LagmnibptlhOAK80oppjum647yf5zn61GwvrqYPrunIgsBvkzMpCsMuLzBcb?=
 =?us-ascii?Q?Im2h/EAWWoduKm5DFShEusGHqV8L421V7/k+SZh328CzyjTjeX24yJ2MFQij?=
 =?us-ascii?Q?0wxDvgyLr1+NpXCqvd6EKJ7a7mUjAfaCIJCyMFd5zAA4e2NZuA+BBl1PIRlX?=
 =?us-ascii?Q?JG5YFUZPfh79svePbrB0BjSMip4ZAbqIxhELEYH0ADA5O/KQhYc1+fTj4pbz?=
 =?us-ascii?Q?kEXIL3C2KLKPn4nzRHcmT5svnH8cxrDwrLFJbs1nJFN9OaHulQFbQANZbqLG?=
 =?us-ascii?Q?jdY4cHzp7ybdzjJgDpPFpc8ZYyqGfghdg5JN8k6NKL3Z5/ESM2ve5fJzXQ9s?=
 =?us-ascii?Q?9TZdywat/Y4TZasJRqOl/ABcndx6KkATP5tAUogm7KYuLyu/lGb6OTzd6p1f?=
 =?us-ascii?Q?WV7wNOGdKGxgqAHDQmvg/7tKJrFNwMN2KRUwDnQU7of6Gr01OCoxu+Aq4rNV?=
 =?us-ascii?Q?04FeGMm/yk7XF1/NcO0U4rHtH5b020LHKC5UTasn/Q2/rUMvL/4m3mk4WzRN?=
 =?us-ascii?Q?iUbIRByUqRHbj52X7mzBCaIf3XjQsovtQSRsNeTvPitPitC9z99E+wcGGX6U?=
 =?us-ascii?Q?EHecPVJeYTC9iw+vxkjVI2Udi28cNtSBpEqRzhfSQ1ciAoCxCRCWvOrAGAIY?=
 =?us-ascii?Q?Gao+P8IkgRfqku+teLwjgwSupUtD2S5BAVcNkTxAbN8OGfdAYxyI9oP4pqCj?=
 =?us-ascii?Q?VX+3ufldSPitnS83yQWmCrJrqy3qbdAR5E6eNlqb7lBdcN6+85D8O+Fk3jff?=
 =?us-ascii?Q?elu8C7sdYrtysWVmIDoWqmCr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QnheZaOuLk9sEeqFyk74qkB9A6rQwrgp1uXgy+8Nb7wuyxe6uytx0TsmWQre?=
 =?us-ascii?Q?Zcgql27Bv+X7z2JFsj35R75w9SZQfjd0PJgJ7QXFvGz+89Si7PnN9glXIEGW?=
 =?us-ascii?Q?xnaVL4ega+f2VfH8BGsubFQKKOyxWz7F0uvqOxcHmBBOI99khbu6em2kEljp?=
 =?us-ascii?Q?0G59vf+pnwppNTRsCxtEJYKtZQS+Y8KSAgMKx7Inv4YW41lnx1nTU/cZz15D?=
 =?us-ascii?Q?O9Ze1Iok1EAAiluMtjDyYQscsmJln8oS43c3al9dNaay1sanA7GSGjrCLtlH?=
 =?us-ascii?Q?yk+jvjuFKOx751gMrYLmDSZKpR1N91fX2pzj52nLG1JpgVhvXuHTFtQHq3lu?=
 =?us-ascii?Q?m4fWOKpuoGl3Fuv1nCkBy1ki1I2s7bLPOYWBOLkg/ceNSPfa/BZgcNY7PvxI?=
 =?us-ascii?Q?oq5RC2qq0xX2RygApKEuw9sUKikki+6ITddkcr1zwW/0nusHg74TucpzQDnl?=
 =?us-ascii?Q?PfxtzLfxBp7ixXJBKador2rtdkFUczmLWDos9Li1LsHVH2FwmChnnEO0LC5q?=
 =?us-ascii?Q?1ayoDSNWXin8wqk1mf+s6lGL0/5PJjlnDFVB+5YEuh10yqvWuWTFbMafEO61?=
 =?us-ascii?Q?eUQI02jbDSw82vg8eJ6d0+6e4LM3VTm2wyTMnbsIf9WH7uCS0cnbBRS3e2l5?=
 =?us-ascii?Q?QrRJt3Oi3Ab+wbs9hvoUuFap25HBGadNyFS2+UbvKLQfmd4O/subfn+RPZz2?=
 =?us-ascii?Q?UKMS9zieukVTjktliq8M2jVkmtm0OxYC0E1Ec4RrP0MvgON4CTQfduXWB53v?=
 =?us-ascii?Q?UDS+27a10EpYB6crxieE7FXH1b23weDJnEQtlG8iuUAG78nceQHo2nFshhxU?=
 =?us-ascii?Q?o+yisbXt11hLwwMECQlNkykRUsPQs/sqGdHX2KkHf5a7uZrn0fI3NriaPdjV?=
 =?us-ascii?Q?lgbQZblEW5vgxFNwP+dfPMv/Vj1X0RKtuBeQ2xH2cyht9so1t663dCG+/HkZ?=
 =?us-ascii?Q?bNuFApr1NEJk57shU0Hxb6xPkk9tzPV0+PAsE1MQZ290yH2VSHzIuwtSZODP?=
 =?us-ascii?Q?NMndwiIa+NwlgaXUgG+Mfxd6yBmFQZgwjU1xMqipvKbBN2IVI611der+8qJj?=
 =?us-ascii?Q?aunUirfAabKH45vc4PSkPB2eaE8ID9SlI3NcEPEQ6SXkaK9WcG8AxL+5eD1A?=
 =?us-ascii?Q?8T5iuQGXKxCjpxZgLQx32q83gTB57tRsaBm6oRE5OCpdK8QA5dtGZ05XjbPc?=
 =?us-ascii?Q?R/grDUCtlTM3TR6IzeOSsKK4KlJAie2zXVOlrPy/pJfFeGJTLvaAQS1Wvigx?=
 =?us-ascii?Q?2dUu83bIHmpQOKhpJhMs/SpEnIy/mbtLCsKOK0xpdD5MN5Go+7S0g3Qvn27o?=
 =?us-ascii?Q?JkBcoXDhPJBZSKIxNL9lPb84oYd7HOcSh0pqaOGduMCL8fVhDWC6LvZ3TOap?=
 =?us-ascii?Q?YxBggN5IY5dwlevfHhIdSWr3YvasnEyoa3POJYug0dEDopa1GGylOC2lX/eP?=
 =?us-ascii?Q?7TaaOiTRHs8zbPnGV3iHdJEFVI74EDGUBydE9IT1fsoPAyGq0083pay3PSwG?=
 =?us-ascii?Q?87vdtLGJReUGyJCprPmVYFp9R9AlPw0fzzB1zWJb80iN0A2IH3NOSzKr0XeZ?=
 =?us-ascii?Q?KTVucDD9Tb9NvaYm5MNXwGXQpX09wUg1QiuEnZfq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9eebe01-a10b-4831-c642-08dcf25eaeb5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:59:25.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b2WLQKcafhMLFHt3m18DX9tbhWBnUjmZ/l44wnbCwQN8fBK7bSe+AdAZ5eHLx5mfUzsnQyNLdIrHM96Swm0RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

On Mon, Oct 21, 2024 at 01:02:47PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> There are some firmware parameters that need to be configured
> when a CPU core is brought online or offline.
> 
> when CPU is online, it will initialize the workload classification
> parameters to CPU firmware which will trigger the workload class ID
> updating function.
> 
> Once the CPU is going to offline, it will need to disable the workload
> classification function and clear the history.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * cpu -> CPU (Ilpo)
> v2->v3:
>  * Use guard() (Ilpo)
>  * Whitespace changes (Ilpo)
>  * Remove labels for unwind (Ilpo)
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 79 ++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 986ea056fa022..70ddde37f283f 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -245,6 +245,80 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
>  	return 0;
>  }
>  
> +static int amd_hfi_set_state(unsigned int cpu, bool state)
> +{
> +	int ret;
> +
> +	ret = wrmsrl_on_cpu(cpu, AMD_WORKLOAD_CLASS_CONFIG, state);
> +	if (ret)
> +		return ret;
> +
> +	return wrmsrl_on_cpu(cpu, AMD_WORKLOAD_HRST, 0x1);
> +}
> +
> +/**
> + * amd_hfi_online() - Enable workload classification on @cpu
> + * @cpu: CPU in which the workload classification will be enabled
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int amd_hfi_online(unsigned int cpu)
> +{
> +	struct amd_hfi_cpuinfo *hfi_info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +	struct amd_hfi_classes *hfi_classes;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!hfi_info))
> +		return -EINVAL;
> +
> +	/*
> +	 * Check if @cpu as an associated, initialized and ranking data must be filled
> +	 */
> +	hfi_classes = hfi_info->amd_hfi_classes;
> +	if (!hfi_classes)
> +		return -EINVAL;
> +
> +	guard(mutex)(&hfi_cpuinfo_lock);
> +
> +	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	cpumask_set_cpu(cpu, hfi_info->cpus);
> +
> +	ret = amd_hfi_set_state(cpu, true);
> +	if (ret)
> +		pr_err("WCT enable failed for CPU %d\n", cpu);
> +
> +	return ret;
> +}
> +
> +/**
> + * amd_hfi_offline() - Disable workload classification on @cpu
> + * @cpu: CPU in which the workload classification will be disabled
> + *
> + * Remove @cpu from those covered by its HFI instance.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int amd_hfi_offline(unsigned int cpu)
> +{
> +	struct amd_hfi_cpuinfo *hfi_info = &per_cpu(amd_hfi_cpuinfo, cpu);
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!hfi_info))
> +		return -EINVAL;
> +
> +	guard(mutex)(&hfi_cpuinfo_lock);
> +
> +	ret = amd_hfi_set_state(cpu, false);
> +	if (ret)
> +		pr_err("WCT disable failed for CPU %d\n", cpu);
> +
> +	free_cpumask_var(hfi_info->cpus);
> +
> +	return ret;
> +}
> +
>  static int update_hfi_ipcc_scores(void)
>  {
>  	int cpu;
> @@ -348,6 +422,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
> +				amd_hfi_online, amd_hfi_offline);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


--
Thanks and Regards
gautham.

