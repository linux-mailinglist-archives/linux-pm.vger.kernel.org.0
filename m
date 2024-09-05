Return-Path: <linux-pm+bounces-13671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF796D34A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FF21F28473
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 09:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A184199231;
	Thu,  5 Sep 2024 09:29:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432C1991DB;
	Thu,  5 Sep 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528573; cv=none; b=V07OI52YfonlD9E9ASotoq7Du5kzaXw4h8R6/YTWepu1Lwh9E53ne2F3VSd7Xad8xXqIukQ/MH/klZn7HyNxvEPI0seQnG8zGEoR4SMXL0LZJUSIRDjyHBr8BxmEL0A6RpnlqtOU9oU8AN6KkdX+B6APiskcYm+trl5M8WrUshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528573; c=relaxed/simple;
	bh=29QhhdAW9yVD66jVVFY2TLQ8yKn+5ciS2Z14YFd/33A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLXE/XBOWtYVlNUKRs1THHq9KvF/WyY1Hw59J0SfLNgb3OyZ7n9pOlIYQOEm6IlV89L2q+8/BqpefFYiCFHcfVTIs21K8QvhE9SU78Stm6Ntr6HhZVq/pK6nnyQhClxhxeVfVipXYliR0/dgDLCDPecZC7IsiNZf/1aee/jMx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13CD8FEC;
	Thu,  5 Sep 2024 02:29:58 -0700 (PDT)
Received: from [10.57.75.86] (unknown [10.57.75.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6873F73F;
	Thu,  5 Sep 2024 02:29:29 -0700 (PDT)
Message-ID: <0e37c349-7076-4a02-bfbc-577e50090172@arm.com>
Date: Thu, 5 Sep 2024 10:29:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
 <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/24 16:18, Rafael J. Wysocki wrote:
> On Wed, Sep 4, 2024 at 4:42 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Sep 4, 2024 at 4:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Mon, Aug 19, 2024 at 09:39:45AM -0600, Jens Axboe wrote:
>>>> Hi,
>>>>
>>>> This is v6 of the patchset where the current in_iowait state is split
>>>> into two parts:
>>>>
>>>> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>>>>    in terms of sleep and wakeup latencies.
>>>> 2) The above, and also accounted as such in the iowait stats.
>>>>
>>>> The current ->in_iowait covers both, this series splits it into two types
>>>> of state so that each can be controlled seperately.
>>>
>>> Yeah, but *WHY* !?!? I have some vague memories from last time around,
>>> but patches should really keep this information.
>>>
>>>> Patches 1..3 are prep patches, changing the type of
>>>> task_struct->nr_iowait and adding helpers to manipulate the iowait counts.
>>>>
>>>> Patch 4 does the actual splitting.
>>>>
>>>> This has been sitting for a while, would be nice to get this queued up
>>>> for 6.12. Comments welcome!
>>>
>>> Ufff, and all this because menu-governor does something insane :-(
>>>
>>> Rafael, why can't we simply remove this from menu?
>>
>> Same reason as before: people use it and refuse to stop.
>>
>> But this is mostly about the schedutil cpufreq governor that uses
>> iowait boosting.
> 
> To be more precise, there are two different uses of "iowait" in PM.
> 
> One is the nr_iowait_cpu() call in menu_select() and the result of it
> is used for two purposes: (1) select different sets of statistics
> depending on whether or not this number is zero and (2) set a limit
> for the idle state's exit latency that depends on this number (but
> note that it only takes effect when the "iowait" statistics are used
> in the first place).  Both of these are arguably questionable and it
> is unclear to me whether or not they actually help and how much.

So from my perspective it doesn't, not significantly to justify it's
existence anyway. Either it doesn't actually matter for menu, or teo
is able to compete / outperform without relying on it.
Some caution is advised though this really depends on:
- Which idle states are available for the kernel to select.
- How accurate the kernel's view of the idle states is.

Both varies wildly.

> 
> The other use is boosting CPU frequency in schedutil and intel_pstate
> if SCHED_CPUFREQ_IOWAIT is passed to them which in turn depends on the
> p->in_iowait value in enqueue_task_fair().
> 
> AFAICS, the latter makes a major difference.


Indeed, fortunately the impact is quite limited here.
But please, Rafael, Jens and Peter, feel free to share your comments
over here too:

https://lore.kernel.org/lkml/20240905092645.2885200-1-christian.loehle@arm.com/

