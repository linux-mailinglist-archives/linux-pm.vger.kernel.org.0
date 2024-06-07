Return-Path: <linux-pm+bounces-8747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901228FFDE9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D721C230EA
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0BF15ADA7;
	Fri,  7 Jun 2024 08:14:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A1C13E043;
	Fri,  7 Jun 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748084; cv=none; b=nt0M1QwO+PvDT+cMopxLCwpD2Uk/9wSalzpIvtIdA+opTuGnH4rXoBWJFgj7mBtp5k/wqIuNwqnW6U4JMP7IWSRYmBvXKkxLcuxHhGUylak3INPW7h8j8yCqTCN2cd+eDBNwPMRHbSXz0YGhEWWdgGNTgL9llwbgZS6vnA8ozRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748084; c=relaxed/simple;
	bh=Lrv2JMUnu8KtktRB5CsvxnRHmeg5518CYUsd9b4ohQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWkqOGnb1qQVU3R3oxJeSKNVE8Y7j8I4CZibW8piwQlnA4L7lkJlvFZce72HrWUd618HJ6mLC0DyOQwUW9N//xXjKHyOqVWSF40c6xeXbVh8H+/V2LP3yU7gjgGqPpYg0ExFpYunh7+0Jw9DFv390MDfPjFt0sOa5SrKcZJqY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3862F4;
	Fri,  7 Jun 2024 01:15:06 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 151483F64C;
	Fri,  7 Jun 2024 01:14:39 -0700 (PDT)
Message-ID: <c11acac7-085a-4041-a1f3-8b4f46e4b691@arm.com>
Date: Fri, 7 Jun 2024 10:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] cpuidle: teo: Increase minimum time to stop tick
To: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-5-christian.loehle@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240606090050.327614-5-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 11:00, Christian Loehle wrote:
> Since stopping the tick isn't free, add at least some minor constant
> (1ms) for the threshold to stop the tick.

Sounds pretty arbitrary to me? 'duration_ns' is either based on
target_residency_ns or tick_nohz_get_sleep_length() or even set to
TICK_NSEC/2. Does adding 1ms makes sense to all these cases? But then
why 1ms?

> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index 216d34747e3b..ca9422bbd8db 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -622,10 +622,10 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	/*
>  	 * Allow the tick to be stopped unless the selected state is a polling
>  	 * one or the expected idle duration is shorter than the tick period
> -	 * length.
> +	 * length plus some constant (1ms) to account for stopping it.
>  	 */
>  	if ((!(drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -	    duration_ns >= TICK_NSEC) || tick_nohz_tick_stopped())
> +	    duration_ns > NSEC_PER_MSEC + TICK_NSEC) || tick_nohz_tick_stopped())
>  		return idx;
>  
>  out_tick_state:


