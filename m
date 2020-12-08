Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F102D2950
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 11:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgLHK53 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 05:57:29 -0500
Received: from foss.arm.com ([217.140.110.172]:47276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgLHK53 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 05:57:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF891FB;
        Tue,  8 Dec 2020 02:56:43 -0800 (PST)
Received: from [10.57.34.152] (unknown [10.57.34.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C6CA3F68F;
        Tue,  8 Dec 2020 02:56:41 -0800 (PST)
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-4-nicola.mazzucato@arm.com>
 <20201208055053.kggxw26kxtnpneua@vireshk-i7>
 <0e4d3134-f9b2-31fa-b454-fb30265a80b5@arm.com>
 <20201208072611.ptsqupv4y2wybs6p@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <83b8400f-8dc4-000e-d790-0bf584a75f48@arm.com>
Date:   Tue, 8 Dec 2020 10:58:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201208072611.ptsqupv4y2wybs6p@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/8/20 7:26 AM, Viresh Kumar wrote:
> On 08-12-20, 07:22, Nicola Mazzucato wrote:
>> On 12/8/20 5:50 AM, Viresh Kumar wrote:
>>> On 02-12-20, 17:23, Nicola Mazzucato wrote:
>>>>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>>>>  	if (nr_opp <= 0) {
>>>> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
>>>> -		ret = -EPROBE_DEFER;
>>>> -		goto out_free_opp;
>>>> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
>>>> +		if (ret) {
>>>> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
>>>> +			goto out_free_cpumask;
>>>> +		}
>>>> +
>>>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
>>>> +		if (ret) {
>>>> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>>>> +				__func__, ret);
>>>> +			goto out_free_cpumask;
>>>> +		}
>>>> +
>>>
>>> Why do we need to call above two after calling
>>> dev_pm_opp_get_opp_count() ?
>>
>> Sorry, I am not sure to understand your question here. If there are no opps for
>> a device we want to add them to it
> 
> Earlier we used to call handle->perf_ops->device_opps_add() and
> dev_pm_opp_set_sharing_cpus() before calling dev_pm_opp_get_opp_count(), why is
> the order changed now ?

True. The order has changed to take into account the fact that when we have
per-cpu + opp-shared, we don't need to add opps for devices which already have them.

> 
>> otherwise no need as they would be duplicated.
> 
> I am not sure why they would be duplicated in your case. I though
> device_opps_add() is responsible for dynamically adding the OPPs here.

In case of per-cpu + opp-shared, with the "previous order" we would try to add
opps to a device which already has them, in fact attempting to add duplicates.
Nothing wrong with it, but a lot of warnings are thrown.

> 
>>> And we don't check the return value of
>>> the below call anymore, moreover we have to call it twice now.
>>
>> This second get_opp_count is required such that we register em with the correct
>> opp number after having added them. Without this the opp_count would not be correct.
> 
> What if the count is still 0 ? What about deferred probe we were doing earlier ?

My assumption is to rely on the two above to fail if there was something wrong.
For the deferred probe, I am not sure it is still a useful case to have, but I
will let Sudeep have his view also on this.

> 

Thanks Viresh, hope it's a bit more clear now.
Nicola
