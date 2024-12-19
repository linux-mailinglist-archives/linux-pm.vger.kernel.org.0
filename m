Return-Path: <linux-pm+bounces-19519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B53959F7CB3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 14:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C2B189374F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA408224AF7;
	Thu, 19 Dec 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VriswTZz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE62248B6
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616515; cv=none; b=jwui+Lp6btR/rBcnPG+aJrx+L/Pdar4xpVovVhgbgMZK0xNtaOxi0K+HR0s30iHzM1EykgwvQTl4Mkw/vM+TLWlYMKF3g5AdlDtm9y3E5D9WJJTjmQnySx/dfXSJKbBjIn8cNz051r5jCHI7WrR+vCIzWwx+uY879gDE+dQa3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616515; c=relaxed/simple;
	bh=ANB1CObm+7QH/t4YKy5hJsXI3MV3D9QR+4gNAq+h//E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrgN2rJMkMr5w6e0qOq0jiFPcUVvScnWQDiKJjUA6dMyiikbkajXV78W9yHYnzJQ33zGm5DwJDERtuFuWMmdm7HiKorvTpe5wu2Ps6xhogPypsfmNpaZ6JHpuW6YzOebgA9a1JtOkrVamWcUYdfj4m/xQgFFukfZucYqLq/IcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VriswTZz; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef81222be7so7251377b3.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 05:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734616513; x=1735221313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqjglsHNEzFU9vaMiL5RfRpC+S8PcoDfSHitlHm4rHY=;
        b=VriswTZz6Oi8xLgfdqiWA5lF2pW1YeVgz72nFaenfAKhL2a4nwChnPdJr5t21mZ0OO
         z6rupEXdxs2ymP8+qs6QiO60bEIxw9M1lrxLOUVdBZDikoOKQmmfoWb1FUQr6E1H2tA4
         cAGDHhaDhCTByUrmpySpgZ64vDaXNPS8Ld6FG+YdyGVac9wyH+2WzA47htF03cgfORcL
         4x2gDKlb3ZojzQ8YolpU/USWj2jOa1u/ggmuzudqtZm2+hqAIhPjGPkUMq27RFTO9ZnL
         nc+lAxHYjleSnDFW5LMgUNnYSRDktyF3lPQ+CDHjkQZ2pD+zqkc3919KwrqnszrHT+NI
         b8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734616513; x=1735221313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqjglsHNEzFU9vaMiL5RfRpC+S8PcoDfSHitlHm4rHY=;
        b=Bd9wiGvuB0BCltZD3LjO2Bm3blD8EQGmiAmF+QZ1tih4Jf2UNU8L2rgAcFf/6zmP46
         T69YW5FpiVcQ+sVQ+mO8MxbuueWCZi5dSJZ6i1y7XcC03RqBkn8XHZCyjHprIHrESuAR
         HzltU9+59a/eldmMwbTVVkNDgh4ukYRcFhPTis9axTIpM8Xce0N4pOGA7lATNM77tpQK
         T7389T/uBjkgiKWa7chzGd7Osfyql48XJggLrKGiCbckER2D1Wvyt/nmy31N8TMVDGNk
         btTp11BYJQboUiSyEzRusDfbRz4+K+eYXmmziuvM8HuBvT6LJLzOG4fo6JnmeL6GupfH
         AZcg==
X-Forwarded-Encrypted: i=1; AJvYcCWLjP9XXHSg2Uey++h647aN78PhsWraWqaY6F8sWIoLLV+G0DEtojNR767ywb+MoSNZGidlWZRLuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3PMHE6WzumnoIvK9xdn3Ppqvhh5ckuOcqYrXIwrfoArlzhhNk
	t7FI55yyeKIRWn6es7PcNjz7WMIYaiISuOpFOhNT7fzzqnMiMcu3TdIUiQIFUnxt4R42fOAFoZW
	P8SrGOmer8gRVHxmIVJvROXCmMZ2bf0wUquDiYA==
X-Gm-Gg: ASbGncspAusWl2tXNCpX0YEuUO9jhzcaNBO/6CwQOICpfEd2lRGMuWkMcJZwcOXaJEq
	M+kqYPmEe6/waBWkJ6n9hgSMLGSzN9t+ESZrueFQ=
X-Google-Smtp-Source: AGHT+IEXzGoehdhMl3Q9vXxU+XSlMdQxyfyUpu/ioGXoirnSYyBAN5iDxXWzj6qyDS6IkjSMMPWxu5Uknzpw4GSHDrQ=
X-Received: by 2002:a05:690c:6990:b0:6ef:4fba:8158 with SMTP id
 00721157ae682-6f3e19864e9mr35032897b3.0.1734616512781; Thu, 19 Dec 2024
 05:55:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211143044.9550-1-sebastian.reichel@collabora.com>
 <20241211143044.9550-4-sebastian.reichel@collabora.com> <CAMdYzYqLq=kSC8fiBapRS_8w0s8PaL9Yd46VgM56YbTEmUG1xA@mail.gmail.com>
 <xe2wqm4ktutycxj7x4rskz4pn4cfmoci6zcgfxecmvc5bu7cqi@mqxi3pnehqq3>
 <CAMdYzYpDXHtz_Fq5NJXqTdxVTcJcHkjcjU4-J=zwmE0BWmSsNw@mail.gmail.com>
 <CAPDyKFoW5-U8hLcU-sryuMSP5-E2_yudFZ2-wH8-s62jn4qJ8A@mail.gmail.com> <v4oh6r5lr6eg3rg2poucotbuoddjllfp63lvmf7vuaawe2spvy@f2gv4nvubiw3>
In-Reply-To: <v4oh6r5lr6eg3rg2poucotbuoddjllfp63lvmf7vuaawe2spvy@f2gv4nvubiw3>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 14:54:35 +0100
Message-ID: <CAPDyKFooBYfmWWpy=vw38sw=ANuaadJO4eCRKnq=286vftRPAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain
 errors
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com, 
	Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Dec 2024 at 20:14, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Thu, Dec 12, 2024 at 12:26:42PM +0100, Ulf Hansson wrote:
> > On Thu, 12 Dec 2024 at 00:11, Peter Geis <pgwipeout@gmail.com> wrote:
> > > On Wed, Dec 11, 2024 at 3:46=E2=80=AFPM Sebastian Reichel
> > > <sebastian.reichel@collabora.com> wrote:
> > > > On Wed, Dec 11, 2024 at 02:53:34PM -0500, Peter Geis wrote:
> > > > > On Wed, Dec 11, 2024 at 9:32=E2=80=AFAM Sebastian Reichel
> > > > > <sebastian.reichel@collabora.com> wrote:
> > > > > >
> > > > > > Currently rockchip_do_pmu_set_power_domain prints a warning if =
there
> > > > > > have been errors turning on the power domain, but it does not r=
eturn
> > > > > > any errors and rockchip_pd_power() tries to continue setting up=
 the
> > > > > > QOS registers. This usually results in accessing unpowered regi=
sters,
> > > > > > which triggers an SError and a full system hang.
> > > > > >
> > > > > > This improves the error handling by forwarding the error to avo=
id
> > > > > > kernel panics.
> > > > >
> > > > > I think we should merge your patch here with my patch for returni=
ng
> > > > > errors from rockchip_pmu_set_idle_request [1].
> > > >
> > > > I will have a look.
> > > >
> > > > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > > > > Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On R=
ock 5B
> > > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.c=
om>
> > > > > > ---
> > > > > >  drivers/pmdomain/rockchip/pm-domains.c | 34 +++++++++++++++++-=
--------
> > > > > >  1 file changed, 22 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/p=
mdomain/rockchip/pm-domains.c
> > > > > > index a161ee13c633..8f440f2883db 100644
> > > > > > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > > > > > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > > > > > @@ -533,16 +533,17 @@ static int rockchip_pmu_domain_mem_reset(=
struct rockchip_pm_domain *pd)
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > -static void rockchip_do_pmu_set_power_domain(struct rockchip_p=
m_domain *pd,
> > > > > > -                                            bool on)
> > > > > > +static int rockchip_do_pmu_set_power_domain(struct rockchip_pm=
_domain *pd,
> > > > > > +                                           bool on)
> > > > > >  {
> > > > > >         struct rockchip_pmu *pmu =3D pd->pmu;
> > > > > >         struct generic_pm_domain *genpd =3D &pd->genpd;
> > > > > >         u32 pd_pwr_offset =3D pd->info->pwr_offset;
> > > > > >         bool is_on, is_mem_on =3D false;
> > > > > > +       int ret;
> > > > > >
> > > > > >         if (pd->info->pwr_mask =3D=3D 0)
> > > > > > -               return;
> > > > > > +               return 0;
> > > > > >
> > > > > >         if (on && pd->info->mem_status_mask)
> > > > > >                 is_mem_on =3D rockchip_pmu_domain_is_mem_on(pd)=
;
> > > > > > @@ -557,16 +558,21 @@ static void rockchip_do_pmu_set_power_dom=
ain(struct rockchip_pm_domain *pd,
> > > > > >
> > > > > >         wmb();
> > > > > >
> > > > > > -       if (is_mem_on && rockchip_pmu_domain_mem_reset(pd))
> > > > > > -               return;
> > > > > > +       if (is_mem_on) {
> > > > > > +               ret =3D rockchip_pmu_domain_mem_reset(pd);
> > > > > > +               if (ret)
> > > > > > +                       return ret;
> > > > > > +       }
> > > > > >
> > > > > > -       if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on=
, pd, is_on,
> > > > > > -                                     is_on =3D=3D on, 0, 10000=
)) {
> > > > > > -               dev_err(pmu->dev,
> > > > > > -                       "failed to set domain '%s', val=3D%d\n"=
,
> > > > > > -                       genpd->name, is_on);
> > > > > > -               return;
> > > > > > +       ret =3D readx_poll_timeout_atomic(rockchip_pmu_domain_i=
s_on, pd, is_on,
> > > > > > +                                       is_on =3D=3D on, 0, 100=
00);
> > > > > > +       if (ret) {
> > > > > > +               dev_err(pmu->dev, "failed to set domain '%s' %s=
, val=3D%d\n",
> > > > > > +                       genpd->name, on ? "on" : "off", is_on);
> > > > > > +               return ret;
> > > > > >         }
> > > > > > +
> > > > > > +       return 0;
> > > > > >  }
> > > > > >
> > > > > >  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bo=
ol power_on)
> > > > > > @@ -592,7 +598,11 @@ static int rockchip_pd_power(struct rockch=
ip_pm_domain *pd, bool power_on)
> > > > > >                         rockchip_pmu_set_idle_request(pd, true)=
;
> > > > > >                 }
> > > > > >
> > > > > > -               rockchip_do_pmu_set_power_domain(pd, power_on);
> > > > > > +               ret =3D rockchip_do_pmu_set_power_domain(pd, po=
wer_on);
> > > > > > +               if (ret < 0) {
> > > > > > +                       clk_bulk_disable(pd->num_clks, pd->clks=
);
> > > > > > +                       return ret;
> > > > >
> > > > > Looking at it, we shouldn't return directly from here because the
> > > > > mutex never gets unlocked.
> > > >
> > > > Yes, we should do that after patch 2/7 from this series :)
> > >
> > > That's excellent!
> > >
> > > >
> > > > > Instead of repeating clk_bulk_disable and return ret for each fai=
lure,
> > > > > we can initialize ret =3D 0, have a goto: out pointing to
> > > > > clk_bulk_disable, and change return 0 to return ret at the end.
> > > >
> > > > Right now there is only a single clk_bulk_disable() in an error
> > > > case, so I did not use the typical error goto chain. I suppose
> > > > it makes a lot more sense with proper error handling for the calls
> > > > to rockchip_pmu_set_idle_request().
> > >
> > > If you'd like, I can base my v2 on this patch series with the changes
> > > I'm suggesting?
> >
> > I leave you guys to decide the best way forward, but please keep in
> > mind that fixes/stable patches are easier managed if they are as
> > simple as possible and without relying on cleanup patches. Better fix
> > the problem first, then clean up the code.
>
> I had this ordered the other way around initially and as Heiko
> pointed out that makes things more complicated overall:
>
> https://lore.kernel.org/linux-rockchip/4864529.A9s0UXYOmP@diego/

Right, I have no strong opinions, but leave the decision to you.

Still, we need confirmation on the regulator-patch (patch1) from Mark,
before I can apply any of this.

Kind regards
Uffe

