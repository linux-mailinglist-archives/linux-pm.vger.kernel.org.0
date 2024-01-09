Return-Path: <linux-pm+bounces-2006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F626828A28
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FE62861E1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23F39AFA;
	Tue,  9 Jan 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UlDgN3dg"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586E3A8E4
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3BC02475;
	Tue,  9 Jan 2024 17:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704818374;
	bh=4/kUOxDd7PkJFu1C5LOw2ZOBFqybUHLiV1hKOSU8ARk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlDgN3dgVvLTMeMsxYFUtM8lSjOMDJxiDycMlOvXJKl6NgdYSxMfQNQkZ0V+QOL7C
	 QqW9phjb8Fj7zNSXJNz4M7z10mK9+AKwkNNvixeHa1GlRfqLBG3Oye/ZiMtdlVOC3o
	 5Y46IZuP3jIDR6ciN3t1BEI5bYgSGTmD57Z3xSsU=
Date: Tue, 9 Jan 2024 18:40:47 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] pm: runtime: Add pm_runtime_put_autosuspend()
 replacement
Message-ID: <20240109164047.GB27655@pendragon.ideasonboard.com>
References: <20240109133639.111210-1-sakari.ailus@linux.intel.com>
 <20240109133639.111210-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109133639.111210-2-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Tue, Jan 09, 2024 at 03:36:39PM +0200, Sakari Ailus wrote:
> Add __pm_runtime_put_autosuspend() that replaces
> pm_runtime_put_autosuspend() for new users. The intent is to later
> re-purpose pm_runtime_put_autosuspend() to also mark the device's last
> busy stamp---which is what the vast majority of users actually need.
> 
> This is also described in pm_runtime_put_autosuspend() documentation.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

This looks good to me, so

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Do you plan to patch the existing users tree-wide ?

> ---
>  Documentation/power/runtime_pm.rst | 17 +++++++++++------
>  include/linux/pm_runtime.h         | 12 ++++++++++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index da99379071a4..6fa50e4f87ce 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -154,7 +154,7 @@ suspending the device are satisfied) and to queue up a suspend request for the
>  device in that case.  If there is no idle callback, or if the callback returns
>  0, then the PM core will attempt to carry out a runtime suspend of the device,
>  also respecting devices configured for autosuspend.  In essence this means a
> -call to pm_runtime_autosuspend() (do note that drivers needs to update the
> +call to __pm_runtime_autosuspend() (do note that drivers needs to update the
>  device last busy mark, pm_runtime_mark_last_busy(), to control the delay under
>  this circumstance).  To prevent this (for example, if the callback routine has
>  started a delayed suspend), the routine must return a non-zero value.  Negative
> @@ -409,6 +409,10 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        pm_request_idle(dev) and return its result
>  
>    `int pm_runtime_put_autosuspend(struct device *dev);`
> +    - does the same as __pm_runtime_put_autosuspend() for now, but in the
> +      future, will also call pm_runtime_mark_last_busy() as well, DO NOT USE!
> +
> +  `int __pm_runtime_put_autosuspend(struct device *dev);`
>      - decrement the device's usage counter; if the result is 0 then run
>        pm_request_autosuspend(dev) and return its result
>  
> @@ -539,6 +543,7 @@ It is safe to execute the following helper functions from interrupt context:
>  - pm_runtime_put_noidle()
>  - pm_runtime_put()
>  - pm_runtime_put_autosuspend()
> +- __pm_runtime_put_autosuspend()
>  - pm_runtime_enable()
>  - pm_suspend_ignore_children()
>  - pm_runtime_set_active()
> @@ -864,9 +869,9 @@ automatically be delayed until the desired period of inactivity has elapsed.
>  
>  Inactivity is determined based on the power.last_busy field.  Drivers should
>  call pm_runtime_mark_last_busy() to update this field after carrying out I/O,
> -typically just before calling pm_runtime_put_autosuspend().  The desired length
> -of the inactivity period is a matter of policy.  Subsystems can set this length
> -initially by calling pm_runtime_set_autosuspend_delay(), but after device
> +typically just before calling __pm_runtime_put_autosuspend().  The desired
> +length of the inactivity period is a matter of policy.  Subsystems can set this
> +length initially by calling pm_runtime_set_autosuspend_delay(), but after device
>  registration the length should be controlled by user space, using the
>  /sys/devices/.../power/autosuspend_delay_ms attribute.
>  
> @@ -877,7 +882,7 @@ instead of the non-autosuspend counterparts::
>  
>  	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
>  	Instead of: pm_schedule_suspend   use: pm_request_autosuspend;
> -	Instead of: pm_runtime_put        use: pm_runtime_put_autosuspend;
> +	Instead of: pm_runtime_put        use: __pm_runtime_put_autosuspend;
>  	Instead of: pm_runtime_put_sync   use: pm_runtime_put_sync_autosuspend.
>  
>  Drivers may also continue to use the non-autosuspend helper functions; they
> @@ -916,7 +921,7 @@ Here is a schematic pseudo-code example::
>  		lock(&foo->private_lock);
>  		if (--foo->num_pending_requests == 0) {
>  			pm_runtime_mark_last_busy(&foo->dev);
> -			pm_runtime_put_autosuspend(&foo->dev);
> +			__pm_runtime_put_autosuspend(&foo->dev);
>  		} else {
>  			foo_process_next_request(foo);
>  		}
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 13cd526634c1..d28df13ffe4d 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -482,6 +482,18 @@ static inline int pm_runtime_put(struct device *dev)
>  	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>  
> +/**
> + * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
> + * @dev: Target device.
> + *
> + * Decrement the runtime PM usage counter of @dev and if it turns out to be
> + * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
> + */
> +static inline int __pm_runtime_put_autosuspend(struct device *dev)
> +{
> +	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
> +}
> +
>  /**
>   * pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
>   * @dev: Target device.

-- 
Regards,

Laurent Pinchart

