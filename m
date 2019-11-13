Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4FFB239
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 15:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKMOJw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 09:09:52 -0500
Received: from foss.arm.com ([217.140.110.172]:53178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbfKMOJw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 09:09:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B72B97A7;
        Wed, 13 Nov 2019 06:09:51 -0800 (PST)
Received: from [192.168.1.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 937823F6C4;
        Wed, 13 Nov 2019 06:09:48 -0800 (PST)
Subject: Re: [PATCH v2] sched/freq: move call to cpufreq_update_util
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
 <20191112150544.GA3664@linaro.org>
 <3b8cafb7-894d-c302-e6c6-b5844b1298b5@arm.com>
 <CAKfTPtBMNnM2tTfb72VtufDpwBvqu6Ttj3dnLgoNOZ--Q6qo+Q@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <bcba52bc-6780-1efc-6ef4-1a75f1cef33d@arm.com>
Date:   Wed, 13 Nov 2019 15:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBMNnM2tTfb72VtufDpwBvqu6Ttj3dnLgoNOZ--Q6qo+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.11.19 14:30, Vincent Guittot wrote:
> On Wed, 13 Nov 2019 at 11:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 12.11.19 16:05, Vincent Guittot wrote:
>>> Le Tuesday 12 Nov 2019 à 15:48:13 (+0100), Vincent Guittot a écrit :

[...]

>>>> @@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
>>>>       * that RT, DL and IRQ signals have been updated before updating CFS.
>>>>       */
>>>>      curr_class = rq->curr->sched_class;
>>>> -    update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>>>> -    update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>>>> -    update_irq_load_avg(rq, 0);
>>>> +    decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>>>> +    decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>>>> +    decayed |= update_irq_load_avg(rq, 0);
>>
>> Why not 'decayed  = update_cfs_rq_load_avg()' like in the
>> !CONFIG_FAIR_GROUP_SCHED case?
> 
> Because it is handled by the update_load_avg() in
> for_each_leaf_cfs_rq_safe() loop
> 
> This means that we can have 2 calls to cpufreq_update_util in
> update_blocked_average() but at least the values will be up to date in
> both calls unlike previously.
> 
> I'm going to prepare an additional patch to remove this useless call.
> I have also seen some possible further optimization that i need to
> study a bit more before preparing a patch

I see. The update_load_avg() call for the taskgroup skeleton se
(cfs_rq->tg->se[cpu]). But what happens to the cpu which only has the
root cfs_rq i the list? It doesn't have a skeleton se.
