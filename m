Return-Path: <linux-pm+bounces-38020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 196BAC5C3D6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 10:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 062484FB45D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84F2FFF8D;
	Fri, 14 Nov 2025 09:16:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A482F6904;
	Fri, 14 Nov 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111811; cv=none; b=QNJ/HtuodJVrpFW2Vm90A2jCxdOG7Jf6HSfW18XBF6QMtT8PJIkmisQYDvH2Xj615NMNMIOvxEU86n9y5F2v4OSZs9ggaIwajELDH4ecrDG7M/TqTo8KlLH0n3VxUbP2bZuEJBHV6C1N9XoNSC/4GDpvXX57LJ+rWd/GJ84DgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111811; c=relaxed/simple;
	bh=U6aNknAI0snecy+k1j4GPNqzHaeAQejY2Yx0pkU1rE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZOPhVhrwhWPC843Sz1tVImWZDzmvrQiylNnEmoqBl4mRuKph3tPHEYifbWvUG0ln+B72ZjOj2Pk5lec4FYZqW0zfF23BENSZXKMc+zf/cjHlhAhou8U6e7h5aJ9Bv06BRULPa46tk3Holtt4xEdbSG3sOaI/+6jCnT8qs3LL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9AE81063;
	Fri, 14 Nov 2025 01:16:40 -0800 (PST)
Received: from [10.57.41.249] (unknown [10.57.41.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A9F43F66E;
	Fri, 14 Nov 2025 01:16:47 -0800 (PST)
Message-ID: <2d8f3f25-1b96-4e66-83b8-78a3b501f1e4@arm.com>
Date: Fri, 14 Nov 2025 09:16:45 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] cpuidle: governors: teo: Drop misguided target
 residency check
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
 <5035693.GXAFRqVoOG@rafael.j.wysocki> <5955081.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5955081.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 13:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When the target residency of the current candidate idle state is
> greater than the expected time till the closest timer (the sleep
> length), it does not matter whether or not the tick has already been
> stopped or if it is going to be stopped.  The closest timer will
> trigger anyway at its due time, so if an idle state with target
> residency above the sleep length is selected, energy will be wasted
> and there may be excess latency.
> 
> Of course, if the closest timer were canceled before it could trigger,
> a deeper idle state would be more suitable, but this is not expected
> to happen (generally speaking, hrtimers are not expected to be
> canceled as a rule).
> 
> Accordingly, the teo_state_ok() check done in that case causes energy to
> be wasted more often than it allows any energy to be saved (if it allows
> any energy to be saved at all), so drop it and let the governor use the
> teo_find_shallower_state() return value as the new candidate idle state
> index.
> 
> Fixes: 21d28cd2fa5f ("cpuidle: teo: Do not call tick_nohz_get_sleep_length() upfront")
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Subject and changelog modifications
> 
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

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


