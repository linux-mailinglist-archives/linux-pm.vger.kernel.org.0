Return-Path: <linux-pm+bounces-21087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A383DA21BFA
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 12:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5421885E65
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221F1C5F25;
	Wed, 29 Jan 2025 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kMGPGqXJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246D1AF0C1;
	Wed, 29 Jan 2025 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149349; cv=fail; b=pRwZ1BYT4o+1YFDwnwcGcUNoCWRAHH/vDFLl6KwEKiKQq/ObmmuOjTUwZ4xoWETue60ldq1BVdqQMBM3VT/Td98WEmHdZEE/mbT0immHCkGAsHIBpD9d7MctlSPAkMmY3EMQhmKR3t+M0WDHKVv3F3SlrlFW4fByYJnG+wqqQ68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149349; c=relaxed/simple;
	bh=44xMZs2sWkbldJFsbztbzHE2SLuQLAUHuMnG26w4qJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iVAYdhDUsJm62Rvw384yHI4Hl8gMYhFkKbCKBWThvZbVNpKv4AhXVTNRJrP2yxJ85jp0LmMzbN94vtjF9EF7p0aMe/v49WAusFxbWh0ekV3w1qou15mgt/kqFuHEGNHp3PO88uYfAMrcac2thkkUGST01eaCmGOykmeUoFEx65w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kMGPGqXJ; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/r+7bSXFwy8h3IqoOZRT7Ls4Sgoaamfo2nYzy2+cmYaZnD9rDjNR32H79NY9s+dFnJJEpqHaUt39vDqc6KWyOezD3sjM8q4G7ZvBbjh+VPM/XzEuhIxarhmOetuRH5wvRiGh5uA18AecJ33ece+r3C48EggSct87N8gh6ArsLqdGElZzWb1BHFnmHDp6S5g/SsX69S1WnkmFEvk58j9DhgArHnOKvZjz/PJpwjb8ADapQIeUsXR3hPI530otMs/N3YV0wvDcTHG/nk59ox//ATgf0gg7UuA/1S4kIsXH3IgrjdrZHN8wh3WalTcwT487dzVTT0GR+aWEZ59MK0mcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZwkBGQ/8laLY1dd4HI2iZedl7zABoMjouNeF66xqM4=;
 b=N70DAFTVRUgmWBLKRTulBd3pM9A1xALjq7ziEg0ErIpdIt4uVc/V56vq7KT8nR7zkIZ+13R4+ygr7lR/Mim1vR8SGedLMtQ96toKdEq63nNVyfNEI+eS4nvkkz6EXhekaD9vcuSUHCPCjmRyDYJ80+5CUi7pEP+4xKxjJUjwi56VEmXCbFWFGu1jCnW1rR7DTzzeZUblzaET/CWdUmthYA0vxL6CD+tuXSOt1PWcoFcej8jgRny9YANYLdeVUi+DlRVO/5kQC2DxyQgX4G7BD50ibc7USzRilsJq2RO+yEm21jM1i46Xt1FdOMTfsBHlxdNvsxfZzLwXHIVU9FQycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZwkBGQ/8laLY1dd4HI2iZedl7zABoMjouNeF66xqM4=;
 b=kMGPGqXJ3DAfXgVR5qsIzAtEvrwfXbN664LXxQbirTgnGNzckc+a6UcsMxe9A13olq3x7K9Yd19z8ohWSvP0tctK7fQ/LDFASGyL2fFb6Zl8FZ63Petf5h+x5D6pVN/jV2hYgcbtGzKOnsiejYjFUhC8L2swikwAqHUXGKYMLo0crtJzMv4NvKGAdQSUWMGzT+vQCriOt5iQG2QrhETQiiP8IkVlbNIE/K54xlTPkKKFBKjt4xib01522pNYUF+dnOMyGZpjcCSViFuBSkNf6OpjL91NhTeEmi0BmPQyWXD+hJCEkP3JF2Ari54C+TeUnAU7kZLac6oa049Hcx6syQ==
Received: from BY3PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:39b::26)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 11:15:42 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2b) by BY3PR05CA0051.outlook.office365.com
 (2603:10b6:a03:39b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 11:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 11:15:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 03:15:30 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Jan
 2025 03:15:26 -0800
Message-ID: <a14a0273-6e40-44c6-b2f9-22a5bd7617f7@nvidia.com>
Date: Wed, 29 Jan 2025 16:45:23 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
To: Beata Michalska <beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <yang@os.amperecomputing.com>, <vanshikonda@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <zhanjie9@hisilicon.com>, linux-tegra
	<linux-tegra@vger.kernel.org>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-5-beata.michalska@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20250121084435.2839280-5-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d142844-4b01-4ce9-7f20-08dd405644ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXVsbzd6MjJYUURVOElCS2p6SFFxUHQ5Yk1mUmI0cytaTkM1REhENUphVlZl?=
 =?utf-8?B?WGZVUzNsZFYxaUhKUDhudDJJUEdSWGZmZmV3QTRhMlBsU29HTXFKMEpHbEhw?=
 =?utf-8?B?M29OalpDcHNhTkg2c1FtR0JuRXo1RVBWRFhmYkpGaXhFWWR5cklEZ3RLK1oy?=
 =?utf-8?B?OEwwbDBKRFR2SzNFNm1uWTN5NlE4Vll0cTMvQUt4aW11SVI4TTdQTFhpZnZu?=
 =?utf-8?B?Nitid0kxK1J1TS9GVXB5VVB0R3JZUC80cS9kZGNCUDMxd1FwcXJzVEg4d0FJ?=
 =?utf-8?B?Z0YrWVoxQ01UY1BqTWl6QWpwZy90aUFMM2wxQWc4Y1gzQ0txT0JlOHFYei9R?=
 =?utf-8?B?dkdSSHNXUFpyenk0TnNLUHV1eVFrU3BZd3NTQUUwQWpXTmlzK0M0MWRtSlZn?=
 =?utf-8?B?VjZGZzQwQTI0ODNQNDFLZXFJVTNpcys2empsdm41cndxUHE4Rm9JNWE2WUpv?=
 =?utf-8?B?WTZibW02ODlVWmFBdnhLSFVHWDdqOHFBVld4b2xWTHgvdFBBVnpLdUxxbVpy?=
 =?utf-8?B?NjErMy81SERKTHpxOFdnSVlPdTZKT2lYTmRTTkpQM2lUdXVoYTEwVDR0NEpk?=
 =?utf-8?B?S2ZFbTJpaHQ4eGR3WnA3bjJyTDRwaGlMOUlmb2RmRjlUb1R3MDVjVmxMYnBw?=
 =?utf-8?B?TkU1VGYzemNOa1RRSG9FTm04VHVTUUZ5dlVNcnE3SWowUXdCT1FsVmxNdnV3?=
 =?utf-8?B?V2xLL2l6c1l3UTlXcEVManVaV1ZaZkl4UTRuK0xoRFlXTDBRQU51emxQZWJh?=
 =?utf-8?B?WkRENCtmM0hDb2VUNXV3ZE13VWlYQ1l2djNIeHJhc1p1c2F0U1QvTjJmWjQx?=
 =?utf-8?B?c1UyaVBzOW9OZE5FQ2FsUG5mQkVEa2VNak5EbGV6cTBLOXgxMm0yRnlxTGhQ?=
 =?utf-8?B?N2VpVU1jcHhoQXpEVlhCSzRKTjlPdk9QRGllZTBCK2dTVXVZaTdRK0VjMDR6?=
 =?utf-8?B?UW1VN1dQdkJqT1M3TGRQUXRMQytJOU9HTmh4TTJzWThoY0RndUQvY0pSL1Yr?=
 =?utf-8?B?U2tEZGhGa0RvTFBmZjlrR0JrdGFtbTU5UEJGZVdJTVZJMlEyMWFkZ1VTZElw?=
 =?utf-8?B?bFh5TXJKVzNzbEFZUWZzR1FXNmZOUlVvQmY3Z2VxSVJwQi9HYnJTTVlWWHhU?=
 =?utf-8?B?VHQ3eUtxQ0t3ZUlIbVdSeUtTQnFPVTRYeTMraFBFc1R4YitPY1gwZGtFbWNN?=
 =?utf-8?B?UFF6NDlVcEt1d1NnbzkxNGdoVzU5cDlQNG5jVzl3aStYeVFtV2FWcWJEMXQz?=
 =?utf-8?B?bUxjZFdqVmhraDRnVnZPblVjQ1B0N1J3VThudm1OeDU0cWx1dVU4V1BybVR6?=
 =?utf-8?B?SGo3VjdvUVBjRHQ0Vk52L3JldElpTHJtVDUvR3dCYWo2MTVaNVZEdXRzUy9a?=
 =?utf-8?B?SE9pUHIwSGl3K0M3NmNGY0cvMmdpYmVhVVFHSjZrRlBvVHZNcWkxMXQ0RnJB?=
 =?utf-8?B?a3hKNjVvUElSQ2xtNlBCRG1XdUdLU1lnMmdLNXY4YnBKOTlXTkxvUTJWYkVo?=
 =?utf-8?B?b0FlcW56Y0pISUtqYU83d1Exa3F1eUNIcEZLQTI0RlBNQ0R1V1M3d0FrbG4v?=
 =?utf-8?B?NDdGTFptNUg2YWtGM3FqaVRsa09wNkFyN2w0OXRiVUtNYUZSbGhkSzE2aFhR?=
 =?utf-8?B?OWFzYmIxMFlhQUF6Tk9FeFdwUkdWTmMyaEt1R0JYQU5Valhhc25UZ2ZvcU55?=
 =?utf-8?B?bTNZR3IyR25oUnNWZG9PQXdyMlZTMEExUW5td0s2MTMvQ1J2aGkvNU10YkFZ?=
 =?utf-8?B?VE40WHVKWXFlNHh4TGpMbmxGZkc1TXEwekx5aFhmT2JqclNKTGlodnpscXd2?=
 =?utf-8?B?cHVweG9VTWhZNnBGOU5DTHR0OXlRVVZFRGR0RUgzRHJETGpjNHpYdXM3T2FO?=
 =?utf-8?B?ZnF4clBLWmlXc3QvbUk3Z3R4SzVGbkwzTlB6QnJZRHN1RS8ralBrMTlXMUcz?=
 =?utf-8?B?N0NDQU5VWU9xVXRTTHhqSXFmbGhnY1R4Y0ozc1RFbWNCZlMvcDNKbVRzREZ6?=
 =?utf-8?B?MUtuUlFMd0VlZXFkWUxJY1ZOQitOOTFpcmJFdUVWMkZwbkxGcHhpcXVjRXpx?=
 =?utf-8?Q?N/H2ge?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:15:41.9283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d142844-4b01-4ce9-7f20-08dd405644ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281



On 21/01/25 14:14, Beata Michalska wrote:
> 
> 
> With the Frequency Invariance Engine (FIE) being already wired up with
> sched tick and making use of relevant (core counter and constant
> counter) AMU counters, getting the average frequency for a given CPU,
> can be achieved by utilizing the frequency scale factor which reflects
> an average CPU frequency for the last tick period length.
> 
> The solution is partially based on APERF/MPERF implementation of
> arch_freq_get_on_cpu.
> 
> Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

> ---
>   arch/arm64/kernel/topology.c | 109 +++++++++++++++++++++++++++++++----
>   1 file changed, 99 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index cb180684d10d..5f5738b174c7 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -17,6 +17,7 @@
>   #include <linux/cpufreq.h>
>   #include <linux/init.h>
>   #include <linux/percpu.h>
> +#include <linux/sched/isolation.h>
> 
>   #include <asm/cpu.h>
>   #include <asm/cputype.h>
> @@ -88,18 +89,28 @@ int __init parse_acpi_topology(void)
>    * initialized.
>    */
>   static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
> -static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> -static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
>   static cpumask_var_t amu_fie_cpus;
> 
> +struct amu_cntr_sample {
> +       u64             arch_const_cycles_prev;
> +       u64             arch_core_cycles_prev;
> +       unsigned long   last_scale_update;
> +};
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct amu_cntr_sample, cpu_amu_samples);
> +
>   void update_freq_counters_refs(void)
>   {
> -       this_cpu_write(arch_core_cycles_prev, read_corecnt());
> -       this_cpu_write(arch_const_cycles_prev, read_constcnt());
> +       struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
> +
> +       amu_sample->arch_core_cycles_prev = read_corecnt();
> +       amu_sample->arch_const_cycles_prev = read_constcnt();
>   }
> 
>   static inline bool freq_counters_valid(int cpu)
>   {
> +       struct amu_cntr_sample *amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> +
>          if ((cpu >= nr_cpu_ids) || !cpumask_test_cpu(cpu, cpu_present_mask))
>                  return false;
> 
> @@ -108,8 +119,8 @@ static inline bool freq_counters_valid(int cpu)
>                  return false;
>          }
> 
> -       if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
> -                    !per_cpu(arch_core_cycles_prev, cpu))) {
> +       if (unlikely(!amu_sample->arch_const_cycles_prev ||
> +                    !amu_sample->arch_core_cycles_prev)) {
>                  pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
>                  return false;
>          }
> @@ -152,17 +163,22 @@ void freq_inv_set_max_ratio(int cpu, u64 max_rate)
> 
>   static void amu_scale_freq_tick(void)
>   {
> +       struct amu_cntr_sample *amu_sample = this_cpu_ptr(&cpu_amu_samples);
>          u64 prev_core_cnt, prev_const_cnt;
>          u64 core_cnt, const_cnt, scale;
> 
> -       prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
> -       prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
> +       prev_const_cnt = amu_sample->arch_const_cycles_prev;
> +       prev_core_cnt = amu_sample->arch_core_cycles_prev;
> 
>          update_freq_counters_refs();
> 
> -       const_cnt = this_cpu_read(arch_const_cycles_prev);
> -       core_cnt = this_cpu_read(arch_core_cycles_prev);
> +       const_cnt = amu_sample->arch_const_cycles_prev;
> +       core_cnt = amu_sample->arch_core_cycles_prev;
> 
> +       /*
> +        * This should not happen unless the AMUs have been reset and the
> +        * counter values have not been restored - unlikely
> +        */
>          if (unlikely(core_cnt <= prev_core_cnt ||
>                       const_cnt <= prev_const_cnt))
>                  return;
> @@ -182,6 +198,8 @@ static void amu_scale_freq_tick(void)
> 
>          scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
>          this_cpu_write(arch_freq_scale, (unsigned long)scale);
> +
> +       amu_sample->last_scale_update = jiffies;
>   }
> 
>   static struct scale_freq_data amu_sfd = {
> @@ -189,6 +207,77 @@ static struct scale_freq_data amu_sfd = {
>          .set_freq_scale = amu_scale_freq_tick,
>   };
> 
> +static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
> +{
> +       return cpumask_available(amu_fie_cpus) &&
> +               cpumask_test_cpu(cpu, amu_fie_cpus);
> +}
> +
> +#define AMU_SAMPLE_EXP_MS      20
> +
> +int arch_freq_get_on_cpu(int cpu)
> +{
> +       struct amu_cntr_sample *amu_sample;
> +       unsigned int start_cpu = cpu;
> +       unsigned long last_update;
> +       unsigned int freq = 0;
> +       u64 scale;
> +
> +       if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
> +               return -EOPNOTSUPP;
> +
> +retry:
> +       amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> +
> +       last_update = amu_sample->last_scale_update;
> +
> +       /*
> +        * For those CPUs that are in full dynticks mode, or those that have
> +        * not seen tick for a while, try an alternative source for the counters
> +        * (and thus freq scale), if available, for given policy: this boils
> +        * down to identifying an active cpu within the same freq domain, if any.
> +        */
> +       if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> +           time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
> +               struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +               int ref_cpu = cpu;
> +
> +               if (!policy)
> +                       return -EINVAL;
> +
> +               if (!cpumask_intersects(policy->related_cpus,
> +                                       housekeeping_cpumask(HK_TYPE_TICK))) {
> +                       cpufreq_cpu_put(policy);
> +                       return -EOPNOTSUPP;
> +               }
> +
> +
> +               do {
> +                       ref_cpu = cpumask_next_wrap(ref_cpu, policy->cpus,
> +                                                   start_cpu, false);
> +
> +               } while (ref_cpu < nr_cpu_ids && idle_cpu(ref_cpu));
> +
> +               cpufreq_cpu_put(policy);
> +
> +               if (ref_cpu >= nr_cpu_ids)
> +                       /* No alternative to pull info from */
> +                       return -EAGAIN;
> +
> +               cpu = ref_cpu;
> +               goto retry;
> +       }
> +       /*
> +        * Reversed computation to the one used to determine
> +        * the arch_freq_scale value
> +        * (see amu_scale_freq_tick for details)
> +        */
> +       scale = arch_scale_freq_capacity(cpu);
> +       freq = scale * arch_scale_freq_ref(cpu);
> +       freq >>= SCHED_CAPACITY_SHIFT;
> +       return freq;
> +}
> +
>   static void amu_fie_setup(const struct cpumask *cpus)
>   {
>          int cpu;
> --
> 2.25.1
> 

