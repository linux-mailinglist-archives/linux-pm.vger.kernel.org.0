Return-Path: <linux-pm+bounces-19117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897729EE4FC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DBC166852
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422D211717;
	Thu, 12 Dec 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ev9bziEV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCA2116E9
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002844; cv=none; b=R5wLg4khTC2c4bFs1IoU76trmhwl1Icr3CxzP/uqOFenyBstNO0mXH+2FEehLsVkHPTle45RtFpSfSwHcFp5veJ18c2UTAS4gfDn8mRwG9GzG6DW+iIe0xpkaUiG5Ztcwc2Cvko57q9Buru5L7bBeiOzcGz8z3fIkbYJrw4Eu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002844; c=relaxed/simple;
	bh=M51P619tsMjNoMeKHLvLkJmPDP3r11s2NzL2NHxvba8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sae8tAE3xD3cBB3uQWcQXGNdmDbKWu8TeSd8O4aRDWwZcAQRFkLY7RXbQ+S0ZrT6uk1V36e5S4AH8aqvDtzB91a2hxEW2GIXsmivYkFFNLS8xCmkMQoJxs9GUhayksnsEV82dr33kSwRR/KWfepkoV33y+OFitkgSbaNxNMRkqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ev9bziEV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso900527a12.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 03:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734002840; x=1734607640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqF2Tieb7D67lOICsBmQP287sce+XfAQfH7MOyV9crc=;
        b=ev9bziEVJBumm/DMFtCl7/vH0Q2App7g1f9wG5YBK+13YIclX+2mqSkWf/cwfNi2x4
         uybcG5hP3CMQ90tGLVtK0yAGdh6tSCBl1GTbVqC01T6t2MlsVW8/Xsgp4m3kbgVBwcU7
         Rl7mBMdMLQfrCUigSulJ3bYhbZ7gkTzVW8UWpn8lgWqV6jkW/14RzupghcwuGedHBB4V
         j+P3iqlRRYLWG/EwNcTv6zmvwHSOjY+OP7i5fW0XpVpNue0qml7uKdwqH/O/Hg9/A6mc
         8Ms/qlqxRVZs8V4b7A4bUju6M/mA2uwl9zkXG1+yu1UTT+pCgbcg+X1uYAyfYBY/wZPc
         HSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734002840; x=1734607640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqF2Tieb7D67lOICsBmQP287sce+XfAQfH7MOyV9crc=;
        b=TULhqhSWl+X161wn9CW0BSYFdWFJ7L1EisPi0ZroHlNrFmCe6+kEbAAE+035FfMBos
         kllIDG3tPFTfE6bWRW61iNCtGUg6kfp6iGDLt+avOo2h97FeB7Sasxuv5dCoss0Af+8Q
         SBQWrrgAkMRnVGSOd4O1NClUh4Jz4HfyYkw9qt5Ao9TMi+Euewk+nBAFhU88gIe5W+0B
         bB5U8AEdhM9V96QwwlKADAnCL9XdWqDniauoK79CzWWfJa5L7kjMs8uIciTNtfi0zB6Y
         uBPDItFurme8fiIJGeiFNiFtHb5BvoNE/EcKHzDV3O/ZBu/Xd1GY0yiAcittwCrbXaHa
         R95g==
X-Forwarded-Encrypted: i=1; AJvYcCVSfSjGIthN5GUT1BlQgh+GtoQpWBU2jZPcU31n114vxvoOWOv66jSKdEtReI9HQY5ONkxMfFQIIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnMyofd1XsAVY9a0+cuFFmSri7eaEe8s1INPLNoFkD+Smh90A
	5h4R9Bcn2SdvDtv4DynHHEsvkM4doaTIt8uO5ijRDuiYislglR2IJeGsHIiDaIhUfUl/XrkJSp5
	NZzNYShZNA45LtJObb4U3OeFrxQjVMYfDStGzvA==
X-Gm-Gg: ASbGnculDO0RIYAhPbIcRhEMSlfld3J2bLtxc7zn+jpBC7MJ6KY/kIhe/1ymHBoEydD
	R5DefAD4/VtmstsZdFPPOjUNFX+a8LdmDiMEgdC8=
X-Google-Smtp-Source: AGHT+IHSocGA17XJXgNRc77fra8QkYZRyTUv7pf/EXG6lM07ihLb0AEq4b28rY2ahXI1ToSkjC7tXsZ2JZaq/zhJemc=
X-Received: by 2002:a05:6402:34d5:b0:5d3:f617:a003 with SMTP id
 4fb4d7f45d1cf-5d4eb599aa0mr763985a12.4.1734002840039; Thu, 12 Dec 2024
 03:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211143044.9550-1-sebastian.reichel@collabora.com>
 <20241211143044.9550-4-sebastian.reichel@collabora.com> <CAMdYzYqLq=kSC8fiBapRS_8w0s8PaL9Yd46VgM56YbTEmUG1xA@mail.gmail.com>
 <xe2wqm4ktutycxj7x4rskz4pn4cfmoci6zcgfxecmvc5bu7cqi@mqxi3pnehqq3> <CAMdYzYpDXHtz_Fq5NJXqTdxVTcJcHkjcjU4-J=zwmE0BWmSsNw@mail.gmail.com>
In-Reply-To: <CAMdYzYpDXHtz_Fq5NJXqTdxVTcJcHkjcjU4-J=zwmE0BWmSsNw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Dec 2024 12:26:42 +0100
Message-ID: <CAPDyKFoW5-U8hLcU-sryuMSP5-E2_yudFZ2-wH8-s62jn4qJ8A@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain
 errors
To: Peter Geis <pgwipeout@gmail.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com, 
	Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Dec 2024 at 00:11, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Wed, Dec 11, 2024 at 3:46=E2=80=AFPM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hello Peter,
> >
> > On Wed, Dec 11, 2024 at 02:53:34PM -0500, Peter Geis wrote:
> > > On Wed, Dec 11, 2024 at 9:32=E2=80=AFAM Sebastian Reichel
> > > <sebastian.reichel@collabora.com> wrote:
> > > >
> > > > Currently rockchip_do_pmu_set_power_domain prints a warning if ther=
e
> > > > have been errors turning on the power domain, but it does not retur=
n
> > > > any errors and rockchip_pd_power() tries to continue setting up the
> > > > QOS registers. This usually results in accessing unpowered register=
s,
> > > > which triggers an SError and a full system hang.
> > > >
> > > > This improves the error handling by forwarding the error to avoid
> > > > kernel panics.
> > >
> > > I think we should merge your patch here with my patch for returning
> > > errors from rockchip_pmu_set_idle_request [1].
> >
> > I will have a look.
> >
> > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > > Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock =
5B
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > ---
> > > >  drivers/pmdomain/rockchip/pm-domains.c | 34 +++++++++++++++++-----=
----
> > > >  1 file changed, 22 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdom=
ain/rockchip/pm-domains.c
> > > > index a161ee13c633..8f440f2883db 100644
> > > > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > > > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > > > @@ -533,16 +533,17 @@ static int rockchip_pmu_domain_mem_reset(stru=
ct rockchip_pm_domain *pd)
> > > >         return ret;
> > > >  }
> > > >
> > > > -static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_do=
main *pd,
> > > > -                                            bool on)
> > > > +static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_dom=
ain *pd,
> > > > +                                           bool on)
> > > >  {
> > > >         struct rockchip_pmu *pmu =3D pd->pmu;
> > > >         struct generic_pm_domain *genpd =3D &pd->genpd;
> > > >         u32 pd_pwr_offset =3D pd->info->pwr_offset;
> > > >         bool is_on, is_mem_on =3D false;
> > > > +       int ret;
> > > >
> > > >         if (pd->info->pwr_mask =3D=3D 0)
> > > > -               return;
> > > > +               return 0;
> > > >
> > > >         if (on && pd->info->mem_status_mask)
> > > >                 is_mem_on =3D rockchip_pmu_domain_is_mem_on(pd);
> > > > @@ -557,16 +558,21 @@ static void rockchip_do_pmu_set_power_domain(=
struct rockchip_pm_domain *pd,
> > > >
> > > >         wmb();
> > > >
> > > > -       if (is_mem_on && rockchip_pmu_domain_mem_reset(pd))
> > > > -               return;
> > > > +       if (is_mem_on) {
> > > > +               ret =3D rockchip_pmu_domain_mem_reset(pd);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +       }
> > > >
> > > > -       if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd=
, is_on,
> > > > -                                     is_on =3D=3D on, 0, 10000)) {
> > > > -               dev_err(pmu->dev,
> > > > -                       "failed to set domain '%s', val=3D%d\n",
> > > > -                       genpd->name, is_on);
> > > > -               return;
> > > > +       ret =3D readx_poll_timeout_atomic(rockchip_pmu_domain_is_on=
, pd, is_on,
> > > > +                                       is_on =3D=3D on, 0, 10000);
> > > > +       if (ret) {
> > > > +               dev_err(pmu->dev, "failed to set domain '%s' %s, va=
l=3D%d\n",
> > > > +                       genpd->name, on ? "on" : "off", is_on);
> > > > +               return ret;
> > > >         }
> > > > +
> > > > +       return 0;
> > > >  }
> > > >
> > > >  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool p=
ower_on)
> > > > @@ -592,7 +598,11 @@ static int rockchip_pd_power(struct rockchip_p=
m_domain *pd, bool power_on)
> > > >                         rockchip_pmu_set_idle_request(pd, true);
> > > >                 }
> > > >
> > > > -               rockchip_do_pmu_set_power_domain(pd, power_on);
> > > > +               ret =3D rockchip_do_pmu_set_power_domain(pd, power_=
on);
> > > > +               if (ret < 0) {
> > > > +                       clk_bulk_disable(pd->num_clks, pd->clks);
> > > > +                       return ret;
> > >
> > > Looking at it, we shouldn't return directly from here because the
> > > mutex never gets unlocked.
> >
> > Yes, we should do that after patch 2/7 from this series :)
>
> That's excellent!
>
> >
> > > Instead of repeating clk_bulk_disable and return ret for each failure=
,
> > > we can initialize ret =3D 0, have a goto: out pointing to
> > > clk_bulk_disable, and change return 0 to return ret at the end.
> >
> > Right now there is only a single clk_bulk_disable() in an error
> > case, so I did not use the typical error goto chain. I suppose
> > it makes a lot more sense with proper error handling for the calls
> > to rockchip_pmu_set_idle_request().
>
> If you'd like, I can base my v2 on this patch series with the changes
> I'm suggesting?

I leave you guys to decide the best way forward, but please keep in
mind that fixes/stable patches are easier managed if they are as
simple as possible and without relying on cleanup patches. Better fix
the problem first, then clean up the code.

Kind regards
Uffe

