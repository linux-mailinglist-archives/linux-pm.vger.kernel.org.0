Return-Path: <linux-pm+bounces-25182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2559A84E37
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1931B8746F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8928EA7F;
	Thu, 10 Apr 2025 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DXLoxM1W"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC781FA262
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316938; cv=none; b=XExtItmE1VWAAFVoAxiC9dsKXt9u7IaVELh/M4P1gIJYPFq+d68C6Ukq8nBjiiD438bUKBc94GWT8I2D45170CraoPEdcPTQbaUh0Ok3gkNBvPlV0RHBszubUv2nA6MnSgM0rrT4Xb/G/w3VzAtTHxFCbk+VyenqikjyGPJu4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316938; c=relaxed/simple;
	bh=ZjMsCjA5VySI182xcFC18XSiihqDCOYMehP56PKwhfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uysrQtq+FKFv4jjYNMpq+LMRdzBUxdeCDEW1U5d29Ixz5d9sQCEqoQuCvn7zhyu6fh3Ix+VqUKzn4c+KqX5qN1TChsYAzZbyXNbUp7hMZeTcA5eO93PXffX+VbffBisYBbjwVq2HokgIY+Io1GeltcVJh/K/1JEJLitNH6QUemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DXLoxM1W; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E6C1D352;
	Thu, 10 Apr 2025 22:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1744316817;
	bh=ZjMsCjA5VySI182xcFC18XSiihqDCOYMehP56PKwhfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXLoxM1WWirmIYWadV24Vb0M7n6FPBPNQVAPa1UHnIDYhuYOEWrZ8PGYTwLyKlaVY
	 brpTC9O6QyYUPelc+k4DSEU1hyljIxrk2rAANQO2Y3QowMiJLrKyLc0mEjfB5VvRdi
	 vtim6m87dl9gRJS/KT8+oL3yMbHOjbVHf/WAtlbQ=
Date: Thu, 10 Apr 2025 23:28:29 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 6/7] pm: runtime: Mark last busy stamp in
 pm_request_autosuspend()
Message-ID: <20250410202829.GE29836@pendragon.ideasonboard.com>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-7-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410153106.4146265-7-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Apr 10, 2025 at 06:31:05PM +0300, Sakari Ailus wrote:
> Set device's last busy timestamp to current time in
> pm_request_autosuspend().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/power/runtime_pm.rst | 6 +++---
>  include/linux/pm_runtime.h         | 8 +++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index 39a0b62f6648..91bc93422262 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -354,9 +354,9 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        success or error code if the request has not been queued up
>  
>    `int pm_request_autosuspend(struct device *dev);`
> -    - schedule the execution of the subsystem-level suspend callback for the
> -      device when the autosuspend delay has expired; if the delay has already
> -      expired then the work item is queued up immediately
> +    - Call pm_runtime_mark_last_busy() and schedule the execution of the
> +      subsystem-level suspend callback for the device when the autosuspend delay
> +      expires
>  
>    `int pm_schedule_suspend(struct device *dev, unsigned int delay);`
>      - schedule the execution of the subsystem-level suspend callback for the
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 3d12cfb0bf00..61ca98cd0aa2 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -444,11 +444,12 @@ static inline int pm_request_resume(struct device *dev)
>  }
>  
>  /**
> - * pm_request_autosuspend - Queue up autosuspend of a device.
> + * pm_request_autosuspend - Update the last access time and queue up autosuspend
> + * of a device.
>   * @dev: Target device.
>   *
> - * Queue up a work item to run an equivalent pm_runtime_autosuspend() for @dev
> - * asynchronously.
> + * Update the last access time of a device and queue up a work item to run an
> + * equivalent pm_runtime_autosuspend() for @dev asynchronously.
>   *
>   * Return:
>   * * 0: Success.
> @@ -463,6 +464,7 @@ static inline int pm_request_resume(struct device *dev)
>   */
>  static inline int pm_request_autosuspend(struct device *dev)
>  {
> +	pm_runtime_mark_last_busy(dev);
>  	return __pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
>  }
>  

-- 
Regards,

Laurent Pinchart

