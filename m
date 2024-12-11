Return-Path: <linux-pm+bounces-18977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075209EC1A7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 02:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CBD1884FE1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 01:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8078F59;
	Wed, 11 Dec 2024 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iLXQvmIz"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540C3A8F7;
	Wed, 11 Dec 2024 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881102; cv=pass; b=RYePl54Up2v4q3QtqxGGPIC6VW0GeUxJBJqaJl5mxHQpXbobIGwE9ezDsUQg0CoE89GhwGdXvbjA5KO+SQmtwW4v2GmUmVwAy+al1U6Sur8m4ZnsLcqbVR3AI+l7urXi9qGCK/eAEgFbm02FridztEObnO6X+ExEAF8L95QlO78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881102; c=relaxed/simple;
	bh=MiANRQxAdGZ9xEmS1eGwBnT+TtfM8IekXWmhnbTeeJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncvv3hwwh4sewkuNwd3iI6+3pMdH7VlpfpzxO5gXAHRLe6gTjL7ZhO4KJ6uY6n49/7KgN94e3YQOB4ddkP/HQDLpX8B8B8r4SUPeZCmHkAlxDwPK5N4Off7GoY+IpcbaqBFuPS+BbKZmKmIv4qS79JK8umA47yl7BtQE3sJR3cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=iLXQvmIz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733881091; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MBbJ6zXRPQCvT/XYWEwRK20WqjTmUqwU16AiK4vyrVhNj/jHI/BhIhqlrKjhXO0G/fxUu9GbaTYAoxzAa+rIeCcHZemngcSgtl/eh7vK5MCBaDj1TmRB9zLWdtMEtdvZMggo66LqvC9DjOn/Mzeck+DSWbkjr1cZFD26ssZmitQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733881091; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i5QT+7FiT6szOyqoDxYnm2QjssftX3943ZiJ+wM6JZM=; 
	b=IvluER+xWZeoKGtYBmI4qjXR0zOzaYpNfoSJeSgCzLsG9U2pRBULhGp567xLuokXQiMrL5Hy7DQZTROWHR27yv5RmkormaGoB+MyDk2S2BbwIjdM54yjIeTWKT2LlrlO4ZVW5mgkThHWhFAq0rkrjYNMEgWpWhOX9TQdeHFVvjs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733881091;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=i5QT+7FiT6szOyqoDxYnm2QjssftX3943ZiJ+wM6JZM=;
	b=iLXQvmIzD4wQRi76Q+4y7LuJO/nVikOQPc4jQ/LZKc13jLdvOdqSC1tfOwdotlOd
	tIkyF75XoziQj3QexsQPiqXJlRz0PVhRS9y32OgX9atYaErXilVkGLdnoa9TZ+MqPVd
	Yp6KlTiWJemeZ8u0mBke7Ij2XxwzmSHW2KccWPF8=
Received: by mx.zohomail.com with SMTPS id 173388108866529.45962812053415;
	Tue, 10 Dec 2024 17:38:08 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 63B0B10604B1; Wed, 11 Dec 2024 02:38:03 +0100 (CET)
Date: Wed, 11 Dec 2024 02:38:03 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] power/supply: Add support for ltc4162-f/s and
 ltc4015
Message-ID: <b5mhivpuhyfj3knw3w5wmi2kxyyej7cdnh3kd6wyenumfy7qpr@vnfvfj5gsmtx>
References: <20241210060506.10295-1-kimseer.paller@analog.com>
 <20241210060506.10295-2-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esba6m4ei4fw3vbd"
Content-Disposition: inline
In-Reply-To: <20241210060506.10295-2-kimseer.paller@analog.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.855.81
X-ZohoMailClient: External


--esba6m4ei4fw3vbd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] power/supply: Add support for ltc4162-f/s and
 ltc4015
MIME-Version: 1.0

Hi,

On Tue, Dec 10, 2024 at 02:05:06PM +0800, Kim Seer Paller wrote:
>  static int ltc4162l_get_ibat(struct ltc4162l_info *info,
>  			     union power_supply_propval *val)
>  {
> +	const struct ltc4162l_chip_info *chip_info =3D info->chip_info;
>  	unsigned int regval;
>  	int ret;
> =20
> @@ -249,9 +356,8 @@ static int ltc4162l_get_ibat(struct ltc4162l_info *in=
fo,
>  	if (ret)
>  		return ret;
> =20
> -	/* Signed 16-bit number, 1.466=CE=BCV / RSNSB amperes/LSB. */
>  	ret =3D (s16)(regval & 0xFFFF);
> -	val->intval =3D 100 * mult_frac(ret, 14660, (int)info->rsnsb);
> +	val->intval =3D mult_frac(ret, chip_info->ibat_resolution_uv, info->rsn=
sb);

ibat_resolution_uv is in picovolt as far as I can see:

1.466 uV / RSNSB =3D 1466 nV / RSNSB =3D 1466000 pV / RSNSB

RSNSB is provided in microOhm and picoVolt / microOhm equals
microAmp, which is the unit expected by the power-supply
subsystem.

>  	return 0;
>  }
> @@ -260,6 +366,7 @@ static int ltc4162l_get_ibat(struct ltc4162l_info *in=
fo,
>  static int ltc4162l_get_input_voltage(struct ltc4162l_info *info,
>  				      union power_supply_propval *val)
>  {
> +	const struct ltc4162l_chip_info *chip_info =3D info->chip_info;
>  	unsigned int regval;
>  	int ret;
> =20
> @@ -267,8 +374,7 @@ static int ltc4162l_get_input_voltage(struct ltc4162l=
_info *info,
>  	if (ret)
>  		return ret;
> =20
> -	/* 1.649mV/LSB */
> -	val->intval =3D  regval * 1694;
> +	val->intval =3D  regval * chip_info->vin_resolution_mv;

I believe it should be vin_resolution_uv. Microvolt is what the
power-supply subsystem wants and 1.649 mV (from the comment above) is
1649 uV (from the chip_info->vin_resolution_mv value) :)

> =20
>  	return 0;
>  }

Otherwise LGTM.

-- Sebastian

--esba6m4ei4fw3vbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdY7PMACgkQ2O7X88g7
+prZOw//Q9E81WqnzJLQB8b1yVZZRDrkWWCkh3Szb4nJa9ejJcxu8un4xz/PMlO0
yBxnavwvni/qrPG+ctI0gBg952XSeY6CqMdx2ZzUt93BjqE5VsaQXa2PyKmfOmrb
JM63fjjJbCzRMnsUEobmoMQjILZNFC93c7Iy+XDSXzVeTS5WL4lU9i91TkSAMTNC
r/Erb/l9Xv9wa+yCgmvZuMRXS0T+ef0+7iySJVFV9vAJ1ywPjhybJsvtmCdjH+Oq
BuP61RfDc8fbsm77VJoVhKfZCSwzrhcYNRNrC5r7xYDbobZnZDqmu5bUprN4ld0j
5KgFeQ8blpFT+cyl6DWQJxe5obX9XM6xroWJMy5vG3MzN9DktkKews9SnXErcSOi
hR061UxKPn9qy8cEwI5ATZSPhA596pIcQl1LVI4qJazYrdrHxFKpWJPAcY2+fW4+
yK4uD+R1sJbfupukfa1dW+suvyTQJF0xpfZvqnSHs6GuMOhXK0m8oGqOwpRq6f8b
UcLroEuFBzx3tf6W5oX8p3RqAwNr/QgVJayQvl7l+DDgWTcLRp4TBcaD5mMWZn2U
Y5cO+PRSxplVDaqSg/gEOArVglT6WPDYJfJ3O6fYAVV5b6F7CxQ03hLOpzJQJ3+H
MaEHozCOBf42+PtoxJPLGKkT9uSg1ZYunVZbb/kW1Bho42JSmL4=
=DZFE
-----END PGP SIGNATURE-----

--esba6m4ei4fw3vbd--

