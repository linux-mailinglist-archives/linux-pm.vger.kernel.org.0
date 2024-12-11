Return-Path: <linux-pm+bounces-19076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731309EDB01
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 00:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F31614EA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 23:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F611F2389;
	Wed, 11 Dec 2024 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOyoSWR6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48491EC4FF;
	Wed, 11 Dec 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958701; cv=none; b=TXG57ioNhPSbWl54X/wzmtsNuPEBdZTKUVUIOctqRoB++6N01+XFAM4TTNT6v6rFXVo17TSGm92bkLncCImjXhwwwHqbTARtt375upFZyA7lyc47B1IKia6SJ23j/111cm6tAoQ/YmHCRGND+58ux8EvMZCgApt6MJazZVW+pJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958701; c=relaxed/simple;
	bh=8dYracxQcqXH7RO7AuMCREdDCK+nw64UWPDNSr72gKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwW+I/fR4M9LA5v1wXbiX4QjjwSI/9xkm/NmrxY/DTQt75EMG7gClTfbdDQVjs2V1mWPNlqkbU34sZhjZjdn8kuIlLBNzaAP2YjhUWGuzxBuyCoEwwUh6ca8MDPDMkFkMCgf+Uc75jkgs/1NleeqjJ7onl1U8iXSoAbGESwcZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOyoSWR6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so9209411a12.3;
        Wed, 11 Dec 2024 15:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958698; x=1734563498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DEsYbv+14YcD3cx8SHU+N63+rhoslsxxNsNwT6XSRs=;
        b=QOyoSWR6nKUYLPQgIlONQ/PDjgn3+z4Fmx7CMyMOBo1XYhhdXmTR1lLkmF4BnfTWgm
         U+lPQ9QNRcJL1nX/27+BtEQPAl7L66wK2nSmppk4Uo4iqrnD13+x9IHt6z1nBqqj4Ley
         fk3Cg2YGAI3bQggkYuRjxfwiY2ub9mOomvzskCDVoWqmSrodtWVsvKJ+RPoafnpERMwD
         Fw1kc/SQMXlVA9ao3jfpUdjpKg1/wNF7uQmouTXr1POuAVf6hnX0OqIB0VbAO8RZD0wg
         UxzrnhWU3cy7Yf7gBjuONCJv/wja1XHiiVSB0X8wMZk/GNA7cVpDqUnxL/56/5GlKWSI
         MVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958698; x=1734563498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DEsYbv+14YcD3cx8SHU+N63+rhoslsxxNsNwT6XSRs=;
        b=Bqym6w8cUS1B6nCogY5QByZon04Kwiu6WgSlXxoNdPehKKbTqXdIYnDaGefsHI37gD
         KOzGyYsSIvuix9497g0OUtDuE3mX2YmcHUQx5z3S4dV7m/D6EpGoG39sxlqXeiLTLcsH
         nz5s6RLag+1w4ii87GaOggD/1nlD7b3VFK0sNccSF3F1kZlVeRo7029Pa/w8/vONeDv4
         6+UiZrmFKhF+cJSscWu1Bctd35Z6abUATnvj7UQSSKCXCF603sJqqsKisRRV+3xlc7Rz
         cWmrYikKkgkYew7e0AWZVQuFqPAgBO1TV3zzO9f5hikgKC8irjfQQCjSIwmwoBmE7Q+0
         Itwg==
X-Forwarded-Encrypted: i=1; AJvYcCUDLzQZSFnDJS5snA2KRBigTYJXNKCBXb0KkpFIpQYW77GuIAM0yFzwf5QtqMO6HWEZM1fbH8NXf9Eh3ehe@vger.kernel.org, AJvYcCVarw30CdvvdsqFLHjsPXjWQ6vnIK8r8olBSR3yeVaoT9Ji8LEGodcsvyYOfzdmirjGeLnOeelteYNK@vger.kernel.org, AJvYcCVf9BWEUYP/8qTk1+Ptz0e9VA7W4T1eJkg+uU8igBtID1GKYDzJC9I9gmt8fWQpVoAAfgYMZa7uCiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGl5uoVrVd8S07gzuu9msWzdX+/SSvYQaxnRuCp5fwHszrdHPt
	V/gvWKK/tyLqA/loys37Jsa6DM1SmsgXmm4LE7UFOVxIghrj00hSFO+3bKpybE71aU6piRfsBgn
	6ePSElqNP0jys/3rC4qQSPDLXb0uC3I87
X-Gm-Gg: ASbGncsCcgRxqhQc6asLli0bNYBGBQL5947gmEKx+cE2i+C6J5vSONxMdYbFBQ8Oidf
	uPu+m0PBTQmQmVbpcWNU5HPSdqYyl/1mBmDFwR5U=
X-Google-Smtp-Source: AGHT+IEYnXu22m40I+M5yIWPJ0DddwBgpRlRSQLnu5K7XsASm55CzvCUktO2mqurNfbV8WshyxJABShiYjVjYlW2C5o=
X-Received: by 2002:a05:6402:2114:b0:5d0:d9e6:fea1 with SMTP id
 4fb4d7f45d1cf-5d4330d3799mr3651305a12.19.1733958697900; Wed, 11 Dec 2024
 15:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211143044.9550-1-sebastian.reichel@collabora.com>
 <20241211143044.9550-4-sebastian.reichel@collabora.com> <CAMdYzYqLq=kSC8fiBapRS_8w0s8PaL9Yd46VgM56YbTEmUG1xA@mail.gmail.com>
 <xe2wqm4ktutycxj7x4rskz4pn4cfmoci6zcgfxecmvc5bu7cqi@mqxi3pnehqq3>
In-Reply-To: <xe2wqm4ktutycxj7x4rskz4pn4cfmoci6zcgfxecmvc5bu7cqi@mqxi3pnehqq3>
From: Peter Geis <pgwipeout@gmail.com>
Date: Wed, 11 Dec 2024 18:11:24 -0500
Message-ID: <CAMdYzYpDXHtz_Fq5NJXqTdxVTcJcHkjcjU4-J=zwmE0BWmSsNw@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain
 errors
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com, 
	Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 3:46=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hello Peter,
>
> On Wed, Dec 11, 2024 at 02:53:34PM -0500, Peter Geis wrote:
> > On Wed, Dec 11, 2024 at 9:32=E2=80=AFAM Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> > >
> > > Currently rockchip_do_pmu_set_power_domain prints a warning if there
> > > have been errors turning on the power domain, but it does not return
> > > any errors and rockchip_pd_power() tries to continue setting up the
> > > QOS registers. This usually results in accessing unpowered registers,
> > > which triggers an SError and a full system hang.
> > >
> > > This improves the error handling by forwarding the error to avoid
> > > kernel panics.
> >
> > I think we should merge your patch here with my patch for returning
> > errors from rockchip_pmu_set_idle_request [1].
>
> I will have a look.
>
> > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  drivers/pmdomain/rockchip/pm-domains.c | 34 +++++++++++++++++-------=
--
> > >  1 file changed, 22 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomai=
n/rockchip/pm-domains.c
> > > index a161ee13c633..8f440f2883db 100644
> > > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > > @@ -533,16 +533,17 @@ static int rockchip_pmu_domain_mem_reset(struct=
 rockchip_pm_domain *pd)
> > >         return ret;
> > >  }
> > >
> > > -static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_doma=
in *pd,
> > > -                                            bool on)
> > > +static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domai=
n *pd,
> > > +                                           bool on)
> > >  {
> > >         struct rockchip_pmu *pmu =3D pd->pmu;
> > >         struct generic_pm_domain *genpd =3D &pd->genpd;
> > >         u32 pd_pwr_offset =3D pd->info->pwr_offset;
> > >         bool is_on, is_mem_on =3D false;
> > > +       int ret;
> > >
> > >         if (pd->info->pwr_mask =3D=3D 0)
> > > -               return;
> > > +               return 0;
> > >
> > >         if (on && pd->info->mem_status_mask)
> > >                 is_mem_on =3D rockchip_pmu_domain_is_mem_on(pd);
> > > @@ -557,16 +558,21 @@ static void rockchip_do_pmu_set_power_domain(st=
ruct rockchip_pm_domain *pd,
> > >
> > >         wmb();
> > >
> > > -       if (is_mem_on && rockchip_pmu_domain_mem_reset(pd))
> > > -               return;
> > > +       if (is_mem_on) {
> > > +               ret =3D rockchip_pmu_domain_mem_reset(pd);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > >
> > > -       if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, =
is_on,
> > > -                                     is_on =3D=3D on, 0, 10000)) {
> > > -               dev_err(pmu->dev,
> > > -                       "failed to set domain '%s', val=3D%d\n",
> > > -                       genpd->name, is_on);
> > > -               return;
> > > +       ret =3D readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, =
pd, is_on,
> > > +                                       is_on =3D=3D on, 0, 10000);
> > > +       if (ret) {
> > > +               dev_err(pmu->dev, "failed to set domain '%s' %s, val=
=3D%d\n",
> > > +                       genpd->name, on ? "on" : "off", is_on);
> > > +               return ret;
> > >         }
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool pow=
er_on)
> > > @@ -592,7 +598,11 @@ static int rockchip_pd_power(struct rockchip_pm_=
domain *pd, bool power_on)
> > >                         rockchip_pmu_set_idle_request(pd, true);
> > >                 }
> > >
> > > -               rockchip_do_pmu_set_power_domain(pd, power_on);
> > > +               ret =3D rockchip_do_pmu_set_power_domain(pd, power_on=
);
> > > +               if (ret < 0) {
> > > +                       clk_bulk_disable(pd->num_clks, pd->clks);
> > > +                       return ret;
> >
> > Looking at it, we shouldn't return directly from here because the
> > mutex never gets unlocked.
>
> Yes, we should do that after patch 2/7 from this series :)

That's excellent!

>
> > Instead of repeating clk_bulk_disable and return ret for each failure,
> > we can initialize ret =3D 0, have a goto: out pointing to
> > clk_bulk_disable, and change return 0 to return ret at the end.
>
> Right now there is only a single clk_bulk_disable() in an error
> case, so I did not use the typical error goto chain. I suppose
> it makes a lot more sense with proper error handling for the calls
> to rockchip_pmu_set_idle_request().

If you'd like, I can base my v2 on this patch series with the changes
I'm suggesting?

>
> Greetings,
>
> -- Sebastian
>
> >
> > What do you think?
> >
> > Very Respectfully,
> > Peter Geis
> >
> > [1] https://lore.kernel.org/linux-rockchip/20241210013010.81257-2-pgwip=
eout@gmail.com/
> >
> > > +               }
> > >
> > >                 if (power_on) {
> > >                         /* if powering up, leave idle mode */
> > > --
> > > 2.45.2
> > >
> > >
> > > _______________________________________________
> > > Linux-rockchip mailing list
> > > Linux-rockchip@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-rockchip

