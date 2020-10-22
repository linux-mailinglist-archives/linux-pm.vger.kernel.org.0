Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E82C2964C0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369740AbgJVSlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 14:41:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:27153 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368421AbgJVSlS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 14:41:18 -0400
IronPort-SDR: 9J9GskZZlJ07GIkXQvy1Ty13mvoRA6FYYKtPHktb3jOAOWZHEihf8TJgmOrCNSH06zksk2gpP2
 lponmlX5eVgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="229209236"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="229209236"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 11:41:17 -0700
IronPort-SDR: 5N6qHqRd0Srw8wxTI9l3Qzjln4fXmAM8MqhQCD6g+lQYMIGAwxrpF9OhdnFblXa1f4Eo1TFilT
 tCjFbbNd6Ufw==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="534078453"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 11:41:15 -0700
Date:   Fri, 23 Oct 2020 02:43:37 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] PM / sysfs: Expose suspend resume driver flags in
 sysfs
Message-ID: <20201022184336.GA8593@chenyu-office.sh.intel.com>
References: <20201022085244.1860-1-yu.c.chen@intel.com>
 <20201022091707.GA1485535@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022091707.GA1485535@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,
On Thu, Oct 22, 2020 at 11:17:07AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 22, 2020 at 04:52:44PM +0800, Chen Yu wrote:
> > Currently there are 4 driver flags to control system suspend/resume
> > behavior: DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> > DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME. Make these flags
> > visible in sysfs as read-only to get a brief understanding of the
> > expected behavior of each device during suspend/resume, so as to
> > facilitate suspend/resume debugging/tuning.
> > 
> > For example:
> > /sys/devices/pci0000:00/0000:00:15.1/power/driver_flags:4
> > (DPM_FLAG_SMART_SUSPEND)
> > 
> > /sys/devices/pci0000:00/0000:00:07.3/power/driver_flags:5
> > (DPM_FLAG_NO_DIRECT_COMPLETE | DPM_FLAG_SMART_SUSPEND)
> > 
> > Acked-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v2: Adding description in Documentation/ABI/testing/sysfs-devices-power
> >     according to Greg's suggestion.
> > --
> >  Documentation/ABI/testing/sysfs-devices-power | 11 +++++++
> >  drivers/base/power/sysfs.c                    | 29 ++++++++++++++++++-
> >  2 files changed, 39 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
> > index 1763e64dd152..8ea68639ab3a 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-power
> > +++ b/Documentation/ABI/testing/sysfs-devices-power
> > @@ -269,3 +269,14 @@ Description:
> >  		the current runtime PM status of the device, which may be
> >  		"suspended", "suspending", "resuming", "active", "error" (fatal
> >  		error), or "unsupported" (runtime PM is disabled).
> > +
> > +What:		/sys/devices/.../power/driver_flags
> > +Date:		October 2020
> > +Contact:	Chen Yu <yu.c.chen@intel.com>
> > +Description:
> > +		The /sys/devices/.../driver_flags attribute contains the driver
> > +		flags to control system suspend/resume. The flag is a combination
> > +		of DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
> > +		DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME, or 0 if the
> > +		driver has not set any flag. This attribute is read-only. If
> > +		CONFIG_PM_ADVANCED_DEBUG is not set this attribute is empty.
> 
> You are now exporting random internal kernel values to userspace, so
> they are now going to become a userspace API value that you must ensure
> works for the next 20+ years.
> 
> Are you _SURE_ you want to do this?  What is this velue being exported
> going to show you?  Who is going to use it?  For what?
> 
The value exposed can give the user(usually the developer who wants to
speed up the suspend/resume process on this platform) a brief overview
on each device. The 4 flags are actually suspend/resume speed up strategy.
By checking what the current suspend/resume speed up strategy of each device
is, we can infer if there any room to be improved in case some devices have
not enabled any suspend/resume speed up strategy yet.
> And if you are going to export it to userspace, you need to actually
> give userspace the values so that it knows what they are, by moving them
> to a uapi file.
> 
> And if you do that, you need to name them a lot better...
> 
If exposing them in sysfs is inappropriate as the cost of maintaining this
item is considerable, maybe we can print this flag in power debug message during
suspend/resume, via dynamic debug.
> > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > index a1474fb67db9..48313a1040a5 100644
> > --- a/drivers/base/power/sysfs.c
> > +++ b/drivers/base/power/sysfs.c
> > @@ -607,6 +607,13 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
> >  
> >  static DEVICE_ATTR_RW(async);
> >  
> > +static ssize_t driver_flags_show(struct device *dev,
> > +				 struct device_attribute *attr, char *buf)
> > +{
> > +	return sysfs_emit(buf, "%x\n", dev->power.driver_flags);
> > +}
> > +static DEVICE_ATTR_RO(driver_flags);
> > +
> >  #endif /* CONFIG_PM_SLEEP */
> >  #endif /* CONFIG_PM_ADVANCED_DEBUG */
> >  
> > @@ -691,6 +698,20 @@ static const struct attribute_group pm_qos_flags_attr_group = {
> >  	.attrs	= pm_qos_flags_attrs,
> >  };
> >  
> > +static struct attribute *pm_driver_flags_attrs[] = {
> > +#ifdef CONFIG_PM_ADVANCED_DEBUG
> > +#ifdef CONFIG_PM_SLEEP
> > +	&dev_attr_driver_flags.attr,
> > +#endif
> > +#endif
> 
> As this is for debugging only, why is it in sysfs and not debugfs?
> 
> 
Because
1. There seems to be no proper directory for per-device item in debugfs.
2. There seems to be other power related debug items in this directory.
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group pm_driver_flags_attr_group = {
> > +	.name	= power_group_name,
> > +	.attrs	= pm_driver_flags_attrs,
> > +};
> > +
> >  int dpm_sysfs_add(struct device *dev)
> >  {
> >  	int rc;
> > @@ -719,11 +740,17 @@ int dpm_sysfs_add(struct device *dev)
> >  		if (rc)
> >  			goto err_wakeup;
> >  	}
> > -	rc = pm_wakeup_source_sysfs_add(dev);
> > +	rc = sysfs_merge_group(&dev->kobj, &pm_driver_flags_attr_group);
> 
> Ick, really?  Why not make it part of the other attribute group?  Why
> make it a stand-alone one?  This feels like extra uneeded work if you
> really are going to do this.
Ah, yes, it should be put into existing attribute group which makes it
much simpler.

But since you mentioned that maintaining this item in sysfs looks overkill,
we can put this flags information in dynamic debug log, which only includes
one line of code change, although the disadvantage is that we will need to
do a real suspend/resume cycle to get driver_flags to be printed.
thanks,
Chenyu
> 
> thanks,
> 
> greg k-h
