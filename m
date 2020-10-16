Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2944E29063B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 15:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407057AbgJPNYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 09:24:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36385 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406421AbgJPNYf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 09:24:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id u17so2419165oie.3;
        Fri, 16 Oct 2020 06:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTPwgrPwjHomsro8IxSQHLddbBYd6O1DwuH3s3n9rhA=;
        b=NIwCZ7IE9mF1F/WAxtglOOrH75nDEi+X3IpnRhtfddkaa/KZ0FSgIS+tibz6+UsEbd
         2OfqgvQBHWrzvjRa1HhZ/Gu17XYg5kcHh0/Fu961bgVJhNJE6RyK19T8/UJXGmedPDjS
         HwzEGc6HqUbZ1TkygEmc3elrQe7+ns5kmfx10jZXhvjckcH2tvmUe21TcSvUSqISOTpA
         on/NYQmgolOCYTW5/pVuj2AmkUsWIlIAABs+ovLBcqqkaJHjA8TK5U/XpEMK0U4TPHGo
         8Bmh0T8b36xxIdHEdshANPd127fHm25YgQRyB01peKv11qXuqXiE/UrbWwMdYyd4Dymb
         nHxA==
X-Gm-Message-State: AOAM533/I63yR1FrVc5bKXkFOYTKN1LXLiVercRz6jCdMwuJoaCXduDE
        BGNOSCNZdRazzGZfgLvKfSWgAqY4ny+lBj2PBmA=
X-Google-Smtp-Source: ABdhPJzqUWcXR9slVTjUfSdAetE9SrBukTuLwabYm+efn3iS5ECB3bhpkhxe0DJKvRDbb5U5SVAlKLvlxEFnAC0R5JU=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2456721oic.157.1602854674830;
 Fri, 16 Oct 2020 06:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cafee605b1c9a745@google.com>
In-Reply-To: <000000000000cafee605b1c9a745@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 15:24:23 +0200
Message-ID: <CAJZ5v0gFpt-N-VdwWLr0qkST3Tojxr3-t0BS35rcJxxV00fcCg@mail.gmail.com>
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
To:     josephjang@google.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, jonglin@google.com,
        woodylin@google.com, markcheng@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 3:22 PM <josephjang@google.com> wrote:
>
> Thank you Rafael's promptly response.
>
> > On Fri, Oct 16, 2020 at 5:51 AM Joseph Jang <josephjang@google.com> wrote:
> > >
> > > From: josephjang <josephjang@google.com>
> > >
> > > Add suspend timeout handler to prevent device stuck during suspend/
> > > resume process. Suspend timeout handler will dump disk sleep task
> > > at first round timeout and trigger kernel panic at second round timeout.
> > > The default timer for each round is 30 seconds.
> > >
> > > Note: Can use following command to simulate suspend hang for testing.
> > >     adb shell echo 1 > /sys/power/pm_hang
> > >     adb shell echo mem > /sys/power/state
> > > Signed-off-by: josephjang <josephjang@google.com>
> > > ---
> > >  include/linux/console.h |   1 +
> > >  kernel/power/Kconfig    |   9 +++
> > >  kernel/power/main.c     |  66 ++++++++++++++++
> > >  kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++++++
> > >  kernel/printk/printk.c  |   5 ++
> > >  5 files changed, 243 insertions(+)
> > >
> > > diff --git a/include/linux/console.h b/include/linux/console.h
> > > index 0670d3491e0e..ac468c602c0b 100644
> > > --- a/include/linux/console.h
> > > +++ b/include/linux/console.h
> > > @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
> > >  { }
> > >  #endif
> > >  extern bool console_suspend_enabled;
> > > +extern int is_console_suspended(void);
> > >
> > >  /* Suspend and resume console messages over PM events */
> > >  extern void suspend_console(void);
> > > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > > index a7320f07689d..52b7a181b6d8 100644
> > > --- a/kernel/power/Kconfig
> > > +++ b/kernel/power/Kconfig
> > > @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
> > >         def_bool y
> > >         depends on PM_DEBUG && PM_SLEEP
> > >
> > > +config PM_SLEEP_MONITOR
> > > +       bool "Linux kernel suspend/resume process monitor"
> > > +       depends on PM_SLEEP
> > > +       help
> > > +       This option will enable suspend/resume monitor to prevent device
> > > +       stuck during suspend/resume process. Suspend timeout handler
> > will
> > > +       dump disk sleep task at first round timeout and trigger kernel
> > panic
> > > +       at second round timeout. The default timer for each round is 30
> > seconds.
> > > +
>
> > The facility associated with the Kconfig entry right below is supposed
> > to do exactly the same thing.
>
> > What's the reason to add another one?  What is missing?
>
>
>
> > >  config DPM_WATCHDOG
> > >         bool "Device suspend/resume watchdog"
> > >         depends on PM_DEBUG && PSTORE && EXPERT
>
> Because we found some suspend hand issue that cannot be detected by
> "CONFIG_DPM_WATCHDOG" (which is focus on device PM).

What's that issue?

> Our suspend timeout monitor can cover PM core and Device PM hang issues.

Then I'd suggest to extend the existing watchdog instead of adding a
whole new implementation.
