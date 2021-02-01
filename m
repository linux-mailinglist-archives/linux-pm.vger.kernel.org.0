Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7961430ACC1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 17:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhBAQh5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 11:37:57 -0500
Received: from foss.arm.com ([217.140.110.172]:34370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBAQh5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Feb 2021 11:37:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F7A1042;
        Mon,  1 Feb 2021 08:37:10 -0800 (PST)
Received: from [10.57.8.191] (unknown [10.57.8.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0D063F718;
        Mon,  1 Feb 2021 08:37:07 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
References: <20210126104001.20361-1-lukasz.luba@arm.com>
 <CAJZ5v0gm7TU59Cr1SUZ8Xk_PwBbwv+J5kA75fNqK7OsGM8F6RA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <aa626625-a685-1ab2-953e-b492a03e4b53@arm.com>
Date:   Mon, 1 Feb 2021 16:37:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gm7TU59Cr1SUZ8Xk_PwBbwv+J5kA75fNqK7OsGM8F6RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 2/1/21 2:19 PM, Rafael J. Wysocki wrote:
> On Tue, Jan 26, 2021 at 11:40 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi all,
>>
>> This patch set tries to add the missing feature in the Intelligent Power
>> Allocation (IPA) governor which is: frequency limit set by user space.
>> User can set max allowed frequency for a given device which has impact on
>> max allowed power.
> 
> If there is more than one frequency that can be limited for the given
> device, are you going to add a limit knob for each of them?

I might be unclear. I was referring to normal sysfs scaling_max_freq,
which sets the max frequency for CPU:

echo XYZ > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

similar for devfreq device, like GPU.


> 
>> In current design there is no mechanism to figure this
>> out. IPA must know the maximum allowed power for every device. It is then
>> used for proper power split and divvy-up. When the user limit for max
>> frequency is not know, IPA assumes it is the highest possible frequency.
>> It causes wrong power split across the devices.
> 
> Do I think correctly that this depends on the Energy Model?

Not directly, but IPA uses the max freq to ask EM for max power. The
issue is that I don't know this 'max freq' for a given device, because
user might set a limit for that device. In that case IPA still blindly 
picks up the power for highest frequency.

> 
>> This new mechanism provides the max allowed frequency to the thermal
>> framework and then max allowed power to the IPA.
>> The implementation is done in this way because currently there is no way
>> to retrieve the limits from the PM QoS, without uncapping the local
>> thermal limit and reading the next value.
> 
> The above is unclear.  What PM QoS limit are you referring to in the
> first place?

The PM QoS which we use in thermal for setting the frequency limits,
for cpufreq_cooling [1] and for devfreq_cooling [2]. I am able to read
that PM QoS value, but it's the lowest, but not set by user.
Example:
2000MHz
1800MHz <----- user set this to 'max freq'
1400MHz <----- thermal set that to 'max freq'

then PM QoS would give me the 1400MHz, because it is the limit for
the max freq.

That's why I said that PM QoS is not able to give me the user limit,
unless I revert in IPA the capping for that device.


> 
>> It would be a heavy way of
>> doing these things, since it should be done every polling time (e.g. 50ms).
>> Also, the value stored in PM QoS can be different than the real OPP 'rate'
>> so still would need conversion into proper OPP for comparison with EM.
>> Furthermore, uncapping the device in thermal just to check the user freq
>> limit is not the safest way.
>> Thus, this simple implementation moves the calculation of the proper
>> frequency to the sysfs write code, since it's called less often. The value
>> is then used as-is in the thermal framework without any hassle.
>>
>> As it's a RFC, it still misses the cpufreq sysfs implementation,
> 
> What exactly do you mean by this?

I haven't modified cpufreq.c and cpufreq_cooling.c because
maybe for CPUs there is a way to solve it differently or you might
don't want at all to modify CPUs code.

> 
>> but would be addressed if all agree.
> 
> Depending on the answers above.
> 
> But my general comment would be that it might turn out to be
> unrealistic to expect user space to know what frequency limit to use
> to get the desired result in terms of constraining power.
> 

There are scenarios, where middleware (which is aware what is on
the foreground in mobile) might limit the GPU max freq, to not
burn out some power spent on highest OPPs.

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpufreq_cooling.c#L443
[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/thermal/devfreq_cooling.c#L106


