Return-Path: <linux-pm+bounces-35074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A1CB8AEEA
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3878B60394
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB88255E53;
	Fri, 19 Sep 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="YV9ytXFo"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F985211A28;
	Fri, 19 Sep 2025 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306945; cv=pass; b=smWkOah8CZ+58S0yygopmoEX5A1iwbrVpHTM9otr3pW8ApR2MUomSZwLYiwauESpO1b7TuIrtSjjPfpO5oMbr1gfy5/2+8Qm3HxBe5X6DmDWjyP1TJ0vENtcvx9r8TYF1/o72IfeRf/zoYKbrscpkIqBWsorh5lgaX2hNyjLS8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306945; c=relaxed/simple;
	bh=jwmcTQDxHnCEVCjF/im4fIO6wwzyKkjwMBLb+svDjF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdmLu7Fex1r+TbYAUY47WQqLkwzTZMckhILEf4IpsrSmWw4doeqe2pv1g2XwT6IZaRziDTP6K+/AJke+ijYIj8g3+9cVF7g202SolSxsrOaIb2iA4tK6Xa7Vgt4ZEoJrilZRmF6G/XzVraMjDwzwKvOwACJPgewBDUtcrR3qN78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=YV9ytXFo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758306920; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=htG9dmLjIm0MG2EAmEP+UrylffFxxizBi0dVjBCvRmBURsoNR8MsxJEFhYRutXp0Fysgs5mJKW7LfTA5S/FAV2whT6yUFacOAcZlhHvoYl+10VZS/sx90FewlnYaoq68DudIs3X+V2TBk685Gg5Ygd4AqsgFdxZuC8fbBbvziQ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758306920; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dYelWx50Z6ZFoqvuH3SnrsBA9SoBu2/C8F6gLHongwI=; 
	b=KoRWFVnAJBHxlBFqLIUDk52BG3W7aMbzso37/jhmFISHK4UId+Rl0cj8jZ5+jJNzepmRHLWRnFzFDVyzzp+/MKuPSovrns7RNliKv6pjUAIB5kNchHQm28Etg6gP92ZPsXeD4Hu2i4bo5ErBFpvAYAVwKzvqxIAorGctH1UX47Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758306920;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=dYelWx50Z6ZFoqvuH3SnrsBA9SoBu2/C8F6gLHongwI=;
	b=YV9ytXFotHoYhZPB6OmOKBkk7wp37V53wLcLRgPnQ7jQ5ctaacXRy15U7vNqy6Rx
	2tYGRW4dTr3xn1cHgAvvUGPovYReGbHaciguqaBHCJnXyrdSjYm3sJvVl+V9vZp6yik
	s2lEVJE5pOef9f3Q4VKNXQg1quHIJA9IltV8iLrg=
Received: by mx.zohomail.com with SMTPS id 1758306917364249.0348507446621;
	Fri, 19 Sep 2025 11:35:17 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 1DCFD1805C8; Fri, 19 Sep 2025 20:35:12 +0200 (CEST)
Date: Fri, 19 Sep 2025 20:35:12 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Conor Dooley <conor@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Diederik de Haas <didi.debian@cknow.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: rockchip: tighten grf
 requirements
Message-ID: <wtwdpqi4tk3ixzmrvdyv2aguf6pjlmnz6q5gvhlajl2hk6mdys@fmkugriedhqe>
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
 <20250820-thermal-rockchip-grf-warning-v2-3-c7e2d35017b8@kernel.org>
 <20250820-await-chomp-9812902c0f74@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z6crpzxibzcnj3de"
Content-Disposition: inline
In-Reply-To: <20250820-await-chomp-9812902c0f74@spud>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.269.22
X-ZohoMailClient: External


--z6crpzxibzcnj3de
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: rockchip: tighten grf
 requirements
MIME-Version: 1.0

Hi,

On Wed, Aug 20, 2025 at 08:48:23PM +0100, Conor Dooley wrote:
> On Wed, Aug 20, 2025 at 07:40:49PM +0200, Sebastian Reichel wrote:
> > Instead of having an optional rockchip,grf property, forbid using it on
> > platforms without registers in a GRF being needed for thermal monitoring
> > and make it mandatory on the platforms actually needing it.
>=20
> I am assuming that "needing it" means that it was actually mandatory but
> the binding was just missing the required required entry. If so
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I just noticed, that I never replied: The GRF configuration is
required for proper functionality as far as I can tell. Technically
it might be skipped, if the bootloader already configured the
registers correctly. but I don't think this is something anyone wants
to rely on and with the same argument we could describe almost any
resource as optional :) The upstream kernel DT always had the GRF
specified for these platforms (and thus most likely has never been
tested without it).

Greetings,

-- Sebastian

>=20
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../devicetree/bindings/thermal/rockchip-thermal.yaml     | 15 +++++++=
++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal=
=2Eyaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> > index 573f447cc26ed7100638277598b0e745d436fd01..9fa5c4c49d76e3a689f3179=
7875124e7fb30d3df 100644
> > --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
> > @@ -119,6 +119,21 @@ required:
> >    - resets
> > =20
> >  allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - rockchip,px30-tsadc
> > +              - rockchip,rk3366-tsadc
> > +              - rockchip,rk3399-tsadc
> > +              - rockchip,rk3568-tsadc
> > +    then:
> > +      required:
> > +        - rockchip,grf
> > +    else:
> > +      properties:
> > +        rockchip,grf: false
> >    - if:
> >        not:
> >          properties:
> >=20
> > --=20
> > 2.50.1
> >=20



--z6crpzxibzcnj3de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjNolcACgkQ2O7X88g7
+prySQ/+Plmvb6VuG/3iqahgjq/5DSN+60ggmi/i0BADm5v2odvaNmggYliwfw6+
xjNfvblePAiRBF5bIfp8PYoBDmoOR1l56cVxPmtg90/UOA6Q8ZbGoPZGLoMWmANx
3WoqzlXwRG6yXus0PTlKarXalAbSShc5wXkN+KgscOGdIxx5XXhGwjUSWVdiuy8q
L0q5fBR1uYU6QHNUGNzM/H6GEPylQHbApFj2UEkQm4cb1QvSEq9I2HJ8bV+yOfhv
0WmIk0fzyVn5FREYCVT+DQmd7Z3VRcWHtwgtXIzonxJIRLmJJWwl2iLTSPBulWYN
EKAIHiqq4ak6FI/COHHid8czjM0/Tk7oMlDPkk8gJT9SgPzwvwR+xeLrOI+Nyk2f
aBqBUTL7Y+LfrOe3I4TA2ljQtD7qL2oDixqqf/cTIR7Mk9R83A5Zem3R4qdyGvOt
FoFbQ4mcmhqYeXxglKyDExMuxUC5vxcAL/fq2KFl+aNWX2Adzue3Kkjow0NMeQA+
3880RR6Pn+tU2RikQvBhwk5WG6CTcPjgH5PgzzBZ4N8zhUARf8/J1bctqaCMYBiV
XSWG1x+3Rtsxq0DHZVR640Ly89r9BWMTQxH5UKNhbrGmXum0V1RUerIT132ew7M8
5afmV/udl4nk7VNzgkip02aBFKkpaLCGAk03LWDs0U0rPgksp4s=
=9GvR
-----END PGP SIGNATURE-----

--z6crpzxibzcnj3de--

