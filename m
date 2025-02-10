Return-Path: <linux-pm+bounces-21669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D628CA2EA4A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3AB7A3920
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E171E98E1;
	Mon, 10 Feb 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xDwV/oDm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CB1E990E;
	Mon, 10 Feb 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184769; cv=fail; b=V5p0dVyGq2eZwqMDtu5MvKUWv6aXaphHUcz3oKDXaT9AGqreGtXNAHViY7/DYo2AZa8Ob2r/OajlQoRQxByM17wjh4A9st/LaWo4zRmatRapRIbDRxrgfhm3AMc2MQt9M0ctIf61ddmGBVyy94ZKB7FQvb6XLSxvd0aqWLMphbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184769; c=relaxed/simple;
	bh=uSW7I27cjHAebVldWoJSQMNz+sYEynASiJwNa4Z+V+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QFJkpQtiEyutc5jojDQMXrm4BpR5w+Ppws3s+vsjLmLAeGiw5ZOK2YWNIu3I1C4hGhqBRL/xyIdTKi+5toPnvFYmWfRFF5ELLHZ8NJ1VdPwmJ/QXGV3Mb7/TV9uBDEbMtPGwKflX5RZCF0FOk49AOTxn8z+iaFR/UZeZHc5FdlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xDwV/oDm; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYyGrvk1CLhM4RWIhPWMvHavrNiJYeV7D4zIOBbRltHDplFOn9KT62XbcWXfKnp2zwGjVf6aki0Px8RtGxdCzvepPhioi7EFGg0AE96GyjZYr2jkInP9G3Otog7AoODXRz5ROyFAWuanpPSrgognOdfBuUNIyNlh6mMc2pgSseGa4KacnKeO/ZevhBsN48adeKhMbOefd5FdI4oyU2zyYQ6DvXTURnUmn2KmlZvHYL2T42zElTitOYe5QtgaLihAzt6ngLHR/HJJrywe8MmBoYnwnIOXRv7ou2jD0DYjI59mGCAnwL+S/Qh46mJQUv+ghQIeLurXzr1swTdcabIQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxdcQSV7WoEi6gAWiR4Q06X3zN4VoQMrjzSMjTuiqpg=;
 b=MCLgKajlAQW5P7bMH/5J7UQDqrQrOgkutSgUHkFBc9QgOgSUeCtUuObhk3xmmQh7RtHLYjoIRq+/VGEWGMMV3G66O1I/0/oFlJGBPxfqukrjY60FyVbT33XhX8Tm4vhQDkJtJ+IO3S5D4m8Tg6YKX+QeDGEX8TpYj88NHN0vQXKnrWfjc97Gg3fQwuziIq1I2mlURPZFvlZTAGtGIO0cIbavh/G+/1yOoNSmuvosuhnYvAXcYztejZNNql0qnIziz1/a7KylO606iTZE8+jf4bdSf/5W8HpVe4IxtaIAPTNDIcu1SYvsOvYhB4ypiOuyGcrP97BVRBipdl1QEV1GyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxdcQSV7WoEi6gAWiR4Q06X3zN4VoQMrjzSMjTuiqpg=;
 b=xDwV/oDmtLQh/IIi5vjB9rN20H79t3xNAnsm7Gwtre/6RyG+xZtiZploS1Dgj7cTIQb19twiIdzMp3EM+2wYk1njQe9735T2v3ia2rMGqHXonMAdXUn80Jf5HYq6zVY4675LVZ8qok+vXi4zJABX5XAGaHQrrXqQJLDuPHqQdQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 10:52:45 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:52:44 +0000
Date: Mon, 10 Feb 2025 16:22:34 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 09/12] cpufreq/amd-pstate: Fix cpufreq_policy ref counting
Message-ID: <Z6nacnX/CcynO2Cv@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-10-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-10-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: BMXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df2973f-d4bc-4abc-a5d4-08dd49c10c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dbk+fGg63Me3nDtrbLEhgIQ4tF46cPpzxi36NJ4WO5TlRvg+eg6ENMM2RvT3?=
 =?us-ascii?Q?+Z4GvXzgT3/FzNWbTV8bBzBFlv48z64RqBvQi4A0aB37yl4NY9luUZw1+JeQ?=
 =?us-ascii?Q?VRy3gnpxR0P4/8wohfg6fVDaDKgPAXzALyGLi/inkwRtiz1a7+LPPt0bgrFA?=
 =?us-ascii?Q?dqaGTUcrUaTOdayADL3U7a4XAT+zNVTYRh3TagNAP7N/YsQjRy9SQ4r21fBT?=
 =?us-ascii?Q?ZaFdJ7GSsYoCxKJDCXqFGNZy0HPjK1zkidfh4FVmiE2eSa1C8VaBlDJZ1QBK?=
 =?us-ascii?Q?2HHPpU3UEWXe/ucgPKutPkTIINRkkmnGZhYV2SZPMTxTfuIvUZCZj/ycqIi/?=
 =?us-ascii?Q?Hokd4lmFehpA2rUoE32hk0Sy4IDU5MXw9F87NH0pr9y93caW/53ldC7d449A?=
 =?us-ascii?Q?4FD49NoNwnE01q5e8k6cG/RPneZTg6UO3yuOS/fDa+5foLAtAt3OpCglf00l?=
 =?us-ascii?Q?q3PUCjG9n4u1QfPcmnlXML4D3t+IJJ1PSKj84Llb6hXLENSZG3TEO1CVIgLJ?=
 =?us-ascii?Q?GxZ8bpcYB+eXuQAOegy048zNtRnrQq2ydDrQSeNGIggX/j6cDYjUZnlAEUB6?=
 =?us-ascii?Q?rgvEJnSespnNiXDdxp4DbKAMl+HCZrJHaFUTOcvRAAt0+NKWVRN46qkFRuB8?=
 =?us-ascii?Q?t6yBJ5INM8msto/rtUuTOIM52AmRnIsjTNlQb8qnzqXL1OwqIQEeP1YcIDxV?=
 =?us-ascii?Q?Jfm7txhdktuYbAyn0OHrAdRdMx45dMu/jx+QbwqOeVbAjwnwhdAR91n5uqu3?=
 =?us-ascii?Q?G0JGLPPxNe89mK05w/1tK43Kwi/32rmoB2VU/RjG28BmTLIWa4wb2NWAMeqd?=
 =?us-ascii?Q?jbi0Xtoy9DfZh8Q2cCaHEoYtfnJN27ntezHOsg+B1OFgl5PuoMuAIpEbgtce?=
 =?us-ascii?Q?v/YCl2+RBd/69ju1zwZLvmalluDX4GU0BgcNb2TJhsyHZRXzcDCxRZ6J7J+c?=
 =?us-ascii?Q?aZtoEodldTzCJ6xPMqD4BoaAcb0AR6jmqxsYaYZHz/AcR058P2icMXZ53bjL?=
 =?us-ascii?Q?Uo3UvCk/hJMKjgysoWQY7s35zeUOLdZjZzZlvo8AElkbfYPY43WOJ9Hz7ZJ6?=
 =?us-ascii?Q?Kl3wWK3Ck1H+ZNSlKhnsZxZcpw4xNw71MHQfE2244IprEbS+U4ES9VaaXmbw?=
 =?us-ascii?Q?t2CvM45OOFW/86ffFW2lMKUFfDZEIbojCeg1DQXJFH3lQlvgG12XreBvTBwv?=
 =?us-ascii?Q?MRiFLB5bwtHKlB664DfBiYmFDXYr3fyBrYu34uCK4pPQXe+V/gIs+V2Dz0hr?=
 =?us-ascii?Q?NGwKE6kHxJUcgBkbv8pcRJh3sbh4WZbkm/sffb7J1buZwM8UU83ZhK15YfMP?=
 =?us-ascii?Q?cxxlSoJQQCjxqa4djMbBajjySNFwWhe/nrY/qGMs4ymdA47vXtYR5LCt5SXm?=
 =?us-ascii?Q?n20Q5WdQAkzZKLhAm1wZxCCBVFxT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2RjTkDSqCSeZdB14UMPrY3rUmP3RHMIavPDS1f1HbCbru4vXaNlclW/A/4k?=
 =?us-ascii?Q?3r3moxkzDBcJS+6xcoiCv5QhCFjJewmD1IPWRprQsPXOHbULqFZC3ouGwP8M?=
 =?us-ascii?Q?nwghei19gzcrtluBpJ/A6oFj8kU8/NShZHjyB+53PP/bTw72yWazT9hmdpBD?=
 =?us-ascii?Q?Ih8tUUSKzdVEBZb7CyScrX4B+nIzJoAutjmH4zN77DfOwutWa76BkZGvpJG6?=
 =?us-ascii?Q?N6xVBbPwX6qD/BFF9h8dab2IOdXaW3UaSGSAgP9JkxAQyX2yG2Jz1bL90+Ej?=
 =?us-ascii?Q?0DrxaEBVQIGPtTDxJaqqQ65oMLREJXrA5j8hdl0AMPkD75OmGJUuJ/9CTyHI?=
 =?us-ascii?Q?gK0ancSwSxhdQ0hOC1efdWrx7H4sn72iwqPjfkFWk/WxbX5Ar5dszlTSy1ri?=
 =?us-ascii?Q?OsS8DIKHFNQl/j6FznmTruJ1A1o5tGUQhXJ9TsAJX9GZhIivT+v6giAKZCPI?=
 =?us-ascii?Q?w60MF+eBmfKTcQ/efEJsU3NsQK3qYEjd4FHokOneqVMfZrwL/Y7pYXCA7+68?=
 =?us-ascii?Q?YXbmfjm4obLreGB5Y56ZJsxqU35E9sT66UWgiRoNJzjHFCisjD+PPkydrza0?=
 =?us-ascii?Q?PQSIQTyLi2uZ/iuo66YjrIrAnkJIdopk/uIBq1RksasJxrVGSB3ZraSX6Z8w?=
 =?us-ascii?Q?E0FZk81c7s9GOk7PUEoRCRLpg6ZPEW+7g73XbW3QkOkwj5iwwzHWjYztzOCB?=
 =?us-ascii?Q?E+jypln0ayxkUm1HkH43h5N1tZt9W0Qr5OvrBt+8fewHeIoPJ7W064sNv0A1?=
 =?us-ascii?Q?Jo4r74D2ZUulvhoFhrjKUV4Ipc1GIbLxgxiD7KLHmflwmxJm2p+Q3xvuSXSN?=
 =?us-ascii?Q?aqoNbsNv82fqCbWbTFQPYKpAXssIysvokSmoMXpA6ob2aewvvB9Fdu9PzvQr?=
 =?us-ascii?Q?DQAd8yh5UzhqpUmXkpIwbEyD1uEbccZ3qKAt0nrTGqKvHsdK8UoYwydfLGrU?=
 =?us-ascii?Q?AJjUfCut+BFLF52k+KoGKNWv3cvAGr+/RI2oQSWCGhx1wHG24Cq4HXFjwwYG?=
 =?us-ascii?Q?5pTRG96eDVyQ0bXJZBuOinaK4ix6oQoSyAgwLDETHXJBEXSN4lHhdtWCIswm?=
 =?us-ascii?Q?6R61ulJhO0KeKJhKOp5YYizKi5mmcLO/wLq/Fpe6VVztRkiWQmBmWPTi76ti?=
 =?us-ascii?Q?dMql4zag5SHDNUikOBRE82+7IwkO8kbzLhgd3M0mucenaoGMzLcdwp281Bii?=
 =?us-ascii?Q?0ZfRGFWRO83gb53lveMpQrmBsZuQv5YVWqQc7gD7jvm7XziMw+fK6OWicDcJ?=
 =?us-ascii?Q?cuMzSEhmrv6bYBpdGgo72XWzmFZgfhvTiwss2y0Osrr8u9gDmx2RB741v92J?=
 =?us-ascii?Q?EAAM3Fp9BvWdmytSbjTxcoEgSIOd0HlH1sMrxRVXGaBr/+tiVKQTGY04xIvy?=
 =?us-ascii?Q?SkyFSiwbHw3bkBQaRC6pxDt4Qs2I8S5bwANZwtZVjylmdpLgdUWfCAoRW+R3?=
 =?us-ascii?Q?ap4dGQr6iVNXq4VpocdqZ6V5DgxVZ7x4h3G88n/lisqXZ1ayhAmENvniQ+8o?=
 =?us-ascii?Q?mVILV1FuefBLVih0VcrntlwAS2Jft9jJybKs8AJn6U3wz6UbMknnw4p/rMqN?=
 =?us-ascii?Q?YsqIBp6OjU7Llh0j7BP/ge0U6hdg/HxhFlEM5/aO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df2973f-d4bc-4abc-a5d4-08dd49c10c7f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 10:52:44.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqHAvfz8juH/ITQWfFDTex+X1TKbhG6T2cgz6sYXgOgf+rzJTmD4WZYKp7FtlSwE1bQ/RtBz9HKBgorNqwHi0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959

On Wed, Feb 05, 2025 at 11:25:20AM +0000, Dhananjay Ugwekar wrote:
> amd_pstate_update_limits() takes a cpufreq_policy reference but doesn't
> decrement the refcount in one of the exit paths, fix that.
> 
> Fixes: 45722e777fd9 ("cpufreq: amd-pstate: Optimize amd_pstate_update_limits()")
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Thanks for fixing this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 107ad953ce43..9c939be59042 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -821,20 +821,21 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  
>  static void amd_pstate_update_limits(unsigned int cpu)
>  {
> -	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata;
>  	u32 prev_high = 0, cur_high = 0;
>  	int ret;
>  	bool highest_perf_changed = false;
>  
> +	if (!amd_pstate_prefcore)
> +		return;
> +
> +	policy = cpufreq_cpu_get(cpu);
>  	if (!policy)
>  		return;
>  
>  	cpudata = policy->driver_data;
>  
> -	if (!amd_pstate_prefcore)
> -		return;
> -
>  	guard(mutex)(&amd_pstate_driver_lock);
>  
>  	ret = amd_get_highest_perf(cpu, &cur_high);
> -- 
> 2.34.1
> 

