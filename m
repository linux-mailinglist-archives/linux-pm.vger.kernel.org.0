Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A723A2972
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJKjy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 06:39:54 -0400
Received: from foss.arm.com ([217.140.110.172]:56592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFJKjy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 06:39:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C990AD6E;
        Thu, 10 Jun 2021 03:37:57 -0700 (PDT)
Received: from [10.57.4.220] (unknown [10.57.4.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF953F694;
        Thu, 10 Jun 2021 03:37:55 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        qperret@google.com, vincent.donnefort@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com
References: <20210604080954.13915-1-lukasz.luba@arm.com>
 <20210604080954.13915-2-lukasz.luba@arm.com>
 <2f2fc758-92c6-5023-4fcb-f9558bf3369e@arm.com>
 <905f1d29-50f9-32be-4199-fc17eab79d04@arm.com>
 <3cfa5690-644b-ba80-3fc3-7c5a3f292e70@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c77d00b9-d7a3-0e8a-a528-ab0c1773496f@arm.com>
Date:   Thu, 10 Jun 2021 11:37:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3cfa5690-644b-ba80-3fc3-7c5a3f292e70@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/10/21 11:07 AM, Dietmar Eggemann wrote:
> On 10/06/2021 11:04, Lukasz Luba wrote:
>>

[snip]

>> Not always, it depends on thermal governor decision, workload and
>> 'power actors' (in IPA naming convention). Then it depends when and how
>> hard you clamp the CPUs. They (CPUs) don't have to be always
>> overutilized, they might be even 50-70% utilized but the GPU reduced
>> power budget by 2 Watts, so CPUs left with only 1W. Which is still OK
>> for the CPUs, since they are only 'feeding' the GPU with new 'jobs'.
> 
> All this pretty much confines the usefulness of you proposed change. A
> precise description of it with the patches is necessary to allow people
> to start from there while exploring your patches.

OK, I see your point.

[snip]

>> True, I hope this description above would help to understand the
>> scenario.
> 
> This description belongs in the patch header. The scenario in which your
> functionality would improve things has to be clear.
> I'm sure that not everybody looking at this patches is immediately aware
> on how IPA setups work and which specific setup you have in mind here.

Agree. I will add this description into the patch header for v3.

[snip]

>>
>> Yes, this code implementation tries to address those issues.
> 
> The point I was making here is: why using the PELT signal
> thermal_load_avg() and not per_cpu(thermal_pressure, cpu) directly,
> given the fact that the latter perfectly represents the frequency clamping?
> 

Good question. I wanted to be aligned with other parts in the fair.c
like cpu_capacity() and all it's users. The CPU capacity is reduced by
RT, DL, IRQ and thermal load avg, not the 'raw' value from the
per-cpu variable.

TBH I cannot recall what was the argument back then
when thermal pressure geometric series was introduced.
Maybe to have a better control how fast it raises and decays
so other mechanisms in the scheduler will see the change in thermal
as not so sharp... (?)


Vincent do you remember the motivation to have geometric series
in thermal pressure and not use just the 'raw' value from per-cpu?
