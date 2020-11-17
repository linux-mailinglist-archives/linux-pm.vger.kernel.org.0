Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B972B5D32
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 11:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgKQKrZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 05:47:25 -0500
Received: from foss.arm.com ([217.140.110.172]:53830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgKQKrZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 05:47:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69CA3D6E;
        Tue, 17 Nov 2020 02:47:24 -0800 (PST)
Received: from [10.57.25.49] (unknown [10.57.25.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 206DF3F718;
        Tue, 17 Nov 2020 02:47:20 -0800 (PST)
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-4-nicola.mazzucato@arm.com>
 <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
 <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
 <20201106105514.bhtdklyhn7goml64@vireshk-i7>
 <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
 <20201109065742.22czfgyjhsjmkytf@vireshk-i7>
 <2fa8a5c0-f66d-34bc-7f1c-8462e7532e0a@arm.com>
 <20201117101128.6uapqg56arwqmm5p@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <117c6d30-0013-7222-dedb-57e65ba84d15@arm.com>
Date:   Tue, 17 Nov 2020 10:47:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201117101128.6uapqg56arwqmm5p@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/17/20 10:11 AM, Viresh Kumar wrote:
> On 16-11-20, 11:33, Lukasz Luba wrote:
>> On 11/9/20 6:57 AM, Viresh Kumar wrote:
>>> On 06-11-20, 11:14, Lukasz Luba wrote:
>>>> I also had similar doubts, because if we make frequency requests
>>>> independently for each CPU, why not having N cooling devs, which
>>>> will set independently QoS max freq for them...
>>>>
>>>> What convinced me:
>>>> EAS and FIE would know the 'real' frequency of the cluster, IPA
>>>> can use it also and have only one cooling device per cluster.
>>>>
>>>> We would like to keep this old style 'one cooling device per cpuset'.
>>>> I don't have strong opinion and if it would appear that there are
>>>> some errors in freq estimation for cluster, then maybe it does make
>>>> more sense to have cdev per CPU...
>>>
>>> Let me rephrase my question. What is it that doesn't work _correctly_
>>> with cdev per cpufreq policy in your case? What doesn't work well if
>>> the thermal stuff keeps looking at only the related_cpus thing and not
>>> the cpu-perf-dependencies thing?
>>>
>>
>> We don't have a platform which would be this per-cpu freq request, yet.
>> Thus it's hard to answer your question. The EAS would work in 'old
>> style' - cluster mode. I don't know how IPA would work on such HW
>> and SW configuration. To figure this out I need a real platform.
> 
> Hmm, so who are going to be the users of this new stuff (dependent
> CPUs) ? I don't think cpufreq-cooling should be updated, unless there
> is a compelling reason to.

Fair enough. What if we come back with experiments results in future?
Currently we are trying to conduct experiments with Nicola on modified 
Juno firmware and kernel)

> 
> The other one in energy model ? Why does it need this information ?

The energy model needs this information, because it's used during the
sched domain re-build. The sched domain is then used in the EAS main
functions: feec() [1] and compute_energy() [2].
What EAS normally does is 'trying different options to put a task
on different CPUs and observe the potential energy costs'.
Example, we need the 'cluster' frequency, because when you put a task on
a CPU its freq might need to be set a bit higher. This would affect all
CPUs in the cluster not only one and we capture that energy cost. Then,
we try to put a task on other CPU in that cluster and if it appears to
be no need of rising freq for the whole cluster, then it wins.


> 
> Who else ?
> 

FIE..
