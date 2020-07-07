Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA4217251
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgGGPbb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgGGPba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 11:31:30 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02917C08C5DC
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 08:31:30 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id h190so9519797vkh.6
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9pD5UhiE599Tk9wmQP354KMod/Tb87VcByMMuwvg3k=;
        b=G+VWkqkqtjaLmPcbE4Vr+ciMMRNHr+VCxIoF6KeYJNsyLUH8ifsFw42bsVUuCQcL2v
         4h8B6RVOb0A7JHYxkMMPFot6aNEHIX4sO1KFmTN9HVLhhirhuN/5M7I9phPJxLAU7aez
         9P7ONjtIUTLRxZSOQviFEN8aNFPBqxVoZEhGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9pD5UhiE599Tk9wmQP354KMod/Tb87VcByMMuwvg3k=;
        b=toSnl9tKua7yzgQ8jiPU1DQ1BL+ILuY4MKOUM7otuX5O1VO/lRM3p7b7gqq+Kkc6rN
         VzIXscxd+Q1jNPGGjwqk6VttwoPpRchzsanKd0caPARXVOef3GzvU4vLq2JyIKJUIDjw
         9rT8zw85i/FzEfhpTuHBg0QuXWvao8S7Ew2LGHega5X7W7Jtl8GlC740pdYna7xpiZn6
         cUvhBB7lQg1irHmwonCt37mINgZGSblEc5uWYFbct7FmKhIfvFbZnvp2deaiwsLO/Nb6
         Ta/satTl5u0LIZ5BJ3YuxojShL3uhaawE+g7cfRUDPA+vTgn0TkEmTc0509kCkm9OHUD
         Pmjg==
X-Gm-Message-State: AOAM530aUxgO1PKKqDZwBh6KQrRmQHT+6z/PsxEKFMVHXJUvAw7Zd3z5
        4ZeWUk2Z+iT99djkJ8h+D1eO76GJZnnvc8mH4GXTZg==
X-Google-Smtp-Source: ABdhPJzywIHzvHEbshbYh1BPf/R2VSON3B3el7elCV5+s8tTIaZ0pNfM6hRiiIO9NHAG6kQxEZ1i9zEbDrKxhAAT9zg=
X-Received: by 2002:a1f:418f:: with SMTP id o137mr37478018vka.25.1594135888939;
 Tue, 07 Jul 2020 08:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200706210717.1210639-1-abhishekpandit@chromium.org>
 <20200706140715.v2.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid> <20200707142859.GB55434@kroah.com>
In-Reply-To: <20200707142859.GB55434@kroah.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Jul 2020 08:31:18 -0700
Message-ID: <CANFp7mUgJScOn1xJFqqK82UkRsQ7GpsEJ7Ai9gptZjCRtf+JJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        rafael.j.wysocki@intel.com, Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,


On Tue, Jul 7, 2020 at 7:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 06, 2020 at 02:07:17PM -0700, Abhishek Pandit-Subedi wrote:
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
> > Changes in v2:
> > - Add newline at end of bt_dev_err
> >
> >  drivers/base/power/sysfs.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > index 24d25cf8ab1487..d57e8e7f175ebf 100644
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
> > @@ -739,12 +740,30 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
> >
> >  int wakeup_sysfs_add(struct device *dev)
> >  {
> > -     return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +     int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +
> > +     if (!ret) {
> > +             int tmp = kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> > +
> > +             if (tmp)
> > +                     dev_err(dev,
> > +                             "Error in uevent for wakeup_sysfs_add: %d\n",
> > +                             tmp);
> > +     }
> > +
> > +     return ret;
> >  }
>
> Shouldn't the above function look like this instead to be simpler:
>
> int wakeup_sysfs_add(struct device *dev)
> {
>         int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
>
>         if (ret)
>                 return ret;
>
>         return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> }
>
>
> >
> >  void wakeup_sysfs_remove(struct device *dev)
> >  {
> > +     int tmp;
>
> Use 'ret' like the above function had, to be consistent.
>
> > +
> >       sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> > +
> > +     tmp = kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> > +     if (tmp)
> > +             dev_err(dev, "Error in uevent for wakeup_sysfs_remove: %d\n",
>
> nit, use __func__ to describe a function name, if you really want it.
> Why do you need to send a message for this error, will that really ever
> happen?
>

Looking through kobject_uevent, it does look like the errors are
unlikely to be seen (-ENOMEM, -ENOENT) and probably don't need to be
logged.
Will apply the suggestions above and send a v3.

Thanks,
Abhishek

> thanks,
>
> greg k-h
