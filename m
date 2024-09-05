Return-Path: <linux-pm+bounces-13676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3996D618
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 12:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C62287514
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7BB13D276;
	Thu,  5 Sep 2024 10:31:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EFA1EBFEC;
	Thu,  5 Sep 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532275; cv=none; b=K9mZcKrCDAptf26aj8Uek9JQ4trTvBH6AxQDOIoWSd0oTj+GYwJYc9QBCaZsm3wZu529lCuw9VP6G0fSmqNxy87oOSXnGPW7LkBtQdS5E9s9ZT88dpJy8xveCdL1LQS5Y/iM5W7vIGlylM1rDk2GXhWP0400c7v0a8PAlNvYIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532275; c=relaxed/simple;
	bh=q8XkERj659XGje1P3sdRFSBqUlmICDPdn8bzik6Z/9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igqK4M/KEJWxD+FWm3I+Q3ZjgSFWaoBExrdyc7XaBk2GFcnKndcPUKCkRn22LnVO55hh3dmeoX+CmWCkfgE9Se6c6iq2ehx2bNjpsQLGY1z1RA5+45iIZsfcEv42dMCSrXn7fSnYnrP5BfaifdzyCof2rf1TWPe5lFio891rggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C061FEC;
	Thu,  5 Sep 2024 03:31:39 -0700 (PDT)
Received: from [10.1.32.66] (e127648.arm.com [10.1.32.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 475423F73F;
	Thu,  5 Sep 2024 03:31:11 -0700 (PDT)
Message-ID: <3efadac3-1aa0-4747-b140-3fb6f267586e@arm.com>
Date: Thu, 5 Sep 2024 11:31:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
To: Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
 <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com>
 <20240905093607.GB15400@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240905093607.GB15400@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 10:36, Peter Zijlstra wrote:
> On Wed, Sep 04, 2024 at 05:18:57PM +0200, Rafael J. Wysocki wrote:
> 
>> To be more precise, there are two different uses of "iowait" in PM.
>>
>> One is the nr_iowait_cpu() call in menu_select() and the result of it
>> is used for two purposes: (1) select different sets of statistics
>> depending on whether or not this number is zero and (2) set a limit
>> for the idle state's exit latency that depends on this number (but
>> note that it only takes effect when the "iowait" statistics are used
>> in the first place).  Both of these are arguably questionable and it
>> is unclear to me whether or not they actually help and how much.
> 
> So this one is very dubious, it relies on tasks getting back on the CPU
> they went to sleep on -- not guaranteed at all.
> 
>> The other use is boosting CPU frequency in schedutil and intel_pstate
>> if SCHED_CPUFREQ_IOWAIT is passed to them which in turn depends on the
>> p->in_iowait value in enqueue_task_fair().
> 
> This one is fine and makes sense. At this point we know that p is going
> to run and where it is going to run.

On any even remotely realistic scenario and hardware though the boost
isn't effective until the next enqueue-dequeue-cycle, so if your above
objection is based on that, I would object here too, using your argument.

