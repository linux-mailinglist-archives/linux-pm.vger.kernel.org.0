Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFB3A6E26
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhFNSYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 14:24:13 -0400
Received: from foss.arm.com ([217.140.110.172]:43392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235298AbhFNSYL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Jun 2021 14:24:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE3D113E;
        Mon, 14 Jun 2021 11:22:07 -0700 (PDT)
Received: from [10.57.5.127] (unknown [10.57.5.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE6433F694;
        Mon, 14 Jun 2021 11:22:03 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>, amitk@kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20210610150324.22919-1-lukasz.luba@arm.com>
 <20210610150324.22919-3-lukasz.luba@arm.com>
 <CAKfTPtAq5Hn7iQ-USO5La4B_jkYXzSvFSFrCDq47gjXDGghyTQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2fa70564-e02a-06d5-2742-24dedccddea2@arm.com>
Date:   Mon, 14 Jun 2021 19:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAq5Hn7iQ-USO5La4B_jkYXzSvFSFrCDq47gjXDGghyTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/14/21 5:03 PM, Vincent Guittot wrote:
> On Thu, 10 Jun 2021 at 17:03, Lukasz Luba <lukasz.luba@arm.com> wrote:

[snip]

>> In the existing code the raw value of arch_scale_cpu_capacity() is used
>> for clamping the returned CPU utilization from effective_cpu_util().
>> This patch fixes issue with too big single CPU utilization, by introducing
>> clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
>> capacity reduced by thermal pressure signal. We rely on this load avg
> 
> you don't rely on load avg value but on raw thermal pressure value now

Good catch, I'll change that description.

> 
>> geometric series in similar way as other mechanisms in the scheduler.
>>

[snip]

>>
>> +       thermal_pressure = arch_scale_thermal_pressure(cpumask_first(pd_mask));
> 
> Do you really need to use this intermediate variable thermal_pressure
> ? Seems to be used only below

True, it's used only here. I'll remove this variable in the v4.

> 
> With these 2 comments above fixed,
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thank you for the review!

Regards,
Lukasz
