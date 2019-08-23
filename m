Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C164B9AB21
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 11:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfHWJIW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 05:08:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45772 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfHWJIW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 05:08:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id v12so6493263oic.12;
        Fri, 23 Aug 2019 02:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vv7AIXHXpjyqYAZ2S7B2OmOZt6qGKJgxmRiKB2RUIlY=;
        b=q1ecNwF83ugVXJcnCqUmw/sMQAcklHIIy1ruHkVb3ClLaE8GluNTHPWaKkH8293NpW
         2nmQsDUZnESviYaZ7laWuPWiyzkwiFl5Pfs0bk1/REGnB6cqFcEV6ASZyaa+rPu2G/IF
         1WpANIUAlRlXMaSBXkqOvWOiYPRFCNASGoxmvKsBsioJRO13zz54xXKAULAI+1Jc/X+S
         5BPuxWSO3x512mmQHtAjsaa5bnIZ0cZGTOZYmkmHTY9ZAcvLI20kkhOXopiNJy9o7EMz
         fdUpTht5jdNmax5U2EnUhgBSuBubBjwf4UhYrlZJ8XFMWdF58z1EnGeCC5dM1xTd2aGv
         Fjhg==
X-Gm-Message-State: APjAAAWprP0wlO6Pn+n2koiGgqMPFPiYVdzlz6cirf8VmXNsaeKhQcNh
        otBl69vW3V0G42WRwA162oZOjyKeWaenZ7Gxa30=
X-Google-Smtp-Source: APXvYqyEnIDhJoxsBgSVUV558kban19R/tfa1+VWnxVQTBEbq2Dh73GIhYgK4nIksCgA8MMkTXFHDJckp5fokG8Tdzw=
X-Received: by 2002:aca:b154:: with SMTP id a81mr2283349oif.148.1566551301228;
 Fri, 23 Aug 2019 02:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190816125225.16061-1-geert+renesas@glider.be> <CAPDyKFrxF26gmt3pxp32L6Bt=5tr1PLZVg1bsrjdWKiBqJWf9g@mail.gmail.com>
In-Reply-To: <CAPDyKFrxF26gmt3pxp32L6Bt=5tr1PLZVg1bsrjdWKiBqJWf9g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Aug 2019 11:08:10 +0200
Message-ID: <CAMuHMdUPaBjU6SqVVe8KAGjzSAVgMY50bWCVcxBRF97N6s6grQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] clk: renesas: Set GENPD_FLAG_ALWAYS_ON for clock domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 4:09 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 16 Aug 2019 at 14:52, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > The Renesas Clock Domain drivers do not implement the
> > generic_pm_domain.power_{on,off}() callbacks, as the domains themselves
> > cannot be powered down.  Hence the domains should be marked as always-on
> > by setting the GENPD_FLAG_ALWAYS_ON flag.
> >
> > This patch series that issue for R-Car M1A, RZ/A1, RZ/A2, and
> > RZ/N1 SoCs.
> > SH/R-Mobile SoCs are fixed in "[PATCH] soc: renesas: rmobile-sysc: Set
> > GENPD_FLAG_ALWAYS_ON for always-on domain"
> > (https://lore.kernel.org/linux-renesas-soc/20190816124106.15383-1-geert+renesas@glider.be/T/#u).
> > R-Car H1, Gen2, and Gen3 SoCs do not need a fix, as these SoCS use the
> > R-Car SYSC driver for Clock Domain creation, which already sets the
> > flag.
> >
> > To be queued in clk-renesas for v5.4.
> >
> > Thanks!
> >
> > Geert Uytterhoeven (3):
> >   clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for clock domain
> >   clk: renesas: r9a06g032: Set GENPD_FLAG_ALWAYS_ON for clock domain
> >   clk: renesas: cpg-mssr: Set GENPD_FLAG_ALWAYS_ON for clock domain
> >
> >  drivers/clk/renesas/clk-mstp.c         | 3 ++-
> >  drivers/clk/renesas/r9a06g032-clocks.c | 3 ++-
> >  drivers/clk/renesas/renesas-cpg-mssr.c | 3 ++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
>
> Feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, queuing in clk-renesas-for-v5.4, with enhanced commit description:

    ... to prevent the core PM Domain code from considering it for power-off,
    and doing unnessary processing.

for all three of them, and

    This also gets rid of a boot warning when the Clock Domain contains an
    IRQ-safe device, e.g. on RZ/A1:

for the first patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
