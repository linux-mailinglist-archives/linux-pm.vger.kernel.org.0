Return-Path: <linux-pm+bounces-20503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F43A12BEB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 20:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C9816667C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CED1D63E8;
	Wed, 15 Jan 2025 19:44:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA4324A7E5;
	Wed, 15 Jan 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970283; cv=none; b=LGyLTYtaI7Oi66QeHJwCac+YLhZsDD2Ium46yKgepLeqrzxjrW55l3NVv2sC8HyjX2EQ3OrXfyhhyK6qK/wlBKltBPKS9II9szicTgZY8kPqjC+WUu6bpKyHSTjS+CENmvajFpubWxzQOdFzT7Uo3cnXn7ryEs4BszZOoZIG7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970283; c=relaxed/simple;
	bh=zypMCRbhNsOWVcCZTCCeiAlHrYtS7et7wXxzTkTyW8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhUatXxmNno3BglNTMrCg/0H3S1fiktEs0NGif5cWU2LthHrg7Y72hZbyz+skOwRNma9/P/romneWkz9j7x6CiitAxrIHOIXM/xdeuGj45vPRE+O+/dTnwUilnGoJ4KD3X5ttWzeTV40DwYhKuH1R1T4A/YMV3B3UVxSPcewDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5156212FC;
	Wed, 15 Jan 2025 11:45:08 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6CF3F73F;
	Wed, 15 Jan 2025 11:44:38 -0800 (PST)
Message-ID: <0021de2a-9342-4e3c-ac71-57ecf6935339@arm.com>
Date: Wed, 15 Jan 2025 19:44:36 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] cpuidle: teo: Combine candidate state index checks
 against 0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <13676346.uLZWGnKmhe@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <13676346.uLZWGnKmhe@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two candidate state index checks against 0 in teo_select()
> that need not be separate, so combine them and update comments around
> them.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a rebased variant of
> 
> https://lore.kernel.org/linux-pm/2296767.iZASKD2KPV@rjwysocki.net/
> 
> ---
>  drivers/cpuidle/governors/teo.c |   23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -436,24 +436,19 @@
>  	if (idx > constraint_idx)
>  		idx = constraint_idx;
>  
> -	if (!idx && prev_intercept_idx) {
> -		/*
> -		 * We have to query the sleep length here otherwise we don't
> -		 * know after wakeup if our guess was correct.
> -		 */
> -		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> -		cpu_data->sleep_length_ns = duration_ns;
> +	if (!idx) {
> +		if (prev_intercept_idx) {
> +			/*
> +			 * Query the sleep length to be able to count the wakeup
> +			 * as a hit if it is caused by a timer.
> +			 */
> +			duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> +			cpu_data->sleep_length_ns = duration_ns;
> +		}
>  		goto out_tick;
>  	}
>  
>  	/*
> -	 * Skip the timers check if state 0 is the current candidate one,
> -	 * because an immediate non-timer wakeup is expected in that case.
> -	 */
> -	if (!idx)
> -		goto out_tick;
> -
> -	/*
>  	 * If state 0 is a polling one, check if the target residency of
>  	 * the current candidate state is low enough and skip the timers
>  	 * check in that case too.
> 
> 
> 

This patch relies on the previous one, but given that you'll probably
convince me on that:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

