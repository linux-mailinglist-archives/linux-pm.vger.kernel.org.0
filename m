Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCEE3006C4
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbhAVPKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:10:19 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46888 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbhAVPKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 10:10:10 -0500
Received: by mail-oi1-f180.google.com with SMTP id q205so6224070oig.13;
        Fri, 22 Jan 2021 07:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNQSppSfSvMROzk8r+0lEH5X+aKm+/SWh2+D0nHCMMQ=;
        b=ph96d9IyP4epiwjkryjXR4kq6qKa/BRBG0B2jatDiufxIe8z9OsbyLSdJcurOItNrb
         nLcE9LV3lcDn22mNomRADqdxSTDbEDMyfcSJfhmtFwXx6L3Dr3zky29VxabZ+I7Gv+Ie
         axv/TAEX70Y7SqSspHBCOM6B6N+DhCpH0j99auQVCrowShiJAPVDQ9586r9XAa+Dijql
         wfEtRGTyTjGCdlRlFgtWTd+3JMNSi+aB0cRHEXXtjWpyXDUlak6lUcTv3UwlCJrOUs6n
         TNPCoSEwWbqTtelPbwrYIqTZ0zyXkoXg8/VzOhaA5HubPVL4jxrT7tJgVQehLtWM7bYs
         DJvg==
X-Gm-Message-State: AOAM5322hY9kAMtnQseoclQ8mV4DLW0iFeWugjot1NCKegH7ujBgOR9O
        Pr56cuVoKIbY9mmjxGc4eGr5sRBwHOdAoZXOquA=
X-Google-Smtp-Source: ABdhPJxQ+6ZtpUYYuPp/QZRC1FJcmNKDTQ3vozJ+xFy+5ekP+/0fwNNpaRCbqCWuRk7khSbytGCEogB5Ut4rKBc7zxk=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr3571826oii.71.1611328168714;
 Fri, 22 Jan 2021 07:09:28 -0800 (PST)
MIME-Version: 1.0
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
 <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com>
 <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com>
 <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
 <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com>
 <84r6s34s-opq7-9358-o45n-27s17084012@onlyvoer.pbz> <CAJZ5v0jUxonxp0q80Kdcbax+WMmh-NZ_h=KQG-HcfFdE1hr4VA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jUxonxp0q80Kdcbax+WMmh-NZ_h=KQG-HcfFdE1hr4VA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:09:17 +0100
Message-ID: <CAJZ5v0hj4VC_kjB5e_b_ho=ET_quG5zUh0Dbbdwofp-6azopsw@mail.gmail.com>
Subject: Re: [PATCH v2] PM / clk: make PM clock layer compatible with clocks
 that must sleep
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Nicolas Pitre <npitre@baylibre.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 21, 2021 at 8:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 21, 2021 at 6:23 PM Nicolas Pitre <npitre@baylibre.com> wrote:
> >
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
> >
> > ---
> >
> > On Thu, 21 Jan 2021, Rafael J. Wysocki wrote:
> >
> > > So I'm going to drop this patch from linux-next until the issue is
> > > resolved, thanks!
> >
> > Here's the fixed version.
>
> Applied instead of the v1, thanks!
>
> > Changes from v1:
> >
> > - Moved clk_is_enabled_when_prepared() declaration under
> >   CONFIG_HAVE_CLK_PREPARE and provided a dummy definition when that
> >   config option is unset.
> >
> > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> > index ced6863a16..a62fb0f9b1 100644
> > --- a/drivers/base/power/clock_ops.c
> > +++ b/drivers/base/power/clock_ops.c
> > @@ -23,6 +23,7 @@
> >  enum pce_status {
> >         PCE_STATUS_NONE = 0,
> >         PCE_STATUS_ACQUIRED,
> > +       PCE_STATUS_PREPARED,
> >         PCE_STATUS_ENABLED,
> >         PCE_STATUS_ERROR,
> >  };
> > @@ -32,8 +33,102 @@ struct pm_clock_entry {
> >         char *con_id;
> >         struct clk *clk;
> >         enum pce_status status;
> > +       bool enabled_when_prepared;
> >  };
> >
> > +/**
> > + * pm_clk_list_lock - ensure exclusive access for modifying the PM clock
> > + *                   entry list.
> > + * @psd: pm_subsys_data instance corresponding to the PM clock entry list
> > + *      and clk_op_might_sleep count to be modified.
> > + *
> > + * Get exclusive access before modifying the PM clock entry list and the
> > + * clock_op_might_sleep count to guard against concurrent modifications.
> > + * This also protects against a concurrent clock_op_might_sleep and PM clock
> > + * entry list usage in pm_clk_suspend()/pm_clk_resume() that may or may not
> > + * happen in atomic context, hence both the mutex and the spinlock must be
> > + * taken here.
> > + */
> > +static void pm_clk_list_lock(struct pm_subsys_data *psd)
> > +{
> > +       mutex_lock(&psd->clock_mutex);
> > +       spin_lock_irq(&psd->lock);
> > +}
> > +
> > +/**
> > + * pm_clk_list_unlock - counterpart to pm_clk_list_lock().
> > + * @psd: the same pm_subsys_data instance previously passed to
> > + *      pm_clk_list_lock().
> > + */
> > +static void pm_clk_list_unlock(struct pm_subsys_data *psd)

Locking annotations for sparse were missing here and above, so I've
added them by hand.

Please double check the result in my linux-next branch (just pushed).

Thanks!

> > +{
> > +       spin_unlock_irq(&psd->lock);
> > +       mutex_unlock(&psd->clock_mutex);
> > +}
