Return-Path: <linux-pm+bounces-20488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14BEA125E5
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 15:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B1A1880909
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA724A7EC;
	Wed, 15 Jan 2025 14:22:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3337E24A7D0;
	Wed, 15 Jan 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950923; cv=none; b=Ji4GffRP4Q6G3BtzkcIfTeXQmh3bBxyIxCPjOZelChUg7dIXhe4epFCVgbe8aeiNeLoYHrsvo0xPLTTazLtUCAbFWtr+2GYS/u4pmTkZ198PuE5dgZFvRQw5uLOnmhNxnhwCc4Onlz0UW/IDLzrO8ce4kXCtIEmqHSJFyd2esQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950923; c=relaxed/simple;
	bh=R47fIdIR/v/+YPZYK2YlCY/UWF7yJ+SIx5KujMpeezs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfohCH3VIdek7l5M2RaLz2Y8hDsd0fyzXn/OTaB4GdZBXM2Bv48sQihaZNKQfl+phdwAljpuHCRkbqTtg1zVfYMQTsABlnx/7B4InPOuhR4khSnjgqq9Nr60iTtagjONRyE0Q9Nx1A6WYP5+REKOpfJO+A8GpIaejUxMS/scDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9E3211FB;
	Wed, 15 Jan 2025 06:22:28 -0800 (PST)
Received: from [10.1.38.43] (e127648.arm.com [10.1.38.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F96A3F63F;
	Wed, 15 Jan 2025 06:21:59 -0800 (PST)
Message-ID: <afcbae77-67a6-4f7a-800d-bf26a899b90a@arm.com>
Date: Wed, 15 Jan 2025 14:21:57 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] cpuidle: teo: Rearrange idle state lookup code
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <4619938.LvFx2qVVIh@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4619938.LvFx2qVVIh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:34, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rearrange code in the idle state lookup loop in teo_select() to make it
> somewhat easier to follow and update comments around it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
> 
> This is the same patch as
> 
> https://lore.kernel.org/linux-pm/3332506.aeNJFYEL58@rjwysocki.net/
> 
> ---
>  drivers/cpuidle/governors/teo.c |   34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -367,7 +367,7 @@
>  	 * If the sum of the intercepts metric for all of the idle states
>  	 * shallower than the current candidate one (idx) is greater than the
>  	 * sum of the intercepts and hits metrics for the candidate state and
> -	 * all of the deeper states a shallower idle state is likely to be a
> +	 * all of the deeper states, a shallower idle state is likely to be a
>  	 * better choice.
>  	 */
>  	prev_intercept_idx = idx;
> @@ -396,30 +396,36 @@
>  				 * first enabled state that is deep enough.
>  				 */
>  				if (teo_state_ok(i, drv) &&
> -				    !dev->states_usage[i].disable)
> +				    !dev->states_usage[i].disable) {
>  					idx = i;
> -				else
> -					idx = first_suitable_idx;
> -
> +					break;
> +				}
> +				idx = first_suitable_idx;
>  				break;
>  			}
>  
>  			if (dev->states_usage[i].disable)
>  				continue;
>  
> -			if (!teo_state_ok(i, drv)) {
> +			if (teo_state_ok(i, drv)) {
>  				/*
> -				 * The current state is too shallow, but if an
> -				 * alternative candidate state has been found,
> -				 * it may still turn out to be a better choice.
> +				 * The current state is deep enough, but still
> +				 * there may be a better one.
>  				 */
> -				if (first_suitable_idx != idx)
> -					continue;
> -
> -				break;
> +				first_suitable_idx = i;
> +				continue;
>  			}
>  
> -			first_suitable_idx = i;
> +			/*
> +			 * The current state is too shallow, so if no suitable
> +			 * states other than the initial candidate have been
> +			 * found, give up (the remaining states to check are
> +			 * shallower still), but otherwise the first suitable
> +			 * state other than the initial candidate may turn out
> +			 * to be preferable.
> +			 */
> +			if (first_suitable_idx == idx)
> +				break;
>  		}
>  	}
>  	if (!idx && prev_intercept_idx) {
> 
> 
> 


