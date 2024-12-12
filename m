Return-Path: <linux-pm+bounces-19151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C079EFC24
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 20:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C07316BA95
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741D1925AF;
	Thu, 12 Dec 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="WqwLGXMR"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9284818CBFB;
	Thu, 12 Dec 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030870; cv=pass; b=BmWK464poV9L57zvl9nRdzQHoSLGcKuIp3kIqSaViw8Uu6fWGa1YA1scu0KJ277z21FvZdlTyDg8tp5BDywEBAK0w0f/neFxyshHgegPawwpVjvUAh45IMcvrVq76je0X4Qkrmi7UWNhXGE649qy1XVc+DxMYdcYfFpwKYPU8do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030870; c=relaxed/simple;
	bh=vr23ACFYNAg50do9K/bY+cFmocw4LsFbCTJIv7y69YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIQgZqS891qNU3WSI3XXjWtyPE+paS3zHFw4e0EFGrpD8YipxVyyR2kyIzBHbSuRe/I3koeCulBW/YiO9RNT7LRo4gJuk7RYDaYNsEMtAy5aG5avAfbf6oQQ0/JfBKqq746hV/wR4+GS7tp2JpqJPy2vWn4V3MJZk5GaB9JY7Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=WqwLGXMR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734030828; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d2KhIrTRCwsnrSEx5Awba5uvk41EF0jtrltCD/UEiBzj4zr8GnyyDi2B+GdQIb2QWV+v4mSWCXQPGQ/Tekvhw2llABm+j9ThHIAGkIZZqArnYHYyZGodb/cHX5DsB/2qDjNgeyetDXFdnlfDKfyMUgG/qBjtuUozXu6GseYPQvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734030828; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wbJ8cGeT9Wi00jHtRJfO1mPAsezSL7iwI1iLiBCnwhA=; 
	b=IPVolFHtc9XoXkZrf0RDz5Eezr1fbuG2+z6OLT/6GeL/pGBNuHen0xgU8IOMBtVZaV1RMFx4gPQrvhn+DAHXzVWK5k1ZW7zhvIQ1iEzNuSITBCJdvSMXFtzE8W85iWgeG017ZqHL87SsTuvcYmC4PYZ6bIglLpHB+x43rEJF4ZA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734030828;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=wbJ8cGeT9Wi00jHtRJfO1mPAsezSL7iwI1iLiBCnwhA=;
	b=WqwLGXMRlElCdIE54gl2MEFu8Olymm/zI0A6KavVx//bqv1lC38iqgsDk1MCnlhR
	8zuCEnt0YIfSiexjncqGMSlzj+7tu4a2d4JKcphkKphuYAgUlT8nzB4IJoW9WhLzQui
	nrzigylBi3iG7drL+xY0KvCptv6yXWL8YM4/q7hQ=
Received: by mx.zohomail.com with SMTPS id 1734030825629780.8771974478221;
	Thu, 12 Dec 2024 11:13:45 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 57EE810604B1; Thu, 12 Dec 2024 20:13:40 +0100 (CET)
Date: Thu, 12 Dec 2024 20:13:40 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?utf-8?B?QWRyacOhbiBNYXJ0w61uZXo=?= Larumbe <adrian.larumbe@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com, 
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v5 3/7] pmdomain: rockchip: forward
 rockchip_do_pmu_set_power_domain errors
Message-ID: <v4oh6r5lr6eg3rg2poucotbuoddjllfp63lvmf7vuaawe2spvy@f2gv4nvubiw3>
References: <20241211143044.9550-1-sebastian.reichel@collabora.com>
 <20241211143044.9550-4-sebastian.reichel@collabora.com>
 <CAMdYzYqLq=kSC8fiBapRS_8w0s8PaL9Yd46VgM56YbTEmUG1xA@mail.gmail.com>
 <xe2wqm4ktutycxj7x4rskz4pn4cfmoci6zcgfxecmvc5bu7cqi@mqxi3pnehqq3>
 <CAMdYzYpDXHtz_Fq5NJXqTdxVTcJcHkjcjU4-J=zwmE0BWmSsNw@mail.gmail.com>
 <CAPDyKFoW5-U8hLcU-sryuMSP5-E2_yudFZ2-wH8-s62jn4qJ8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6fd2ncdfhcvqlku"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoW5-U8hLcU-sryuMSP5-E2_yudFZ2-wH8-s62jn4qJ8A@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.989.0
X-ZohoMailClient: External


--j6fd2ncdfhcvqlku
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/7] pmdomain: rockchip: forward
 rockchip_do_pmu_set_power_domain errors
MIME-Version: 1.0

Hi,

On Thu, Dec 12, 2024 at 12:26:42PM +0100, Ulf Hansson wrote:
> On Thu, 12 Dec 2024 at 00:11, Peter Geis <pgwipeout@gmail.com> wrote:
> > On Wed, Dec 11, 2024 at 3:46=E2=80=AFPM Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> > > On Wed, Dec 11, 2024 at 02:53:34PM -0500, Peter Geis wrote:
> > > > On Wed, Dec 11, 2024 at 9:32=E2=80=AFAM Sebastian Reichel
> > > > <sebastian.reichel@collabora.com> wrote:
> > > > >
> > > > > Currently rockchip_do_pmu_set_power_domain prints a warning if th=
ere
> > > > > have been errors turning on the power domain, but it does not ret=
urn
> > > > > any errors and rockchip_pd_power() tries to continue setting up t=
he
> > > > > QOS registers. This usually results in accessing unpowered regist=
ers,
> > > > > which triggers an SError and a full system hang.
> > > > >
> > > > > This improves the error handling by forwarding the error to avoid
> > > > > kernel panics.
> > > >
> > > > I think we should merge your patch here with my patch for returning
> > > > errors from rockchip_pmu_set_idle_request [1].
> > >
> > > I will have a look.
> > >
> > > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > > > Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Roc=
k 5B
> > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > > ---
> > > > >  drivers/pmdomain/rockchip/pm-domains.c | 34 +++++++++++++++++---=
------
> > > > >  1 file changed, 22 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmd=
omain/rockchip/pm-domains.c
> > > > > index a161ee13c633..8f440f2883db 100644
> > > > > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > > > > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > > > > @@ -533,16 +533,17 @@ static int rockchip_pmu_domain_mem_reset(st=
ruct rockchip_pm_domain *pd)
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > -static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_=
domain *pd,
> > > > > -                                            bool on)
> > > > > +static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_d=
omain *pd,
> > > > > +                                           bool on)
> > > > >  {
> > > > >         struct rockchip_pmu *pmu =3D pd->pmu;
> > > > >         struct generic_pm_domain *genpd =3D &pd->genpd;
> > > > >         u32 pd_pwr_offset =3D pd->info->pwr_offset;
> > > > >         bool is_on, is_mem_on =3D false;
> > > > > +       int ret;
> > > > >
> > > > >         if (pd->info->pwr_mask =3D=3D 0)
> > > > > -               return;
> > > > > +               return 0;
> > > > >
> > > > >         if (on && pd->info->mem_status_mask)
> > > > >                 is_mem_on =3D rockchip_pmu_domain_is_mem_on(pd);
> > > > > @@ -557,16 +558,21 @@ static void rockchip_do_pmu_set_power_domai=
n(struct rockchip_pm_domain *pd,
> > > > >
> > > > >         wmb();
> > > > >
> > > > > -       if (is_mem_on && rockchip_pmu_domain_mem_reset(pd))
> > > > > -               return;
> > > > > +       if (is_mem_on) {
> > > > > +               ret =3D rockchip_pmu_domain_mem_reset(pd);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +       }
> > > > >
> > > > > -       if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, =
pd, is_on,
> > > > > -                                     is_on =3D=3D on, 0, 10000))=
 {
> > > > > -               dev_err(pmu->dev,
> > > > > -                       "failed to set domain '%s', val=3D%d\n",
> > > > > -                       genpd->name, is_on);
> > > > > -               return;
> > > > > +       ret =3D readx_poll_timeout_atomic(rockchip_pmu_domain_is_=
on, pd, is_on,
> > > > > +                                       is_on =3D=3D on, 0, 10000=
);
> > > > > +       if (ret) {
> > > > > +               dev_err(pmu->dev, "failed to set domain '%s' %s, =
val=3D%d\n",
> > > > > +                       genpd->name, on ? "on" : "off", is_on);
> > > > > +               return ret;
> > > > >         }
> > > > > +
> > > > > +       return 0;
> > > > >  }
> > > > >
> > > > >  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool=
 power_on)
> > > > > @@ -592,7 +598,11 @@ static int rockchip_pd_power(struct rockchip=
_pm_domain *pd, bool power_on)
> > > > >                         rockchip_pmu_set_idle_request(pd, true);
> > > > >                 }
> > > > >
> > > > > -               rockchip_do_pmu_set_power_domain(pd, power_on);
> > > > > +               ret =3D rockchip_do_pmu_set_power_domain(pd, powe=
r_on);
> > > > > +               if (ret < 0) {
> > > > > +                       clk_bulk_disable(pd->num_clks, pd->clks);
> > > > > +                       return ret;
> > > >
> > > > Looking at it, we shouldn't return directly from here because the
> > > > mutex never gets unlocked.
> > >
> > > Yes, we should do that after patch 2/7 from this series :)
> >
> > That's excellent!
> >
> > >
> > > > Instead of repeating clk_bulk_disable and return ret for each failu=
re,
> > > > we can initialize ret =3D 0, have a goto: out pointing to
> > > > clk_bulk_disable, and change return 0 to return ret at the end.
> > >
> > > Right now there is only a single clk_bulk_disable() in an error
> > > case, so I did not use the typical error goto chain. I suppose
> > > it makes a lot more sense with proper error handling for the calls
> > > to rockchip_pmu_set_idle_request().
> >
> > If you'd like, I can base my v2 on this patch series with the changes
> > I'm suggesting?
>=20
> I leave you guys to decide the best way forward, but please keep in
> mind that fixes/stable patches are easier managed if they are as
> simple as possible and without relying on cleanup patches. Better fix
> the problem first, then clean up the code.

I had this ordered the other way around initially and as Heiko
pointed out that makes things more complicated overall:

https://lore.kernel.org/linux-rockchip/4864529.A9s0UXYOmP@diego/

Greetings,

-- Sebastian

--j6fd2ncdfhcvqlku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdbNd0ACgkQ2O7X88g7
+ponTw//SV9QzhiNNpwaJEZ72Yh6NxpJRGo86MsMBSZ9/hhH/EzUuwcgl/xGydss
96U9t15iugFbrra/alLpoMJVQX9qb8Y/xU3ClWUC6Anf8mKGVl1/6wZEewzkFG1b
WTEwIbH1U7Smvoqu7y6U6GkdHlcqqm3HQinG6VJS92KMyXtWvPs6pwOb0Ta/sSGY
qLxHPKGurxofPQOqc5/NDouHad5Hv07K4Ef8gaG6ng1fhAAu/zdt3Cr/kMzgfzPu
VEBHcdaFbMfVAv+GbLjy6oos/jP1ZeOeTsFxBZAysVH7E++h5JRvAJayIdKzjN6i
7K9EQ0qeBmGQES/8MirUlfBifYce62uVGsIRg1FfL7PxTRovwZGZEryyusq4FF0p
cxSX4yQF8ZqaP/XclJVB4zZBZefltZaRh8WVkQvUJc/Y6VjuyV91MTnbVWOmOR7i
j6t7k8L8ZwGIZ2n3PxMibZLsNZlSk40sgo7ox9DbwsdXaJO+13sdDIdcapUTjUOe
jFrrvK0KnJfB+Jyg9f8W5Ur0BwX2of+seHNyRaUzDNkYHAXv/BNQqxzLXH9Ki0NA
1M+juByBONsbRsCLAXyeg+IhosEooD841w09hs8PvYuPbNbw/Xlawz18oVp15GbG
I5SmjfEeWnwDI7amjbsahRXQa8OvYYm7mRSPfLUUw9c3aLtikyo=
=rS7x
-----END PGP SIGNATURE-----

--j6fd2ncdfhcvqlku--

