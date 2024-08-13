Return-Path: <linux-pm+bounces-12150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E45950605
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6B3B2227B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D055619ADAA;
	Tue, 13 Aug 2024 13:09:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C318A94E;
	Tue, 13 Aug 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554565; cv=none; b=VbvgytqQLQ2v34wFskOx1AIj6Fi9hJUrjmcu8USSRD0UwcmgBuCedvu7+0a/EN9FeTZf9U16ABi/GC+y+bTFI9SGvj5cTgKsRlScIqMqvZ2Hs4S9LVxnmn/oqINh5OAeZRxKp4K5XGYWpel57zgH8FAqXhz7CZLu/9ecWHEwUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554565; c=relaxed/simple;
	bh=ILz6YE5PV2hkpYKxw1tQdKEoLMSr5oeVb5KDJS931ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOX/EsBU/hrsKoP6eqU0O6nM+PndyzWMsK3XxiK+aT/Fe8f/qvQ/sWQQj6KNgni4ojQM0owXL+xXCfq+j+Duu60RO4T9SYYbTh5DUt5lNx+5Llw/S4JwDmgRzXKpsx8RqVqp6GFR9OdDCMBBVKMH/Vx4we4SW03uAE1AH7tm0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9402912FC;
	Tue, 13 Aug 2024 06:09:49 -0700 (PDT)
Received: from [10.57.84.20] (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64DFD3F6A8;
	Tue, 13 Aug 2024 06:09:22 -0700 (PDT)
Message-ID: <c20a07e4-b9e6-4a66-80f5-63d679b17c3b@arm.com>
Date: Tue, 13 Aug 2024 14:09:20 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpuidle/menu: avoid prioritizing physical state over
 polling state
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
 <20240809073120.250974-2-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240809073120.250974-2-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/24 08:31, Aboorva Devarajan wrote:
> Update the cpuidle menu governor to avoid prioritizing physical states
> over polling states when predicted idle duration is lesser than the
> physical states target residency duration for performance gains.
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  drivers/cpuidle/governors/menu.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index f3c9d49f0f2a..cf99ca103f9b 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -354,17 +354,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  			idx = i; /* first enabled state */
>  
>  		if (s->target_residency_ns > predicted_ns) {
> -			/*
> -			 * Use a physical idle state, not busy polling, unless
> -			 * a timer is going to trigger soon enough.
> -			 */
> -			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> -			    s->exit_latency_ns <= latency_req &&
> -			    s->target_residency_ns <= data->next_timer_ns) {
> -				predicted_ns = s->target_residency_ns;
> -				idx = i;
> -				break;
> -			}
>  			if (predicted_ns < TICK_NSEC)
>  				break;
>  


How about this?
data->next_timer_ns is set to KTIME_MAX in case the last few intervals were
very short, which might be the case for you.

-->8--

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index f3c9d49f0f2a..77b40201c446 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -360,6 +360,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                         */
                        if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
                            s->exit_latency_ns <= latency_req &&
+                           data->next_timer_ns != KTIME_MAX &&
                            s->target_residency_ns <= data->next_timer_ns) {
                                predicted_ns = s->target_residency_ns;
                                idx = i;


