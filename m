Return-Path: <linux-pm+bounces-22301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5B8A39C5F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF67A2980
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279624635A;
	Tue, 18 Feb 2025 12:41:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960D24419A
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882518; cv=none; b=k2pNukXKwub9Cje3S+9r1gUUzn9vkQ0TBv+QATrDdwQx6v3zthcU61cO52yh+61tsAXdaEvZPqMx8ACx8HB/gw+49p2oowsnbWyEoVWlAT0NnJWQ51cHPYeibLrE30YRRSeo/aY40SzewLaKKn2loczMgtT3sLJ9GTjc8s1qq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882518; c=relaxed/simple;
	bh=qP88DMrX7m2ic6MbVfJoVMyzekSVi4U0iJ/ob7sRHng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W/RHGB0oRODqsSf971wJYz2IvaI40Eafq7jEFIABNTueMXzWPD9vhI4TQecQ17LLTLEY/0C79XFFvSJkgPk7ikOIT/P//uzSN+1uCiShmKEXKag2lvb7GonatgmudhP4EUVMxVB8asQXNvWunvYLwCiobdkX2aGixdgCSnq2uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YxzdJ32TNzMrc8;
	Tue, 18 Feb 2025 20:40:20 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 1684A1400D6;
	Tue, 18 Feb 2025 20:41:50 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Feb
 2025 20:41:49 +0800
Message-ID: <3965c9ee-c136-bdf2-8384-ed361fc601c1@hisilicon.com>
Date: Tue, 18 Feb 2025 20:41:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3] cpufreq: governor: Fix negative 'idle_time' handling
 in dbs_update()
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <yu.c.chen@intel.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <wanghuiqiang@huawei.com>, <fanghao11@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20250213035510.2402076-1-zhanjie9@hisilicon.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250213035510.2402076-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo100006.china.huawei.com (7.202.195.47)

A kindly ping on this patch.

Thanks,
Jie

On 13/02/2025 11:55, Jie Zhan wrote:
> We observed an issue that the cpu frequency can't raise up with a 100% cpu
> load when NOHZ is off and the 'conservative' governor is selected.
> 
> 'idle_time' can be negative if it's obtained from get_cpu_idle_time_jiffy()
> when NOHZ is off.  This was found and explained in commit 9485e4ca0b48
> ("cpufreq: governor: Fix handling of special cases in dbs_update()").
> 
> However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detection
> logic in load calculation") introduced a comparison between 'idle_time' and
> 'samling_rate' to detect a long idle interval.  While 'idle_time' is
> converted to int before comparison, it's actually promoted to unsigned
> again when compared with an unsigned 'sampling_rate'.  Hence, this leads to
> wrong idle interval detection when it's in fact 100% busy and sets
> policy_dbs->idle_periods to a very large value.  'conservative' adjusts the
> frequency to minimum because of the large 'idle_periods', such that the
> frequency can't raise up.  'Ondemand' doesn't use policy_dbs->idle_periods
> so it fortunately avoids the issue.
> 
> Correct negative 'idle_time' to 0 before any use of it in dbs_update().
> 
> Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic in load calculation")
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3:
> - Remove ternary operators.
> 
> v2:
> - Avoid type conversion, compare current and previous idle time before
>   obtaining 'idle_time'.
> - Update the explanation in comments.
> 
> Discussions:
> v2: https://lore.kernel.org/linux-pm/20250212081438.1294503-1-zhanjie9@hisilicon.com/
> v1: https://lore.kernel.org/linux-pm/20250210130659.3533182-1-zhanjie9@hisilicon.com/
> ---
>  drivers/cpufreq/cpufreq_governor.c | 45 +++++++++++++++---------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index af44ee6a6430..1a7fcaf39cc9 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -145,7 +145,23 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  		time_elapsed = update_time - j_cdbs->prev_update_time;
>  		j_cdbs->prev_update_time = update_time;
>  
> -		idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
> +		/*
> +		 * cur_idle_time could be smaller than j_cdbs->prev_cpu_idle if
> +		 * it's obtained from get_cpu_idle_time_jiffy() when NOHZ is
> +		 * off, where idle_time is calculated by the difference between
> +		 * time elapsed in jiffies and "busy time" obtained from CPU
> +		 * statistics.  If a CPU is 100% busy, the time elapsed and busy
> +		 * time should grow with the same amount in two consecutive
> +		 * samples, but in practice there could be a tiny difference,
> +		 * making the accumulated idle time decrease sometimes.  Hence,
> +		 * in this case, idle_time should be regarded as 0 in order to
> +		 * make the further process correct.
> +		 */
> +		if (cur_idle_time > j_cdbs->prev_cpu_idle)
> +			idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
> +		else
> +			idle_time = 0;
> +
>  		j_cdbs->prev_cpu_idle = cur_idle_time;
>  
>  		if (ignore_nice) {
> @@ -162,7 +178,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  			 * calls, so the previous load value can be used then.
>  			 */
>  			load = j_cdbs->prev_load;
> -		} else if (unlikely((int)idle_time > 2 * sampling_rate &&
> +		} else if (unlikely(idle_time > 2 * sampling_rate &&
>  				    j_cdbs->prev_load)) {
>  			/*
>  			 * If the CPU had gone completely idle and a task has
> @@ -189,30 +205,15 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  			load = j_cdbs->prev_load;
>  			j_cdbs->prev_load = 0;
>  		} else {
> -			if (time_elapsed >= idle_time) {
> +			if (time_elapsed > idle_time)
>  				load = 100 * (time_elapsed - idle_time) / time_elapsed;
> -			} else {
> -				/*
> -				 * That can happen if idle_time is returned by
> -				 * get_cpu_idle_time_jiffy().  In that case
> -				 * idle_time is roughly equal to the difference
> -				 * between time_elapsed and "busy time" obtained
> -				 * from CPU statistics.  Then, the "busy time"
> -				 * can end up being greater than time_elapsed
> -				 * (for example, if jiffies_64 and the CPU
> -				 * statistics are updated by different CPUs),
> -				 * so idle_time may in fact be negative.  That
> -				 * means, though, that the CPU was busy all
> -				 * the time (on the rough average) during the
> -				 * last sampling interval and 100 can be
> -				 * returned as the load.
> -				 */
> -				load = (int)idle_time < 0 ? 100 : 0;
> -			}
> +			else
> +				load = 0;
> +
>  			j_cdbs->prev_load = load;
>  		}
>  
> -		if (unlikely((int)idle_time > 2 * sampling_rate)) {
> +		if (unlikely(idle_time > 2 * sampling_rate)) {
>  			unsigned int periods = idle_time / sampling_rate;
>  
>  			if (periods < idle_periods)

