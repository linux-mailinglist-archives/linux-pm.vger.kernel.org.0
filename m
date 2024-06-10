Return-Path: <linux-pm+bounces-8862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA6902019
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 13:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA7F1F21DD5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D565778C9C;
	Mon, 10 Jun 2024 11:06:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B3FC01;
	Mon, 10 Jun 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017573; cv=none; b=P0WdjUA80DsJS/sApvUKNCfNyzoovzFd4LZ6IyjjQuk/cVfa2yl0T9YPdJp3WxRQocyXzHbl6QC0FwrSequI0hVqHsjVkdM6U+FDtTisTHisJRN12XvVi/JcTNWa3/614SWdn0vUhx0QndcCPrw4vyUX2JToZrCB1H9aQwPpY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017573; c=relaxed/simple;
	bh=jsL8Kw6PFgSnYlx7ILeB6Tn4nUKxwvpN9JhVhat3+u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XA1560SbhGFn3ADEWS+Puke/EagxUWBWzp+ZyhQ2eeqM/en3q7Os/txay3koq0yTImJ+J3w8+9kxKghaAfL9EXfTIN7HIkVg1X1sxJsUHybZPtnZKS++vx9S/ResjNChe9j+eFFaI38PWMyjdqR928lIVqPT72Zv3HDsOrYqQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB69612FC;
	Mon, 10 Jun 2024 04:06:35 -0700 (PDT)
Received: from [10.57.71.68] (unknown [10.57.71.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E06A3F73B;
	Mon, 10 Jun 2024 04:06:08 -0700 (PDT)
Message-ID: <33405fa7-7102-407e-8cc8-851c808cd47a@arm.com>
Date: Mon, 10 Jun 2024 12:06:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] cpuidle: teo: Don't count non-existent intercepts
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-7-christian.loehle@arm.com>
 <a71314e6-b248-44a4-8a82-0a8dfde9d44f@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <a71314e6-b248-44a4-8a82-0a8dfde9d44f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 11:17, Dietmar Eggemann wrote:
> On 06/06/2024 11:00, Christian Loehle wrote:
>> When bailing out early, teo will not query the sleep length anymore
>> since commit 6da8f9ba5a87 ("cpuidle: teo:
>> Skip tick_nohz_get_sleep_length() call in some cases") with an
>> expected sleep_length_ns value of KTIME_MAX.
>> This lead to state0 accumulating lots of 'intercepts' because
>> the actually measured sleep length was < KTIME_MAX, so count KTIME_MAX
>> as a hit (we have to count them as something otherwise we are stuck).
>>
>> Fundamentally we can only do one of the two:
>> 1. Skip sleep_length_ns query when we think intercept is likely
>> 2. Have accurate data if sleep_length_ns is actually intercepted when
>> we believe it is currently intercepted.
>>
>> This patch chooses that latter as I've found the additional time it
>> takes to query the sleep length to be negligible and the variants of
>> option 1 (count all unknowns as misses or count all unknown as hits)
>> had significant regressions (as misses had lots of too shallow idle
>> state selections and as hits had terrible performance in
>> intercept-heavy workloads).
> 
> So '2.' is the 'if (prev_intercept_idx != idx && !idx)' case ?
> 
> [...]

Yes, we allow the logic to bail out early, but not without querying the
expected sleep length.
(For idx > 0 the logic will continue to query the expected sleep length
later on.)

> 
>> @@ -514,6 +521,14 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>  			first_suitable_idx = i;
>>  		}
>>  	}
>> +	if (prev_intercept_idx != idx && !idx) {
> 
> if (!idx && prev_intercept_idx) ?
> 

Thanks! I picked that up for the next version.

>> +		/*
>> +		 * We have to query the sleep length here otherwise we don't
>> +		 * know after wakeup if our guess was correct.
>> +		 */
>> +		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
>> +		cpu_data->sleep_length_ns = duration_ns;
>> +	}
>>  
>>  	/*
>>  	 * If there is a latency constraint, it may be necessary to select an
> 


