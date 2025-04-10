Return-Path: <linux-pm+bounces-25180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669CA84E1B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 22:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1871B68998
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D73293453;
	Thu, 10 Apr 2025 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TwWYvEeM"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2062293440
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316628; cv=none; b=eyztak9xlHJGYlLvmL/LPumG3pqBagvBrKR+GGmqXA5+9eW03aBV02jwNSdMjq2mCllijwwvBwbWeLj53Ru5YqQvmxazSVFjh1675W8Nq1oouaqepEsZDG8y2dqielAaGYi0KS+K/krfotG3YtZHaNBuQvNxnvxMkcd/JTt+BaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316628; c=relaxed/simple;
	bh=z+3fBlBKusjuU4bEebQfKfEk+hgDicPjTDHphGr3DK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xfw0aWGCz2uiF9z0J5kwpY37/IH1Q+8mX8+IOp/YuxwhUUlwwZSVJOeAQjnwn6GXTaaNiePDIHaoC02t1pj+zWet29eLt9o+YvFzzLAJra4pvL1lBRkixsMMcoJwT11j65c6A4J6tcX9VtsvFq3jacfu1N7M8O2dGYQPtsd86So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TwWYvEeM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 094DD352;
	Thu, 10 Apr 2025 22:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1744316506;
	bh=z+3fBlBKusjuU4bEebQfKfEk+hgDicPjTDHphGr3DK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwWYvEeM77yKn9sxiKuHnU6c9NypO9iMDeA1iIzhEPJX4l4ePM6iDFmcgEWvAGCiI
	 eOjrc3U5f3YYCCjrhQ3QVr/HtM/iHbHoIoknZruGwP25L6GRFxNp6n5LBCTnTWBMQY
	 SWCjJ3ViopjbdEWiW9OSZz7mq59j4z17avvUnMEQ=
Date: Thu, 10 Apr 2025 23:23:18 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 4/7] pm: runtime: Mark last busy stamp in
 pm_runtime_put_sync_autosuspend()
Message-ID: <20250410202318.GC29836@pendragon.ideasonboard.com>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-5-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410153106.4146265-5-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Thu, Apr 10, 2025 at 06:31:03PM +0300, Sakari Ailus wrote:
> Set device's last busy timestamp to current time in
> pm_runtime_put_sync_autosuspend().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I was a bit puzzled by why this function exists. Reading
Documentation/power/runtime_pm.rst answered that question: if I
understand it correctly, the function is meant to be used by code that
doesn't know whether or not autosuspend has been enabled for a device,
such as core code in subsystems.

I looked at usage patterns, and found the function being used in drivers
as well, for instance in drivers/media/i2c/tc358746.c. Given that the
driver unconditionally enabled autosuspend, is this incorrect usage of
the API ?

> ---
>  Documentation/power/runtime_pm.rst |  3 ++-
>  include/linux/pm_runtime.h         | 11 +++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index e7bbdc66d64c..9c21c913f9cf 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -428,7 +428,8 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        pm_runtime_suspend(dev) and return its result
>  
>    `int pm_runtime_put_sync_autosuspend(struct device *dev);`
> -    - decrement the device's usage counter; if the result is 0 then run
> +    - set the power.last_busy field to the current time and decrement the
> +      device's usage counter; if the result is 0 then run
>        pm_runtime_autosuspend(dev) and return its result
>  
>    `void pm_runtime_enable(struct device *dev);`
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 0ade3f75d903..e26caf2c0552 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -645,12 +645,14 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
>  }
>  
>  /**
> - * pm_runtime_put_sync_autosuspend - Drop device usage counter and autosuspend if 0.
> + * pm_runtime_put_sync_autosuspend - Update the last access time of a device,
> + * drop device usage counter and autosuspend if 0.
>   * @dev: Target device.
>   *
> - * Decrement the runtime PM usage counter of @dev and if it turns out to be
> - * equal to 0, set up autosuspend of @dev or suspend it synchronously (depending
> - * on whether or not autosuspend has been enabled for it).
> + * Update the last access time of @dev, decrement the runtime PM usage counter
> + * of @dev and if it turns out to be equal to 0, set up autosuspend of @dev or
> + * suspend it synchronously (depending on whether or not autosuspend has been
> + * enabled for it).
>   *
>   * The runtime PM usage counter of @dev remains decremented in all cases, even
>   * if it returns an error code.
> @@ -670,6 +672,7 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
>   */
>  static inline int pm_runtime_put_sync_autosuspend(struct device *dev)
>  {
> +	pm_runtime_mark_last_busy(dev);
>  	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_AUTO);
>  }
>  

-- 
Regards,

Laurent Pinchart

