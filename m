Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9084321732F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 18:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgGGQAs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 12:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgGGQAs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jul 2020 12:00:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77402206E2;
        Tue,  7 Jul 2020 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594137647;
        bh=0BlRynaDNr3hx41psfYOd+ICHIe/RtCgteNSx90K9JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INE9r+/HdvJPhuASOEkh8ETNgO4NdGufY/na5p6QUOGo4vyNijRYlsww2dwSU4yCz
         d+HAhNn28aW+s0NJpJ6lOOzlE8bHkIuvfxAPjVaQ4+/9hR9FvR0jvEVdOPWYfjHuMS
         scppuriDxmSkBf37MeolAGQODZ1035i4wsqBEQGY=
Date:   Tue, 7 Jul 2020 18:00:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 1/1] power: Emit changed uevent on
 wakeup_sysfs_add/remove
Message-ID: <20200707160045.GA118278@kroah.com>
References: <20200707154905.2763616-1-abhishekpandit@chromium.org>
 <20200707084857.v3.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707084857.v3.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 07, 2020 at 08:49:05AM -0700, Abhishek Pandit-Subedi wrote:
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
> Changes in v3:
> - Simplified error handling
> 
> Changes in v2:
> - Add newline at end of bt_dev_err
> 
>  drivers/base/power/sysfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 24d25cf8ab1487..04c82373c8f240 100644
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
> @@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>  
>  int wakeup_sysfs_add(struct device *dev)
>  {
> -	return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> +	int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> +
> +	if (ret)
> +		return ret;
> +
> +	return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
>  }
>  
>  void wakeup_sysfs_remove(struct device *dev)
>  {
>  	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> +	return kobject_uevent(&dev->kobj, KOBJ_CHANGE);

Always test build and hopefully actually test, your patches before
sending them out :(

