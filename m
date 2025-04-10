Return-Path: <linux-pm+bounces-25181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3909A84E2B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006753BC50B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9C2046B9;
	Thu, 10 Apr 2025 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="X0mgNF/5"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBD149C64
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316899; cv=none; b=SDqgTHHcJCJ4ACI2Li2Kp7EFxAzOdxttPvP2Nb+30dIV+nHcRpawtAMzH7WplcqmlHXv6D0SYihm5rl8wqBOkVOtfJa83p+RcWlq3SmQdi9Xxs+zLbM8Fs3XPAm1UYR0fk2RzyPfYBZLKPnKYaAdpw+/YKbQMZLSIicbRw0K7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316899; c=relaxed/simple;
	bh=U4hw15sxHLRxcLpcuTcRGhnHpI6Zmxb1vxeLeQHVzOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU7F75UCFWL6D1WjUfTxh7bZ5+d9vSG3Zl00wTmUMsMF6uEbQ1wbbg5ry4ZJIZjn+4uxCgSHEE0xvP/wCsSK4tihWeogMkfxlnNx09uaCougwEvFRfBD3hCdqYjwWF0dUV/aQM+xL9D5NrVda58f1l3uOngNyyPB0X64IqM6Hn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=X0mgNF/5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1FD07352;
	Thu, 10 Apr 2025 22:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1744316777;
	bh=U4hw15sxHLRxcLpcuTcRGhnHpI6Zmxb1vxeLeQHVzOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0mgNF/5OofA/TCK+Fd4ZJF2tCt3VnlRebDWqDtRbKHIv8+x0JrGu/tEMbdrAe0D3
	 VKeMkHPSj9RLb3SQ9QeN+vGsmuWjzgbfUMkYGsRMJoa709iVNjMGOptXy3DHPui0lE
	 gWFYeh09r+JNuaSm433DJ0fTBA9/nyGdjS1Vh+EA=
Date: Thu, 10 Apr 2025 23:27:49 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 5/7] pm: runtime: Mark last busy stamp in
 pm_runtime_autosuspend()
Message-ID: <20250410202749.GD29836@pendragon.ideasonboard.com>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-6-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410153106.4146265-6-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Apr 10, 2025 at 06:31:04PM +0300, Sakari Ailus wrote:
> Set device's last busy timestamp to current time in
> pm_runtime_autosuspend().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/power/runtime_pm.rst | 15 ++++++---------
>  include/linux/pm_runtime.h         |  9 ++++++---
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 9c21c913f9cf..39a0b62f6648 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -154,11 +154,9 @@ suspending the device are satisfied) and to queue up a suspend request for the
>  device in that case.  If there is no idle callback, or if the callback returns
>  0, then the PM core will attempt to carry out a runtime suspend of the device,
>  also respecting devices configured for autosuspend.  In essence this means a
> -call to pm_runtime_autosuspend() (do note that drivers needs to update the
> -device last busy mark, pm_runtime_mark_last_busy(), to control the delay under
> -this circumstance).  To prevent this (for example, if the callback routine has
> -started a delayed suspend), the routine must return a non-zero value.  Negative
> -error return codes are ignored by the PM core.
> +call to pm_runtime_autosuspend(). To prevent this (for example, if the callback
> +routine has started a delayed suspend), the routine must return a non-zero
> +value.  Negative error return codes are ignored by the PM core.
>  
>  The helper functions provided by the PM core, described in Section 4, guarantee
>  that the following constraints are met with respect to runtime PM callbacks for
> @@ -330,10 +328,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        'power.disable_depth' is different from 0
>  
>    `int pm_runtime_autosuspend(struct device *dev);`
> -    - same as pm_runtime_suspend() except that the autosuspend delay is taken
> -      `into account;` if pm_runtime_autosuspend_expiration() says the delay has
> -      not yet expired then an autosuspend is scheduled for the appropriate time
> -      and 0 is returned
> +    - same as pm_runtime_suspend() except that a call to
> +      pm_runtime_mark_last_busy() is made and an autosuspend is scheduled for
> +      the appropriate time and 0 is returned
>  
>    `int pm_runtime_resume(struct device *dev);`
>      - execute the subsystem-level resume callback for the device; returns 0 on
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index e26caf2c0552..3d12cfb0bf00 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -375,11 +375,13 @@ static inline int pm_runtime_suspend(struct device *dev)
>  }
>  
>  /**
> - * pm_runtime_autosuspend - Set up autosuspend of a device or suspend it.
> + * pm_runtime_autosuspend - Update the last access time and set up autosuspend
> + * of a device.
>   * @dev: Target device.
>   *
> - * Set up autosuspend of @dev or suspend it (depending on whether or not
> - * autosuspend is enabled for it) without engaging its "idle check" callback.
> + * First update the last access time, then set up autosuspend of @dev or suspend
> + * it (depending on whether or not autosuspend is enabled for it) without
> + * engaging its "idle check" callback.
>   *
>   * Return:
>   * * 0: Success.
> @@ -395,6 +397,7 @@ static inline int pm_runtime_suspend(struct device *dev)
>   */
>  static inline int pm_runtime_autosuspend(struct device *dev)
>  {
> +	pm_runtime_mark_last_busy(dev);
>  	return __pm_runtime_suspend(dev, RPM_AUTO);
>  }
>  

-- 
Regards,

Laurent Pinchart

