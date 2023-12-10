Return-Path: <linux-pm+bounces-868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F76080BA2E
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 11:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9F41F20FB9
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7279C6;
	Sun, 10 Dec 2023 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mPZ/FFga"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01154749D
	for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2023 10:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD13BC433C7;
	Sun, 10 Dec 2023 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702204505;
	bh=kWjoRMAFe6f0i1po6kYqlLe9wp8VQklHs8gl4ogzYKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPZ/FFgahWdiTEo5htUEqFWGr1LrNeTLuV6uXOZ4g3wMBbekBwxI4pXlAROerwmum
	 DXYlBNgFKTqLIaekdF7ktBlBMCrOBtPFOlSV5Nilf56Ce4ahgC70CtmF1WhHe0uRHs
	 4RP9/ihAuxXIsXMJMGYx6MhvO6VPBpLrIZnJvGEE=
Date: Sun, 10 Dec 2023 11:35:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vimal Kumar <vimal.kumar32@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
	mintupatel89@gmail.com
Subject: Re: [PATCH v2] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2023121037-unroasted-gradation-a47f@gregkh>
References: <20231210100303.491-1-vimal.kumar32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210100303.491-1-vimal.kumar32@gmail.com>

On Sun, Dec 10, 2023 at 03:33:01PM +0530, Vimal Kumar wrote:
> +#define MAX_SUSPEND_ABORT_LEN 256

What does this number mean?

> +static DEFINE_RAW_SPINLOCK(abort_suspend_lock);

Why is this a "raw" spinlock?  What requires this?

> +
> +struct pm_abort_suspend_source {
> +	struct list_head list;
> +	char *source_triggering_abort_suspend;
> +};
> +static LIST_HEAD(pm_abort_suspend_list);
> +
>  /**
>   * wakeup_source_create - Create a struct wakeup_source object.
>   * @name: Name of the new wakeup source.
> @@ -575,6 +584,56 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>  	trace_wakeup_source_activate(ws->name, cec);
>  }
>  
> +/**
> + * abort_suspend_list_clear - Clear pm_abort_suspend_list.
> + *
> + * The pm_abort_suspend_list will be cleared when system PM exits.
> + */
> +void abort_suspend_list_clear(void)
> +{
> +	struct pm_abort_suspend_source *info, *tmp;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> +	list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
> +		list_del(&info->list);
> +		kfree(info);
> +	}
> +	raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(abort_suspend_list_clear);
> +
> +/**
> + * pm_abort_suspend_source_add - Update pm_abort_suspend_list
> + * @source_name: Wakeup_source or function aborting suspend transitions.
> + *
> + * Add the source name responsible for updating the abort_suspend flag in the
> + * pm_abort_suspend_list.
> + */
> +static void pm_abort_suspend_source_add(const char *source_name)
> +{
> +	struct pm_abort_suspend_source *info;
> +	unsigned long flags;
> +
> +	info = kmalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return;
> +
> +	/* Initialize the list within the struct if it's not already initialized */
> +	if (list_empty(&info->list))
> +		INIT_LIST_HEAD(&info->list);

How can this list head not be initialized already?

> +
> +	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
> +	if (!info->source_triggering_abort_suspend) {
> +		kfree(info);
> +		return;
> +	}
> +
> +	raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> +	list_add_tail(&info->list, &pm_abort_suspend_list);
> +	raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> +}
> +
>  /**
>   * wakeup_source_report_event - Report wakeup event using the given source.
>   * @ws: Wakeup source to report the event for.
> @@ -590,8 +649,11 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
>  	if (!ws->active)
>  		wakeup_source_activate(ws);
>  
> -	if (hard)
> +	if (hard) {
> +		if (pm_suspend_target_state != PM_SUSPEND_ON)
> +			pm_abort_suspend_source_add(ws->name);
>  		pm_system_wakeup();
> +	}
>  }
>  
>  /**
> @@ -877,6 +939,7 @@ bool pm_wakeup_pending(void)
>  {
>  	unsigned long flags;
>  	bool ret = false;
> +	struct pm_abort_suspend_source *info;
>  
>  	raw_spin_lock_irqsave(&events_lock, flags);
>  	if (events_check_enabled) {
> @@ -893,12 +956,29 @@ bool pm_wakeup_pending(void)
>  		pm_print_active_wakeup_sources();
>  	}
>  
> +	if (atomic_read(&pm_abort_suspend) > 0) {
> +		raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> +		list_for_each_entry(info, &pm_abort_suspend_list, list) {
> +			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
> +					info->source_triggering_abort_suspend);
> +		}
> +		raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> +	}

After you print them all out, why not remove them from the list now?
Why wait until later?

> +
>  	return ret || atomic_read(&pm_abort_suspend) > 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_wakeup_pending);
>  
>  void pm_system_wakeup(void)
>  {
> +	char buf[MAX_SUSPEND_ABORT_LEN];

You never actually check to ensure that you do not overflow this value,
right?  And are you _SURE_ you can put a string this big on the stack?

> +
> +	if (pm_suspend_target_state != PM_SUSPEND_ON) {
> +		sprintf(buf, "%ps", __builtin_return_address(0));
> +		if (strcmp(buf, "pm_wakeup_ws_event"))

This is _VERY_ fragile, you are relying on a specific symbol to never
change its name, which is not going to work in the long run, AND this
will not work if you don't have symbols in your kernel, right?

How was this tested?

And again, why is this even needed, who will use it?  What tools will
consume it?  Who will rely on it?

thanks,

greg k-h

