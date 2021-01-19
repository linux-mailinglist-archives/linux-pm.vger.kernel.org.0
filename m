Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D452FC14D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 21:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbhASUjf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 15:39:35 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:40479 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390848AbhASUjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 15:39:15 -0500
Received: by mail-ot1-f43.google.com with SMTP id i20so13344736otl.7;
        Tue, 19 Jan 2021 12:38:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6KlUQTbL5/2CJrk6DGIi6MNkCUnrcgjf32j2D+4yxc=;
        b=oJz2WGABUuMtAbox6dr0tywwxmS8DEE/x2jK8D5LU5lfsm2fb37mbpmIuDLLo/stcE
         A3GIhhMaxjiPk+4WuQ72oRkblQpJ5XQXvKcAZADwa3YJDDaOrXjpcl3pxoLxxl+ItJmf
         8xUCW0ZK3v4YvRbJpaSpEuSrkMKEhapjRpjTF0Ceitu4kAeS7hTGjz21dcDYJt4wzeq7
         /fphW6fsth7GJD70A1tp7bdpwBk2VroRligjGabH5VHNcTWVHwAuFbtbnE20qchFZd1R
         +96rtCc9HvBUpIW8u7vfwG+7YZkORvwtMO4eVcmG1GsSmSCYV1wiu6VsvUqarFxbOEL6
         gAHA==
X-Gm-Message-State: AOAM532r/Z15TAe20DAHp2ilSEajBo82WZXuB3lPSrEJpDHv1ugkqOCn
        S1TozgD3v4o9mj6R+Q99b8ps6FPvQSpCDbPqKpo=
X-Google-Smtp-Source: ABdhPJxl03WOXFvPzSSYHzpFyncD90OOeEjxfMP5di575EDj6nmUS4boaQpGTbw2kJnSah97l4Lj3BPmbohRENirgGM=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr4738858oth.250.1611088713849;
 Tue, 19 Jan 2021 12:38:33 -0800 (PST)
MIME-Version: 1.0
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz> <7him7sydd6.fsf@baylibre.com>
In-Reply-To: <7him7sydd6.fsf@baylibre.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jan 2021 21:38:22 +0100
Message-ID: <CAMuHMdX8T+tO-sT_tgrgEi-D0z2ac7k4Atg13arHN5bA84HqTA@mail.gmail.com>
Subject: Re: [PATCH] PM / clk: make PM clock layer compatible with clocks that
 must sleep
To:     Kevin Hilman <khilman@baylibre.com>,
        Nicolas Pitre <npitre@baylibre.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kevin, Nicolas,

On Tue, Jan 19, 2021 at 7:45 PM Kevin Hilman <khilman@baylibre.com> wrote:
> [ + Geert.. renesas SoCs are the primary user of PM clk ]

Thanks!

> Nicolas Pitre <npitre@baylibre.com> writes:
> > The clock API splits its interface into sleepable ant atomic contexts:
> >
> > - clk_prepare/clk_unprepare for stuff that might sleep
> >
> > - clk_enable_clk_disable for anything that may be done in atomic context
> >
> > The code handling runtime PM for clocks only calls clk_disable() on
> > suspend requests, and clk_enable on resume requests. This means that
> > runtime PM with clock providers that only have the prepare/unprepare
> > methods implemented is basically useless.
> >
> > Many clock implementations can't accommodate atomic contexts. This is
> > often the case when communication with the clock happens through another
> > subsystem like I2C or SCMI.
> >
> > Let's make the clock PM code useful with such clocks by safely invoking
> > clk_prepare/clk_unprepare upon resume/suspend requests. Of course, when
> > such clocks are registered with the PM layer then pm_runtime_irq_safe()
> > can't be used, and neither pm_runtime_suspend() nor pm_runtime_resume()
> > may be invoked in atomic context.
> >
> > For clocks that do implement the enable and disable methods then
> > everything just works as before.
> >
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

Thanks for your patch!

> > --- a/drivers/base/power/clock_ops.c
> > +++ b/drivers/base/power/clock_ops.c

> > +/**
> > + * pm_clk_op_lock - ensure exclusive access for performing clock operations.
> > + * @psd: pm_subsys_data instance corresponding to the PM clock entry list
> > + *    and clk_op_might_sleep count being used.
> > + * @flags: stored irq flags.
> > + * @fn: string for the caller function's name.
> > + *
> > + * This is used by pm_clk_suspend() and pm_clk_resume() to guard
> > + * against concurrent modifications to the clock entry list and the
> > + * clock_op_might_sleep count. If clock_op_might_sleep is != 0 then
> > + * only the mutex can be locked and those functions can only be used in
> > + * non atomic context. If clock_op_might_sleep == 0 then these functions
> > + * may be used in any context and only the spinlock can be locked.
> > + * Returns -EINVAL if called in atomic context when clock ops might sleep.
> > + */
> > +static int pm_clk_op_lock(struct pm_subsys_data *psd, unsigned long *flags,
> > +                       const char *fn)
> > +{
> > +     bool atomic_context = in_atomic() || irqs_disabled();

Is this safe? Cfr.
https://lore.kernel.org/dri-devel/20200914204209.256266093@linutronix.de/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
