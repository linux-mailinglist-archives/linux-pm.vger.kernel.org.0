Return-Path: <linux-pm+bounces-135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B87F6167
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 15:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CECF1C21090
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF426AFF;
	Thu, 23 Nov 2023 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4379E1A8;
	Thu, 23 Nov 2023 06:26:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7055F1063;
	Thu, 23 Nov 2023 06:27:41 -0800 (PST)
Received: from [10.57.4.190] (unknown [10.57.4.190])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99C073F6C4;
	Thu, 23 Nov 2023 06:26:52 -0800 (PST)
Message-ID: <77ec94ee-798d-4c5e-a673-616d25acca4a@arm.com>
Date: Thu, 23 Nov 2023 14:27:52 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: mingo@redhat.com, peterz@infradead.org,
 Vincent Guittot <vincent.guittot@linaro.org>, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org,
 viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
 <20231121230150.eq2kc72bvyn6ltur@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231121230150.eq2kc72bvyn6ltur@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/23 23:01, Qais Yousef wrote:
> On 11/22/23 15:01, Vincent Guittot wrote:
>> It has been reported that thread's util_est can significantly decrease as
>> a result of sharing the CPU with other threads. The use case can be easily
>> reproduced with a periodic task TA that runs 1ms and sleeps 100us.
>> When the task is alone on the CPU, its max utilization and its util_est is
>> around 888. If another similar task starts to run on the same CPU, TA will
>> have to share the CPU runtime and its maximum utilization will decrease
>> around half the CPU capacity (512) then TA's util_est will follow this new
>> maximum trend which is only the result of sharing the CPU with others
>> tasks. Such situation can be detected with runnable_avg wich is close or
>> equal to util_avg when TA is alone but increases above util_avg when TA
>> shares the CPU with other threads and wait on the runqueue.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
> 
> So effectively if have two always running tasks on the same CPU their util_est
> will converge to 1024 instead of 512 now, right?
> 
> I guess this is more accurate, yes. And I think this will hit the same
> limitation we can hit with uclamp_max. If for example there are two tasks that
> are 650 if they run alone, they would appear as 1024 now (instead of 512) if
> they share the CPU because combined running there will be no idle time on the
> CPU and appear like always running tasks, I think.

Well they might not converge to 1024. It will just prevent them to not
drop the highest seen util_est on them before this contention happen.

> 
> If I got it right, I think this should not be a problem in practice because the
> only reason these two tasks will be stuck on the same CPU is because the load
> balancer can't do anything about it to spread them; which indicates the system
> must be busy anyway. Once there's more idle time elsewhere, they should be
> spread and converge to 650 again.

It can be applicable for the real app. That chrome thread that I
reported (which is ~950 util) drops it's util and util_est in some
scenarios when there are some other tasks in the runqueue, because
of some short sleeps. Than this situation attracts other tasks to
migrate but next time when the big thread wakes-up it has to share
the CPU and looses it's util_est (which was the last information
that there was such big util on it).

Those update moments when we go via util_est_update() code path
are quite often in short time and don't fit into the PELT world,
IMO. It's like asynchronous force-update to the util_est signal,
not the same way wrt how slowly util is built. I think Peter
had something like this impression, when he asked me of often
and fast this update could be triggered that we loose the value...

I would even dare to call this patch a fix and a candidate to
stable-tree.

