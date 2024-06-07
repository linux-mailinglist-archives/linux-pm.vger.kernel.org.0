Return-Path: <linux-pm+bounces-8765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC78FFF7A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AECF1F2563E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028FB15B969;
	Fri,  7 Jun 2024 09:29:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859F215B143;
	Fri,  7 Jun 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752548; cv=none; b=WtVCvWM/JZWGqTceuRgvYqH5zZD/IbLHWrvIGnQHHWrL6hKm4v5dbcD28+tv6xuwWgJIzuJupiWcMvklZV85r6gIjQsKWbgBt0SLbEqG6RLmWdfysmXUEkkQlTGq+lkTNTFGZrKw27tj8rwmacCOhJ5flb5pgRfUHHfQEN2c/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752548; c=relaxed/simple;
	bh=tVKja3TODpkq5BiJV/Alpr164LIt6krldc8AlGeoxQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rh3AywwXNtHZFPYQHK0KJocXwiWFxgcttwg4Y10FV2qf+KXhGidTheMmXBVpWDQhlZQLpNZyiYEEfu79AUdbnqqBMzWmh8VeeiWpKJcPQFqNlNLpPMECWEyXgg+pk2d2YiNeCT/igy3vLMNiP3gkMTPaQ59wzO1IhruHfD8aKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B2532F4;
	Fri,  7 Jun 2024 02:29:31 -0700 (PDT)
Received: from [10.57.70.22] (unknown [10.57.70.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94FE73F762;
	Fri,  7 Jun 2024 02:29:03 -0700 (PDT)
Message-ID: <edffb2d4-a13d-4973-ae6f-af993a6225de@arm.com>
Date: Fri, 7 Jun 2024 10:29:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] cpuidle: teo: Increase minimum time to stop tick
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-5-christian.loehle@arm.com>
 <c11acac7-085a-4041-a1f3-8b4f46e4b691@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <c11acac7-085a-4041-a1f3-8b4f46e4b691@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 09:14, Dietmar Eggemann wrote:
> On 06/06/2024 11:00, Christian Loehle wrote:
>> Since stopping the tick isn't free, add at least some minor constant
>> (1ms) for the threshold to stop the tick.
> 
> Sounds pretty arbitrary to me? 'duration_ns' is either based on
> target_residency_ns or tick_nohz_get_sleep_length() or even set to
> TICK_NSEC/2. Does adding 1ms makes sense to all these cases? But then
> why 1ms?

It definitely is arbitrary, you're correct.
Feel free to treat this as RFC. I'll probably just drop this from the
serie and issue separately (to get the actual fixes merged more quickly).
Anyway I'd like to hear comments on this.

We are only interested in the cost of stopping the tick, which doesn't
really depend on the selected state residency nor the expected sleep length.
1ms works fine (for me!!), making it depend on TICK_NSEC would be natural,
too, but using TICK_NSEC is far too long for CONFIG_HZ=100 (and TICK_NSEC/2
too short for CONFIG_HZ=1000).
The cost of stopping the tick depends on a number of factors and knowing all
of them is probably not on the table anytime soon and until then I'd consider
this an improvement over 0.

> 
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  drivers/cpuidle/governors/teo.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
>> index 216d34747e3b..ca9422bbd8db 100644
>> --- a/drivers/cpuidle/governors/teo.c
>> +++ b/drivers/cpuidle/governors/teo.c
>> @@ -622,10 +622,10 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>  	/*
>>  	 * Allow the tick to be stopped unless the selected state is a polling
>>  	 * one or the expected idle duration is shorter than the tick period
>> -	 * length.
>> +	 * length plus some constant (1ms) to account for stopping it.
>>  	 */
>>  	if ((!(drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
>> -	    duration_ns >= TICK_NSEC) || tick_nohz_tick_stopped())
>> +	    duration_ns > NSEC_PER_MSEC + TICK_NSEC) || tick_nohz_tick_stopped())
>>  		return idx;
>>  
>>  out_tick_state:
> 


