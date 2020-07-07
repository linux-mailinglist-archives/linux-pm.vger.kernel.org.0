Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B214217464
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGGQsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgGGQsE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 12:48:04 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B7C08C5E1
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 09:48:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p25so15088454vsg.4
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eWoCnOASAKMtuQZyGLOuX3o7NTlzqUAEG+oBEPWKJ8=;
        b=El0vxZtqg6JPxeKZyM66PqiJ4jyD0i9lHL6yotyIIDUC+AViY0YG4D/79jNwjMUabw
         9Pr+v/FoxAAvwkEMHuljUs0iNcnGbyDN1kDvHa6dchgrr3JbLcEOq/qc5RS43jbf9URR
         JVyJb24B6MSCghW0Q5LihVIf3+BHxKMaYaFA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eWoCnOASAKMtuQZyGLOuX3o7NTlzqUAEG+oBEPWKJ8=;
        b=o7hRskhLn+bIGNboQ+2U1wL4gznz2+lBq0vlwkEW7lHLDCWjMMLR96/S2mHq30/9Kc
         HtiSNXixAEL0+1TdAdOnftuu+orHW49UD9N8TVaryClsNxsqLEtNYXLtTxuK/ee8/9u2
         tsb2sbhalk1hUZo6bPlmYJShPXhLoRWCLHHWi5oWuCtbxDnVtjhWX2+HULRah/W9QQRl
         C5WQHmg9V3YZk00BJOqTycEWG9U2Jr0pLQKRkqVFtr9wFbEsBKQYj5IT7gCFeolM2NXB
         sK9oqLhN/eHtRGB9+cuTITfXJ9k7cmyxkRBJsnrra4T3KCoMUz5J6pszZsZOaQ/ghWwM
         EJvg==
X-Gm-Message-State: AOAM530pycAcw+O1LtOQA7PLsndQ2elj2QuS9CWpbC+qGWl3f1UTcVFP
        MQLeSh4MFaPO6XyrqFkRvlQdnb8DWLXdxiD6ryQ4mA==
X-Google-Smtp-Source: ABdhPJysq8+6FxhpZrg1dgwHaUrHRyK3KI93qSdqzWL6HNijbQcEkUjFbxYm09sE8WLnXhQ1UoylWLanSIj9IJCT5bo=
X-Received: by 2002:a67:c90c:: with SMTP id w12mr30280616vsk.86.1594140483655;
 Tue, 07 Jul 2020 09:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200707162417.3514284-1-abhishekpandit@chromium.org>
 <20200707092406.v4.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid> <CAJZ5v0iyvge_Hqgm46_vfjh45YFdnsJ7ksvY7DqD6gx+f+1dvg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iyvge_Hqgm46_vfjh45YFdnsJ7ksvY7DqD6gx+f+1dvg@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Jul 2020 09:47:52 -0700
Message-ID: <CANFp7mUas8Qnzqeivri25S7SWbKe6T+6riN419dR6xZXXOcaKA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

(resent in plain text)

On Tue, Jul 7, 2020 at 9:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jul 7, 2020 at 6:24 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > Udev rules that depend on the power/wakeup attribute don't get triggered
> > correctly if device_set_wakeup_capable is called after the device is
> > created. This can happen for several reasons (driver sets wakeup after
> > device is created, wakeup is changed on parent device, etc) and it seems
> > reasonable to emit a changed event when adding or removing attributes on
> > the device.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Fix warning where returning from void and tested on device
> >
> > Changes in v3:
> > - Simplified error handling
> >
> > Changes in v2:
> > - Add newline at end of bt_dev_err
> >
> >  drivers/base/power/sysfs.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > index 24d25cf8ab1487..aeb58d40aac8de 100644
> > --- a/drivers/base/power/sysfs.c
> > +++ b/drivers/base/power/sysfs.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* sysfs entries for device PM */
> >  #include <linux/device.h>
> > +#include <linux/kobject.h>
> >  #include <linux/string.h>
> >  #include <linux/export.h>
> >  #include <linux/pm_qos.h>
> > @@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
> >
> >  int wakeup_sysfs_add(struct device *dev)
> >  {
> > -       return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +       int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +
> > +       if (ret)
> > +               return ret;
> > +
> > +       return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
>
> So let me repeat the previous comment:
>
> If you return an error here, it may confuse the caller to think that
> the operation has failed completely, whereas the merging of the
> attribute group has been successful already.
>
> I don't think that an error can be returned at this point.
>

The caller looks at the return code and just logs that an error
occurred (no other action). It's also unlikely for kobject_uevent to
fail (I saw mostly -ENOMEM and an -ENOENT when the kobj wasn't in the
correct set).

Call site:
    int ret = wakeup_sysfs_add(dev);

    if (ret)
        dev_info(dev, "Wakeup sysfs attributes not added\n");

So I'm ok with either keeping this as-is (caller isn't getting
confused, just logging) or swallowing the return of kobject_uevent.

> >  }
> >
> >  void wakeup_sysfs_remove(struct device *dev)
> >  {
> >         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +       kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> >  }
> >
> >  int pm_qos_sysfs_add_resume_latency(struct device *dev)
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
