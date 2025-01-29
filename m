Return-Path: <linux-pm+bounces-21088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB3FA21C02
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 12:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C461883A98
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7D1B4240;
	Wed, 29 Jan 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPmVdfgI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1019DF60;
	Wed, 29 Jan 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149483; cv=fail; b=bugLiNqu7cmOJOQuJtNIuA2dOnIYaI38Qymc9kmn/p8RqyM+yvQc6PmZpvGxYYETMwrXQZrsMHU7d90o25lOA83S81igtvRjKSFET56m1imtGajhUtnIXHXBLTVz8J9DTbD2C951x7y57z1X5c//nlst669HoskbgniwR13N76Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149483; c=relaxed/simple;
	bh=G924FupLB9epzpC8Yy/5qfdi7e/SWsBxPT4fg+jpOFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MDvs4WrNFOVURQZkCc1Y8rxhBNc/9lvKXNrqybOu/gaM27+Ns+8Rlk+btoaxpO3OysYnzuHhER2qc+tnzhYMEPGg3ipoHG3DKPmIxPYUcpp39tDVoieNWyT98jOSWuDz/F4WS3rviivxEOqO8mkM9Pl569ehUCFIEk1jpfPB2tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPmVdfgI; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/FgoRqDtnlBzeSqNC3sXku+N1drvdU7baGFFiPhZpVS26LplG1NWEfu6cihcMUc/7MrPgh2IS233nVVhSp74GUMGlca+BWbCHGNdraXRFQoKNYMEQ9CiR65l00HvcxgH2t0sZdxOasUgex25cS3kW1en8NSJ7MHPHXMdmJAAMA8Gc8MCmwy3D/sr/qGJu9d2fC7SgUTRQaS3IeDA1WhsBXgGF6AWrwrLzXuF6LybOnPMlLUjmBiQI3oHMwdbAJfWySNlTD4AyUALEngMJ+PI/LZTBc7iXDTe0uUPHMCWsEqkbXN/FU8nsR4g5olo2Q7DeTFR7+Q+xbPhbIPamzHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR4jfuaRoh9kPBuw9ezZVA0DCSlEvTAy5xhXj4BUyRs=;
 b=b/NuRH8WcM7dXz00mo3aCYF5GzTx5pqIrRvNLGXXPvV/TMtotSQIAXvLFD7Y4M9vvSUXkLphR9rL1QZfy/R0diQqZpNi93e1dDpkQyA4WDOwUgYdqb+0L7FXyuRAkJlSnIhZLb24Tqp+dLCT+Ba3Bex/aUNOHS6NRGMpQ2lLbMfevtq6kBmQb5QevNhdXKOXtp58W24kryWtcpbJJ/0llcgRq0dqw3KcmlIeymoO2CybKHLxkXL5kkfVyI5cnprPsaDHOggv7ogg6kPgovav601JIKrUHAE90CdDxYNue3cUdr/X02Rqpee1+pTuF8Sh5ZXqK4KhuNBUCNYly+fehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR4jfuaRoh9kPBuw9ezZVA0DCSlEvTAy5xhXj4BUyRs=;
 b=KPmVdfgIhcZIbXyloqREd7a7J8tiG8LPn9+RMRf9KO9O/HOGw6/fr6/7nu0aAXcRVgj6/BneIGWODZeYc/UrjXP+IYIHcaUfzS0yrd340xv2/VhY/AOUOI2J4jMcCz4ZCvR3bS9K0PqCYx2xu5uJtVkkcSF8H7VYiOWbTjA0+ZqwWQZIyrvQ+iRHskZ5o6IYop4CEUAoPFKkXjTCKAyR2imPu5KiUrBEbpn3v4MpPgPTleD3NnE7Oz6Gtuvuk1L47rrc4rimIHq1zZ1zscy7/UKUmYPhwuamBMK8ofLDES8LWqrrjypcia8sHRGtHYkv5G9BI6YdvIWgiqsQxR0v4w==
Received: from MN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:52f::30)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 11:17:58 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::25) by MN0PR03CA0014.outlook.office365.com
 (2603:10b6:208:52f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 11:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 11:17:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 03:17:43 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Jan
 2025 03:17:38 -0800
Message-ID: <1465513a-1752-48f3-80f1-321d1e7f357a@nvidia.com>
Date: Wed, 29 Jan 2025 16:47:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] arm64: amu: Delay allocating cpumask for AMU FIE
 support
To: Beata Michalska <beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <yang@os.amperecomputing.com>, <vanshikonda@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <zhanjie9@hisilicon.com>, linux-tegra
	<linux-tegra@vger.kernel.org>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-4-beata.michalska@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20250121084435.2839280-4-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccf4e04-5b21-406d-5c4d-08dd40569570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTI3MjhHcnBVY21Qc2JmVEhydnZXLzJ0WTN3SHJNWmlCaHFDNVV1RDdlR291?=
 =?utf-8?B?SHJVMm13eDgrMFNtQXBYMkJBeStYSlFSVlR1QjlhTnZGbUhlcEkzZVhQejEw?=
 =?utf-8?B?eXZMdVdXa1d4MjVFM2VGM3AwZ21KSENvWVZZZzRpUzRhZllLSFlHM0RQU2t4?=
 =?utf-8?B?VERoSTJKdDdXUHpxbXZWNXVkdEJHY3FxK2V4a28wN2pLdDNRN05jcnJ6ZHlz?=
 =?utf-8?B?d1FuZWxIaTNPQ0QvMjR0cHdnekRoQmNGQ3R2RE55dC81TWkzTlVSRC8ydkkx?=
 =?utf-8?B?NDc4TENRVDNRZHdLcW9sNHk5eFVoNDRGa2VhSm5rRzZkd2RYSGUzeVBwNWVw?=
 =?utf-8?B?SE5EaXlIazlGejJoaGZTWVFiSkF6MThQWE52Y00rSGNZVFFoSWZmSTVXTVJM?=
 =?utf-8?B?cER4dGlTaW1yKzRsT29uY2xvY1FMbGNaRmc5OGtDemovWVN0SXBiTUUxN2g1?=
 =?utf-8?B?SkVlanRuWGlpSTk3WW1pcXYwbWYzVmNlNjFqRjJ5azZpdnZnK1JRRHllaGVx?=
 =?utf-8?B?RWtxWjFkV2FLQXZwU0VOOHNXSUdNV3J5UklsSUUxc0MxQ2xtSXN3NERRRW1v?=
 =?utf-8?B?UWpmYW1VakpMK203eEl1TW1sTThxR2tNQUkzekZ4WUtJOTQvOStMMnVuemF0?=
 =?utf-8?B?T0h6bitEaDl0YVZYalM4Rm9FNWhyN2NVbFNuYUZZV0xRUHVCejBla2FvYWpu?=
 =?utf-8?B?V3NkSEVOZGgwQWhVT0h0anFObXVXcWtWd0ZJbHNsb205WkdneUJMdHZTRGpv?=
 =?utf-8?B?UkRidWtDMDdtb3VTTGcrRTducWcvaHcxSlNOT0ZNR3VaR1lkYW01TjNya3hK?=
 =?utf-8?B?Sk1uNHFibG9VMzdCa1dWYUFFTGlPZzFpbVRwd1ozWUxBNnVXSEMyT3l4Vlg1?=
 =?utf-8?B?WVRzcFBLRFpHMVhjUk0vS0g1K0F2ZzJzc0VtMCtBNkZ0ckhuYVhIVkdIRnpB?=
 =?utf-8?B?OUg3ek43bzBhQjRXVmhDeTg1WGJ6aGlkRmlPWHpKVmtNdXNsM2gxYVM4WDdS?=
 =?utf-8?B?WlI4WXNlYW5ocTZSNlNrdjczNmROTUtMR08wQlI4Z0NaUGE3NHJQMFVZNDEz?=
 =?utf-8?B?bFBQMmxJTDdzWVFMWkJBaXlwY2lYTDJKdmZlb1JhcjlPSGlXWmxkYlN4cy9z?=
 =?utf-8?B?MlErcGxhK0N5OFpIaDBtWWtYYWhYcmhZRXZVRUlGRThWRlgzZ1B5QXQvdzh4?=
 =?utf-8?B?L1cyWGxFNVVkYk9lOExFN0F6ZFlqaGRtMjlZQkFtT1YweUJlejl6QVRtcWtV?=
 =?utf-8?B?elpvMGhrWk1icEphSW1EUlZwNUlWSCtVUjlyTkxHN3RlTXVHQmlhOGtIYlJN?=
 =?utf-8?B?SGtVRUU3V05NeU9ZQzVSVkM4eEVMb0lqNm5DLzY3Y1pJTkRuV1RFNmUrNmlT?=
 =?utf-8?B?U3hrZkFZekZ5dUk3aVNBNExPWFBFcE00TXpOMTdEZVNNdElod2RXMUFWTnA1?=
 =?utf-8?B?S0RsUWVLVk5YRFgxOWVaYklpcUtkZTRXSlFSd0xpSURFR1FXcEtmYkVZb3ZL?=
 =?utf-8?B?RjM1SG95WHpCRlJxWVJ4d0dpeTFiQ3c4aHBYODByZUtXc0JSeDNnQ0NKZkJh?=
 =?utf-8?B?Nk95MGhlY3pmaWM1cFFyc0Y4NTFFVW9rRG9uNDlwU1V2eWNNTFNla2VvaVQ0?=
 =?utf-8?B?cDlqOGZrd1hnTUNxVFVJa3c4NGtjQzV4NW0rVlZCYitiZFZpL1M5YnNNMWx6?=
 =?utf-8?B?UUgyM1YrSDNFampFNWo3eTZNUXhRZjY3K1gvaVJmVnlpNlU1aldzczBVaGpG?=
 =?utf-8?B?bWpPbjRCN3JPSmhzSFY0UldTSCt1aWRNSmhuMlM5K3BrR0dYWTZDWTNTR3U0?=
 =?utf-8?B?SnJrN0xjaEJQa0V5UjJKMzR6VW9pZ012QWNsQ1FmMVl6Vllib0psbTJTcWxS?=
 =?utf-8?B?VlE1QlM1MVJrMU9XNHdJNW11QXNVYUd1NkVZTXg5Tzlib0t3WHo3UzJXZzJm?=
 =?utf-8?B?eDhjOWNvQ25FY2M2NVpDcjV1RDZmMTRVbS9tQ2w2VEI5c1R4cGgwN1VQSytr?=
 =?utf-8?B?V1J4ZzhSekJtcHlicFhwcDFMaVl3TTVDRCtQZExueUkzUU85dCtHRjFBYWt3?=
 =?utf-8?Q?vkAsnu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:17:57.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccf4e04-5b21-406d-5c4d-08dd40569570
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199



On 21/01/25 14:14, Beata Michalska wrote:
> 
> 
> For the time being, the amu_fie_cpus cpumask is being exclusively used
> by the AMU-related internals of FIE support and is guaranteed to be
> valid on every access currently made. Still the mask is not being
> invalidated on one of the error handling code paths, which leaves
> a soft spot with theoretical risk of UAF for CPUMASK_OFFSTACK cases.
> To make things sound, delay allocating said cpumask
> (for CPUMASK_OFFSTACK) avoiding otherwise nasty sanitising case failing
> to register the cpufreq policy notifications.
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

> ---
>   arch/arm64/kernel/topology.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 1a2c72f3e7f8..cb180684d10d 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -194,12 +194,19 @@ static void amu_fie_setup(const struct cpumask *cpus)
>          int cpu;
> 
>          /* We are already set since the last insmod of cpufreq driver */
> -       if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
> +       if (cpumask_available(amu_fie_cpus) &&
> +           unlikely(cpumask_subset(cpus, amu_fie_cpus)))
>                  return;
> 
> -       for_each_cpu(cpu, cpus) {
> +       for_each_cpu(cpu, cpus)
>                  if (!freq_counters_valid(cpu))
>                          return;
> +
> +       if (!cpumask_available(amu_fie_cpus) &&
> +           !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
> +               WARN_ONCE(1, "Failed to allocate FIE cpumask for CPUs[%*pbl]\n",
> +                         cpumask_pr_args(cpus));
> +               return;
>          }
> 
>          cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
> @@ -237,17 +244,8 @@ static struct notifier_block init_amu_fie_notifier = {
> 
>   static int __init init_amu_fie(void)
>   {
> -       int ret;
> -
> -       if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
> -               return -ENOMEM;
> -
> -       ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> +       return cpufreq_register_notifier(&init_amu_fie_notifier,
>                                          CPUFREQ_POLICY_NOTIFIER);
> -       if (ret)
> -               free_cpumask_var(amu_fie_cpus);
> -
> -       return ret;
>   }
>   core_initcall(init_amu_fie);
> 
> --
> 2.25.1
> 

