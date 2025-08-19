Return-Path: <linux-pm+bounces-32613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 818C2B2BCBA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FE3189C56A
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 09:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2FB31CA57;
	Tue, 19 Aug 2025 09:10:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409731B12D;
	Tue, 19 Aug 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594637; cv=none; b=n9lNNasSQ/irTZplrhzIGQai+Q6ii2kZGePSF39U0Ly3uWd1onKaL93DT+OUhtLpx1f10b/fvfPdLC7JCelq7oC2hs3HGSuO6r0asA7N0YtPkbayMh6yzNoNnM+mpwUeDRlNUml8aRnYpeWkglpG4ireeAaUAbHOpBoKQ8vo06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594637; c=relaxed/simple;
	bh=k0UKpVDMhhnSmwYuWfPThSQ+On0Y0+TXnkxYW4uP2xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqBc2EPYeC7joYCsp2VHBWxnee8IU1VFc+ZsP9HN0y/WCpDlZYSVhnml6fLYBJIEdwZ+0O3qOq9VrWkDy1LtLqtniKEaUVYH8vDximyLP3ldEGOoupPYg9oXg7WsG8cgymWDAGaT74WrpVdxImUP/IyAtm8PV5Q2RmaLcXWAZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 778C11BD0;
	Tue, 19 Aug 2025 02:10:25 -0700 (PDT)
Received: from [10.1.30.58] (unknown [10.1.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 867C73F58B;
	Tue, 19 Aug 2025 02:10:32 -0700 (PDT)
Message-ID: <3fa10040-7e48-4100-9d70-cbbac406abde@arm.com>
Date: Tue, 19 Aug 2025 10:10:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full
 CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <2244365.irdbgypaU6@rafael.j.wysocki>
 <9104c434-9025-4365-8127-28014ddddc8d@arm.com>
 <CAJZ5v0iTaa62WGXCLcgiRyzcj2GBXmYcvLa8AtQZD5bQcxTw5g@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0iTaa62WGXCLcgiRyzcj2GBXmYcvLa8AtQZD5bQcxTw5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/25 18:41, Rafael J. Wysocki wrote:
> On Thu, Aug 14, 2025 at 4:09 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 8/13/25 11:29, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> When the menu governor runs on a nohz_full CPU and there are no user
>>> space timers in the workload on that CPU, it ends up selecting idle
>>> states with target residency values above TICK_NSEC all the time due to
>>> a tick_nohz_tick_stopped() check designed for a different use case.
>>> Namely, on nohz_full CPUs the fact that the tick has been stopped does
>>> not actually mean anything in particular, whereas in the other case it
>>> indicates that previously the CPU was expected to be idle sufficiently
>>> long for the tick to be stopped, so it is not unreasonable to expect
>>> it to be idle beyond the tick period length again.
>>>
>>> In some cases, this behavior causes latency in the workload to grow
>>> undesirably.  It may also cause the workload to consume more energy
>>> than necessary if the CPU does not spend enough time in the selected
>>> deep idle states.
>>>
>>> Address this by amending the tick_nohz_tick_stopped() check in question
>>> with a tick_nohz_full_cpu() one to avoid using the time till the next
>>> timer event as the predicted_ns value all the time on nohz_full CPUs.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/cpuidle/governors/menu.c |   12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> --- a/drivers/cpuidle/governors/menu.c
>>> +++ b/drivers/cpuidle/governors/menu.c
>>> @@ -293,8 +293,18 @@
>>>        * in a shallow idle state for a long time as a result of it.  In that
>>>        * case, say we might mispredict and use the known time till the closest
>>>        * timer event for the idle state selection.
>>> +      *
>>> +      * However, on nohz_full CPUs the tick does not run as a rule and the
>>> +      * time till the closest timer event may always be effectively infinite,
>>> +      * so using it as a replacement for the predicted idle duration would
>>> +      * effectively always cause the prediction results to be discarded and
>>> +      * deep idle states to be selected all the time.  That might introduce
>>> +      * unwanted latency into the workload and cause more energy than
>>> +      * necessary to be consumed if the discarded prediction results are
>>> +      * actually accurate, so skip nohz_full CPUs here.
>>>        */
>>> -     if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
>>> +     if (tick_nohz_tick_stopped() && !tick_nohz_full_cpu(dev->cpu) &&
>>> +         predicted_ns < TICK_NSEC)
>>>               predicted_ns = data->next_timer_ns;
>>>
>>>       /*
>>>
>>>
>>>
>>
>> OTOH the behaviour with $SUBJECT possibly means that we use predicted_ns from
>> get_typical_interval() (which may suggest picking a shallow state based on
>> previous wakeup patterns) only then to never wake up again?
> 
> Yes, there is this risk, but the current behavior is more damaging IMV
> because it (potentially) hurts both energy efficiency and performance.
> 
> It is also arguably easier for the user to remedy getting stuck in a
> shallow idle state than to change governor's behavior (PM QoS is a bit
> too blunt for this).
> 
> Moreover, configuring CPUs as nohz_full and leaving them in long idle
> may not be the most efficient use of them.

True, on the other hand the setup cost for nohz_full is so high, you'd expect
the additional idle states disabling depending on the workload isn't too much
to ask for...
Anyway feel free to go ahead.

