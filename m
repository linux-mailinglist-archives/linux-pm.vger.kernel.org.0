Return-Path: <linux-pm+bounces-20489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3781A1266D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 15:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CA716920D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C838614E;
	Wed, 15 Jan 2025 14:46:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59924A7F0;
	Wed, 15 Jan 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952402; cv=none; b=dFQZy8kBbV7YRhSZJUD1rcmZbTAzA4/IPiW8fesA0hHTF0rpo4kh26ElYJaUkD/9QhybpRkXn2SXfmcjsb2JIlAhfYy6hs6dd/bUvi+FVLaZNwV/piFvPkTXfiSA0W+yMhB6lb0bPk2fiikxUjQFWPJ0XzdH6yy+WI5NhkCEx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952402; c=relaxed/simple;
	bh=MDzW2WFv4U5qNnMZKqe2wc3SkWfpAlINxE1EHA4bs1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2aIWsqwCqIzOtyyUPhfLY/igCUI3VtqXDIePQJCPcZq+TRHzbCGc6U7Bv9F9s5b4dYqNcEJIaph7/gIt70ngHl+lFRNsWiFn1rt0XXJvO8MRdtFy9wxdH4S0YOiQwXtZ+MEz3yaGa92dP9PQPbfoHxLPnXEof9xLEW3GxyPF7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE7711FB;
	Wed, 15 Jan 2025 06:47:08 -0800 (PST)
Received: from [10.1.38.43] (e127648.arm.com [10.1.38.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFC023F63F;
	Wed, 15 Jan 2025 06:46:38 -0800 (PST)
Message-ID: <8959e72a-600d-427a-9ab2-54f14b056766@arm.com>
Date: Wed, 15 Jan 2025 14:46:36 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <1907276.tdWV9SEqCh@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1907276.tdWV9SEqCh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since constraint_idx may be 0, the candidate state index may change to 0
> after assigning constraint_idx to it, so first check if it is greater
> than constraint_idx (and update it if so) and then check it against 0.

So the reason I've left this where it was is because the prev_intercept_idx
was supposed to query the sleep length if we're in an majority-intercept
period and then it makes sense to query the sleep length (to detect such
a period being over).
A constraint_idx == 0 scenario doesn't need the intercept-machinery to
work at all, why are we querying the sleep length then?

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a rebased variant of
> 
> https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/
> 
> ---
>  drivers/cpuidle/governors/teo.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -428,6 +428,14 @@
>  				break;
>  		}
>  	}
> +
> +	/*
> +	 * If there is a latency constraint, it may be necessary to select an
> +	 * idle state shallower than the current candidate one.
> +	 */
> +	if (idx > constraint_idx)
> +		idx = constraint_idx;
> +
>  	if (!idx && prev_intercept_idx) {
>  		/*
>  		 * We have to query the sleep length here otherwise we don't
> @@ -439,13 +447,6 @@
>  	}
>  
>  	/*
> -	 * If there is a latency constraint, it may be necessary to select an
> -	 * idle state shallower than the current candidate one.
> -	 */
> -	if (idx > constraint_idx)
> -		idx = constraint_idx;
> -
> -	/*

We could leave this here and just do goto end;?


