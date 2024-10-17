Return-Path: <linux-pm+bounces-15829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA209A19D2
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 06:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB167B20FDB
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 04:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D313A3E4;
	Thu, 17 Oct 2024 04:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BGnrQrQA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B12F36;
	Thu, 17 Oct 2024 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140462; cv=fail; b=DDXFouRxvElSG5EIhpFHz0rAgI4G1ObaxtjrIhiTeT98I0nqew8X0eJFlVBIB5m6aNydv2/WeYRqHkojprPPF6SJGtCo5MA5XDm0DwLrNnO9WmB88DZH3mHOtolfwyTsInQCOPLjMT5OYtkm9PasKSuShRISs6uSMHelHJtboaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140462; c=relaxed/simple;
	bh=pscTndexECRmMyS02Vt6ha8Xzc6WO3UTrMGnurwsktY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NBLNgsMAnOvq2AFhid7SBpzgoTgR0HZJnG4PCadz57MNLSnJFUdgpoGwTPpMZ3/xkUe0uUA1JI8mSNspbof0O0QQrZiJ/4M+0BBw5kBJcxO1cVOutTbCXJGYH0ChHTFjVIFBaLzTf7Gm+rCBVjwBeQTX2U2fkVdKVDmfSdoTMNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BGnrQrQA; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPeA8moavXZgCBSQi/RAUArAi+/RkyLu/pQJjATf/5nd//MBk9ogHROG35GylDhqYt/xT+LiM+X6bDhNDA5yQKB/qJX2tz992dq+EfxIRiC1W/z31SUZqYXonDBuFCJv90WIlpNfzLqbRk87N3DMu535aVKTutOM8oHce6G+V/MucSNosmXMHsDQf1TBUy/lnvsoHbZNDn4sCLftti24a2CddDJsyhqwqPvtTewB6TDerbr6Zg7QGH/oKZR9+3tqloH430/kYAW703pvkf9B+j2LDX2i/vG0vXd0WAshXUIxV49Jt3Tap4mzBh02eNBD4G0rEYG2K9jJ1w3+ToCzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vFWP9I8IDehzlENdIh/AjeRQmHznunBY/X9y2CBMTc=;
 b=PRqwcUkoT8f5oZm1Fl/+BY78/aZc9LwWXd0evzZb9okf9wqfMuGVgjBUEQIRxzDUf3JA6QbWUniX61ENEXzeg+7TJBonO1ESkQVTHb1ST2Tlrx4D6aptVJ+5z0Ju20tv83kmAjGZ4zz/V6l0Hwh89w0+YUQopw+lLuB1P5cB0ZDyiEt2lRDBdnlpOg7BUB0mCM41x4Z6lQ/MzkHIjTO0iexuGfrsw2mrmjZSeqvHrihZP6t+hykagPLUtqHFoTtGoZwCsyVkKjDgXG4kIO/ELtWMMU6tPokHVx5A/biuYkgayom29lIiklecvm0KZwuaEQd9ujgIAUObPBakRron4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vFWP9I8IDehzlENdIh/AjeRQmHznunBY/X9y2CBMTc=;
 b=BGnrQrQAEqBchlsEZTg6HIJBfWl+ia83EtH5CYLCR7LQXQ7zJHLHqsd1u+wYWKKc/MuAhLQ7DImEId2Ln/oyF+Ww/2tXGdb+8MHzRAsr1nVHX5IU7YoFSkvzO4aEY/3ay+jkc60tOhL8gfZnsk2H5XddCx11ytLqFSsNbSKmMBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 04:47:36 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%5]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 04:47:35 +0000
Date: Thu, 17 Oct 2024 10:17:25 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 03/14] x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS
 feature bit
Message-ID: <ZxCW3bLUQhMqv9Rp@BLRRASHENOY1.amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015213645.1476-4-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f122e49-c3c8-49f5-2ea8-08dcee66d1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oVhEa6OLhkNIT4cvkNU6/w9UrmJkj2OKm0h8jspa1jqgix/pfSsThJhPVXdv?=
 =?us-ascii?Q?nm+7hzoi3rMdZybHcZwaOfZsN/IbR5m4yHUzJLOWhCrNSaGBxq+GfPoNL3F+?=
 =?us-ascii?Q?VbYknmBRgcucVk7aZiD3D1XroPp+6k5D/xFujKuhJZtbaIDjx74qUJQcRYo1?=
 =?us-ascii?Q?RPyjX70TOzI5Yt8JlqacCZtelH9R8/aYb1TwqG1WjRoN6IWZtAWxDRTQOP1n?=
 =?us-ascii?Q?3Pulv1mLtgD58CCRUBziOFBidJqs/hO/5oeybDWuv9J83USGHmnSNjmObl+T?=
 =?us-ascii?Q?RExuLuIqw2B1KJmiRp7s+7bQO0zMuQeAwE14inMhNxmVx5MNrupmOlqVecZB?=
 =?us-ascii?Q?1RpYf050d4ZCftpX+MEHnDGIKhDB87YHjLz9bdiTgEd+Bm7Q/9Vv0p+rA4/L?=
 =?us-ascii?Q?a5YUg226oL+6QKUC9w07ojQbQ/ofdg8F/lydS7+FG8kfHuUr/dK+kpfE/n9g?=
 =?us-ascii?Q?5xyLpwmIK0Z7CiDhM4AYAcv+fY6kFS+Rkv7Pg5BzzM1FGi4KswrnM1NnMucN?=
 =?us-ascii?Q?CssKK2XOHloV31zWW3MHcutzKNoQvTQgnx7cTLWAgdoQV7ClSChmN81kN2ST?=
 =?us-ascii?Q?2hD07dPHFQnT6mC2CtMXzJ5qDDhVft4M5qIgKndiMNpNyTce+z3RnZKiz/Gx?=
 =?us-ascii?Q?GhMuRkGdAQM0qf6fl4o1R+7tzreaSRYpnXKJk4F630L5gxRwoTc/tVi0KwIT?=
 =?us-ascii?Q?mZ5nIyuCX67W2A8tGx4RvUj+EbKLeOiHzYSVMnk2oZX6JYsPoYLpljiUw/OT?=
 =?us-ascii?Q?QTKD4WEhJrTil5Zg9ZAblZUKaoCMEGXWCvJWYKMRmRRZjO3VW1wOxcQYiGK1?=
 =?us-ascii?Q?h4a0DT0ydTOCn5ORERPpqN/NX6C1YS8+da0nUi7KPHgAlMiooYq5or5MrOV0?=
 =?us-ascii?Q?PadwkiixWpfAGzUqNQfIQwmgex8oZV+EX2UbuIxyZX4A3kU2MLBmj3E+ktrO?=
 =?us-ascii?Q?agyK2UIVw1SW2mYWZsky81dNDQgcykcRy0Yl5Oa8kUAFrmju+t0C9BB17EML?=
 =?us-ascii?Q?SuXentjX9yH874ODOJUUQwfPbEXH/8yVqyN8LAZPEDnpDmwDvwEmGqXw6/1N?=
 =?us-ascii?Q?+rO3L9rkFCIVuvm/sPQZeY4TfM0alzT0QrLFaOxJ5V+AW8ah3V+U11UxljTN?=
 =?us-ascii?Q?ym96I9gdESsTmNpfFU2iuJpzdQENE24Cipu6nsaajsGkob3qI1LH6dBZV9gz?=
 =?us-ascii?Q?krT1eciljS96RsRQAbaHbK2TGgl/+Fs35nSeb6RlF1ohJdj0AcoufOhPNpao?=
 =?us-ascii?Q?EzoMINzFc7I7DMhgZqnPgugwfg7dy+dJR8qFCpRkfTLHMAGpSQ/NQvM2raYO?=
 =?us-ascii?Q?9vTdAvox3tAHl77TxRok0Zo1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xpYVuMct5JsDmRdKaPWAxTwFvaDZHNoQNlKGEm2MCTzHN+UJHu4iiwTkHukq?=
 =?us-ascii?Q?sS2Ox0nXrwb+L/N81cojYKx5x/XODjVuWcI/Tab5ERJDSl3XnFX8Ty4iSCGs?=
 =?us-ascii?Q?v0yjWfSdNn1sYSwi3MO7dcalyWZF8k6XDo1slOERiMmN6kv8yLfB4+cig03T?=
 =?us-ascii?Q?saQ1/xdnHSudr0f/YGwbCxA7yp0UPNV9+A6Ml9T9rA3YleaCJyI2I9fbDbR0?=
 =?us-ascii?Q?pVSjGlkzsqTVblDymbFDqLcwCqeC4TB+h1aCTFWXDm/1IBsdM4YhEfEjAO1s?=
 =?us-ascii?Q?sZJpno5K5AORNBSgsQ1rLyYCdny0bEYa2CiX2blh6/AKxbl0FT/Rt/4BjYSg?=
 =?us-ascii?Q?+/XdAnlUSmyM+IAn/CdgdUVl0O/OHN71X7ZUoKrh3SW9T1p5nUbheRZiq2qK?=
 =?us-ascii?Q?gWN+hhFSfAQuS1ScHBtIJOor9mPBhbLP0DjpEpwOR7miNdCxvFSpSAVugH6w?=
 =?us-ascii?Q?W5YNNTT6Yv1xHNROsjMVx3KvCZb8xckiQ/UFzDcd0PW/+6RTy6901FVPqDU1?=
 =?us-ascii?Q?2tWVD0qRSD1cjpa3m7bwn5dbj8naECdsZ8QH9kZvzVU/aY/+BAuWjvYQE5MO?=
 =?us-ascii?Q?AZ7xJQoBYV5GRRR8ZboxV3KjELcVNlVdJLC4K6N9R2ynYyGr9CD7Q9ZKrYtD?=
 =?us-ascii?Q?RTa0/Tb+Bt8ZPFVuqoRFKr85okU5f4QmTj3/a7hgnmcWr/TEpeoCt27rxdC/?=
 =?us-ascii?Q?Lim58vfbqVs3J+w5fhH99lAUCYn4R9mWGoasdwIdsRTkir7wjj8/Qn/eg0QN?=
 =?us-ascii?Q?MpZinurXFj9ex04IFuWY66D5hGpXjnVbCFGbG7BSFhe1wJ0CLJGdfgXRKY/0?=
 =?us-ascii?Q?zsK0YRRQ6XXPURziVPFPEcIJxo+69dvsv+3O++D1UjDkx97wvoWudDBrrFEg?=
 =?us-ascii?Q?TzSDb/CdFSL/bfRRWEpkqiNZ/Q5hZ8KUOewqU0lNZmHyE2HxqjLq0ULxhMWX?=
 =?us-ascii?Q?UjRLx0fZoMTGSUNBar1ZpNzhZMKWlmVJYGsH/cRiaod0d6BIoYwrJ7QCzxPx?=
 =?us-ascii?Q?FkQyqmwC+Fqzbo1SdmXYdCjT6eMRFBESjIJLXzjkno3EYIonys8cHNeySdIR?=
 =?us-ascii?Q?1nZgfJhTKXxB2HtKWIfgNo80XmuUwaiTHiQlhQogfyiHmHzugIJcCYkG7jTs?=
 =?us-ascii?Q?QKaVPwWuJTHRzAp1e13bOb/Qod59DjlDY0cNLVvQWzfoQ2G2QUkK0MApnpwB?=
 =?us-ascii?Q?4Pdbo1Zoq+az/26hLcZRXRn07Oki7YTLIvU3gwGKDC33o+rnm1BPyKNK9op6?=
 =?us-ascii?Q?CY+kEO4wz6rHNNSbA9iYcnmx6GT6TjVWjl6Cp62pNo/0ieIsf31n6y4Aqdgd?=
 =?us-ascii?Q?MP84yP9aXNaVAHdKw18daSg0Rz0aNdmHh8IpUST8xvzC9g/K/68DzogVZ03x?=
 =?us-ascii?Q?cQUBrA8NnUFfL6N44EjYJimgRlQz7Yh6eIsQfvRlhYmQJC6lyMdcAyHxlPnU?=
 =?us-ascii?Q?aPKdKiyyMBhSbJsQ//smyOZsr5d32MvvV6uv7xV3dYcqm2nfN/V60h0OH29w?=
 =?us-ascii?Q?+t5+B4Lgc2xibEHi8rV5dMurzoLj1SDOQH86vAUzEOUbEg7MKHhsGLi2D2ik?=
 =?us-ascii?Q?M8ybe57G/XCLWAPMc5Lu8p7n4+HrGw/l4N/PlMEj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f122e49-c3c8-49f5-2ea8-08dcee66d1d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 04:47:35.7555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/TzsJGqvPOJ6yRweX50k+nLVXt1HyNvVQq32HynReB30B6pD6nQq0cMQ8vRTv7lelSt1UlCwY9pCm9IwO+F7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438

On Tue, Oct 15, 2024 at 04:36:34PM -0500, Mario Limonciello wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Add new feature bit that indicates support for workload based
> heuristic feedback to OS for scheduling decisions.
> When the bit set, threads are classified during runtime into
> enumerated classes. The classes represent thread performance/power
> characteristics that may benefit from special scheduling behaviors.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index cea1ed82aeb4..3e8e67b8ec7a 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -474,6 +474,7 @@
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
>  #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
>  #define X86_FEATURE_HETERO_CORE_TOPOLOGY	(21*32 + 6) /* Heterogeneous Core Topology */
> +#define X86_FEATURE_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
>  
>  /*
>   * BUG word(s)
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 3bba55323163..b6547bab9e23 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
>  	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
>  	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
> +	{ X86_FEATURE_WORKLOAD_CLASS,   CPUID_EAX,  22, 0x80000021, 0 },
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> -- 
> 2.43.0
> 

