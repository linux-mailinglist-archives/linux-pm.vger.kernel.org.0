Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63147295B81
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 11:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505092AbgJVJQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 05:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439287AbgJVJQa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 05:16:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815DF222E9;
        Thu, 22 Oct 2020 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603358189;
        bh=X7YWORMLc3boOQq34ADkP+iYUcQE1Vh/uDhPZqf73qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrM04kOaVq8sTalX12dV9GaiVMgkvOmX3B/t8dotno/NSgRFKLaBQy+nL/oghZ4Ew
         QI3+S8SHJFQFFS306CczTQKDtJK761qJo3K8bEel8L5vmPggy+EiMTNwQtQwvpwUzw
         U6l5B8tde9Muu7CBJ+L1SteLRNUQBjZo4KlVTBQ4=
Date:   Thu, 22 Oct 2020 11:17:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] PM / sysfs: Expose suspend resume driver flags in
 sysfs
Message-ID: <20201022091707.GA1485535@kroah.com>
References: <20201022085244.1860-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022085244.1860-1-yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 04:52:44PM +0800, Chen Yu wrote:
> Currently there are 4 driver flags to control system suspend/resume
> behavior: DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME. Make these flags
> visible in sysfs as read-only to get a brief understanding of the
> expected behavior of each device during suspend/resume, so as to
> facilitate suspend/resume debugging/tuning.
> 
> For example:
> /sys/devices/pci0000:00/0000:00:15.1/power/driver_flags:4
> (DPM_FLAG_SMART_SUSPEND)
> 
> /sys/devices/pci0000:00/0000:00:07.3/power/driver_flags:5
> (DPM_FLAG_NO_DIRECT_COMPLETE | DPM_FLAG_SMART_SUSPEND)
> 
> Acked-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Adding description in Documentation/ABI/testing/sysfs-devices-power
>     according to Greg's suggestion.
> --
>  Documentation/ABI/testing/sysfs-devices-power | 11 +++++++
>  drivers/base/power/sysfs.c                    | 29 ++++++++++++++++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
> index 1763e64dd152..8ea68639ab3a 100644
> --- a/Documentation/ABI/testing/sysfs-devices-power
> +++ b/Documentation/ABI/testing/sysfs-devices-power
> @@ -269,3 +269,14 @@ Description:
>  		the current runtime PM status of the device, which may be
>  		"suspended", "suspending", "resuming", "active", "error" (fatal
>  		error), or "unsupported" (runtime PM is disabled).
> +
> +What:		/sys/devices/.../power/driver_flags
> +Date:		October 2020
> +Contact:	Chen Yu <yu.c.chen@intel.com>
> +Description:
> +		The /sys/devices/.../driver_flags attribute contains the driver
> +		flags to control system suspend/resume. The flag is a combination
> +		of DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> +		DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME, or 0 if the
> +		driver has not set any flag. This attribute is read-only. If
> +		CONFIG_PM_ADVANCED_DEBUG is not set this attribute is empty.

You are now exporting random internal kernel values to userspace, so
they are now going to become a userspace API value that you must ensure
works for the next 20+ years.

Are you _SURE_ you want to do this?  What is this velue being exported
going to show you?  Who is going to use it?  For what?

And if you are going to export it to userspace, you need to actually
give userspace the values so that it knows what they are, by moving them
to a uapi file.

And if you do that, you need to name them a lot better...

> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index a1474fb67db9..48313a1040a5 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -607,6 +607,13 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
>  
>  static DEVICE_ATTR_RW(async);
>  
> +static ssize_t driver_flags_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%x\n", dev->power.driver_flags);
> +}
> +static DEVICE_ATTR_RO(driver_flags);
> +
>  #endif /* CONFIG_PM_SLEEP */
>  #endif /* CONFIG_PM_ADVANCED_DEBUG */
>  
> @@ -691,6 +698,20 @@ static const struct attribute_group pm_qos_flags_attr_group = {
>  	.attrs	= pm_qos_flags_attrs,
>  };
>  
> +static struct attribute *pm_driver_flags_attrs[] = {
> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> +#ifdef CONFIG_PM_SLEEP
> +	&dev_attr_driver_flags.attr,
> +#endif
> +#endif

As this is for debugging only, why is it in sysfs and not debugfs?


> +	NULL,
> +};
> +
> +static const struct attribute_group pm_driver_flags_attr_group = {
> +	.name	= power_group_name,
> +	.attrs	= pm_driver_flags_attrs,
> +};
> +
>  int dpm_sysfs_add(struct device *dev)
>  {
>  	int rc;
> @@ -719,11 +740,17 @@ int dpm_sysfs_add(struct device *dev)
>  		if (rc)
>  			goto err_wakeup;
>  	}
> -	rc = pm_wakeup_source_sysfs_add(dev);
> +	rc = sysfs_merge_group(&dev->kobj, &pm_driver_flags_attr_group);

Ick, really?  Why not make it part of the other attribute group?  Why
make it a stand-alone one?  This feels like extra uneeded work if you
really are going to do this.

thanks,

greg k-h
