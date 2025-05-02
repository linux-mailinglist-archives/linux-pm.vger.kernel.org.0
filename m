Return-Path: <linux-pm+bounces-26583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D77AA7766
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 18:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592C97B12C2
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A32B25D90D;
	Fri,  2 May 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ82AaDm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C8922E3FD
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203845; cv=none; b=ShR7hrWyhcabiLZyr3tDQzgIaWIn8dPLgnJAfHaUj0+52aoTK/XJlmCK2C9Vjcj4HpmZtBD3eX3GZMNmEJ7cJ7mLgOK7F1e3OQhGptn4tk4OGboBCoGqdYftgaLmD+Gxi2hIC/FTqxEQJCUaoCY0047bJE0gzVfVaepLzfvux9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203845; c=relaxed/simple;
	bh=zkjGpsaRxlCJjZrZYRcHo/RpmmsbcMbgHrhUqEoVd08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRAc1WNXU6weuW+yEbVj5levLEa0nc2se5JNZFzmXh97YmfrjqIL8M+CsiTv5LjW6xCougOWcgQguusll0GndKFvQVScI56P+FcnpncmqCrnSoI7Wl0EDqd9wHOcPQmKkAUr47r/Zl65t6GkgjtI51vzgeYBvaoF9hZN0v7fp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ82AaDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDE5C4CEE4;
	Fri,  2 May 2025 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746203844;
	bh=zkjGpsaRxlCJjZrZYRcHo/RpmmsbcMbgHrhUqEoVd08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lZ82AaDmaI2Ox8Aa2T+rewKITIjyKAwlfozcZOgkxnGnVyGdbyehK0k3S0z7PF8OW
	 fNfx4eudrdsA6kNl+sx+DEZw4dNBOwOSTCM0oaC4W7z1wHRrMSwB/1Gdzf+zqLdaVJ
	 AQ0hwb4xb+NPUQT8yBvNyYOTfSUd72W/ZTLj2eYrOwgmadz9nSnTFTkOYun3/yJXzx
	 lBhOq4wuY23uA7oe4xGcIeppvbhgYAVJFUAGGjq5j16GY3gDm7IURjlsfZTK/9/+1L
	 K0d8jJvn/kxvGIlVQGIQQu/rBUyFX1UbTMP6dz3S1UdwR3Y36F48U2yMZbM/T14zGg
	 EJLqiirpt6oHA==
Message-ID: <ed250538-0e6c-400d-af03-b9b0d32b3133@kernel.org>
Date: Fri, 2 May 2025 11:37:23 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] PM: Add suspend and hibernate notifications for after
 freeze
To: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>
References: <20250501211734.2434369-1-superm1@kernel.org>
 <20250501211734.2434369-2-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250501211734.2434369-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/2025 4:17 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Suspend and hibernate notifications are available specifically when
> the sequence starts and finishes.  However there are no notifications
> during the process when tasks have been frozen.
> 
> Introduce two new events `PM_SUSPEND_POST_FREEZE` and
> `PM_HIBERNATE_POST_FREEZE` that drivers can subscribe to and take
> different actions specifically knowing userspace is frozen.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   Documentation/driver-api/pm/notifiers.rst | 19 ++++++++++++++++---
>   include/linux/suspend.h                   | 14 ++++++++------
>   kernel/power/hibernate.c                  |  9 +++++++--
>   kernel/power/suspend.c                    | 13 +++++++++----
>   4 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/driver-api/pm/notifiers.rst b/Documentation/driver-api/pm/notifiers.rst
> index 186435c43b77e..6a1912fbee214 100644
> --- a/Documentation/driver-api/pm/notifiers.rst
> +++ b/Documentation/driver-api/pm/notifiers.rst
> @@ -32,6 +32,18 @@ will be called upon the following events by the PM core:
>   	additional work is done between the notifiers and the invocation of PM
>   	callbacks for the "freeze" transition.
>   
> +``PM_HIBERNATION_POST_FREEZE``
> +	The system is going to hibernate and tasks have just been frozen.
> +
> +``PM_SUSPEND_PREPARE``
> +	The system is going to suspend, tasks will be frozen immediately.  This
> +	is different from ``PM_HIBERNATION_PREPARE`` above, because in this case
> +	additional work is done between the notifiers and the invocation of PM
> +	callbacks for the "freeze" transition.

I accidentally created this section ``PM_SUSPEND_PREPARE`` (there 
already is one for PM_SUSPEND_PREPARE that is totally fine).

If conceptually the rest of the patch makes sense I will drop this section.

> +
> +``PM_SUSPEND_POST_FREEZE``
> +	The system is going to suspend and tasks have just been frozen.

Looking again, I think this is better put between (the correct) 
PM_SUSPEND_PREPARE and PM_POST_SUSPEND.

If conceptually the rest of the patch makes sense I will move it to that 
section.

> +
>   ``PM_POST_HIBERNATION``
>   	The system memory state has been restored from a hibernation image or an
>   	error occurred during hibernation.  Device restore callbacks have been
> @@ -54,9 +66,10 @@ will be called upon the following events by the PM core:
>   	resume callbacks have been executed and tasks have been thawed.
>   
>   It is generally assumed that whatever the notifiers do for
> -``PM_HIBERNATION_PREPARE``, should be undone for ``PM_POST_HIBERNATION``.
> -Analogously, operations carried out for ``PM_SUSPEND_PREPARE`` should be
> -reversed for ``PM_POST_SUSPEND``.
> +``PM_HIBERNATION_PREPARE`` and ``PM_HIBERNATION_POST_FREEZE``, should be undone
> +for ``PM_POST_HIBERNATION``.
> +Analogously, operations carried out for ``PM_SUSPEND_PREPARE`` and ``PM_SUSPEND_POST_FREEZE``
> +should be reversed for ``PM_POST_SUSPEND``.
>   
>   Moreover, if one of the notifiers fails for the ``PM_HIBERNATION_PREPARE`` or
>   ``PM_SUSPEND_PREPARE`` event, the notifiers that have already succeeded for that
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index da6ebca3ff774..704e6579b0df6 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -422,12 +422,14 @@ static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
>   #endif
>   
>   /* Hibernation and suspend events */
> -#define PM_HIBERNATION_PREPARE	0x0001 /* Going to hibernate */
> -#define PM_POST_HIBERNATION	0x0002 /* Hibernation finished */
> -#define PM_SUSPEND_PREPARE	0x0003 /* Going to suspend the system */
> -#define PM_POST_SUSPEND		0x0004 /* Suspend finished */
> -#define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
> -#define PM_POST_RESTORE		0x0006 /* Restore failed */
> +#define PM_HIBERNATION_PREPARE		0x0001 /* Going to hibernate */
> +#define PM_HIBERNATION_POST_FREEZE	0x0002 /* Prepared for hibernation and tasks have been frozen */
> +#define PM_POST_HIBERNATION		0x0003 /* Hibernation finished */
> +#define PM_SUSPEND_PREPARE		0x0004 /* Going to suspend the system */
> +#define PM_SUSPEND_POST_FREEZE		0x0005 /* Prepared and tasks have been frozen */
> +#define PM_POST_SUSPEND			0x0006 /* Suspend finished */
> +#define PM_RESTORE_PREPARE		0x0007 /* Going to restore a saved image */
> +#define PM_POST_RESTORE			0x0008 /* Restore failed */
>   
>   extern struct mutex system_transition_mutex;
>   
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index f0db9d1896e80..f896056ad2e5d 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -783,11 +783,15 @@ int hibernate(void)
>   	if (error)
>   		goto Exit;
>   
> +	error = pm_notifier_call_chain_robust(PM_HIBERNATION_POST_FREEZE, PM_POST_HIBERNATION);
> +	if (error)
> +		goto Thaw;
> +
>   	lock_device_hotplug();
>   	/* Allocate memory management structures */
>   	error = create_basic_memory_bitmaps();
>   	if (error)
> -		goto Thaw;
> +		goto Unlock_hotplug;
>   
>   	error = hibernation_snapshot(hibernation_mode == HIBERNATION_PLATFORM);
>   	if (error || freezer_test_done)
> @@ -833,8 +837,9 @@ int hibernate(void)
>   
>    Free_bitmaps:
>   	free_basic_memory_bitmaps();
> - Thaw:
> + Unlock_hotplug:
>   	unlock_device_hotplug();
> + Thaw:
>   	if (snapshot_test) {
>   		pm_pr_dbg("Checking hibernation image\n");
>   		error = swsusp_check(false);
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 8eaec4ab121d4..bc6654e8cdc80 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -377,13 +377,18 @@ static int suspend_prepare(suspend_state_t state)
>   	trace_suspend_resume(TPS("freeze_processes"), 0, true);
>   	error = suspend_freeze_processes();
>   	trace_suspend_resume(TPS("freeze_processes"), 0, false);
> -	if (!error)
> -		return 0;
> +	if (error)
> +		goto Restore;
> +	error = pm_notifier_call_chain_robust(PM_SUSPEND_POST_FREEZE, PM_POST_SUSPEND);
> +	if (error)
> +		goto Thaw;
>   
> -	dpm_save_failed_step(SUSPEND_FREEZE);
> -	pm_notifier_call_chain(PM_POST_SUSPEND);
> +	return 0;
> + Thaw:
> +	suspend_thaw_processes();
>    Restore:
>   	pm_restore_console();
> +	dpm_save_failed_step(SUSPEND_FREEZE);
>   	return error;
>   }
>   


