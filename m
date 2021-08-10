Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071283E5804
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbhHJKL4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:11:56 -0400
Received: from foss.arm.com ([217.140.110.172]:52896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhHJKL4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 06:11:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 608E46D;
        Tue, 10 Aug 2021 03:11:34 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8384F3F70D;
        Tue, 10 Aug 2021 03:11:32 -0700 (PDT)
Subject: Re: [PATCH 8/8] cpufreq: vexpress: Use auto-registration for energy
 model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <87fecd84e3f6ff6f153be14b0d53de93c0b04ae6.1628579170.git.viresh.kumar@linaro.org>
 <d3629cc7-d9db-0e54-94e9-278e308b7e8e@arm.com>
 <20210810100652.h473q6hgtc5czfyk@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2210acb9-2666-7aa9-d36c-346480541f3c@arm.com>
Date:   Tue, 10 Aug 2021 11:11:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210810100652.h473q6hgtc5czfyk@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/10/21 11:06 AM, Viresh Kumar wrote:
> On 10-08-21, 11:05, Lukasz Luba wrote:
>> I can see that this driver calls explicitly the
>> of_cpufreq_cooling_register()
>> It does this in the cpufreq_driver->ready() callback
>> implementation: ve_spc_cpufreq_ready()
>>
>> With that in mind, the new code in the patch 1/8, which
>> registers the EM, should be called even earlier, above:
>> ---------------------8<---------------------------------
>> /* Callback for handling stuff after policy is ready */
>> 	if (cpufreq_driver->ready)
>> 		cpufreq_driver->ready(policy);
>> ------------------->8----------------------------------
> 
> Thanks. I will look at this sequencing issue again.
> 
>> This also triggered a question:
>> If this new flag can be set in the cpufreq driver which hasn't set
>> CPUFREQ_IS_COOLING_DEV
>> ?
> 
> Why not ?

I thought someone could try to call cpufreq_cooling_register()
from the cpufreq driver init function, but it's not possible. I have
just checked that, so should be good with these two flags being
independent and working fine.

> 
>> I can only see one driver (this one in the patch) which has such
>> configuration.
> 
