Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD120DD56
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgF2SuH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 14:50:07 -0400
Received: from foss.arm.com ([217.140.110.172]:36234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgF2SuA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 125D91435;
        Mon, 29 Jun 2020 04:41:59 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA9D3F73C;
        Mon, 29 Jun 2020 04:41:56 -0700 (PDT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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
 <708feba7-6b11-4943-1073-a1b5e54b6283@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <cf460cc5-dbb1-efeb-3021-622ee5b0be45@arm.com>
Date:   Mon, 29 Jun 2020 12:41:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <708feba7-6b11-4943-1073-a1b5e54b6283@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/26/20 6:50 PM, Sylwester Nawrocki wrote:
> Hi Lukasz,
> 
> On 25.06.2020 12:02, Lukasz Luba wrote:
>> Regarding the 'performance counters overflow interrupts' there is one
>> thing worth to keep in mind: variable utilization and frequency.
>> For example, in order to make a conclusion in algorithm deciding that
>> the device should increase or decrease the frequency, we fix the period
>> of observation, i.e. to 500ms. That can cause the long delay if the
>> utilization of the device suddenly drops. For example we set an
>> overflow threshold to value i.e. 1000 and we know that at 1000MHz
>> and full utilization (100%) the counter will reach that threshold
>> after 500ms (which we want, because we don't want too many interrupts
>> per sec). What if suddenly utilization drops to 2% (i.e. from 5GB/s
>> to 250MB/s (what if it drops to 25MB/s?!)), the counter will reach the
>> threshold after 50*500ms = 25s. It is impossible just for the counters
>> to predict next utilization and adjust the threshold.
> 
> Agreed, that's in case when we use just the performance counter (PMCNT)
> overflow interrupts. In my experiments I used the (total) cycle counter
> (CCNT) overflow interrupts. As that counter is clocked with fixed rate
> between devfreq updates it can be used as a timer by pre-loading it with
> initial value depending on current bus frequency. But we could as well
> use some reliable system timer mechanism to generate periodic events.
> I was hoping to use the cycle counter to generate low frequency monitor
> events and the actual performance counters overflow interrupts to detect
> any sudden changes of utilization. However, it seems it cannot be done
> with as simple performance counters HW architecture as on Exynos4412.
> It looks like on Exynos5422 we have all what is needed, there is more
> flexibility in selecting the counter source signal, e.g. each counter
> can be a clock cycle counter or can count various bus events related to
> actual utilization. Moreover, we could configure the counter gating period
> and alarm interrupts are available for when the counter value drops below
> configured MIN threshold or exceeds configured MAX value.

I see. I don't have TRM for Exynos5422 so couldn't see that. I also
have to keep in mind other platforms which might not have this feature.

> 
> So it should be possible to configure the HW to generate the utilization
> monitoring events without excessive continuous CPU intervention.

I agree, that would be desirable especially for low load in the system.

> But I'm rather not going to work on the Exynos5422 SoC support at the moment.

I see.

> 
>> To address that, we still need to have another mechanism (like watchdog)
>> which will be triggered just to check if the threshold needs adjustment.
>> This mechanism can be a local timer in the driver or a framework
>> timer running kind of 'for loop' on all this type of devices (like
>> the scheduled workqueue). In both cases in the system there will be
>> interrupts, timers (even at workqueues) and scheduling.
>> The approach to force developers to implement their local watchdog
>> timers (or workqueues) in drivers is IMHO wrong and that's why we have
>> frameworks.
> 
> Yes, it should be also possible in the framework to use the counter alarm
> events where the hardware is advanced enough, in order to avoid excessive
> SW polling.

Looks promising, but that would need more plumbing I assume.

Regards,
Lukasz

> 
> --
> Regards,
> Sylwester
> 
