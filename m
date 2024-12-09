Return-Path: <linux-pm+bounces-18797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766D89E8E4A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E441616478F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D42217641;
	Mon,  9 Dec 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U5HlBCGt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4672215F68;
	Mon,  9 Dec 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734590; cv=fail; b=QsAHQyzo0vwMLROHw0uNa7wqxFqVdc+0YWOLFnZYdZJ2XF2FFJ3xJn4wfiv7qgut4s7hl3w5WbVk2BAuAKx8u+mITyXM0Kxw4+kZVVQDzv9uekaXo10iw90nrYxD4qNJyyUZ3xlQa5+OONoR4w9xl/v1HgqCpJ3Hu84lkIJX87M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734590; c=relaxed/simple;
	bh=V2nRaopr3/64o16poiroi4gYGzDaOjbd2ify5t2ORVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdiXM5nu6fAt+4lxTxbXvxfUBsYg8RkYJn2UltDnPX9cbf30EDGjfi6JiDbp6bG0vHGkQ3ODjmdQtGOTyuNdFOS5sDxrhHsj/xkp1AzYY2QFbqu0l5Y8/JrzXbEknQ+QlQXz4/v+4gRcvzWSf9ffCiMiYbaGgYwqqjEdBHhGNHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U5HlBCGt; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1W1hfxuz6vft3D1Wia4yR/pWWPKxgFFPh3a8qqPkDaGLw7N8CtPSZ1bfLPyy1GCN0rlxAs3iJ9JNzLeXet8HWFW83dJxnkEPmxSO4CMbs17IRRPHC+vKqZL3MPxWHRkGIagzchLNXTBsR4saw2ogJSMNqZ4nQirnJb4uHEYumP2/GugjzyZrLaYlQHAPa8aIWC8DfDZGfk57Y3fPqKVX8TZRtC5DeyMbDeWBwU7nkWMEMDHQ/0W0WkNFfUwbBpcq3NY9rs7+2q8TZCSvxlICcQQNNwXaCJkHm6TbmP9OY7M2fEsfnb/mgumOnr618KV7IqfSBEfyp+1S9mzN7hqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3GwJqpOTItgqpoiFZNbgHcp2ceRA1Urj2Qc0EJn9dI=;
 b=sBWufFHC4nZBlOPr6//Jo4okLmisl6+lnGR4M5PJUj8JzN6nDwJiZXA/UkfKQtuhCo4NjA33S3n78t+jWfEQyheGoISHDPvGOqX1+uPwOGgpnYvh+l8okZpVN6rA+ZAr1/jP/IiUZps3L8dSFus3/+aYti4Y5DthlA6FRCE/tLVURsiyX1dWQ4k44z9UJNHPn9cr7qL4H4ZoQ+weQZHL5ERI0V4mxhvWuFYDgZ6aABMKXIfTjw2MaWeCrRBydZpdylQA0dgAbvYQSpD7gNlX2ktiOQLMma4FgYeVf6SAEXhUgvKx7DsiIVq4e17rpy0YffkMI0mhAr1kao52J8hv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3GwJqpOTItgqpoiFZNbgHcp2ceRA1Urj2Qc0EJn9dI=;
 b=U5HlBCGtEeBH5opSMXELQG4//9yh17NRzOeRBLNCsn6mwU0Ygl/MayvVk5Nb0DKAYJgEaUg1xhlWrTxCaLc2QCXJtJnWzslM6WkanMaX4Dxuq6/gNiUOPo25Pzlvy6DNEXM8Q20kWjxvqjfxPVFKVkL3AlUUa7q/bAw5oEChfrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Mon, 9 Dec 2024 08:56:25 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 08:56:25 +0000
Date: Mon, 9 Dec 2024 14:26:14 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH v2 13/16] cpufreq/amd-pstate: Check if CPPC request has
 changed before writing to the MSR or shared memory
Message-ID: <Z1awrnPHwTVMht4E@BLRRASHENOY1.amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-14-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208063031.3113-14-mario.limonciello@amd.com>
X-ClientProxiedBy: PN0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::19) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4e4164-c6c7-4287-fdff-08dd182f5c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KnQbhcRQPUfqGJLJBrzIEPhjAwOli+6AbNWK2b9FpOxL7u2HOck/aS0HZr8k?=
 =?us-ascii?Q?ay2WT4lJXp3YcY8lY01On8lesaqsL+QO/LbEavimeTSY8P8AwmeBkCAKNq1L?=
 =?us-ascii?Q?SBB4vZGcLtFLWy4/s5ajkTHgMxL9vLqeLr/frJis569kRAWu8mD/AisNI/e1?=
 =?us-ascii?Q?FlYAGNZ9Ki+eYopxP6rAI6UFoA1mXY8UCsPkOjHFZqUJ2lBsalHj9FXJu1b9?=
 =?us-ascii?Q?hxg/62QuLak2s2ooZhtBf3IAIJP9ZmniBICvVtQEtUgWgh6UGjxJNAN+FIXO?=
 =?us-ascii?Q?Shf/2RZcOtbrp6dLn6QOTUUp/cYhrXbnhsB+KCINUkijwKxWpizr7H3ZBgWt?=
 =?us-ascii?Q?Ndf1PMXo5x62EI/FmJ/IM59XsIdF5M3lsx3wqBTFnoNR9wavsgm7YdqObgLh?=
 =?us-ascii?Q?PbN0xx7tUCE36qMF4sGCJ9wyjnozq00ht48wL4UJrSaqfup2MddO0XPNNm90?=
 =?us-ascii?Q?lBKlA1+yCk2VjPqHMySmYU1VkJ2IPfV4RSLOIadq0zolpfxazWm2+rQQUBEO?=
 =?us-ascii?Q?FwApue7bzSnTHudLns9TU0GD0vHdWsBaZ1HCfZqXdUEwesCD0xqP4kCiwbdb?=
 =?us-ascii?Q?3WYR/FqSWMWLpXUzD2cfS/kfUQGM407obHVLgN5FC7Ot1nhoVlpRRnIQtMrW?=
 =?us-ascii?Q?h7zykWAUWDe5a+AUSFQW6SGTF2iC/bX7u57escdnI09eect6bWFXj4cWaP/b?=
 =?us-ascii?Q?pMUkBDky31hY/5uka5qPv57WC6Hx22Wami2w9CxFynFQ47x8S3DY31dhmP6I?=
 =?us-ascii?Q?Pvjl+H0sYfTJErrG7YbeqGEH2KwiE2ZjtGpbbHJDBZ/1H+TTLFQ3KQnv0j1m?=
 =?us-ascii?Q?DDYRXqRJuRwoARlLp6kqUD/VAQJ1VK4hlkekapyEMjuizsi6+Ew1Ht/80ncl?=
 =?us-ascii?Q?hgw1cxOBbBekEFtS7jGLeeepgPQ7kXNuElmH0adATzZuJRcipjEN7MFR1Xde?=
 =?us-ascii?Q?E6NlUfzvOJ4lg42moca5bVXEwUtmuaCz6jgMKYL8ZuDCWCsai0StsoGUzaxP?=
 =?us-ascii?Q?VlbPmsJ4EMO8HJDQCeT90m7dCp4/N/aosKBnXYJcQgmuejZ+L4R7SpC5spwa?=
 =?us-ascii?Q?Z0ZVhus1QkIA2VFxj5a1Of14H99N2qffH4DXJVXWj4zfQ7/pgKzW9EgQ4yYv?=
 =?us-ascii?Q?9tagQxwgKfRrUahs7LxtYVUg8cw822Swx7wic2Gv6YMIxFkqh9atF5ilJ10x?=
 =?us-ascii?Q?L29FtNPWJgf1YA4W9ryvGzhY1y1j90XEoW0yqmmfY5amNFB9VG6TUJQ/p7+F?=
 =?us-ascii?Q?FcKfP2gwu5SdhNOER4V+vrLA8wDTpZTgzz040bTlb8PzMnRvuxM/b1cQFxQy?=
 =?us-ascii?Q?o6BIWjrueIE/0gt3Rfz2+i53cHiM6OgQ2Oe0iZzw/jL08AX67BsU476w+fSx?=
 =?us-ascii?Q?TupoxLQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HKWBGv5KoIzSxZHH9Kd9cF4VFR1fsA30BlI1TnX8M2kU/N0BD0GD/zbL5Jtt?=
 =?us-ascii?Q?M+5lfKZ8pS8kGB7N+O/h4KfUnoX2XxJEf9C+W65V+3yNoRX48B5TFYrSce3l?=
 =?us-ascii?Q?qDp1Ay/qCschI8BXkghg1tETFzFELPGpe4tF02jusgbYPPBAqeKDp2cKvVox?=
 =?us-ascii?Q?TvbFhBEu/cMuJzZWp4gQfl4m0+k4U2i6h/WfmMX0GvkMGtEIR9fELMrhimkp?=
 =?us-ascii?Q?FsW96Cz+g+K5cWYQo0+5O5LumoDroe3+1vGwhpMIuG/qylEMzECbwYXKeMD6?=
 =?us-ascii?Q?o2JWt4bP0azTnOrRgCNG4QxCfNA5hKz4FPF1JeL1RlkRI017g4M/eAbwQi4S?=
 =?us-ascii?Q?0JywIYOT7kFCbsg0Bk6DDqJhLcXxevMlmzs/4FT1C+QBSf879LD1yoHdtEVU?=
 =?us-ascii?Q?lsj44jUzhtLKhqNtltjGicbXBQ0gPPvhPaaTeas0pElCVayFvHaVOT8zZlQd?=
 =?us-ascii?Q?duvuKdYAUt6hdBjwiTfzij115zGXEC1b0zF0tUdXrU+y9fPQz1QJ4Nhb1aEO?=
 =?us-ascii?Q?2nMCAUr/WsbAkTusIQI8Mv30nXvt4Nvg0Gde8lKsVmtW/JEO73dEGhBfH8qy?=
 =?us-ascii?Q?GSNDDBkaPMubxYriWQSLyoLB3N9Ear4/AWGqGaxawzf+kyTE4WczCg7HY4OD?=
 =?us-ascii?Q?NpvUQ2a0tQF/HCfSmIxTudxCTjbLYMLf3NPV8P+Mdxtfbi2KO6YLU7jvR689?=
 =?us-ascii?Q?Drt/hYJEvEkLjmsQKKrTDecCi6w/N/hgsqJ/vcq+HmrJDkBsY3vHvUqpcBOW?=
 =?us-ascii?Q?GlMuT2qEfMjr8EYr0o7TVRmoKi1Z6sodgesK6SZnZvTv8WU3A9TOS6lf08Ji?=
 =?us-ascii?Q?mgJtUauHTm4Gj4f5wAv+TQWBYIdMUMeHG2B9jR/BONmKl4u1SzdqgnJJauyC?=
 =?us-ascii?Q?vZ9WWn4oSRW2sipGsiKuKh9MHsiWeuAH/6p8TCWQQdjyz+1Gen1oHFzG1LqV?=
 =?us-ascii?Q?dsggTw3M8GdcnQIUwx+EAJLUSCbItOR3j+Uyc/+cpin8R7FwJFDoKHudJCfh?=
 =?us-ascii?Q?2qfLpjFX/W8sOHfyr4oOsD74QWEd6TZz7jTzgmfEsegYi0do63y39iGFdrl7?=
 =?us-ascii?Q?ZHiF1wKwA10sEIZEuOU5v0pWkF9Shiwytm+XCUPRZUwuMsnYK8mHxnNQIM2N?=
 =?us-ascii?Q?0tQ5if3N9hCFpj8jIrju6mmJmmJ0okaIjd+zmTFKiPSG4MAK3+oeXqua5wtM?=
 =?us-ascii?Q?zJ9Y02Os0XvN6RmRhSHoszbbVwn5ILrCAYI6tT1ZujVeYF0Vkvot+F4VoiSz?=
 =?us-ascii?Q?qn0/x3dmFHK6zhw2fSISiJ0BE4Q4us3ytWRHkxpTQbq9kwa1vppOP10WyVj0?=
 =?us-ascii?Q?12BmjH2MbIojPGZL1kUlCaarCjuXScfvCjK3U837CvwGTh3qaan3xDGNi0jg?=
 =?us-ascii?Q?fVhNt0nSEdb+BrXKP9UOynP4bWDW321NGHsVal3xTZpmqI5FjVclKi6R/8vi?=
 =?us-ascii?Q?2AF3kWh050HP+7MqOAPg8PjhFjF4EYJdYfaHzDUb92Yg+fTqIcyXz+AxJME2?=
 =?us-ascii?Q?P91fOiq/tZtMkfN0sKp/IWi2rVvRQw7SlUK2lU0u3rGToaxpvm2HARbMOGzK?=
 =?us-ascii?Q?juuowvgZp+c6mF9UkBzEyu4I/wxLV4mG3O8f7n9q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4e4164-c6c7-4287-fdff-08dd182f5c53
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 08:56:25.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsqlVg6dvr2FftqJkhvyjhOA2Wz9NtKJ6REDl5O+RgZultOM6NPlE6JlXRvwLaPRU95k9Ot2sYJu8QHHbMlOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346

Hello Mario,


On Sun, Dec 08, 2024 at 12:30:28AM -0600, Mario Limonciello wrote:
> Move the common MSR field formatting code to msr_update_perf() from
> its callers.
> 
> Ensure that the MSR write is necessary before flushing a write out.
> Also drop the comparison from the passive flow tracing.
> 
> Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

[..snip..]

> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index dd11ba6c00cc3..2178931fbf87b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -224,15 +224,26 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
>  static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>  			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>  {
> -	u64 value;
> +	u64 value, prev;
> +
> +	value = prev = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
> +		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
> +	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
> +	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
> +	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
> +	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
> +
> +	if (value == prev)
> +		return 0;
>  
> -	value = READ_ONCE(cpudata->cppc_req_cached);
>  	if (fast_switch) {
> -		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> +		wrmsrl(MSR_AMD_CPPC_REQ, value);
>  		return 0;
>  	} else {
> -		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> -					READ_ONCE(cpudata->cppc_req_cached));
> +		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +
>  		if (ret)
>  			return ret;

Ok, so you are recomputing the value in this patch. Does it also make
sense to move trace_amd_pstate_perf() call to this place?


--
Thanks and Regards
gautham.

>  	}
> @@ -528,9 +539,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  {
>  	unsigned long max_freq;
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
> -	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>  	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -	u64 value = prev;
>  
>  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>  
> @@ -546,27 +555,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	if (!cpudata->boost_supported)
>  		max_perf = min_t(unsigned long, nominal_perf, max_perf);
>  
> -	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
> -		   AMD_CPPC_DES_PERF_MASK);
> -	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, max_perf);
> -	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, des_perf);
> -	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, min_perf);
> -
>  	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
>  		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
>  			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
> -				cpudata->cpu, (value != prev), fast_switch);
> +				cpudata->cpu, fast_switch);
>  	}
>  
> -	if (value == prev)
> -		goto cpufreq_policy_put;
> -
> -	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -
>  	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
>  
> -cpufreq_policy_put:
> -
>  	cpufreq_cpu_put(policy);
>  }
>  
> @@ -1562,19 +1558,10 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u64 value;
>  	u32 epp;
>  
>  	amd_pstate_update_min_max_limit(policy);
>  
> -	value = READ_ONCE(cpudata->cppc_req_cached);
> -
> -	value &= ~(AMD_CPPC_MAX_PERF_MASK | AMD_CPPC_MIN_PERF_MASK |
> -		   AMD_CPPC_DES_PERF_MASK | AMD_CPPC_EPP_PERF_MASK);
> -	value |= FIELD_PREP(AMD_CPPC_MAX_PERF_MASK, cpudata->max_limit_perf);
> -	value |= FIELD_PREP(AMD_CPPC_DES_PERF_MASK, 0);
> -	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
> -
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		epp = 0;
>  	else
> -- 
> 2.43.0
> 

