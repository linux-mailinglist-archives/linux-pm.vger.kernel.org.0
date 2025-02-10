Return-Path: <linux-pm+bounces-21663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6065A2E828
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C8716441A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D5C1C3C13;
	Mon, 10 Feb 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IcrkRaod"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF571B6547;
	Mon, 10 Feb 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180915; cv=fail; b=LOMyCWGwWgaGzdwsvD5CuPywPnFj7hnytnZDsMdd9p6RrTnzfWN/IbCtUdX9zmD0f0iwGGuGpby98HmDqahTjdtJJJO9ZIHWwImneAxRkAEf1UQSG2bjVjw9LVEKRGnx6VvFXNnwMqFRgOiIZBaMQyyCK97qfyskqHx5xY2yBKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180915; c=relaxed/simple;
	bh=D4nfU01jyOJnYdlJ3peeFyzbu06bJKKayAu4ihEOrT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n+dihCcLltlnRBEoaFVVeU/A4wauYTpPpngpr3eqxT+FgkYBCwxMb/CiGHiDTPwn2h/P5+bCjgM+ITgi17B2zZb98YXKxDbYsWn6k2wpO6p6jGxPoOZlF9/KFHTYqNCZaCge14lcgEcQi+LTxySMYNCXbe8Bie7tJD8L86FS5do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IcrkRaod; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbSMeiXjXBpA+1dwMnqZ0SfMW53wLKZ7K148H8AMTztq3NEfRNN3juV2TG2VeajhwBYE+tD63/XiaGwza/6sDOXak7MsB7TldHmU243lEJOs/zkaSbNffh5xJGB1l3wXOKgLuWa+CUIYcAIv+gOgQeDJjGWS3zZbEf6gRYVsA0edJFre7kurqea5z2Y0rRQe0IkHGHl4FppeyR2xxT/MGS/catWPmVMcAgbDUCmQyg7CaHJRP2T3TQ5SgAlYkxje7Tzrn8aONaDYiLuDrnW3SbzscwaBPng+UcPeNLXnPrrB6BS2YshO2NduxLpddJw37UjGRdwEzGiviWcnr7ksTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDP3RH4dgaFtaWbT128QofcdWaBvE3Nepv2uOqpAHY=;
 b=RgVhnxp+XjPigGSnclEymLErPhTqeWaHn3lod92w/HrGO1LkqG0OJj3Lz4Q7GvJnjNjtw58FNfjIFTtcNdydltoLvde6QC91S/LdJtRl0h954mb8Fvkr6tnUebKoRP8n7/DULz8Cm9s0VNvPzofiJ3lJccRYGoUgHnRB2DcfwGFHJxIVgC1/wWWFLd2V3DGcYPJRC71ALnPSQkcajPA6KPIuXZED1irszBSy3X9g+hjsjzbAAky5Jpt1ZtD5I8Jm7vrUX8sptuSLt2Io2JiLBNYouLv0dsZjukNqt8iuybHvgMI615CF9FOh/igiXz4hzz1rLjlljuRw8jEwy9356A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDP3RH4dgaFtaWbT128QofcdWaBvE3Nepv2uOqpAHY=;
 b=IcrkRaod2/EGCy7TWo37TYyzYumRtvq2jcUIP4j3JnMXTKNgfyTobaIMbn50nZiXGtnJciEuGVzUHfSvdyW9fRWJrlPPqHjUY2jrmwQFZ4sWYzmPYanmoeaZQb6pauf88MokQf5ligjG9K8umPYx4LmeHBAfM8fetjHydyb9xeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:48:31 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:48:31 +0000
Date: Mon, 10 Feb 2025 15:18:22 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/12] cpufreq/amd-pstate: Convert all perf values to u8
Message-ID: <Z6nLZhkZ4N03iy5V@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-7-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-7-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN2P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6551d9-a1c1-4c7c-a654-08dd49b813bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H9DmoU6RzqPfx0B2/wAhv7p3eQ4Bi/aIfyQmhgF7GWy2bAx4u/s98eSHr6HJ?=
 =?us-ascii?Q?XHbznOSbRObwexSpcoj4Gx9E5jJ2W8Opr3TNNWf8Hgl/EfoAxOJfZSQkoBk7?=
 =?us-ascii?Q?rfi670YNDm5w7dA37nwIbORnZSHTovWiAVl7re54gV2WTqbXVP7u+nN/F4uS?=
 =?us-ascii?Q?Sg5rv+ZEQolXQZvrgVolLUzTBvwSmuQzAmfQeeIAMyCAFbbpd9qo2FPVMQAz?=
 =?us-ascii?Q?7zzxt9R5N5oK7wLdHsTAj8326Bo8pHEDgayeHIvKIl0TLAe+XaxoU95Rt+fQ?=
 =?us-ascii?Q?LIIgKRH6KAZqJ7OnoeJKUUDTJcri58V+OXpOlyFfjcHigh13bsoebRP4C3wN?=
 =?us-ascii?Q?wB8sOsLRtfS4GSx59vCNU30/t0R+BbmRydiKEkIYmc9HmLe9At/IFJNmyK5P?=
 =?us-ascii?Q?V5Q4NIB1sGlaHF1BAo7OYVsZ+EZxTTJbGOgEsHaZFA/VX6HGQKXyPvpfST2/?=
 =?us-ascii?Q?Wh1NsRPUB7q8mYDC0X7fHMILy/7qn9okcNEl5X5wmA+mdKObBIVzgJ7BaWqL?=
 =?us-ascii?Q?sCfY6miDmvwTYTVVTLG91tD0XwHXe76tQvw7lr1k1lI8C8MFNXTCJUQB48Ms?=
 =?us-ascii?Q?lP2zHj5vAgEAyijd9/3RqrTm1IbgHPzwpxFH7LtqegoogIruTw6G72oyBTJ7?=
 =?us-ascii?Q?PaKiBKbzhil7r/OJld9L2wx+nsU2XQrXgStHNKRAiFeCSXN0urXW2DMiDFu/?=
 =?us-ascii?Q?rNY0rg0ulYlX24l7ZNNBs0U4/l5VIDAVVz1A9jb4kGkbwjMUNPkeQ2R0ZE3n?=
 =?us-ascii?Q?xAvwBejkwfBQXS4Uf0bUSdLl4l801E12p+GpYvkXj2rdsYEBDlqOa8EQ6VT6?=
 =?us-ascii?Q?ig9JXMbHdv/W6QGvb0QNjuCeRvWyJueAOPSlbKqkCKUy1Rd0gXgId5zhOTM9?=
 =?us-ascii?Q?WG8733jcUP1ooP6bnRyvK1uWH1OeYcy9Q3wZtsttVXfWlKDp+zK5yEUTONN2?=
 =?us-ascii?Q?OpuwcY7wA9SCyoKA0EP3TE3zL4wywLgQlFiUm7hY8cS+qlzD155Sp6Drg1Pf?=
 =?us-ascii?Q?Lu3JUuJNPQBFKQJ64puwCiSTuy3ZfMjQ4plVlr/Xc5O08W0FbZl5oK1j0NWM?=
 =?us-ascii?Q?EIIYS9djlxhHym0Ieh5LeNPSAr0X6lb2BJEWJotOHtckO/m1wzNw7a8I+nPr?=
 =?us-ascii?Q?1zv0k/6zga8cZUa8P1WCewJBy7qbAHQdWN5yn7bLcBsKIcIL8iQl+kTX1bhE?=
 =?us-ascii?Q?YZaYd88B6RIYXC/c9ZYX6+DEJ3TKdEhvvSPJvR6TNGq8cu/AgaSEIAMuFWcd?=
 =?us-ascii?Q?mh7ygWFuVXg/srqC+MhWuCV8oLmYgg01KBZvP7SXDDiiQaEEIxaiV/NHa9XA?=
 =?us-ascii?Q?lWiUQGhFgwtX7/fLqMD2FMug5xaYEQuDrzlO5Z2sNmgpSUIAmdSyoCqNg0R/?=
 =?us-ascii?Q?cSJxWMZ68p6UcNJQAgGfMO1fafZd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZO20YWI+tzB3OuP/drq4UT74Er4HAsVgq0/miz6VlzT524+Sv1f+JbecM2NQ?=
 =?us-ascii?Q?UlKYsQCZjDdxIV15D309FnLNTjN3zir1fA0pOV31yHvGMy1QQ2Zl/JzOlvJM?=
 =?us-ascii?Q?Y6JXlUwhZ00o446CuvX4Mu9w/syW0xwjZsf5zjQ+TG28pzEKsx9y3QtpZRK0?=
 =?us-ascii?Q?C9pNDnuDtxY6gf1aIEJjIAPDDU+oaeNq7hh0/SMwYQZ1k2SgBRwngeLZRv4c?=
 =?us-ascii?Q?ovUML/XkEB9kmImc2zVjHSTGs7DLifh+9oLf3kNnagdYRQpF6l96HFUZ7OvW?=
 =?us-ascii?Q?+e+D2WqKokkUT+Dm0NnwfBJo6+73v+zD+i0sBEBMszF6Cq89akwzYEqh4gSU?=
 =?us-ascii?Q?in9Bd+MGL5cfjwyUSXJM6z85aMA6Qdlzfj+5SFZVIlUzr2dRV/cp6P1oHHe4?=
 =?us-ascii?Q?A5PzSUQp4RZ7cdXzYK11g+UZo2+LBe7HsXvPEGOC7lg2ibDGwqTjc2/kJLmK?=
 =?us-ascii?Q?5Z1l/9KkxkT0CBumNR11hqY9iDFMWkZNzcl0TdZ7fhNsKUyKSdb0u9h17GG6?=
 =?us-ascii?Q?l1idJIXXnbc3oaAZiGa7HXbyaDF63mNkFvjX53AvHMSyQ1j4bbaxM9xnh5Fb?=
 =?us-ascii?Q?QZ6QvFvq6LoXu/QLkSv1E/Ccsz7Ok/i2ciRhfxfk5x+A9wQOsWa6oBZup4dc?=
 =?us-ascii?Q?Ec+O+1MEvYefV4jg7Y72YreWO9Nvh1mMVWep3//zbi4OEuHY4v8nLvwMeLsh?=
 =?us-ascii?Q?yjf8Q6kqQGeG8IaPujzBY94Nr9IWrcs6p5iY8IRQqHDaOEvkUapmM96UShra?=
 =?us-ascii?Q?Txxn4Y+G2guvdcbAd23bClNxbHOTtY5HcC+0v+roF9DdW2l00kr4lHvRCzLl?=
 =?us-ascii?Q?mVKkMpylZoGfXWgWbHOy43h78eRQUa+25PG2i7ft/b3WLqk3/6Qi5fDMxWJg?=
 =?us-ascii?Q?5COXa3/a0MuH5Bb8gWrBnpG+kMGnSXIQhIpWYXQ4GuUnGLfQawxJtCHhCnvJ?=
 =?us-ascii?Q?bQDupukRYslx5p/JzRxsWLT1xuUlPjZIa0SGQVtha2t5wUKpot2XMOsAH/ql?=
 =?us-ascii?Q?OwPH1JT3xtOdSGbNq0xqxqCBAURfzZ7ZaG8ty+L1orFD4+C6kmY2gH6QdEmy?=
 =?us-ascii?Q?Wo+c9cl7yroaPw/n6pPvlyxEy65uDeg+7b7xhyLnAnc5lWLDcdFEYeLQnNTb?=
 =?us-ascii?Q?uaYyaqfvvlbKlcu9F9a6s3SgHT7Jmx/nzvJ5PhQAOVyp52qql/RPr/L6mdx4?=
 =?us-ascii?Q?ttytGGJlEKM/v1RkU8cvTJsadJRmNtbaGl4YaHGQSHuizp3LMUAMNZulLDwv?=
 =?us-ascii?Q?zELhPBxEcBkwC3cbdkTvBeKwi9o9RspdnV9tzgdbbsK0P7NF6j5f6fetWWll?=
 =?us-ascii?Q?sqNhxlN6lV9U4vT1GP9ykH5nS+dDfMkVtpoAV/SEXPR6uT03F8+Muns5HiJs?=
 =?us-ascii?Q?TSnrnvIM7GgsMY9is0solV/1jdJj0IcjZINTNwBwsUZnW1LWN6iFXt1mNt2v?=
 =?us-ascii?Q?Vg2vE0V3P+kqcMkpm1uY3D6+Zvpa6pJKJg0OlD6I32L8JR8oBBjODKyJFvGj?=
 =?us-ascii?Q?J/dAZeOzHUssvTYgXpHOGWRuL2hksu3622mAb4OzCQtna6jQt5RrFBJbsC3v?=
 =?us-ascii?Q?kRJmPpIsmaDPPRslmh0tplIPDowTT/SsOST9nf4Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6551d9-a1c1-4c7c-a654-08dd49b813bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:48:31.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5YTcpr/MpD9fF5LvZfpOdjJBRsn0C10m0SVgogLyfjhc9GU41/bJm3dcXSJ8xiyfEnOTzM09C9IkfgXupbceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

On Wed, Feb 05, 2025 at 11:25:17AM +0000, Dhananjay Ugwekar wrote:
> All perf values are always within 0-255 range, hence convert their
> datatype to u8 everywhere.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.


> ---
>  drivers/cpufreq/amd-pstate-trace.h | 46 +++++++++++------------
>  drivers/cpufreq/amd-pstate.c       | 60 +++++++++++++++---------------
>  drivers/cpufreq/amd-pstate.h       | 18 ++++-----
>  3 files changed, 62 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> index 8d692415d905..f457d4af2c62 100644
> --- a/drivers/cpufreq/amd-pstate-trace.h
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -24,9 +24,9 @@
>  
>  TRACE_EVENT(amd_pstate_perf,
>  
> -	TP_PROTO(unsigned long min_perf,
> -		 unsigned long target_perf,
> -		 unsigned long capacity,
> +	TP_PROTO(u8 min_perf,
> +		 u8 target_perf,
> +		 u8 capacity,
>  		 u64 freq,
>  		 u64 mperf,
>  		 u64 aperf,
> @@ -47,9 +47,9 @@ TRACE_EVENT(amd_pstate_perf,
>  		),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, min_perf)
> -		__field(unsigned long, target_perf)
> -		__field(unsigned long, capacity)
> +		__field(u8, min_perf)
> +		__field(u8, target_perf)
> +		__field(u8, capacity)
>  		__field(unsigned long long, freq)
>  		__field(unsigned long long, mperf)
>  		__field(unsigned long long, aperf)
> @@ -70,10 +70,10 @@ TRACE_EVENT(amd_pstate_perf,
>  		__entry->fast_switch = fast_switch;
>  		),
>  
> -	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
> -		  (unsigned long)__entry->min_perf,
> -		  (unsigned long)__entry->target_perf,
> -		  (unsigned long)__entry->capacity,
> +	TP_printk("amd_min_perf=%hhu amd_des_perf=%hhu amd_max_perf=%hhu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
> +		  (u8)__entry->min_perf,
> +		  (u8)__entry->target_perf,
> +		  (u8)__entry->capacity,
>  		  (unsigned long long)__entry->freq,
>  		  (unsigned long long)__entry->mperf,
>  		  (unsigned long long)__entry->aperf,
> @@ -86,10 +86,10 @@ TRACE_EVENT(amd_pstate_perf,
>  TRACE_EVENT(amd_pstate_epp_perf,
>  
>  	TP_PROTO(unsigned int cpu_id,
> -		 unsigned int highest_perf,
> -		 unsigned int epp,
> -		 unsigned int min_perf,
> -		 unsigned int max_perf,
> +		 u8 highest_perf,
> +		 u8 epp,
> +		 u8 min_perf,
> +		 u8 max_perf,
>  		 bool boost
>  		 ),
>  
> @@ -102,10 +102,10 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned int, cpu_id)
> -		__field(unsigned int, highest_perf)
> -		__field(unsigned int, epp)
> -		__field(unsigned int, min_perf)
> -		__field(unsigned int, max_perf)
> +		__field(u8, highest_perf)
> +		__field(u8, epp)
> +		__field(u8, min_perf)
> +		__field(u8, max_perf)
>  		__field(bool, boost)
>  		),
>  
> @@ -118,12 +118,12 @@ TRACE_EVENT(amd_pstate_epp_perf,
>  		__entry->boost = boost;
>  		),
>  
> -	TP_printk("cpu%u: [%u<->%u]/%u, epp=%u, boost=%u",
> +	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u",
>  		  (unsigned int)__entry->cpu_id,
> -		  (unsigned int)__entry->min_perf,
> -		  (unsigned int)__entry->max_perf,
> -		  (unsigned int)__entry->highest_perf,
> -		  (unsigned int)__entry->epp,
> +		  (u8)__entry->min_perf,
> +		  (u8)__entry->max_perf,
> +		  (u8)__entry->highest_perf,
> +		  (u8)__entry->epp,
>  		  (bool)__entry->boost
>  		 )
>  );
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e179e929b941..dd4f23fa2587 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -186,7 +186,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  static DEFINE_MUTEX(amd_pstate_limits_lock);
>  static DEFINE_MUTEX(amd_pstate_driver_lock);
>  
> -static s16 msr_get_epp(struct amd_cpudata *cpudata)
> +static u8 msr_get_epp(struct amd_cpudata *cpudata)
>  {
>  	u64 value;
>  	int ret;
> @@ -207,7 +207,7 @@ static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
>  	return static_call(amd_pstate_get_epp)(cpudata);
>  }
>  
> -static s16 shmem_get_epp(struct amd_cpudata *cpudata)
> +static u8 shmem_get_epp(struct amd_cpudata *cpudata)
>  {
>  	u64 epp;
>  	int ret;
> @@ -218,11 +218,11 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
>  		return ret;
>  	}
>  
> -	return (s16)(epp & 0xff);
> +	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, epp);
>  }
>  
> -static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> -			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
> +static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
> +			   u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>  {
>  	u64 value, prev;
>  
> @@ -257,15 +257,15 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>  DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>  
>  static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
> -					  u32 min_perf, u32 des_perf,
> -					  u32 max_perf, u32 epp,
> +					  u8 min_perf, u8 des_perf,
> +					  u8 max_perf, u8 epp,
>  					  bool fast_switch)
>  {
>  	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>  						   max_perf, epp, fast_switch);
>  }
>  
> -static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  {
>  	u64 value, prev;
>  	int ret;
> @@ -292,12 +292,12 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
>  
>  DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
>  
> -static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  {
>  	return static_call(amd_pstate_set_epp)(cpudata, epp);
>  }
>  
> -static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
>  {
>  	int ret;
>  	struct cppc_perf_ctrls perf_ctrls;
> @@ -320,7 +320,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>  					    int pref_index)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	int epp;
> +	u8 epp;
>  
>  	if (!pref_index)
>  		epp = cpudata->epp_default;
> @@ -479,8 +479,8 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>  	return static_call(amd_pstate_init_perf)(cpudata);
>  }
>  
> -static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> -			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
> +static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
> +			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
>  {
>  	struct cppc_perf_ctrls perf_ctrls;
>  
> @@ -531,14 +531,14 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>  	return true;
>  }
>  
> -static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> -			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
> +static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
> +			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>  {
>  	unsigned long max_freq;
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
> -	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
>  
> -	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> +	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
>  
>  	max_freq = READ_ONCE(cpudata->max_limit_freq);
>  	policy->cur = div_u64(des_perf * max_freq, max_perf);
> @@ -550,7 +550,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  
>  	/* limit the max perf when core performance boost feature is disabled */
>  	if (!cpudata->boost_supported)
> -		max_perf = min_t(unsigned long, nominal_perf, max_perf);
> +		max_perf = min_t(u8, nominal_perf, max_perf);
>  
>  	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
>  		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> @@ -591,7 +591,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
>  
>  static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  {
> -	u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
> +	u8 max_limit_perf, min_limit_perf, max_perf;
> +	u32 max_freq;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	max_perf = READ_ONCE(cpudata->highest_perf);
> @@ -615,7 +616,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  {
>  	struct cpufreq_freqs freqs;
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	unsigned long des_perf, cap_perf;
> +	u8 des_perf, cap_perf;
>  
>  	if (!cpudata->max_freq)
>  		return -ENODEV;
> @@ -670,8 +671,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  				   unsigned long target_perf,
>  				   unsigned long capacity)
>  {
> -	unsigned long max_perf, min_perf, des_perf,
> -		      cap_perf, min_limit_perf;
> +	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  	struct amd_cpudata *cpudata;
>  
> @@ -904,8 +904,8 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  {
>  	int ret;
>  	u32 min_freq, max_freq;
> -	u32 highest_perf, nominal_perf, nominal_freq;
> -	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> +	u8 highest_perf, nominal_perf, lowest_nonlinear_perf;
> +	u32 nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -1112,7 +1112,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  					    char *buf)
>  {
> -	u32 perf;
> +	u8 perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	perf = READ_ONCE(cpudata->highest_perf);
> @@ -1123,7 +1123,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
>  						char *buf)
>  {
> -	u32 perf;
> +	u8 perf;
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	perf = READ_ONCE(cpudata->prefcore_ranking);
> @@ -1186,7 +1186,7 @@ static ssize_t show_energy_performance_preference(
>  				struct cpufreq_policy *policy, char *buf)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	int preference;
> +	u8 preference;
>  
>  	switch (cpudata->epp_cached) {
>  	case AMD_CPPC_EPP_PERFORMANCE:
> @@ -1548,7 +1548,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u32 epp;
> +	u8 epp;
>  
>  	amd_pstate_update_min_max_limit(policy);
>  
> @@ -1597,7 +1597,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	u64 max_perf;
> +	u8 max_perf;
>  	int ret;
>  
>  	ret = amd_pstate_cppc_enable(true);
> @@ -1634,7 +1634,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	int min_perf;
> +	u8 min_perf;
>  
>  	if (cpudata->suspended)
>  		return 0;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 9747e3be6cee..19d405c6d805 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -70,13 +70,13 @@ struct amd_cpudata {
>  	struct	freq_qos_request req[2];
>  	u64	cppc_req_cached;
>  
> -	u32	highest_perf;
> -	u32	nominal_perf;
> -	u32	lowest_nonlinear_perf;
> -	u32	lowest_perf;
> -	u32     prefcore_ranking;
> -	u32     min_limit_perf;
> -	u32     max_limit_perf;
> +	u8	highest_perf;
> +	u8	nominal_perf;
> +	u8	lowest_nonlinear_perf;
> +	u8	lowest_perf;
> +	u8	prefcore_ranking;
> +	u8	min_limit_perf;
> +	u8	max_limit_perf;
>  	u32     min_limit_freq;
>  	u32     max_limit_freq;
>  
> @@ -93,11 +93,11 @@ struct amd_cpudata {
>  	bool	hw_prefcore;
>  
>  	/* EPP feature related attributes*/
> -	s16	epp_cached;
> +	u8	epp_cached;
>  	u32	policy;
>  	u64	cppc_cap1_cached;
>  	bool	suspended;
> -	s16	epp_default;
> +	u8	epp_default;
>  };
>  
>  /*
> -- 
> 2.34.1
> 

