Return-Path: <linux-pm+bounces-37045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA23C1BC85
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21EAC5A0C98
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B742F6912;
	Wed, 29 Oct 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQT4rKcI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEFA2DEA8C;
	Wed, 29 Oct 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751340; cv=none; b=l20i7vCen1gQJ2ez2PInXOsPQNH4RnoQSg81/6aEMqAaDkNaatu4v/luzTmp3iBkjaMDzrw2G0ouXNjQdmHnJ6e0hy0q9I/Ym8VuOoUieSJ5WlUS/EDDfXxrSUP6AC/U7ksgDDvALh98foqcPcP6qkdQjdn8r+iG1IcxuE6o1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751340; c=relaxed/simple;
	bh=kd0zFIWO1a/ARX+pL8vZNG00zHaMnbNJfmTVzScY8gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AylSGm9yGioL9V5eap1LbrAym4/jONsfkzSMIkp3k0aQ+BJ8vcXYnq8Gvybe6P/9X2RWXPwJpqKn6tv0pcxH5TG5xLk21OAWztpUFwncdWMLVwL2CV58DJOc13zQattklrH1GinM7FLVkL20oo+TPy6Vh67C9I9f2Ncl0RJPBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQT4rKcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC0BC4CEF7;
	Wed, 29 Oct 2025 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751339;
	bh=kd0zFIWO1a/ARX+pL8vZNG00zHaMnbNJfmTVzScY8gE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hQT4rKcIemHJK22zWFEwiDApN9/S2TEiX+n+AqwBXYxcQ2phgcyyI/8T0vBedx0uZ
	 nXoSZ8jLCP1wVwxpkHfu6nVzrIx3dQ7l4U3eELOf9xAF0//G9SKfKol6fPRvzElXS4
	 phb/wdAbG83NAPEKsnosEGiIy3vmzB28khPLeeRS0HA/PoPJlKmmDvR1oYVqEJdpXz
	 We1SCmtGZ3RZQPGtds837QlPK1PYwJ0B24SGJ2wVC0yh7Jj39do0wl8Ig8oEuJ6lff
	 N3DnOfcTtoIMpjlgc5qcZTxm5xTYLOWF+Fh9g4tP+qnIJx8yzXRe6H3JFpu3y4ZPl5
	 xZHqUAOvwrwZw==
Message-ID: <4dd9d86f-7c20-40fa-838c-b7634bbebf9a@kernel.org>
Date: Wed, 29 Oct 2025 10:22:18 -0500
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
Cc: Askar Safin <safinaskar@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <5935682.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5935682.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 3:52 PM, Rafael J. Wysocki wrote:
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

Great idea.  Looks good to me, and it passes the S4 tests on my side.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
> 
> This supersedes
> 
> https://lore.kernel.org/linux-pm/20251026033115.436448-1-superm1@kernel.org/
> 
> as it allows the GFP mask to be restricted across the entire hibernation path.
> 
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


