Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C885F2FED46
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 15:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbhAUOpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 09:45:47 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:43676 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbhAUOpc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 09:45:32 -0500
Received: by mail-oo1-f54.google.com with SMTP id y14so544464oom.10;
        Thu, 21 Jan 2021 06:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5jdvvWEwgNFSV1EO/moduPbzx68vOpeI3wGza6ZRNs=;
        b=L2mSAoTNaUrr70WaFGcLDIHC7D0urpRm7Ef9NRE4OYiavUSVafwvTe0BTotQ07sypa
         dlNcJxIEd99fcv1EG8kGIASb06I3QagTdmxCDzsLF+aDIE/1yQBlDZhFGo2gM+qeUbHi
         bq+IYTntQscl7MFCcYif7gmxpIkmJ8rqgo+zQRVgt+aAKgblMCAjlaQ5wEMayO85cwVt
         wq//5V39ajjNAfYVZkpycfKbNsUciBxlATNG2acQag8W9ltfGDrjvJJ85XVuU9Xyy6AI
         YdonI5MeXstxQzThkj+IR/lo4+1Uc3JppGqB/DAx82w3bjAh0+Uh1hrGCQiphL/RqEzm
         Nr3Q==
X-Gm-Message-State: AOAM531YTMu5zsZj3A8XOGtnXiL4cSr+z/KnFGtW6zsMjXWqLM3ChDh2
        in9+iC7XqFqid9osl9sbDAi94FwnBADNqGw4W2Y=
X-Google-Smtp-Source: ABdhPJz61fItLIccZEjHhNtKpcqGSx4IHgJ29Wilse3walTqUNTCCSTc27NL1zFGK+jamMrtant9lK3Cd7FH5yCrMNo=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr9798920ooi.44.1611240287043;
 Thu, 21 Jan 2021 06:44:47 -0800 (PST)
MIME-Version: 1.0
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
 <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com>
 <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com> <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
In-Reply-To: <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jan 2021 15:44:35 +0100
Message-ID: <CAJZ5v0hFjpGp2GbV1Evi+BbUF7Am4ETY4Cm8VzTrvTJ=7=oyPQ@mail.gmail.com>
Subject: Re: [PATCH] PM / clk: make PM clock layer compatible with clocks that
 must sleep
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas Pitre <npitre@baylibre.com>,
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

On Thu, Jan 21, 2021 at 1:11 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Thu, 21 Jan 2021 at 16:28, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > On Thu, Jan 21, 2021 at 10:13 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > > On Tue, 5 Jan 2021 at 08:48, Nicolas Pitre <npitre@baylibre.com> wrote:
> > > >
> > > > The clock API splits its interface into sleepable ant atomic contexts:
> > > >
> > > > - clk_prepare/clk_unprepare for stuff that might sleep
> > > >
> > > > - clk_enable_clk_disable for anything that may be done in atomic context
> > > >
> > >
> > > <trim>
> > >
> > > >
> > > > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > > >
> > > > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> > > > index ced6863a16..a62fb0f9b1 100644
> > > > --- a/drivers/base/power/clock_ops.c
> > > > +++ b/drivers/base/power/clock_ops.c
> > >
> > > <trim>
> > >
> > > > @@ -64,17 +166,20 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
> > > >                 ce->clk = clk_get(dev, ce->con_id);
> > > >         if (IS_ERR(ce->clk)) {
> > > >                 ce->status = PCE_STATUS_ERROR;
> > > > +               return;
> > > > +       } else if (clk_is_enabled_when_prepared(ce->clk)) {
> > >
> > > arm-linux-gnueabihf-ld: drivers/base/power/clock_ops.o: in function
> > > `pm_clk_acquire':
> > > drivers/base/power/clock_ops.c:170: undefined reference to
> > > `clk_is_enabled_when_prepared'
> > >
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >
> > > This build error was noticed on arm architecture on linux next 20210121 tag.
> > > Following builds failed.
> > >  - arm (omap1_defconfig) with clang-10 - FAILED
> > >  - arm (omap1_defconfig) with clang-11 - FAILED
> > >
> > >  - arm (omap1_defconfig) with gcc-8 - FAILED
> > >  - arm (omap1_defconfig) with gcc-9 - FAILED
> > >  - arm (omap1_defconfig) with gcc-10 - FAILED
> >
> > Missing dummy clk_is_enabled_when_prepared() for the
> > !CONFIG_HAVE_CLK case?
>
> I see these configs enabled in failed builds config file,
>
> CONFIG_HAVE_CLK=y
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_LEGACY_CLK=y
>
> ref:
> https://builds.tuxbuild.com/1nN0vkpNP4qhvIuIJN12j7tTpQs/

So I'm going to drop this patch from linux-next until the issue is
resolved, thanks!
