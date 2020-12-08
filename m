Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F32D2BBE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 14:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgLHNQD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 08:16:03 -0500
Received: from foss.arm.com ([217.140.110.172]:48696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgLHNQD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 08:16:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7181B30E;
        Tue,  8 Dec 2020 05:15:17 -0800 (PST)
Received: from [10.57.61.26] (unknown [10.57.61.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 295BB3F718;
        Tue,  8 Dec 2020 05:15:15 -0800 (PST)
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, vireshk@kernel.org, robh+dt@kernel.org,
        sboyd@kernel.org, nm@ti.com, daniel.lezcano@linaro.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-4-nicola.mazzucato@arm.com>
 <20201208055053.kggxw26kxtnpneua@vireshk-i7>
 <0e4d3134-f9b2-31fa-b454-fb30265a80b5@arm.com>
 <20201208072611.ptsqupv4y2wybs6p@vireshk-i7>
 <20201208112008.niesjrunxq2jz3kt@bogus>
 <1f9daaf8-e850-7c1b-7a32-71367982beaf@arm.com>
 <20201208122222.bp3o6y3xsxo642wd@bogus>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <508c46a8-bf5a-bf29-a1df-c9a96b3de5f6@arm.com>
Date:   Tue, 8 Dec 2020 13:17:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201208122222.bp3o6y3xsxo642wd@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All, thanks for your feedback, please see below

On 12/8/20 12:22 PM, Sudeep Holla wrote:
> On Tue, Dec 08, 2020 at 11:34:36AM +0000, Lukasz Luba wrote:
>>
>>
>> On 12/8/20 11:20 AM, Sudeep Holla wrote:
>>> On Tue, Dec 08, 2020 at 12:56:11PM +0530, Viresh Kumar wrote:
>>>> On 08-12-20, 07:22, Nicola Mazzucato wrote:
>>>>> On 12/8/20 5:50 AM, Viresh Kumar wrote:
>>>>>> On 02-12-20, 17:23, Nicola Mazzucato wrote:
>>>>>>>   	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>>>>>>>   	if (nr_opp <= 0) {
>>>>>>> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
>>>>>>> -		ret = -EPROBE_DEFER;
>>>>>>> -		goto out_free_opp;
>>>>>>> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
>>>>>>> +		if (ret) {
>>>>>>> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
>>>>>>> +			goto out_free_cpumask;
>>>>>>> +		}
>>>>>>> +
>>>>>>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
>>>>>>> +		if (ret) {
>>>>>>> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>>>>>>> +				__func__, ret);
>>>>>>> +			goto out_free_cpumask;
>>>>>>> +		}
>>>>>>> +
>>>>>>
>>>>>> Why do we need to call above two after calling
>>>>>> dev_pm_opp_get_opp_count() ?
>>>>>
>>>>> Sorry, I am not sure to understand your question here. If there are no opps for
>>>>> a device we want to add them to it
>>>>
>>>> Earlier we used to call handle->perf_ops->device_opps_add() and
>>>> dev_pm_opp_set_sharing_cpus() before calling dev_pm_opp_get_opp_count(), why is
>>>> the order changed now ?
>>>>
>>>>
>>>> I am not sure why they would be duplicated in your case. I though
>>>> device_opps_add() is responsible for dynamically adding the OPPs here.
>>>>
>>>
>>> It is because of per-CPU vs per domain drama here. Imagine a system with
>>> 4 CPUs which the firmware puts in individual domains while they all are
>>> in the same perf domain and hence OPP is marked shared in DT.
>>>
>>> Since this probe gets called for all the cpus, we need to skip adding
>>> OPPs for the last 3(add only for 1st one and mark others as shared).
>>> If we attempt to add OPPs on second cpu probe, it *will* shout as duplicate
>>> OPP as we would have already marked it as shared table with the first cpu.
>>> Am I missing anything ? I suggested this as Nicola saw OPP duplicate
>>> warnings when he was hacking up this patch.
>>>
>>>>> otherwise no need as they would be duplicated.
>>>>>> And we don't check the return value of
>>>>>> the below call anymore, moreover we have to call it twice now.
>>>
>>> Yes, that looks wrong, we need to add the check for non zero values, but ....

will add the check, thanks

>>>
>>>>>
>>>>> This second get_opp_count is required such that we register em with the correct
>>>>> opp number after having added them. Without this the opp_count would not be correct.
>>>>
>>>
>>> ... I have a question here. Why do you need to call
>>>
>>> em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, opp_shared_cpus..)
>>>
>>> on each CPU ? Why can't that be done once for unique opp_shared_cpus ?

I left it untouched to reduce changes, but I see your point.

>>
>> It just have to be called once, for one CPU from the mask. Otherwise for
>> the next CPUs you should see error:
>> "EM: exists for CPU%d"
> 
> OK cool, at least it is designed and expected to be used like I thought.
> Ah, I might have seen those, but never thought it was error message 😄 
> 
>> It can happen that this print is not seen when the get_cpu_device(cpu)
>> failed, but that would lead to investigation why CPU devices are not
>> there yet.
>>
>> Nicola: have you seen that print?
>>
> 
> I assume you must see that and you need to pull this inside if condition
> to do this once for each performance domain.

I don't see that error, and that's also why I left it there. If there's already
and em_pd for a device, EM just returns with an error that we don't check.

I agree that it makes more sense to register em for opp_shared_cpus.

> 
> --
> Regards,
> Sudeep
> 
