Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE21F34C9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 09:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFIHYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 03:24:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39636 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgFIHYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 03:24:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id d67so17837165oig.6;
        Tue, 09 Jun 2020 00:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/AluQFezpElpg6Pbtj8tyshUteaFf54Xt+QlROi5Vo=;
        b=Mszvom1ju0FMYVwZ2N36JAwokoSCa6osvn6J7e+Iky+f35p45sQUzELeJV36j3FNkE
         ZejuL6YfVj37+DRUCiT6Kl0DE/yzX6saJUrbXU7FiaGpS2eXHvr1fxTvi7bJpD+Xiws+
         tm/e6GkHX3xxbrw+5j14/kaA1EWLK8Pst1iQQFIEB5KcJnvfXz44BHQRtXus4H3p4tvB
         X5bnVv/zGp+Yf1u5iZ5Ygbjt4NBNLcIIJJLWmecwXx8A8W+4zcyEa4WTiaiijJ7L6JyS
         gz6MyQFm7/BunltXGHOZR0NT1Kjzj3CET6qGUWnkZMfSTnVwE6OTOMKEnMgT/SSO0uoP
         B/ng==
X-Gm-Message-State: AOAM531d9fHSBySgCargLxUg3mj8le1RNRl1zlFgd55t9dBdY09NND8n
        6Mft24vs4pP3eAiJNhpUiTP8TAJ2xa2xM1yDooU=
X-Google-Smtp-Source: ABdhPJxbq2qvdCNRUW9ZD5tMa7PNpthSYSo1YvGbZqi+7qha2Fu+hyW6T99B8OhQkZ0Tis34KxACYZ9umkfFxrzOjME=
X-Received: by 2002:a54:4006:: with SMTP id x6mr2235784oie.148.1591687475499;
 Tue, 09 Jun 2020 00:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <1591614776-20333-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXT0qofW38-g79TSiy1nUBhrWNPfbViKRyWSFdme=oD0g@mail.gmail.com> <TY2PR01MB36923211263DA7F54A814AF4D8820@TY2PR01MB3692.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB36923211263DA7F54A814AF4D8820@TY2PR01MB3692.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Jun 2020 09:24:23 +0200
Message-ID: <CAMuHMdWSZNXk_bXvWzgt6aEtuOtox9sXyP36bG=Z_8KNiwkmHw@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Fix undefined temperature if negative
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Dien Pham <dien.pham.ry@renesas.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Van Do <van.do.xw@renesas.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shimoda-san,

On Tue, Jun 9, 2020 at 4:34 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Monday, June 8, 2020 8:38 PM
> <snip>
> > > --- a/drivers/thermal/rcar_gen3_thermal.c
> > > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > > @@ -167,7 +167,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
> > >  {
> > >         struct rcar_gen3_thermal_tsc *tsc = devdata;
> > >         int mcelsius, val;
> > > -       u32 reg;
> > > +       long reg;
> >
> > "long" is 64-bit, so "int" should be sufficient.
>
> Oops.
>
> > >         /* Read register and convert to mili Celsius */
> > >         reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
> >
> > However, rcar_gen3_thermal_read() does return u32, so keeping u32 for
> > reg looks more logical to me.
> >
> > Successive lines are:
> >
> >         if (reg <= thcode[tsc->id][1])
> >                 val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
> >                                 tsc->coef.a1);
> >         else
> >                 val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
> >                                 tsc->coef.a2);
> >
> > Perhaps it's safer to add an cast to FIXPT_INT(), so it always returns
> > int, and/or add casts to FIXPT_DIV(), so only signed values are passed
> > to DIV_ROUND_CLOSEST?
> > That would prevent the issue from reappearing later.
>
> There is not related to the issue but, thcode[] is also int.
> So, if we use casts, we will see a lot of casts like below:

Sorry for being unclear: I literally meant to add casts to the macros,
not to the callers.  If the macros are safe against this issue, then the
callers don't have to care anymore.
But this might be overkill, as the issue is present in one place only.

> I'm thinking the name "reg" is not good because it should be the same type as
> rcar_gen3_thermal_read(). But, if we use other name like "int ctemp;", we can use
> it like below. What do you think?
> ---
> static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
> {
>         struct rcar_gen3_thermal_tsc *tsc = devdata;
>         int mcelsius, val;
>         int ctemp;
>
>         /* Read register and convert to mili Celsius */
>         ctemp = int(rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK);

No need for a cast to int here, as assignment to ctemp takes care
of that.

>
>         if (ctemp <= thcode[tsc->id][1])
>                 val = FIXPT_DIV(FIXPT_INT(ctemp) - tsc->coef.b1,
>                                 tsc->coef.a1);
>         else
>                 val = FIXPT_DIV(FIXPT_INT(ctemp) - tsc->coef.b2,
>                                 tsc->coef.a2);

That would work too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
