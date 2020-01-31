Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3B14EA2E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 10:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgAaJi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 04:38:28 -0500
Received: from foss.arm.com ([217.140.110.172]:33500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgAaJi1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jan 2020 04:38:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32552FEC;
        Fri, 31 Jan 2020 01:38:26 -0800 (PST)
Received: from [10.37.12.196] (unknown [10.37.12.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8043F68E;
        Fri, 31 Jan 2020 01:38:22 -0800 (PST)
Subject: Re: [PATCH 0/1] drivers: devfreq: use DELAYED_WORK in DEVFREQ
 monitoring subsystem
To:     Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, Kamil Konieczny <k.konieczny@samsung.com>
References: <20200127151731.8640-1-lukasz.luba@arm.com>
 <CGME20200130114724epcas1p1b2a9ea756c7d53a2f26b60abbef0ab51@epcas1p1.samsung.com>
 <b4d1624f-4ca8-c985-ff42-f5f677c72fa9@arm.com>
 <6107fa2b-81ad-060d-89a2-d8941ac4d17e@samsung.com>
 <f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <729911b2-434b-fbe5-b556-5bdba8114085@arm.com>
Date:   Fri, 31 Jan 2020 09:38:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f5c5cd64-b72c-2802-f6ea-ab3d28483260@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 1/31/20 12:47 AM, Chanwoo Choi wrote:
> On 1/31/20 9:42 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 1/30/20 8:47 PM, Lukasz Luba wrote:
>>> Hi Chanwoo, MyungJoo,
>>>
>>> Gentle ping. The issue is not only in the devfreq itself,
>>> but also it affects thermal. The devfreq cooling rely on
>>> busy_time and total_time updated by the devfreq monitoring
>>> (in simple_ondemand).
>>> Thermal uses DELAYED_WORK and is more reliable, but uses stale
>>> data from devfreq_dev_stats. It is especially visible when
>>> you have cgroup spanning one cluster. Android uses cgroups
>>> heavily. You can make easily this setup using 'taskset',
>>> run some benchmarks and observe 'devfreq_monitor' traces and
>>> timestamps, i.e. for your exynos-bus.
>>>
>>> The patch is really non-invasive and simple. It can be a good starting
>>> point for testing and proposing other solutions.
>>
>> Sorry for late reply. I'm preparing the RFC patch about my approach
>> to support this requirement as following:
>>
>> As you knew, DEFERRABLE_WORK with CONFIG_NO_HZ focuses on removing
>> the redundant of power-consumption by preventing the unneeded wakeup
>> from idle state if there are no any interrupts and runnable threads.
>>
>> Finally, I agree the requirement of delaywd_work for devfreq subsystem.
>> But, I would like to support both deferrable_work and delayed_work
>> on devfreq subsystem. It is better to select either deferrable_work
>> or delayed_work by user like Kamil's suggestion[1].
>> [1] https://lore.kernel.org/patchwork/patch/1164317/
>> - [2/4] PM / devfreq: add possibility for delayed work
>>
>> But, I want to change the timer type for devfreq device
>> using simple_ondemand governor via sysfs as following:
>>
>> Example:
>>
>> 1.
>> enum work_timer_type {
>> 	DEVFREQ_WORK_TIMER_DEFERRABLE = 0,
>> 	DEVFREQ_WORK_TIMER_DELAYED = 0,
>> };
>>
>> struct devfreq_simple_ondemand_data {
>> 	unsigned int upthreshold;
>> 	unsigned int downdifferential;
>> 	enum work_timer_type timer_type;
>> };
>>
>> The developer of devfreq device driver can choose
>> the default work time type by initializing the 'timer_type of
>> struct devfreq_simple_ondemand_data'.
>>
>> 2. Change the work timer type at the runtime
>> - Change the work timer type from 'deferrable' to 'delayed'
>> $ echo delayed > /sys/class/devfreq/devfreq0/work_timer_type
>> $ cat /sys/class/devfreq/devfreq0/work_timer_type
>> delayed
>>
>> - Change the work timer type from 'delayed' to 'deferrable'
>> $ echo deferrable > /sys/class/devfreq/devfreq0/work_timer_type
>> $ cat /sys/class/devfreq/devfreq0/work_timer_type
>> deferrable
>>
> 
> And
> Only show '/sys/class/devfreq/devfreq0/work_timer_type' sysfs attribute,
> if devfreq device uses the simple_ondemand. Because this 'work_timer_type'
> sysfs attribute only depends on simple_ondemand governor and are useful.
> 
> So, 'work_timer_type' sysfs attribute will be handled
> at drivers/devfreq/governor_simpleondemand.c.
> 
> After posting my suggestion, we can discuss it.
> 
> 
>> I'm developing the RFC patch and then I'll send it as soon as possible.

Good, thank you for the explanation. For the first glance the design
looks OK, we can discuss it a bit more in you RFC series.
I would recommend to not make it conditional on simple_ondemand governor
just add a comment that for i.e. performance or passive governors it has
less sense to use this setting. There might be some other governors
loaded as modules, which could benefit from it, or in Android e.g.
https://android.googlesource.com/kernel/msm/+/refs/heads/android-msm-coral-4.14-android10/drivers/devfreq/governor_msm_adreno_tz.c

It would be good if it can land in mainline before v5.8-v5.9.

Regards,
Lukasz


