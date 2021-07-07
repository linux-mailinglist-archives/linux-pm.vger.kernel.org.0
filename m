Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F563BE5CB
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhGGJrp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 05:47:45 -0400
Received: from foss.arm.com ([217.140.110.172]:33016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230498AbhGGJro (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 05:47:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CEDAED1;
        Wed,  7 Jul 2021 02:45:04 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04D773F694;
        Wed,  7 Jul 2021 02:45:01 -0700 (PDT)
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
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
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com>
 <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9b0ea7bc-934a-43bd-7dd8-9fe33dec97bc@arm.com>
Date:   Wed, 7 Jul 2021 11:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/07/2021 10:23, Lukasz Luba wrote:
>  
> On 7/7/21 9:00 AM, Vincent Guittot wrote:
>> On Wed, 7 Jul 2021 at 09:49, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>>
>>>
>>> On 7/7/21 8:07 AM, Vincent Guittot wrote:
>>>> On Fri, 25 Jun 2021 at 17:26, Lukasz Luba <lukasz.luba@arm.com> wrote:

[...]

>>>> Could you explain why 32bits results are not enough and you need to
>>>> move to 64bits ?
>>>>
>>>> Right now the result is in the range [0..2^32[ mW. If you need more
>>>> precision and you want to return uW instead, you will have a result in
>>>> the range  [0..4kW[ which seems to be still enough
>>>>
>>>
>>> Currently we have the max value limit for 'power' in EM which is
>>> EM_MAX_POWER 0xffff (64k - 1). We allow to register such big power
>>> values ~64k mW (~64Watts) for an OPP. Then based on 'power' we
>>> pre-calculate 'cost' fields:
>>> cost[i] = power[i] * freq_max / freq[i]
>>> So, for max freq the cost == power. Let's use that in the example.
>>>
>>> Then the em_cpu_energy() calculates as follow:
>>> cost * sum_util / scale_cpu
>>> We are interested in the first part - the value of multiplication.
>>
>> But all these are internal computations of the energy model. At the
>> end, the computed energy that is returned by compute_energy() and
>> em_cpu_energy(), fits in a long
> 
> Let's take a look at existing *10000 precision for x CPUs:
> cost * sum_util / scale_cpu =
> (64k *10000) * (x * 800) / 1024
> which is:
> x * ~500mln
> 
> So to be close to overflowing u32 the 'x' has to be > (?=) 8
> (depends on sum_util).

I assume the worst case is `x * 1024` (max return value of
effective_cpu_util = effective_cpu_util()) so x ~ 6.7.

I'm not aware of any arm32 b.L. systems with > 4 CPUs in a PD.
