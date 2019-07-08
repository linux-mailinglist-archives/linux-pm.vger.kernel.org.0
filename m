Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD461FCF
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfGHNuB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 09:50:01 -0400
Received: from foss.arm.com ([217.140.110.172]:48442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfGHNuB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 09:50:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A456E2B;
        Mon,  8 Jul 2019 06:50:00 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D4FA3F738;
        Mon,  8 Jul 2019 06:49:59 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, dietmar.eggemann@arm.com
References: <20190627171603.14767-1-douglas.raillard@arm.com>
 <20190702154422.GV3436@hirez.programming.kicks-ass.net>
 <590e3dd9-ea4e-5230-d12c-d04bb3916e89@arm.com>
 <20190708111348.o6o63jisbukuk64d@e110439-lin>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <13a596f8-1c9c-f1da-f26e-d832fccbf563@arm.com>
Date:   Mon, 8 Jul 2019 14:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708111348.o6o63jisbukuk64d@e110439-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/8/19 12:13 PM, Patrick Bellasi wrote:
> On 03-Jul 14:38, Douglas Raillard wrote:
>> Hi Peter,
>>
>> On 7/2/19 4:44 PM, Peter Zijlstra wrote:
>>> On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:
>>>> Make schedutil cpufreq governor energy-aware.
>>>>
>>>> - patch 1 introduces a function to retrieve a frequency given a base
>>>>     frequency and an energy cost margin.
>>>> - patch 2 links Energy Model perf_domain to sugov_policy.
>>>> - patch 3 updates get_next_freq() to make use of the Energy Model.
>>>
>>>>
>>>> 1) Selecting the highest possible frequency for a given cost. Some
>>>>      platforms can have lower frequencies that are less efficient than
>>>>      higher ones, in which case they should be skipped for most purposes.
>>>>      They can still be useful to give more freedom to thermal throttling
>>>>      mechanisms, but not under normal circumstances.
>>>>      note: the EM framework will warn about such OPPs "hertz/watts ratio
>>>>      non-monotonically decreasing"
>>>
>>> Humm, for some reason I was thinking we explicitly skipped those OPPs
>>> and they already weren't used.
>>>
>>> This isn't in fact so, and these first few patches make it so?
>>
>> That's correct, the cost information about each OPP has been introduced recently in mainline
>> by the energy model series. Without that info, the only way to skip them that comes to my
>> mind is to set a policy min frequency, since these inefficient OPPs are usually located
>> at the lower end.
> 
> Perhaps it's also worth to point out that the alternative approach you
> point out above is a system wide solution.
> 
> While, the ramp_boost thingy you propose, it's a more fine grained
> mechanisms which could be extended in the future to have a per-task
> side. IOW, it could contribute to have better user-space hints, for
> example to ramp_boost more certain tasks and not others.

ramp_boost and the situation you describe are more what solves point 2) (which has been cut out in that answer),
this point "1)" is really just about avoiding selection of some OPPs, regardless of task util. IOW, it's better to
skip the OPPs we talk about here, and race to idle at a higher OPP regardless of what the task need.


> Best,
> Patrick
> 

Cheers,
Douglas
