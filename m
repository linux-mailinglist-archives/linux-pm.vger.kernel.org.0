Return-Path: <linux-pm+bounces-29229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B11AE31A6
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCA516D02C
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA81F4C97;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="G/MDe6Of"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E718B47D;
	Sun, 22 Jun 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619599; cv=pass; b=nh28qV7+oLNhHNvGR/zBuq3IcbbDQ2VaZ0HjuSKLoYemKlx5knY1rTUNRTfO1oUODowzXZh/3berJQTDgmssVeaQOGgql/f4wmEICI7YDH3hrOMfkRr/ky7ixyoDcJj0Li71SzfU3qIPOSD+0KRg4p62MMVwWVh8OPLPOaUGIA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619599; c=relaxed/simple;
	bh=FbMp3gjLk5gVyAdfkveNcQgNf6kUDTS/CGT6Y+zSPAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS8YoYrdn7JrbhUAnLFPul36n0N6Q7QsL1yxS8jEihJGI2gWGomFqPPmtQD4cToDE4JYO1Gai2fV4Us31Y/LKF/9cIyklYYtfh2Cf0zPBkb8SFpF+eCbYNgMW+/IMGZ/Mf4JpmBpyY1BBlOg9Y2a0M1rcHXn5aPl+xRhbH3dgTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=G/MDe6Of; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750619589; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SPXiDnQKM1mTIbIh98WRkRaiDN5nBmVz+Hps9oWkEHiesZmBNCK3hNOa6gtzdhx1wVd7wtivbLY/NQkR4oIc62AGerGzlkXNkMX6NYS38F+T1dD30GA9XVj0bhVywNHerbMWVd0PizOO7ZxYOsXsLwhNwVvP6JW6BHe8YqlcJ3I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750619589; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BlksCamW8VABl/VrrYkbxTiBGyTzRwySRk0D7nJ21so=; 
	b=jmIjrCvAInyd6lIJxkwsr4ucg4Pp9aP9RPRKbV1Y0VtN8Jh+ZCtJbKfWrM0tzL3/mZSz2iP6z1SQWx8tJiGUHXGNkU6xWuSdCStZ8EWJkBnZdUQX9r+GWoD1goRsf7JeIUR2G1JwbquvskwuGfq/S06vzTowxBDkqPklwCZRx+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750619589;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=BlksCamW8VABl/VrrYkbxTiBGyTzRwySRk0D7nJ21so=;
	b=G/MDe6OfIfzCVb99o8bb7883Cg9sFVVTb4WIUeFZrU6Hb+twnxcy0i+RkUgM1aTM
	tbmNtNIJexaQAqa4Oq/B3tjtTAN3yWAdnt8ttG3WVhZKWuEcskJvh4NjlCmg0ap3rRY
	YjjwKJwWsK8r4SKf7wo/rJr/qq7VwayL82d6JQMo=
Received: by mx.zohomail.com with SMTPS id 1750619588122328.3230636833241;
	Sun, 22 Jun 2025 12:13:08 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id D616A180958; Sun, 22 Jun 2025 21:13:03 +0200 (CEST)
Date: Sun, 22 Jun 2025 21:13:03 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 05/11] power: supply: qcom_smbx: allow disabling charging
Message-ID: <yozzr47ewgi3rtt6hv2si4iivyhhrkaapa7f5vr2mqkt26lfq3@fxt7hqfljbry>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-5-ac5dec51b6e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="anr4msjpopnv2hxv"
Content-Disposition: inline
In-Reply-To: <20250619-smb2-smb5-support-v1-5-ac5dec51b6e1@linaro.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.601.42
X-ZohoMailClient: External


--anr4msjpopnv2hxv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/11] power: supply: qcom_smbx: allow disabling charging
MIME-Version: 1.0

Hi,

On Thu, Jun 19, 2025 at 04:55:13PM +0200, Casey Connolly wrote:
> Hook up USBIN_CMD_IL so that writing "0" to the status register will
> disable charging, this is useful to let users limit charging
> automatically.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/qcom_smbx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom=
_smbx.c
> index b1cb925581ec6b8cfca3897be2de5b00a336c920..fc2a8e20435639a9da4d966c4=
3271beaeb57a03f 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -692,8 +692,11 @@ static int smb_set_property(struct power_supply *psy,
>  {
>  	struct smb_chip *chip =3D power_supply_get_drvdata(psy);
> =20
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return regmap_update_bits(chip->regmap, chip->base + USBIN_CMD_IL,
> +					  USBIN_SUSPEND_BIT, !val->intval);

I planned to pick this, but USBIN_CMD_IL is not defined before the
smb5 support patch, so this is not bisectable.

Greetings,

-- Sebastian

>  	case POWER_SUPPLY_PROP_CURRENT_MAX:
>  		return smb_set_current_limit(chip, val->intval);
>  	default:
>  		dev_err(chip->dev, "No setter for property: %d\n", psp);
> @@ -704,8 +707,9 @@ static int smb_set_property(struct power_supply *psy,
>  static int smb_property_is_writable(struct power_supply *psy,
>  				     enum power_supply_property psp)
>  {
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
>  	case POWER_SUPPLY_PROP_CURRENT_MAX:
>  		return 1;
>  	default:
>  		return 0;
>=20
> --=20
> 2.49.0
>=20
>=20

--anr4msjpopnv2hxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhYVbQACgkQ2O7X88g7
+ppCqw/+OcaWrJzhVY+NExdI7IZy/LOVP8oXQEayrCtNZZtZsC141P4pgppEL2hP
aEZf2mnpca/FEW9J5jBlrM/aKTYij2WTV2zTIEK1su0AV+iYKW/ML7jfaM12DMlF
SS81xydWcsxghzyhRyJ/XSjZmh/GhNsofuyGhWX31SUl3xzlpj9gSunhZYCViSqQ
RWG+0UkKT9b51KWBppHmg/yZmpCay7rcVsSs2yUDiUn5rAeqcrrn8gGHntDUyiub
eh1g6Nn6esSBvUGJw3c/r7II/4QD5+Mv8S2t4uMJ2vWFenHlHXWtebnbR/lcpwMG
VeSQVoBxVuAX6HFCe5oqvVGHgIJPdST+ZMuSQCJOgVPHSe3xThCk5DoKFYHqSizT
2q2OUeRhNqEs6RtkSikRpCbDQwkpAYdU6CrtOiO3DCZjBxx5C4zBXUz34+h+Q5q/
Sjf2Ob2+00npB6GKACP4SYnClKGE7HE6iQ0yTTYqo87r3qH0A7Qt8VAcLfpIxVQN
bfhIe4bqoShXIAToqB4CP6h9euIHguhae0Zs2hK6knRoeE62uRNYYXVJEuYQFoXO
BpwL/TltLCjlu9/RJT9SM6vaFODBE8CP8Ry41My4dFT3thqikvUrIhjpcmobAXbB
3ehDyE6JwBzdeq41MffexDLJtBgKsHfyodEuleUbyrYU83uo2i8=
=nAG6
-----END PGP SIGNATURE-----

--anr4msjpopnv2hxv--

