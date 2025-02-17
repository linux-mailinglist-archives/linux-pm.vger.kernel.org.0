Return-Path: <linux-pm+bounces-22191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEAA37E26
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 10:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83366166427
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C91ABEAC;
	Mon, 17 Feb 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ShaVUN9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B521AA7BA;
	Mon, 17 Feb 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783581; cv=fail; b=VBzswUe+sgQssd/JsEAmbNjbjo8a43VpNzR7kMvs3WnRX9aFJYkjYrTzUE/0gbHjLvOuyE3+PxdE2Wmw9YAQ/+lnidfl89bwuqdMofCoB+09K/CA8VQdqwqHdprx5IaNaWjVuyJmG9ySov3v0itF17rMMSO+Li1y1qUcZK4+5so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783581; c=relaxed/simple;
	bh=oe9rUJ6JylXMpYV7i2R2t8Dxz9N2h8CGEmkNr8j4SPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EXmyWQoO5a4WAu1Qtc7LsVx+QMgPeA+E1cUiLQfpIhfWA/8NRw978c7pBpBrVAIhfOrCzSwVIZl8UvB2bgcAn2DHwA5bwlfV4bILO/UTBBUNItOmc81ZQDTMcjG1By5bUxNvdJfRj2Mffkt/akUoCIRPGKH4B4NMTGsnOH23Z7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ShaVUN9; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDySgSiS9/UUq+DLseRDS7ZDg1v/fsZPPP3BJPiGs6w0RVZqJLsr6VWH6CQYe2rKxGQjQa7wAjMnLe5rnY6G9EkgZW16zs9xYKfsuD6My6krzr11QB6mru3bqCDeOV4xVnib4QEAjzCtvogljtcndi1Kw4U0N/iCnPihaXw2oLT4fHZqrwp+BUn8J9lhmRxASH/cqIHRz1819X8Uc0WdHVk2oHwFNNV5SwED1sYw6PvEwgQpcJ45Xs8Va1PMZzmOtCkLMNbwM5pgXLvsfXyQkj8nK0zMlSMdmmI7B9VEHWmkegnm2dkTH2pL3Vwi/uWkF33ygrHDegURFK6TKN5iOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsPhqWT8GSmielBQZ0+6icai5E9mpt7QjZcOKTsjuPI=;
 b=uQJu0uMwenqdBz+5mKrRyTZQOahwuVsF32RDnzmfLotT3A3wFQm83hpAxUM0XDAOtonBsP+Lnqxdiqy3gCBdOd4wkVGvB9VSoC6RzwLyajQgkq4QUnEuggQbj9uIh1FpnZMJexu5MGKT/fBqW5G/R6O4OPqgIS0SUr8iUIs4CgxwFy9ZhK+uXKvohb4sIOYeSUKR3tWkt81pFuiayD5nInaoDlpONHyo5BO0CmN4JLVhq0Eq15XaBLI0SM3cRmX6+r6tjLDMQGPUuj5m2A+2K+V+dONJKgdgj1bpDGHEO+XFcaRodLe40Be/IxqLm5kMuZr9RpNWFzEZU7Ja/JwTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsPhqWT8GSmielBQZ0+6icai5E9mpt7QjZcOKTsjuPI=;
 b=1ShaVUN92h2Zc4OztHq2nc1YHBPDtO8fiyqpoiJqUMRTun6XGbQfkhgwjBIYuV5/grPnGBv1E6mPw7KSuHXPS7SrJZ6Wj53qbWay6ZhS+NhpLO06PBt/5I6XoTKh5WuXJ1AvKx74nvzfN2bbnECAYLN2frLRrXwq8o663UFw0vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:12:57 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 09:12:57 +0000
Date: Mon, 17 Feb 2025 14:42:49 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 05/17] cpufreq/amd-pstate: Drop `cppc_cap1_cached`
Message-ID: <Z7L9kQGN7fKTh8ct@BLRRASHENOY1.amd.com>
References: <20250215005244.1212285-1-superm1@kernel.org>
 <20250215005244.1212285-6-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215005244.1212285-6-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd8b435-f442-4110-98d2-08dd4f3344d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bpPN5p16uyYwQrlgNbcMlYOczOZuIZ76vciaImK6r8knI/CBUnJ4hFRSMDgV?=
 =?us-ascii?Q?MlTQY4LncBx3KJJ3pDWFshoiuTmO3ebo7P9xOHlYyyEpzTUQuaPK7tCwnvbW?=
 =?us-ascii?Q?+PoEX/syQtyv9LtEnHnfyb8FmungCS0DfDgs9xgKMnxTu3c4Ep3HAoU8s9C2?=
 =?us-ascii?Q?dI4c6NKFjIFI1WAfAN31JNwa3YJXGBtSbnSdViJelPWNJxNPflF2DTTwAbSb?=
 =?us-ascii?Q?dTAqTj6j5F+i9q612ylY+Sc1OWg9kVGoneQUMeJwtr2+jwCtmmqbqMb473SW?=
 =?us-ascii?Q?UbaFDfJGy4APvHXHeVj5g3V91AGkqGl6lvQowWjndu+yOmzAWXlmorIdiH5b?=
 =?us-ascii?Q?3LpjEpzPN43PPcapgU7vU6xkKwNFKyGYCz5v8VOINZlOUDAdscpIPPYVdEV1?=
 =?us-ascii?Q?eJDzkfOsW9Pfn5GNwNpz8CPoTdn204TGWvJb0D4JIUG7Y7E+hwgrIbNpov2s?=
 =?us-ascii?Q?QsYFGD6i4Gqm1p9puOFOItbUpIQO5MfEfrdZjGOu/FXS5qlcKpTOK+HxQ0vl?=
 =?us-ascii?Q?4/1gZNzrMu4tdrkFanL38Fb/1H6EUPQvtlHnWJjwYhRWP+Osdv3SCDOYGF6e?=
 =?us-ascii?Q?Gn9Lqq1xsV7akMJ7rx1L/yC/DqkGE5dUdZbQwJIqTOch3WeUd8o1+Uwl5bfA?=
 =?us-ascii?Q?h+xCkVZYJysDAlJ7ZxZyl7eNqlErtE00E+heDg3GBTlCNRuxWAJk4auy9ljW?=
 =?us-ascii?Q?tl6NNy9thpt2K+aV+JELpr4odAGAcTKrrvcDVo1iCKPI09DEkU/t85GewgD/?=
 =?us-ascii?Q?Mo8N4iQ3+FnutWE71Q675mnyMQcKBDPe5u59mBxpsK6w9QqkTWPVZqreZSIr?=
 =?us-ascii?Q?cRpxg7tp8rctOR9BRs7tpqH7curdIQ+TOtPqE2ous7QLi8/kepE69I/CmlPC?=
 =?us-ascii?Q?8QSEvnFkot7DnsQJVa1s5L1658PaM92m6LBtFGkbsF8oDD6jpA2kqD71RV02?=
 =?us-ascii?Q?6PHeid5sXTAbP351w6nz6fq2cig9ybZZpSK/g2evFLoxKa6uYvMxN8zudnyN?=
 =?us-ascii?Q?SmwvhSgH5wDcwxtvxu/fTrZTY0O1uICPKytK/eNmgcgxTQSWzTWm4+jtNokj?=
 =?us-ascii?Q?AazWdHtw3xgWHmzN+IabT65vnqfCQZXD4V0oJxb3d2x7HKVivoVeFQzhXLk6?=
 =?us-ascii?Q?GJcY77dMVKFZeSXxuoumb0BdVYl+V8g2wwVrTzZrz0SoTGsEq+63WAE6eB5x?=
 =?us-ascii?Q?f8fx/lURSXg3teGZSMAkOMLfFXzs8GwESAtLHQg/QoInHAuSEgv6UcSHsDTz?=
 =?us-ascii?Q?Zsp3umffwDFun8418XHAkasUqvDJD6L/5q+rbTZwmcrZZKeo8/zYxHKebM7w?=
 =?us-ascii?Q?ll18i5ApvuNst5wcNic9G32xm02Gyp6U7i8xeIT8UfXNnGS30How0GMcMYWq?=
 =?us-ascii?Q?lnoXCUGGrc7qiufAqm3AIkGEkecm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dyaC+Vf+tpMbuhTCHyYb8nu4T61GWWDXaEEq8aLnEiMhndtezm9caXbHGlD?=
 =?us-ascii?Q?6JbU/SA/+HMDKiNScwRfrd6dcgvWTAYRfiFb50YK4WBiPIyPzNmXUPBcPf5X?=
 =?us-ascii?Q?uQeQO96B4M7dUt/+1rtC8pg3yjP+D8xvwJrpKYfmhBZiZjiDr2gxvgmETmTb?=
 =?us-ascii?Q?5LG8ZOnP3YqF76Ax3MzqFQ8mW2NPYXefTS3qyGAoXzcitE9WcFM8XeumgTQr?=
 =?us-ascii?Q?9IOW3PcDnvV6w1039KY0JmDB+sc4pnvRlJ6Hz69QEJeMxac9pLHKRumOYcfI?=
 =?us-ascii?Q?z5AggAqJKHd0Cv/7jbDcFk2ijCBIE7bmMB3zhHdk6H4PuIIZVFB1nRwZrLfS?=
 =?us-ascii?Q?v5XS0iVsTRHbyXrT9yxzuCTtAaXS3QDxQeB47/reyj37G/2sjiLEPuIuddI2?=
 =?us-ascii?Q?oW90Xuoz6h9NHH171FkJnomnYbDWOYepPi8T2spMJT6g/RMVnMCibRfAMRSs?=
 =?us-ascii?Q?svoajMsRcUgwBP9ONf1Oq4uOhfMhWAlxuUYuqso7Hsf2h43p4mUBfvFP00zf?=
 =?us-ascii?Q?6wx0W2XOAcz1Xmi5JI0iLzDRCHkn6KRIAfUFi8OhqOkgqcCypka/o73tCE00?=
 =?us-ascii?Q?ZwC//+CyXLrRMuNKa51l/RNBSb1Xxn6FpgUYqeax92xbyKVQt6RbwEbXsbi8?=
 =?us-ascii?Q?DtnDBeQHXcDK563/b7Fvq8NhkSQDYuyzcxGW/HK5yU9NcY5DQCSVXbZL26wc?=
 =?us-ascii?Q?WrflXjNlgP+dYO3VLz3f42vbsN9vAJWH3wNdV2cUv49BAtJwyO2oVxk7IE6q?=
 =?us-ascii?Q?HdzHBTLqKyh9uecYPO+HdqbC7plyIdpZv+eeIBQPwqGpi1SBzN935gC8BuWW?=
 =?us-ascii?Q?uBfwjjmnQZI4Cxx++hhR31GrlKzY/dx9a7WsXIQS0ad1K9/6/Gt1bsZgBofZ?=
 =?us-ascii?Q?q5WHT4KGq5qMA5S+A4nnowLvH3nTJ5iCzVW0HVo1QKE3/Ek1aU5wG3DtVeKv?=
 =?us-ascii?Q?nmVORBVvbyF+COHKAvaSqllZ7dscOzjJgdpz2I9tMj7WRYE4JMD6K5ow1987?=
 =?us-ascii?Q?qbCFfe/2E9ZEiOZSsZgqHbETZX6QotR5bEIETg+9bYZdlzZj4QQKpkYELdjd?=
 =?us-ascii?Q?/INF+44TVb04Qdn+Jf4LTut5MEgUOgis3/fNJaIwXeHCAa8FZ0+r1y3j14Km?=
 =?us-ascii?Q?i7S7PlqkchCoiYYzsDMXo457DqNYFgltu0jvbYzuECD+21StRLkndYlFXTeW?=
 =?us-ascii?Q?MSWuMkLvCRomqwC7R4QuyCg9GLOYJ/Y2+nCQHMKkuBC2iKHwpulFkDs6TTQm?=
 =?us-ascii?Q?PgrhAUMVONdy8jrUY1or4yAj3BCjK7IxZZbdPBjiRRdBkHRH591yplXiu7S2?=
 =?us-ascii?Q?M1kDMgszf6mO8u9wZwtyV3M4EUVwwq8dPQgQFyvJJ7Y1V26FfoCTlEkQq0LN?=
 =?us-ascii?Q?GmKOxL0bGU29nGn9b8IeNQt86eWYngePTNHz51aYlt4DqfqTea80M0+lv0RN?=
 =?us-ascii?Q?ASGalURX8ERgLbhWbpeb2SGlYGMPdxGQEnE8U9XqeS1i5ZjSS+R5D/bJwbDR?=
 =?us-ascii?Q?UC+dt9KJeqR+ltgtIiA8UZKnYs4VbjiZVCeNOLefB64IBp2nl6GKXKFs1hS7?=
 =?us-ascii?Q?AJQf0l1YmQzbnaO9S9eTcr2fSz1KC660RZZNy53E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd8b435-f442-4110-98d2-08dd4f3344d6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:12:57.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FQYquIoGUq12QxNSnRMwuf2+BLzyWJrPxMlUso6Oah9zProjAsoBS5tWvh/NcIQQPIwOq0lDWbgiAlN+/j+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456

On Fri, Feb 14, 2025 at 06:52:32PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The `cppc_cap1_cached` variable isn't used at all, there is no
> need to read it at initialization for each CPU.
> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks for this cleanup.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.


> ---
>  drivers/cpufreq/amd-pstate.c | 5 -----
>  drivers/cpufreq/amd-pstate.h | 2 --
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 044091806f14f..e5983e5c77ba2 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1510,11 +1510,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  		if (ret)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_req_cached, value);
> -
> -		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &value);
> -		if (ret)
> -			return ret;
> -		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
>  	ret = amd_pstate_set_epp(cpudata, cpudata->epp_default);
>  	if (ret)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 8421c83c07919..1a52582dbac9d 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -74,7 +74,6 @@ struct amd_aperf_mperf {
>   * 		  AMD P-State driver supports preferred core featue.
>   * @epp_cached: Cached CPPC energy-performance preference value
>   * @policy: Cpufreq policy value
> - * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -103,7 +102,6 @@ struct amd_cpudata {
>  	/* EPP feature related attributes*/
>  	u8	epp_cached;
>  	u32	policy;
> -	u64	cppc_cap1_cached;
>  	bool	suspended;
>  	u8	epp_default;
>  };
> -- 
> 2.43.0
> 

