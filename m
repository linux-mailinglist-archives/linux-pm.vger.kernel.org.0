Return-Path: <linux-pm+bounces-22380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC9A3B0E9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B951118907B8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B851B4222;
	Wed, 19 Feb 2025 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WuaU4aXI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37B1B4154;
	Wed, 19 Feb 2025 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739942814; cv=fail; b=NPpiltgaDgoeaqhr08B2ERMbt702Chtq6X9jptJHSQIGxw+4v12QasPzPT3M7sOAx2lMfIsOQZ7fM99ikFoOa8Cmo3IK5C9r2qpoSpI7wMGW4ZPwfeOF6DBN40tfx2fpcJP0mHmvcdi63Eg2iVmwUxl8tWfRNIFyuKtW3f18p8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739942814; c=relaxed/simple;
	bh=wormU0QxX47DGYEUiq1PevcsRDLkE1pr414xvMptn6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IaQ1GCD7nIdN9Wtcyk/sZpCrp06xehDgM19stodqiRW3UJdb8qNOxhnzVpOmSpVF/f/UQQ/CacfwXMKJzTKYmVpqD0mlv22TvwHuDNva5jlmAkpNuqNwdtmp8phJRKHL4EX+ezAlu60fXrqsdLN0UfAocl5x2xbrIDkhIJOSKtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WuaU4aXI; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf5zk6sED/kosyua+NBrQ+6SrB6n2/BAIY3otu+2ATwQ91TOs3zsbtV3lUm1JRKc9R1xupLoPNGkV7upYUYVVnEFN8lTd9UTsiYriO7iaTcwZrTG1Q4lyPrCsG1ZvoGBcyspz3Sx3rjGgCok6fniy21sScvaRbjwuPuwA82HznRflK1NMmeIx5mfbwvfiSFwKxvy6pEqLP6S7fitu6pSjn+lqJO7ODj60DmgL6FXz0H/X3GNvIllIk4KOjiGfS+NaQaP/YrngUc82H2hSOLw2OvFX/tV/W7AjScGYpDkD9qusYkHDRxPArIb/HxxaTUEzlik9FXLIMuvniR5FiPlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zarwv0bP2iROlYoSzPXytMdjSHuFu+a6KS3l5VHcuA=;
 b=X3GR+nvuyd0vfr4UbVD2oO8oEjjU6kgQbuCX/nJEFDgg8hZOGb7yt5f5pKPBnVqmR1w+ggQHmWbnca+feAeORhL7p/IHXQeKDQVSt2eVeMahDr90yi3GzLfYo6L+6vEx9PUGNW/5nDpksniR/YhC18RtWsJ+MBYWIA3nWCGK2i2gl3Br6nG2FAeEADtyctT7Um/yezzGwbl2a6A6UbFIzr/XV2VGm6L3KlA8g1EFJfsDFA6Yba50P4T0OH7JSq82oZ7BPDOmsA3Bb+DQbE2405lS6g6J1cCA6r6OYn572HxYXwBOw66/sVGL7IisZkcmwOrSfUTCaIePH7cmRYnm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zarwv0bP2iROlYoSzPXytMdjSHuFu+a6KS3l5VHcuA=;
 b=WuaU4aXI9fkOZCJHkUp+Iyr8zREIN/8KWKErqc0uOxk7xBgxIrlen2RNy2AYDBwn+Nz9N7wbGr3nkYBmCSoGZ0zpFVlalq16mgVrNno9ZJVbrX6egEi+YF2zRZAC2ly3+50sQAk7OWrGSL5FoHuw4FheITqS89i4GNIiY7/AKU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 05:26:51 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 05:26:51 +0000
Date: Wed, 19 Feb 2025 10:56:43 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 10/18] cpufreq/amd-pstate-ut: Run on all of the
 correct CPUs
Message-ID: <Z7Vrk3U94UTWKLmd@BLRRASHENOY1.amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-11-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217220707.1468365-11-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e151e5-b880-4810-81b7-08dd50a6039a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1I+k7xWHU0xcj5aKj4G82bYkKpXuW0m1xN8RJG2jIrdImzBlJNa/1M8mbM3E?=
 =?us-ascii?Q?/ePtwCGMlKxJxIrnybEwmUi7h7r1C2x0fBWehuEfWfUvcJPNePCSjZoABK9m?=
 =?us-ascii?Q?alwdHtOiap0N4Gv9YgEVjm9MzkkC0t7E+21KnVc3axiA71xzV+SkNJK2zf/O?=
 =?us-ascii?Q?yIhr/t8rParDgoQP2mora7QNUgFMXo7s2UqjWurvGXs27nm0zShR2p6KopaC?=
 =?us-ascii?Q?24ePY2j6axR/tr6oaI4x0yax+is+UPEZ1gQNScRvqMSLMvJR+60v/4EZ7lBh?=
 =?us-ascii?Q?r8M+BtmPhp+mlxiJUXzGI58uDtuTtcjA9vybqeADQq648ErWrerdJmkwpmQO?=
 =?us-ascii?Q?UfesFZTLNvA+/5K3A5+JqXMkYw3pfiFzUE/e1zwl629TD0jMuy1IUnJDFdSO?=
 =?us-ascii?Q?0BM3idjyZ3USm/rqz7b63gt+qP7Mki1a4bYEEilKOAKvUC3PWU4TIlxt2t0O?=
 =?us-ascii?Q?9FFeFptlq22U+FoUMtTLaka8y3KUY1VP1cWsy5QqMVopV9BJZbxgK3r76K9L?=
 =?us-ascii?Q?eOhDi8qZ7MZYeIKjvP+nFC6//5z5aelVFFGpGelzrQ3q1t40udeSlas1Rv7t?=
 =?us-ascii?Q?t7+9ykC3Ztrf+Z4NjOurhSoRv9maDjZGCCvHiRi32N6zBm9umaMLUdKQe1pc?=
 =?us-ascii?Q?O+PgZT6uzkfeOXyIBlhM7Uu19yiIEueZ1zl9+N/+8ztwnUHgPreGOfTl1rJQ?=
 =?us-ascii?Q?9VHbhmwp6zMyE1uJoZZIAGtFQxFmK7f6JKIPth0EjCfv9dUkiSyZzI169G9h?=
 =?us-ascii?Q?5WO2RR9Rr9k2sfpOGFbUzGJ2WBJFgW2mdsDT6ORJNXIK/q4zh3GxaQvY7N+0?=
 =?us-ascii?Q?4vKPqAFq0sMGFqqgOlgaRKsc9bM0LOYtODqNA1CsCAnKzXNKFTXqI4TfwSv+?=
 =?us-ascii?Q?cMpQIVNzmqMf2yIDCUP+qquO5QPeU49vcvLs2XqrgFe26+GIugzyrRLGttOO?=
 =?us-ascii?Q?/FJyS1y0VcRcJH0yOgIL85ULGuX26QVQreaqKfed8UufjuByGjbhqyJKSz9O?=
 =?us-ascii?Q?2UatPCotNcfWofxEq35mimcSjKxdjCh9q2LI8FQ5ba+dqaPAZq9HrGav8fY8?=
 =?us-ascii?Q?8BOIDsGczbAOmVlaUbt7lUxpbeJvQX0VFi3JNHfrkaApgvQYDahno2XhRd4D?=
 =?us-ascii?Q?m5xNqpf878feg500U5ZkK85Kqp2Gg607wYVZ3XLbsXaVzv4fH92Rt9aXR5d0?=
 =?us-ascii?Q?1FyFfeAB+YMAkXjCM6njIHZf97F8lp+h/7QHK+azUm680IPDr2u+oqoDBozo?=
 =?us-ascii?Q?QacIiaF0ju3Tilmr5tbzAVMth3fT3f8+cCRh1c6Z64OhwJXu2+hDHy0eAtde?=
 =?us-ascii?Q?BLQFxb/73d79E4iDGRu+CL8ztUL7xNgGtkPRU6NhA0INbN7EGZP0RNsgwOu6?=
 =?us-ascii?Q?DVUYrUCp15RpyoRiPHksis/8I607?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pLUPnkvhwQrncfLXEVdx3rXTmxJK8ReP5E6zPT6jDXSSVL4RFTGXHSs+eIfp?=
 =?us-ascii?Q?74be63E0z8ZB9ToD+4XX9ZRHrSElRWXhUuYrcEUKaSlBuajVOEQ2Z2Czm876?=
 =?us-ascii?Q?ORoGel8OMeixuUdnF2Xmr4gDHVJnr1/VxsqbkXYdkikwaUMMAmGbxbft5JJM?=
 =?us-ascii?Q?TRZ9QAxJP/tb+SJ4HCACivT+3ryFGKiz6hjK7VDiOo/dhS26G5CU1LYi7vwn?=
 =?us-ascii?Q?AcPPTrCGTA0P7qTa0VH5i2b6ze5M1VKAKZLT/Fa8g9n2bVAqEjgmZ+aBazSZ?=
 =?us-ascii?Q?PUoFtq7AWH3UPmolwfT5yiiWKLPqPALTh/zrtrXVtQV4vrUwHicXM121CeDf?=
 =?us-ascii?Q?WDLPEjSdAlpuhTaD/6w3p9+3y0gy7osIc8flrcrq7aCotGPKft2aH/kL7j/P?=
 =?us-ascii?Q?/sK0LjB5KU3t02bsXdd9z4Dj1iieu5alwxEzAZ867bYvesa3/p0yeifVnoLI?=
 =?us-ascii?Q?siT/RMySh1q7WxQzlANXzfFxtf1LTmxsWI3p8YV7nbyUcGW9gjBRH7RxCIOF?=
 =?us-ascii?Q?JonFUa3Z8c9zZSSQjye/27UHU8r9Dk9uzhhwNIoOdtknuRtoICAb5ZeHMBBp?=
 =?us-ascii?Q?AGPgqfo3esZ+V3aJMl0OY/HJiVVV0iP5P/wq8PBXAcb6JXWzELzujJTmasbH?=
 =?us-ascii?Q?2QNoLUx1ZNhU7E9bBbbWiv3PVcw8iqO6PUG74QaDOnUJSP2GuOEXb0qCFEbi?=
 =?us-ascii?Q?gnyD+h93BJq4BDnHwPHieLI4s6qg4ZWcstsQvUbLmyCm1OYdmhhFEK+sXGZY?=
 =?us-ascii?Q?XzuhBVt4p7y0vGvwtjUlD6Qo4UJZK83NwG3TVTgZzDzCzlYRfaz0SZFYU8Lw?=
 =?us-ascii?Q?DdtukCBdZfgNJfhp8UqFhk6eJbTewzpvpy2dVZROi122nzvMWgMtve1GEL1N?=
 =?us-ascii?Q?Ftu/J5s7+IOyv0nBePay4MOKqWFm3G8kB6XtEmACP6VFoB/bOnF+ujN/ama3?=
 =?us-ascii?Q?g7EuXgHpwfmsfwxxZPQkeBn1L/ro1gDSqDaqAmuKVgipk63tUIQ2girbWsgR?=
 =?us-ascii?Q?ddDLxB+G0adCwGLw4x7y6Xt4Tex/07U8YKorE1r/FhLzxdI4mWz/bDNwEnUp?=
 =?us-ascii?Q?WdHWK2k4jukImCeZ4Zj/gv+2GYcsz0IAwksJokl505jhBFKBwopHfnMiMB7q?=
 =?us-ascii?Q?q86T+LNYJybsgfMoLn9b1uFEtCvkXT7zJpzX+sfbLU3KIkDX8uTr2I5si+RU?=
 =?us-ascii?Q?+5a8v+cIlZSfbeL9YLYUAXYcwHulT9bQC5DTgqxevxGApb6lCAnh/iiBC/9P?=
 =?us-ascii?Q?SI7S/ekVjWsTagWwPhnHSXEgJMDqgGCfmnZ4uc+qbW81C3zUnqVk9arz5yWs?=
 =?us-ascii?Q?lq7IbRt8H+B5ftA5MyG6cBD5/miNXwA4FXn1HQcY+6OUfXa2BW3Her8ktW2K?=
 =?us-ascii?Q?OHtAj9h71mZgI9h4OnFzyoFKKGLExrU98VRGz+Jut3k9SW4EQxcom+jNyVsc?=
 =?us-ascii?Q?weABN/mwzpPhyw0U0joO9Z93RTtTP9vai5qSz9ZTsMKWHCEfuAknDUSl/G5G?=
 =?us-ascii?Q?aKcWaJquJ/uRQ2d5ENXI0naHGALmGRAeA7j6xfElW+1incynYqgqy+/djdrd?=
 =?us-ascii?Q?Gqr8pvWRouNXtz/Ws7CPl67djSs08BUa+o0GufPd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e151e5-b880-4810-81b7-08dd50a6039a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:26:51.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jboCgB0e99sVi4u+aNNFyD7bIHom0kWf9wJzCnBqIDsiT/64iUf6T3vqPPGjx9VgbdBQ0MHT0o2756GQxt0VFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

On Mon, Feb 17, 2025 at 04:06:59PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If a CPU is missing a policy or one has been offlined then the unit test
> is skipped for the rest of the CPUs on the system.
> 
> Instead; iterate online CPUs and skip any missing policies to allow
> continuing to test the rest of them.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

LGTM

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> ---
> v3:
>  * Only check online CPUs
>  * Update commit message
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 028527a0019ca..3a541780f374f 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -116,12 +116,12 @@ static int amd_pstate_ut_check_perf(u32 index)
>  	struct amd_cpudata *cpudata = NULL;
>  	union perf_cached cur_perf;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
> -			break;
> +			continue;
>  		cpudata = policy->driver_data;
>  
>  		if (get_shared_mem()) {
> @@ -188,12 +188,12 @@ static int amd_pstate_ut_check_freq(u32 index)
>  	int cpu = 0;
>  	struct amd_cpudata *cpudata = NULL;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
>  
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
> -			break;
> +			continue;
>  		cpudata = policy->driver_data;
>  
>  		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
> -- 
> 2.43.0
> 

