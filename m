Return-Path: <linux-pm+bounces-32647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A108BB2C660
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD731887CAD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640FF340DA9;
	Tue, 19 Aug 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="HjtQkpiB"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD74315764;
	Tue, 19 Aug 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611831; cv=pass; b=tb2fNRYBTga2A11jpkiEJ6vTPKR84lHL2iDPSYFGisDRAfYeLd0AaBJJJwLLtIi0hhQokPpudHWfwbRbiwz9/z+b33R66GNw0v+qt7HTwqeqQ4ddx/w0cLrLemMrq72xjvmk6MhJhtP5Wlr98uK8wRQhxMQfjDJZ4OTn4tKJgMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611831; c=relaxed/simple;
	bh=siIuB7E5RuDmJRrOtoekNeqihP3rWs0Gd1r2NDCqj0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE7lERhlFM3cqmHGZlWjLqonJJ6X7l1nIgBabKasde3xM/Db978K15Fwc9yDXyBw87vLRcKHMi8//zOxWASGDeHs+Fy6AZYl12KT4ZSWk1hHPgAN92+3YhdKnRmEfdMW4qMvk2v9JRWHCMX3x0AQNJjDlQB7Eaesr4yqxSs+mrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=HjtQkpiB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755611809; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZCMUSAll8tGFsfWE3sejVYCcVWf5Qc0xiokdv1UxFrPoeC158s5ymXIOeqRf80wg/7skP5M8/0CSLbUpTwviaH9EfcDPMld7hLmsSJC8py3N6onQufLdAYG5aZxLOkZEk27QBXNUizrncIHEQuipHt2IqmiWe0Y3oFV1NIjOTrg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755611809; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1fLGX7Z92TWpFmAbWT3RBld7Fh5XrpEPjWou6NmLyE8=; 
	b=Iw6cR/I/mUiQZ1j66N7vK2QOUXGLVmsSk4MbmiLUx+c0GNHhwgVVpmoQL/1wrA1BmCTbF1j/0ZS+AOxWC+2L6kIor79bUZlQ/hGtfsj0n0iLqYcARTTepZi692B2z9NRPngag4lEyTRJsqfVdh25Ij4ywnFvYdlAgwtQByOAS60=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755611809;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=1fLGX7Z92TWpFmAbWT3RBld7Fh5XrpEPjWou6NmLyE8=;
	b=HjtQkpiBS4UZeYakPgWfnedxbKQmjkOXUbxSo8tybZcqxKipdV0Ql7lnOCa3pot9
	Vhs1WCC1/P8gTz6M2lsFJtM/h7Sj5/S8DA1wvUN7btuKLOWijo3ZIaZXNZYA8Ts3Ykx
	GanKwE9I0go9GQBH+mmNmvUzF/a+3ACmUW32S1mk=
Received: by mx.zohomail.com with SMTPS id 1755611806229393.72059155561476;
	Tue, 19 Aug 2025 06:56:46 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 59C1018042F; Tue, 19 Aug 2025 15:56:42 +0200 (CEST)
Date: Tue, 19 Aug 2025 15:56:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH] thermal: rockchip: shut up GRF warning
Message-ID: <ciuhfx4u6xs2g43hn7nzjfmhaakfip6ndcpftuvg3kgzf52zkt@3vyvcjflmtqm>
References: <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
 <2c7301cd-9c86-47fd-8b79-05f3e1a89e47@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q2jdxdvsv6fcwf45"
Content-Disposition: inline
In-Reply-To: <2c7301cd-9c86-47fd-8b79-05f3e1a89e47@arm.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/255.592.7
X-ZohoMailClient: External


--q2jdxdvsv6fcwf45
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] thermal: rockchip: shut up GRF warning
MIME-Version: 1.0

Hello Robin,

On Tue, Aug 19, 2025 at 01:42:42PM +0100, Robin Murphy wrote:
> > +	if (thermal->chip->grf_mode !=3D GRF_NONE) {
> > +		thermal->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> > +		if (IS_ERR(thermal->grf)) {
> > +			ret =3D PTR_ERR(thermal->grf);
> > +			if (thermal->chip->grf_mode =3D=3D GRF_OPTIONAL)
> > +				dev_warn(dev, "Missing rockchip,grf property\n");
> > +			else
> > +				return dev_err_probe(dev, ret, "Missing rockchip,grf property\n");
> > +		}
> > +	}
>=20
> Nit: Does the lookup itself need to be made conditional? I think I'd
> also agree that the "optional" mode seems suspect, so potentially it
> could be a whole lot simpler, e.g.:
>=20
> 	thermal->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> 	if (IS_ERR(thermal->grf) && thermal->chip->grf_required)
> 		return dev_err_probe(dev, PTR_ERR(thermal->grf),
> 				     "Missing rockchip,grf property\n");

I came up with the enum, because I think most platforms having
"optional" GRF support actually require it, so I want to keep the
warning. At the same time I don't want to mark them as GRF required
at this point, since that is potentially a DT ABI break. It really
needs to be checked per platform in the TRM and/or by testing on
real HW. With this patch we can easily handle this platform by
platform by moving them from GRF_OPTIONAL to GRF_MANDATORY without
affecting the unchecked platforms. Also switching a platform from
optional to required needs to be reflected in the DT binding. So
this involves a lot of work. I think it makes sense to carry the
slightly complex check in the driver's probe routine for now.

Greetings,

-- Sebastian

>=20
> Thanks,
> Robin.
>=20
> >   	rockchip_get_trim_configuration(dev, np, thermal);
> >=20
> > ---
> > base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> > change-id: 20250818-thermal-rockchip-grf-warning-05f7f56286a2
> >=20
> > Best regards,
>=20
>=20

--q2jdxdvsv6fcwf45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmikgowACgkQ2O7X88g7
+pp9qxAAk+4ty3D/wGDRf7N4T9SpE27oJSSbTDICM9U3L9yjBV/fWCx3HW07ZCkY
F7pr7ZOGSoazsKL0Q8VtyYty1uZi9ZvjytKuDHfNeTVjRSMEKnN5EhBgGahTTnOu
75Sh3EE/FDE+Mv7+xxmPoGHbXhGP8H9afxbUyPKVfoYbk1PaTF6U+LqLb85Zm321
cWSrBJ/Pwx3g5h/Pm4y9v8Kmm3i1cKzeUdzW0vErviCNPBmEwZleQE8QtGHxS7BA
7gNz4w7OWPhdQENSBvFSDmC0RtnLgySDuvQRhdAEzEEm9qC5YpuSDRCgUEu7txZA
j9cA51D6P5DmUf67jVQzORXZv2ZaCnEfkDD96Ru3HG1wSi6jwtwcGJDB6fb0yQ7h
Rv1AaGLrR148PjPQml3DfFvEryP6bQ8DFkFQPesRhT4vKHyyXZk5o4SiQbUKK+7Z
PgZqCuKf2krjjh0yZo9hcGJQ/k01qVnkkNzpHRYJZzRC9/fzJfJhpCVYAzBirypI
JtTMZXJHbXjcA1NVui//3JL6hI/iT0bTpiACq2TR54A+3sA1WKEQcHUL8+/b24nr
YxUZgA4XJjlMn1Qt5Isr7R2T+PxMbQiKNauf+5jGxS7GnZVW3thQMvRR0yUbjr8w
k9luAhXGrsFJhrjkFSSWERZ14uOpvlI6xrEMVs4Uut8rRGi6tIU=
=t7DZ
-----END PGP SIGNATURE-----

--q2jdxdvsv6fcwf45--

