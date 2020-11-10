Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509482AD55E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 12:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKJLgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 06:36:19 -0500
Received: from foss.arm.com ([217.140.110.172]:54418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJLgS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 06:36:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8721396;
        Tue, 10 Nov 2020 03:36:17 -0800 (PST)
Received: from [10.57.21.178] (unknown [10.57.21.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 990B03F6CF;
        Tue, 10 Nov 2020 03:36:15 -0800 (PST)
Subject: Re: [PATCH] cpufreq: stats: Switch to ktime and msec instead of
 jiffies and usertime
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5860b346-4eab-4018-87e4-a6313115fa2d@arm.com>
Date:   Tue, 10 Nov 2020 11:36:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/10/20 11:07 AM, Viresh Kumar wrote:
> The cpufreq and thermal core, both provide sysfs statistics to help
> userspace learn about the behavior of frequencies and cooling states.
> 
> This is how they look:
> 
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:208000 11
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:432000 147
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:729000 1600
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:960000 879
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 399
> 
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state0 4097
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state1 8932
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state2 15868
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state3 1384
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state4 103
> 
> Here, state0 of thermal corresponds to the highest frequency of the CPU,
> i.e. 1200000 and state4 to the lowest one.
> 
> While both of these try to show similar kind of data (which can still be
> very much different from each other), the values looked different (by a
> factor of 10, i.e. thermal's time_in_state is almost 10 times that of
> cpufreq time_in_state).
> 
> This comes from the fact that cpufreq core displays the time in usertime
> units (10 ms).
> 
> It would be better if both the frameworks displayed times in the same
> unit as the users may need to correlate between them and different
> scales just make it awkward. And the choice of thermal core for that
> (msec) seems to be a better choice as it is easier to read.
> 
> The thermal core also does the stats calculations using ktime, which is
> much more accurate as compared to jiffies used by cpufreq core.
> 
> This patch updates the cpufreq core to use ktime for the internal
> calculations and changes the units of time_in_state to msec.
> 
> The results look like this after this commit:
> 
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:208000 13
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:432000 790
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:729000 12492
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:960000 13259
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 3830
> 
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state0 3888
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state1 13432
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state2 12336
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state3 740
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state4 0
> 
> FWIW, tools/power/cpupower/ does consume the time_in_state values from
> the sysfs files but it is independent of the unit of the time and didn't
> require an update.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   Documentation/cpu-freq/cpufreq-stats.rst |  5 +--
>   drivers/cpufreq/cpufreq_stats.c          | 47 +++++++++++++-----------
>   2 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/cpufreq-stats.rst b/Documentation/cpu-freq/cpufreq-stats.rst
> index 9ad695b1c7db..9f94012a882f 100644
> --- a/Documentation/cpu-freq/cpufreq-stats.rst
> +++ b/Documentation/cpu-freq/cpufreq-stats.rst
> @@ -64,9 +64,8 @@ need for a reboot.
>   
>   This gives the amount of time spent in each of the frequencies supported by
>   this CPU. The cat output will have "<frequency> <time>" pair in each line, which
> -will mean this CPU spent <time> usertime units of time at <frequency>. Output
> -will have one line for each of the supported frequencies. usertime units here
> -is 10mS (similar to other time exported in /proc).
> +will mean this CPU spent <time> msec of time at <frequency>. Output will have
> +one line for each of the supported frequencies.
>   
>   ::
>   
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 6cd5c8ab5d49..e054ada291e7 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -14,35 +14,38 @@
>   
>   struct cpufreq_stats {
>   	unsigned int total_trans;
> -	unsigned long long last_time;
> +	ktime_t last_time;
>   	unsigned int max_state;
>   	unsigned int state_num;
>   	unsigned int last_index;
> -	u64 *time_in_state;
> +	ktime_t *time_in_state;
>   	unsigned int *freq_table;
>   	unsigned int *trans_table;
>   
>   	/* Deferred reset */
>   	unsigned int reset_pending;
> -	unsigned long long reset_time;
> +	ktime_t reset_time;
>   };
>   
> -static void cpufreq_stats_update(struct cpufreq_stats *stats,
> -				 unsigned long long time)
> +static void cpufreq_stats_update(struct cpufreq_stats *stats, ktime_t time)
>   {
> -	unsigned long long cur_time = get_jiffies_64();
> +	ktime_t cur_time = ktime_get(), delta;
>   
> -	stats->time_in_state[stats->last_index] += cur_time - time;
> +	delta = ktime_sub(cur_time, time);
> +	stats->time_in_state[stats->last_index] =
> +		ktime_add(stats->time_in_state[stats->last_index], delta);
>   	stats->last_time = cur_time;
>   }
>   
>   static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
>   {
> -	unsigned int count = stats->max_state;
> +	unsigned int count = stats->max_state, i;
> +
> +	for (i = 0; i < count; i++)
> +		stats->time_in_state[i] = ktime_set(0, 0);
>   
> -	memset(stats->time_in_state, 0, count * sizeof(u64));
>   	memset(stats->trans_table, 0, count * count * sizeof(int));
> -	stats->last_time = get_jiffies_64();
> +	stats->last_time = ktime_get();
>   	stats->total_trans = 0;
>   
>   	/* Adjust for the time elapsed since reset was requested */
> @@ -70,7 +73,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>   {
>   	struct cpufreq_stats *stats = policy->stats;
>   	bool pending = READ_ONCE(stats->reset_pending);
> -	unsigned long long time;
> +	ktime_t time, now = ktime_get(), delta;
>   	ssize_t len = 0;
>   	int i;
>   
> @@ -82,18 +85,20 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>   				 * before the reset_pending read above.
>   				 */
>   				smp_rmb();
> -				time = get_jiffies_64() - READ_ONCE(stats->reset_time);
> +				time = ktime_sub(now, READ_ONCE(stats->reset_time));
>   			} else {
> -				time = 0;
> +				time = ktime_set(0, 0);;
>   			}
>   		} else {
>   			time = stats->time_in_state[i];
> -			if (i == stats->last_index)
> -				time += get_jiffies_64() - stats->last_time;
> +			if (i == stats->last_index) {
> +				delta = ktime_sub(now, stats->last_time);
> +				time = ktime_add(delta, time);
> +			}
>   		}
>   
>   		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
> -			       jiffies_64_to_clock_t(time));
> +			       ktime_to_ms(time));
>   	}
>   	return len;
>   }
> @@ -109,7 +114,7 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
>   	 * Defer resetting of stats to cpufreq_stats_record_transition() to
>   	 * avoid races.
>   	 */
> -	WRITE_ONCE(stats->reset_time, get_jiffies_64());
> +	WRITE_ONCE(stats->reset_time, ktime_get());
>   	/*
>   	 * The memory barrier below is to prevent the readers of reset_time from
>   	 * seeing a stale or partially updated value.
> @@ -228,9 +233,9 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>   	if (!stats)
>   		return;
>   
> -	alloc_size = count * sizeof(int) + count * sizeof(u64);
> -
> -	alloc_size += count * count * sizeof(int);
> +	alloc_size = count * sizeof(*stats->time_in_state);
> +	alloc_size += count * sizeof(*stats->freq_table);
> +	alloc_size += count * count * sizeof(*stats->trans_table);
>   
>   	/* Allocate memory for time_in_state/freq_table/trans_table in one go */
>   	stats->time_in_state = kzalloc(alloc_size, GFP_KERNEL);
> @@ -249,7 +254,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>   			stats->freq_table[i++] = pos->frequency;
>   
>   	stats->state_num = i;
> -	stats->last_time = get_jiffies_64();
> +	stats->last_time = ktime_get();
>   	stats->last_index = freq_table_get_index(stats, policy->cur);
>   
>   	policy->stats = stats;
> 

I am not sure if these ktime_get() are not too heavy in the code path
visited by the scheduler.

How about local_clock()?
It's used in ./drivers/cpuidle/cpuidle.c to do similar accounting.

Regards,
Lukasz
