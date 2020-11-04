Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609C82A6C5B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgKDSCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 13:02:55 -0500
Received: from foss.arm.com ([217.140.110.172]:41350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgKDSCz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Nov 2020 13:02:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AD34106F;
        Wed,  4 Nov 2020 10:02:54 -0800 (PST)
Received: from [10.57.56.213] (unknown [10.57.56.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01E03F718;
        Wed,  4 Nov 2020 10:02:51 -0800 (PST)
Subject: Re: [PATCH v3 0/3] CPUFreq: Add support for cpu performance
 dependencies
To:     Viresh Kumar <viresh.kumar@linaro.org>, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, Ionela Voinescu <Ionela.Voinescu@arm.com>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201103101840.yrgwmcjrnjn7n5q6@vireshk-i7>
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
Message-ID: <87558fa9-a4c6-38c9-bcc5-f736c0229f56@arm.com>
Date:   Wed, 4 Nov 2020 18:04:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201103101840.yrgwmcjrnjn7n5q6@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh, thanks for looking into this.

On 11/3/20 10:18 AM, Viresh Kumar wrote:
> On 02-11-20, 12:01, Nicola Mazzucato wrote:
>> Hi All,
>>
>> In this V3 posting I have replaced the new dt-binding with minor changes/
>> improvements for opp (since we are now using opp tables instead).
>> The RFC still stands on how to make this info available to sw consumers.
>>
>> In the RFC, I am proposing a simple addition of a performance dependencies
>> cpumask in CPUFreq core and an example of how drivers and consumers would
>> make use of it.
>> I also propose an alternative approach, which does not require changes in
>> CPUFreq core, but - possibly - in all the consumers.
>>
>> This is to support systems where exposed cpu performance controls are more
>> fine-grained that the platform's ability to scale cpus independently.
> 
> I was talking to Vincent about what you are doing here and we got a
> bit confused and so here are few questions that we had:
> 
> - Based on my previous understanding, you don't want software
>   coordination of frequencies (which is done by cpufreq today), but
>   want the hardware to do that and so you want per-cpu cpufreq
>   policies.

Correct. And this has been done for quite some time in some platforms.

> 
> - What's the real benefit of hardware coordination ? Want to make sure
>   I fully understand that.

The hardware coordination that is coming out by having per-cpu cpufreq policies
is not new, and works just fine in most of the systems.

The benefit of having per-cpu controls is that the firmware will take care of
the performance of the entire system. It is purely a delegation to firmware for
the performance optimizations.

> 
> - Because of hardware co-ordination of otherwise co-ordinated CPUs,
>   few things break. Thermal and EAS are some of the examples and so
>   you are trying to fix them here by proving them the missing
>   information again.

Correct. And for this I have proposed two ways.

> 
> - One other thing that breaks with this is freq-invariance in the
>   scheduler, as the scheduler won't see the real frequencies the
>   various CPUs are running at. Most of the hardware we have today
>   doesn't have counters, like AMUs, not sure if all future ones based
>   on SCMI will have that too, so how are they gong to be fixed ?
> 

Correct. freq-invariance without counters is trying to do its best based on the
information it has available. It definitely relies on the knowledge of the v/f
domains to work at its best so I think in the case of per-cpu it will follow the
same approach as others being affected (EAS, thermal).

>   And if we even have to fix this (freq invariance), what's hardware
>   coordination giving us that makes all this worth it ?

I suppose this is more a generic question for all the platforms running with h/w
coordination, but for our case is that the f/w will take care of the performance
optimizations for us :)

> 
> Sorry about the long list :)

No problem at all. Thank you for your time on this and I hope I have made bits
clearer.

Nicola

> 
