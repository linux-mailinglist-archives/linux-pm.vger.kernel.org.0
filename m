Return-Path: <linux-pm+bounces-25203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042D1A8541A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 08:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C431B65749
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 06:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075427CCC1;
	Fri, 11 Apr 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgG7ZsUm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC001EFF9C
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352833; cv=none; b=gvcBVvJALZqmM2ga+bNeVMUXMLoM3j5dMRoq82OGZaoahTgcnm+ScEzGMHueKgaDVmLa0Q899OyOULmhKDp8NHx7rKSNF65R85/yJe+qAV6/ZISW30RMSvolBeoD9fkh1P8gcpIp6IvQdQOo9j69RUgc/NnTRDm53mCI9hs34xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352833; c=relaxed/simple;
	bh=X5SsDwOyJARDWWPRwlbfQh8yw57GUkWUppsuw16nfWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEE8tnu3AX9SH7UrJjMTP7SdpTHe1JpU3wWBqUvpN6goCUkIuGB+AifoLDrEH3eCnynR5GyytPqKDJI3nh9F5Tgz7kBiv0Co3XCZmGm59lBDzESs5k1EvARTIExC5up4HEXMYRRPe/Op3raP5p8kiBZLzEWhMleb5oLGCADAqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgG7ZsUm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744352833; x=1775888833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X5SsDwOyJARDWWPRwlbfQh8yw57GUkWUppsuw16nfWM=;
  b=CgG7ZsUmdLEYjjYRJBSRReM6Jk92gMsC/WoNKT26BpN6Y9HT46H8G9c6
   s2oldEmiog1zDbGFMIJuucOk1A+wONVvVf9bM391Jre8gxtZ1hP8w2er3
   QQuJS06XEK5Ym2l7jv8Ikna/b6ovQui1SGSXKWDFkudo0uW3/wJkcQis7
   acybLVfLHAIcIVfAD7FoAeSh19TV9wY9CF8ijhQCe3waqQRqkJ0Bf4xwX
   213zBCGrUl9GXkKzqYp5aiQsQfR0b/2Ud6NRfJasVUqpnpI5hsbvs6T8R
   oDBlHy8yJ+W8Si/N6xryv3xNypMS2TQFy3PH1fpZAPnwszyon+l9U0Mqw
   w==;
X-CSE-ConnectionGUID: VUFjEhDHT6ixgrkJuerEtQ==
X-CSE-MsgGUID: Brf2VfWbQ5msgy4N6Ns+yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45797357"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45797357"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 23:27:12 -0700
X-CSE-ConnectionGUID: CSGiHYWpR2uYHUzs5kjq3Q==
X-CSE-MsgGUID: LtY+afpdRxi4Hhs07efA6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129102054"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 23:27:09 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DB3B111F7EE;
	Fri, 11 Apr 2025 09:27:06 +0300 (EEST)
Date: Fri, 11 Apr 2025 06:27:06 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 3/7] pm: runtime: Mark last busy stamp in
 pm_runtime_put_autosuspend()
Message-ID: <Z_i2Og7PT8O6P-Y0@kekkonen.localdomain>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-4-sakari.ailus@linux.intel.com>
 <20250410201711.GB29836@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410201711.GB29836@pendragon.ideasonboard.com>

Hi Laurent,

Thanks for the review.

On Thu, Apr 10, 2025 at 11:17:11PM +0300, Laurent Pinchart wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Thu, Apr 10, 2025 at 06:31:02PM +0300, Sakari Ailus wrote:
> > Set device's last busy timestamp to current time in
> > pm_runtime_put_autosuspend(). Callers wishing not to do that will need to
> > use __pm_runtime_put_autosuspend().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  Documentation/power/runtime_pm.rst | 23 ++++++++++-------------
> >  include/linux/pm_runtime.h         | 12 +++++++-----
> >  2 files changed, 17 insertions(+), 18 deletions(-)
> > 
> > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > index 63344bea8393..e7bbdc66d64c 100644
> > --- a/Documentation/power/runtime_pm.rst
> > +++ b/Documentation/power/runtime_pm.rst
> > @@ -411,8 +411,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
> >        pm_request_idle(dev) and return its result
> >  
> >    `int pm_runtime_put_autosuspend(struct device *dev);`
> > -    - does the same as __pm_runtime_put_autosuspend() for now, but in the
> > -      future, will also call pm_runtime_mark_last_busy() as well, DO NOT USE!
> > +    - set the power.last_busy field to the current time and decrement the
> > +      device's usage counter; if the result is 0 then run
> > +      pm_request_autosuspend(dev) and return its result
> >  
> >    `int __pm_runtime_put_autosuspend(struct device *dev);`
> >      - decrement the device's usage counter; if the result is 0 then run
> > @@ -870,11 +871,9 @@ device is automatically suspended (the subsystem or driver still has to call
> >  the appropriate PM routines); rather it means that runtime suspends will
> >  automatically be delayed until the desired period of inactivity has elapsed.
> >  
> > -Inactivity is determined based on the power.last_busy field.  Drivers should
> > -call pm_runtime_mark_last_busy() to update this field after carrying out I/O,
> > -typically just before calling __pm_runtime_put_autosuspend().  The desired
> > -length of the inactivity period is a matter of policy.  Subsystems can set this
> > -length initially by calling pm_runtime_set_autosuspend_delay(), but after device
> > +Inactivity is determined based on the power.last_busy field. The desired length
> > +of the inactivity period is a matter of policy.  Subsystems can set this length
> > +initially by calling pm_runtime_set_autosuspend_delay(), but after device
> >  registration the length should be controlled by user space, using the
> >  /sys/devices/.../power/autosuspend_delay_ms attribute.
> >  
> > @@ -885,7 +884,7 @@ instead of the non-autosuspend counterparts::
> >  
> >  	Instead of: pm_runtime_suspend    use: pm_runtime_autosuspend;
> >  	Instead of: pm_schedule_suspend   use: pm_request_autosuspend;
> > -	Instead of: pm_runtime_put        use: __pm_runtime_put_autosuspend;
> > +	Instead of: pm_runtime_put        use: pm_runtime_put_autosuspend;
> >  	Instead of: pm_runtime_put_sync   use: pm_runtime_put_sync_autosuspend.
> >  
> >  Drivers may also continue to use the non-autosuspend helper functions; they
> > @@ -922,12 +921,10 @@ Here is a schematic pseudo-code example::
> >  	foo_io_completion(struct foo_priv *foo, void *req)
> >  	{
> >  		lock(&foo->private_lock);
> > -		if (--foo->num_pending_requests == 0) {
> > -			pm_runtime_mark_last_busy(&foo->dev);
> > -			__pm_runtime_put_autosuspend(&foo->dev);
> > -		} else {
> > +		if (--foo->num_pending_requests == 0)
> > +			pm_runtime_put_autosuspend(&foo->dev);
> > +		else
> >  			foo_process_next_request(foo);
> > -		}
> >  		unlock(&foo->private_lock);
> >  		/* Send req result back to the user ... */
> >  	}
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 3e31cbebc527..0ade3f75d903 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -562,11 +562,13 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
> >  }
> >  
> >  /**
> > - * pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
> > + * pm_runtime_put_autosuspend - Update the last access time of a device, drop
> > + * its usage counter and queue autosuspend if the usage counter becomes 0.
> >   * @dev: Target device.
> >   *
> > - * Decrement the runtime PM usage counter of @dev and if it turns out to be
> > - * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
> > + * Update the last access time of @dev and decrement its runtime PM usage
> 
> s/ and decrement/, decrement/

Ack. I'll address this in v2, but wait for other comments still awhile.

> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > + * counter and if it turns out to be equal to 0, queue up a work item for @dev
> > + * like in pm_request_autosuspend().
> >   *
> >   * Return:
> >   * * 0: Success.
> > @@ -581,8 +583,8 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
> >   */
> >  static inline int pm_runtime_put_autosuspend(struct device *dev)
> >  {
> > -	return __pm_runtime_suspend(dev,
> > -	    RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
> > +	pm_runtime_mark_last_busy(dev);
> > +	return __pm_runtime_put_autosuspend(dev);
> >  }
> >  
> >  /**

-- 
Kind regards,

Sakari Ailus

