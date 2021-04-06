Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A562355112
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhDFKjT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 06:39:19 -0400
Received: from foss.arm.com ([217.140.110.172]:40582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhDFKjT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Apr 2021 06:39:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6737531B;
        Tue,  6 Apr 2021 03:39:11 -0700 (PDT)
Received: from [10.57.24.162] (unknown [10.57.24.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 275233F73D;
        Tue,  6 Apr 2021 03:39:09 -0700 (PDT)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d74b8e8e-64b0-d724-d572-f98eb597a60e@arm.com>
Date:   Tue, 6 Apr 2021 11:39:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1a0b6e4a-1717-91d6-a664-d50e6aa8a809@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/6/21 11:16 AM, Daniel Lezcano wrote:
> On 06/04/2021 10:44, Lukasz Luba wrote:
>>
>>
>> On 4/2/21 4:54 PM, Daniel Lezcano wrote:
>>> On 31/03/2021 18:33, Lukasz Luba wrote:
>>>> When the temperature is below the first activation trip point the
>>>> cooling
>>>> devices are not checked, so they cannot maintain fresh statistics. It
>>>> leads into the situation, when temperature crosses first trip point, the
>>>> statistics are stale and show state for very long period.
>>>
>>> Can you elaborate the statistics you are referring to ?
>>>
>>> I can understand the pid controller needs temperature but I don't
>>> understand the statistics with the cooling device.
>>>
>>>
>>
>> The allocate_power() calls cooling_ops->get_requested_power(),
>> which is for CPUs cpufreq_get_requested_power() function.
>> In that cpufreq implementation for !SMP we still has the
>> issue of stale statistics. Viresh, when he introduced the usage
>> of sched_cpu_util(), he fixed that 'long non-meaningful period'
>> of the broken statistics and it can be found since v5.12-rc1.
>>
>> The bug is still there for the !SMP. Look at the way how idle time
>> is calculated in get_load() [1]. It relies on 'idle_time->timestamp'
>> for calculating the period. But when this function is not called,
>> the value can be very far away in time, e.g. a few seconds back,
>> when the last allocate_power() was called.
>>
>> The bug is there for both SMP and !SMP [2] for older kernels, which can
>> be used in Android or ChromeOS. I've been considering to put this simple
>> IPA fix also to some other kernels, because Viresh's change is more
>> a 'feature' and does not cover both platforms.
> 
> Ok, so IIUC, the temperature is needed as well as the power to do the
> connection for the pid loop (temp vs power).
> 
> I'm trying to figure out how to delegate the mitigation switch on/off to
> the core code instead of the governor (and kill tz->passive) but how
> things are implemented for the IPA makes this very difficult.
> 
> AFAICT, this fix is not correct.
> 
> If the temperature is below the 'switch_on_temp' the passive is set to
> zero and the throttle function is not called anymore (assuming it is
> interrupt mode not polling mode), so the power number is not updated also.

IPA doesn't work well in asynchronous mode, because it needs this fixed
length for the period. I have been experimenting with tsens IRQs and
also both fixed polling + sporadic asynchronous IRQs, trying to fix it
and have 'predictable' IPA, but without a luck.
IPA needs synchronous polling events like we have for high temp e.g.
100ms and low temp e.g. 1000ms. The asynchronous events are root of
undesirable states (too low or to high) calculated and set for cooling
devices. It's also harder to escape these states with asynchronous
events. I don't recommend using IPA with asynchronous events from IRQs,
for now. It might change in future, though.

The patch 2/2 should calm down the unnecessary updates/notifications so
your request.
The longer polling, which we have for temperature below 'switch_on_temp'
(e.g. every 1sec) shouldn't harm the performance of the system, but
definitely makes IPA more predictable and stable.

