Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D248F2074C2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbgFXNmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 09:42:14 -0400
Received: from foss.arm.com ([217.140.110.172]:51184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388453AbgFXNmO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jun 2020 09:42:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1B81F1;
        Wed, 24 Jun 2020 06:42:13 -0700 (PDT)
Received: from [10.37.12.79] (unknown [10.37.12.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97BAD3F6CF;
        Wed, 24 Jun 2020 06:42:10 -0700 (PDT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kamil Konieczny <k.konieczny@samsung.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
 <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
 <20200623191129.GA4171@kozik-lap>
 <CGME20200624103308eucas1p29c8572979809b129ff8ac729c6c728e2@eucas1p2.samsung.com>
 <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
 <828b0d63-4d01-48d6-5971-64855adebed2@samsung.com>
 <20200624120651.GA20813@pi3> <55772862-ff8f-1e1d-91ae-7b4d7c3be1b6@arm.com>
 <20200624131341.GA20905@pi3>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c3b4d74e-0e0e-590d-0588-3ff9756f8050@arm.com>
Date:   Wed, 24 Jun 2020 14:42:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624131341.GA20905@pi3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/24/20 2:13 PM, Krzysztof Kozlowski wrote:
> On Wed, Jun 24, 2020 at 02:03:03PM +0100, Lukasz Luba wrote:
>>
>>
>> On 6/24/20 1:06 PM, Krzysztof Kozlowski wrote:
>>> My case was clearly showing wrong behavior. System was idle but not
>>> sleeping - network working, SSH connection ongoing.  Therefore at least
>>> one CPU was not idle and could adjust the devfreq/DMC... but this did not
>>> happen. The system stayed for like a minute in 633 MHz OPP.
>>>
>>> Not-waking up idle processors - ok... so why not using power efficient
>>> workqueue? It is exactly for this purpose - wake up from time to time on
>>> whatever CPU to do the necessary job.
>>
>> IIRC I've done this experiment, still keeping in devfreq:
>> INIT_DEFERRABLE_WORK()
>> just applying patch [1]. It uses a system_wq which should
>> be the same as system_power_efficient_wq when
>> CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set (our case).
>> This wasn't solving the issue for the deferred work. That's
>> why the patch 2/2 following patch 1/2 [1] was needed.
>>
>> The deferred work uses TIMER_DEFERRABLE in it's initialization
>> and this is the problem. When the deferred work was queued on a CPU,
>> next that CPU went idle, the work was not migrated to some other CPU.
>> The former cpu is also not woken up according to the documentation [2].
> 
> Yes, you need either workqueue.power_efficient kernel param or CONFIG
> option to actually enable it.  But at least it could then work on any
> CPU.
> 
> Another solution is to use directly WQ_UNBOUND.
> 
>> That's why Kamil's approach should be continue IMHO. It gives more
>> control over important devices like: bus, dmc, gpu, which utilization
>> does not strictly correspond to cpu utilization (which might be low or
>> even 0 and cpu put into idle).
>>
>> I think Kamil was pointing out also some other issues not only dmc
>> (buses probably), but I realized too late to help him.
> 
> This should not be a configurable option. Why someone would prefer to
> use one over another and decide about this during build or run time?
> Instead it should be just *right* all the time. Always.

I had the same opinion, as you can see in my explanation to those
patches, but I failed. That's why I agree with Kamil's approach
because had higher chance to get into mainline and fix at least some
of the use cases.

> 
> Argument that we want to save power so we will not wake up any CPU is
> ridiculous if because of this system stays in high-power mode.
> 
> If system is idle and memory going to be idle, someone should be woken
> up to save more power and slow down memory controller.
> 
> If system is idle but memory going to be busy, the currently busy CPU
> (which performs some memory-intensive job) could do the job and ramp up
> the devfreq performance.

I agree. I think this devfreq mechanism was designed in the times
where there was/were 1 or 2 CPUs in the system. After a while we got ~8
and not all of them are used. This scenario was probably not
experimented widely on mainline platforms.

That is a good material for improvements, for someone who has time and
power.

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
> 
