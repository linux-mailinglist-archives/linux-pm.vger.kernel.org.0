Return-Path: <linux-pm+bounces-20223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F7A091A8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AB6188F22A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068320E021;
	Fri, 10 Jan 2025 13:16:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCA20C468;
	Fri, 10 Jan 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736515015; cv=none; b=OKlp9gWnTD343IX5LJrbkb6+5/gxYyl9Zm1liLTP6PX/VZrgjA1/ymqQjKiwSjK11Rcaw78Dg/Y/zvGOmbvrubSuJbi8eDdhmNRfemraYYAYtd9bULr39XHIBxtkXty5Xh5Gs9b8OqPJ/Zgr0UWbnWna1Xa7cDIoUCwv5D6ERp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736515015; c=relaxed/simple;
	bh=QR6cDHWgQdjiZwn5qfBNMTvfecgvNmP5xOctGM7XS6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzlMCf15cmXzRIrkAaVM563pnSN10j59OJUvrqTs5+pkymGgrR6u6W6jw/BbfiJJZhz4hpXgXPpUb6IX+Q9VXWNaaAgE+pd6fMxbILNSbgbqT1/90OLyGrcXE4X/D1+3nf5iblpSlOET47p00HECgsYQlJ4JaK6GEoumKcxh/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B847A1477;
	Fri, 10 Jan 2025 05:17:20 -0800 (PST)
Received: from [10.57.6.52] (unknown [10.57.6.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F6BA3F66E;
	Fri, 10 Jan 2025 05:16:51 -0800 (PST)
Message-ID: <842b1500-9f4f-47e5-9777-ee89351f956e@arm.com>
Date: Fri, 10 Jan 2025 13:16:49 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] cpuidle: teo: Add polling flag check to early
 return path
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <4953183.GXAFRqVoOG@rjwysocki.net>
 <13679187.uLZWGnKmhe@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <13679187.uLZWGnKmhe@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 12:53, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length()
> call in some cases") the teo governor behaves a bit differently on
> systems where idle state 0 is a "polling" state (that is, it is not
> really an idle state, but a loop continuously executed by the CPU).
> Namely, on such systems it skips the tick_nohz_get_sleep_length() call
> if the target residency of the current candidate idle state is small
> enough.
> 
> However, if state 0 itself was to be returned, it would be returned
> right away without calling tick_nohz_get_sleep_length() even on systems
> where it was not a "polling" state until commit 4b20b07ce72f ("cpuidle:
> teo: Don't count non-existent intercepts") that attempted to fix this
> problem.
> 
> Unfortunately, commit 4b20b07ce72f has made the governor always call
> tick_nohz_get_sleep_length() when about to return state 0 early, even
> if that state is a "polling" one, which is inconsistent and defeats
> the purpose of commit 6da8f9ba5a87 in that case.
> 
> Address this by adding a CPUIDLE_FLAG_POLLING check to the path where
> state 0 is returned early to prevent tick_nohz_get_sleep_length() from
> being called if it is a "polling" state.
> 
> Fixes: 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -422,7 +422,8 @@
>  			first_suitable_idx = i;
>  		}
>  	}
> -	if (!idx && prev_intercept_idx) {
> +	if (!idx && prev_intercept_idx &&
> +	    !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
>  		/*
>  		 * We have to query the sleep length here otherwise we don't
>  		 * know after wakeup if our guess was correct.
> 
> 
> 

But then you do run into the issue of intercepts not being detected if
state0 is the right choice, don't you?
This would then enable intercept-detection only for <50% of the time,
another option is to not allow intercepts selecting a polling state, but
there were recent complaints about this exact behavior from Aboorva (+TO).
They don't have a low-latency non-polling state.

https://lore.kernel.org/lkml/20240809073120.250974-1-aboorvad@linux.ibm.com/

Regards,
Christian

