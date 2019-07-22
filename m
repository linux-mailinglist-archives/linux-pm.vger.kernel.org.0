Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865D37085E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 20:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfGVSW4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 14:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfGVSW4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 14:22:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B52021901;
        Mon, 22 Jul 2019 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563819775;
        bh=J9M7faZ41fDOYZssXZM6tk4l7o043dO6n8/RMOul8QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlyyurH9m+xtpjE6DT+vlJNbAd1S2BPOTLxWBn89GnqD2uyJuv5XYTe2nU+DY0wV2
         awRf1tuM1dRG+t8rpdDPX36lb2irTphUakv8OwyH9vVXYqvS8VTJRh0PGPfHZpsXLK
         gWJ7eRbUoWwwWm6pXQaFOv7gx1WemlQNM+o8IwG0=
Date:   Mon, 22 Jul 2019 20:22:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: Re: [PATCH] power:sysfs: Expose device wakeup_event_count.
Message-ID: <20190722182252.GA24412@kroah.com>
References: <20190722180258.255949-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722180258.255949-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 11:02:58AM -0700, Ravi Chandra Sadineni wrote:
> Device level event_count can help user level daemon to track if a
> praticular device has seen an wake interrupt during a suspend resume
> cycle. Thus expose it via sysfs.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-power | 11 ++++++++++
>  drivers/base/power/sysfs.c                    | 20 +++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
> index 1ca04b4f0489..344549f4013f 100644
> --- a/Documentation/ABI/testing/sysfs-devices-power
> +++ b/Documentation/ABI/testing/sysfs-devices-power
> @@ -89,6 +89,17 @@ Description:
>  		attribute is not present. If the device is not enabled to wake
>  		up the system from sleep states, this attribute is empty.
>  
> +What:		/sys/devices/.../power/wakeup_event_count
> +Date:		July 2019
> +Contact:	Ravi Chandra sadineni <ravisadineni@chromium.org>
> +Description:
> +		The /sys/devices/.../wakeup_event_count attribute contains the
> +		number of signaled wakeup events associated with the device.
> +		This attribute is read-only. If the device is not capable to
> +		wake up the system from sleep states, this attribute is not
> +		present. If the device is not enabled to wake up the system
> +		from sleep states, this attribute is empty.

The attribute is not "empty" it returns just an empty line.

Is that really a good thing if you are expecting a number?

> +
>  What:		/sys/devices/.../power/wakeup_active_count
>  Date:		September 2010
>  Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index f42044d9711c..8dc1235b9784 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -357,6 +357,25 @@ static ssize_t wakeup_count_show(struct device *dev,
>  
>  static DEVICE_ATTR_RO(wakeup_count);
>  
> +static ssize_t wakeup_event_count_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	unsigned long count = 0;
> +	bool enabled = false;
> +
> +	spin_lock_irq(&dev->power.lock);
> +	if (dev->power.wakeup) {
> +		count = dev->power.wakeup->event_count;
> +		enabled = true;
> +	}
> +	spin_unlock_irq(&dev->power.lock);

Why do you need to lock?  The state and count can change right after the
lock, so what does this help with?

> +	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");

Use a real if statement please.

> +}
> +
> +static DEVICE_ATTR_RO(wakeup_event_count);
> +
> +
> +

too many empty lines :)

thanks,

greg k-h
