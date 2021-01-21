Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78ED2FE9AA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 13:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbhAUMLF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 07:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbhAUMKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 07:10:35 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D29C061757
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 04:09:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so2224131ejf.11
        for <linux-pm@vger.kernel.org>; Thu, 21 Jan 2021 04:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PN3btH2euqDWyhj/RgcRNFuB9aKArS6y5Lw17W2vYDw=;
        b=IgbtXQTlXCqlMx1bhQT61oVPyORIlcntQML0JND/eFe+uUvSN5sY1aXbkodkKJCWaL
         K8kIf0LbHE0ZkQzfc5e4CNqDfn2Qbn5xdlHcU0XS4CGLp8hSJZjmF5fAsHA1BRG172K4
         Z+YDVEXIqaYY+cFgY//pVpftKSH/OYHJiwCSgA8Jj9fyufeNDQQ7JhhQqfxQA7FrPC7U
         4D2//SjPqoK5PRE3E7WVgDSSreA8+JTGPYbyeHJJmr9vxGI5IM0ud9Hncuotj9gMI9We
         zu+lsj/iJBcgzUo4DljRo9Jc0Tat5+a3sFh/hXFfREWFhUfkwNOYkDZ8Ze7aoklspji3
         xLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PN3btH2euqDWyhj/RgcRNFuB9aKArS6y5Lw17W2vYDw=;
        b=H+bvCgAGnGDVUNhMtyY7tcn+swkONoSKfDhZMwSfO5FmLLlq8KNSH62cSD5geQXUjr
         SGlimm3l2HqtJxpNcswWsuM9T+F0XFRG+DXoLHKynPoGVMAdecOxEZo18aVjUFrdB1w8
         uLgvyPtRzSfOXm9oSoOqqdN89+9MPnQa5mFcwqgAeTpBZ65CxRxyCQGuyGXVJI8SfL8M
         iNGAQ+VprDGIP3pmb9LkqO5nGvU4TyyVCOrWQJorcqDX/fzLNqLXbZBkQCNb3orWtf8q
         M3asB4uXpaPhqLiJSt7Sk/sZ02pngu869gLGufKH9wyKymtpOy0W4fa7nxk/tECu+UPk
         2ERA==
X-Gm-Message-State: AOAM533R6B359qjo8cRC4HM2nV6gooCnpCtLg9RHDLqNMov/LWoBE35l
        Ey1llyxXQrm34ydiYYE24uRtFercikaWPHJ2DUyWng==
X-Google-Smtp-Source: ABdhPJzTY9DkBjOJ9FCRi7TMtReV9fqcjGv4rohvAiFeHBoODFkHjE9QiHmMHZBcFgBuQcn6aCZ0pbxKF4S16PGwwDg=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr8849525eju.375.1611230991153;
 Thu, 21 Jan 2021 04:09:51 -0800 (PST)
MIME-Version: 1.0
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
 <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com> <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com>
In-Reply-To: <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Jan 2021 17:39:39 +0530
Message-ID: <CA+G9fYvh0iSyEDQs7+0CX82FLPDCg5UmAt+1JuPsndmfmYF3kw@mail.gmail.com>
Subject: Re: [PATCH] PM / clk: make PM clock layer compatible with clocks that
 must sleep
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nicolas Pitre <npitre@baylibre.com>,
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

On Thu, 21 Jan 2021 at 16:28, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, Jan 21, 2021 at 10:13 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> > On Tue, 5 Jan 2021 at 08:48, Nicolas Pitre <npitre@baylibre.com> wrote:
> > >
> > > The clock API splits its interface into sleepable ant atomic contexts:
> > >
> > > - clk_prepare/clk_unprepare for stuff that might sleep
> > >
> > > - clk_enable_clk_disable for anything that may be done in atomic context
> > >
> >
> > <trim>
> >
> > >
> > > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > >
> > > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> > > index ced6863a16..a62fb0f9b1 100644
> > > --- a/drivers/base/power/clock_ops.c
> > > +++ b/drivers/base/power/clock_ops.c
> >
> > <trim>
> >
> > > @@ -64,17 +166,20 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
> > >                 ce->clk = clk_get(dev, ce->con_id);
> > >         if (IS_ERR(ce->clk)) {
> > >                 ce->status = PCE_STATUS_ERROR;
> > > +               return;
> > > +       } else if (clk_is_enabled_when_prepared(ce->clk)) {
> >
> > arm-linux-gnueabihf-ld: drivers/base/power/clock_ops.o: in function
> > `pm_clk_acquire':
> > drivers/base/power/clock_ops.c:170: undefined reference to
> > `clk_is_enabled_when_prepared'
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > This build error was noticed on arm architecture on linux next 20210121 tag.
> > Following builds failed.
> >  - arm (omap1_defconfig) with clang-10 - FAILED
> >  - arm (omap1_defconfig) with clang-11 - FAILED
> >
> >  - arm (omap1_defconfig) with gcc-8 - FAILED
> >  - arm (omap1_defconfig) with gcc-9 - FAILED
> >  - arm (omap1_defconfig) with gcc-10 - FAILED
>
> Missing dummy clk_is_enabled_when_prepared() for the
> !CONFIG_HAVE_CLK case?

I see these configs enabled in failed builds config file,

CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_LEGACY_CLK=y

ref:
https://builds.tuxbuild.com/1nN0vkpNP4qhvIuIJN12j7tTpQs/

- Naresh
