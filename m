Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DDD300828
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 17:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbhAVQEA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 11:04:00 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43103 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbhAVQDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 11:03:45 -0500
Received: by mail-ot1-f52.google.com with SMTP id v1so5501852ott.10;
        Fri, 22 Jan 2021 08:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZXt3LPjp06oNUnJDeoDXc8Gsk/FMkSs1QZqQ06tFM4=;
        b=VKBGR1h6ci6j9cDUJk4v2aFaGKT025l/14M5T1UQSe4mUdC7QQCMXBQOmPy38qbrjX
         jgmwgMADS2lPW6o63J/5ASR1YdR6v4MFx5hbZ5Lv1XAsop1AXrUaPOg3d3YJeCaD4eOJ
         AHYHh/0JB6SwEuJ85/hqdXG1G8V/9mnMcpNpvM8tnNHyqdtGloW1Z9qv9Q/n0R202ZUF
         2rMs5eMg4OzAhlPdcaEr0q46ISq4H/p67PyYX0o8JVb0ERryFGSrVfJfJtc4ejXlLm2y
         z5bvp9HucWg7N0HwkBEZmDP0GOA3QSomT989zOwMwjjO9QdkWhMhFS+JIowrvEM2cmBC
         113A==
X-Gm-Message-State: AOAM5320jePDqiRNSGaTGzadSmqmr3JHoU9nn0VxRDr7whXWAHVUJfSw
        Oz/pP5rlNZ3nHyfrihcPDa/1mTW+55yde6i633Y=
X-Google-Smtp-Source: ABdhPJwPlqEb4HShYX56M/xSFCnI33iv6UVQbwalZkDHIh9m6GgnDlvU01gnMmft+b4AaYEUf3Uiub8XLGXz+puMstE=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr3937315otk.206.1611331369485;
 Fri, 22 Jan 2021 08:02:49 -0800 (PST)
MIME-Version: 1.0
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
 <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com>
 <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com>
 <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
 <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com>
 <84r6s34s-opq7-9358-o45n-27s17084012@onlyvoer.pbz> <CAJZ5v0jUxonxp0q80Kdcbax+WMmh-NZ_h=KQG-HcfFdE1hr4VA@mail.gmail.com>
 <CAJZ5v0hj4VC_kjB5e_b_ho=ET_quG5zUh0Dbbdwofp-6azopsw@mail.gmail.com>
 <CA+G9fYsRVxWPW1nvSXMTLWfEadrdBDSH5hRPtoUYpfpqq8zRSw@mail.gmail.com>
 <CAJZ5v0gsYb1uxDUTHUe539w8uXhk=m337Xn6wtPhF1oPKzaYrQ@mail.gmail.com> <30np982n-r2q8-8532-q6os-9p9729ppos45@syhkavp.arg>
In-Reply-To: <30np982n-r2q8-8532-q6os-9p9729ppos45@syhkavp.arg>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 17:02:38 +0100
Message-ID: <CAJZ5v0iNtmXWr3uXzit5Er_j7G=LkGVyhdNAsjwpVWsDy8F7KQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM / clk: make PM clock layer compatible with clocks
 that must sleep
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, Jan 22, 2021 at 4:59 PM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Fri, 22 Jan 2021, Rafael J. Wysocki wrote:
>
> > On Fri, Jan 22, 2021 at 4:48 PM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Fri, 22 Jan 2021 at 20:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Jan 21, 2021 at 8:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Jan 21, 2021 at 6:23 PM Nicolas Pitre <npitre@baylibre.com> wrote:
> > > > > >
> > > > > > The clock API splits its interface into sleepable ant atomic contexts:
> > > > > >
> > > > > > - clk_prepare/clk_unprepare for stuff that might sleep
> > > > > >
> > > > > > - clk_enable_clk_disable for anything that may be done in atomic context
> > > > > >
> > > > > > The code handling runtime PM for clocks only calls clk_disable() on
> > > > > > suspend requests, and clk_enable on resume requests. This means that
> > > > > > runtime PM with clock providers that only have the prepare/unprepare
> > > > > > methods implemented is basically useless.
> > > > > >
> > > > > > Many clock implementations can't accommodate atomic contexts. This is
> > > > > > often the case when communication with the clock happens through another
> > > > > > subsystem like I2C or SCMI.
> > > > > >
> > > > > > Let's make the clock PM code useful with such clocks by safely invoking
> > > > > > clk_prepare/clk_unprepare upon resume/suspend requests. Of course, when
> > > > > > such clocks are registered with the PM layer then pm_runtime_irq_safe()
> > > > > > can't be used, and neither pm_runtime_suspend() nor pm_runtime_resume()
> > > > > > may be invoked in atomic context.
> > > > > >
> > > > > > For clocks that do implement the enable and disable methods then
> > > > > > everything just works as before.
> > > > > >
> > > > > > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > > > > >
> > > > > > ---
> > > > > >
> > > > > > On Thu, 21 Jan 2021, Rafael J. Wysocki wrote:
> > > > > >
> > > > > > > So I'm going to drop this patch from linux-next until the issue is
> > > > > > > resolved, thanks!
> > > > > >
> > > > > > Here's the fixed version.
> > > > >
> > > > > Applied instead of the v1, thanks!
> > > > >
> > > > > > Changes from v1:
> > > > > >
> > > > > > - Moved clk_is_enabled_when_prepared() declaration under
> > > > > >   CONFIG_HAVE_CLK_PREPARE and provided a dummy definition when that
> > > > > >   config option is unset.
> > > > > >
> > > > > > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> > > > > > index ced6863a16..a62fb0f9b1 100644
> > > > > > --- a/drivers/base/power/clock_ops.c
> > > > > > +++ b/drivers/base/power/clock_ops.c
> > > > > > @@ -23,6 +23,7 @@
> > > > > >  enum pce_status {
> > > > > >         PCE_STATUS_NONE = 0,
> > > > > >         PCE_STATUS_ACQUIRED,
> > > > > > +       PCE_STATUS_PREPARED,
> > > > > >         PCE_STATUS_ENABLED,
> > > > > >         PCE_STATUS_ERROR,
> > > > > >  };
> > > > > > @@ -32,8 +33,102 @@ struct pm_clock_entry {
> > > > > >         char *con_id;
> > > > > >         struct clk *clk;
> > > > > >         enum pce_status status;
> > > > > > +       bool enabled_when_prepared;
> > > > > >  };
> > > > > >
> > > > > > +/**
> > > > > > + * pm_clk_list_lock - ensure exclusive access for modifying the PM clock
> > > > > > + *                   entry list.
> > > > > > + * @psd: pm_subsys_data instance corresponding to the PM clock entry list
> > > > > > + *      and clk_op_might_sleep count to be modified.
> > > > > > + *
> > > > > > + * Get exclusive access before modifying the PM clock entry list and the
> > > > > > + * clock_op_might_sleep count to guard against concurrent modifications.
> > > > > > + * This also protects against a concurrent clock_op_might_sleep and PM clock
> > > > > > + * entry list usage in pm_clk_suspend()/pm_clk_resume() that may or may not
> > > > > > + * happen in atomic context, hence both the mutex and the spinlock must be
> > > > > > + * taken here.
> > > > > > + */
> > > > > > +static void pm_clk_list_lock(struct pm_subsys_data *psd)
> > > > > > +{
> > > > > > +       mutex_lock(&psd->clock_mutex);
> > > > > > +       spin_lock_irq(&psd->lock);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * pm_clk_list_unlock - counterpart to pm_clk_list_lock().
> > > > > > + * @psd: the same pm_subsys_data instance previously passed to
> > > > > > + *      pm_clk_list_lock().
> > > > > > + */
> > > > > > +static void pm_clk_list_unlock(struct pm_subsys_data *psd)
> > > >
> > > > Locking annotations for sparse were missing here and above, so I've
> > > > added them by hand.
> > > >
> > > > Please double check the result in my linux-next branch (just pushed).
> > >
> > > May i request to add Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > If this had been a patch fixing a problem reported by you, there would
> > have been a reason to add a Reported-by,
> >
> > In this case, it is just a new version of a patch taking your testing
> > feedback into account.
> >
> > I can add a Tested-by for you to it if desired, though.
>
> It is probably fair to mention that Naresh reported the issue too.
> My bad, I should have added the tag myself in v2.

OK

I'm assuming that there will be a v3 because of the sparse warnings,
so please add the tags as needed when posting it.
