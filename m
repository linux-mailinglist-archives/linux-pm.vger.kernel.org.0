Return-Path: <linux-pm+bounces-30852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4567CB0534C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 09:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA57B8070
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507892D374E;
	Tue, 15 Jul 2025 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDnJdyaJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0907255F24;
	Tue, 15 Jul 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564309; cv=none; b=uKFa07gL6yB7ODI6H9/c2K92UsETUTkcURHBjUFlTZfgysd6nqgD+rZJCO5EOlaxli/TQ7XDbeiEsIYznmlUJb2Jm1FwstArnPIuToyzIMhCmVQduz6vQ4WXedwUx4eo8YUUamh8IL5bRDqXHx8gMcODzcVf7ZGM/YYS/96vcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564309; c=relaxed/simple;
	bh=0jd9eLlEvl1cQ0K4ZeoMz0DXZf79bNYhoTlkg4/GlRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyne1/oUGefnMCCATaCEHK94zi9WsmFBRMq62DXzvaSXGsgnQT1gWU+ZX6i6WomMiV8z6wnNMaUPvExKw2PX3bSMpuqbWMg8eEbxBZhL74AGYFCl79qWqC/lD8RCjUTe3qOcN/jz/Yr/tDRiG3XN3n8YoC+71NfrsfUcITJJW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDnJdyaJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752564308; x=1784100308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0jd9eLlEvl1cQ0K4ZeoMz0DXZf79bNYhoTlkg4/GlRU=;
  b=jDnJdyaJId9H5/np0MDX2XHm5DxOnCdUGETqTR22/l/LOhAs/fiIdLPg
   Vw/4FMANDa/5NhTJBN8T3kD9LnGvedqEFUf5mm9nYstCpxxU3W7VsN4UW
   M5I1A/gadve4YBzecTypzExgS8P0tXucJxZQI1EKAq2vD4vNRu5RHL3fA
   tiKo7DZGyR6yUqlJOsd+v2uZo8E8m9ARzXETBEU0A8FIEB+KxRcnWYF3H
   syKds758FIqo89JvrQL5UV3vWywdoSdAxq7FZ+K24jwSPK91PWdA6g8j6
   b3aHZNKB4h45+4nLZtGjXY0kdyp32QTmgWKVBbJFzhFizFW4FYhFlyaMl
   g==;
X-CSE-ConnectionGUID: hhSWtoEzTG26sTq8lHb/wQ==
X-CSE-MsgGUID: auwkCQLsROeD4iJbTLbyoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54897867"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54897867"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:24:59 -0700
X-CSE-ConnectionGUID: XkoSoFCmSnOhxUJ5OesC5A==
X-CSE-MsgGUID: nFLe8oZ9RDeDaIv3TTKEVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="161693672"
Received: from ettammin-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.145])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:24:57 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A10DC11F87A;
	Tue, 15 Jul 2025 10:24:54 +0300 (EEST)
Date: Tue, 15 Jul 2025 07:24:54 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Alex Elder <elder@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] PM: runtime: Take active children into account in
 pm_runtime_get_if_in_use()
Message-ID: <aHYCRvz0ohgi2xUk@kekkonen.localdomain>
References: <12700973.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12700973.O9o76ZdvQC@rjwysocki.net>

Hi Rafael,

Thanks for the patch.

On Wed, Jul 09, 2025 at 12:41:45PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> For all practical purposes, there is no difference between the situation
> in which a given device is not ignoring children and its active child
> count is nonzero and the situation in which its runtime PM usage counter
> is nonzero.  However, pm_runtime_get_if_in_use() will only increment the
> device's usage counter and return 1 in the latter case.
> 
> For consistency, make it do so in the former case either by adjusting
> pm_runtime_get_conditional() and update the related kerneldoc comments
> accordingly.
> 
> Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")

I guess this should be:

Fixes: c111566bea7c ("PM: runtime: Add pm_runtime_get_if_active()")

Should this also be cc'd to stable?

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1203,10 +1203,12 @@
>   *
>   * Return -EINVAL if runtime PM is disabled for @dev.
>   *
> - * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and either
> - * @ign_usage_count is %true or the runtime PM usage counter of @dev is not
> - * zero, increment the usage counter of @dev and return 1. Otherwise, return 0
> - * without changing the usage counter.
> + * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage_count
> + * is set, or (2) @dev is not ignoring children and its active child count is
> + * nonero, or (3) the runtime PM usage counter of @dev is not zero, increment
> + * the usage counter of @dev and return 1.
> + *
> + * Otherwise, return 0 without changing the usage counter.
>   *
>   * If @ign_usage_count is %true, this function can be used to prevent suspending
>   * the device when its runtime PM status is %RPM_ACTIVE.
> @@ -1228,7 +1230,8 @@
>  		retval = -EINVAL;
>  	} else if (dev->power.runtime_status != RPM_ACTIVE) {
>  		retval = 0;
> -	} else if (ign_usage_count) {
> +	} else if (ign_usage_count || (!dev->power.ignore_children &&
> +		   atomic_read(&dev->power.child_count) > 0)) {
>  		retval = 1;
>  		atomic_inc(&dev->power.usage_count);
>  	} else {
> @@ -1261,10 +1264,16 @@
>   * @dev: Target device.
>   *
>   * Increment the runtime PM usage counter of @dev if its runtime PM status is
> - * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
> - * it returns 1. If the device is in a different state or its usage_count is 0,
> - * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device,
> - * in which case also the usage_count will remain unmodified.
> + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or it is not
> + * ignoring children and its active child count is nonzero.  1 is returned in
> + * this case.
> + *
> + * If @dev is in a different state or it is not in use (that is, its usage
> + * counter is 0, or it is ignoring children, or its active child count is 0),
> + * 0 is returned.
> + *
> + * -EINVAL is returned if runtime PM is disabled for the device, in which case
> + * also the usage counter of @dev is not updated.
>   */
>  int pm_runtime_get_if_in_use(struct device *dev)
>  {
> 
> 

-- 
Kind regards,

Sakari Ailus

