Return-Path: <linux-pm+bounces-12992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D4396153F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3077C284482
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E71CF2A4;
	Tue, 27 Aug 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="IOyeCNlF"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18045025;
	Tue, 27 Aug 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778901; cv=pass; b=iXtTYJzrEBOjTRSLkbjVrw7w0P8/KnqHtoprkGSYKjVQH8z2WFirZpvmBcJr2Lcs6EtiumFzliW+XTPl+ctNUNcFmAdABrX9Kt5hy4TnsHSAtBfv/CLOn7hDpVXQ2eZ9PqFetdAg99ecnNfPI3Puit0yXf++FJR7SOO3pEEbWNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778901; c=relaxed/simple;
	bh=nayKPb4tLGx+umAD8NxLT+uZpxft3WYUb0z4jMU2gkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVBY5EQid5JTk/K6zZq92ev1aQy33v+WlMjtInwuOsvQ9E4k89VQsB2yVaagvW/0VBQVf6g804Fzx7bH3Tuw61aCFXs7DcmGamRxJOZjaUVKuZv9UEqWbA+FfVsU5fS45dsN2EkUyIHlvqpLxq7S1H7/4fL9yugGVZ2n71sZp/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=IOyeCNlF; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724778870; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RD5obJxn3/mi7CqGbJBbze69xs+VqGmrHcf4q7XaTSXkF4X6MnSQFLGYH4RaIB3cJlYESqu8ktWvMzaNWpYI9UirRDaEFmk6+ZWPjSXIaoVOg7pcAzJ4f//IjFYakyICxx2ovaQhtl1i2EucFM5apf3TmQZTrAm1dhmij22eJQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724778870; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cDDjGl/Gppuk2pcPpuTmcg+ibp8EJtADXjamce7oskU=; 
	b=VaT+lBBpLu9Ilgw5e0nqlupwp14Zq/wTqfxZS7G6M2K3c/9XFwPCSIz/48tZUbgSdUJeqcQqmY53GuwSLo2VazebgCuYn5hXcd9b0APexCN/4f3tD8M77Lje5b6kvPz9Rlk52+hO5ATTprEhEwm+J+xPbhOtnNhIeE+rbVlTVDc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724778870;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cDDjGl/Gppuk2pcPpuTmcg+ibp8EJtADXjamce7oskU=;
	b=IOyeCNlFKMbn+APGykPNwHCtBZ+EEu9/D3CQJ+3fnO3c/A5jqvZKuMu9N5dh15QA
	cd2x7Agw/cVdlz1BQ6p5vkKlq5FL66p9HEykAvK/AUytRGow5dqNJJMPQ0zj3seG0Cd
	ujLsATJrd4lHa6of8hX8uM73OBdWA+dpbpYeT9eg=
Received: by mx.zohomail.com with SMTPS id 1724778869440810.5604485911801;
	Tue, 27 Aug 2024 10:14:29 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id B5A3F10604BD; Tue, 27 Aug 2024 19:14:24 +0200 (CEST)
Date: Tue, 27 Aug 2024 19:14:24 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Artur Weber <aweber.kernel@gmail.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
	Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Subject: Re: [PATCH v4 04/10] power: supply: max77693: Set charge current
 limits during init
Message-ID: <ek7w5yd2kvmk7qnu3v776dckyjyvdmfahebqbvzfyckwi2szwz@ytcuz22io2cs>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
 <20240816-max77693-charger-extcon-v4-4-050a0a9bfea0@gmail.com>
 <9dbaacdb-5f9c-48d4-a56a-a19ca8809344@kernel.org>
 <021f5a99-bbee-4d4c-b36e-49339030b869@gmail.com>
 <f91048f3-2a97-493f-a35c-0e8f184d77d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="otsejtyezulrljul"
Content-Disposition: inline
In-Reply-To: <f91048f3-2a97-493f-a35c-0e8f184d77d6@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.322.35
X-ZohoMailClient: External


--otsejtyezulrljul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 16, 2024 at 05:40:37PM GMT, Krzysztof Kozlowski wrote:
> On 16/08/2024 16:25, Artur Weber wrote:
> >=20
> >=20
> > On 16.08.2024 11:54, Krzysztof Kozlowski wrote:
> >> On 16/08/2024 10:19, Artur Weber wrote:
> >>> @@ -732,6 +794,15 @@ static int max77693_charger_probe(struct platfor=
m_device *pdev)
> >>>   	chg->dev =3D &pdev->dev;
> >>>   	chg->max77693 =3D max77693;
> >>>  =20
> >>> +	psy_cfg.drv_data =3D chg;
> >>> +
> >>> +	chg->charger =3D devm_power_supply_register(&pdev->dev,
> >>> +						  &max77693_charger_desc,
> >>> +						  &psy_cfg);
> >>> +	if (IS_ERR(chg->charger))
> >>> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
> >>> +				     "failed: power supply register\n");
> >>
> >> This code move is not explained in the commit msg. At least I could not
> >> find it. Please explain why you need it in the commit msg.
> >=20
> > This is done because the call to power_supply_get_battery_info in
> > max77693_dt_init requires chg->charger to be set. (I was considering
> > putting this in the commit message, can't remember why I didn't do it.
> > I'll add it in the next version.)
>=20
> I think that's wrong. Power supply is being available to the system
> before it is being configured.

It's a known limitation of the power_supply_get_battery_info API.
I think it would be best to add an register_init() hook to struct
power_supply_desc, which would be called from __power_supply_register()
directly before it calls device_add(). At that point the power_supply
struct is initialized far enough for getting the battery info, but not
yet exposed to the remaining system.

As a nice side effect the register writes happen after checking the
supplies, so the registers are not written if the probe errors out
with a probe defer anyways.

Greetings,

-- Sebastian

--otsejtyezulrljul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbOCW0ACgkQ2O7X88g7
+pqWrQ/+PyPFHFkRut+MAJpYMoQdpY6HbFaVc/wPgERw1U5QaIeg7WiG236dBjqR
2nmNa/vHaTXfVJRBSPEVP3G+Q0CLgMec8Gw5wNZ2rBi6rBQ3EoWK/YOBHnh6/xD8
zsuSAmjRmgPrS295odE4JRxJV/6FR7keyuBBBXvEdZIk33tZjTlGtpgaVq8ab8iL
ZeUOk4xw4B6r1z0kjaNdlImI/iOK/Jd8/les45cXNem2bVWZ6GphezC+VFNqL+ia
+EnVwEcRMiIJjekED3nN415fB1rIPsY0jyFWuEN1fdSH9+WF8tyBSGls9Efi87Uo
p8BvvK7xAs4mPjVcsE5nwqiduI+Twjg/B/uxm/D49UoMr0p4Tg/53dNUnuuC0WRU
pRNdnHMA2JuwkBBfOEnJ4txjuXAYsb9Kl2QW82tgHJqBDRR/HSGxJK+zd2+JNDz0
Iu1Lx8kKoZyw4zPmr/O6soxgeMPbXMsb/ZB1R4iLLMyTu8EJR8GqjnvIgAQrGTqw
j0Sg774CJ9mutvGwObNFwcvWc898a6k9Km5tCbIsitoc5ZU3sfoIMpgiNWo2dRQD
20V+peZeIGmNKbhPHAroLvvY4wZ7ul83WT4wjyD7Pke6IhDV5cjihsnlAIhgQqup
mT9xWJfUJfB3IpFG04uYHkvAry1+Du+C1LPzXv0v5xkimZHcMf4=
=r5xS
-----END PGP SIGNATURE-----

--otsejtyezulrljul--

