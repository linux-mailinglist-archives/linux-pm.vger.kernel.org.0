Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB4DBEA2
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392185AbfJRHpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 03:45:10 -0400
Received: from [217.140.110.172] ([217.140.110.172]:57362 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2404288AbfJRHpK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 03:45:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DA8F332;
        Fri, 18 Oct 2019 00:44:47 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ED2B3F718;
        Fri, 18 Oct 2019 00:44:45 -0700 (PDT)
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
To:     Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>
Cc:     Douglas Raillard <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        qperret@qperret.net, patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
 <20191017111116.GA27006@google.com>
 <20191017141107.GJ2311@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2cbde0fe-c10c-0ebb-32ef-2d522986bc89@arm.com>
Date:   Fri, 18 Oct 2019 09:44:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191017141107.GJ2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/10/2019 16:11, Peter Zijlstra wrote:
> On Thu, Oct 17, 2019 at 12:11:16PM +0100, Quentin Perret wrote:

[...]

> It only boosts when 'rq->cfs.avg.util' increases while
> 'rq->cfs.avg.util_est.enqueued' remains unchanged (and util > util_est
> obv).
> 
> This condition can be true for select_task_rq_fair(), because that is
> ran before we do enqueue_task_fair() (for obvious raisins).
> 
>>> I'm still thinking about the exact means you're using to raise C; that
>>> is, the 'util - util_est' as cost_margin. It hurts my brain still.
>>
>> +1 ...
> 
> cost_i = capacity_i / power_i ; for the i-th OPP

I get confused by this definition. efficiency=capacity/power but the
cs->cost value used in em_pd_get_higher_freq() is defined as

cs_cost = cs->power * cpu_max_freq / cs->freq [energy_model.h]

> We then do: 'x = util - util_avg' and use that on the first
> OPP >= min_freq:
> 
> 	cost(x) = cost_j + cost_j * x ; freq_j >= min_freq
> 	        = cost_j * (1 + x)
> 
> And then we find the highest OPP that has:
> 
> 	cost_k <= cost(x)

[...]
