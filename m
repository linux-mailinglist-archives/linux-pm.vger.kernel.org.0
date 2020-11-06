Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5AA2A9510
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 12:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgKFLO2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 06:14:28 -0500
Received: from foss.arm.com ([217.140.110.172]:35446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgKFLO1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Nov 2020 06:14:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3D84147A;
        Fri,  6 Nov 2020 03:14:26 -0800 (PST)
Received: from [10.57.14.85] (unknown [10.57.14.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745553F719;
        Fri,  6 Nov 2020 03:14:23 -0800 (PST)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
Date:   Fri, 6 Nov 2020 11:14:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201106105514.bhtdklyhn7goml64@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/6/20 10:55 AM, Viresh Kumar wrote:
> On 06-11-20, 10:37, Lukasz Luba wrote:
>> Good question.
>>
>> How about a different interface for those cpufreq drivers?
>> That new registration API would allow to specify the cpumask.
>> Or rely on EM cpumask: em_span_cpus(em)
>>
>> Currently we have two ways to register cooling device:
>> 1. when the cpufreq driver set a flag CPUFREQ_IS_COOLING_DEV, the core
>> will register cooling device
>> 2. cpufreq driver can explicitly call the registration function:
>> cpufreq_cooling_register() with 'policy' as argument
>>
>> That would need substantial change to the cpufreq cooling code, from
>> policy oriented to custom driver's cpumask (like EM registration).
> 
> I am even wondering if we should really make that change. Why do we
> need the combined load of the CPUs to be sent back to the IPA governor
> ? Why shouldn't they all do that (they == cdev) ?
> 
> This is a bit confusing to me, sorry about that. The cpufreq governors
> take a look at all the CPUs utilization and set the frequency based on
> the highest utilization (and not the total util).
> 
> While in this case we present the total load of the CPUs to the IPA
> (based on the current frequency of the CPUs), in response to which it
> tells us the frequency at which all the CPUs of the policy can run at
> (I am not even sure if it is the right thing to do as the CPUs have
> different loads). And how do we fit this dependent_cpus thing into
> this.
> 
> Sorry, I am not sure what's the right way of doing thing here.
> 

I also had similar doubts, because if we make frequency requests
independently for each CPU, why not having N cooling devs, which
will set independently QoS max freq for them...

What convinced me:
EAS and FIE would know the 'real' frequency of the cluster, IPA
can use it also and have only one cooling device per cluster.

We would like to keep this old style 'one cooling device per cpuset'.
I don't have strong opinion and if it would appear that there are
some errors in freq estimation for cluster, then maybe it does make
more sense to have cdev per CPU...



