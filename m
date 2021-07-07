Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A913A3BE3ED
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhGGHwb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 03:52:31 -0400
Received: from foss.arm.com ([217.140.110.172]:58998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhGGHwa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 03:52:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC0EED1;
        Wed,  7 Jul 2021 00:49:50 -0700 (PDT)
Received: from [10.57.1.129] (unknown [10.57.1.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA9DF3F694;
        Wed,  7 Jul 2021 00:49:47 -0700 (PDT)
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com>
Date:   Wed, 7 Jul 2021 08:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/7/21 8:07 AM, Vincent Guittot wrote:
> On Fri, 25 Jun 2021 at 17:26, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
>> task. It probes many possibilities and compares the estimated energy values
>> for different scenarios. For calculating those energy values it relies on
>> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
>> EM data is in milli-Watts (or abstract scale), which sometimes is not
>> sufficient. In some cases it might happen that two CPUs from different
>> Performance Domains (PDs) get the same calculated value for a given task
>> placement, but in more precised scale, they might differ. This rounding
>> error has to be addressed. This patch prepares EAS code for better
>> precision in the coming EM improvements.
> 
> Could you explain why 32bits results are not enough and you need to
> move to 64bits ?
> 
> Right now the result is in the range [0..2^32[ mW. If you need more
> precision and you want to return uW instead, you will have a result in
> the range  [0..4kW[ which seems to be still enough
> 

Currently we have the max value limit for 'power' in EM which is
EM_MAX_POWER 0xffff (64k - 1). We allow to register such big power
values ~64k mW (~64Watts) for an OPP. Then based on 'power' we
pre-calculate 'cost' fields:
cost[i] = power[i] * freq_max / freq[i]
So, for max freq the cost == power. Let's use that in the example.

Then the em_cpu_energy() calculates as follow:
cost * sum_util / scale_cpu
We are interested in the first part - the value of multiplication.

The sum_util values that we can see for x CPUs which have scale_cap=1024
can be close to 800, let's use it in the example:
cost * sum_util = 64k * (x * 800), where
x=4: ~200mln
x=8: ~400mln
x=16: ~800mln
x=64: ~3200mln (last one which would fit in u32)

When we increase the precision by even 100, then the above values won't
fit in the u32. Even a max cost of e.g. 10k mW and 100 precision has
issues:
cost * sum_util = (10k *100) * (x * 800), where
x=4: ~3200mln
x=8: ~6400mln

For *1000 precision even a power of 1Watt becomes an issue:
cost * sum_util = (1k *1000) * (x * 800), where
x=4: ~3200mln
x=8: ~6400mln

That's why to make the code safe for bigger power values, I had to use
the u64 on 32bit machines.
