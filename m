Return-Path: <linux-pm+bounces-22456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1014BA3C3F9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 16:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285A51893B01
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B131FC7F6;
	Wed, 19 Feb 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SEF1Zy72"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B71E885;
	Wed, 19 Feb 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979704; cv=fail; b=joA1U5jGlhzvgZdcUkSAQb46BenVj9DlTD3KYVtzp+lQ0Stb4Pzh0k2nDajErRryZW1zCrKPCG0QKmr+K6DevAI1JYG0nomUnasiCOWaodyTlmkUL+saA33enO8tXCWxVXnC3NoeTPe1MiVZodHDRY3wha/jHTdM70ZNmg1yZe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979704; c=relaxed/simple;
	bh=91tBj5XCu25yOj2pIFU9Kr+exyMcEq7dpC/8tJf4RIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jg086FNdfWR1PlzFMz5NUg3q3Biey3DEnfJI8nOGGiby9vOPHwsMNO/e0VnFMrT1+K66RFkUfvX5uBdSWbPT2eOTrRtNdOBXzXC+I06iDI9UoRtY5rNE/BJDCS8GKWTbQ9/1qszQEVddNk6nbkBsMCsDZX0el9kIq1k35rWy0ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SEF1Zy72; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT0+hBxqOvnFUoT8TEAtV6p4dzOfLiBEzu25xEbFGASbjm0pMGnmaGmHq3U9J6CLNitR/nQSTW3PQ0Bp3PXJmsRav3jVNtlJvTED0LfMBavqcoDwGa1I8L5imPK2rQlXj4tw03JCKh+BLV6vIUMa9p/AlhrCFYOawSjfNIHA9JWXfg/scVuvq/O+HpR3hHPqNAPQOL6qTVIoO31iW/gJzL6CRouNx2aZevKO9b7mONpSfbcAQLr9bMFopQ0F9atGxkJdp9zeONohr06hUpzr17e8b8U/m5+er+QWOBQGWHHw/oY4QUwJV4O1l3T/nMGHasDTaHIKl3wdbhf8lBnLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUvNYvyelieZ/mMcttI192sve/HrSxlwT3Ge1qArtrE=;
 b=U2pO0Z3YDOX/7fhWkDVJpv+GFJ53eWAG73uTc+y5hFQfbJWHEKPq8kYcP2rioCImd1furAIiGjbOm/jnQvlBWbAwJPgHrOMx8k5YNpyv2bjv9LlZ8uliL0WR6gjRMaVrXJLkDMvly2ZdlXD1TD3MiLoJHGyeYTQFa8YWH+kQtjhKNYCm0JMFJwzYM+jfX149nmABCFHoLSxjgnIMqGVBhbEqv5Ql6MK+Ax1ejk/8aRqqg+htsZL/uPHW1h4HbWcy23pbjWz3LPm57IDIMBOxPfh8Rbi2MJOGYN8g7WpALL9bX8oLfQDH3/rIA0yPf+qPrVW9Ijwgb9zIC71TstZ/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUvNYvyelieZ/mMcttI192sve/HrSxlwT3Ge1qArtrE=;
 b=SEF1Zy72nJUFd/0QEZVpg9Xn5i153Okj8IxX9Nt7BA9LN4OpnAhvloknMv6ifD9WsdBzVo01I3HfnD239j5drkkK2LI+X3UCf3rCgJl5qmRIqjwpnefzJaCxKX9pj++ArY0vTbMiPu6OWr38XDLcGHgX6Sae3e3yVS/qZm7IwY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 15:41:36 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:41:35 +0000
Date: Wed, 19 Feb 2025 21:11:28 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 18/18] cpufreq/amd-pstate: Stop caching EPP
Message-ID: <Z7X7qLAiL0FZxpJf@BLRRASHENOY1.amd.com>
References: <20250217220707.1468365-1-superm1@kernel.org>
 <20250217220707.1468365-19-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217220707.1468365-19-superm1@kernel.org>
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1ee040-a07b-4353-c754-08dd50fbe47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HQugn/npKGIruXme0zXUw4tbwowlMFzMSo77RyL/+Ksgbiq3fAZR4yIc2Kbc?=
 =?us-ascii?Q?NfZvBltXR9IMrxf/ZobOM0p1KZ8lV698KDF7lGrOoeEzkfIEusAuTq6EaGdp?=
 =?us-ascii?Q?1bzBSo57EteQ/u2rlnwUHZgpGx51A+gIEeYKQ3ME0ZqgElX7iS06adfG3HA9?=
 =?us-ascii?Q?XlR0W8T/O2uvffTmZM1VzH1jCNPgKZv2+zED1l8sXgFtFGnynWCgGsxN1oOG?=
 =?us-ascii?Q?TWB7nEp/qLfH0J8q4Oc8KQzY2PHmJkPNex66caZu+l6w8uXjZruy7/1Nylap?=
 =?us-ascii?Q?vp/tJaKjPGu/EhfH7Gmri//t+Ur9JBggF9rXuSXzoHS1Z1TpemlxakrTuIJh?=
 =?us-ascii?Q?H/gCaJkfuLVtqhzQ8iEYfykRkXUaWssCWLR4IDnibJtdWiZHYDRTiO48dVhL?=
 =?us-ascii?Q?zfgVrIhMCno6QkS/IYyRxugi2ZULNDlYl+ML6N6pNnfJfP/sfNtz3/4hr6kv?=
 =?us-ascii?Q?1QDU9sxSDU+EXtCYoW04veFyigh6jk22SC/5fZgEm1J6Ue8cqA3sRD2IohLh?=
 =?us-ascii?Q?jyG15ReJwflSfaLkJHJrvJ3yqOMd1hDT1W65TjrmWWQXxj9meLxhTR4g5UaV?=
 =?us-ascii?Q?xBiVQ9ufrfyez7FbBuM4S53pT9PeDrmJTlW9phQUfpuQPoR0KchPRyUenX71?=
 =?us-ascii?Q?G2sKToe/HLCMnHuM/0EcKL4B5a25Oiyr8WMgvba7qQh3RxPxiNXbDz7tZlzQ?=
 =?us-ascii?Q?7lyKvmzFeHvBjvEhiDmbHQ2WwOByPVHACs7eTsBzgWyIjVM/Qy7/Z9QjMj6I?=
 =?us-ascii?Q?MrLFbGExlH7iCkQJ41c4k3IblrIrc/tw/DI6S9xs0j98yVfiXVVCQermNsS9?=
 =?us-ascii?Q?/fHr1ZaFz6Ko04UVk/DXRNunE2nHndZz3IQ4T8p5NbsSYbwjW5LOPKifdyVZ?=
 =?us-ascii?Q?51O+soUA7rvXuyI3ia1yG1iXR+q+fBu42jUQfb1tVfUH11/QlGi3xkivZ2ce?=
 =?us-ascii?Q?u13/0vTPkP4xXPRHnMSw9BUvDuesb/GpQ7swkFgAlqwBfBeqPPlGyq8qkuBS?=
 =?us-ascii?Q?bx7bcw3yN+faxrue9CVodY3bcQYjOcvzlAKjZ1KVrdUJOcEKiLjdKkTbK8iK?=
 =?us-ascii?Q?4ByeyN4yb1i4pun+skh/mH+jdhPlML4y2Sh6p5ThYB7JMfLZKtkECJyOs258?=
 =?us-ascii?Q?eCmqzefpwrtlV8RjKi1TKWr58B7J2gPs3Zd+4TerxmK+fEST6AADRTf8lwTf?=
 =?us-ascii?Q?pR0mc+Wtj6sBP1HZ8qvMnB+LqDDbhg2y/aDAkCQ5b+ZiUH3xLhRwA4FPyInh?=
 =?us-ascii?Q?PGUXEczF8KOGQFsg04WGhGNC1l+PNfv9W6jZT4Z3VexOSPwe3E303RgkH2Wj?=
 =?us-ascii?Q?oNLgg1Eui27E0qIcPZXxcIncecnHGkjrvEvIQxZqUah1+hMq7E/KBmsbAjxf?=
 =?us-ascii?Q?Xo8S9QBkBPTnsACGGmlgMT22DB47?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMOwTtaiXa20QHykzBh5nM8wHB6tluCPwFjnIMi2uwJ652sZKtLwTy5QLKpq?=
 =?us-ascii?Q?zGfvq2CPd/+JdrK5uGzcBmpymSU8FyCTvtVsfbqNfZ+fMRdZ5TewUmE/LYLV?=
 =?us-ascii?Q?E9nTOfrl69EdcTFmlYBM8NRsENxqxddjmZZSsVJTXUB4WVJKFwifZd2xyPYC?=
 =?us-ascii?Q?5iatlpAkppPRrZ6enV4RyLsrNRKug3eamCvvG/iYrwvc7bBKB0o6IdtxHpsP?=
 =?us-ascii?Q?M9SS553z/KEVMLBhbDDFwheMnGvRApIzSav99dZctkJpZxiFPH09abHmXBx9?=
 =?us-ascii?Q?MK9HlalV/kwQerQZ2QSKH0v1w2nUrpn2ML5+rZPmDPZqTozKXSRzigH0A80Z?=
 =?us-ascii?Q?mtyfYxNhWrapX1uEcOoEUXphGqwn5PEdr3UW+aXxRiztXKiB3C99GcPkmdn0?=
 =?us-ascii?Q?zkAxNvazvunT0lmrJtg7X2hGY1PaI/GbhK+9DVecg+NFHCMaOkB7HA7gzURn?=
 =?us-ascii?Q?cNz+lq5XFlG6RermMezZdMJf3Fx0dFNakun+djkn//ViZOpOJv57kgzY6+FM?=
 =?us-ascii?Q?JS6kTcJUP3pdENA/uCCS/JmHOGorMZsbnsuejbpVp2/hmcNF2UTbmiED4HRF?=
 =?us-ascii?Q?YVDBD+VcPmDX8jc7AUIfeUhVmHhSNDZWS879VUeJb1pDhtpiwBjSX36A3zWD?=
 =?us-ascii?Q?+iTeaffgGu7NaREknCIwsEH1jftxDXr5JAUL83yCUXOBsDehyOEd2LeXljlj?=
 =?us-ascii?Q?nWC3MC0gUvNc5+D4k4T2otpOKoggWhtKWH9Dvxf/1SNCXH1kaRJOGELpCM3X?=
 =?us-ascii?Q?4B0aJPdPZfsc9rRzkGhXjz4HQyWHUIn99qwM6NvGOxCviou94E4/ZqJpan/+?=
 =?us-ascii?Q?nydVGBVN6Y3KZAHIwlf1YOHTJbp2UdFdHZ5Cuyk/98zGbbwRJHBjYhvkXyQm?=
 =?us-ascii?Q?cihctcnc2c5EWzwnTguiw+z7SII7j6mCO2qED8MYf90jKFQYBkbICk40k+co?=
 =?us-ascii?Q?tEY9MiOBheR3HL5bA75bdEz4dLIBUKKcS3JxnZMweuEOBwu7w/Yb+RB1o8cL?=
 =?us-ascii?Q?UILd0nKJqcmLhfGs13aSf8akI5tHyDwlYaPJg9i6skVqCveQW2oIkQS5GYTN?=
 =?us-ascii?Q?ie7EKuZ0bjOJvKNOWLLssoIru6M0srVmmGdMI8s2OJJy75hk6jM34peP8iQV?=
 =?us-ascii?Q?AZemeyNxpt23zGw0AbeeduQO7c6vfjZQSS/ZVcLqqWSeVmJ8zqltn2dBZRJt?=
 =?us-ascii?Q?9uJyZZYzX/e8LBRxQ6l182dVS2+sXG5E8Y08HmLTWvvfYRFqZtUo8E1ElTGA?=
 =?us-ascii?Q?ebN72mg22c+GkJNX4lSMLOEr/Vxx0zsR81P2tKycd5DZUg4xOXuraDBJKt2o?=
 =?us-ascii?Q?jLfrvvYi6bWTzGNOC+Fp1jHBQWB6VeAU2uQg7I1ogOmzxIXS0gkk6sQOPh2x?=
 =?us-ascii?Q?c9NPOtGqpZCZGxcYLjHn0u/lKnJox5mjXmyQf0SqsvQo7OXQUBHyvp+rJEps?=
 =?us-ascii?Q?n5ULoIR1JoEo0gfUccD04DH0w8Nj1xKYtu1Lgj8ahVgSNn2Dyv6CnAzA45yp?=
 =?us-ascii?Q?pXi7yOVpeWDeJalRs8SofJYrqAfs54yuzAxamI9H9//gjVB5IqsVYbkC4Xxh?=
 =?us-ascii?Q?23BsgI68NAG1/tnZTcczFJaznWimvufl+xYtapET?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1ee040-a07b-4353-c754-08dd50fbe47a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:41:35.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grFcSiL9c6obBu4nwaqKgTBnb++q6OxCO5EdW4HEYHin70mhB7FxSwJypj5/edQBM2/8EG0o1w0/UrAUpoUHeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

On Mon, Feb 17, 2025 at 04:07:07PM -0600, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> EPP values are cached in the cpudata structure per CPU. This is needless
> though because they are also cached in the CPPC request variable.
> 
> Drop the separate cache for EPP values and always reference the CPPC
> request variable when needed.
> 
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

LGTM

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>


-- 
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 27 ++++++++++++++-------------
>  drivers/cpufreq/amd-pstate.h |  1 -
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4660dd3f04796..48ec5e6527c68 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -268,8 +268,6 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>  	}
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -	if (epp != cpudata->epp_cached)
> -		WRITE_ONCE(cpudata->epp_cached, epp);
>  
>  	return 0;
>  }
> @@ -318,7 +316,6 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	}
>  
>  	/* update both so that msr_update_perf() can effectively check */
> -	WRITE_ONCE(cpudata->epp_cached, epp);
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
>  	return ret;
> @@ -335,9 +332,12 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	struct cppc_perf_ctrls perf_ctrls;
> +	u8 epp_cached;
>  	u64 value;
>  	int ret;
>  
> +
> +	epp_cached = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		union perf_cached perf = cpudata->perf;
>  
> @@ -348,10 +348,10 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  					  FIELD_GET(AMD_CPPC_MAX_PERF_MASK,
>  						    cpudata->cppc_req_cached),
>  					  policy->boost_enabled,
> -					  epp != cpudata->epp_cached);
> +					  epp != epp_cached);
>  	}
>  
> -	if (epp == cpudata->epp_cached)
> +	if (epp == epp_cached)
>  		return 0;
>  
>  	perf_ctrls.energy_perf = epp;
> @@ -360,7 +360,6 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  		pr_debug("failed to set energy perf value (%d)\n", ret);
>  		return ret;
>  	}
> -	WRITE_ONCE(cpudata->epp_cached, epp);
>  
>  	value = READ_ONCE(cpudata->cppc_req_cached);
>  	value &= ~AMD_CPPC_EPP_PERF_MASK;
> @@ -1203,9 +1202,11 @@ static ssize_t show_energy_performance_preference(
>  				struct cpufreq_policy *policy, char *buf)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u8 preference;
> +	u8 preference, epp;
> +
> +	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  
> -	switch (cpudata->epp_cached) {
> +	switch (epp) {
>  	case AMD_CPPC_EPP_PERFORMANCE:
>  		preference = EPP_INDEX_PERFORMANCE;
>  		break;
> @@ -1568,7 +1569,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		epp = 0;
>  	else
> -		epp = READ_ONCE(cpudata->epp_cached);
> +		epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  
>  	perf = READ_ONCE(cpudata->perf);
>  
> @@ -1604,22 +1605,22 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	union perf_cached perf = READ_ONCE(cpudata->perf);
>  	int ret;
> +	u8 epp;
> +
> +	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  
>  	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
>  	ret = amd_pstate_cppc_enable(policy);
>  	if (ret)
>  		return ret;
> -
> -
> -	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, cpudata->epp_cached, false);
> +	ret = amd_pstate_update_perf(policy, 0, 0, perf.highest_perf, epp, false);
>  	if (ret)
>  		return ret;
>  
>  	cpudata->suspended = false;
>  
>  	return 0;
> -
>  }
>  
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 1a52582dbac9d..13918853f0a82 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -100,7 +100,6 @@ struct amd_cpudata {
>  	bool	hw_prefcore;
>  
>  	/* EPP feature related attributes*/
> -	u8	epp_cached;
>  	u32	policy;
>  	bool	suspended;
>  	u8	epp_default;
> -- 
> 2.43.0
> 

