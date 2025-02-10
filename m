Return-Path: <linux-pm+bounces-21665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5261A2E83E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4523E188928F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8981C4A02;
	Mon, 10 Feb 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WwisJQVp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFA1C3C0F;
	Mon, 10 Feb 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181157; cv=fail; b=Ryrrlj3IAV5AqBdkm8/wgih3aJuzexPervmmf8+GvA9yJTKJuj/GE0ZNDWia6NfZE2Zsyix8PPAnO/VJxp9xmMh17wVgw4d5m61zxyMY2ABePajuFMoP3wpoda87VEIRxrNW+ESHXZ6YrvLt477twcEGn4pANARFsp7+0pWBTks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181157; c=relaxed/simple;
	bh=YDUd8X2PWi6wTQGX4jqR0Or4fybRsaa8lBxYOMRdxOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oPE2sXCQhsi1zYgiCuV76fvDgqtnUegiGbup5AMdRLexyTE+SQdZrgTqwfBQLXvvvx6bn0bvyflhaIGuCYe1yn0NNtYuVQ820uAJATEbrl3h+1hJMg6l3D+CNaWvcX+EEUXlDPhwdBiPbcLZOgV5k0rx8UVHn8WZIUBfgtllzJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WwisJQVp; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/5grg64H9NtQ/7KZhZVcDv1vVd5BVGa5UAp89oXZMxWA+wRGMO3qfQCxMy4CdS2n2EO49wX5rs2PFaIgXoEsdP+m7DPqjZ7A6hrrlct2jjrwDj1gpJuVIyDOiqFWPhbnPms5IkObNRJvkXM+mmrSjf4Bi+gom1vz6rDehPM8MDtfyxg7Dx7PQFSHRrhxQi2+q9Ov76TIgsly0rFztEZBoaEXz1cp7ULGUhOk/eSKjuWakcXIiQ625lY9zlSoLMmHMUsGbRCbLTWmtEWc/+UFjcnLeJ7F/KeJvn0yHsS0VhHIK2Az8T1bUHyrYdm+z/hXjuD8fb3cCqRFjFy1aO9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvZWYPqExp53HOxGizPblFN9nKqCTzpHvKCFxE/WO1g=;
 b=BLcFXSqTVx3/UAE54L+wc01rB8byWY6e8DvEYla4TDMd1yHtiDykoPqfMeYWfegVy9ITdkWwsAMZy/8riulR6mqIhO4LMehg8YYRoXX4Ets0rF5XPZCpbi2RUCPxNdRJ8r7duKtLioRi4WvHLbsTVBR2PNYfl0HNKmDY52hQT+sS0SSLsQRtmJMTuNBexYxgRBoCYizq/5Us2IVVPo20QXNqovPO2PMspt57xJo0WA2eht39ljkZ/4lnxDWmQOqHAfMoWLjiUpzR/O+/FuBbsdeiakl1VGShkwHEcOpsQNCWDzy3+OaPr6uHTTdQMQPFTG5Qms/edYy6Z6Om5j5LDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvZWYPqExp53HOxGizPblFN9nKqCTzpHvKCFxE/WO1g=;
 b=WwisJQVpx960WugbFYqBu6ZjFHfBELJ8c4goCAV/36Hb5b+EPeyXT3Gf6FWZISLKc+VDWkN/B8jjd8lbVeKBui/bl4JMKf+Tq9QLIJEJVvyyu6wGNvN8HjCmIYI/kQpZS53VwJBMTTVKxzLzMzmLn8r/zIznyPpmXVuf9fqADQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Mon, 10 Feb 2025 09:52:32 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:52:32 +0000
Date: Mon, 10 Feb 2025 15:22:23 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 08/12] cpufreq/amd-pstate: Remove the unnecessary
 cpufreq_update_policy call
Message-ID: <Z6nMV0FmxL2SO95z@BLRRASHENOY1.amd.com>
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-9-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205112523.201101-9-dhananjay.ugwekar@amd.com>
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b4d182-e069-4473-d362-08dd49b8a35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NF/gP/GQKe9H3ovnkeBYiYJvSlLyqxA+B4KEtPp3HceGFPGHsTHKrHkyuS9b?=
 =?us-ascii?Q?PQMqV/D8Po077YDZIpAcS7cqaprEzHs9N3qwxj4Hq+3ZaO8sgGXm3VMED6/Z?=
 =?us-ascii?Q?kAcW/O+HwKOVcWBdB1kv93p3lMQeH7m+YKA05htcQ99zQ57uW4iSrhHG8pUO?=
 =?us-ascii?Q?p/XYuWYUm8BpXlA94+xbmuX60hBb9Hizc0NZVkJHSUE8LxYYTWXLH1d1ky04?=
 =?us-ascii?Q?BiBAAtXOZZlA3QbDnRdhvmdvQq3Jh7TZaduCIkCRg/PriRfcVmLhyF3yai3/?=
 =?us-ascii?Q?yUif8787VkXyLko4sc9DZQUW67IpBY4e5gj6xEf7WNCrYbcgMlKMv8RrD4D3?=
 =?us-ascii?Q?K7/ePTFjvkvt1ZBIyY8wmhb4UMROTVSXTmopqSr1NRFux8R/M0nxopF3nego?=
 =?us-ascii?Q?JFPhbqtsP8mEyuqfrnZRUw7qQ+wRF0p5tO0gjuok+RbCfpnsF/KlMFlu9jF+?=
 =?us-ascii?Q?oYF4Hc+OSBM4OflFS0txdH0B6EskpXCYyIfwb6LIcIlfTHqTRU5+reVbhNcj?=
 =?us-ascii?Q?phyZag+Kc3zPsJDW1nTbD/Dtkiz1z/J9bUIYk+L+4FN+CtZ09gKSKKLTYVSN?=
 =?us-ascii?Q?9P1m408jkj9srnBAGtHryLa0QnskNFxAzicVG8Kes2XnsbtthIO8PXGtA67P?=
 =?us-ascii?Q?QdWIJkjwhcM4mwHfwi3560Ai1NAXaKCl8QLEkwlECZ2FtmLmB8u5sMJwq11T?=
 =?us-ascii?Q?o9ep4Hw/eN0uvAGVO0Cet04jjFK16qquDKhduj4exaiRetmtF0iAJ/xsUKHD?=
 =?us-ascii?Q?IdgSyEGbstttZ4D4D5sQ8RXIo6lOV5yKfHVyA5yYlXVQZCxi6evelqFhg541?=
 =?us-ascii?Q?uzrxgM/J1QPm9KdXGEL5hOQaSzBZ2X0CYLDzJ8esFGPTV4p6R4i771PoH7AR?=
 =?us-ascii?Q?OCpG4bSXK8p4tUnpTeSmhd2kMtjUpXG/zfAPahLUVg1UFNWT2OExp3D4vL0V?=
 =?us-ascii?Q?TQnw1/JrUGolPVZxh2VWtUufKv0ANDGM37TzjJ67wBVBLmbZnGsOP9wSNNjC?=
 =?us-ascii?Q?Yk5jkynTHf6UVopCgQXkxDf6VrNETV5i5rIYf0EsK59qfjkvR1F/w2Km6zWr?=
 =?us-ascii?Q?fDab/oWBlFO1HYYgWcByYF4qGSdj3pvfdPr5xeyOeKUSvJw45qJjz7FHNmlM?=
 =?us-ascii?Q?2eugRfY0WRR+ylqcDS+6C0RJqr1Y7/QFjvktAvIQavDJ/rxSVCq6aeZY8EMK?=
 =?us-ascii?Q?XqjdFA5+P3pcW9iYrigEf9my3nx5uSCXtHWDXKXHVmzYls++z/2Ur6n8ak/J?=
 =?us-ascii?Q?SofoOjaT/xqGXWJuA6GiSyWxCNqyGSxJVtOO7iTstSkUeZGZCb0p4/GKfjKg?=
 =?us-ascii?Q?W3ohPmgtJ3ckqS3HtZ1uzelN6kAv2KQj0mqUmF3PEg0LJ8FyJ9hJHyAfl2qD?=
 =?us-ascii?Q?bDPcNaNm26jPYgpA5C7JTNa5xELK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/RtXr3e2Fg/I3DuFEc3DcCRdW35Os/f2LPQf5fBuOihAdhEAOmZDnE1yde/?=
 =?us-ascii?Q?jjKhugZe9OuopKRIPAXmDktYTWw4W5NlONI2tWsUHDtqIr3UxL82tRYAo1l1?=
 =?us-ascii?Q?jFG/S5gPBJ8LkbzUIfc8qY3vOqztPjIqTryuLd3an6dhFD4OSPFlNnQADImb?=
 =?us-ascii?Q?vNLn0rOSsgqAav+BHV9JFlDpj6szrX4lmKL5h3f0Hbf7D4prcTZ+4NrkpdlH?=
 =?us-ascii?Q?QAQiQKkDC6UA5TiwMHgHj9ym/1xwRxLump+RumYp3GuVs781iPOZJqL0yYum?=
 =?us-ascii?Q?RBewiPEZbyKYCqxumSVgqVsg4jZ54RzJRtvNyUgGSNua0uI3QF26qH/3+19Q?=
 =?us-ascii?Q?Y/qWLzH5+gv3Nu6ISj6WjqdQ8F9tgi2fWLSHyp0QBuOsTqthTITbEezzztzM?=
 =?us-ascii?Q?GY2VzxbYpHUukuCoKAFZBB40hexmV2lJ1yddCw/6aRfueynHDVfLK6UZ1kv9?=
 =?us-ascii?Q?qKH75MVF6SY1MvDpkKgKvII3Ts0XVBn5x8J9inlslE/CjEc4qVTjzzIVJNnr?=
 =?us-ascii?Q?80hMpY51hJsFRgWenbT/y/EsaKroFMsMjNaiTjyUmZNFL2+K2JNXSy6HFET3?=
 =?us-ascii?Q?9GWjiRtGU4eWxnHpbBWRuxb5JnePKzhu7YyvyiCPTH0G03FclWXerHFowWCW?=
 =?us-ascii?Q?YVk75cuTNxe67mXtHqrWf+aPlF/CkQDlhUsKC4qdTny4R1k5Mw/it9gEboY/?=
 =?us-ascii?Q?IC0k9fqXSvlEys4qZuGJ68Keahsuk/NWQYs/aNdd9b3ia36Vi/tOyz7bzss1?=
 =?us-ascii?Q?lo5vej1NeWl+6j6T/eK5k+h0Lg3IhiSnh2cfiW8Mcsvhi0U4MPi/ZuMi1y5U?=
 =?us-ascii?Q?wArRxUtIsi3Y0vcOsOLvgdzTupQnxr21LhQCaZ0aemsBQqRftkvQZatjhCjP?=
 =?us-ascii?Q?nbKftjWTJhvP+qWUWX/NCRaWTHD1Ba3ItMGThNau6jRrbH7qgDBZ/Dk59/qK?=
 =?us-ascii?Q?QAV2mWFHcE+/Ne4leeL1Ff9fmRfx+07amBNe9zRYzrK9lZ9YbeyIFH8gQQRM?=
 =?us-ascii?Q?fYcansKqLnA6j4HCNniJFbGUyaxDe19nHQ+WjkDOKvvXAijQxahsMMGOWNzq?=
 =?us-ascii?Q?G8V8b4d2nrb7zQ8XRmJ+lyflw7rKoIwmB/YMstJ9Ac1alM9ouin+6TJ2ReOR?=
 =?us-ascii?Q?Py14ag0gpjRFISzskyBUNFSNpQTJPnwRdQ7Fsrw7zmA9WUqy4NHnS0xRpJST?=
 =?us-ascii?Q?0xsHu/9rZtQ1JPYXWrmTeS+hg6NKORgzPgjhLhTyOeid9tgj836rXjHkf9+q?=
 =?us-ascii?Q?yOYbzJFI+U5OM19GjHCZb/7wDXzKfsl0D/gdk9LBR94KAeys3JMQ5JzzlGt5?=
 =?us-ascii?Q?a9Und9B0I2BPn1jDHXFPMDiRPQyzJQRxzBN7RUNwRpIJ13G8s5mgjIGD1eRX?=
 =?us-ascii?Q?jImkLAhFVKGVznuM6DL2Ou4mBQe0ilQavVhFMSYJZDECpKDwTU7LmtDG06fc?=
 =?us-ascii?Q?wfDXUs1Qiyfdy+CNkFeBV/D/c8ILa+4AESUEBen/5nYeKj91xErtzW/Iffsb?=
 =?us-ascii?Q?4MoLlsdyDmK0cFywXHwDOuLZbOyswGrNRwhQOuFpWuKJQaemS78S4lmziNQE?=
 =?us-ascii?Q?xhTdN4nISqnjuU8/8lNmfRlZO/SglrZWuhQl+Gop?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b4d182-e069-4473-d362-08dd49b8a35a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:52:32.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEm7wgMACSJdaeRaS1btAzyqh3xaneC9Ml28Fb+XO7xVkkj6RsTsYnTIW4Mwng73RMRob4fRRhFuZp08jKLEPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

On Wed, Feb 05, 2025 at 11:25:19AM +0000, Dhananjay Ugwekar wrote:
> The update_limits callback is only called in two conditions.
> 
> * When the preferred core rankings change. In which case, we just need to
> change the prefcore ranking in the cpudata struct. As there are no changes
> to any of the perf values, there is no need to call cpufreq_update_policy()
> 
> * When the _PPC ACPI object changes, i.e. the highest allowed Pstate
> changes. The _PPC object is only used for a table based cpufreq driver
> like acpi-cpufreq, hence is irrelevant for CPPC based amd-pstate.
> 
> Hence, the cpufreq_update_policy() call becomes unnecessary and can be
> removed.

Thanks for the cleanup.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 346fac646eba..107ad953ce43 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -852,10 +852,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>  			sched_set_itmt_core_prio((int)cur_high, cpu);
>  	}
>  	cpufreq_cpu_put(policy);
> -
> -	if (!highest_perf_changed)
> -		cpufreq_update_policy(cpu);
> -
>  }
>  
>  /*
> -- 
> 2.34.1
> 

