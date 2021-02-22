Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA03215DA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 13:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBVMLk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 07:11:40 -0500
Received: from foss.arm.com ([217.140.110.172]:44114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhBVMLi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Feb 2021 07:11:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95381FB;
        Mon, 22 Feb 2021 04:10:52 -0800 (PST)
Received: from [10.57.51.123] (unknown [10.57.51.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754373F70D;
        Mon, 22 Feb 2021 04:10:50 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, Dietmar.Eggemann@arm.com,
        amitk@kernel.org, rui.zhang@intel.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20210126104001.20361-1-lukasz.luba@arm.com>
 <2f4d7bf2-3f3e-ac24-20fb-b8d66dcdd809@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <042c06a3-eae4-85e4-54cd-4389cc343eb1@arm.com>
Date:   Mon, 22 Feb 2021 12:10:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2f4d7bf2-3f3e-ac24-20fb-b8d66dcdd809@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 2/22/21 10:22 AM, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> sorry for the delay, it took more time to finish my current work before
> commenting these patches.

No worries, thank you looking at this.

> 
> On 26/01/2021 11:39, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set tries to add the missing feature in the Intelligent Power
>> Allocation (IPA) governor which is: frequency limit set by user space.
> 
> It is unclear if we are talking about frequency limit of the dvfs device
> by setting the hardware limit (min-max freq). If it is the case, then
> that is an energy model change, and all user of the energy model must be
> notified about this change. But I don't see why userspace wants to
> change that.
> 
> If we just want to set a frequency limit, then that is what we are doing
> with the DTPM framework via power numbers.
> 
>> User can set max allowed frequency for a given device which has impact on
>> max allowed power. In current design there is no mechanism to figure this
>> out. IPA must know the maximum allowed power for every device. It is then
>> used for proper power split and divvy-up. When the user limit for max
>> frequency is not know, IPA assumes it is the highest possible frequency.
>> It causes wrong power split across the devices.
> 
> That is because the IPA introduced the power rebalancing between devices
> belonging the same thermal zone, so the feature was very use case specific.
> 
> The DTPM is supposed to solve this by providing an unified uW unit to
> act on the different power capable devices on a generic way.
> 
> Today DTPM is mapped to userspace using the powercap framework, but it
> is considered to add kernel API to let other subsystem to act on it
> directly. May be, you can add those and call them from IPA directly, so
> the governor does power decision and ask the DTPM to do the changes.
> 
> Conceptually, that would be much more consistent and will remove
> duplicated code IMO.
> 
> May be create a power_qos framework to unify the units ...
> 
>> This new mechanism provides the max allowed frequency to the thermal
>> framework and then max allowed power to the IPA.
>> The implementation is done in this way because currently there is no way
>> to retrieve the limits from the PM QoS, without uncapping the local
>> thermal limit and reading the next value. It would be a heavy way of
>> doing these things, since it should be done every polling time (e.g. 50ms).
>>
>> Also, the value stored in PM QoS can be different than the real OPP 'rate'
>> so still would need conversion into proper OPP for comparison with EM.
>> Furthermore, uncapping the device in thermal just to check the user freq
>> limit is not the safest way.
>> Thus, this simple implementation moves the calculation of the proper
>> frequency to the sysfs write code, since it's called less often. The value
>> is then used as-is in the thermal framework without any hassle.
> 
> Sounds like the DTPM is doing exactly that, no ?
> 
>> As it's a RFC, it still misses the cpufreq sysfs implementation, but would
>> be addressed if all agree.
> We are talking about power, frequency, in-kernel governor, userspace
> having knowledge of max frequency limit to set power.
> 
> I'm a bit lost. What is the problem we want to solve here ?
> 
> May be I'm missing something. Is it possible to share a scenario where
> the userspace acts on the devfreq and the IPA taking decision to
> illustrate your proposal ?
> 
> 

Sure, here is the description of the configuration and scenario in which
the issue is present.
SoC with 2 CPU clusters (consuming 1W (little cluster) and 3W (big
cluster) at max freq, plenty of OPPs available),
1 GPU (at max consuming ~6W, a few of OPPs),

Scenario:
IPA is working because temperature crossed 1st threshold and tries to
control the system to 'converge' to 2nd temp threshold. It checks
the actors max possible power [1], gets the current power, calculates
current budget, split that budget and grants power across actors so
max allowed frequency is set via QoS.

The state2power() callback called at [1] with argument '0' would return
the power from EM for the highest OPP. This is fine in most cases. That
power information is used in line 359 and 364 during the split.

If the user-space (the aware middleware) wants to switch into different
power-performance mode e.g. power-saving, it writes into device sysfs
to limit max allowed freq. Then IPA does not know about it and makes
wrong decisions. It's an issue for GPUs (but CPUs also) which can
consume big power at higher freq. For example to limit this 6W into
3W, simple freq write via sysfs is enough, but IPA completely is not
aware of that (as you can see in the code).

The sysfs interface for GPU:
$ cat /sys/class/devfreq/<device>/available_frequencies
400000000 600000000 800000000 1000000000

$ echo 600000000 > /sys/class/devfreq/<device>/max_freq
$ cat /sys/class/devfreq/<device>/max_freq
600000000

IMHO is not an issue of IPA, because DTPM might suffer for this
missing 'user write' information as well. It's just missing
design feature, to provide that user information further to the
other frameworks or governors.

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/thermal/gov_power_allocator.c#L458

