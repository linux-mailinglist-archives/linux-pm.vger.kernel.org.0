Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018D2355B87
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhDFSjB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 14:39:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237219AbhDFSiv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Apr 2021 14:38:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAEB01063;
        Tue,  6 Apr 2021 11:38:42 -0700 (PDT)
Received: from [10.57.24.162] (unknown [10.57.24.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8587C3F73D;
        Tue,  6 Apr 2021 11:38:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power_allocator: maintain the device
 statistics from going stale
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210331163352.32416-1-lukasz.luba@arm.com>
 <20210331163352.32416-2-lukasz.luba@arm.com>
 <b27e0c79-de27-f9b1-ad16-17825b302615@linaro.org>
 <1f0710d5-cd78-dfff-1ce2-bba5f6e469b7@arm.com>
 <1a0b6e4a-1717-91d6-a664-d50e6aa8a809@linaro.org>
 <d74b8e8e-64b0-d724-d572-f98eb597a60e@arm.com>
 <cbc40019-8b2d-5d14-f0fd-b0018fb4a1f6@linaro.org>
 <f7dfced2-23f6-8d3e-d23d-291de368f472@arm.com>
 <7660a09b-51f8-c6f2-5678-77b6bff97af6@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d1bacbb5-9a45-b06d-b646-11ba77510dad@arm.com>
Date:   Tue, 6 Apr 2021 19:38:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7660a09b-51f8-c6f2-5678-77b6bff97af6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/6/21 3:32 PM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> 
> On 06/04/2021 14:25, Lukasz Luba wrote:
>>
>>
>> On 4/6/21 12:24 PM, Daniel Lezcano wrote:

[snip]

>>
>> In your proposed code there is 'tz->last_temperature < switch_on_temp'
>> which then return 0 immediately. So we don't poke the devices.
> 
> Ah yes, I see your point.
> 
> Often the device tree is setup with an additional trip point to trigger
> a stat collection. So I assumed we don't need to feed the pid loop below
> this temperature.
> 
> What is the goal of sampling at polling time (not passive) ?

True, we don't need to feed the PID loop with this data when the temp
is low. We only have to call ->get_requested_power() for each cooling
device, because they maintain context (in that get_load() function
which I pointed earlier). When we don't call them, then next time
when we call, their context is growing and shows statistics for a period
e.g. 30 sec. Then this 30 sec is almost all idle, but only 1sec was
'running', but it doesn't tell you that it was actually the last
1 sec, which means the avg load is ~100%. Due to 'stale' context
IPA might interpret that the load was 1s/30s = ~3%.
When we have this reliable polling every 1sec, so we poke the cooling
devices even at low temp, they will maintain proper statistics context,
then this ~3% misscalculation would not happen.

> 
> Here are the boards with the extra trip point:
> 
> - mt8173.dtsi
> - hi6220.dtsi
> - hi6220.dtsi
> - px30.dts
> - rk3328.dtsi
> - rk3399-gru-kevin.dts
> 
> Those have an interrupt mode but do polling also.
> 
> See the configuration for:
> - sc7180.dtsi (no polling delay and no pre-trip point)
> - r8a77990.dtsi
> 
>>> If the IPA needs a sampling, it may be more adequate to separate the
>>> sampling from the polling. So the other governors won't be impacted by
>>> the IPA specific setup, and we do not end up with polling/passive delays
>>> tricks for a governor. The IPA would have its own self-encapsulated
>>> sampling rate and the thermal zone setup won't depend on the governor.
>>>
>>> What do you think ?
>>>
>>
>> IMHO having a private timer in the governor creates another complexity
>> and confusion.
> 
> I would say we move the adherence between the thermal core and the IPA
> into the governor only :)
> 
> Especially, we *have* to call throttle on a governor even if we are not
> in the mitigation process.
> 
> And from a design POV, it should be the thermal core to be in control of
> what is happening, not passively call the different callbacks and expect
> them to behave correctly (eg. set tz->passive)

In that design you would like to interpret the temp and trips' values
and decide not to call governor like IPA when the temp is low, below
the 1st trip point. Well

> 
> 
>> What we have in thermal now is good enough. We have DT support for both
>> periods so there is need even to write via sysfs:
>> polling-delay-passive
>> polling-delay
>> The device driver developers can rely on this reliable check in the
>> thermal framework.
>> I don't agree that IPA forces any specific setup.
> 
> Yes, it does IMO.
> 
> For instance, on the hi3660, the sensor is able to do interrupt mode, so
> to be wake up when the first temperature threshold is reached.
> 
> But there is still the polling delay because the governor is IPA in this
> case? There is also an additional trip-point0 which is not a target for
> a cooling device, just put there to ensure the IPA has enough data when
> reaching the second trip point which is the target.

It's just a configuration which was there for years. Some who wants to
use IPA have to be sure that it has this 2 trip points: switch_on and
control. If you are talking about a new design, then it's not for this
patch. The complete re-design of DT thermal zones, sensors, etc is
a huge topic.

> 
> If, for any reason, we want to switch to step_wise, where the interrupt
> mode is enough to trigger the mitigation (eg. with passive polling), and
> ensure the system is not constantly waking up (and AFAICT even 1s
> periodic wake up can have a significant impact on battery life), it
> won't be possible because of the device tree.

What do you mean 'and ensure the system is not constantly waking up'?
Thermal workqueue mechanism doesn't cause system wakeup from suspend
AFAIK, unless something has changed.

I don't think it has 'significant impact on battery life'. The phone is
not woken-up when it's in suspend after power button was hit and screen
is off. There will be no thermal delayed work timer firing.

Then if we are considering a low system utilization, which would allow
to fire the thermal workqueue and run IPA every 1s, IPA does it's
computation in less then 10us on single big core with 1GHz freq for a
thermal zone with 2 cooling devices.
Thus, for a big CPU running 100% at 1GHz power usage is ~500mW. We can
estimate in various ways the cost of this 10us IPA running time.
It's ~5uW or, when we have 1V (in Juno) for that freq, then
amps=500mA * 10us / 1000000us = 5uA

Even when we add firing & scheduling workqueue cost of CPU idle wake-up
if needed, then still the impact is not 'significant'. It's not a
frequent task, this 1sec thermal+IPA check. Even if you double or triple 
this 10us overhead due to idle wake-up.

That's why we have two values for polling, one is longer, the impact is
low and not 'significant'.

There is plenty of other software which might have bigger impact than
this 1sec polling.

> 
> Moreover, some sensors do not use their interrupt mode because of IPA
> setup or they use it incorrectly.

Sensors have two modes, I don't see why only IRQ is OK.
Polling a sensor every 1s is also OK, it's not waking up the whole
device from suspend.

> 
> See my concern here ? IPA has an impact on the thermal core and the
> sensor, while those should be governor agnostic.

I don't see this as argument for blaming that current design of thermal
has 'significant impact' and is wrong. I don't agree that IPA is the
root cause of this design.

> 
>> If the thermal is
>> configured to do the polling of the temp sensor, because maybe there
>> are no HW interrupts, then there is no other way. The Arm SCMI sensors
>> were one of them, where we had to send a SCMI request. There was no
>> notifications/IRQs that temp crossed some trip point. Now it should be
>> better, but still it depends on vendor's FW implementation if there is
>> IRQ.
> 
> I don't know all the platforms but so far the interrupt mode is largely
> supported, to not say in the vast majority.

It's not obligatory to support IRQ for all trip points per sensor.
There are platforms which support a number, e.g. 4 IRQs, then the
rest of trip points must be defined as polling. This 'mix' for
a single sensor is a concern for me.

In other platforms which use SCMI, till recently, there was no IRQs
for sensors protocols (with latest notifications support it
might be possible in kernel, but still FW must support it).

> 
>> The reliable polling is not IPA 'feature request'.
>> We cannot avoid polling in some configurations. Thermal framework
>> must support this scenario: polling/checking temp sensor even when
>> the temp is low.
> 
> I agree with that, I'm not questioning about removing the polling.
> 
>> Thus, since framework must check the temp, calling
>> the governor->throttle() doesn't harm (as I said every 1sec).
>> Furthermore, the governor interprets what trip point and temperature to
>> interpret and how to react.
> 
> Precisely, that is the reason why I disagree. The thermal core should
> switch on/off the mitigation (say cool down / warm up) and the governor
> applies its recipe. With polling and sampling tied together it is not
> possible to create self-encapsulated components. As a result we have bug
> like [1] :/

I wouldn't blame that this design is all wrong. Framework calls governor
update callback for all temperature and that's it.

Switching governors is tricky, especially when they rely not only on
their private data, but data from it's devices private fields, like this
example step_wise.

This step_wise governor doesn't even provide bind_to_tz() and
unbind_from_tz(). Maybe it should setup itself before starting
operating on the thermal zone after binding?
