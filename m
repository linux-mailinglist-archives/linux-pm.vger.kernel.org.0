Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15B42A0599
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 13:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJ3Mks (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 08:40:48 -0400
Received: from foss.arm.com ([217.140.110.172]:33650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgJ3Mks (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Oct 2020 08:40:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FCFA1063;
        Fri, 30 Oct 2020 05:40:47 -0700 (PDT)
Received: from [10.57.13.192] (unknown [10.57.13.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7143C3F68F;
        Fri, 30 Oct 2020 05:40:44 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add sustainable OPP concept
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
 <20201029075356.rruej6jlerhfa4oy@vireshk-i7>
 <228fa1b3-bbd3-6941-fd4b-06581016d839@arm.com>
 <20201030082937.xgjmko2ohwhkt6f5@vireshk-i7>
 <a0a6db69-fc3e-c39f-7586-5ac3227b746e@arm.com>
 <20201030095248.abej6h5wphud2ihb@vireshk-i7>
 <757fe3b1-745f-2656-fe21-c7b39f123a25@arm.com>
 <20201030111751.i7zdsi7ruzmnyxk6@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <468065c6-d604-5691-cddf-3eca20035bba@arm.com>
Date:   Fri, 30 Oct 2020 12:40:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201030111751.i7zdsi7ruzmnyxk6@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/30/20 11:17 AM, Viresh Kumar wrote:
> On 30-10-20, 10:56, Lukasz Luba wrote:
>> IPA tries to do that, even dynamically when e.g. GPU is supper busy
>> in 3D games (~2000W) or almost idle showing 2D home screen.
>> It tries to find highest 'sustainable' frequencies for the devices,
>> at that various workloads and temp. But it needs some coefficients to
>> start, which have big impact on the algorithm. It could slow down IPA a
>> lot, when those coefficients are calculated based on lowest OPPs.
> 
> I see. So when you say it slows down IPA, what does that really mean ?
> IPA isn't performing that accurately during the initial period of
> booting (any time estimate here) ? Does it work fine after a time
> duration? Or will it suffer for ever ?

The coefficients would stay 'forever', which determine the temp rising
slope, until someone change them via sysfs (the: k_po, k_pu, k_i,
sustainable_power).

> 
> And maybe you shouldn't start with the lowest OPPs while you calculate
> these coefficients dynamically ? Maybe start from the middle ? As the
> sustainable OPP would be something there only or maybe a bit higher
> only. But yeah, I don't have any idea about how those coefficients are
> calculated so this idea can be simply ignored as well :)
> 
>> My backup plan was to add a flag into EM em_perf_state, extend SCMI perf
>> exposing the 'sustained_freq_khz' to scmi-cpufreq, which would set that
>> field after registering EM. IPA depends on EM, so should be OK.
> 
> I think at this point (considering the limited number of users (only
> IPA) and providers (only SCMI)), it would be better that way only
> instead of updating the OPP framework. Of course we can revisit that
> if we ever feel that we need a better placeholder for it.

OK, sounds good.

> 
>>> So only SCMI based platforms will be able to use this stuff ? That's
>>> very limited, isn't it ? I think we should still try to make it better
>>> for everyone by making the software smarter. It has so much data, the
>>> OPPs, the power it will consume (based on microvolt property?), the
>>> heat we produce from that (from thermal framework), etc. Perhaps
>>> building this information continuously at runtime based on when and
>>> how we hit the trip points ? So we know which is the right frequency
>>> where we can refrain from hitting the trip points.
>>
>> IPA works in this way.
> 
> Nice, that's what I thought as well but then got a bit confused with
> your patchset.
> 
>>> But may be I am asking too much :(
>>>
>>
>> When you asked for user of this, I gave you instantly. This is one is
>> more difficult. I am still not there with IPA tests in LISA. I have some
>> out-of-tree kernel driver for testing, which also need polishing before
>> can be used with LISA. Then proper workloads with results processing.
>> EM for devfreq cooling devices. Then decent 'hot' board running
>> preferably mainline kernel.
>> What you requested is on my list, but it needs more work, which
>> won't be ready over night.
> 
> I can understand what you are trying to do here. And this surely
> requires a lot of effort.
> 

Thank you Viresh for your opinion.
I will take the EM approach, please ignore this patch set.

Regards,
Lukasz
