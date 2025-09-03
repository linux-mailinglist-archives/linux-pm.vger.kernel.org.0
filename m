Return-Path: <linux-pm+bounces-33737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C44B42461
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 17:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55486583AD4
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0530DEC0;
	Wed,  3 Sep 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oXaRPEDs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4020408A;
	Wed,  3 Sep 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911926; cv=fail; b=Uc6zQgkVLCmg9NWZ04mNduLeq7HK/4XhB/Tdd1q49cXvu89JDv1wHFZE7bkr6U/O9HxJ08mRIKOqrJokfnp3UCSiWY+7l19fRSSFva/bUU8IZMzUpmxive73wbgj8S7GUaXNuYYNK57u3+So3rwEzijV9N+RgIjA4Bnez/nSfG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911926; c=relaxed/simple;
	bh=Sqn99XdwLIWkjL5NkrKaoOWkw4bI8uRpnG29KA+TBYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qi1J5nZnfqzmG/yrp2Kfz5q1FdPWakl0WSgi4Rx5PpVN6QUxSi2Zb2EAO2ZZVc2MgWb/SDXPjGy2LVUoAJQPqpMrFQGJfw8hNxepsmy13oDBoHq511R9aNeYuz2P1aPovTMVQ2L2XuCy6zR/r1spmME+WB0aUfrrxxD8fLBlhos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oXaRPEDs; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlAltRtq8FtkaqSnu4QZGSVSZUE9JFquOQVsaW8J8y8hbpZp41NGq6erj2mQtCkYBSyO4c8dk13SR9NuQAX6AmDZTx+lU5Kd2oquRc4wMOWDM5zHPrPHFOlR19dqzK6HDvTHT73yI/4GcX9+JyrebYQQz7Vs0ihSjYTp6aIoTBvJ8OhVTXd1r0BtwrN5eSqFMd+z7vy09dofnO8h/pDuGw4Mye11wYVna3FvB99EcCIQ5B8dpWkp6Iujkd3cUhkcPLUq78NPurSRcHoeH+kKOFrrmmQKdziXQZJlejTNHY/rpy2PkrAYHZ2OrvZDYLTfTmUk2fdWkE5L/TIgEm5Atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSUq1i6W9+IeGHXKVB0RnEb3SfAx/mOXMSwRRMWzYhU=;
 b=NSXYcianlur3K7vhNf7DINE1Om2FfKkThy0OG+VE7o5Ph8NXOeKLSH2lj8LVCbK7z+sKaXryOmgIH8/+hlZqgJX7prNGXFw71FiyX/+M2FOzWGnb7Y86dBsv8eRytMfBYhN7McoxsFm/A8Kvi112oNhOD/o/fzCoSKMiC1eG6uC9NZ5Q6k2bYo22RpK6nLKSAPkNOSGrxN80928e07Cc/7Ppvs/5rRYOaCqQefiOB440XRtdeAT+DhBJBrsq3O26mWTZu2oWMBVWGmI1FHGKmcX6s9WmdC+kvJb4t6R7ATB5OOqsLNI/rryUM2LjW3vnliYwrH/UmkKDjgkwec24GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSUq1i6W9+IeGHXKVB0RnEb3SfAx/mOXMSwRRMWzYhU=;
 b=oXaRPEDsQcWJpRKvIKOyDliuzN341FBBMFzI4oCuvcrpN6xgdp1EsjkhhK4qRW39l2l0R0Mmf6UjopOP5oK5f49JSEVZolcXmL0PhRgDQp/9mT2vwnSmZAE5j4aIcEZsoc7/f8oVATy/GRuRNRxkZ1g/iNUG/AS8qx7VbSFMQmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:05:20 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 15:05:18 +0000
Date: Wed, 3 Sep 2025 20:35:12 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix a regression leading to EPP 0
 after resume
Message-ID: <aLhZKNnnyUXOX5wk@BLRRASHENOY1.amd.com>
References: <20250826052747.2240670-1-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826052747.2240670-1-superm1@kernel.org>
X-ClientProxiedBy: BM1PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::21) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad98cae-54fb-456b-572b-08ddeafb4bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A4MatByDl0k76CepaiakW0CXsvPV4lu158jTBCnIh7UH+c38Vt72JobOhJl8?=
 =?us-ascii?Q?Ceou6pvVwK4etC8L0UTUrUG5JkAdq0Dohf2wDQCHtGl4TUITmvMgukQ+IBQG?=
 =?us-ascii?Q?3HmAkgNciSWi4d8gjAZvPSVi15AYTNMpZNOLgRGacSKfwDFdLshJNLkJq1lH?=
 =?us-ascii?Q?jQ7odsuieZpLNFaeigfbAfdSrn5UOVNjH2z2QilbQ5w262dYjFCXwTZE0aKf?=
 =?us-ascii?Q?sog5u/Ck8d1/KzUbkEBCsKJjKliPSPqAVX+qVnv6tMatR3AXICIBA2AmFL1I?=
 =?us-ascii?Q?zvd2m+YpQ5OgJRPbNlHrME7deXOAheTK5MoNdhgpXMIZI56tDBaItWWhFJHP?=
 =?us-ascii?Q?VYa+bmLzzFHqzuik8cGtVmpf/1VmoObH4Jq963K/nMgocJ57aGa4v9B3TYOB?=
 =?us-ascii?Q?hyyevI5X6gpDLiJDwOy7BJrn0Cnk/oUmFaBMMCP39RMBxrafC0emZuoimD5J?=
 =?us-ascii?Q?GVBU5Zp8IbChrLvadLDzzReEjB8Psty72JCtQCYqh+NwC6FBwnK7dWwRP1wE?=
 =?us-ascii?Q?9f3bsI7u3vjUz9GVKGaDTt5Xxqdy0KEjb92+JLfAckjNl3+x64wqpNw/Awmz?=
 =?us-ascii?Q?JdAI7XjWTGepTXl4i0DlGgH/t5LJOdVpNxacq7l/TpBzom0/lWboBd+8QrcP?=
 =?us-ascii?Q?sxJEQBRDZS+h7Sb7YijxBJvKY5duxPJ+r/tVgdHtKgn8c3r4Uu5P66J3YECj?=
 =?us-ascii?Q?hm8fbll/tUKAYTt9OO5rb3O+bjZntqzsG59AzxhK7p8eX1F1DM1CGUKd7Nse?=
 =?us-ascii?Q?nIvCaGyDXhGu5iguBsC0sf9SyW8Ul/UvELQolUR5bJ2KPcYKvIsPygCf2P9O?=
 =?us-ascii?Q?mFeFlDmet9JBlzOZQWmHVRoQ8Js8RlnlZdn9CzAXmLUwLCOgSO/yZlcWiGr4?=
 =?us-ascii?Q?LFBX0kv4x0IbsJtCCHMgKI6C1qp4SO38/uSvNbzJe0gM5jlV4xDQkmzDsytv?=
 =?us-ascii?Q?79KC5UT6xeEPqC9fZEby5f+v1vHpekZpgioy+4TJkv/nbjaHhsTsHosaPthg?=
 =?us-ascii?Q?/2x3K9uu5SslTFClSPDZIa6hj8haJq1k4hlDvPpKsDnU3wYxZ1ks/elgokYu?=
 =?us-ascii?Q?6jh3ThbwaRKFUbH3Hbs4Tm0U0+1ywLW4HN2QYkA+logCxgt+rrGgAk/3zHb3?=
 =?us-ascii?Q?pSzZusjq4q+17O5rFu0DEb+6x0Dh5qj/c4+4GHNPn1eFjNLiuSZrFQ4lv6k0?=
 =?us-ascii?Q?ABAycpR1vHu798Kxb5YInwXGU5K5XF7fot+PD8g5hYOnUgOMJT6uKywnzf63?=
 =?us-ascii?Q?yR4Sch/sbI+tIStC7/USYEcnSnalnmIBn0xo56gmPYmy7Ye0zt1+6fTCpob8?=
 =?us-ascii?Q?REdqCU/SrE8gJ4qrkGmezUmov5RD5zjfXOnFn+E6AjqHA1pzeKngpHHkl+/Y?=
 =?us-ascii?Q?9F90GgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gqY5wjcQKm/6x6QYDZyuw5etnRYCKKTpXSzlAWOGRidicNNixvNGPuWVzBbw?=
 =?us-ascii?Q?9jRH4atoLIScJ1wWH1wzu1Vm9oNMSe1LIPEcHSyEy2kNTJdQ/w2Pc+oV1O/G?=
 =?us-ascii?Q?thynsoh0Y7VnunHsAgJ1G8VKfcpLS5LEP3VR/WmcAN82HN6OmTS0T02nGT/J?=
 =?us-ascii?Q?UefRHq5TfAsyR0+kHhEO0k48h+jRX9Xb+KOJtFG/PUi+leRGvUmZA6KV5nmW?=
 =?us-ascii?Q?19GakBxmOLBirjzu5BuVb5nc5MQSYfDt09IQihL/7UD+S+QU4Ls0IAGB8Kvs?=
 =?us-ascii?Q?Gb/Wc++cmoZVoWAbklEuQ0yGFmbspeFEf+04ZWrvU8i/L9zbHtrq+acaNkBC?=
 =?us-ascii?Q?ZCQ1Bh0/00fiMRS3txddmnmMVJZMDARF+xN8s70ByfiFaJA+P5en2bNXbjv/?=
 =?us-ascii?Q?tnN6EaLRX1DvF5WCqbQwbXhYUKfRBkiKwd5KcrTdTWZFkOzbyRXOmKj8EY9v?=
 =?us-ascii?Q?iwhgk2Qx2KLKFQzKGWPHIj181pWxx+eZw9tNUq/FB+7ajPqif31iTz6J80kk?=
 =?us-ascii?Q?rA86LXAyZsJ2UyB9P56M0REG0RCkPR4BBruHCAJhMw5BGYEi3vGGV58ImaK8?=
 =?us-ascii?Q?K0X03H/m23pkIMdUWFPx0xCVQrVqxSJfsKpRvppfT6lhbbA6dppCNX8mWina?=
 =?us-ascii?Q?xEBfhqfZJ+2ZUCjpGlgZBTeC1iP2SRM+B7AnnNqAJ2J8CdMBpuSaBymijuAD?=
 =?us-ascii?Q?gSKcQENZz7mT57k6K7dCb/kRQFTiz9QxievFptGYN5bPQZ+mRBQsyoq9sJ7m?=
 =?us-ascii?Q?Hl3HRE3VJ76naQd4HhxdOiw/p1Mj9yl7+L/dU+VvyRzlqbyLtlbGpvNvoqDF?=
 =?us-ascii?Q?Asi0PCHtRfb4siulbwWMJmqYwtKpgMp9L9d8XAIy/2uIk3zGuC7ELTvFsNNk?=
 =?us-ascii?Q?D3oLqcPKi4TOFmwakceKb427Vp5EYYrRD0G9/b2AN7gEs+SpRijMWYSF1uBa?=
 =?us-ascii?Q?3u7wPRb4qE+QBDu4wn8O82LNodYMeot9AwxlnYiSzCJalFMclHLNA+JuLLVV?=
 =?us-ascii?Q?kMMunW5W7ojucsEdhgHGPIob2dpOSIpJ5TwqQQumAOJX4dTO8KrjxOpIfuSn?=
 =?us-ascii?Q?cDzM4/pmJWPXWklFD6/s7912pTscQ7LOcV6r+pe5V1Zx22x/HsW+9LbnGNpx?=
 =?us-ascii?Q?BCJK1WrwEWZWlVW39G67dUdYn3v6nmy07VR47mhMPF2jqG/NZEYRdmC6/PbR?=
 =?us-ascii?Q?JGyou5a5MfwqiQWnaquzOS0JAyVjvajA/jsyfPxcLZ9V/lFEg6y/bnjfYm3v?=
 =?us-ascii?Q?yEKXQa4H9l+i6iY78N4Upc1k1XeJr7V3khQBngDrOvW7SaaJcZL+UoZthpHK?=
 =?us-ascii?Q?sCFK5ARrx5/9MQ4Z4Dm4JWCl81NrlIOgP+oIRmK3gLIvlX7wdJ1wg129Gze3?=
 =?us-ascii?Q?W0/0Ih/KGGPl9xHbBrpP2J2a7+pTiTl/ZHxJ4Hg3yZYG+iQIxHguxdlQBYNP?=
 =?us-ascii?Q?9uP7UCi9x8hZdHzsdW4jw6wEnnqJXge3kekt4AArfB4K5tpmSHnuVAyPQvBx?=
 =?us-ascii?Q?et+HX1JeKsr2Ww4C/TItho1CNCTDqpIOKQmWx/ouiyqBvvix1BxxJdds3HaF?=
 =?us-ascii?Q?PzLaOxmDWZ2U2kVkR5BvGHyNKIl4E9E8BLcvHQ6O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad98cae-54fb-456b-572b-08ddeafb4bb5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:05:18.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EzrrGawreNn8KgdNzsQx9C5Q0l1RwqIcn/S+7oz86Eirk/r92RLS/H3uBp+pXBSp+U9f6SMSbiNXhFdw5Ht4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

Hello Mario,


On Tue, Aug 26, 2025 at 12:27:47AM -0500, Mario Limonciello (AMD) wrote:
> During the suspend sequence the cached CPPC request is destroyed
> with the expectation that it's restored during resume.  This assumption
> broke when the separate cache EPP variable was removed, and then it was
> broken again by commit 608a76b65288 ("cpufreq/amd-pstate: Add support
> for the "Requested CPU Min frequency" BIOS option") which explicitly
> set it to zero during suspend.
> 
> Remove the invalidation and set the value during the suspend call to
> update limits so that the cached variable can be used to restore on
> resume.
> 
> Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
> Fixes: b7a41156588a ("cpufreq/amd-pstate: Invalidate cppc_req_cached during suspend")
> Closes: https://community.frame.work/t/increased-power-usage-after-resuming-from-suspend-on-ryzen-7040-kernel-6-15-regression/
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/cpufreq/amd-pstate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index bbc27ef9edf7b..8eca4707226b8 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1626,13 +1626,14 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
>  	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
>  	 * the limits, epp and desired perf will get reset to the cached values in cpudata struct
>  	 */
> -	ret = amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
> +	ret = amd_pstate_update_perf(policy, perf.bios_min_perf,
> +				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
> +				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
> +				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
> +				     false);
>  	if (ret)
>  		return ret;
>  
> -	/* invalidate to ensure it's rewritten during resume */
> -	cpudata->cppc_req_cached = 0;
> -

Ah, so cppc_req_cached is required to extract the EPP value in
amd_pstate_epp_update_limit() which is called by
amd_pstate_epp_resume().

Looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.



>  	/* set this flag to avoid setting core offline*/
>  	cpudata->suspended = true;
>  
> -- 
> 2.43.0
> 

