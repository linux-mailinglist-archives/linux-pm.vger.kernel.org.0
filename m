Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B892520D387
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgF2S75 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 14:59:57 -0400
Received: from foss.arm.com ([217.140.110.172]:37356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbgF2S74 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jun 2020 14:59:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2328143B;
        Mon, 29 Jun 2020 04:52:15 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 854593F73C;
        Mon, 29 Jun 2020 04:52:12 -0700 (PDT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Kamil Konieczny <k.konieczny@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
 <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
 <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
 <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
 <4a72fcab-e8da-8323-1fbe-98a6a4b3e0f1@arm.com>
 <4c3b01af-2337-1eba-4675-6488105144c8@samsung.com>
 <6f8b1119-62b1-942d-cfde-6f1e9a28c40c@arm.com>
 <ee2e4acb-3986-3227-da1f-177d2756d194@samsung.com>
 <ad4e1a73-6de3-68ee-e3b3-b30bc315bd31@samsung.com>
 <691bc55c-5b04-b519-4575-6dce5ea9914c@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <be215777-54fd-ed84-0709-1d276bc3fe90@arm.com>
Date:   Mon, 29 Jun 2020 12:52:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <691bc55c-5b04-b519-4575-6dce5ea9914c@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 6/29/20 2:43 AM, Chanwoo Choi wrote:
> Hi,
> 
> Sorry for late reply because of my perfornal issue. I count not check the email.

I hope you are good now.

> 
> On 6/26/20 8:22 PM, Bartlomiej Zolnierkiewicz wrote:
>>
>> On 6/25/20 2:12 PM, Kamil Konieczny wrote:
>>> On 25.06.2020 14:02, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 6/25/20 12:30 PM, Kamil Konieczny wrote:
>>>>> Hi Lukasz,
>>>>>
>>>>> On 25.06.2020 12:02, Lukasz Luba wrote:
>>>>>> Hi Sylwester,
>>>>>>
>>>>>> On 6/24/20 4:11 PM, Sylwester Nawrocki wrote:
>>>>>>> Hi All,
>>>>>>>
>>>>>>> On 24.06.2020 12:32, Lukasz Luba wrote:
>>>>>>>> I had issues with devfreq governor which wasn't called by devfreq
>>>>>>>> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
>>>>>>>> for it [1]. If the CPU which scheduled the next work went idle, the
>>>>>>>> devfreq workqueue will not be kicked and devfreq governor won't check
>>>>>>>> DMC status and will not decide to decrease the frequency based on low
>>>>>>>> busy_time.
>>>>>>>> The same applies for going up with the frequency. They both are
>>>>>>>> done by the governor but the workqueue must be scheduled periodically.
>>>>>>>
>>>>>>> As I have been working on resolving the video mixer IOMMU fault issue
>>>>>>> described here: https://patchwork.kernel.org/patch/10861757
>>>>>>> I did some investigation of the devfreq operation, mostly on Odroid U3.
>>>>>>>
>>>>>>> My conclusions are similar to what Lukasz says above. I would like to add
>>>>>>> that broken scheduling of the performance counters read and the devfreq
>>>>>>> updates seems to have one more serious implication. In each call, which
>>>>>>> normally should happen periodically with fixed interval we stop the counters,
>>>>>>> read counter values and start the counters again. But if period between
>>>>>>> calls becomes long enough to let any of the counters overflow, we will
>>>>>>> get wrong performance measurement results. My observations are that
>>>>>>> the workqueue job can be suspended for several seconds and conditions for
>>>>>>> the counter overflow occur sooner or later, depending among others
>>>>>>> on the CPUs load.
>>>>>>> Wrong bus load measurement can lead to setting too low interconnect bus
>>>>>>> clock frequency and then bad things happen in peripheral devices.
>>>>>>>
>>>>>>> I agree the workqueue issue needs to be fixed. I have some WIP code to use
>>>>>>> the performance counters overflow interrupts instead of SW polling and with
>>>>>>> that the interconnect bus clock control seems to work much better.
>>>>>>>
>>>>>>
>>>>>> Thank you for sharing your use case and investigation results. I think
>>>>>> we are reaching a decent number of developers to maybe address this
>>>>>> issue: 'workqueue issue needs to be fixed'.
>>>>>> I have been facing this devfreq workqueue issue ~5 times in different
>>>>>> platforms.
>>>>>>
>>>>>> Regarding the 'performance counters overflow interrupts' there is one
>>>>>> thing worth to keep in mind: variable utilization and frequency.
>>>>>> For example, in order to make a conclusion in algorithm deciding that
>>>>>> the device should increase or decrease the frequency, we fix the period
>>>>>> of observation, i.e. to 500ms. That can cause the long delay if the
>>>>>> utilization of the device suddenly drops. For example we set an
>>>>>> overflow threshold to value i.e. 1000 and we know that at 1000MHz
>>>>>> and full utilization (100%) the counter will reach that threshold
>>>>>> after 500ms (which we want, because we don't want too many interrupts
>>>>>> per sec). What if suddenly utilization drops to 2% (i.e. from 5GB/s
>>>>>> to 250MB/s (what if it drops to 25MB/s?!)), the counter will reach the
>>>>>> threshold after 50*500ms = 25s. It is impossible just for the counters
>>>>>> to predict next utilization and adjust the threshold. [...]
>>>>>
>>>>> irq triggers for underflow and overflow, so driver can adjust freq
>>>>>
>>>>
>>>> Probably possible on some platforms, depends on how many PMU registers
>>>> are available, what information can be can assign to them and type of
>>>> interrupt. A lot of hassle and still - platform and device specific.
>>>> Also, drivers should not adjust the freq, governors (different types
>>>> of them with different settings that they can handle) should do it.
>>>>
>>>> What the framework can do is to take this responsibility and provide
>>>> generic way to monitor the devices (or stop if they are suspended).
>>>> That should work nicely with the governors, which try to predict the
>>>> next best frequency. From my experience the more fluctuating intervals
>>>> the governors are called, the more odd decisions they make.
>>>> That's why I think having a predictable interval i.e. 100ms is something
>>>> desirable. Tuning the governors is easier in this case, statistics
>>>> are easier to trace and interpret, solution is not to platform specific,
>>>> etc.
>>>>
>>>> Kamil do you have plans to refresh and push your next version of the
>>>> workqueue solution?
>>>
>>> I do not, as Bartek takes over my work,
>>> +CC Bartek
>>
>> Hi Lukasz,
>>
>> As you remember in January Chanwoo has proposed another idea (to allow
>> selecting workqueue type by devfreq device driver):
>>
>> "I'm developing the RFC patch and then I'll send it as soon as possible."
>> (https://lore.kernel.org/linux-pm/6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com/)
>>
>> "After posting my suggestion, we can discuss it"
>> (https://lore.kernel.org/linux-pm/f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com/)
>>
>> so we have been waiting on the patch to be posted..
> 
> Sorry for this. I'll send it within few days.


Feel free to add me on CC, I can review&test the patches if you like.

Stay safe and healthy.

Regards,
Lukasz

