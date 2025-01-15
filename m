Return-Path: <linux-pm+bounces-20502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EBBA12BE7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 20:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083E71889EB2
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1DF1D6DBB;
	Wed, 15 Jan 2025 19:43:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9968D1D5AC3;
	Wed, 15 Jan 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970198; cv=none; b=eSNHOByRGXPxLWNUZEFHhRP9FvdZQ63GFBNaJzNKXKEYdefy7daiPgmK/c04CycvjgP3G5K63AOAWv0ovvd65ojSSfE4XfQdrje/1Xa+JOt58kT143PH4fOYunTeVKTtrfZFwEtk7/IwVwB14AZ8ezO19GMOVCtVsjeoJrjmd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970198; c=relaxed/simple;
	bh=DTi8fO+2cceKsWRMyl+IZpVqHpPIxEXH1UvSCdPShO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=df9Kot9lPHXkv3WCXt86O+9XNlf4ZZSmK8j7KTu2DlupGU7DaGpef96Oaf3GdDOamZJrMfop3rpC+WOYwkzvZbfsexVgNq0byt6WyEhKGgo7IX/GpZSGlTZj+LL+b9b1otTTidPS5sPZVtklMkg9xx7I/gv7e14dCTd+fpxnXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C75FA12FC;
	Wed, 15 Jan 2025 11:43:42 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577903F73F;
	Wed, 15 Jan 2025 11:43:13 -0800 (PST)
Message-ID: <7eb5b339-c4f1-4eaa-b9c1-4c775c99efaf@arm.com>
Date: Wed, 15 Jan 2025 19:43:11 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] cpuidle: teo: Clarify two code comments
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <8472971.T7Z3S40VBb@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <8472971.T7Z3S40VBb@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rewrite two code comments suposed to explain its behavior that are too

s/suposed/supposed

> concise or not sufficiently clear.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -154,9 +154,10 @@
>  
>  	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
>  		/*
> -		 * One of the safety nets has triggered or the wakeup was close
> -		 * enough to the closest timer event expected at the idle state
> -		 * selection time to be discarded.
> +		 * This causes the wakeup to be counted as a hit regardless of

regardless of twice.

> +		 * regardless of the real idle duration which doesn't need to be
> +		 * computed because the wakeup has been close enough to an
> +		 * anticipated timer.
>  		 */
>  		measured_ns = U64_MAX;
>  	} else {
> @@ -302,8 +303,13 @@
>  
>  	cpu_data->time_span_ns = local_clock();
>  	/*
> -	 * Set the expected sleep length to infinity in case of an early
> -	 * return.
> +	 * Set the sleep length to infitity in case the invocation of

s/infitity/infinity

> +	 * tick_nohz_get_sleep_length() below is skipped, in which case it won't
> +	 * be known whether or not the subsequent wakeup is caused by a timer.
> +	 * It is generally fine to count the wakeup as an intercept then, except
> +	 * for the cases when the CPU is mostly woken up by timers and there may
> +	 * be opportunities to ask for a deeper idle state when no imminent
> +	 * timers are scheduled which may be missed.

With the above typo fixes.
Reviewed-by: Christian Loehle <christian.loehle@arm.com>


