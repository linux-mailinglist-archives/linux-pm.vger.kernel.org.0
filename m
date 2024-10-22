Return-Path: <linux-pm+bounces-16185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7AB9A99C4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 08:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9AA1F226E7
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 06:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8B113D516;
	Tue, 22 Oct 2024 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rsv2FtoC"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C213A416;
	Tue, 22 Oct 2024 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729578545; cv=fail; b=dj/gLOpzLQDK13+9EvgsQP/zklYzyyhkVmiplK5f4eP9EOSuZGay/33O+oCsD4DIiurEVUNHYx3uGlivEQKCA9Qfmuvj44a5FxSxjrKEiOlKMRCVSozXFUCQF3aqwmeI914ZpVQ3dK/BqAnr/OI/09B/fjxliN5CJYdxEOdPQhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729578545; c=relaxed/simple;
	bh=RD6qJjZLQ4hGDLBSTOK7t76giWh5LjpfOMV1FYzhqDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aW7QRdu6VYzq4I6bz3hI4PL8/yTCnqR+DpQZEwHvxEYuqQ2CQZa1yrQw1Ft5EECmdYJYc4ecby4c0ybByKz74se3FJuk2oL10JYSDds6dQrJiFMvc6u0TELMBmNfvjjE/b4s7ER77BlXZhqID37Vpuj85iBcKLi7fPsEewR25QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rsv2FtoC; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRbq16ojajMejdEv6N5xsStcEzkP0uoXl9blrmACLqtqs+Le0NqoFa+zgCEDzLkzin1rCu+rIW+n+O3sOh8xFE5iccNBR2sYKS9HsqV2o6ETTbppRM+/k/lIxf6irazloQrzxUrAn6hcsc7ppYqYbUq3xEpxt0P3/DhBoHcHftiIX8sVDtCoWTDiLTUiv6FfWkpNCTJ6QiN6brXKO6U4eGFNmW7gji0NW0rI6zwTKBLUisXlR58KT/M3vUCEQdjrNHXrkly/M0SADQbQJ8bDoz2IknpQRk3dJ2D5q+BUl3iPgKJ+Bh0eoPjnBdZUbvGd09T3Dj44D4m2wz6s0/AcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8TWdHLVQNtaECvEyzOI3vXvLQsTLe21Kz3x2HZPXZs=;
 b=IiLywNzYIx02vadNQ3uIVHCuCT/lNPHy/Ai009yVViTZKLVSA+Yba9q7X+BwUZQs4dIGQXMHYJhCu45aTFBn4sjDOubZoorrovyDb8JNVVJ1I8wJxGyCI+/p+EgCyElF7dy7Vd5c05OndElGQkGPKYdvBi8LqMyciEVDBk94qLQX+kRQymB6KvMrLt5QnXXfOE/NnzqA+ftM+QsO5sTRQFpFH27hPGBeGG57alHYF2IGGCwCeMEZRMiKS+dA9IPjpIkQzL+rhbAk9d/LloUw3Paqu4/JVqG6O/bw53MsjcolBecRAeFISNX4qDS7SfSGOCWzT3XDuSgRXPZRJOj3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8TWdHLVQNtaECvEyzOI3vXvLQsTLe21Kz3x2HZPXZs=;
 b=Rsv2FtoCQRm3CGGIseJ0b7SE9sFofIhQiEe8o7Z6QtQpKmGgnM8XV+7wzMqdlgIrqxSw/mC3P/32WIlC2vLYfzrRLkoqA6adp51rkIyqDK4I5EWX8jzcM7PmLZ5qxSlhAZ685L05Axyl3XIb5VsqqFoQE0MK6sw9maZRdLU3r3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 06:29:00 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:29:00 +0000
Date: Tue, 22 Oct 2024 11:58:48 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 10/13] x86/process: Clear hardware feedback history
 for AMD processors
Message-ID: <ZxdGIFv5MPMX1HPo@BLRRASHENOY1.amd.com>
References: <20241021180252.3531-1-mario.limonciello@amd.com>
 <20241021180252.3531-11-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021180252.3531-11-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 88670ddb-809d-46b8-06c4-08dcf262d0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QtAEA61DYPy0YibiImFLbQ7WovFnd4j5I0ImBXmppdie3Z09Oyv7/lX2vV/s?=
 =?us-ascii?Q?4CKR8CnseKLg7sQSigWup8F5UbBzP63LMZNRjpY88wS9wfV/h8Ku0XkEkdzd?=
 =?us-ascii?Q?54+2M+8BtPudSvS21A3mxSbP2euxMzsAnX5bo2yZhameS2xkLGvcwTxNV1Bt?=
 =?us-ascii?Q?iUmcgLoAvLtX+76Tby16RTEjMb39q0GFaGtiogA7ilmSyaSwVA9dimnxf6s4?=
 =?us-ascii?Q?VgHxWDrCo6rrxLhk7IKFcmGnFxNDEr10VqBB1EbbucHTwI0hYXq4ump8I6fX?=
 =?us-ascii?Q?vx0ZIuK+xToszzhNIXVI0GM+COIgGqB9WNcp0fGbsc1pjZ9lJu2dF7VGeB/3?=
 =?us-ascii?Q?ystZJKlPiBYMLOEGO5pO/aS7PpftUv1lcZyTZwk6+TeTDa43TEyuyihKnfdJ?=
 =?us-ascii?Q?yZ5fULwvHOiF3ZA/2BInvfqHngxTUsudAKoLU8mRcjAsJzBJcdBNet8QJxeG?=
 =?us-ascii?Q?/r3U0dmuP+q9HDwiAstuF/RG/TAL2fUdUZhDBpTSEB8yVX39yjCRuECOnmxn?=
 =?us-ascii?Q?7kpDYoMPXAdk8wnRBFisw0IPTFsc1L0a33baCOWTH6lbI2rAqD8u446pjPm/?=
 =?us-ascii?Q?ki+vngRrNqfH6hvWzmRN01SX12rqCrMahnwP7s/jAMzb1LLNLPsvfLr5CLpM?=
 =?us-ascii?Q?9AYFZ28L63W/MTZSQzPdcGU9DD6UsXKkm1UCYYP8U3CzkjDc6Ecna7rTov+4?=
 =?us-ascii?Q?xO9UsLSJa+49HpvhK6PUQGJbXDtc2/TNp177yf/R/+6ve1XMIxdh1nnW+Ee8?=
 =?us-ascii?Q?pWGuI/VSQZR+H/93gc0xMk5XhitdEYxDGnQ24HGCZ3dB5zbfQ5i9iRFa/zJj?=
 =?us-ascii?Q?Z4qYkHfNLR2hzOOr36WBHb1TeIj74zsAT/mDgGNLK0HsgZn15TdhzBYI+NBB?=
 =?us-ascii?Q?BHBjsrF5S/FoIZQNIfI1uLmjMenDoUjQyGqzbOk1/uhjyd/ecdUNW2M7a8eF?=
 =?us-ascii?Q?uud3Rx6QtD1b+QMfA1EDYraUMi7lKdXp56GNjDy/hCcjsQTOf5y4Tv6iS2IV?=
 =?us-ascii?Q?wkMwIQLd9O56bSUcrKfCNpwJQVCoyMSW/IUGF/+iTIliai/ZYPbjXK9xZQuD?=
 =?us-ascii?Q?r1f6DDF635DnEyxsGCf+UsYlGCQ+nBLvCZ480+sGdhWGe/GYDpKCR0m2yots?=
 =?us-ascii?Q?PZqrLpfrBPZToRDAPlTcZzD9ZwlPaGfsrqwUx9stUTb9Gsr0R+xNN4f1Gf+P?=
 =?us-ascii?Q?o666eW/kNICQfSPI3g3p3x9tKM7UblBiJiMSxKRiuE1rC9w7k1y4JF9xPcHY?=
 =?us-ascii?Q?SEJxPzPMsoJiLBRO2oj3zcT4fe6K/GsDtR1EKFM5HQAwvHf8mO6qUpgdMoew?=
 =?us-ascii?Q?PQNjZwKnSxIbksQmQPAVKlTH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uRYwWCP5djBC4UQx0zHBKIlNgwMQuEtOOG204oySgbP9/cJIC8nORcd7W0aW?=
 =?us-ascii?Q?7FGagPC1cWmSZlfBnknZnN9fzgTYMHq1AaDyfWUR8yTDGbDk0Q8gwIZMlTNe?=
 =?us-ascii?Q?J/+UAiUYHFCLPdVRUxXg7irwd/e3Ck3rLpG0C+TBbwxSe0rmFxVoPQ8PQmGd?=
 =?us-ascii?Q?S/+avWT2zirkRdz9TVNIwtXiQ/D92qZGF1+4ZSPEecd7Rk7B+lmd5auw62gS?=
 =?us-ascii?Q?VjMANH9fhhyaaTBZtF0bfqKqJ6aKmDDvz11FG3/lvyUbzAbO4TdbRnuAyzJk?=
 =?us-ascii?Q?rg8RQoDHfncgzfSnV6zSb78U9dl/sQWqtpHMHDsWNPfDvMMAQT9jMpOuXfqJ?=
 =?us-ascii?Q?uMi8KeFKVwOvyW892tZv+MA+e94R19wOtbwot9XDG3eAEtbutuoAGFH1x+Bu?=
 =?us-ascii?Q?51GLP70/TCocjhj6mEg0/+JaY1gCTahefdB0w8D6OqBSV1Bu6xj4rkrH792s?=
 =?us-ascii?Q?zgyNt7iNGjtZiVdyvBNxQ+9cjENVmUAhwTJFLdBL8TNFaxn2gLRDvtzHnQAz?=
 =?us-ascii?Q?ALCfTG1CT6ZhaVBQcpeC8Hm10EHGpv07FqJ0Bx/zOplhrG/OOQZAhH+4g9Cg?=
 =?us-ascii?Q?v+E1oxf+9vwIADRv4F2LbEKJqAgo/79YPRANYwAVu22t7c94IJJQFiUUFmaV?=
 =?us-ascii?Q?ieeF1LQaGW6FtUBFWyLpUhng0ALO1DCBQ8ZE5LXKEulk68bTdsdwxifs+l4L?=
 =?us-ascii?Q?Wgn8X+dOiLnMIQQ8oPplCdS7aHZcuKDdB6ApjZdPAl21USLJOCCnLR+lLNqt?=
 =?us-ascii?Q?suQWZyw5rSWfuLzm0RRWdaPAw0t2w3XmpINFgZSg5Lo93QZT6I4LveVqcCbr?=
 =?us-ascii?Q?AVnizf4BSHU1ROImB6UTGKp1JPHuAYWxcjHDHKSdwLS4kA33E0q6kbuE2Is9?=
 =?us-ascii?Q?fwXxYNfxxAgzeDG6tzlNsatI7gDX3/BxzUZjvzxY3fgJ/QHbA1u+6kHIhF34?=
 =?us-ascii?Q?+hUcTUKHm0bKdYF3IF/XJ3cD6B/+ys9WanmTmjfUV3tVGh97dekYP6B8zYGw?=
 =?us-ascii?Q?ILWYDRVZgg0dGokqev8m+2AvHoD0/SUsLFvgH1HvUsbbpGXShSabUDik72TN?=
 =?us-ascii?Q?/hlYBf7ibIfoxSPdd3dGqApTdwl6KAPOP7Mp2ojfCvsBNbGjNnWXLwwuug93?=
 =?us-ascii?Q?ZtwLs/5cKplpQpGIdTH7CI5wg3uaY00zyi4zhWYt9dACFdsdSHYXA1OVX9L9?=
 =?us-ascii?Q?l3D84BgY+yQsa3+BGMIIyWUpeJtFOvqgmhPTM3uvh/vZdFMFTL5SDCMx+AGI?=
 =?us-ascii?Q?YEcpI+X0acCHRuwNBxJc3d6hhS7wZ/gsT+bu6w9MT99wsde+UiNN8FXb74Qo?=
 =?us-ascii?Q?PnaYtEE2idOXO/nJ+SSu65waY21tf8VCAymx9ksMhsIzxejTvi4j1lSY+jg5?=
 =?us-ascii?Q?LN2zivDbgiAWZKWw021262xOe9HVGe4jWbpmIrLzDTS/37iBDfuXVly0pawx?=
 =?us-ascii?Q?Np2CJ7Mj0AwB0HMciWvlwbhYuU3mKJHS06QoK2NopFD++fvnLgrGmjQjoMey?=
 =?us-ascii?Q?FWJvwH7xUDnKn/Ka/uGifDwaVIj9eTa9sJGeAw0M+4cVLDl2tarigMaNOPZB?=
 =?us-ascii?Q?5SFvIFRQSaq4GimZLLpAa8LQ0dVQVQd8HLbEH51/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88670ddb-809d-46b8-06c4-08dcf262d0d3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:29:00.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFwJkPCyNXLdakeKR+OJHwvR4j/dyYu72J9tt+x71U9HdzngUxuojdoIHMCyQOPoLiHm8IBHdKBA9ZpuwJuZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

Hello Mario,

On Mon, Oct 21, 2024 at 01:02:49PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Incorporate a mechanism within the context switching code to reset
> the hardware history for AMD processors. Specifically, when a task
> is switched in, the class ID was read and reset the hardware workload
> classification history of CPU firmware and then it start to trigger
> workload classification for the next running thread.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/include/asm/hreset.h |  6 ++++++
>  arch/x86/kernel/cpu/common.c  | 15 +++++++++++++++
>  arch/x86/kernel/process_32.c  |  3 +++
>  arch/x86/kernel/process_64.c  |  3 +++
>  4 files changed, 27 insertions(+)
>  create mode 100644 arch/x86/include/asm/hreset.h
> 
> diff --git a/arch/x86/include/asm/hreset.h b/arch/x86/include/asm/hreset.h
> new file mode 100644
> index 0000000000000..ae1f72602bbd0
> --- /dev/null
> +++ b/arch/x86/include/asm/hreset.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_HRESET_H
> +
> +void reset_hardware_history_hetero(void);
> +
> +#endif /* _ASM_X86_HRESET_H */
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 07a34d7235057..658c8fb4e25df 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -57,6 +57,7 @@
>  #include <asm/mce.h>
>  #include <asm/msr.h>
>  #include <asm/cacheinfo.h>
> +#include <asm/hreset.h>
>  #include <asm/memtype.h>
>  #include <asm/microcode.h>
>  #include <asm/intel-family.h>
> @@ -403,6 +404,7 @@ static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_C
>  					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
>  static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
>  static unsigned long cr4_pinned_bits __ro_after_init;
> +static DEFINE_STATIC_KEY_FALSE_RO(hardware_history_features);
>  
>  void native_write_cr0(unsigned long val)
>  {
> @@ -481,6 +483,12 @@ void cr4_init(void)
>  	this_cpu_write(cpu_tlbstate.cr4, cr4);
>  }
>  
> +static void __init setup_hreset(struct cpuinfo_x86 *c)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
> +		static_key_enable_cpuslocked(&hardware_history_features.key);
> +}
> +
>  /*
>   * Once CPU feature detection is finished (and boot params have been
>   * parsed), record any of the sensitive CR bits that are set, and
> @@ -1844,6 +1852,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	setup_smep(c);
>  	setup_smap(c);
>  	setup_umip(c);
> +	setup_hreset(c);

Since setup_hreset() just enables the static key once when the
AMD_WORKLOAD_CLASS feature is enabled, does it make sense to call
setup_hreset() in identify_boot_cpu() instead of in identify_cpu() ?

--
Thanks and Regards
gautham.

>  
>  	/* Enable FSGSBASE instructions if available. */
>  	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
> @@ -2410,3 +2419,9 @@ void __init arch_cpu_finalize_init(void)
>  	 */
>  	mem_encrypt_init();
>  }
> +
> +__always_inline void reset_hardware_history_hetero(void)
> +{
> +	if (static_branch_unlikely(&hardware_history_features))
> +		wrmsrl(AMD_WORKLOAD_HRST, 0x1);
> +}
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 0917c7f25720b..6a3a1339f7a77 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -52,6 +52,7 @@
>  #include <asm/switch_to.h>
>  #include <asm/vm86.h>
>  #include <asm/resctrl.h>
> +#include <asm/hreset.h>
>  #include <asm/proto.h>
>  
>  #include "process.h"
> @@ -213,6 +214,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in(next_p);
>  
> +	reset_hardware_history_hetero();
> +
>  	return prev_p;
>  }
>  
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 226472332a70d..ea7f765c6262a 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -54,6 +54,7 @@
>  #include <asm/xen/hypervisor.h>
>  #include <asm/vdso.h>
>  #include <asm/resctrl.h>
> +#include <asm/hreset.h>
>  #include <asm/unistd.h>
>  #include <asm/fsgsbase.h>
>  #include <asm/fred.h>
> @@ -709,6 +710,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in(next_p);
>  
> +	reset_hardware_history_hetero();
> +
>  	return prev_p;
>  }
>  
> -- 
> 2.43.0
> 

