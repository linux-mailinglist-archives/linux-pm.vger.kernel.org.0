Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D148D112B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfJIO0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 10:26:16 -0400
Received: from foss.arm.com ([217.140.110.172]:35562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbfJIO0Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 10:26:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19D451576;
        Wed,  9 Oct 2019 07:26:15 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8103F71A;
        Wed,  9 Oct 2019 07:26:12 -0700 (PDT)
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Parth Shah <parth@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Quentin Perret <qperret@qperret.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20191007083051.4820-1-parth@linux.ibm.com>
 <20191007083051.4820-5-parth@linux.ibm.com>
 <CAKfTPtCgoTJXxbYyza1W55ayw9QeM7fue2e91Xpt804sL9GQWA@mail.gmail.com>
 <80bb34ec-6358-f4dc-d20d-cde6c9d7e197@linux.ibm.com>
 <d55c593d-af8e-c8ba-cc0e-c9917df5d593@arm.com>
 <86dc25e4-9f19-627f-9581-d74608b7f20c@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <eef32b9e-1f24-e8a9-cd91-dcc6546a636f@arm.com>
Date:   Wed, 9 Oct 2019 16:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <86dc25e4-9f19-627f-9581-d74608b7f20c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/10/2019 10:57, Parth Shah wrote:

[...]

>> On 07/10/2019 18:53, Parth Shah wrote:
>>>
>>>
>>> On 10/7/19 5:49 PM, Vincent Guittot wrote:
>>>> On Mon, 7 Oct 2019 at 10:31, Parth Shah <parth@linux.ibm.com> wrote:

[...]

>>> Maybe I can add just below the sched_energy_present(){...} construct giving
>>> precedence to EAS? I'm asking this because I remember Patrick telling me to
>>> leverage task packing for android as well?
>>
>> I have a hard time imaging that Turbosched will be used in Android next
>> to EAS in the foreseeable future.
>>
>> First of all, EAS provides task packing already on Performance Domain
>> (PD) level (a.k.a. as cluster on traditional 2-cluster Arm/Arm64
>> big.LITTLE or DynamIQ (with Phantom domains (out of tree solution)).
>> This is where we can safe energy without harming latency.
>>
>> See the tests results under '2.1 Energy test case' in
>>
>> https://lore.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com
>>
>> There are 10 to 50 small (classified solely by task utilization) tasks
>> per test case and EAS shows an effect on energy consumption by packing
>> them onto the PD (cluster) of the small CPUs.
>>
>> And second, the CPU supported topology is different to the one you're
>> testing on.
>>
> 
> cool. I was just keeping in mind the following quote
> " defining a generic spread-vs-pack wakeup policy which is something
> Android also could benefit from " (https://lkml.org/lkml/2019/6/28/628)

The main thing is that in case we want to introduce a new functionality
into CFS, we should try hard to use existing infrastructure (or
infrastructure there is agreement on that we'll need it) as much as
possible.

If I understand Patrick here correctly, he suggested not to use uclamp
but the task latency nice approach. There is agreement that we would
need something like this as infrastructure:

https://lore.kernel.org/r/20190830174944.21741-1-subhra.mazumdar@oracle.com

So p->latency_nice is suitable to include your p->flags |=
PF_CAN_BE_PACKED concept nicely.

> 
> BTW, IIUC that does task consolidation only on single CPU unless
> rd->overload is set, right?

Task consolidation on Performance Domains (PDs) w/ multiple CPUs (e.g.
on a per-cluster PD big.LITTLE system) only works when the system is not
overutilized:

6326 int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
6327 {
...
6337         if (!pd || *READ_ONCE(rd->overutilized)*)
6338                 goto fail;
...

[...]
