Return-Path: <linux-pm+bounces-32423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC0B27909
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 08:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9842EB61069
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 06:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36AC2BEFE6;
	Fri, 15 Aug 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6r9bund"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50382BEFE2;
	Fri, 15 Aug 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238823; cv=none; b=rdLXE6Xng8t72j8R+crOXv4qvxuh6YN+RNNefrY/w0a4UjajmUz4mIT1SCvE9pWKJlR999sq7aENyB9SIVuwVPm9UFG9xiHY7lSva0nzdo+C+pv8074mndU6ReVzEVE2vrROZmFrf5sBuGEsL4JIyCcGagGCwfxUzQ9mFdQbq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238823; c=relaxed/simple;
	bh=GHcp5dA4rULDOFBx0PEjNx1k4ReW/CdBLRFBsLgN9zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE7lOGYxs51VCVJvh2qLfeH1c91XT/6PrRREUoUYeyoe+IWWwChGnkExvyKSbixR9zvDXYvQNm5Rbt/qla5fyp7b6GRmEasHaRmu0UAEwsXc2DCSqDI1VL6bKtE/xl/DReUYFBISNidMTVUq918zW5Q0tQhJoR/S5CeiGffZ+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6r9bund; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873A4C4CEF5;
	Fri, 15 Aug 2025 06:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755238823;
	bh=GHcp5dA4rULDOFBx0PEjNx1k4ReW/CdBLRFBsLgN9zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6r9bundNNXZ0i8V0VRBCVj2L9yurJEyDhK80miA0kt9Vo2qYWCfQlRE1CEXBd4B3
	 6UvkMrOl+BXUpS/bGEBKSKaUJttGZ/SnD3M86tmF3IVTxrEaWIw5aWto5gER6eMxd3
	 +GwraUt9iHfXqaL5cdAh0WwG/1HCFmHgiTJOGFDQ=
Date: Fri, 15 Aug 2025 08:20:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: Support aborting suspend during filesystem sync
Message-ID: <2025081538-grappling-crewmate-8cf5@gregkh>
References: <20250815004635.3684650-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815004635.3684650-1-wusamuel@google.com>

On Thu, Aug 14, 2025 at 05:46:34PM -0700, Samuel Wu wrote:
> At the start of suspend, filesystems will sync to save the current state
> of the device. However, the long tail of the filesystem sync can take
> upwards of 25 seconds. If during this filesystem sync there is some
> wakeup or abort signal, it will not be processed until the sync is
> complete; from a user's perspective, this looks like the device is
> unresponsive to any form of input.
> 
> This patch adds functionality to handle a suspend abort signal when in
> the filesystem sync phase of suspend. This topic was first discussed by
> Saravana Kannan at LPC 2024 [1], where the general consensus was to
> allow filesystem sync on a parallel thread.
> 
> [1]: https://lpc.events/event/18/contributions/1845/
> 
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/base/power/wakeup.c |  8 ++++
>  include/linux/suspend.h     |  3 ++
>  kernel/power/process.c      |  1 -
>  kernel/power/suspend.c      | 85 ++++++++++++++++++++++++++++++++++++-
>  4 files changed, 95 insertions(+), 2 deletions(-)
> 
> v1 -> v2:
> - Added documentation for suspend_abort_fs_sync()
> - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration static
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..304368c3a55f 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>  
>  	/* Increment the counter of events in progress. */
>  	cec = atomic_inc_return(&combined_event_count);
> +	/*
> +	 * To maintain the same behavior as pm_wakeup_pending(),
> +	 * aborting suspend will only happen if events_check_enabled. Similarly,
> +	 * the abort during fs_sync needs the same check.
> +	 */
> +	if (events_check_enabled)
> +		suspend_abort_fs_sync();
>  
>  	trace_wakeup_source_activate(ws->name, cec);
>  }
> @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
>  void pm_system_wakeup(void)
>  {
>  	atomic_inc(&pm_abort_suspend);
> +	suspend_abort_fs_sync();
>  	s2idle_wake();
>  }
>  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 317ae31e89b3..21b1ea275c79 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -276,6 +276,8 @@ extern void arch_suspend_enable_irqs(void);
>  
>  extern int pm_suspend(suspend_state_t state);
>  extern bool sync_on_suspend_enabled;
> +
> +extern void suspend_abort_fs_sync(void);
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem	NULL
>  
> @@ -296,6 +298,7 @@ static inline bool idle_should_enter_s2idle(void) { return false; }
>  static inline void __init pm_states_init(void) {}
>  static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {}
>  static inline void s2idle_wake(void) {}
> +static inline void suspend_abort_fs_sync(void) {}
>  #endif /* !CONFIG_SUSPEND */
>  
>  static inline bool pm_suspend_in_progress(void)
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index dc0dfc349f22..8ff68ebaa1e0 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -132,7 +132,6 @@ int freeze_processes(void)
>  	if (!pm_freezing)
>  		static_branch_inc(&freezer_active);
>  
> -	pm_wakeup_clear(0);
>  	pm_freezing = true;
>  	error = try_to_freeze_tasks(true);
>  	if (!error)
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index b4ca17c2fecf..dc37ab942bcb 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -31,6 +31,7 @@
>  #include <linux/compiler.h>
>  #include <linux/moduleparam.h>
>  #include <linux/fs.h>
> +#include <linux/workqueue.h>
>  
>  #include "power.h"
>  
> @@ -74,6 +75,21 @@ bool pm_suspend_default_s2idle(void)
>  }
>  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
>  
> +static bool suspend_fs_sync_queued;
> +static DEFINE_SPINLOCK(suspend_fs_sync_lock);
> +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> +
> +/**
> + * Triggers the completion that aborts suspend. This completion will only have
> + * an effect if called during filesystems sync step of suspend.
> + */
> +void suspend_abort_fs_sync(void)

This is not kerneldoc format, I think the parser will fail on it, right?
Have you tried building the kernel documentation with this patch
applied?

> +{
> +	spin_lock(&suspend_fs_sync_lock);
> +	complete(&suspend_fs_sync_complete);
> +	spin_unlock(&suspend_fs_sync_lock);
> +}
> +
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
>  {
>  	unsigned int sleep_flags;
> @@ -403,6 +419,71 @@ void __weak arch_suspend_enable_irqs(void)
>  	local_irq_enable();
>  }
>  
> +static void sync_filesystems_fn(struct work_struct *work)
> +{
> +	ksys_sync_helper();
> +
> +	spin_lock(&suspend_fs_sync_lock);
> +	suspend_fs_sync_queued = false;
> +	complete(&suspend_fs_sync_complete);
> +	spin_unlock(&suspend_fs_sync_lock);
> +}
> +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> +
> +/**
> + * suspend_fs_sync_with_abort- Start filesystem sync and handle potential aborts
> + *
> + * Starts filesystem sync in a workqueue, while the main thread uses a
> + * completion to wait for either the filesystem sync to finish or for a wakeup
> + * event. In the case of filesystem sync finishing and triggering the
> + * completion, the suspend path continues as normal. If the complete is due to a
> + * wakeup or abort signal, the code jumps to the suspend abort path while the
> + * filesystem sync finishes in the background.
> + *
> + * An aborted suspend that is followed by another suspend is a potential
> + * scenario that complicates the sequence. This patch handles this by
> + * serializing any filesystem sync; a subsequent suspend's filesystem sync
> + * operation will only start when the previous suspend's filesystem sync has
> + * finished. Even while waiting for the previous suspend's filesystem sync to
> + * finish, the subsequent suspend will still break early if a wakeup completion
> + * is triggered, solving the original issue of filesystem sync blocking abort.
> + */

Shouldn't this documentation go up in the public one?

thanks,

greg k-h

