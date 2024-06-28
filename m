Return-Path: <linux-pm+bounces-10180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D060C91BB86
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89649283B19
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AE014B97E;
	Fri, 28 Jun 2024 09:33:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411F2139A8;
	Fri, 28 Jun 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567223; cv=none; b=m8VfazRUy5Ot64ktjyqEwi1/Eq0sMPupT53+dD0czZ204O4pZjdQjI0tuBmrqp74W1S3AHYK1dZyFzCKAInDlmZRk/dq+JAGs+2mikJC5TN4+bLxj4fcrvZ2b7w5Wv91eidfTPh7Rlgn2OngWEZ5WVCNVyZVIeArnmVfsV2Uriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567223; c=relaxed/simple;
	bh=W9g1NFwlq7n5GZ0tFtq3OlFb+W44eiic5uaJkBur9sw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lAklh4WhJ76XASXmM/XL35nFHYgveGUiIRuuLlAYVjwaL5o0P/NSiZb5K282bndaKFf/sRienoHZG4GVcunNxKDibulXolVp/QFIc/FquK3g0MAvjaC1OJLyQ9azRXUWvrZO6cu6PrRZLpV0oHKPWuJc+uQKSAnQn6TO7iTYrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F7911FB;
	Fri, 28 Jun 2024 02:34:05 -0700 (PDT)
Received: from [10.1.30.21] (e127648.arm.com [10.1.30.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4291F3F6A8;
	Fri, 28 Jun 2024 02:33:37 -0700 (PDT)
Message-ID: <f1ceaf85-8b51-48e3-91ae-e666ba2c5dac@arm.com>
Date: Fri, 28 Jun 2024 10:33:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCHv2 3/3] cpuidle: teo: Don't count non-existent intercepts
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240611112413.1241352-1-christian.loehle@arm.com>
 <20240611112413.1241352-4-christian.loehle@arm.com>
 <99518a43-8347-4f62-aaf6-de6ce68eca0c@arm.com>
Content-Language: en-US
In-Reply-To: <99518a43-8347-4f62-aaf6-de6ce68eca0c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/24 14:09, Dietmar Eggemann wrote:
> On 11/06/2024 13:24, Christian Loehle wrote:
>> When bailing out early, teo will not query the sleep length anymore
>> since commit 6da8f9ba5a87 ("cpuidle: teo:
>> Skip tick_nohz_get_sleep_length() call in some cases") with an
>> expected sleep_length_ns value of KTIME_MAX.
>> This lead to state0 accumulating lots of 'intercepts' because
>> the actually measured sleep length was < KTIME_MAX, so count KTIME_MAX
>> as a hit (we have to count them as something otherwise we are stuck)
>> and therefore teo taking too long to recover from intercept-heavy
>> scenarios.
>>
>> Fundamentally we can only do one of the two:
>> 1. Skip sleep_length_ns query when we think intercept is likely
> 
> Isn't this what we do right now? Skip tick_nohz_get_sleep_length() for
> state0 and set cpu_data->sleep_length_ns to KTIME_MAX in teo_select()
> and then count this as an 'intercept' in teo_update().

Yes it is, I'll state that more explicitly in the future, it was
kind of implied by "we can only do one of the two" and "This patch
chooses the latter".

> 
>> 2. Have accurate data if sleep_length_ns is actually intercepted when
>> we believe it is currently intercepted.
>>
>> This patch chooses the latter as I've found the additional time it
>> takes to query the sleep length to be negligible and the variants of
>> option 1 (count all unknowns as misses or count all unknown as hits)
>> had significant regressions (as misses had lots of too shallow idle
>> state selections and as hits had terrible performance in
>> intercept-heavy workloads).
> 
> IMHO, you do 2 things here:
> 
> (1) Set 'cpu_data->sleep_length_ns != KTIME_MAX' for '!idx &&
>     prev_intercept_idx' in teo_select().

This is just the technical way of saying "We query the sleep length
even though teo is in an intercept scenario (and don't use the sleep
length for determining the current idle state selection)".

> 
> (2) Force an update with 'cpu_data->sleep_length_ns == KTIME_MAX' to be
>     counted as a 'hit' rather an 'intercept' in teo_update().

I assume this is the one you have an issue with and you're correct.
This isn't quite obvious from the text.
Furthermore the KTIME_MAX won't be set for intercept-bailouts anyway
with (1) and thus doesn't become that important in terms of resulting
behavior. I still think (2) is the semantically correct thing to do,
but I'll drop it for the fixes series and add it to the remaining
'improvements' pile.
Thanks!

> 
> Can't really see how this matches the explanatory text exactly.
> [SNIP]

