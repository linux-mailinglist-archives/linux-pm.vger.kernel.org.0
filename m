Return-Path: <linux-pm+bounces-37946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D288BC57393
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56AFF34E238
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE842F0C46;
	Thu, 13 Nov 2025 11:32:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771C2EE607;
	Thu, 13 Nov 2025 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033567; cv=none; b=M2Xc0nlj1CODgnhPghOozq7rSToT8JJml1e8+4226CG3fhmMk3wquK+P96YpiYg/EW7x6V0NPPZjO7OR+ymFntnbgQaeY4clQRAHvvUtSe3449e9VGL28oQcpoYrjbtTZODGRIeO2lLmsj5FJRWQJ3t0sQIKvc3ytaBFhCkTvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033567; c=relaxed/simple;
	bh=gsE04yxtQUqCAg9Uv0wf+vQtEfwTWll6x+wXBOPmv+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqDeTLTe3/r72/BT+CmhUEsga/ILynKvERYyMb62epjMy1ys5/JJpfqDuAsRoUlMDuryx9qboI/iJv+AyMtwDTxX6gqJLayOMdN7Qo2cLJVkMYEHsSgCBzH17bxv9Rs7L2J2RLTbgp0i8HJQwb7s1QOSn3gQ7ufaRg42MJG5o6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1FD112FC;
	Thu, 13 Nov 2025 03:32:37 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2B6D3F66E;
	Thu, 13 Nov 2025 03:32:44 -0800 (PST)
Message-ID: <1dc4934f-a3ce-4ead-a43c-0a80987364b6@arm.com>
Date: Thu, 13 Nov 2025 11:32:42 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] cpuidle: governors: teo: Drop incorrect target
 residency check
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
 <5035693.GXAFRqVoOG@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5035693.GXAFRqVoOG@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 16:22, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When the target residency of the current candidate idle state is
> greater than the expected time till the closest timer (the sleep
> length), it does not matter whether or not the tick has already
> been stopped or if it is going to be stopped.  The closest timer
> will trigger anyway at its due time, so it does not make sense to
> select an idle state with target residency above the sleep length.
> 
> Accordingly, drop the teo_state_ok() check done in that case and
> let the governor use the teo_find_shallower_state() return value
> as the new candidate idle state index.
> 
> Fixes: 21d28cd2fa5f ("cpuidle: teo: Do not call tick_nohz_get_sleep_length() upfront")
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -458,11 +458,8 @@ static int teo_select(struct cpuidle_dri
>  	 * If the closest expected timer is before the target residency of the
>  	 * candidate state, a shallower one needs to be found.
>  	 */
> -	if (drv->states[idx].target_residency_ns > duration_ns) {
> -		i = teo_find_shallower_state(drv, dev, idx, duration_ns, false);
> -		if (teo_state_ok(i, drv))
> -			idx = i;
> -	}
> +	if (drv->states[idx].target_residency_ns > duration_ns)
> +		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, false);
>  
>  	/*
>  	 * If the selected state's target residency is below the tick length
> 
> 
> 

AFAICT this check was to not be stuck in a shallow state when tick is already disabled.
There might be a timer armed in t+500us but that might still get cancelled, which
is why we didn't think a below TICK_NSEC 'shallow' state is acceptable?

