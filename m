Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B69F580EDE
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 10:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiGZI0t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiGZI0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 04:26:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18E091A82E;
        Tue, 26 Jul 2022 01:26:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 759441FB;
        Tue, 26 Jul 2022 01:26:47 -0700 (PDT)
Received: from [10.57.13.197] (unknown [10.57.13.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0FA33F73B;
        Tue, 26 Jul 2022 01:26:45 -0700 (PDT)
Message-ID: <dade430a-0856-0936-96bd-5010480c48c9@arm.com>
Date:   Tue, 26 Jul 2022 09:26:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] cpufreq: schedutil: Move max CPU capacity to sugov_policy
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220711124229.16516-1-lukasz.luba@arm.com>
 <1198724e-d94f-0b7c-9c4a-90595f8426d2@arm.com>
 <CAJZ5v0gh78z3tw6simaZ5S6dmGvDc-OE6t02N8vQYk-2eoFQgA@mail.gmail.com>
 <deddd9cc-f517-cff9-e304-e1f09c6784b7@arm.com>
 <CAJZ5v0jYzJo2BU-qKkaJog6pYx7SkpgmWGd6vTTkc2T=gx8abw@mail.gmail.com>
 <837b387a-b29d-2122-efb0-881b24dd2725@arm.com>
In-Reply-To: <837b387a-b29d-2122-efb0-881b24dd2725@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 7/25/22 09:07, Lukasz Luba wrote:
> Hi Rafael,
> 
> On 7/15/22 18:29, Rafael J. Wysocki wrote:
>> On Fri, Jul 15, 2022 at 1:47 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>>
>>>
>>> On 7/15/22 12:44, Rafael J. Wysocki wrote:
>>>> On Fri, Jul 15, 2022 at 10:47 AM Lukasz Luba <lukasz.luba@arm.com> 
>>>> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> gentle ping.
>>>>>
>>>>> On 7/11/22 13:42, Lukasz Luba wrote:
>>>>>> There is no need to keep the max CPU capacity in the per_cpu 
>>>>>> instance.
>>>>>> Furthermore, there is no need to check and update that variable
>>>>>> (sg_cpu->max) everytime in the frequency change request, which is 
>>>>>> part
>>>>>> of hot path. Instead use struct sugov_policy to store that 
>>>>>> information.
>>>>>> Initialize the max CPU capacity during the setup and start callback.
>>>>>> We can do that since all CPUs in the same frequency domain have 
>>>>>> the same
>>>>>> max capacity (capacity setup and thermal pressure are based on that).
>>>>>>
>>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>>> ---
>>>>>>     kernel/sched/cpufreq_schedutil.c | 30 
>>>>>> +++++++++++++++---------------
>>>>>>     1 file changed, 15 insertions(+), 15 deletions(-)
>>>>>
>>>>> The patch got Ack from Viresh.
>>>>> Could you take it?
>>>>
>>>> Yes, it's there in my queue.  Same for the EM changes.
>>>
>>> Thank you Rafael!
>>
>> Well, the patch doesn't apply on top of 5.19-rc6, because
>> sugov_get_util() is somewhat different.
>>
>> Please rebase it and resend.
> 
> My apologies for the delay, I was on holidays.
> 
> I'll do that today and resend it.
> 

I have found the reason why it doesn't apply
on your tree. I have used next-20220711
to base this work on. It contains Peter's
branch sched/core, where there is this Dietmar's patch:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=bb4479994945e9170534389a7762eb56149320ac

That causes the issue. I thing it might collide when I re-base my patch
on top of 5.19-rc6 and you apply it into pm tree...

What do you think about this?
