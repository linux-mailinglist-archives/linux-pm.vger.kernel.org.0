Return-Path: <linux-pm+bounces-170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4757F7190
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 11:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707881C20E19
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347111733;
	Fri, 24 Nov 2023 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E79B818E;
	Fri, 24 Nov 2023 02:35:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 154E31FB;
	Fri, 24 Nov 2023 02:35:49 -0800 (PST)
Received: from [10.57.4.20] (unknown [10.57.4.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97BAF3F7A6;
	Fri, 24 Nov 2023 02:35:00 -0800 (PST)
Message-ID: <39cde23a-19d8-4e64-a1d2-f26bce264883@arm.com>
Date: Fri, 24 Nov 2023 10:34:59 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: lukasz.luba@arm.com, juri.lelli@redhat.com, mingo@redhat.com,
 dietmar.eggemann@arm.com, peterz@infradead.org, bsegall@google.com,
 rostedt@goodmis.org, bristot@redhat.com, mgorman@suse.de,
 vschneid@redhat.com, rafael@kernel.org, qyousef@layalina.io,
 viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
 <0bc60a26-af18-4108-8b8d-238a1df1775b@arm.com>
 <CAKfTPtAosL8f0M1nL2U78iuwm9ZFGuQS5jX4soex8nsGjMX_RQ@mail.gmail.com>
 <CAKfTPtCnj9Gnczt7aJOELRW+_Rgs3Qp9KFM9Kn17YQ3nFbNdhQ@mail.gmail.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAKfTPtCnj9Gnczt7aJOELRW+_Rgs3Qp9KFM9Kn17YQ3nFbNdhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2023 17:37, Vincent Guittot wrote:
> The same but with plain text instead of html ...
> 
>   On Wed, 22 Nov 2023 at 17:40, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> On 22/11/2023 14:01, Vincent Guittot wrote:
>>> It has been reported that thread's util_est can significantly decrease as
>>> a result of sharing the CPU with other threads. The use case can be easily
>>> reproduced with a periodic task TA that runs 1ms and sleeps 100us.
>>> When the task is alone on the CPU, its max utilization and its util_est is
>>> around 888. If another similar task starts to run on the same CPU, TA will
>>> have to share the CPU runtime and its maximum utilization will decrease
>>> around half the CPU capacity (512) then TA's util_est will follow this new
>>> maximum trend which is only the result of sharing the CPU with others
>>> tasks. Such situation can be detected with runnable_avg wich is close or
>>> equal to util_avg when TA is alone but increases above util_avg when TA
>>> shares the CPU with other threads and wait on the runqueue.
>>
>> Thanks for bringing this case up. I'm a bit nervous skipping util_est
>> updates this way. While it is true that this avoids dropping util_est
>> when the task is still busy doing stuff, it also avoids dropping
>> util_est when the task really is becoming less busy. If a task has a
>> legitimate reason to drop its utilization, it looks weird to me that its
>> util_est dropping can be stopped by a new task joining this rq which
>> pushes up runnable_avg.
> 
>   We prefer an util_est that overestimate rather than under estimate
> because in 1st case you will not provide enough performance to the
> task which will remain under provisioned whereas in the other case you
> will create some idle time which will enable to reduce contention and
> as a result reduce the util_est so the overestimate will be transient
> whereas the underestimate will be remain

My concern is mostly about energy efficiency, although I have no 
concrete evidence on energy impact so I'm not firmly against this patch.

> 
>> Also, something about rt-app. Is there an easy way to ask an rt-app
>> thread to achieve a certain amount of throughput (like loops per
>> second)? I think 'runs 1ms and sleeps 100us' may not entirely simulate a
>> task that really wants to preserve a util_est of 888. If its utilization
> 
> 
>   We can do this in rt-app with timer...
Thanks. Looking at the rt-app doc, I think a timer with absolute time 
stamps does what I want.

