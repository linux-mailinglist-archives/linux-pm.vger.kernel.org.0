Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B246B3A266F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 10:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhFJIVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:21:09 -0400
Received: from foss.arm.com ([217.140.110.172]:53208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhFJIVI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 04:21:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E9CD6E;
        Thu, 10 Jun 2021 01:19:12 -0700 (PDT)
Received: from [10.57.4.220] (unknown [10.57.4.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D786C3F719;
        Thu, 10 Jun 2021 01:19:09 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] sched/cpufreq: Consider reduced CPU capacity in
 energy calculation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, Beata.Michalska@arm.com,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20210604080954.13915-1-lukasz.luba@arm.com>
 <20210604080954.13915-3-lukasz.luba@arm.com>
 <CAJZ5v0ji=601eHQzHP1KuiA_TRUBaeEL6=sSLR_sW12MS_8QcA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6b10f1ed-17d7-e1b0-37c5-17ced9ba383c@arm.com>
Date:   Thu, 10 Jun 2021 09:19:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ji=601eHQzHP1KuiA_TRUBaeEL6=sSLR_sW12MS_8QcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/9/21 4:01 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 4, 2021 at 10:10 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Energy Aware Scheduling (EAS) needs to predict the decisions made by
>> SchedUtil. The map_util_freq() exists to do that.
>>
>> There are corner cases where the max allowed frequency might be reduced
>> (due to thermal). SchedUtil as a CPUFreq governor, is aware of that
>> but EAS is not. This patch aims to address it.
>>
>> SchedUtil stores the maximum allowed frequency in
>> 'sugov_policy::next_freq' field. EAS has to predict that value, which is
>> the real used frequency. That value is made after a call to
>> cpufreq_driver_resolve_freq() which clamps to the CPUFreq policy limits.
>> In the existing code EAS is not able to predict that real frequency.
>> This leads to energy estimation errors.
>>
>> To avoid wrong energy estimation in EAS (due to frequency miss prediction)
>> make sure that the step which calculates Performance Domain frequency,
>> is also aware of the allowed CPU capacity.
>>
>> Furthermore, modify map_util_freq() to not extend the frequency value.
>> Instead, use map_util_perf() to extend the util value in both places:
>> SchedUtil and EAS, but for EAS clamp it to max allowed CPU capacity.
>> In the end, we achieve the same desirable behavior for both subsystems
>> and alignment in regards to the real CPU frequency.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> For the schedutil part
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 


Thank you Rafael!

Regards,
Lukasz
