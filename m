Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174ED216EB4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 16:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGGO3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 10:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGO3C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jul 2020 10:29:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7AAA2073E;
        Tue,  7 Jul 2020 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594132141;
        bh=SeXjnrv0KQvcd5JrSwJuK4Z3XaoksQu7R84+qAENwuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4FBXdVCCTFVLNly8/ClwjMiwbxZo2+1v2fWs/GeevPXQR9aB6PotkQGnK9uDtI8n
         Pj4Nw9OWHPnEpZtqW43oBirhBGSOHdjg+NHVJHuuJMvdG0gsH5QAiw7MASezJfgq7Q
         J0CRRFVkt+M1awRqGwq2cUUTDo6vkfeMFo/+qWAo=
Date:   Tue, 7 Jul 2020 16:28:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/1] power: Emit changed uevent on
 wakeup_sysfs_add/remove
Message-ID: <20200707142859.GB55434@kroah.com>
References: <20200706210717.1210639-1-abhishekpandit@chromium.org>
 <20200706140715.v2.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706140715.v2.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 06, 2020 at 02:07:17PM -0700, Abhishek Pandit-Subedi wrote:
> Udev rules that depend on the power/wakeup attribute don't get triggered
> correctly if device_set_wakeup_capable is called after the device is
> created. This can happen for several reasons (driver sets wakeup after
> device is created, wakeup is changed on parent device, etc) and it seems
> reasonable to emit a changed event when adding or removing attributes on
> the device.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> Changes in v2:
> - Add newline at end of bt_dev_err
> 
>  drivers/base/power/sysfs.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 24d25cf8ab1487..d57e8e7f175ebf 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* sysfs entries for device PM */
>  #include <linux/device.h>
> +#include <linux/kobject.h>
>  #include <linux/string.h>
>  #include <linux/export.h>
>  #include <linux/pm_qos.h>
> @@ -739,12 +740,30 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>  
>  int wakeup_sysfs_add(struct device *dev)
>  {
> -	return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> +	int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> +
> +	if (!ret) {
> +		int tmp = kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> +
> +		if (tmp)
> +			dev_err(dev,
> +				"Error in uevent for wakeup_sysfs_add: %d\n",
> +				tmp);
> +	}
> +
> +	return ret;
>  }

Shouldn't the above function look like this instead to be simpler:

int wakeup_sysfs_add(struct device *dev)
{
	int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);

	if (ret)
		return ret;

	return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
}


>  
>  void wakeup_sysfs_remove(struct device *dev)
>  {
> +	int tmp;

Use 'ret' like the above function had, to be consistent.

> +
>  	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> +
> +	tmp = kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> +	if (tmp)
> +		dev_err(dev, "Error in uevent for wakeup_sysfs_remove: %d\n",

nit, use __func__ to describe a function name, if you really want it.
Why do you need to send a message for this error, will that really ever
happen?

thanks,

greg k-h
