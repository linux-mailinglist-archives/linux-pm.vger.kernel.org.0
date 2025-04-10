Return-Path: <linux-pm+bounces-25179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E88A84E02
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1185B7A5A75
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DAE20469E;
	Thu, 10 Apr 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ucW3vm+9"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EB1EB193
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316261; cv=none; b=luNjxNoL+7Q4yJUPWUMaVA+mqXfAf2spPApzaSS9MFQB7NmB++tCitIbXIJ66tYCohTc6f32ffbl8CT+kIzIZjFAWsvKZyO8kTvWpHRYYF5vEAswFBBBqboLgmxxp65tew/w7L9nMmSlUsZiT3ff7SML80j2pxRiJ6n7y0wkauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316261; c=relaxed/simple;
	bh=0WfbnqsmB7USLOzVf6G71a2aG/gYR919U1OqNM5qBiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obxd3A2HYkfOir+vognzNRNr4wG0xkx6LGL/FkOR6uK43II/b4of2tOAm4BeG+rcCdNd7nh66A14h25mPlOziAVkkD4+6W2jgZFCdyClnnGxh2kuZQjhUB6CfsOQMNkgQSx1ZYi8BC1iMu+aSpCucs3+W1MkSS9RwKScXXgL0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ucW3vm+9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B9FC352;
	Thu, 10 Apr 2025 22:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1744316139;
	bh=0WfbnqsmB7USLOzVf6G71a2aG/gYR919U1OqNM5qBiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ucW3vm+9jCpHjT5q2+ONDfuF2n8U77e77sjrQHrDh+cJaL1EsDpWWuq3hwVbExdTG
	 SjMBoX52h/BYCi1KLJwjC+mL3ZOFZyFhXlOcrbhbLkkwga3W07TLffJDz4FHTcUEAa
	 /IWyVUF57H75JLNEoYLKq7lOHK72aaq6BdHKdpr0=
Date: Thu, 10 Apr 2025 23:17:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 3/7] pm: runtime: Mark last busy stamp in
 pm_runtime_put_autosuspend()
Message-ID: <20250410201711.GB29836@pendragon.ideasonboard.com>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410153106.4146265-4-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Apr 10, 2025 at 06:31:02PM +0300, Sakari Ailus wrote:
> Set device's last busy timestamp to current time in
> pm_runtime_put_autosuspend(). Callers wishing not to do that will need to
> use __pm_runtime_put_autosuspend().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  Documentation/power/runtime_pm.rst | 23 ++++++++++-------------
>  include/linux/pm_runtime.h         | 12 +++++++-----
>  2 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 63344bea8393..e7bbdc66d64c 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -411,8 +411,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        pm_request_idle(dev) and return its result
>  
>    `int pm_runtime_put_autosuspend(struct device *dev);`
> -    - does the same as __pm_runtime_put_autosuspend() for now, but in the
> -      future, will also call pm_runtime_mark_last_busy() as well, DO NOT USE!
> +    - set the power.last_busy field to the current time and decrement the
> +      device's usage counter; if the result is 0 then run
> +      pm_request_autosuspend(dev) and return its result
>  
>    `int __pm_runtime_put_autosuspend(struct device *dev);`
>      - decrement the device's usage counter; if the result is 0 then run
> @@ -870,11 +871,9 @@ device is automatically suspended (the subsystem or driver still has to call
>  the appropriate PM routines); rather it means that runtime suspends will
>  automatically be delayed until the desired period of inactivity has elapsed.
>  
> -Inactivity is determined based on the power.last_busy field.  Drivers should
> -call pm_runtime_mark_last_busy() to update this field after carrying out I/O,
> -typically just before calling __pm_runtime_put_autosuspend().  The desired
> -length of the inactivity period is a matter of policy.  Subsystems can set this
> -length initially by calling pm_runtime_set_autosuspend_delay(), but after device
> +Inactivity is determined based on the power.last_busy field. The desired length
> +of the inactivity period is a matter of policy.  Subsystems can set this length
> +initially by calling pm_runtime_set_autosuspend_delay(), but after device
>  registration the length should be controlled by user space, using the
>  /sys/devices/.../power/autosuspend_delay_ms attribute.
>  
> @@ -885,7 +884,7 @@ instead of the non-autosuspend counterparts::
>  
>  	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
>  	Instead of: pm_schedule_suspend   use: pm_request_autosuspend;
> -	Instead of: pm_runtime_put        use: __pm_runtime_put_autosuspend;
> +	Instead of: pm_runtime_put        use: pm_runtime_put_autosuspend;
>  	Instead of: pm_runtime_put_sync   use: pm_runtime_put_sync_autosuspend.
>  
>  Drivers may also continue to use the non-autosuspend helper functions; they
> @@ -922,12 +921,10 @@ Here is a schematic pseudo-code example::
>  	foo_io_completion(struct foo_priv *foo, void *req)
>  	{
>  		lock(&foo->private_lock);
> -		if (--foo->num_pending_requests == 0) {
> -			pm_runtime_mark_last_busy(&foo->dev);
> -			__pm_runtime_put_autosuspend(&foo->dev);
> -		} else {
> +		if (--foo->num_pending_requests == 0)
> +			pm_runtime_put_autosuspend(&foo->dev);
> +		else
>  			foo_process_next_request(foo);
> -		}
>  		unlock(&foo->private_lock);
>  		/* Send req result back to the user ... */
>  	}
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 3e31cbebc527..0ade3f75d903 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -562,11 +562,13 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
>  }
>  
>  /**
> - * pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
> + * pm_runtime_put_autosuspend - Update the last access time of a device, drop
> + * its usage counter and queue autosuspend if the usage counter becomes 0.
>   * @dev: Target device.
>   *
> - * Decrement the runtime PM usage counter of @dev and if it turns out to be
> - * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
> + * Update the last access time of @dev and decrement its runtime PM usage

s/ and decrement/, decrement/

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> + * counter and if it turns out to be equal to 0, queue up a work item for @dev
> + * like in pm_request_autosuspend().
>   *
>   * Return:
>   * * 0: Success.
> @@ -581,8 +583,8 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
>   */
>  static inline int pm_runtime_put_autosuspend(struct device *dev)
>  {
> -	return __pm_runtime_suspend(dev,
> -	    RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
> +	pm_runtime_mark_last_busy(dev);
> +	return __pm_runtime_put_autosuspend(dev);
>  }
>  
>  /**

-- 
Regards,

Laurent Pinchart

