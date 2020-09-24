Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66F2276F2E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIXLAK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 07:00:10 -0400
Received: from foss.arm.com ([217.140.110.172]:42042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgIXLAH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 07:00:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6224F113E;
        Thu, 24 Sep 2020 04:00:06 -0700 (PDT)
Received: from [10.57.51.181] (unknown [10.57.51.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 821473F73B;
        Thu, 24 Sep 2020 04:00:04 -0700 (PDT)
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
 <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com>
 <a4c5a6b9-10f8-34f8-f01d-8b373214d173@arm.com>
 <CAJZ5v0iFjzqTKTPFF5hB5C0TYSQn2rxL_6099gqUwoTARKRnZA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ae5771c8-6297-e447-4449-e39ae2ea5a0e@arm.com>
Date:   Thu, 24 Sep 2020 12:00:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iFjzqTKTPFF5hB5C0TYSQn2rxL_6099gqUwoTARKRnZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/24/20 11:24 AM, Rafael J. Wysocki wrote:
> On Thu, Sep 24, 2020 at 11:25 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 9/23/20 2:48 PM, Rafael J. Wysocki wrote:
>>> On Wed, Sep 16, 2020 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>
>>>> In order to prepare for lock-less stats update, add support to defer any
>>>> updates to it until cpufreq_stats_record_transition() is called.
>>>
>>> This is a bit devoid of details.
>>>
>>> I guess you mean reset in particular, but that's not clear from the above.
>>>
>>> Also, it would be useful to describe the design somewhat.
>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>    drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
>>>>    1 file changed, 56 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
>>>> index 94d959a8e954..3e7eee29ee86 100644
>>>> --- a/drivers/cpufreq/cpufreq_stats.c
>>>> +++ b/drivers/cpufreq/cpufreq_stats.c
>>>> @@ -22,17 +22,22 @@ struct cpufreq_stats {
>>>>           spinlock_t lock;
>>>>           unsigned int *freq_table;
>>>>           unsigned int *trans_table;
>>>> +
>>>> +       /* Deferred reset */
>>>> +       unsigned int reset_pending;
>>>> +       unsigned long long reset_time;
>>>>    };
>>>>
>>>> -static void cpufreq_stats_update(struct cpufreq_stats *stats)
>>>> +static void cpufreq_stats_update(struct cpufreq_stats *stats,
>>>> +                                unsigned long long time)
>>>>    {
>>>>           unsigned long long cur_time = get_jiffies_64();
>>>>
>>>> -       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
>>>> +       stats->time_in_state[stats->last_index] += cur_time - time;
>>>>           stats->last_time = cur_time;
>>>>    }
>>>>
>>>> -static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
>>>> +static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
>>>>    {
>>>>           unsigned int count = stats->max_state;
>>>>
>>>> @@ -41,42 +46,67 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
>>>>           memset(stats->trans_table, 0, count * count * sizeof(int));
>>>>           stats->last_time = get_jiffies_64();
>>>>           stats->total_trans = 0;
>>>> +
>>>> +       /* Adjust for the time elapsed since reset was requested */
>>>> +       WRITE_ONCE(stats->reset_pending, 0);
>>>
>>> What if this runs in parallel with store_reset()?
>>>
>>> The latter may update reset_pending to 1 before the below runs.
>>> Conversely, this may clear reset_pending right after store_reset() has
>>> set it to 1, but before it manages to set reset_time.  Is that not a
>>> problem?
>>
>> I wonder if we could just drop the reset feature. Is there a tool
>> which uses this file? The 'reset' sysfs would probably have to stay
>> forever, but an empty implementation is not an option?
> 
> Well, having an empty sysfs attr would be a bit ugly, but the
> implementation of it could be simplified.
> 
>> The documentation states:
>> 'This can be useful for evaluating system behaviour under different
>> governors without the need for a reboot.'
>> With the scenario of fast-switch this resetting complicates the
>> implementation and the justification of having it just for experiments
>> avoiding reboot is IMO weak. The real production code would have to pay
>> extra cycles every time. Also, we would probably not experiment with
>> cpufreq different governors, since the SchedUtil is considered the best
>> option.
> 
> It would still be good to have a way to test it against the other
> available options, though.
> 

Experimenting with different governors would still be possible, just
the user-space would have to take a snapshot of the stats when switching
to a new governor. Then the values presented in the stats would just
need to be calculated in this user tool against the snapshot.

The resetting is also not that bad, since nowadays more components
maintain some kind of local statistics/history (scheduler, thermal).
I would recommend to reset the whole system and repeat the same tests
with different governor, just to be sure that everything starts from
similar state (utilization, temperature, other devfreq devices
frequencies etc).


