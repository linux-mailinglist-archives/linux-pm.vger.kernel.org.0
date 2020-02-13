Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8420A15BD10
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 11:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgBMKtM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 05:49:12 -0500
Received: from foss.arm.com ([217.140.110.172]:44754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbgBMKtM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 05:49:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D91BB1FB;
        Thu, 13 Feb 2020 02:49:11 -0800 (PST)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD2BD3F6CF;
        Thu, 13 Feb 2020 02:49:10 -0800 (PST)
Subject: Re: [RFC PATCH v4 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-5-douglas.raillard@arm.com>
 <20200210130802.GG14879@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <56c3a7c0-0d41-809d-6929-086d7a9251b9@arm.com>
Date:   Thu, 13 Feb 2020 10:49:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200210130802.GG14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/10/20 1:08 PM, Peter Zijlstra wrote:
> On Wed, Jan 22, 2020 at 05:35:36PM +0000, Douglas RAILLARD wrote:
> 
>> +static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
>> +{
>> +	struct rq *rq = cpu_rq(sg_cpu->cpu);
>> +	unsigned long util_est_enqueued;
>> +	unsigned long util_avg;
>> +	unsigned long boost = 0;
>> +
> 
> Should we NO-OP this function when !sched_feat(UTIL_EST) ?
> 
>> +	util_est_enqueued = READ_ONCE(rq->cfs.avg.util_est.enqueued);
> 
> Otherwise you're reading garbage here, no?

Most likely indeed. The boosting should be disabled in that case.

> 
>> +	util_avg = READ_ONCE(rq->cfs.avg.util_avg);
>> +
>> +	/*
>> +	 * Boost when util_avg becomes higher than the previous stable
>> +	 * knowledge of the enqueued tasks' set util, which is CPU's
>> +	 * util_est_enqueued.
>> +	 *
>> +	 * We try to spot changes in the workload itself, so we want to
>> +	 * avoid the noise of tasks being enqueued/dequeued. To do that,
>> +	 * we only trigger boosting when the "amount of work" enqueued
>> +	 * is stable.
>> +	 */
>> +	if (util_est_enqueued == sg_cpu->util_est_enqueued &&
>> +	    util_avg >= sg_cpu->util_avg &&
>> +	    util_avg > util_est_enqueued)
>> +		boost = util_avg - util_est_enqueued;
>> +
>> +	sg_cpu->util_est_enqueued = util_est_enqueued;
>> +	sg_cpu->util_avg = util_avg;
>> +	WRITE_ONCE(sg_cpu->ramp_boost, boost);
>> +	return boost;
>> +}
