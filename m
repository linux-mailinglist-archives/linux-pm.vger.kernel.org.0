Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9406F2D3E6E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 10:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgLIJTU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 04:19:20 -0500
Received: from foss.arm.com ([217.140.110.172]:59866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgLIJTS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Dec 2020 04:19:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE5AF1FB;
        Wed,  9 Dec 2020 01:18:31 -0800 (PST)
Received: from [10.57.54.135] (unknown [10.57.54.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF69D3F718;
        Wed,  9 Dec 2020 01:18:29 -0800 (PST)
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
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
 <20201209054502.ajomw6glcxx5hue2@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <a70cfb32-1a5f-d12f-f466-321d60e58204@arm.com>
Date:   Wed, 9 Dec 2020 09:20:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201209054502.ajomw6glcxx5hue2@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi both,

thanks for looking into this.

On 12/9/20 5:45 AM, Viresh Kumar wrote:
> On 08-12-20, 11:20, Sudeep Holla wrote:
>> It is because of per-CPU vs per domain drama here. Imagine a system with
>> 4 CPUs which the firmware puts in individual domains while they all are
>> in the same perf domain and hence OPP is marked shared in DT.
>>
>> Since this probe gets called for all the cpus, we need to skip adding
>> OPPs for the last 3(add only for 1st one and mark others as shared).
> 
> Okay and this wasn't happening before this series because the firmware
> was only returning the current CPU from scmi_get_sharing_cpus() ?

yes

> 
> Is this driver also used for the cases where we have multiple CPUs in
> a policy ? Otherwise we won't be required to call
> dev_pm_opp_set_sharing_cpus().
> 
> So I assume that we want to support both the cases here ?

yes, we want to support existing platforms (n cpus in a policy) + the per-cpu case.

> 
>> If we attempt to add OPPs on second cpu probe, it *will* shout as duplicate
>> OPP as we would have already marked it as shared table with the first cpu.
>> Am I missing anything ? I suggested this as Nicola saw OPP duplicate
>> warnings when he was hacking up this patch.
> 
> The common stuff (for all the CPUs) is better moved to probe() in this
> case, instead of the ->init() callback. Otherwise it will always be
> messy. You can initialize the OPP and cpufreq tables in probe()
> itself, save the pointer somewhere and then just use it here in
> ->init().
> 
> Also do EM registration from there.
>

ok, will rework

>>>> otherwise no need as they would be duplicated.
>>>>> And we don't check the return value of
>>>>> the below call anymore, moreover we have to call it twice now.
>>
>> Yes, that looks wrong, we need to add the check for non zero values, but ....
>>
>>>>
>>>> This second get_opp_count is required such that we register em with the correct
>>>> opp number after having added them. Without this the opp_count would not be correct.
>>>
>>
>> ... I have a question here. Why do you need to call
>>
>> em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, opp_shared_cpus..)
>>
>> on each CPU ? Why can't that be done once for unique opp_shared_cpus ?
>>
>> The whole drama of per-CPU vs perf domain is to have energy model and
>> if feeding it opp_shared_cpus once is not sufficient, then something is
>> wrong or simply duplicated or just not necessary IMO.
>>
>>> What if the count is still 0 ? What about deferred probe we were doing earlier ?
>>
>> OK, you made me think with that question. I think the check was original
>> added for deferred probe but then scmi core was changed to add the cpufreq
>> device only after everything needed is ready. So the condition must never
>> occur now.
> 
> The deferred probe shall be handled in a different patch in that case.
> 
> Nicola, please break the patch into multiple patches, with one patch
> dealing only with one task.

Sure, I had the doubt and thanks for confirming. will do, thanks

> 

Cheers,
Nicola
