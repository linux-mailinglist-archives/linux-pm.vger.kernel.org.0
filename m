Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A777CFEE
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfGaVTR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:19:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45793 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfGaVTR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:19:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so51907642oib.12;
        Wed, 31 Jul 2019 14:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzyHnanfaOTPxHoF3LKE4Om9lWjz1so8u2/O9AODChE=;
        b=ghAvTr3OQ80WyWlLSfe/bEw50niizuiKx48rnu+0US+jnmKhfTKgzU3/R2fIoq5hEU
         Yxzf30sy9nsYpzxvtiyrBVONhat/oT/jFj2993pg7seVlUbeX5WMJcwSA+63D1bFisfS
         U9EN1PNl6LgxPAM8p2iZaMjt5U22RZzp0/qGyCmSbDfzJUZ06pCmnNbZKfFI6qVkO9qE
         6Wwf7qP3uo58GfNgZ37fa0sL3SRjNrejW0c0Eo55w5Lv9jchZ+krP9Lg6JQYtzvloocy
         huZAGPaW8249hprzsDUFmzROrwwEk21v+pVKXhypRmVyO1LjMPlocylhqHSGwpiaCYaF
         2Bug==
X-Gm-Message-State: APjAAAV420Neo2kDBRgRMjsFEM+1mN0MoK2jY7xnCI1tCnlmkYJ8l4tT
        Fxf/G31EQRkCrZDAZMPCwDSLHPHMr2H7oxGDvdQ=
X-Google-Smtp-Source: APXvYqzYwv61kifcrw/006ib/jUsVg1OGY/R5Q4szmHDksbv8zACV2eT6uKJsceeXuAEcx4T9zrE8SA5ZBnmv+NG4mg=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr55041731oig.115.1564607956221;
 Wed, 31 Jul 2019 14:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190730024309.233728-1-trong@android.com> <5d40d5b3.1c69fb81.6047f.1cc3@mx.google.com>
 <CAJZ5v0hj-GpiYN7nwPJvKJag71MG6zEFbJ6BNwzDidD+7fNFWw@mail.gmail.com>
 <3963324.N1Qi0Ay72S@kreacher> <5d41cc55.1c69fb81.9480d.8a49@mx.google.com>
In-Reply-To: <5d41cc55.1c69fb81.9480d.8a49@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Jul 2019 23:19:04 +0200
Message-ID: <CAJZ5v0gdmmgBuSQU7FWaBmdTq7diToKO=5F5e5vRt=Yqvn9C2Q@mail.gmail.com>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tri Vo <trong@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 31, 2019 at 7:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-07-31 04:58:36)
> > On Wednesday, July 31, 2019 10:34:11 AM CEST Rafael J. Wysocki wrote:
> > > On Wed, Jul 31, 2019 at 1:41 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > >
> > > > We can run into the same problem when two buses name their devices the
> > > > same name and then we attempt to attach a wakeup source to those two
> > > > devices. Or we can have a problem where a virtual wakeup is made with
> > > > the same name, and again we'll try to make a duplicate named device.
> > > > Using something like 'event' or 'wakeup' or 'ws' as the prefix avoids this
> > > > problem and keeps things clean.
> > >
> > > Or suffix, like "<devname-wakeup>.
> > >
> > > But if prefixes are used by an existing convention, I would prefer
> > > "ws-" as it is concise enough and should not be confusing.
>
> Another possibility is 'eventN', so it reads as /sys/class/wakeup/event0
>
> > >
> > > > We should probably avoid letting the same virtual wakeup source be made
> > > > with the same name anyway, because userspace will be confused about what
> > > > virtual wakeup it is otherwise. I concede that using the name of the
> > > > wakeup source catches this problem without adding extra code.
> > > >
> > > > Either way, I'd like to see what you outline implemented so that we
> > > > don't need to do more work than is necessary when userspace writes to
> > > > the file.
> > >
> > > Since we agree here, let's make this change first.  I can cut a patch
> > > for that in a reasonable time frame I think if no one else beats me to
> > > that.
> >
> > So maybe something like the patch below (untested).
> >
> > Index: linux-pm/drivers/base/power/wakeup.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/wakeup.c
> > +++ linux-pm/drivers/base/power/wakeup.c
> > @@ -265,15 +244,29 @@ int device_wakeup_enable(struct device *
> >         if (pm_suspend_target_state != PM_SUSPEND_ON)
> >                 dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
> >
> > +       spin_lock_irq(&dev->power.lock);
> > +
> > +       if (dev->power.wakeup) {
> > +               spin_unlock_irq(&dev->power.lock);
> > +               return -EEXIST;
> > +       }
> > +       dev->power.wakeup = ERR_PTR(-EBUSY);
> > +
> > +       spin_unlock_irq(&dev->power.lock);
> > +
> >         ws = wakeup_source_register(dev_name(dev));
> >         if (!ws)
> >                 return -ENOMEM;
> >
>
> Let's say that device_wakeup_enable() is called twice at around the same
> time. First thread gets to wakeup_source_register() and it fails, we
> return -ENOMEM.

The return is premature.  dev->power.wakeup should be reset back to
NULL if the wakeup source creation fails.

> dev->power.wakeup is assigned to ERR_PTR(-EBUSY). Second
> thread is at the spin_lock_irq() above, it grabs the lock and sees
> dev->power.wakeup is ERR_PTR(-EBUSY) so it bails out with return
> -EEXIST. I'd think we would want to try to create the wakeup source
> instead.
>
>     CPU0                                   CPU1
>     ----                                   ----
>     spin_lock_irq(&dev->power.lock)
>     ...
>     dev->power.wakeup = ERR_PTR(-EBUSY)
>     spin_unlock_irq(&dev->power.lock)
>     ws = wakeup_source_register(...)
>     if (!ws)
>         return -ENOMEM;                 spin_lock_irq(&dev->power.lock)
>                                         if (dev->power.wakeup)
>                                             return -EEXIST; // Bad
>
>
> Similar problems probably exist with wakeup destruction racing with
> creation. I think it might have to be a create and then publish pointer
> style of code to keep the spinlock section small?

There is a problem when there are two concurrent callers of
device_wakeup_enable() running in parallel with a caller of
device_wakeup_disable(), but that can be prevented by an extra check
in the latter.

Apart from that I missed a few if (dev->power.wakeup) checks to convert.

I'll update the patch and resend it.
