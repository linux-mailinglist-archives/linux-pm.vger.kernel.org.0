Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD310B1B6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 15:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0O6z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 09:58:55 -0500
Received: from foss.arm.com ([217.140.110.172]:48630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfK0O6z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 09:58:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A22E430E;
        Wed, 27 Nov 2019 06:58:52 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 268D63F68E;
        Wed, 27 Nov 2019 06:58:51 -0800 (PST)
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
 <20191127120816.GC29301@bogus> <20191127121402.vd3tul4gmqm6qtyb@vireshk-i7>
 <20191127133200.GE29301@bogus>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a60cab69-4d47-d418-94bd-74630bf9e846@arm.com>
Date:   Wed, 27 Nov 2019 15:58:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191127133200.GE29301@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/11/2019 14:32, Sudeep Holla wrote:
> On Wed, Nov 27, 2019 at 05:44:02PM +0530, Viresh Kumar wrote:
>> On 27-11-19, 12:08, Sudeep Holla wrote:
>>> On Wed, Nov 27, 2019 at 12:48:01PM +0100, Dietmar Eggemann wrote:

[...]

>>> Unlike DT based drivers, it not easy to get the fixed cpumask unless we
>>> add some mechanism to extract it based on clks/OPP added. I prefer
>>> this simple solution instead.
>>
>> I will call this a work-around for the problem and not really the
>> solution, though I won't necessarily oppose it. There are cases which
>> will break even with this solution.
>>
> 
> I agree and that's the reason I spoke out my thought aloud here :)
> 
>> - Boot board with cpufreq driver as module.
>> - Offline all CPUs except CPU0.
>> - insert cpufreq driver.
>> - online all CPUs.
>>
> 
> Indeed, not just boot anytime since it's a module :)
> 
>> Now there is no guarantee that the last online will get the mask
>> properly, if I have understood the problem well :)
>>
> 
> Yes
> 
>> But yeah, who does this kind of messy work anyway :)
>>
> 
> I won't bet on that ;)
> 
>> FWIW, we need a proper way (may be from architecture code) to find
>> list of all CPUs that share clock line.
>>
> 
> Yes but there's no architectural way. I need to revise and see tc2_pm.c
> to check if we can do any magic there.

I'm fine with finding a better solution to return a fixed topology core
cpumask or calling this patch a workaround. AFAICS, only TC2 is affected.

("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
is needed for other systems as well in case we have commit ca74b316df96
("arm: Use common cpu_topology structure and functions."). We probably
don't want to revert commit ca74b316df96?

We do CPU hp stress tests in our EAS mainline integration test suite
https://developer.arm.com/tools-and-software/open-source-software/linux-kernel/energy-aware-scheduling/eas-mainline-development
and there is where we initially encountered this issue on TC2.
