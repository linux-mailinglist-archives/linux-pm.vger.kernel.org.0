Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF49AAE9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391026AbfHWI7R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 04:59:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37341 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732254AbfHWI7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 04:59:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id b25so6512452oib.4;
        Fri, 23 Aug 2019 01:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/O7KDJXrmJK4XRdRsrYODhtwGGh/VBJ/wqdtL3MX3sw=;
        b=LTt8M6qLv7V1FG1e2tCq9VLo0aySlS1cAxdbJwbbGUVMP21GiCwqsGtN7D+b3yJGJ9
         P+u5ZURQIglVR8jxxw2NGnn0Tgpe6bKKDeWO3AP/aj3Q/lMr5K4133x3mKHEI9zs5jLe
         ZAODsGYTAmVk3yu3B0uqZDxevz2sYOTTw5D7rWJcmIDHRlRE7IXL4zasWUPvzviEF3Rx
         Ur/wTEON484fOSGTHwkkkkC2gxHGnW+wtdvreyfY01nR5ym5AoXoVjsfxQJJS0nhijEC
         bRXmuL18+Mt8Eyh0NMAXXLBs3kNxOuXt+JoFD8h4rItaypf4jjDVaFfWOSt4gDmXaZw8
         A5UQ==
X-Gm-Message-State: APjAAAW07WZanWQLKznwbFFzfxtXdfo/UQFHfUoXhqzZxP1MIA458vYT
        1Bo4C6Hzt26wJ4xm1OecC9uiTyQE01jpu3m1K8Q=
X-Google-Smtp-Source: APXvYqx9JRH9R2CUtnvFbptw0kgUk2Jw8SnkNPr8UkV++6uNcE/kyPEoGMVzQ+AbDAX6xLdhldBkk2mDpVjxvtvWgsQ=
X-Received: by 2002:aca:b154:: with SMTP id a81mr2257779oif.148.1566550756016;
 Fri, 23 Aug 2019 01:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190816125225.16061-1-geert+renesas@glider.be>
 <20190816125225.16061-2-geert+renesas@glider.be> <20190816180123.6299720665@mail.kernel.org>
 <CAMuHMdVvwsXU2YwFRA2Y2K9KKzF4L-hqDudarmc-OeHXRMCifQ@mail.gmail.com>
 <20190817034812.5435B21721@mail.kernel.org> <CAMuHMdWpUEt-wxEdAK7NsAOadS5TtHYdO=JTGT=CtSROHuR+Pw@mail.gmail.com>
 <CAPDyKFpr7fw_rCciXzZNk2is8KFkd7Tvdx-fzyka_vobCK0U=g@mail.gmail.com>
In-Reply-To: <CAPDyKFpr7fw_rCciXzZNk2is8KFkd7Tvdx-fzyka_vobCK0U=g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Aug 2019 10:59:04 +0200
Message-ID: <CAMuHMdU+szi38Ygk8bu8jrwE4fgsdWVL4Vkf2_Lf4crJQSDm5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for
 clock domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On Thu, Aug 22, 2019 at 4:06 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > Well is it actually a problem to not specify the flag? I guess it's just
> > > a potential problem if the genpd is ever powered off, but given that the
> > > governor decides to leave it always enabled it doesn't actually matter?
> > > So it's not really fixing anything besides silencing a harmless warning?
> >
> > The warning is indeed harmless.
> >
> > The "interesting" case is the case where no warning is printed, as no
> > IRQ-safe device is present.  In that case, the absence of the
> > GENPD_FLAG_ALWAYS_ON flag means that the core PM Domain code will
> > consider the domain for power-off, and will loop over all devices part
> > of it, which is suboptimal.  Setting the flag avoids that.
> >
> > Thanks for your continued questions, it made me realize I need to add more
> > meat to the description to these "simple" patches!
> >
> > For the PM people: would it make sense to add a
> > WARN(!genpd->power_off && !genpd_is_always_on(genpd), "...") check to
> > pm_genpd_init()?
> > Or set GENPD_FLAG_ALWAYS_ON automatically if !genpd->power_off?
>
> Well, wouldn't it be possible that the power is provided through a
> master domain, thus not having the ->power_off() callback assigned for
> the subdomain is perfectly fine, even without having
> GENPD_FLAG_ALWAYS_ON not set.

Thanks, I hadn't considered that the clock domain might be a subdomain
of a power domain.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
