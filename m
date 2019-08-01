Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFF7E0F6
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfHARV5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 13:21:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35001 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfHARV5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 13:21:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so36628294otq.2;
        Thu, 01 Aug 2019 10:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONDKKiCVIxrv79Fe4EJypm2SI1odtF39CM+MiqFDUUs=;
        b=BRpnJdJ5CiCDbJzilHwBl70VA+3u6o1DoYavTdwpN0cbNcM5MLn6lBBn0gi41ZHS71
         fWNb7S9MXdNEVWkfX/WYB15QrVf56O2j3d1g2RzYEApvHFOGRYUo0GMalW+xc0CjkZ1P
         BcaVVLqCbNX2JyQf9JY3Dc1uDN+a9X8vMFAWc1THaJLA0DF8RZiUAC9KAKkfmNB8vQWz
         vbFIn1jDDJJZ86FVUI9V8/9WkBHpnmq6A8a9dnF4Wcw0bwG4pqxq9NS9p4s0/q/ER4J6
         ggQK5yudFsffH/LuylVj3vhZwqI2DyTLrC5YSJVAIQsOxtM+D4aOZxEuf9nzupYr2Yh8
         +63w==
X-Gm-Message-State: APjAAAUYXDX4yFaKJomua8oYfCZLtFbYairnf+QqD8swcl9FOrMchqFA
        km+2/CzL07xj4uAb0zbwWBxkq9TZInMh4oY6Fqs=
X-Google-Smtp-Source: APXvYqyuyaONhATriUIvpzRyvAHuQcipIx3MF7QaOFWyyvWZCViadzdAlvjYDkBwEhh9cdRxeE+KKuFikcNj567QEzU=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr91002299otp.189.1564680115917;
 Thu, 01 Aug 2019 10:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <5d423637.1c69fb81.62114.ca6f@mx.google.com>
 <CAJZ5v0jkLXwqmXwyYtdZ9X2=W2KNKS4Ok_NrDew2yvvt1=4pgQ@mail.gmail.com> <5d4305df.1c69fb81.c4013.1950@mx.google.com>
In-Reply-To: <5d4305df.1c69fb81.c4013.1950@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Aug 2019 19:21:44 +0200
Message-ID: <CAJZ5v0hDE908XcreUyzZ8JGjFJbgVX1N1ELeMwf+n_ENxPA_DA@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 1, 2019 at 5:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-08-01 01:09:22)
> > On Thu, Aug 1, 2019 at 2:45 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Stephen Boyd (2019-07-31 16:45:31)
> > > >
> > > > This approach also nicely detects duplicate wakeup source names in the
> > > > case that the string passed in to wakeup_source_register() is already
> > > > used on the virtual bus.
> > >
> > > This was clearly untested! Here's a better one. This is what I see on my
> > > device with this patch squashed in:
> > >
> > > localhost ~ # cat /sys/kernel/debug/wakeup_sources
> > > name            active_count    event_count     wakeup_count    expire_count    active_since    total_time      max_time        last_change  prevent_suspend_time
> > > 1-1.2.4.1       0               0               0               0               0               0               0               0   0
> > > 1-1.1           0               0               0               0               0               0               0               0   0
> > > gpio-keys       0               0               0               0               0               0               0               0   0
> > > spi10.0         0               0               0               0               0               0               0               0   0
> > > a88000.spi:ec@0:keyboard-controller     0               0               0               0               0               0           0
> > >                 0               0
> > > alarmtimer      0               0               0               0               0               0               0               0   0
> > > cros-ec-rtc.1.auto      0               0               0               0               0               0               0           0
> > >                 0
> > > a8f8800.usb     0               0               0               0               0               0               0               0   0
> > > a6f8800.usb     0               0               0               0               0               0               0               0   0
> > > localhost ~ # ls -l /sys/class/wakeup/
> > > total 0
> > > lrwxrwxrwx. 1 root root 0 Jul 31 17:43 alarmtimer -> ../../devices/platform/soc/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/cros-ec-dev.0.auto/cros-ec-rtc.1.auto/rtc/rtc0/alarmtimer
> >
> > So why is this not "(...)rtc0/wakeup/alarmtimer" ?
> >
> > This particular bit looks kind of inconsistent.
>
> I believe this is the code you're looking for in drivers/base/core.c
>
>                 /*
>                  * If we have no parent, we live in "virtual".
>                  * Class-devices with a non class-device as parent, live
>                  * in a "glue" directory to prevent namespace collisions.
>                  */
>                 if (parent == NULL)
>                         parent_kobj = virtual_device_parent(dev);
>                 else if (parent->class && !dev->class->ns_type)
>                         return &parent->kobj;
>                 else
>                         parent_kobj = &parent->kobj;
>

OK, so it looks like there really is a little benefit from making the
device associated with the wakeup source be the parent of its virtual
dev.

> >
> > I guess without your patch you'd see "(...)rtc0/wakeup/wakeup0" instead, right?
>
> No, it would be rtc0/wakeup0. That's because rtc is a class, and rtc0 is
> part of that class, so we don't try to make a glue directory named after
> the class to avoid collisions (see class_dir_create_and_add()
> implementation).

That's not really consistent.

> BTW, paths in /sys/devices aren't supposed to matter too much. In this
> case, I'd expect to see userspace looking at the /sys/class/wakeup path
> to follow the symlink to figure out what device triggered a wakeup. It
> can look at the 'device' symlink inside the directory for the wakeup
> device to figure out which one it is.

But if you go from the device, it would be good to be able to figure
out which wakeup sources are associated with it and in the alarmtimer
example you don't even see that it is a wakeup source without
following the link.

So the "wakeupN" virtual dev names for all wakeup source objects are
less confusing IMO.

It would be good to avoid the glue dir creation in all cases somehow too.

> Final thought, might want to suppress the power directory from being
> created for the wakeup class. It looks odd to have
> /sys/class/wakeup/wakeup0/power when the presumably does nothing.

I agree and there is a flag for that IIRC.
