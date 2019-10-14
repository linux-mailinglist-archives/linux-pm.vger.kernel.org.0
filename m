Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3465BD6620
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 17:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfJNPcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 11:32:15 -0400
Received: from foss.arm.com ([217.140.110.172]:47000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfJNPcP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 11:32:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42C9C28;
        Mon, 14 Oct 2019 08:32:14 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA39D3F68E;
        Mon, 14 Oct 2019 08:32:12 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191011134500.235736-5-douglas.raillard@arm.com>
 <20191014143321.GH2328@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <65bfb1eb-2348-e36c-9ba1-31e59a9afc96@arm.com>
Date:   Mon, 14 Oct 2019 16:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014143321.GH2328@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On 10/14/19 3:33 PM, Peter Zijlstra wrote:
> On Fri, Oct 11, 2019 at 02:44:58PM +0100, Douglas RAILLARD wrote:
>> Use the utilization signals dynamic to detect when the utilization of a
>> set of tasks starts increasing because of a change in tasks' behavior.
>> This allows detecting when spending extra power for faster frequency
>> ramp up response would be beneficial to the reactivity of the system.
>>
>> This ramp boost is computed as the difference
>> util_avg-util_est_enqueued. This number somehow represents a lower bound
> 
> That reads funny, maybe 'as the difference between util_avg and
> util_est_enqueued' ?

Indeed, it was not clear that it was a formula. Talking about formulas, I remember laying down
the relations between the various flavors of util signals in the v2 thread. This could be
turned rather easily into a doc page for PELT, along with a signal-processing-friendly
accurate description of how the PELT signals are built. Would such a patch be of any
interest the kernel tree ?

>> of how much extra utilization this tasks is actually using, compared to
>> our best current stable knowledge of it (which is util_est_enqueued).
>>
>> When the set of runnable tasks changes, the boost is disabled as the
>> impact of blocked utilization on util_avg will make the delta with
>> util_est_enqueued not very informative.
> 
>> @@ -561,6 +604,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>>   		}
>>   	}
>>   
>> +
>>   	return get_next_freq(sg_policy, util, max);
>>   }
> 
> Surely we can do without this extra whitespace? :-)
> 
woops ...

Cheers,
Douglas
