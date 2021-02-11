Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CB23185F4
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 08:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhBKH5X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 02:57:23 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41409 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBKHzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 02:55:16 -0500
Received: by mail-ot1-f48.google.com with SMTP id s107so4369052otb.8;
        Wed, 10 Feb 2021 23:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+y2ykRo35Ho1Ay2BjBPfbis5WVr8Yo45047sbXAu03U=;
        b=NoZWoxODDM8XN2MeaY7pdhAM1vX6YtPM9qUWchjPVxU0pLKY6R8qLXy2UftHHocyHN
         72KFdKV2EvaPdxGH0cjC3X1+C8bSOV+891yR/DygBawkR3b048Eib3ndzX/QNajjU93G
         cueYJNYZGnBrMjxnK0HYECTLp/q5Q2bpnUrTWqne+GDx7RlwgJWhiepAQsyKzFvrq2oA
         4N3kx1n4FCnSRk6/XVH4AQ81jR8jH44IIX85bW5TXxqahvMaS+7ojZ0FvIYSM1tSUrY3
         FHyuTzC/5zrxbbefPFdteASm+MEeqDvpcDBhfIa90zUD7bCnq4m0z9ykDRvSPslChG3R
         GXAw==
X-Gm-Message-State: AOAM530Rc3cIj/DksDewsvbyr2kbnGox8x5J+vFKxwfri4OAvi15wKyZ
        2BEhDuEttpCza/+fLXl2C5F5DO8z37j3ITwzKqZ3ZGqC
X-Google-Smtp-Source: ABdhPJxeLTHAjoZoTOkYH7ZF43miE01Q6qTrxl9a0rDUSducWvD6ALn4VvYN6F14WIJQEZoKHkr28cLiwhnnxCnSv90=
X-Received: by 2002:a9d:77d6:: with SMTP id w22mr4966439otl.145.1613030118370;
 Wed, 10 Feb 2021 23:55:18 -0800 (PST)
MIME-Version: 1.0
References: <17nqrn25-rp5s-4652-o5o1-72p2oprqpq90@onlyvoer.pbz>
 <CAJZ5v0hj4VC_kjB5e_b_ho=ET_quG5zUh0Dbbdwofp-6azopsw@mail.gmail.com>
 <CA+G9fYsRVxWPW1nvSXMTLWfEadrdBDSH5hRPtoUYpfpqq8zRSw@mail.gmail.com>
 <CAJZ5v0gsYb1uxDUTHUe539w8uXhk=m337Xn6wtPhF1oPKzaYrQ@mail.gmail.com>
 <30np982n-r2q8-8532-q6os-9p9729ppos45@syhkavp.arg> <CAJZ5v0iNtmXWr3uXzit5Er_j7G=LkGVyhdNAsjwpVWsDy8F7KQ@mail.gmail.com>
 <61p41n8-r88q-9npq-879o-s4r5856os9s1@onlyvoer.pbz> <CAJZ5v0hn=aUXS-cBG333YXiG2_SUhfkvzsJPYqmWRyDu1zc+VA@mail.gmail.com>
 <82qo9ooo-32q0-2r4r-26q-o8482651qr91@onlyvoer.pbz> <p19331q-3579-p18s-s832-qps97sp5o6sq@onlyvoer.pbz>
 <161301451636.1254594.7473642352348913785@swboyd.mtv.corp.google.com>
In-Reply-To: <161301451636.1254594.7473642352348913785@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Feb 2021 08:55:07 +0100
Message-ID: <CAMuHMdXvkhH3ELV2TF-KxWK1neeKEWdFFtLvbxrnorZk-yW1Pg@mail.gmail.com>
Subject: Re: [PATCH v4] PM / clk: make PM clock layer compatible with clocks
 that must sleep
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Pitre <npitre@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

On Thu, Feb 11, 2021 at 4:35 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Nicolas Pitre (2021-01-25 11:29:18)
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
> > A note on sparse:
> > According to https://lwn.net/Articles/109066/ there are things
> > that sparse can't cope with. In particular, pm_clk_op_lock() and
> > pm_clk_op_unlock() may or may not lock/unlock psd->lock depending on
> > some runtime condition. To work around that we tell it the lock is
> > always untaken for the purpose of static analisys.
> >
> > Thanks to Naresh Kamboju for reporting issues with the initial patch.
> >
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > ---
>
> Thanks for doing this. I think it's the main reason why nobody uses the
> PM clock code so far.

"git grep pm_clk_add" tells you otherwise?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
