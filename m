Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36393BE9B7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhGGO2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 10:28:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232023AbhGGO2N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 10:28:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 560A8D6E;
        Wed,  7 Jul 2021 07:25:32 -0700 (PDT)
Received: from [10.57.1.129] (unknown [10.57.1.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B35323F73B;
        Wed,  7 Jul 2021 07:25:28 -0700 (PDT)
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
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com>
 <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com>
 <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
 <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com>
 <CAKfTPtCEo+gkV2TMhOHSnuUyu5BC54o-B4Hb=QbzgT6Dft-PhQ@mail.gmail.com>
 <27916860-33b1-f0a0-acff-4722a733c81b@arm.com>
 <CAKfTPtB2ogGbGBjJNRBB5jvN24q-tXFR+BpJ31fzsTd2=pDTHQ@mail.gmail.com>
 <ee3ebbaa-7b6d-416d-2caa-197c2713dd4e@arm.com>
 <CAKfTPtAN6-ytxa2Qj3=z27e8ZBoqGrWAZce9CojL3wbZSotUsQ@mail.gmail.com>
 <58cb7ad3-ffff-8940-4c8e-2c46dcc86d54@arm.com>
 <CAKfTPtCy-dbo0xnW8iKaQy94_iV=JYbMU-X4qanzL6RXcL7xEw@mail.gmail.com>
 <e3b11a84-9a26-9a7d-cf90-12a7a8fbcc3f@arm.com>
 <CAKfTPtD-i0K=ofKEekoCzAm2eXR+vVzFxR-uc6Em4LMO8W=RFA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d6e3cc2a-c942-5d6c-a55d-e7c24c8c1a80@arm.com>
Date:   Wed, 7 Jul 2021 15:25:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD-i0K=ofKEekoCzAm2eXR+vVzFxR-uc6Em4LMO8W=RFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/7/21 2:53 PM, Vincent Guittot wrote:
> On Wed, 7 Jul 2021 at 13:02, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 7/7/21 11:50 AM, Vincent Guittot wrote:
>>> On Wed, 7 Jul 2021 at 12:41, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/7/21 11:32 AM, Vincent Guittot wrote:
>>>>> On Wed, 7 Jul 2021 at 12:29, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 7/7/21 11:11 AM, Vincent Guittot wrote:
>>>>>>> On Wed, 7 Jul 2021 at 12:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>>>>
>>>>>>
>>>>>> [snip]
>>>>>>
>>>>>>>> No. It's in 0.1uW scale, so 800Watts. Which is 16 CPUs * 64Watts
>>>>>>>
>>>>>>> Oh! you want 0.1uW precision .... This doesn't seem realistic at all.
>>>>>>> I'm not even sure that the power model can even reach an accuracy of
>>>>>>> 1mW
>>>>>>>
>>>>>>
>>>>>> True, the EM is registering platform with 1mW precision, but 1uW
>>>>>
>>>>> Do you mean 1uW or 0.1uW ?
>>>>
>>>> In this patch set I've proposed 0.1uW, but I'm open to drop one
>>>> order of magnitude. The 1uW still be good.
>>>
>>> I don't want to underestimate the capabilities of the power model but
>>> I don't see which benefit you will get with 0.1uW precision
>>> With a 1uW precision the long type currently used for the returned
>>> value is fine for 32bits machine AFAICT
>>>
>>
>> For 1uW and 1.2Watts for one core, 4 CPUs in cluster we get:
>> (1200 * 1000) * (4 * 1024) = ~4.9bln
>> so it would need div 64 version
> 
> But as stated before, this is an internal computation step and doesn't
> have to be reflected in the returned value which can stay a long
> 

I agree, we might scale down the result if it's too big, before the
return. We could figure this out at the EM registration point, so a
proper shift might be applied for such platform. It might enable both
32bit and 64bit platforms to avoid the rounding error. Let me experiment
with some code to check all the cases.
Thank you for the comments!

