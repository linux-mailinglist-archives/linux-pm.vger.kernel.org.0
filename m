Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A41E46BD
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbgE0PCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 11:02:46 -0400
Received: from foss.arm.com ([217.140.110.172]:39702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389400AbgE0PCp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 May 2020 11:02:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC9AB30E;
        Wed, 27 May 2020 08:02:44 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A25323F52E;
        Wed, 27 May 2020 08:02:42 -0700 (PDT)
References: <20200526151619.8779-1-benjamin.gaignard@st.com> <jhjk10xu1tq.mognet@arm.com> <ab4340c0-bda3-e752-9073-e162e6325bb1@st.com> <jhjwo4xinhb.mognet@arm.com> <099f5b6c-aa81-be4a-19bf-52a2fff7b3db@st.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     "rjw\@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar\@linaro.org" <viresh.kumar@linaro.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        "mchehab\@kernel.org" <mchehab@kernel.org>,
        "mcoquelin.stm32\@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "pavel\@ucw.cz" <pavel@ucw.cz>,
        "len.brown\@intel.com" <len.brown@intel.com>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media\@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32\@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
In-reply-to: <099f5b6c-aa81-be4a-19bf-52a2fff7b3db@st.com>
Date:   Wed, 27 May 2020 16:02:37 +0100
Message-ID: <jhjv9khifoy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 27/05/20 14:11, Benjamin GAIGNARD wrote:
> On 5/27/20 2:14 PM, Valentin Schneider wrote:
>> On 27/05/20 12:17, Benjamin GAIGNARD wrote:
>>> On 5/27/20 12:09 PM, Valentin Schneider wrote:
>>>> Hi Benjamin,
>>>>
>>>> On 26/05/20 16:16, Benjamin Gaignard wrote:
>>>>> A first round [1] of discussions and suggestions have already be done on
>>>>> this series but without found a solution to the problem. I resend it to
>>>>> progress on this topic.
>>>>>
>>>> Apologies for sleeping on that previous thread.
>>>>
>>>> So what had been suggested over there was to use uclamp to boost the
>>>> frequency of the handling thread; however if you use threaded IRQs you
>>>> get RT threads, which already get the max frequency by default (at least
>>>> with schedutil).
>>>>
>>>> Does that not work for you, and if so, why?
>>> That doesn't work because almost everything is done by the hardware blocks
>>> without charge the CPU so the thread isn't running.
>> I'm not sure I follow; the frequency of the CPU doesn't matter while
>> your hardware blocks are spinning, right? AIUI what matters is running
>> your interrupt handler / action at max freq, which you get if you use
>> threaded IRQs and schedutil.
> Yes but not limited to schedutil.
> Given the latency needed to change of frequencies I think it could
> already too late
> to change the CPU frequency when handling the threaded interrupt.

Right, on my Juno the transition latency (i.e. worse case) is about
1.2ms; I can see that eating into your time budget, depending on the
framerate you're going for.

Vincent's got a point, if you can limit that max-freq-hold to a single
frequency domain, that would probably be a tad better.

Thanks for persisting through my questioning :-)

>>
>> I think it would help if you could clarify which tasks / parts of your
>> pipeline you need running at high frequencies. The point is that setting
>> a QoS request affects all tasks, whereas we could be smarter and only
>> boost the required tasks.
> What make us drop frames is that the threaded IRQ is scheduled too late.
> The not thread part of the interrupt handler where we clear the
> interrupt flags
> is going fine but the thread part not.
>>
>>> I have done the
>>> tests with schedutil
>>> and ondemand scheduler (which is the one I'm targeting). I have no
>>> issues when using
>>> performance scheduler because it always keep the highest frequencies.
>>>
>>>
>>>>> When start streaming from the sensor the CPU load could remain very low
>>>>> because almost all the capture pipeline is done in hardware (i.e. without
>>>>> using the CPU) and let believe to cpufreq governor that it could use lower
>>>>> frequencies. If the governor decides to use a too low frequency that
>>>>> becomes a problem when we need to acknowledge the interrupt during the
>>>>> blanking time.
>>>>> The delay to ack the interrupt and perform all the other actions before
>>>>> the next frame is very short and doesn't allow to the cpufreq governor to
>>>>> provide the required burst of power. That led to drop the half of the frames.
>>>>>
>>>>> To avoid this problem, DCMI driver informs the cpufreq governors by adding
>>>>> a cpufreq minimum load QoS resquest.
>>>>>
>>>>> Benjamin
>>>>>
>>>>> [1] https://lkml.org/lkml/2020/4/24/360
>>>>>
>>>>> Benjamin Gaignard (3):
>>>>>     PM: QoS: Introduce cpufreq minimum load QoS
>>>>>     cpufreq: governor: Use minimum load QoS
>>>>>     media: stm32-dcmi: Inform cpufreq governors about cpu load needs
>>>>>
>>>>>    drivers/cpufreq/cpufreq_governor.c        |   5 +
>>>>>    drivers/media/platform/stm32/stm32-dcmi.c |   8 ++
>>>>>    include/linux/pm_qos.h                    |  12 ++
>>>>>    kernel/power/qos.c                        | 213 ++++++++++++++++++++++++++++++
>>>>>    4 files changed, 238 insertions(+)
