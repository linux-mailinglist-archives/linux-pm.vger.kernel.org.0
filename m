Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2AF2FE9DD
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 13:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbhAUMMs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 07:12:48 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33257 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbhAUK7i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 05:59:38 -0500
Received: by mail-ot1-f44.google.com with SMTP id 63so1217274oty.0;
        Thu, 21 Jan 2021 02:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KN7X5cb1xBM2Aiwbk2CER1u8lNv5H/NY07cvyV8TZWI=;
        b=aUEMwCfRD1Fiu1xjKKAi6xSGyT/v/Hjs0qFBPtc6jpbKF/qRcf8CDuvZxJM3S+3otT
         jEt1P0pqk74EMqFHo331i7Psex92e20ELR2upLRcaVCtgbFuB6Q7XW58KqMCNdTH/iUa
         6pJ8QqmkxDF8m/iM97m9F6YmGNFSzlqWudDo04TbATnq3qIhpqTvXPX5JLZHo7jbH2cZ
         IHZosrKdYaiMjAz4X6uqgFf+0YC1uncTM4nYMd1NstsPER3gmTvhNgB9M1YYJFtXcuBf
         56kr/llKSwKVt0ervyBg+AZZd7Fazmz0yVHdo8VvoEP0mhDBQv8sIlgF7ndA4eddWQIQ
         prLQ==
X-Gm-Message-State: AOAM530BbmFqbGx2GFd8fXe7idhC0Il4o55jAFYoogLB7/4r9k1KxpOs
        3T/2TVXzNEFLZx1cpDhoHAy0fPAUHk0z2YOQpxQ=
X-Google-Smtp-Source: ABdhPJzRIkve3Ta7vTVnatwwfNZxYw6W8kCRob+9RseLWJuz5yDjZx2O5MqU7+pPm63VZ5kW0iNdebVs0gZAk8je2gE=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr10022158oth.250.1611226733787;
 Thu, 21 Jan 2021 02:58:53 -0800 (PST)
MIME-Version: 1.0
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz> <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com>
In-Reply-To: <CA+G9fYsyXsNSXGy6BWZ6mgpAP=+7r6Xy9jQ2xxb9mXyHdRoBCg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jan 2021 11:58:42 +0100
Message-ID: <CAMuHMdULW4bnb0Jc0+ZaF9P2VNgnYsvEks7y8WYCk045BHqh7A@mail.gmail.com>
Subject: Re: [PATCH] PM / clk: make PM clock layer compatible with clocks that
 must sleep
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
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

On Thu, Jan 21, 2021 at 10:13 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> On Tue, 5 Jan 2021 at 08:48, Nicolas Pitre <npitre@baylibre.com> wrote:
> >
> > The clock API splits its interface into sleepable ant atomic contexts:
> >
> > - clk_prepare/clk_unprepare for stuff that might sleep
> >
> > - clk_enable_clk_disable for anything that may be done in atomic context
> >
>
> <trim>
>
> >
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> >
> > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> > index ced6863a16..a62fb0f9b1 100644
> > --- a/drivers/base/power/clock_ops.c
> > +++ b/drivers/base/power/clock_ops.c
>
> <trim>
>
> > @@ -64,17 +166,20 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
> >                 ce->clk = clk_get(dev, ce->con_id);
> >         if (IS_ERR(ce->clk)) {
> >                 ce->status = PCE_STATUS_ERROR;
> > +               return;
> > +       } else if (clk_is_enabled_when_prepared(ce->clk)) {
>
> arm-linux-gnueabihf-ld: drivers/base/power/clock_ops.o: in function
> `pm_clk_acquire':
> drivers/base/power/clock_ops.c:170: undefined reference to
> `clk_is_enabled_when_prepared'
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> This build error was noticed on arm architecture on linux next 20210121 tag.
> Following builds failed.
>  - arm (omap1_defconfig) with clang-10 - FAILED
>  - arm (omap1_defconfig) with clang-11 - FAILED
>
>  - arm (omap1_defconfig) with gcc-8 - FAILED
>  - arm (omap1_defconfig) with gcc-9 - FAILED
>  - arm (omap1_defconfig) with gcc-10 - FAILED

Missing dummy clk_is_enabled_when_prepared() for the
!CONFIG_HAVE_CLK case?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
