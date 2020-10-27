Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6529A488
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 07:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506372AbgJ0GRk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 02:17:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12529 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506370AbgJ0GQo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 02:16:44 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f97bb500001>; Mon, 26 Oct 2020 23:16:48 -0700
Received: from [10.41.23.128] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 06:16:35 +0000
Subject: Re: [PATCH v3] cpufreq: tegra194: get consistent cpuinfo_cur_freq
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <sudeep.holla@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <ksitaraman@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <1602668171-30104-1-git-send-email-sumitg@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <c56983dc-dc45-3e8c-a67c-14d7d09464ae@nvidia.com>
Date:   Tue, 27 Oct 2020 11:46:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1602668171-30104-1-git-send-email-sumitg@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603779408; bh=PSwb9HY4aIa9iuFeUy5QFj8uQLyn9S18ol0gggwXYSg=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=NQPLmfKYlD+gOsPyciOmtSmQjlaUg2BCr/+H+HY7EVf3r0XFJAvDepq0Cux0+eJsy
         rMDKxVSgskB5qkD+JyXr8f5FRxE1qB2w7Z7u6EcpbRsMxK2xCOR5VKQlzXvU3zQN9Q
         UxJczm+fdWxKORoQS7Yxzfji9smoYOm1mIhVw0EkTzQOraL/bnE2DwTqyLKKD0g9Go
         kW6clUd6G5CgkHBBmmxRXUK2N73PueiUz3s5elHA8aL15+9rF0lhFtw147I3hmhph6
         7oJuv9HjuL9cnvBpFt8xZdswL71vVlXtl9wzUCOCvgQRNhC4Ltj5BGEwyi5BDXaDpP
         fewBa7AAjUCrg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ping.

> 
> Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
> and keeps changing slightly. This change returns a consistent value
> from freq_table. If the reconstructed frequency has acceptable delta
> from the last written value, then return the frequency corresponding
> to the last written ndiv value from freq_table. Otherwise, print a
> warning and return the reconstructed freq.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> 
> Sending only this patch as other patch not required after the change
> to convert 'pr_warn' to 'pr_info' in cpufreq core for unlisted freq.
> Changelog
> v1[2] -> v3:
> - Removed unwanted checks for cpu_online and max cluster number
> - Used WARN_ON_ONCE to avoid print flooding.
> 
> v1[1] -> v2:
> - Minor changes to improve comments and reduce debug prints.
> - Get freq table from cluster specific data instead of policy.
> 
> [2] https://marc.info/?l=linux-tegra&m=160216218511280&w=2
> [1] https://marc.info/?l=linux-arm-kernel&m=160028821117535&w=2
> 
>   drivers/cpufreq/tegra194-cpufreq.c | 62 ++++++++++++++++++++++++++++++++------
>   1 file changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index e1d931c..7901587 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -180,9 +180,61 @@ static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
>          return (rate_mhz * KHZ); /* in KHz */
>   }
> 
> +static void get_cpu_ndiv(void *ndiv)
> +{
> +       u64 ndiv_val;
> +
> +       asm volatile("mrs %0, s3_0_c15_c0_4" : "=r" (ndiv_val) : );
> +
> +       *(u64 *)ndiv = ndiv_val;
> +}
> +
> +static void set_cpu_ndiv(void *data)
> +{
> +       struct cpufreq_frequency_table *tbl = data;
> +       u64 ndiv_val = (u64)tbl->driver_data;
> +
> +       asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
> +}
> +
>   static unsigned int tegra194_get_speed(u32 cpu)
>   {
> -       return tegra194_get_speed_common(cpu, US_DELAY);
> +       struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
> +       struct cpufreq_frequency_table *pos;
> +       unsigned int rate;
> +       u64 ndiv;
> +       int ret;
> +       u32 cl;
> +
> +       smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
> +
> +       /* reconstruct actual cpu freq using counters */
> +       rate = tegra194_get_speed_common(cpu, US_DELAY);
> +
> +       /* get last written ndiv value */
> +       ret = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
> +       if (WARN_ON_ONCE(ret))
> +               return rate;
> +
> +       /*
> +        * If the reconstructed frequency has acceptable delta from
> +        * the last written value, then return freq corresponding
> +        * to the last written ndiv value from freq_table. This is
> +        * done to return consistent value.
> +        */
> +       cpufreq_for_each_valid_entry(pos, data->tables[cl]) {
> +               if (pos->driver_data != ndiv)
> +                       continue;
> +
> +               if (abs(pos->frequency - rate) > 115200) {
> +                       pr_warn("cpufreq: cpu%d,cur:%u,set:%u,set ndiv:%llu\n",
> +                               cpu, rate, pos->frequency, ndiv);
> +               } else {
> +                       rate = pos->frequency;
> +               }
> +               break;
> +       }
> +       return rate;
>   }
> 
>   static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
> @@ -209,14 +261,6 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>          return 0;
>   }
> 
> -static void set_cpu_ndiv(void *data)
> -{
> -       struct cpufreq_frequency_table *tbl = data;
> -       u64 ndiv_val = (u64)tbl->driver_data;
> -
> -       asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
> -}
> -
>   static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>                                         unsigned int index)
>   {
> --
> 2.7.4
> 
