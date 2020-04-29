Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D821BDA80
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD2LVG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 07:21:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42957 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgD2LVG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 07:21:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so1326432otq.9
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 04:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7m1kGugjYclGreChYlr0lfJicdbj5G2Eja3HF0kMo1w=;
        b=X8rVL7BtBPjA7dtL0b0m0NUqE8V25renGy5JGODSGWdnTpSN+O4y3fwgLfDMwDiY2r
         ICBrJ7AfgqaJr/BmwcLnMAuLyIHSeFg0Yk8QTWWNtfRZ/II8OmkF3Sj9G0COajslcrs9
         xoQiMoLAeIBiyVnTQ7vmRB3XLWxRpkEy+QYu9M6NPDvkPLjfyEcHurDn91NL1+uW9X9m
         fDexTpUMaaGI1n6gzFw0je7HWzggDRvejDq4EdylDqc8ANlNSfdOSTt/W1QS0QsHITkz
         KaaoISDA/XQiIC5qQWTg4MOxT1T6wh6FdR8elKlRT7MTzYDVhGdJN9h5dZBS/Il6BSan
         +IgQ==
X-Gm-Message-State: AGi0PuYMWKbPZmrHy3s/1RCk515sTZt7iVZGMdLMpq/2Gy9wyIopcTjV
        6iA9ieoCUL/XLZWCmccbE+2f6P/ovLR5xtjB13hP8R2V
X-Google-Smtp-Source: APiQypJTw7EZVkzNZHhkxLiM+8S0h4N0nddO0cJfOCckQl/hfnGHodkB3pr6OyvT9ybOmaHxtLEVpF8ixOpqeNrBm0Q=
X-Received: by 2002:a05:6830:18d0:: with SMTP id v16mr25030961ote.118.1588159265260;
 Wed, 29 Apr 2020 04:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200413190843.044112674@gmail.com> <20200413193718.956985775@gmail.com>
 <4068729.AMvo8hvaBI@kreacher> <20200427094840.GA29259@dumbo>
In-Reply-To: <20200427094840.GA29259@dumbo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Apr 2020 13:20:53 +0200
Message-ID: <CAJZ5v0hbE3Gswp_Wp4QQTb8wuaAOGQrWNEa7Utg45wR50QN0QQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] uswsusp: build only when configured
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 27, 2020 at 11:48 AM Domenico Andreoli
<domenico.andreoli@linux.com> wrote:
>
> On Sun, Apr 26, 2020 at 06:16:29PM +0200, Rafael J. Wysocki wrote:
> > On Monday, April 13, 2020 9:08:45 PM CEST Domenico Andreoli wrote:
> > > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > >
> > > uswsusp is no longer the preferred way to suspend/hibernate and the
> > > userspace tools have not received any update in years.
> > >
> > > Make it possible to enable the uswsusp support only if needed, prepare
> > > for future phase out.
> > >
> > > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Linux PM <linux-pm@vger.kernel.org>
> > >
> > > ---
> > >  kernel/power/Kconfig  |    5 +++++
> > >  kernel/power/Makefile |    3 ++-
> > >  kernel/power/power.h  |    5 +++++
> > >  3 files changed, 12 insertions(+), 1 deletion(-)
> > >
> > > Index: b/kernel/power/Kconfig
> > > ===================================================================
> > > --- a/kernel/power/Kconfig
> > > +++ b/kernel/power/Kconfig
> > > @@ -80,6 +80,11 @@ config HIBERNATION
> > >
> > >       For more information take a look at <file:Documentation/power/swsusp.rst>.
> > >
> > > +config HIBERNATION_USER
> > > +   bool "Userspace software suspend interface (DEPRECATED)"
> > > +   depends on HIBERNATION
> > > +   default n
> >
> > This needs to be "default y" for the time being.
> >
> > Also, I would call the option HIBERNATION_SNAPSHOT_DEV, because it effectively
> > controls whether or not the snapshot device is available.
> >
> > > +
> > >  config PM_STD_PARTITION
> > >     string "Default resume partition"
> > >     depends on HIBERNATION
> > > Index: b/kernel/power/Makefile
> > > ===================================================================
> > > --- a/kernel/power/Makefile
> > > +++ b/kernel/power/Makefile
> > > @@ -10,7 +10,8 @@ obj-$(CONFIG_VT_CONSOLE_SLEEP)    += consol
> > >  obj-$(CONFIG_FREEZER)              += process.o
> > >  obj-$(CONFIG_SUSPEND)              += suspend.o
> > >  obj-$(CONFIG_PM_TEST_SUSPEND)      += suspend_test.o
> > > -obj-$(CONFIG_HIBERNATION)  += hibernate.o snapshot.o swap.o user.o
> > > +obj-$(CONFIG_HIBERNATION)  += hibernate.o snapshot.o swap.o
> > > +obj-$(CONFIG_HIBERNATION_USER)     += user.o
> > >  obj-$(CONFIG_PM_AUTOSLEEP) += autosleep.o
> > >  obj-$(CONFIG_PM_WAKELOCKS) += wakelock.o
> > >
> > > Index: b/kernel/power/power.h
> > > ===================================================================
> > > --- a/kernel/power/power.h
> > > +++ b/kernel/power/power.h
> > > @@ -158,8 +158,13 @@ extern sector_t alloc_swapdev_block(int
> > >  extern void free_all_swap_pages(int swap);
> > >  extern int swsusp_swap_in_use(void);
> > >
> > > +#ifdef CONFIG_HIBERNATION_USER
> > >  bool swsusp_try_enter(void);
> > >  void swsusp_leave(void);
> > > +#else
> > > +static inline bool swsusp_try_enter(void) { return 1; }
> > > +static inline void swsusp_leave(void) {}
> > > +#endif
> >
> > It is possible in theory that two processes write "disk" to /sys/power/state
> > concurrently.
> >
> > Is there enough mutual exclusion in place to handle this gracefully after the
> > above change?
>
> No, indeed.
>
> It looks like hibernate.c needs the mutual exclusion and user.c could
> just use it. Should I move snapshot_device_available to hibernate.c
> and rename it hibernate_available?

There is hibernation_available() already.

Maybe switch over to the refcount_t API, call the variable
hibernate_refcount and use refcount_add_not_zero() on it for the
mutual exclusion.
