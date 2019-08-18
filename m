Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5391589
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfHRI1l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 04:27:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34058 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfHRI1k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 04:27:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id c7so13467780otp.1;
        Sun, 18 Aug 2019 01:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGsbphl0FQQGBuaRly5CWz/iJFmuKNjtWAnSJ2N4x+0=;
        b=dUcsNVHIiueFDkN4qMQ/xgJKFVim6rXPU2vPe8DySPZ2y37HnkcLshStNYpR4m9sii
         6BjsM/mR8P19NwiRHHOqv44CL5lduXAG+wrSVTe1S+WhshDVHk9pFaHziVlxHfjeJlQJ
         vuU8PrHslBPFabqwqED5t/BWsh7fLsCwKkREKsJN8OTWQRG7H6XobgmFTC6Z313s2s5b
         j0bPpA/ALsrdiA/AnLEVgyludy12ViUxvjfHyJS0X7iaMxQmRaPO/NAdazhTNQCa28C6
         TokBhOQzQVJ96MZZjx93zzykHVKypgtISFkqhKBXAPHCmYQJbyzLvCkchoNqgX8kzCeX
         rTwQ==
X-Gm-Message-State: APjAAAVR+dERphw6MIArOIOHk/A39kk3zv++iNExY7dLZ3cYYWhC2EAN
        01LEIKWat/TJJbPyTEp0Ve5nwzkYGxGd0j5H9Bk=
X-Google-Smtp-Source: APXvYqx7IA3LHDxIT7relAV7fI5zU5sPnu2xMiAU9Hh4XnETjwrFtGdKnmornqsRB0cg2qycSCFuJg+2WRrk3UyjPh4=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr14124466otk.145.1566116859589;
 Sun, 18 Aug 2019 01:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190816125225.16061-1-geert+renesas@glider.be>
 <20190816125225.16061-2-geert+renesas@glider.be> <20190816180123.6299720665@mail.kernel.org>
 <CAMuHMdVvwsXU2YwFRA2Y2K9KKzF4L-hqDudarmc-OeHXRMCifQ@mail.gmail.com> <20190817034812.5435B21721@mail.kernel.org>
In-Reply-To: <20190817034812.5435B21721@mail.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Aug 2019 10:27:28 +0200
Message-ID: <CAMuHMdWpUEt-wxEdAK7NsAOadS5TtHYdO=JTGT=CtSROHuR+Pw@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for
 clock domain
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

On Sat, Aug 17, 2019 at 5:48 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2019-08-16 12:59:32)
> > On Fri, Aug 16, 2019 at 8:01 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > Quoting Geert Uytterhoeven (2019-08-16 05:52:23)
> > > > The CPG/MSTP Clock Domain driver does not implement the
> > > > generic_pm_domain.power_{on,off}() callbacks, as the domain itself
> > > > cannot be powered down.  Hence the domain should be marked as always-on
> > > > by setting the GENPD_FLAG_ALWAYS_ON flag.
> > > >
> > > > This gets rid of the following boot warning on RZ/A1:
> > > >
> > > >     sh_mtu2 fcff0000.timer: PM domain cpg_clocks will not be powered off
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > >
> > > Are you going to add a Fixes tag?
> >
> > I didn't add a Fixes tag, as there's no clear point in history where the
> > problem appeared: the Clock Domain code in this driver predates the
> > introduction of the GENPD_FLAG_ALWAYS_ON flag by ca. 18 months.
> >
> > Candidates are:
> > d716f4798ff8c65a ("PM / Domains: Support IRQ safe PM domains")
> > ffaa42e8a40b7f10 ("PM / Domains: Enable users of genpd to specify
> > always on PM domains")
> > 075c37d59ecd4a8b ("PM / Domains: Don't warn about IRQ safe device for
> > an always on PM domain")
> >
> > Do you think it's worth adding one or more of the above?
>
> Well is it actually a problem to not specify the flag? I guess it's just
> a potential problem if the genpd is ever powered off, but given that the
> governor decides to leave it always enabled it doesn't actually matter?
> So it's not really fixing anything besides silencing a harmless warning?

The warning is indeed harmless.

The "interesting" case is the case where no warning is printed, as no
IRQ-safe device is present.  In that case, the absence of the
GENPD_FLAG_ALWAYS_ON flag means that the core PM Domain code will
consider the domain for power-off, and will loop over all devices part
of it, which is suboptimal.  Setting the flag avoids that.

Thanks for your continued questions, it made me realize I need to add more
meat to the description to these "simple" patches!

For the PM people: would it make sense to add a
WARN(!genpd->power_off && !genpd_is_always_on(genpd), "...") check to
pm_genpd_init()?
Or set GENPD_FLAG_ALWAYS_ON automatically if !genpd->power_off?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
