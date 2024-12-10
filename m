Return-Path: <linux-pm+bounces-18904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB89EAF7C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 12:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305C716A9F4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0612248B8;
	Tue, 10 Dec 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LE/weBAn"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CD2153E1;
	Tue, 10 Dec 2024 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828930; cv=fail; b=h3NJFJGB5KaFypffg+vKUzi+SgapkOktWSdVyOKfbBA0Vy6jy3r696CAhCTEkkTLpvEv7XkBwFt/r2eOHeZoMfqiHDWHx4ZE08vgGbnohELtgi2p5ljM4aEAWBjR9zTo4ZdD7s/Fdy+fZjo3i2pjP6mX8mnq5SOFhoUZHs3U0Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828930; c=relaxed/simple;
	bh=GEQ4CDTNXwt8YtYaqZ47ywH4hCUagy5g3+e4A6s8sko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ql20RYWueZbzxH9VbZ8yzAEiGN9dQrj1pFsmTvUM6waJZB0vSs4Nz9+a8Je4ttg39MgloJU+LUv5UOEJhKw+q0ajV2uCnXcCBN8IOa3uEJUBBXNWr5duR28/sgf1KsJ/xVxen7ik5MloLzEtA8U74nML9kwXgk5PPEr8qW5ya6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LE/weBAn; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elO2yTla1f9HOUBuHq7e5HpgkrjY1K+U/adlz5gDe/1NLHw7vKumUax9BM7966z3NvPKwadXRzsnoLpSMes27NFIMoIRnZ/xOgdVoiYm6yOYk9jon/2j4lHqXx4CpqnWlNYZGWIa90CnytbRaMO+im5JeZUDvba0m/1mMLiD9DzffvX7V1zHkkSiK9dSZ0KRsfrNcYcQi6/TM3YEQnBb4dcfOPjv0pgQ7t+ihirwAmZttCrbI0FgMwwWGU8G7SbzsLbM0ONF2+ntq+X88Cy7x/0dR+z6jcHsLokPr4zpW+NGSpdCzwXvjIPb9D7bgsINeyaKCaBhGvgk/23+T2Fhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK7VKsRYS3fiAolkJU8Ch+tutyvQd8zTjyXoz68hvZg=;
 b=TPDSdfsmaAXQH11wn8nCXh9wtnuykkzA0zGQst5CaxCECeKkuYzbLGgYQjUuwh9qrMmTtce9zv4RyzngdQu9EuJ1SBqJINXA6/rJvg0SeNxrzSlIpoZ6ND4B1BsDrN1WiGuWl29H9q0HhhD0imndwqk8NZy5WOYhEM7NouiyA3Xgi1WUuOusvB3r2ZGir1mbj7nfycmc8WC+xJWakmITrw+pAjue9DdfZ6Eyxs3GSG6CD3mSbBlseXT38+WulfiSbvVZdFTCrhxQeFJxUG9BTNnE5sT34mAnpn8rlfJDdiVNYWdb3RiYtynKRvosmG5qC0Cm//tVdPe5HI7PuNa+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK7VKsRYS3fiAolkJU8Ch+tutyvQd8zTjyXoz68hvZg=;
 b=LE/weBAneSnhyfDvtorXbNDYqY6UEo3ASkVtJ8Oo8i0uBk5AGDw5BNjYDgsQgvx23wkX/P+8PFgp1hOdHRu/OisCrvf2MsFfVq6DHHyTlkqSIgJRyo+asrFhKWjqfL/2owp1SCqobI2wc7NfzBrv6qYsOEqfdTmjGIoJpm65AK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.19; Tue, 10 Dec 2024 11:08:45 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 11:08:45 +0000
Date: Tue, 10 Dec 2024 16:38:37 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH v3 12/15] cpufreq/amd-pstate: Always write EPP value when
 updating perf
Message-ID: <Z1ghNdyUeosgOtdR@BLRRASHENOY1.amd.com>
References: <20241209185248.16301-1-mario.limonciello@amd.com>
 <20241209185248.16301-13-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185248.16301-13-mario.limonciello@amd.com>
X-ClientProxiedBy: PN3PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: afdac110-5b7b-479f-a15a-08dd190b034e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oR0Fj8RZxc2v7fBOx33JBr2b+DqBtg0QwQiM9L5dgydCw9vfXmf0X7EZ7LYi?=
 =?us-ascii?Q?wjUcnGdlUWUn1K1K96ftRb9d/mDfNAZU8CpQGzMEG8LmDACp642f6GEJO/Bk?=
 =?us-ascii?Q?qLqFgAzD8M8g0M3fD5gmqQvSyM8TL0b9YtRb2+T2k2zT9DM+66SnXFVyetCS?=
 =?us-ascii?Q?hSnWl0ufFDaOBgLR5WPjii0r4OsEkWldCWDGiKGWODpHFK8lFnqf6GrWGjdb?=
 =?us-ascii?Q?WNfH+8zh1/oyWsxec7vu96ZRiHGZfuC2coahj7ixGbsCmz+29YN46MxDT45N?=
 =?us-ascii?Q?HPjNltVIudn/M9n7ZWwGZAAY+2QTCtKCuTPLVkxwGlkXeKiVeEW8YNcA7aIt?=
 =?us-ascii?Q?1t7hME7pdqiXuLHo5C2SebC9TsTmuSo+t4yDjOOTVEazx2IDsn/OeD4+hBLB?=
 =?us-ascii?Q?HI7/mMZ/XJbXgcfXAACb7y2Yykeu36l8ms8FVXeetYy2D3YX2x1AjF2GOXlc?=
 =?us-ascii?Q?cI+v7vGiKqTcVq4IZrmaBrLM1+zJ9hG499LlKCfWZaKrzS0h8COsFTHfCqYj?=
 =?us-ascii?Q?95sa9jkDai2KAISuZYqFTRHWdkA/ODRLrUz1MMIcCYQZftDvCqlVwRh7mF/F?=
 =?us-ascii?Q?//2kuSggpnj/JvXoXTh+z6ldjHRcgX+i9zefoooEP3WuhpTxENu28l8BLcng?=
 =?us-ascii?Q?R389KJDN8yTM6JI2iITbP5QmxeJNTbogHeICRuFKfNASuNsp6HPnh8UALJRm?=
 =?us-ascii?Q?JUCxcd2123te6wgF3DZc7VWfN5jNlJQFmpNozb9qVWLwSyzfGnB0reGcbBnF?=
 =?us-ascii?Q?YuqYjMW22mpBAGwcmmd7P6MOkzqFf4pBdiMjrNbb09BYT/dF1I/Hq7RvAeqb?=
 =?us-ascii?Q?2VHBKmy4m0VRSanNaQ7X/ACGjYL599azJ94LoasReMzByuiNWs3XFtKqQFXK?=
 =?us-ascii?Q?QbmDGomcDAf2JV1ujSABe/1AXKfwBxMlWy3EI3PMjxmN7s8Uu5yRkS/iVw4a?=
 =?us-ascii?Q?IDl4TozjfwIhSV7uIgsmyBtvAeOQohe1lyuZjnuillf68ZfYpaMDW1pIEV8i?=
 =?us-ascii?Q?BY4CSIFW+xjsEuE9yA69NiyIUA6orZ8cliQSQ2DVXc933dSRNvZiL7O1kJU5?=
 =?us-ascii?Q?98M1vhu6cZPlef5mdx+7sLA6DTecweY3Z45UgGIhM4fFr399M8V4M2blUa2a?=
 =?us-ascii?Q?jhZwRXC6lNzniaA1nCVdKJxjNKlPeJCZK7Hi0r1XR0u4YvZZRWw1vlQWNxyz?=
 =?us-ascii?Q?tHd2SsnSwbWUig2yzdG8TRKG5YYXFcbYm9MZaG8BpbYNb1nHDLUlH4igKZIg?=
 =?us-ascii?Q?QgwUg9lKWdJrtQn3bCPcLFFBPYaaL4VF10+tx2gbvBoqxymG9o63CkDEjr4p?=
 =?us-ascii?Q?z7uNtzzP5BQnLEUNKWyPIEeOclsuqciTsRIXf/PwSZvIsgag9UmH2k3n+0fe?=
 =?us-ascii?Q?e3NZWe8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oiLHFIyJVp40cXVM+ib+XrWsLitka60zgB1wqSJEAGiQTBmP1oynjSXnOqwG?=
 =?us-ascii?Q?QNx70awZK3QxHC23KvTuBPwJEdOGtJ1TQIo+/9NcTE3MHYbhFxKO+K1eOpYh?=
 =?us-ascii?Q?HTr3FhZss2ptPuaq+uwbMMSWLEBOkYG7QoQ+vwuVzGLgGjSrPOW/8mN78ysV?=
 =?us-ascii?Q?f/Cqt0+HNYC+spU6lnYEfH4QdELj4YCH0JhfssKY7yedOEMl3f4JFWTRwcgM?=
 =?us-ascii?Q?PTcRGGTxxBkfnGI2Ty76h/VduphIuGp8+dJo2LTodN/wzVZ0XtoYhYT/Dftz?=
 =?us-ascii?Q?PzR19dtRD450zP2bOrvgi5qMhJmKnU8CAlgI9N5BO64xPefJ5nzbRcX1fsLt?=
 =?us-ascii?Q?IfOtFWGgBDxCXFjpMi8BO9JvuUWkPKvbIl4oAeCo9HKK1aiCfkVfrLT3klxr?=
 =?us-ascii?Q?NYxUfzNNvoJ8ngN5/Uz7a6CB2aFtJDJP9yuUf5wMjWfyqYKB6vwJLgOiDnBZ?=
 =?us-ascii?Q?8l+O4JwfAR8F6RtSRv9HggUgXlIkNlmU+MVZb0Go7h2DT+vpsO9sL60PsozB?=
 =?us-ascii?Q?dCVaxY3CnttdRe7/BJ67QM+FaqyfJCAe0hbD2RyRTMG1AHUyI3j1bavXm6FL?=
 =?us-ascii?Q?Uq37e71IwvlwJMnDesG6MHsUEWYZYOV/JAoubYJ+OUrIxq0RuL1xyJH6IzVn?=
 =?us-ascii?Q?UP8t1GyRJhMSgcMewxS2HXAUwpu87hpXObRnpFTldAOlmTrsVI2t29xc7q7v?=
 =?us-ascii?Q?+46jP9keF6DZFPSpYnYFW9QAPirvQ47UrNTuT+OXFzt086n1tgY9bZvQ0/PU?=
 =?us-ascii?Q?8TitfQPNE09sTKviulnWC9YlpjEdn5366P7qslL8RrVkZnqJqFPIQ7msCVTf?=
 =?us-ascii?Q?l2CxklmnsiEod0Bn2hrA/qL1vSbIIdOaIInvFeZY5TSyRpGIlhnBXqCI4WRo?=
 =?us-ascii?Q?V4MOSBbdrayzFeymzMjjtCJdbmPcNIC6KnWMRN6RiL4OLkwfRG9jn5Fuw3og?=
 =?us-ascii?Q?vg1Xv0kSpqYim5gCIR/rC1dDGAf0/+PG7U/kJ0TjzpZq8ZWyvtzO5YdVHSzv?=
 =?us-ascii?Q?P7twuUjnpOyY7ntOdnr0zAh1kfHTBa8YLjwfcXWA3Q2ijnCLW1h34Vc4lsm5?=
 =?us-ascii?Q?I3LYrj+l47e6DYKA/5wENPKgEB3AzW71NLrcTgt0DRAg06vkdHcSQo7mBgcE?=
 =?us-ascii?Q?dxzpCmZhOIxQ9M96Qy6bXczbcWBhdC4nVFVOxw2NMP1W1Aedd2k9gRL4Cb44?=
 =?us-ascii?Q?lbPsNJJt4zTRfQNABomeeCpNskES51gzC6QXLiEtmGbGVY7fHyI+erF5cMc3?=
 =?us-ascii?Q?nP4Kmqj8PRwQBJN90nlkBeZYLyjh8/o9uV4CpvMSrZIJKpm4nfdLTlDjthMr?=
 =?us-ascii?Q?s18S7isb0ZY4Ef2riJS2pu28QXXfiCW3RTouSW8YqbfsRohl3hYDT/FRlLeq?=
 =?us-ascii?Q?az3+Uooys9+mzsZmOob8RezbgvRwsDU1fmVciu77bjNCp9Na/RpQ8FN5OPeM?=
 =?us-ascii?Q?dnRLU6tG5Mxw2mqbZrWdUjFoQfaWHzg56CVog68bCM9xpbHIjyie/m7jXcKK?=
 =?us-ascii?Q?jz2gD9Ci0ax3haXXRE4Pm7Q6sIeUZAneBsW6AaVv4p3hUPCxgp8wGiaOlf/7?=
 =?us-ascii?Q?HFV4m9PMcn873s7+ZFMcsPU7lbV9lCVgyWAtDQjB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdac110-5b7b-479f-a15a-08dd190b034e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 11:08:45.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WbiS6lYA3GsUHI4ZrCsWCL502Hz1U/gy4EOGw66ZJRq9KTr1dFZR29ScfoC9q4BaMwQRVc+ZpgnglG30rf9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

On Mon, Dec 09, 2024 at 12:52:45PM -0600, Mario Limonciello wrote:
> For MSR systems the EPP value is in the same register as perf targets
> and so divding them into two separate MSR writes is wasteful.
> 
> In msr_update_perf(), update both EPP and perf values in one write to
> MSR_AMD_CPPC_REQ, and cache them if successful.
> 
> To accomplish this plumb the EPP value into the update_perf call and
> modify all its callers to check the return value.
> 
> As this unifies calls, ensure that the MSR write is necessary before
> flushing a write out. Also drop the comparison from the passive flow
> tracing.

This version looks good as it contains all the necessary changes in
the same patch.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Squash
>    "Always write EPP value when updating perf"
>    and
>    "Check if CPPC request has changed before writing to the MSR or shared memory"
>  * Remove extra write to cached value
>  * Add comment explaining why updating two cached variables
> ---
>  drivers/cpufreq/amd-pstate-trace.h |   7 +-
>  drivers/cpufreq/amd-pstate.c       | 108 +++++++++++++++--------------
>  2 files changed, 56 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> index e2221a4b6901c..8d692415d9050 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -32,7 +32,6 @@ TRACE_EVENT(amd_pstate_perf,
>  		 u64 aperf,
>  		 u64 tsc,
>  		 unsigned int cpu_id,
> -		 bool changed,
>  		 bool fast_switch
>  		 ),
>  
> @@ -44,7 +43,6 @@ TRACE_EVENT(amd_pstate_perf,
>  		aperf,
>  		tsc,
>  		cpu_id,
> -		changed,
>  		fast_switch
>  		),
>  
> @@ -57,7 +55,6 @@ TRACE_EVENT(amd_pstate_perf,
>  		__field(unsigned long long, aperf)
>  		__field(unsigned long long, tsc)
>  		__field(unsigned int, cpu_id)
> -		__field(bool, changed)
>  		__field(bool, fast_switch)
>  		),
>  
> @@ -70,11 +67,10 @@ TRACE_EVENT(amd_pstate_perf,
>  		__entry->aperf = aperf;
>  		__entry->tsc = tsc;
>  		__entry->cpu_id = cpu_id;
> -		__entry->changed = changed;
>  		__entry->fast_switch = fast_switch;
>  		),
>  
> -	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u changed=%s fast_switch=%s",
> +	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
>  		  (unsigned long)__entry->min_perf,
>  		  (unsigned long)__entry->target_perf,
>  		  (unsigned long)__entry->capacity,
> @@ -83,7 +79,6 @@ TRACE_EVENT(amd_pstate_perf,
>  		  (unsigned long long)__entry->aperf,
>  		  (unsigned long long)__entry->tsc,
>  		  (unsigned int)__entry->cpu_id,
> -		  (__entry->changed) ? "true" : "false",
>  		  (__entry->fast_switch) ? "true" : "false"
>  		 )
>  );
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d21acd961edcd..fc0eb268c0335 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -222,25 +222,47 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
>  }
>  
>  static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> -			       u32 des_perf, u32 max_perf, bool fast_switch)
> +			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>  {
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
> +
>  	if (fast_switch) {
> -		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> +		wrmsrl(MSR_AMD_CPPC_REQ, value);
>  		return 0;
> +	} else {
> +		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> -			     READ_ONCE(cpudata->cppc_req_cached));
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	WRITE_ONCE(cpudata->epp_cached, epp);
> +
> +	return 0;
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>  
>  static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
>  					  u32 min_perf, u32 des_perf,
> -					  u32 max_perf, bool fast_switch)
> +					  u32 max_perf, u32 epp,
> +					  bool fast_switch)
>  {
>  	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> -						   max_perf, fast_switch);
> +						   max_perf, epp, fast_switch);
>  }
>  
>  static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
> @@ -261,6 +283,7 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  		return ret;
>  	}
>  
> +	/* update both so that msr_update_perf() can effectively check */
>  	WRITE_ONCE(cpudata->epp_cached, epp);
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
> @@ -459,12 +482,18 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>  	return static_call(amd_pstate_init_perf)(cpudata);
>  }
>  
> -static int shmem_update_perf(struct amd_cpudata *cpudata,
> -			     u32 min_perf, u32 des_perf,
> -			     u32 max_perf, bool fast_switch)
> +static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> +			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>  {
>  	struct cppc_perf_ctrls perf_ctrls;
>  
> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
> +		int ret = shmem_set_epp(cpudata, epp);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
>  	perf_ctrls.max_perf = max_perf;
>  	perf_ctrls.min_perf = min_perf;
>  	perf_ctrls.desired_perf = des_perf;
> @@ -510,9 +539,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  {
>  	unsigned long max_freq;
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
> -	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>  	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
> -	u64 value = prev;
>  
>  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>  
> @@ -528,27 +555,14 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
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
> +	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
>  
> -	WRITE_ONCE(cpudata->cppc_req_cached, value);
> -
> -	amd_pstate_update_perf(cpudata, min_perf, des_perf,
> -			       max_perf, fast_switch);
> -
> -cpufreq_policy_put:
>  	cpufreq_cpu_put(policy);
>  }
>  
> @@ -1544,36 +1558,24 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u64 value;
> +	u32 epp;
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
> -		WRITE_ONCE(cpudata->epp_cached, 0);
> -	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, cpudata->epp_cached);
> -
> -	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +		epp = 0;
> +	else
> +		epp = READ_ONCE(cpudata->epp_cached);
>  
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> -					  cpudata->epp_cached,
> +		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
>  					  cpudata->min_limit_perf,
>  					  cpudata->max_limit_perf,
>  					  policy->boost_enabled);
>  	}
>  
> -	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> -			       cpudata->max_limit_perf, false);
> -
> -	return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
> +	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> +				      cpudata->max_limit_perf, epp, false);
>  }
>  
>  static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> @@ -1602,7 +1604,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
> +static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  {
>  	u64 max_perf;
>  	int ret;
> @@ -1620,17 +1622,19 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  					  max_perf, cpudata->boost_state);
>  	}
>  
> -	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
> -	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
> +	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
>  }
>  
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
>  
>  	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
> -	amd_pstate_epp_reenable(cpudata);
> +	ret = amd_pstate_epp_reenable(cpudata);
> +	if (ret)
> +		return ret;
>  	cpudata->suspended = false;
>  
>  	return 0;
> @@ -1654,10 +1658,8 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  					  min_perf, min_perf, policy->boost_enabled);
>  	}
>  
> -	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
> -	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
> -
> -	return 0;
> +	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
> +				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>  }
>  
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> -- 
> 2.43.0
> 

