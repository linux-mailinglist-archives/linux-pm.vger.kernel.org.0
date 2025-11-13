Return-Path: <linux-pm+bounces-37950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333BC57438
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A11B034B674
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91E320A0E;
	Thu, 13 Nov 2025 11:46:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA727B34E;
	Thu, 13 Nov 2025 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034419; cv=none; b=qjWgP7GJl9Y35BwPtgfO3KhWbMM5U8pcqrlBvQGz84Qw1EXV5gGer4XMawJwEofKkmrlRuuqEKniXxCBmmIxFdCojUMn/BU+xjVfUklVyeq9xPA1ciSvlnVS3gCuZAsm0cSgrqH3TyALr/5lg8007ksTBosCqARS7ss4V/6VBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034419; c=relaxed/simple;
	bh=u7hxcLqZJXuPbIi6sMDHo+OcymugydI5OddMaW+gawI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMxI0Cav63HX6YvDbBJA1ETKaPsAm7D/mzhWeSZdd2spYvuH8HwcP7clLW4Xw1xDlp7qWmw1TywGprScHJS/b/XVhVth8nnSD4iJKkYmh3s29xqsERzFP4mlccU6RKWLcCHfXsNQCha55PSX8gLh487OcbA/LnSufmk5iYAQqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8610B12FC;
	Thu, 13 Nov 2025 03:46:49 -0800 (PST)
Received: from [10.1.28.59] (e127648.arm.com [10.1.28.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 375FE3F66E;
	Thu, 13 Nov 2025 03:46:55 -0800 (PST)
Message-ID: <b70a9578-74ed-4ac4-bd8c-90b075439112@arm.com>
Date: Thu, 13 Nov 2025 11:46:53 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] cpuidle: governors: teo: Drop redundant function
 parameter
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
References: <4701737.LvFx2qVVIh@rafael.j.wysocki>
 <2253109.irdbgypaU6@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2253109.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 16:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The last no_poll parameter of teo_find_shallower_state() is always
> false, so drop it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/governors/teo.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -239,17 +239,15 @@ static bool teo_state_ok(int i, struct c
>   * @dev: Target CPU.
>   * @state_idx: Index of the capping idle state.
>   * @duration_ns: Idle duration value to match.
> - * @no_poll: Don't consider polling states.
>   */
>  static int teo_find_shallower_state(struct cpuidle_driver *drv,
>  				    struct cpuidle_device *dev, int state_idx,
> -				    s64 duration_ns, bool no_poll)
> +				    s64 duration_ns)
>  {
>  	int i;
>  
>  	for (i = state_idx - 1; i >= 0; i--) {
> -		if (dev->states_usage[i].disable ||
> -				(no_poll && drv->states[i].flags & CPUIDLE_FLAG_POLLING))
> +		if (dev->states_usage[i].disable)
>  			continue;
>  
>  		state_idx = i;
> @@ -459,7 +457,7 @@ static int teo_select(struct cpuidle_dri
>  	 * candidate state, a shallower one needs to be found.
>  	 */
>  	if (drv->states[idx].target_residency_ns > duration_ns)
> -		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, false);
> +		idx = teo_find_shallower_state(drv, dev, idx, duration_ns);
>  
>  	/*
>  	 * If the selected state's target residency is below the tick length
> @@ -487,7 +485,7 @@ end:
>  	 */
>  	if (idx > idx0 &&
>  	    drv->states[idx].target_residency_ns > delta_tick)
> -		idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
> +		idx = teo_find_shallower_state(drv, dev, idx, delta_tick);
>  
>  out_tick:
>  	*stop_tick = false;
> 
> 
> 


