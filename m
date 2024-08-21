Return-Path: <linux-pm+bounces-12621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D25959956
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63D11C213BC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866661CEAAF;
	Wed, 21 Aug 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e8hFzcFT"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4501CEAA8;
	Wed, 21 Aug 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233932; cv=none; b=lAax2HpvxzxdIYPtll1Xgx5WL54o9UAhMet2lFYdY1GNuq5TKVA1v9k8zpWARtgYQCCdGot3SawXB2Iqa9aVs2/cA/gBh+nJ3QyERn6OFJUvXgmkY2wkssezIxz4Zo6JCP7P7kDdlvkq/8sz/LiWdt+g/E6BclV/FK/E/nN2HOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233932; c=relaxed/simple;
	bh=oX5Y70PeZSV3FnIe5Qe50n57CiaewuBdW2S9LxKusGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOIYWXLVjpugg3hXlztQxhqogIxn4I+M5Su+Fiz378EI1u9bOZatQx72ygK5JsCDWO9/DlKNizlJIvvOKjMPR25QD5DleQGz1K0i7+zpNCG/+nnn0w/l4ZjTFvbQ65lY7k8UmLw2j9vt7jzCMDM9OmQzQNCcXjL9sDvdqcz+/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e8hFzcFT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47L9p7Tu016774;
	Wed, 21 Aug 2024 04:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724233867;
	bh=H7rReYITgrUtmdZwgpSvcFNTCUfWweG/KI6cfIfwQdA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=e8hFzcFTgf0zsEftdMITEA0451Egc41z72EY29SJRk5GYYpue1gNlzoaIJGoexYQw
	 pRSPZDfR5Eo5YcwcgZAqFbLgxoNfMtDIV+A/QZiTJH5+Q+S2RfdaMGmYccBIZU/hLR
	 dcAmCDsz0KduaO3d59hz0YrVeQXNEYwaLouR0Fgg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47L9p7HL027706
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 04:51:07 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 04:51:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 04:51:06 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47L9p6Vt065443;
	Wed, 21 Aug 2024 04:51:06 -0500
Date: Wed, 21 Aug 2024 15:21:05 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Preeti U Murthy <preeti@linux.vnet.ibm.com>, <peterz@infradead.org>,
        <rlippert@google.com>, <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linus.walleij@linaro.org>,
        <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <sudeep.holla@arm.com>, <tglx@linutronix.de>,
        <linuxppc-dev@lists.ozlabs.org>, <khilman@ti.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle: Select a different state on
 tick_broadcast_enter() failures
Message-ID: <20240821095105.xuf2a5xe3yxqqewj@lcpd911>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <3161640.llJtBoKCBr@vostro.rjw.lan>
 <8965830.CMQzZzsqm0@vostro.rjw.lan>
 <4652506.tkuQIhnkdH@vostro.rjw.lan>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4652506.tkuQIhnkdH@vostro.rjw.lan>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On May 10, 2015 at 01:19:52 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If tick_broadcast_enter() fails in cpuidle_enter_state(),
> try to find another idle state to enter instead of invoking
> default_idle_call() immediately and returning -EBUSY which
> should increase the chances of saving some energy in those
> cases.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Found this during code review, hence dug up this old thread again,

>  drivers/cpuidle/cpuidle.c |   20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -73,7 +73,10 @@ int cpuidle_play_dead(void)
>  }
>  
>  static int find_deepest_state(struct cpuidle_driver *drv,
> -			      struct cpuidle_device *dev, bool freeze)
> +			      struct cpuidle_device *dev,
> +			      unsigned int max_latency,
> +			      unsigned int forbidden_flags,
> +			      bool freeze)
>  {
>  	unsigned int latency_req = 0;
>  	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
> @@ -83,6 +86,8 @@ static int find_deepest_state(struct cpu
>  		struct cpuidle_state_usage *su = &dev->states_usage[i];
>  
>  		if (s->disabled || su->disable || s->exit_latency <= latency_req
> +		    || s->exit_latency > max_latency
> +		    || (s->flags & forbidden_flags)
>  		    || (freeze && !s->enter_freeze))
>  			continue;
>  
> @@ -100,7 +105,7 @@ static int find_deepest_state(struct cpu
>  int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  			       struct cpuidle_device *dev)
>  {
> -	return find_deepest_state(drv, dev, false);
> +	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>  }
>  
>  static void enter_freeze_proper(struct cpuidle_driver *drv,
> @@ -139,7 +144,7 @@ int cpuidle_enter_freeze(struct cpuidle_
>  	 * that interrupts won't be enabled when it exits and allows the tick to
>  	 * be frozen safely.
>  	 */
> -	index = find_deepest_state(drv, dev, true);
> +	index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
>  	if (index >= 0)
>  		enter_freeze_proper(drv, dev, index);
>  
> @@ -168,8 +173,13 @@ int cpuidle_enter_state(struct cpuidle_d
>  	 * CPU as a broadcast timer, this call may fail if it is not available.
>  	 */
>  	if (broadcast && tick_broadcast_enter()) {
> -		default_idle_call();
> -		return -EBUSY;
> +		index = find_deepest_state(drv, dev, target_state->exit_latency,
> +					   CPUIDLE_FLAG_TIMER_STOP, false);
> +		if (index < 0) {

Would this condition ever meet?
If you see, the ret inside find_deepest_state is always starting with a 0 and
then nobody is ever really making it negative again. So the func either
returns a 0 or some positive value right?

Since nobody has probably raised an issue about this in 9 years, is this
basically dead code inside the if?
Let me know what needs to be done here, I'd be happy to patch this up.

> +			default_idle_call();
> +			return -EBUSY;
> +		}
> +		target_state = &drv->states[index];
>  	}
>  
>  	/* Take note of the planned idle state. */
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

