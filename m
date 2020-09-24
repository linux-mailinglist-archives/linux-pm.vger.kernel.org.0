Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A2277648
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgIXQKb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 12:10:31 -0400
Received: from foss.arm.com ([217.140.110.172]:50086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgIXQKb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 12:10:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28D881396;
        Thu, 24 Sep 2020 09:10:30 -0700 (PDT)
Received: from [10.57.51.181] (unknown [10.57.51.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AC1B3F718;
        Thu, 24 Sep 2020 09:10:28 -0700 (PDT)
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
 <ae5771c8-6297-e447-4449-e39ae2ea5a0e@arm.com>
 <CAJZ5v0hkBnU_W-ZXHTfppu9pVWnQcJHho7DQPi7N7yeLOt5cgg@mail.gmail.com>
 <20200924123921.iiaqw2ufe2utnjtg@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f57626de-6021-e87d-63ab-33ccc46a2900@arm.com>
Date:   Thu, 24 Sep 2020 17:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200924123921.iiaqw2ufe2utnjtg@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/24/20 1:39 PM, Viresh Kumar wrote:
> On 24-09-20, 13:07, Rafael J. Wysocki wrote:
>> On Thu, Sep 24, 2020 at 1:00 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>> On 9/24/20 11:24 AM, Rafael J. Wysocki wrote:
>>>> On Thu, Sep 24, 2020 at 11:25 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> 
>>>>> I wonder if we could just drop the reset feature. Is there a tool
>>>>> which uses this file? The 'reset' sysfs would probably have to stay
>>>>> forever, but an empty implementation is not an option?
>>>>
>>>> Well, having an empty sysfs attr would be a bit ugly, but the
>>>> implementation of it could be simplified.
>>>>
>>>>> The documentation states:
>>>>> 'This can be useful for evaluating system behaviour under different
>>>>> governors without the need for a reboot.'
>>>>> With the scenario of fast-switch this resetting complicates the
>>>>> implementation and the justification of having it just for experiments
>>>>> avoiding reboot is IMO weak. The real production code would have to pay
>>>>> extra cycles every time. Also, we would probably not experiment with
>>>>> cpufreq different governors, since the SchedUtil is considered the best
>>>>> option.
>>>>
>>>> It would still be good to have a way to test it against the other
>>>> available options, though.
>>>>
>>>
>>> Experimenting with different governors would still be possible, just
>>> the user-space would have to take a snapshot of the stats when switching
>>> to a new governor. Then the values presented in the stats would just
>>> need to be calculated in this user tool against the snapshot.
>>>
>>> The resetting is also not that bad, since nowadays more components
>>> maintain some kind of local statistics/history (scheduler, thermal).
>>> I would recommend to reset the whole system and repeat the same tests
>>> with different governor, just to be sure that everything starts from
>>> similar state (utilization, temperature, other devfreq devices
>>> frequencies etc).
>>
>> Well, if everyone agrees on removing the reset feature, let's drop the
>> sysfs attr too, as it would be useless going forward.
>>
>> Admittedly, I don't have a strong opinion and since intel_pstate
>> doesn't use a frequency table, this is not relevant for systems using
>> that driver anyway.
> 
> I added this file sometime back as it made my life a lot easier while testing
> some scheduler related changes and see how they affect cpufreq updates. IMO this
> is a useful feature and we don't really need to get rid of it.
> 
> Lets see where the discussion goes about the feedback you gave.
> 

Because of supporting this reset file, the code is going to be a bit
complex and also visited from the scheduler. I don't know if the
config for stats is enabled for production kernels but if yes,
then forcing all to keep that reset code might be too much.
For the engineering kernel version is OK.

I would say for most normal checks these sysfs stats are very useful.
If there is a need for investigation like you described, the trace
event is there, just have to be enabled. Tools like LISA would
help with parsing the trace and mapping to some plots or even
merging with scheduler context.

 From time to time some engineers are asking why the stats
don't show the values (missing fast-switch tracking). I think
they are interested in a simple use case, otherwise they would use the
tracing.

Regards,
Lukasz
