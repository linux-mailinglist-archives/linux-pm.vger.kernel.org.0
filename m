Return-Path: <linux-pm+bounces-14368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD95897AFFD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 14:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27061C21CA8
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9257316A930;
	Tue, 17 Sep 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHNyVbsA"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3EB43150;
	Tue, 17 Sep 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575096; cv=fail; b=ShDDJqx4JLu0MgRzD2fe55UEhUEvFhuH6KCut6yJ4k9kL5uZpq0Vf7RekJW4g9CoNxmklNCEhx4PFye+pqCSYL7miRNr/VoYDvjgsagRkg3HeEkT1HIfnzcs3I85IdJd2mcG/bHPvxROELiv9KglvWE8VwbM4DbeOBnyBleAW3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575096; c=relaxed/simple;
	bh=MdrAAPL4WCJMCFWqUzSN+59YTcokf3AOVFF3iqP4MSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QPwYirJZKjuFnXtn63IqBPE3gBDN2e8VhDSrFI0rtQU2irbI5vXO782/ooExgwzm8X7DLf4H+LkjfpnShgTDqzSdg/RfoTpeFOeiXG6z5sjIRxV6RxRqGDzbUmYsVpzyb5Dz2mO72oKEV/AAMkG65eoKOg/P8SuDQ/AXffhqWHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHNyVbsA; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9bFP9hpzdFIOON+4QhSV3N5veIdEdaJY08laTHssl+6aBIW51pUgYnST0EuJTrAjOe6vMdE/g88IogrjIYQcPJWz+VJYI1GUWMy6XPyo73XGAi6sWGsfysrI0Kt/FQD9Ncd86Q+5TmLlmf5CidLLSE2X2EL0uTcdCOWYzfLeN2sFFYMMrcypomfZ5QF9NyxYYxKr4F2uSjOTVbWaetVHR1g/Qixp5ug4uOj2KPop25sVMYwpxloCqxGi8XcJh8xQR2/i2yglcJNSWsC2V0pmWPeXZXAAq/K4COfe44Z2mwjO90uhxEsXf8f8Uau/UesEzgTtDmRzdoyuQYp9PECnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJrPlqVW1cxoQgcWpKANqQS+KDCG8uN92o5fzJYpxNo=;
 b=nosjpWNkb9BTizvwoYHL0DrGE2G4ShxwCQVIfi1jo5eJqN4zKyCUnmjzkcpEzn8oZbts1jIP/C71krMn0UM0B4Qd5UeyxkutmyGg5YM14l3+YnZz6t5FfMQJ4LkUB1W3mijR4C9dTKppT9HdmFDk77D/hN/hOpqz0NgyLQR/B7sgVJk0oGwVmNa2YOagi02tCSL3ewTGWYR8VOC/qEsUmdMYCwK83uO3AfolyDdUt0x9wuCVukb4JmHCvEVUKM4qVMeS+lcykpjHHLESfyEpk4jBGCv85XnxzSejsVkSAx1L7M+mFiiOWW26jxu/my70gyISaef88VooOSn2Obwmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJrPlqVW1cxoQgcWpKANqQS+KDCG8uN92o5fzJYpxNo=;
 b=mHNyVbsAWZFW1u9lEwXSSqIzEN0PblR01BJB+PG8nVxte9+uiKDyXZ/hd87TuW3uXiORVWZTy65TBlsfaav0lEsS17J5itDwEVugBuGeT/qRPsqx7bIyJLDI8nrBLf2SyZWbg26yBmFej/Na66kFwwyUzsofeycqf9f/6vKl8RlrGrIgCGE5DV9tQ1wz7qJf0iFnla/TrA3FH2TuLO9BRxrceWjPSkZM+uhLSqCCS48SJA7tezrioW3FA8T5rRH1+0BsdHgjBSXOsWMRJSr9Rq44doiKtj+kbw3coabGyN8/Y8nF7H3M6A+DK+B0DDaNSon5y4N87GKCTb/Tfb5NkA==
Received: from SA1PR05CA0019.namprd05.prod.outlook.com (2603:10b6:806:2d2::26)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 12:11:30 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::9b) by SA1PR05CA0019.outlook.office365.com
 (2603:10b6:806:2d2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.14 via Frontend
 Transport; Tue, 17 Sep 2024 12:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 17 Sep 2024 12:11:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Sep
 2024 05:11:16 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Sep
 2024 05:11:12 -0700
Message-ID: <aa254516-968e-4665-bb5b-981c296ffc35@nvidia.com>
Date: Tue, 17 Sep 2024 17:41:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] arm64: Provide an AMU-based version of
 arch_freq_avg_get_on_cpu
To: Beata Michalska <beata.michalska@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<ionela.voinescu@arm.com>, <sudeep.holla@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <yang@os.amperecomputing.com>, <vanshikonda@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <zhanjie9@hisilicon.com>, linux-tegra
	<linux-tegra@vger.kernel.org>, Bibek Basu <bbasu@nvidia.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-4-beata.michalska@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20240913132944.1880703-4-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 119b63a1-c581-4d86-445c-08dcd711dcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emdUVWcrMDk1SDJOT29peVdMeGwrNHVHN3JWSXZ4emczYXk5L3FZVHJPSllz?=
 =?utf-8?B?TS85elJzL1pGc0kxZEROV0tOYnh0eTB4Zk8xV2ZUU21HUVgwcEkzU2pTMTg5?=
 =?utf-8?B?eGFxZ2VtTVkvU3BKRHVvbCtUT0Rlcm9CSThaYWVHVFZ5ek80d09YSXVCMTJW?=
 =?utf-8?B?M2NvL3ZKQ21WemNZckhvTVhIbThFVXc5U1pLOFVkMXdCMnpTd0N1TlFBbEdI?=
 =?utf-8?B?SFlyMnhqVGVCV1JUWGtTSHFmdnc0ekNBYUtYMFdzM3hjeTNXZ3hsMkM1aHRB?=
 =?utf-8?B?aEF0eU1Yell0WjBDTlliM2s3dWhZVldKNzdUV1lBRVRNYlVYaTc2eGpiN1gr?=
 =?utf-8?B?SFVKRmNtOUkxQVpzOGRMQTV4ZkJkaFJKeUdBdXBRdmMveFh5eTBKZmVKWXVE?=
 =?utf-8?B?eG1IKzNreDFTb0lVRnVrN1NjVlhUUEVYbkN5RzJhMTcvdm9tTEJlQlBWS3lh?=
 =?utf-8?B?M0Q1SUNXcjE5R1ppY2ZleDVuQ1R1NUpITG1TNEgvVHZlc2JBT1Z0ZUxUdFls?=
 =?utf-8?B?ZHMxVEJjVUVUWWZFWFdJekZiZlhTLzk5aHROdkZ6MUhrUjluU1poWVp3SDF6?=
 =?utf-8?B?bzNxU0xzeFRUNzR5NFBMbmlMc1NiUnNZanJ2YkNMZXQrTVhsZUg5RVlSdW9o?=
 =?utf-8?B?UmlTTXIzaEFCYW9FWXJVWDlSU0J2YnllTDl4WDZVUUN5UlQxVGY5aWtpMGo3?=
 =?utf-8?B?WStnSnh2V3EvOUthbzNsNk1zMlFZOEd2Z2pjY0lZckZRU1ludkc1enZ2b0oy?=
 =?utf-8?B?eU9md3EvQktzeTRoUEdyZXdtS3B6YkZBbXVpNEE0Uk1VcDhFbFdSaC9ZcFFE?=
 =?utf-8?B?MWYyeWV6V252ZWpKdkk4dlk4MGpGSWRUUUFjUm9MZ2VWZnZQTlRlVWpsZWZS?=
 =?utf-8?B?cU55UFFQNThaWHZuYjNvelBiMEJSRG9GK3pQcU1sTFNOcEt6eURKbmxvS2F3?=
 =?utf-8?B?Z1dMUDVBTWRPR014akFTSUpGUWhHNkxibHR1MzdsY3J3V3N3M0lua2pwallS?=
 =?utf-8?B?bDA1R2VLdVBsUXJjMUtXdDBacDR5TXlOMjVudENZd2JxQXZYYnJ2SkNYUEJk?=
 =?utf-8?B?UTdPS3dmY3VGblpJN3V6WEpLMnRYU0NqaVRNOHJHc0hiNHR5YzhpSStSTEhF?=
 =?utf-8?B?ZllheG5yQkhoVWxZUEREQWJIOHpnV0gxUFJWcmx4aW9mNytSanc0MU1ubUpk?=
 =?utf-8?B?Qi96N1hKbCtOZ2ozYWFjUEdvV3FOUWtBMjNEekY3SXVNZzRad1QveGZ5Q2R6?=
 =?utf-8?B?bTFKZ2Rtb0dackdQeE1vdDZ4cGpTMWd2Sm1icU0zT3R5ZnpORGVHT0RwM01v?=
 =?utf-8?B?clpzQldsdVZxbzFGeGs5eWVjZGpodEpyOEg4TzRFaG8rZ2N5MkRYdEk3NHFQ?=
 =?utf-8?B?Kzh1QkVPM3ZEa05lY1RSZ3NJcVRYRzdCb2dNM3hucnk0Z2lhYmY1TFFyZkIy?=
 =?utf-8?B?UlUxZmlreVNqSEZ4UXhBZW9DY3JFYm5TQnJ3QU4ycHpKeUtMRy9Wa3NhTUxY?=
 =?utf-8?B?Vi9EWGdETVgxelljSjN0MGlvTWJNY0V3UHBNbHVZVkJaWmhmMThmUzRZbmxR?=
 =?utf-8?B?Q3dBdUgrNUU3WnpaeFVJQVIyKzk1UUMxMmRrSFhWSnlYaXdhSXg3YTlHWGNB?=
 =?utf-8?B?dy8wNmphZUM5VVlXdzBOeXovUjFjTXB6YTN6TFYyb0llUFA4T2dFaXpqR3N5?=
 =?utf-8?B?WFBvTEY1cXVMZXE0MFczaHExOEgzclZJdktxNmxOaHAwcTZBL1VNd2NxNXha?=
 =?utf-8?B?Wm9PSkR1STlRZFc4NzNFV0h6MHR1ak1rZU9KV0pjUkZWQkI5WWRzeHhwYmx6?=
 =?utf-8?B?b25teHhLUXFxNnJGYVVwRGpoK21wczZIWGpiQW9Rc2ZFcFFGWXc3SGlKNU05?=
 =?utf-8?B?Z1FRUGJESjg0M1BnR2JoZlNDdUdiUXA4Q3dycFl0R1FVTW9wcldBcXNzU1pu?=
 =?utf-8?B?WU1adWkvTzdxMW9UMjllNlU2UEFQUDRTeE8zSkJjM0xidUJxc2hXbndER1lK?=
 =?utf-8?B?UGY4d2lyTmdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 12:11:30.0857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119b63a1-c581-4d86-445c-08dcd711dcfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

Hi Beata,

Thank you for the patches.

On 13/09/24 18:59, Beata Michalska wrote:
> External email: Use caution opening links or attachments
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
> ---
>   arch/arm64/kernel/topology.c | 109 +++++++++++++++++++++++++++++++----
>   1 file changed, 99 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index cb180684d10d..22e510733336 100644
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
> +int arch_freq_avg_get_on_cpu(int cpu)
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
> +        * For those CPUs that are in full dynticks mode, and those that have
'or those' to match with if condition?

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
> +                       return 0;
> +

We can skip the rest of code if policy has a single cpu. AFAIR, one of 
the previous versions had similar check.

       if (!policy_is_shared(policy)) {
               cpufreq_cpu_put(policy);
               goto freq_comput;
       }

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
> +                       return 0;
> +

The 'cpuinfo_avg_freq' node gives 'unknown' value for single CPU per 
policy as 'ref_cpu' increments to 'nr_cpu_ids'. We can use the same CPU 
instead of returning zero if no alternative CPU.

   # cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_avg_freq
   <unknown>

   ----
       if (ref_cpu >= nr_cpu_ids)
           /* Use same CPU if no alternative to pull info from */
           goto freq_comput;

     ..
   freq_comput:
     scale = arch_scale_freq_capacity(cpu);
     freq = scale * arch_scale_freq_ref(cpu);
   ----

Thank you,
Sumit Gupta

P.S. Will be on afk for next 2 weeks with no access to email. Please 
expect a delay in response.

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

