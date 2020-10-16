Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58180290640
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407424AbgJPNZ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407999AbgJPNZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 09:25:54 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EA8C0613D3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 06:25:52 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d15so1896078ybl.10
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iCwkZaf/CJExTKItTZS0YUHQy3kQsNwhFTOhb5qzSos=;
        b=g+yeeBwCIOWo9vWLkEL/f5NhXHhQfSFeC/5mD2L53//eLKECA2+BWR7+l/YKdht24H
         NcBn9VzALomR1qu3gKMKtoPSUKEEH88Rj3ZKv0kQnqes0ZJZOmirxLIM9Ka/f7L4Scji
         HefVOlJV5sT4GsLUTN9j/XNqJ5XLaKKuKMo27LZGN2ZhgEL1iLrVxL942Dk5EzHpVJ9J
         zroPKpl4EGYv9VhqZ9Scwplt48ovEvu35lcVE2hOEwblcxXL3HI4MqHXSjAQcNKaHWor
         0iuhv36rf9rrGsykcEwODK5CiK9b3KrFtkMNlfGHiVcTDDTQB0mofE8uBk6mZermItrk
         nO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iCwkZaf/CJExTKItTZS0YUHQy3kQsNwhFTOhb5qzSos=;
        b=ra7eS+sDaEGIMlhxm8MvFDq+HH1tbb0Kteg38vR38Ztm4e91k4dwKuAu73vvpR87mQ
         jKF5VTMx14CT1BZOvIm5znGDc8B5DTS4EEs2Jnh+WKvgrmDMGB4f5dCHPx6kvWStPCz6
         jnGOij0S0bGBuMTdjU86+fOCKVV3QnuUAfXsbx3eOOO2+Rd2MRnl1ajIJXvQcos5poby
         2XRoR8v16wO1AJErFersHkhNjzkgl0DpEVluSp0KMl4D0GEoqgmPry/Lgm1tVYu7vn5L
         TGYucOh6+83GfC7CKZLOGzQve64BqQQIYVanynxM3nixOH0PEuTLY5I1P+8QNUBPp8jo
         Lzng==
X-Gm-Message-State: AOAM531Fi5gVOypW3/HkpsT+RPyl1Auf9tnyUdfF8ACCYYXRQjQWgcrH
        qJDn6LM6CN7zV4K5bhlzR5+bRxHxCwgL1SVSwpNGLg==
X-Google-Smtp-Source: ABdhPJzy80GNTSODpCrlrVYYRB+McjTIHkBKpwU0lfkrRyF1AAgpJ7bpr7NU3lGt7qJHLWV8Jyd9OOdkgmBImj725PM=
X-Received: by 2002:a25:7542:: with SMTP id q63mr5086409ybc.176.1602854751196;
 Fri, 16 Oct 2020 06:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cafee605b1c9a745@google.com> <CAJZ5v0gFpt-N-VdwWLr0qkST3Tojxr3-t0BS35rcJxxV00fcCg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gFpt-N-VdwWLr0qkST3Tojxr3-t0BS35rcJxxV00fcCg@mail.gmail.com>
From:   Joseph Jang <josephjang@google.com>
Date:   Fri, 16 Oct 2020 21:25:40 +0800
Message-ID: <CAPaOXESgeK9oJB_0fRVqZQFQWQKJ=Y-L7TAX2oBkLR4cv3Z7bQ@mail.gmail.com>
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonglin Lee <jonglin@google.com>,
        Woody Lin <woodylin@google.com>,
        Mark Cheng <markcheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Yes, I agree.

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:24=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Fri, Oct 16, 2020 at 3:22 PM <josephjang@google.com> wrote:
> >
> > Thank you Rafael's promptly response.
> >
> > > On Fri, Oct 16, 2020 at 5:51 AM Joseph Jang <josephjang@google.com> w=
rote:
> > > >
> > > > From: josephjang <josephjang@google.com>
> > > >
> > > > Add suspend timeout handler to prevent device stuck during suspend/
> > > > resume process. Suspend timeout handler will dump disk sleep task
> > > > at first round timeout and trigger kernel panic at second round tim=
eout.
> > > > The default timer for each round is 30 seconds.
> > > >
> > > > Note: Can use following command to simulate suspend hang for testin=
g.
> > > >     adb shell echo 1 > /sys/power/pm_hang
> > > >     adb shell echo mem > /sys/power/state
> > > > Signed-off-by: josephjang <josephjang@google.com>
> > > > ---
> > > >  include/linux/console.h |   1 +
> > > >  kernel/power/Kconfig    |   9 +++
> > > >  kernel/power/main.c     |  66 ++++++++++++++++
> > > >  kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++=
++++
> > > >  kernel/printk/printk.c  |   5 ++
> > > >  5 files changed, 243 insertions(+)
> > > >
> > > > diff --git a/include/linux/console.h b/include/linux/console.h
> > > > index 0670d3491e0e..ac468c602c0b 100644
> > > > --- a/include/linux/console.h
> > > > +++ b/include/linux/console.h
> > > > @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
> > > >  { }
> > > >  #endif
> > > >  extern bool console_suspend_enabled;
> > > > +extern int is_console_suspended(void);
> > > >
> > > >  /* Suspend and resume console messages over PM events */
> > > >  extern void suspend_console(void);
> > > > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > > > index a7320f07689d..52b7a181b6d8 100644
> > > > --- a/kernel/power/Kconfig
> > > > +++ b/kernel/power/Kconfig
> > > > @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
> > > >         def_bool y
> > > >         depends on PM_DEBUG && PM_SLEEP
> > > >
> > > > +config PM_SLEEP_MONITOR
> > > > +       bool "Linux kernel suspend/resume process monitor"
> > > > +       depends on PM_SLEEP
> > > > +       help
> > > > +       This option will enable suspend/resume monitor to prevent d=
evice
> > > > +       stuck during suspend/resume process. Suspend timeout handle=
r
> > > will
> > > > +       dump disk sleep task at first round timeout and trigger ker=
nel
> > > panic
> > > > +       at second round timeout. The default timer for each round i=
s 30
> > > seconds.
> > > > +
> >
> > > The facility associated with the Kconfig entry right below is suppose=
d
> > > to do exactly the same thing.
> >
> > > What's the reason to add another one?  What is missing?
> >
> >
> >
> > > >  config DPM_WATCHDOG
> > > >         bool "Device suspend/resume watchdog"
> > > >         depends on PM_DEBUG && PSTORE && EXPERT
> >
> > Because we found some suspend hand issue that cannot be detected by
> > "CONFIG_DPM_WATCHDOG" (which is focus on device PM).
>
> What's that issue?
>
> > Our suspend timeout monitor can cover PM core and Device PM hang issues=
.
>
> Then I'd suggest to extend the existing watchdog instead of adding a
> whole new implementation.



--=20
Embedded Software engineer
