Return-Path: <linux-pm+bounces-37144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B47C221EE
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 21:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2B614E50E0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 20:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED7C331A74;
	Thu, 30 Oct 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="oNuCizO3"
X-Original-To: linux-pm@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99693655E9;
	Thu, 30 Oct 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854823; cv=none; b=NifThsCnxeCNqERZdp5GrUSKDRtd8rIAd5TNwp/+e3jIeVWgG5eO9XsDqTyU5hOoNu0kLyH1YT62QDuXICTpYqSXErvwxtAXAC4Sg1/oKO5I7+zXpSf7fhVGWncYPrsayeYEfKlpmBIUEnfKBgMBtDCXxkMo6LMeX9151lzZwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854823; c=relaxed/simple;
	bh=tfmblrhzXjsA6ekSaTQtw6ENryGpp70gPKOdsvjs7ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8r+nv/wt1xMvKIYE5VgQfgE/huaV2dT8zNbj0h82krYJ/kx4Ut9byTTO172qcLWdvcuoxTm5iSDmzywR5hOaiCr3/oHXyT1h1AVwCBZv6Ozfk1W7mP1QiY8Tew69fRLbss6Cof3I/kejxHgpYt01O/7cOXasg0DY++UFOalztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=oNuCizO3; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4cyF7n69jbzDRx;
	Thu, 30 Oct 2025 15:49:57 -0400 (EDT)
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cyF7d5b4gz44Zj;
	Thu, 30 Oct 2025 15:49:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1761853790; bh=tfmblrhzXjsA6ekSaTQtw6ENryGpp70gPKOdsvjs7ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oNuCizO3RYv9/mhuwRRgfbRoJJkLkYRWkhm/AhjjM1bs0n9UWZmOdWMyISiJgVMmn
	 XEHGKzXyKIkGPjKiaKt1MpR5zhglkCteAWWulJlzB5VVm+8ID2FjjX7QK1a/iNQ/tI
	 iBWF2mwoS5ItPU8KEk4UUFgL2+piNXEKg855C4tI=
Message-ID: <777ab283-1189-4415-8602-ebe65ba0f4dc@panix.com>
Date: Thu, 30 Oct 2025 12:49:48 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Allow pm_restrict_gfp_mask() stacking
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <5935682.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <5935682.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 10/28/25 13:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Allow pm_restrict_gfp_mask() to be called many times in a row to avoid
> issues with calling dpm_suspend_start() when the GFP mask has been
> already restricted.
> 
> Only the first invocation of pm_restrict_gfp_mask() will actually
> restrict the GFP mask and the subsequent calls will warn if there is
> a mismatch between the expected allowed GFP mask and the actual one.
> 
> Moreover, if pm_restrict_gfp_mask() is called many times in a row,
> pm_restore_gfp_mask() needs to be called matching number of times in
> a row to actually restore the GFP mask.  Calling it when the GFP mask
> has not been restricted will cause it to warn.
> 
> This is necessary for the GFP mask restriction starting in
> hibernation_snapshot() to continue throughout the entire hibernation
> flow until it completes or it is aborted (either by a wakeup event or
> by an error).
> 
> Fixes: 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in hibernation_snapshot()")
> Fixes: 469d80a3712c ("PM: hibernate: Fix hybrid-sleep")
> Reported-by: Askar Safin <safinaskar@gmail.com>
> Closes: https://lore.kernel.org/linux-pm/20251025050812.421905-1-safinaskar@gmail.com/
> Link: https://lore.kernel.org/linux-pm/20251028111730.2261404-1-safinaskar@gmail.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This supersedes
> 
> https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/
> 
> as it allows the GFP mask to be restricted across the entire hibernation path.

Tested-By: Kenneth R. Crudup <kenny@panix.com>

(Helgaas told me about "b4 shazam" and I've been applying all kinds of 
interesting patches willy-nilly lately :) )

> ---
>   kernel/power/hibernate.c |    4 ----
>   kernel/power/main.c      |   22 +++++++++++++++++-----
>   2 files changed, 17 insertions(+), 9 deletions(-)
> 
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -706,7 +706,6 @@ static void power_down(void)
>   
>   #ifdef CONFIG_SUSPEND
>   	if (hibernation_mode == HIBERNATION_SUSPEND) {
> -		pm_restore_gfp_mask();
>   		error = suspend_devices_and_enter(mem_sleep_current);
>   		if (!error)
>   			goto exit;
> @@ -746,9 +745,6 @@ static void power_down(void)
>   		cpu_relax();
>   
>   exit:
> -	/* Match the pm_restore_gfp_mask() call in hibernate(). */
> -	pm_restrict_gfp_mask();
> -
>   	/* Restore swap signature. */
>   	error = swsusp_unmark();
>   	if (error)
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -31,23 +31,35 @@
>    * held, unless the suspend/hibernate code is guaranteed not to run in parallel
>    * with that modification).
>    */
> +static unsigned int saved_gfp_count;
>   static gfp_t saved_gfp_mask;
>   
>   void pm_restore_gfp_mask(void)
>   {
>   	WARN_ON(!mutex_is_locked(&system_transition_mutex));
> -	if (saved_gfp_mask) {
> -		gfp_allowed_mask = saved_gfp_mask;
> -		saved_gfp_mask = 0;
> -	}
> +
> +	if (WARN_ON(!saved_gfp_count) || --saved_gfp_count)
> +		return;
> +
> +	gfp_allowed_mask = saved_gfp_mask;
> +	saved_gfp_mask = 0;
> +
> +	pm_pr_dbg("GFP mask restored\n");
>   }
>   
>   void pm_restrict_gfp_mask(void)
>   {
>   	WARN_ON(!mutex_is_locked(&system_transition_mutex));
> -	WARN_ON(saved_gfp_mask);
> +
> +	if (saved_gfp_count++) {
> +		WARN_ON((saved_gfp_mask & ~(__GFP_IO | __GFP_FS)) != gfp_allowed_mask);
> +		return;
> +	}
> +
>   	saved_gfp_mask = gfp_allowed_mask;
>   	gfp_allowed_mask &= ~(__GFP_IO | __GFP_FS);
> +
> +	pm_pr_dbg("GFP mask restricted\n");
>   }
>   
>   unsigned int lock_system_sleep(void)
> 
> 
> 
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


