Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7F3AA537
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhFPUYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 16:24:54 -0400
Received: from foss.arm.com ([217.140.110.172]:44864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233355AbhFPUYx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 16:24:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2125D113E;
        Wed, 16 Jun 2021 13:22:46 -0700 (PDT)
Received: from [10.57.9.31] (unknown [10.57.9.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A493A3F70D;
        Wed, 16 Jun 2021 13:22:42 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20210614185815.15136-1-lukasz.luba@arm.com>
 <20210614191128.22735-1-lukasz.luba@arm.com>
 <237ef538-c8ca-a103-b2cc-240fc70298fe@arm.com>
 <d214db57-879c-cf3f-caa8-76c2cd369e0d@arm.com>
 <9821712d-be27-a2e7-991c-b0010e23fa70@arm.com>
 <CAKfTPtCpWrubqp2W8NQA0JTh2dJx3oxGuCBJbZ04reFzCbDxEg@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <79dbb2ad-88c1-ff08-59c8-7728d37ee78a@arm.com>
Date:   Wed, 16 Jun 2021 21:22:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCpWrubqp2W8NQA0JTh2dJx3oxGuCBJbZ04reFzCbDxEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/16/21 8:25 PM, Vincent Guittot wrote:
> On Wed, 16 Jun 2021 at 19:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 15/06/2021 18:09, Lukasz Luba wrote:
>>>
>>> On 6/15/21 4:31 PM, Dietmar Eggemann wrote:
>>>> On 14/06/2021 21:11, Lukasz Luba wrote:
>>
>> [...]
>>
>>>> It's important to highlight that this will only fix this issue between
>>>> schedutil and EAS when it's due to `thermal pressure` (today only via
>>>> CPU cooling). There are other places which could restrict policy->max
>>>> via freq_qos_update_request() and EAS will be unaware of it.
>>>
>>> True, but for this I have some other plans.
>>
>> As long as people are aware of the fact that this was developed to be
>> beneficial for `EAS - IPA` integration, I'm fine with this.
> 
> I don't think it's only for EAS - IPA. Thermal_pressure can be used by
> HW throttling like here:
> https://lkml.org/lkml/2021/6/8/1791
> 
> EAS is involved but not IPA

Thank you Vincent for pointing to Thara's patches. Indeed, this is a
good example. We will have to provide similar for our SCMI perf
notifications - these are the plans that I've mentioned. In both
new examples, the IPA (or other governors) won't be even involved.
