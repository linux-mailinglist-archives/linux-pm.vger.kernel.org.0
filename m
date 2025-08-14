Return-Path: <linux-pm+bounces-32398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C54B2661F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 15:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C169C1B611B9
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090F13959D;
	Thu, 14 Aug 2025 13:00:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4C2C1A2;
	Thu, 14 Aug 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176440; cv=none; b=JmBiqXrUjVvb0AHsUZ9Jy/M3+f1N39CpHaWSKMU56j5BJvWO7E8VCgrIVjzZeaIcTKJfwWq2wIsc16zDCCkPcK44hFlahLwoGpVeuYKk9z2607JWMA1r4YTAxvpL3hpGt/1xs8RJq9oIKbOIXK2KTN/IONjbBRLQmucGzuV+OiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176440; c=relaxed/simple;
	bh=Az7oX33qNufV5hkHJIP4qvKP6D/1/D4ME/JBSiIraJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0tD8czdW9fQRnDNthYWdy4fK9gzUjGbfLQ7axB5/ff4XZadyAXAvFG9BxcYDFXhkbFvbx+CfuCd/scERKr8lHp5hFXGOgrzGS6rRleY8f79Qv/UFPdTGYMIShnRNj6iZ2fiONhIogitY+4/42ZpOi4BMyge+yShf5yhNQk3Ob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16B6D1688;
	Thu, 14 Aug 2025 06:00:29 -0700 (PDT)
Received: from [10.1.38.46] (e127648.arm.com [10.1.38.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3160A3F5A1;
	Thu, 14 Aug 2025 06:00:35 -0700 (PDT)
Message-ID: <bd940e70-ef2d-4382-9ea6-e2ee32cd9849@arm.com>
Date: Thu, 14 Aug 2025 14:00:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cpuidle: governors: menu: Rearrange main loop in
 menu_select()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <2389215.ElGaqSPkdT@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2389215.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 11:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reduce the indentation level in the main loop of menu_select() by
> rearranging some checks and assignments in it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/governors/menu.c |   72 ++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 35 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -314,45 +314,47 @@
>  		if (s->exit_latency_ns > latency_req)
>  			break;
>  
> -		if (s->target_residency_ns > predicted_ns) {
> -			/*
> -			 * Use a physical idle state, not busy polling, unless
> -			 * a timer is going to trigger soon enough.
> -			 */
> -			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -			    s->target_residency_ns <= data->next_timer_ns) {
> -				predicted_ns = s->target_residency_ns;
> -				idx = i;
> -				break;
> -			}
> -			if (predicted_ns < TICK_NSEC)
> -				break;
> -
> -			if (!tick_nohz_tick_stopped()) {
> -				/*
> -				 * If the state selected so far is shallow,
> -				 * waking up early won't hurt, so retain the
> -				 * tick in that case and let the governor run
> -				 * again in the next iteration of the loop.
> -				 */
> -				predicted_ns = drv->states[idx].target_residency_ns;
> -				break;
> -			}
> +		if (s->target_residency_ns <= predicted_ns) {
> +			idx = i;
> +			continue;
> +		}
> +
> +		/*
> +		 * Use a physical idle state, not busy polling, unless a timer
> +		 * is going to trigger soon enough.
> +		 */
> +		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> +		    s->target_residency_ns <= data->next_timer_ns) {
> +			predicted_ns = s->target_residency_ns;
> +			idx = i;
> +			break;
> +		}
>  
> +		if (predicted_ns < TICK_NSEC)
> +			break;
> +
> +		if (!tick_nohz_tick_stopped()) {
>  			/*
> -			 * If the state selected so far is shallow and this
> -			 * state's target residency matches the time till the
> -			 * closest timer event, select this one to avoid getting
> -			 * stuck in the shallow one for too long.
> +			 * If the state selected so far is shallow, waking up
> +			 * early won't hurt, so retain the tick in that case and
> +			 * let the governor run again in the next iteration of
> +			 * the idle loop.
>  			 */
> -			if (drv->states[idx].target_residency_ns < TICK_NSEC &&
> -			    s->target_residency_ns <= delta_tick)
> -				idx = i;
> -
> -			return idx;
> +			predicted_ns = drv->states[idx].target_residency_ns;
> +			break;
>  		}
>  
> -		idx = i;
> +		/*
> +		 * If the state selected so far is shallow and this state's
> +		 * target residency matches the time till the closest timer
> +		 * event, select this one to avoid getting stuck in the shallow
> +		 * one for too long.
> +		 */
> +		if (drv->states[idx].target_residency_ns < TICK_NSEC &&
> +		    s->target_residency_ns <= delta_tick)
> +			idx = i;
> +
> +		return idx;
>  	}
>  
>  	if (idx == -1)
> 
> 
> 


