Return-Path: <linux-pm+bounces-19070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7F69ED771
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 21:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1965F280DA2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263DE204F82;
	Wed, 11 Dec 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Sino7N4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208D259486;
	Wed, 11 Dec 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950008; cv=pass; b=SPB7AJJHLwWKBZiWhOrrnh8FZ8BHD3AeJXGcSTnz97JbxSoLwOsh6xEMiLHe9n7NvWKTDVbNeDWncGm8S0qCGPT/3UxxmOsckOtViAcy7QUq4AEuJHpSOHJcMlru6CYsmY+GCVPcuCMral9L41eAMwndTdXNn/+XpxuMhOwSe4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950008; c=relaxed/simple;
	bh=RmSK6AsmG2uId15th8lKdy6IVZGu7c1GXJwp4ekgKmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMwq+GH2oRZ8yCw1IvTkG+SjZ6HBptxN4+OHA/k4Ewagq4kG+COpjuSd7a8jW5T/QSyfez5MgghtuaWNnoJgoGyV6E4hk4wCY4twQaO03DBJN4X5+RUyCbXYVh/QhJt16xQVfKHiq6XGBkTiwn0YKYgykh9wZfrt+u/WOKb9tBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Sino7N4R; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733949964; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QWcyrFWnH4Y8H6dcwOzQqEaV0SEsvqACGw54o4ftlIBQZQMPCflngtcHs5EKV73OQ0aXa9gPSDaOuQR7OOmH9rwu04smquzcA1ixDtnn49s4W/lbYyuwClyH8xAyy2zoDIe+wx/IbNJ4MFli2D14/Pf1MPyr2Gb6nERd1YfyDRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733949964; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VXPnSM3GTeNHeZYS08ax4CHEV8xlYT9lwfiCoPy3wAo=; 
	b=TV1XJ29RZRs8Pi93Xy3tFq6zNZEBDkQqe5CMpOdunqWrQFCi/HwxJsQMTulUUbph1rMUPvX4+2u0C1YSReKi5spqU67NoyKHp9+fVkaIk7ioYy/SoURdEuOYT9VnRFnb0yX1yiSIVJ/gnYIz+BPcSsV0Y1zfjkbHPQR1MvIevls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733949964;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=VXPnSM3GTeNHeZYS08ax4CHEV8xlYT9lwfiCoPy3wAo=;
	b=Sino7N4RbmipXtCFYryGQLF7QQDQl7IENYBxr4OW4yWdWQMtTU0qZTVA2UprbBnW
	O9hqjiALFjS8CkIS23V6c4EEt89XgASA6+0+A5ByUc1g0myWRG0SqEfebzHsNebTYXt
	RRvuFBDhaQCDEcgatpw+zwDBG/gCu9e7ZZOVqOHA=
Received: by mx.zohomail.com with SMTPS id 1733949962296297.8827041831578;
	Wed, 11 Dec 2024 12:46:02 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id BCA1A10604B1; Wed, 11 Dec 2024 21:45:56 +0100 (CET)
Date: Wed, 11 Dec 2024 21:45:56 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Peter Geis <pgwipeout@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Elaine Zhang <zhangqing@rock-chips.com>, 
	=?utf-8?B?QWRyacOhbiBNYXJ0w61uZXo=?= Larumbe <adrian.larumbe@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com, 
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v5 3/7] pmdomain: rockchip: forward
 rockchip_do_pmu_set_power_domain errors
Message-ID: <xe2wqm4ktutycxj7x4rskz4pn4cfmoci6zcgfxecmvc5bu7cqi@mqxi3pnehqq3>
References: <20241211143044.9550-1-sebastian.reichel@collabora.com>
 <20241211143044.9550-4-sebastian.reichel@collabora.com>
 <CAMdYzYqLq=kSC8fiBapRS_8w0s8PaL9Yd46VgM56YbTEmUG1xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pgyuyhmom73rgyyw"
Content-Disposition: inline
In-Reply-To: <CAMdYzYqLq=kSC8fiBapRS_8w0s8PaL9Yd46VgM56YbTEmUG1xA@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.945.80
X-ZohoMailClient: External


--pgyuyhmom73rgyyw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/7] pmdomain: rockchip: forward
 rockchip_do_pmu_set_power_domain errors
MIME-Version: 1.0

Hello Peter,

On Wed, Dec 11, 2024 at 02:53:34PM -0500, Peter Geis wrote:
> On Wed, Dec 11, 2024 at 9:32=E2=80=AFAM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Currently rockchip_do_pmu_set_power_domain prints a warning if there
> > have been errors turning on the power domain, but it does not return
> > any errors and rockchip_pd_power() tries to continue setting up the
> > QOS registers. This usually results in accessing unpowered registers,
> > which triggers an SError and a full system hang.
> >
> > This improves the error handling by forwarding the error to avoid
> > kernel panics.
>=20
> I think we should merge your patch here with my patch for returning
> errors from rockchip_pmu_set_idle_request [1].

I will have a look.

> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/pmdomain/rockchip/pm-domains.c | 34 +++++++++++++++++---------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/=
rockchip/pm-domains.c
> > index a161ee13c633..8f440f2883db 100644
> > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > @@ -533,16 +533,17 @@ static int rockchip_pmu_domain_mem_reset(struct r=
ockchip_pm_domain *pd)
> >         return ret;
> >  }
> >
> > -static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain=
 *pd,
> > -                                            bool on)
> > +static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain =
*pd,
> > +                                           bool on)
> >  {
> >         struct rockchip_pmu *pmu =3D pd->pmu;
> >         struct generic_pm_domain *genpd =3D &pd->genpd;
> >         u32 pd_pwr_offset =3D pd->info->pwr_offset;
> >         bool is_on, is_mem_on =3D false;
> > +       int ret;
> >
> >         if (pd->info->pwr_mask =3D=3D 0)
> > -               return;
> > +               return 0;
> >
> >         if (on && pd->info->mem_status_mask)
> >                 is_mem_on =3D rockchip_pmu_domain_is_mem_on(pd);
> > @@ -557,16 +558,21 @@ static void rockchip_do_pmu_set_power_domain(stru=
ct rockchip_pm_domain *pd,
> >
> >         wmb();
> >
> > -       if (is_mem_on && rockchip_pmu_domain_mem_reset(pd))
> > -               return;
> > +       if (is_mem_on) {
> > +               ret =3D rockchip_pmu_domain_mem_reset(pd);
> > +               if (ret)
> > +                       return ret;
> > +       }
> >
> > -       if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is=
_on,
> > -                                     is_on =3D=3D on, 0, 10000)) {
> > -               dev_err(pmu->dev,
> > -                       "failed to set domain '%s', val=3D%d\n",
> > -                       genpd->name, is_on);
> > -               return;
> > +       ret =3D readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd=
, is_on,
> > +                                       is_on =3D=3D on, 0, 10000);
> > +       if (ret) {
> > +               dev_err(pmu->dev, "failed to set domain '%s' %s, val=3D=
%d\n",
> > +                       genpd->name, on ? "on" : "off", is_on);
> > +               return ret;
> >         }
> > +
> > +       return 0;
> >  }
> >
> >  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power=
_on)
> > @@ -592,7 +598,11 @@ static int rockchip_pd_power(struct rockchip_pm_do=
main *pd, bool power_on)
> >                         rockchip_pmu_set_idle_request(pd, true);
> >                 }
> >
> > -               rockchip_do_pmu_set_power_domain(pd, power_on);
> > +               ret =3D rockchip_do_pmu_set_power_domain(pd, power_on);
> > +               if (ret < 0) {
> > +                       clk_bulk_disable(pd->num_clks, pd->clks);
> > +                       return ret;
>=20
> Looking at it, we shouldn't return directly from here because the
> mutex never gets unlocked.

Yes, we should do that after patch 2/7 from this series :)

> Instead of repeating clk_bulk_disable and return ret for each failure,
> we can initialize ret =3D 0, have a goto: out pointing to
> clk_bulk_disable, and change return 0 to return ret at the end.

Right now there is only a single clk_bulk_disable() in an error
case, so I did not use the typical error goto chain. I suppose
it makes a lot more sense with proper error handling for the calls
to rockchip_pmu_set_idle_request().

Greetings,

-- Sebastian

>=20
> What do you think?
>=20
> Very Respectfully,
> Peter Geis
>=20
> [1] https://lore.kernel.org/linux-rockchip/20241210013010.81257-2-pgwipeo=
ut@gmail.com/
>=20
> > +               }
> >
> >                 if (power_on) {
> >                         /* if powering up, leave idle mode */
> > --
> > 2.45.2
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip

--pgyuyhmom73rgyyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdZ+fcACgkQ2O7X88g7
+poitxAApbTTrpEjlB2v52/YhGg5DXkiutsrUhEmLjEn5X8QpxlCWLwT0NXPGdgi
VbJKJtKTrJAHlE1ckkg3XApoJbqSHWqsjOtvc6m8D1GINUKOiK3sj8DUg6EK/dTy
PVGXwigbmpjud6JcbRLSLarsdoCu4SAuuIr77Lvw/b8f29mpA5AeAEQBEgEdCGpX
WBcNaYdmnSKy341CqQHISRteNiTwooY0s+22MaSfMErxyv1yfCYdzKBHq9p5wSi5
Txq5w6oKZ5ASPzStI7jX/KK7Dl6eqi8I91bxbP+ddPHtVw+7LWzPmk3lu4/Zc8pq
qiPHQ20psK4XeSfhFHGl0aElE8x3LD/CFydUa3VM1gkz8tofcgQgtfZ9p/in7TKj
e7uc4I+KbJQx89Gz20ioAC3q92o179O6JqbomKoYyEcsXfSpzrDwZ2X4g3X+mvsM
IRetDXYaakkfYfiRK8I36FjP/kiPRBaS3vlch1k+j8wgyVJmgV8bGrNejET/U0ls
+hrz3lheTZoPw4caoqn7mGQy6iIcMfk6C26IgYWtGgmhgTJn5L/K/r6pJHXrevq6
m9yKdkJcXbbH5lh5zVFQnbrcGTDI5v+oV5hNKcxpIAwZZF0mJAwb+HWgkn1uSuJu
cBbLIBr5U2ZcT1DmSNDsYSCRufYW87NXv0l8wVVKAvgtc66TQrg=
=FhZH
-----END PGP SIGNATURE-----

--pgyuyhmom73rgyyw--

