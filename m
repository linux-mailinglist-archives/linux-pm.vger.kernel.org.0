Return-Path: <linux-pm+bounces-38635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8EBC8607D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC8C24E0252
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88E32937D;
	Tue, 25 Nov 2025 16:50:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0B78F51;
	Tue, 25 Nov 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089428; cv=none; b=Cnwkg5D05Exw1wgcjm3Eig+VADxAZZ7LowhnF61ZfHJqbEoOrjbdUxcMu6j3a3/KIkm8Xr4/xbRJHIuZ91AV5ZgtVzdpPlia1bPMFLbnY+eOf/9zya47NFOoBPYRB4Vk34mHwt4GwewNPHLtAqhvhnhO5zMrLtEtlhmwAqKZa6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089428; c=relaxed/simple;
	bh=DtV+a3bHeaWwdErW6cX+CzO8HCNEZyvwDdrdbX+AIeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5tbh9cSHkTjqErSFKivmSTWZJK4tNHBMzWD9+8AYhPdPP9UUfl605lEBuU9+NlFZWXhFwKixDYoDYt/bYMQC6H2Z97HZr29LLN1oP9JBKwDEUy8XXgO8NsMEEk7UrIT1XskjRoHVrrRjgS6N1b0OklzIWKa9VsLLhxdk+iwMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 069A0168F;
	Tue, 25 Nov 2025 08:50:18 -0800 (PST)
Received: from [10.1.39.33] (unknown [10.1.39.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D21C03F6A8;
	Tue, 25 Nov 2025 08:50:23 -0800 (PST)
Message-ID: <f78cf081-c4c4-43d9-90a1-e32eecb9e889@arm.com>
Date: Tue, 25 Nov 2025 16:50:22 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: Warn instead of bailing out if target
 residency check fails
To: "Rafael J. Wysocki" <rafael@kernel.org>, Val Packett <val@packett.cool>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251121010756.6687-1-val@packett.cool>
 <CAJZ5v0h1VTozCKweKvma3dQiUCz8KkR88Hue1cL_jDaKiP+BEw@mail.gmail.com>
 <2808566.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2808566.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/25 16:23, Rafael J. Wysocki wrote:
> On Friday, November 21, 2025 2:10:57 PM CET Rafael J. Wysocki wrote:
>> On Fri, Nov 21, 2025 at 2:08 AM Val Packett <val@packett.cool> wrote:
>>>
>>> On Device Tree platforms, the latency and target residency values come
>>> directly from device trees, which are numerous and weren't all written
>>> with cpuidle invariants in mind. For example, qcom/hamoa.dtsi currently
>>> trips this check: exit latency 680000 > residency 600000.
>>
>> So this breaks cpuidle expectations and it doesn't work correctly on
>> the affected platforms.
>>
>>> Instead of harshly rejecting the entire cpuidle driver with a mysterious
>>> error message, print a warning and set the target residency value to be
>>> equal to the exit latency.
>>
>> This generally doesn't work because the new target residency may be
>> greater than the target residency of the next state.
>>
>>> Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and target residency")
>>> Signed-off-by: Val Packett <val@packett.cool>
>>> ---
>>>  drivers/cpuidle/driver.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
>>> index 1c295a93d582..06aeb59c1017 100644
>>> --- a/drivers/cpuidle/driver.c
>>> +++ b/drivers/cpuidle/driver.c
>>> @@ -199,8 +199,11 @@ static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>>>                  * exceed its target residency which is assumed in cpuidle in
>>>                  * multiple places.
>>>                  */
>>> -               if (s->exit_latency_ns > s->target_residency_ns)
>>> -                       return -EINVAL;
>>> +               if (s->exit_latency_ns > s->target_residency_ns) {
>>> +                       pr_warn("cpuidle: state %d: exit latency %lld > residency %lld (fixing)\n",
>>> +                               i, s->exit_latency_ns, s->target_residency_ns);
>>> +                       s->target_residency_ns = s->exit_latency_ns;
>>
>> And you also need to update s->target_residency.
>>
>> Moreover, that needs to be done when all of the target residency and
>> exit latency values have been computed and full sanitization of all
>> the states would need to be done (including the ordering checks), but
>> the kernel has insufficient information to do that (for instance, if
>> the ordering is not as expected, it is not clear how to fix it up).
>> Even the above sanitization is unlikely to result in the intended
>> behavior.
>>
>> So if returning the error code doesn't work, printing a warning is as
>> much as can be done, like in the attached patch.
>>
>> If this works for you, I'll submit it properly later.
>>
> 
> No response, so I assume no objections.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It turns out that the change in commit 76934e495cdc ("cpuidle: Add
> sanity check for exit latency and target residency") goes too far
> because there are systems in the field on which the check introduced
> by that commit does not pass.
> 
> For this reason, change __cpuidle_driver_init() return type back to void
> and make it print a warning when the check mentioned above does not
> pass.
> 
> Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and target residency")
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://lore.kernel.org/linux-pm/20251121010756.6687-1-val@packett.cool/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/driver.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -8,6 +8,8 @@
>   * This code is licenced under the GPL.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/mutex.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
> @@ -152,7 +154,7 @@ static void cpuidle_setup_broadcast_time
>   * __cpuidle_driver_init - initialize the driver's internal data
>   * @drv: a valid pointer to a struct cpuidle_driver
>   */
> -static int __cpuidle_driver_init(struct cpuidle_driver *drv)
> +static void __cpuidle_driver_init(struct cpuidle_driver *drv)
>  {
>  	int i;
>  
> @@ -195,15 +197,13 @@ static int __cpuidle_driver_init(struct
>  			s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
>  
>  		/*
> -		 * Ensure that the exit latency of a CPU idle state does not
> -		 * exceed its target residency which is assumed in cpuidle in
> -		 * multiple places.
> +		 * Warn if the exit latency of a CPU idle state exceeds its
> +		 * target residency which is assumed to never happen in cpuidle
> +		 * in multiple places.
>  		 */
>  		if (s->exit_latency_ns > s->target_residency_ns)
> -			return -EINVAL;
> +			pr_warn("Idle state %d target residency too low\n", i);
>  	}
> -
> -	return 0;
>  }
>  
>  /**
> @@ -233,9 +233,7 @@ static int __cpuidle_register_driver(str
>  	if (cpuidle_disabled())
>  		return -ENODEV;
>  
> -	ret = __cpuidle_driver_init(drv);
> -	if (ret)
> -		return ret;
> +	__cpuidle_driver_init(drv);
>  
>  	ret = __cpuidle_set_driver(drv);
>  	if (ret)
> 

FWIW I also prefer this to a weird fixing-up-states logic that we would never test!
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

