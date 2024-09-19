Return-Path: <linux-pm+bounces-14471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB8797CC0B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDF9B22551
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E81A00D4;
	Thu, 19 Sep 2024 16:08:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0C12E4A;
	Thu, 19 Sep 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762100; cv=none; b=SRdq0Nl5/JV0Anl3q6bJY6xQOt+lkxqa0NFZ0Pp4Kv2lQTEKbtYlU/4VYnklt6CQgZgyGO6AEEQbyhbab8E1js2+DhACI7GgbspN88JLBBkR5rDnm5274od6pI1+L4qLHoNxOs9OAEUDFUmxjO1KrGrlukV/cVAlDKvxDvNYYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762100; c=relaxed/simple;
	bh=dOd9scNVhOFHzv5AzvwVvWrCZQN/bKmXb1v4ZQjOXaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWJsNOZYP2TSSIZqNBYVhJLnWk1NGk5W4QhESHDqhWxs3DAPEQ0lo26F/sAMUplcqD7hEcN/pJp7sgMWbwUNs8t17/d+3d0g8mHHT1GaOeM6gdgK3nHceKNrzNyseiDloe2VzAxWt2KSXci5v0EMQ06Jpuyl1vD1i/h0kLVcB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B810A1007;
	Thu, 19 Sep 2024 09:08:47 -0700 (PDT)
Received: from [10.57.78.149] (unknown [10.57.78.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B1B73F64C;
	Thu, 19 Sep 2024 09:08:17 -0700 (PDT)
Message-ID: <6c6ef251-814d-45c8-bbad-3096b9265397@arm.com>
Date: Thu, 19 Sep 2024 17:08:15 +0100
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

I would use something like this as wording:

[PATCH] cpuidle: menu: Select polling on short predicted idle
Select a shallow state matching our predicted_ns even if it is a
polling one.

Additionally to querying the next timer event, menu also employs an
interval tracking strategy of most recent idle durations for workloads
that aren't woken up by predictable timer events. The logic predicts
the next wakeup as predicted_ns, but the logic handling that skipped
any polling states.
In the worst-case on POWER we might only have snooze as polling and
CEDE. This makes the entire logic around it a NOP as it never let's
predicted_ns choose an appropriate idle state since it requires a
non-polling one.
To actually enforce predicted_ns for idle state selection actually use
states even though they are polling ones.

Even for a perfect recent intervals of
[1, 1, 1, 1, 1, 1, 1, 1]
menu previously chose the first non-idle state.


-----

To mitigate potential side-effects since most platforms have a
shallower idle state we could add something based on that, but
really your patch would be the only consistent IMO.

I'm not quite sure why this was put there in the first place.
It was essentially introduced in
commit ("69d25870f20c cpuidle: fix the menu governor to boost IO performance")
with a 20us lower limit.

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


