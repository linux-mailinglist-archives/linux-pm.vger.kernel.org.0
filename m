Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216C72A9481
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKFKiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:38:12 -0500
Received: from foss.arm.com ([217.140.110.172]:34668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbgKFKh6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B57BA147A;
        Fri,  6 Nov 2020 02:37:56 -0800 (PST)
Received: from [10.57.14.85] (unknown [10.57.14.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE973F719;
        Fri,  6 Nov 2020 02:37:53 -0800 (PST)
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-4-nicola.mazzucato@arm.com>
 <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
Date:   Fri, 6 Nov 2020 10:37:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 11/6/20 9:20 AM, Viresh Kumar wrote:
> On 02-11-20, 12:01, Nicola Mazzucato wrote:
>> This is a continuation of the previous v2, where we focused mostly on the
>> dt binding.
>>
>> I am seeking some feedback/comments on the following two approaches.
>>
>> Intro:
>> We have seen that in a system where performance control and hardware
>> description do not match (i.e. per-cpu), we still need the information of
>> how the v/f lines are shared among the cpus. We call this information
>> "performance dependencies".
>> We got this info through the opp-shared (the previous 2 patches aim for
>> that).
>>
>> Problem:
>> How do we share such info (retrieved from a cpufreq driver) to other
>> consumers that rely on it? I have two proposals.
> 
> I haven't really stop thinking about what and how we should solve
> this, but I have few concerns first.
> 
>> 2) drivers/thermal/cpufreq_cooling: Replace related_cpus with dependent_cpus
> 
> I am not sure if I understand completely on how this is going to be
> modified/work.
> 
> The only use of related_cpus in the cooling driver is in the helper
> cdev->get_requested_power(), where we need to find the total power
> being consumed by devices controlled by the cooling device. Right ?
> 
> Now the cooling devices today are very closely related to the cpufreq
> policy, the registration function itself takes a cpufreq policy as an
> argument.
> 
> Consider that you have an octa-core platform and all the CPUs are
> dependent on each other. With your suggested changes and hw control,
> we will have different cpufreq policies for each CPU. And so we will
> have a cooling device, cdev, for each CPU as well. When the IPA
> governor calls cdev->get_requested_power(), why should we ever bother
> to traverse the list of dependent_cpus and not related_cpus only ?
> 
> Otherwise the same CPU will have its load contributed to the power of
> 8 cooling devices.
> 

Good question.

How about a different interface for those cpufreq drivers?
That new registration API would allow to specify the cpumask.
Or rely on EM cpumask: em_span_cpus(em)

Currently we have two ways to register cooling device:
1. when the cpufreq driver set a flag CPUFREQ_IS_COOLING_DEV, the core
will register cooling device
2. cpufreq driver can explicitly call the registration function:
cpufreq_cooling_register() with 'policy' as argument

That would need substantial change to the cpufreq cooling code, from
policy oriented to custom driver's cpumask (like EM registration).

Regards,
Lukasz
