Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38372174EF
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGGRQo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 13:16:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37235 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGRQn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 13:16:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id w17so27027483otl.4;
        Tue, 07 Jul 2020 10:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUdKoU1H+z8qeBTxQdM+SPgy95nTHPoa7jpopZEDv8Y=;
        b=Pf6FMT5LyEMitO9qDPArxDr4uMH/z/aW3bgwB682VenojpZ1OL3XD4exe5l3VC99rM
         b8KeATINejGg2ywbQa75nwXG+kjYfGOIHpN+jIIF9dsmkgQ8usP2utRu/MuteJVJKnl/
         BjaQRfr/LQipscWjSUNq93QvZm5q9gy25mHYMfZdwlrVvMFOexza0nu3A5/Km2il6r3j
         T0GqLb3OqGY6ZKDS+2r/5GAlsFdybpwcY9jDK8lr9J/TRiegRQtpI9gQVcUnClsnnCu7
         /Xl8GNEgBjIyoGOetVldvar/UgMsHtq4BI1MTAtqNCn4Z7z80cK8uCHjohq8gO3UitAs
         wb2w==
X-Gm-Message-State: AOAM531x+oKnoQQT+oNWQzSrWfcHD7rmG2ZvegSdZ5BAXccEppmjXmtf
        c6+DDfLx7xH41Iz0sWRRheOwOZKtNnzXf3Eqthc=
X-Google-Smtp-Source: ABdhPJx8HATaz0zjRx9gs1OrA241/fnh2U+zL02uEuN+UC4P7Dh1KnovbuqHuDqumPh5Ub2BG0nc5bCvGslWULqn6lk=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr9944178oth.262.1594142202516;
 Tue, 07 Jul 2020 10:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200707162417.3514284-1-abhishekpandit@chromium.org>
 <20200707092406.v4.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
 <CAJZ5v0iyvge_Hqgm46_vfjh45YFdnsJ7ksvY7DqD6gx+f+1dvg@mail.gmail.com> <CANFp7mUas8Qnzqeivri25S7SWbKe6T+6riN419dR6xZXXOcaKA@mail.gmail.com>
In-Reply-To: <CANFp7mUas8Qnzqeivri25S7SWbKe6T+6riN419dR6xZXXOcaKA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jul 2020 19:16:31 +0200
Message-ID: <CAJZ5v0iVXbxHzV0Y_y5idkoS4DdF+cXQ6kmA0bWWHWZ-TVv8wg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] power: Emit changed uevent on wakeup_sysfs_add/remove
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Tue, Jul 7, 2020 at 6:48 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Rafael,
>
> (resent in plain text)
>
> On Tue, Jul 7, 2020 at 9:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jul 7, 2020 at 6:24 PM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > Udev rules that depend on the power/wakeup attribute don't get triggered
> > > correctly if device_set_wakeup_capable is called after the device is
> > > created. This can happen for several reasons (driver sets wakeup after
> > > device is created, wakeup is changed on parent device, etc) and it seems
> > > reasonable to emit a changed event when adding or removing attributes on
> > > the device.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > > - Fix warning where returning from void and tested on device
> > >
> > > Changes in v3:
> > > - Simplified error handling
> > >
> > > Changes in v2:
> > > - Add newline at end of bt_dev_err
> > >
> > >  drivers/base/power/sysfs.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > > index 24d25cf8ab1487..aeb58d40aac8de 100644
> > > --- a/drivers/base/power/sysfs.c
> > > +++ b/drivers/base/power/sysfs.c
> > > @@ -1,6 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /* sysfs entries for device PM */
> > >  #include <linux/device.h>
> > > +#include <linux/kobject.h>
> > >  #include <linux/string.h>
> > >  #include <linux/export.h>
> > >  #include <linux/pm_qos.h>
> > > @@ -739,12 +740,18 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
> > >
> > >  int wakeup_sysfs_add(struct device *dev)
> > >  {
> > > -       return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > > +       int ret = sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
> > > +
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       return kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> >
> > So let me repeat the previous comment:
> >
> > If you return an error here, it may confuse the caller to think that
> > the operation has failed completely, whereas the merging of the
> > attribute group has been successful already.
> >
> > I don't think that an error can be returned at this point.
> >
>
> The caller looks at the return code and just logs that an error
> occurred (no other action). It's also unlikely for kobject_uevent to
> fail (I saw mostly -ENOMEM and an -ENOENT when the kobj wasn't in the
> correct set).
>
> Call site:
>     int ret = wakeup_sysfs_add(dev);
>
>     if (ret)
>         dev_info(dev, "Wakeup sysfs attributes not added\n");

Yes, which is confusing, because the wakeup attributes may in fact
have been added.  Which is my point.

>
> So I'm ok with either keeping this as-is (caller isn't getting
> confused, just logging) or swallowing the return of kobject_uevent.

I would just ignore the return value of kobject_uevent() along the
lines of wakeup_sysfs_remove() below.

Thanks!

> > >  }
> > >
> > >  void wakeup_sysfs_remove(struct device *dev)
> > >  {
> > >         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> > > +       kobject_uevent(&dev->kobj, KOBJ_CHANGE);
> > >  }
> > >
> > >  int pm_qos_sysfs_add_resume_latency(struct device *dev)
> > > --
> > > 2.27.0.212.ge8ba1cc988-goog
> > >
