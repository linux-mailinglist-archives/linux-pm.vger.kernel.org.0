Return-Path: <linux-pm+bounces-20234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C77FA092FD
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3055B3AAB23
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE5210184;
	Fri, 10 Jan 2025 14:09:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912420FAB2;
	Fri, 10 Jan 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518150; cv=none; b=ocs0r4W8eY0uF0WCg8q3thi0CKK/E5J3BH2dsR3IPIMQUxtpFlv2X+VAe3U8XGd482h2l2opVkEFVqMH0TX+IY5f4jARqCe8acY14zDbK/lw/ajJp4EmYFiXnZd72MMETOk8tVMGNYGo5gWOGP5lZ4s1N/fRY5+3hcbkYv9cJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518150; c=relaxed/simple;
	bh=OBQU0X6jtRDwZquvKnyq/lAIBBJf4gZh+VpCf3e9j0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZJV72DzzjY8wwlykCs4ShzQ+7mQ0jaCxTxlKL0eTaflfVN51efxrF12BY9DkuOSIN3RafqiSj5a1Gqmk3jVRZJR5kwOPayYJIJMc+GlE8Uki/WMUPc3qrAwlDd8SNxxIVt8DOVVPEvL5sWcos5ydslgeeU+i+e6uF3KOJR898g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55C931477;
	Fri, 10 Jan 2025 06:09:33 -0800 (PST)
Received: from [10.57.6.52] (unknown [10.57.6.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F23953F59E;
	Fri, 10 Jan 2025 06:09:03 -0800 (PST)
Message-ID: <658fc3b6-2e8f-47b4-a5c2-bd1b72b54a15@arm.com>
Date: Fri, 10 Jan 2025 14:09:01 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: teo: Update documentation after previous
 changes
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6120335.lOV4Wx5bFT@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6120335.lOV4Wx5bFT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 12:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After previous changes, the description of the teo governor in the
> documentation comment does not match the code any more, so update it
> as appropriate.
> 
> Fixes: 449914398083 ("cpuidle: teo: Remove recent intercepts metric")
> Fixes: 2662342079f5 ("cpuidle: teo: Gather statistics regarding whether or not to stop the tick")
> Fixes: 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length() call in some cases")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   99 +++++++++++++++++++++-------------------
>  1 file changed, 52 insertions(+), 47 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -10,25 +10,27 @@
>   * DOC: teo-description
>   *
>   * The idea of this governor is based on the observation that on many systems
> - * timer events are two or more orders of magnitude more frequent than any
> - * other interrupts, so they are likely to be the most significant cause of CPU
> - * wakeups from idle states.  Moreover, information about what happened in the
> - * (relatively recent) past can be used to estimate whether or not the deepest
> - * idle state with target residency within the (known) time till the closest
> - * timer event, referred to as the sleep length, is likely to be suitable for
> - * the upcoming CPU idle period and, if not, then which of the shallower idle
> - * states to choose instead of it.
> - *
> - * Of course, non-timer wakeup sources are more important in some use cases
> - * which can be covered by taking a few most recent idle time intervals of the
> - * CPU into account.  However, even in that context it is not necessary to
> - * consider idle duration values greater than the sleep length, because the
> - * closest timer will ultimately wake up the CPU anyway unless it is woken up
> - * earlier.
> - *
> - * Thus this governor estimates whether or not the prospective idle duration of
> - * a CPU is likely to be significantly shorter than the sleep length and selects
> - * an idle state for it accordingly.
> + * timer interrupts are two or more orders of magnitude more frequent than any
> + * other interrupt types, so they are likely to dominate CPU wakeup patterns.
> + * Moreover, in principle, the time when the next timer event is going to occur
> + * can be determined at the idle state selection time, although doing that may
> + * be costly, so it can be regarded as the most reliable source of information
> + * for idle state selection.
> + *
> + * Of course, non-timer wakeup sources are more important in some use cases,
> + * but even then it is generally unnecessary to consider idle duration values
> + * greater than the time time till the next timer event, referred as the sleep
> + * length in what follows, because the closest timer will ultimately wake up the
> + * CPU anyway unless it is woken up earlier.
> + *
> + * However, since obtaining the sleep length may be costly, the governor first
> + * checks if it can select a shallow idle state using wakeup pattern information
> + * from recent times, in which case it can do without knowing the sleep length
> + * at all.  For this purpose, it counts CPU wakeup events and looks for an idle
> + * state whose terget residency has not exceeded the idle duration (measured

s/terget/target

> + * after wakeup) in the majority of relevant recent cases.  If the target
> + * residency of that state is small enough, it may be used right away and the
> + * sleep length need not be determined.
>   *
>   * The computations carried out by this governor are based on using bins whose
>   * boundaries are aligned with the target residency parameter values of the CPU
> @@ -39,7 +41,11 @@
>   * idle state 2, the third bin spans from the target residency of idle state 2
>   * up to, but not including, the target residency of idle state 3 and so on.
>   * The last bin spans from the target residency of the deepest idle state
> - * supplied by the driver to infinity.
> + * supplied by the driver to the scheduler tick period length or to infinity if
> + * the tick period length is less than the targer residency of that state.  In

s/targer/target

> + * the latter case, the governor also counts events with the measured idle
> + * duration between the tick period length and the target residency of the
> + * deepest idle state.
>   *
>   * Two metrics called "hits" and "intercepts" are associated with each bin.
>   * They are updated every time before selecting an idle state for the given CPU
> @@ -49,47 +55,46 @@
>   * sleep length and the idle duration measured after CPU wakeup fall into the
>   * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
>   * length).  In turn, the "intercepts" metric reflects the relative frequency of
> - * situations in which the measured idle duration is so much shorter than the
> - * sleep length that the bin it falls into corresponds to an idle state
> - * shallower than the one whose bin is fallen into by the sleep length (these
> - * situations are referred to as "intercepts" below).
> + * non-timer wakeup events for which the measured idle duration falls into a bin
> + * that corresponds to an idle state shallower than the one whose bin is fallen
> + * into by the sleep length (these events are also referred to as "intercepts"
> + * below).
>   *
>   * In order to select an idle state for a CPU, the governor takes the following
>   * steps (modulo the possible latency constraint that must be taken into account
>   * too):
>   *
> - * 1. Find the deepest CPU idle state whose target residency does not exceed
> - *    the current sleep length (the candidate idle state) and compute 2 sums as
> - *    follows:
> - *
> - *    - The sum of the "hits" and "intercepts" metrics for the candidate state
> - *      and all of the deeper idle states (it represents the cases in which the
> - *      CPU was idle long enough to avoid being intercepted if the sleep length
> - *      had been equal to the current one).
> - *
> - *    - The sum of the "intercepts" metrics for all of the idle states shallower
> - *      than the candidate one (it represents the cases in which the CPU was not
> - *      idle long enough to avoid being intercepted if the sleep length had been
> - *      equal to the current one).
> + * 1. Find the deepest enabled CPU idle state (the candidate idle state) and
> + *    compute 2 sums as follows:
>   *
> - * 2. If the second sum is greater than the first one the CPU is likely to wake
> - *    up early, so look for an alternative idle state to select.
> + *    - The sum of the "hits" metric for all of the idle states shallower than
> + *      the candidate one (it represents the cases in which the CPU was likely
> + *      woken up by a timer).
> + *
> + *    - The sum of the "intercepts" metric for all of the idle states shallower
> + *      than the candidate one (it represents the cases in which the CPU was
> + *      likely woken up by a non-timer wakeup source).
> + *
> + * 2. If the second sum computed in step 1 is greater than a half of the sum of
> + *    both mertics for the candidate state bin and all subsequent bins(if any),

s/mertics/metrics

> + *    a shallower idle state is likely to be more suitable, so look for it.
>   *
> - *    - Traverse the idle states shallower than the candidate one in the
> + *    - Traverse the enabled idle states shallower than the candidate one in the
>   *      descending order.
>   *
>   *    - For each of them compute the sum of the "intercepts" metrics over all
>   *      of the idle states between it and the candidate one (including the
>   *      former and excluding the latter).
>   *
> - *    - If each of these sums that needs to be taken into account (because the
> - *      check related to it has indicated that the CPU is likely to wake up
> - *      early) is greater than a half of the corresponding sum computed in step
> - *      1 (which means that the target residency of the state in question had
> - *      not exceeded the idle duration in over a half of the relevant cases),
> - *      select the given idle state instead of the candidate one.
> + *    - If this sum is greater than a half of the second sum computed in step 1,
> + *      use the given idle state as the new candidate one.
>   *
> - * 3. By default, select the candidate state.
> + * 3. If the current candidate state is state 0 or its target residency is short
> + *    enough, return it and prevent the scheduler tick from being stopped.
> + *
> + * 4. Obtain the sleep length value and check if it is below the target
> + *    residency of the current candidate state, in which case a new shallower
> + *    candidate state needs to be found, so look for it.
>   */

Description seems to parse in my brain FWIW.
Thanks for cleaning that up, clearly I've overlooked that doc.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

