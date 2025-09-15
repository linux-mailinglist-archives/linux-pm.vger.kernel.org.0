Return-Path: <linux-pm+bounces-34681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 197DAB580E3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0236189CCCD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE5D346A10;
	Mon, 15 Sep 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ZGOSROZO"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B4345757
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949975; cv=pass; b=cujeHu+/3EWrlU91bSWZPB6HSvI1i8+v1GUI6b3GWgMBwqvjrN4jDPtDm8yJNydkKXPOFhdpUSg3fqttgYnODQPvMlusvPR5p2olmN2D48o12Qn4PS+cSAoUedYTEkXKkyfiFNHLEc0KVnsugeZFXmL04vusar/ftWTFJmUdvB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949975; c=relaxed/simple;
	bh=NOX4t3/3jYSsSTxuNIdevOO5Syrt8fLEdE11Y6YdoIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef27HwJvCV4eqAkZ2vBrn3s+vkK4s56ZpQfFRHa3NcLklENq/0Wf8Iy1fdPabavU6B5MAIkJ+C6Wx7fCvT+AqFilQYd6S6oE5/81HJdwOtd7D577JqiCRcDYrP1YjhFsyLUcbWu83dPtM0OVyPy1yCt9kTbs8G/PSYUnbMuuDUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ZGOSROZO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757949947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PSy8dSqxGeiE/oQqovIV14JncIs3/Rcyd35zvabY+geBZ08L5W9wdhqYYOB7pk7hQMK6mJEnzC4Fgr3SjWGX1aDjYSOfR7AKCM8eVAyRtYO1GzDbcKp3AUnJW6SnRGl7Fq04xjsX3WTZjnW06EVp+st2gjTBP7D3tytd24o6sLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757949947; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vaoFRPg+tKr9b78Dr0wEFewD1PbEo84vKDgkRDmE524=; 
	b=I+ll/ectiNrHFuvcKI4jXFqAnIEtvFMGUKxs2IHykRXkccI+lJrnRQzdT50HIzHZDLRZxwcyI6MNPZcqXoRzzL7bivXRQjGfPmkBTv/dlfE0iQDW1OHTRPrnLARxvtORjopLSuNXxbu2wnX0mu+LgGA9m7iZGz/IrmKP/u9xpiU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757949947;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=vaoFRPg+tKr9b78Dr0wEFewD1PbEo84vKDgkRDmE524=;
	b=ZGOSROZOL+Vec/sqVmS6fGwutBrvmELerMlQqXysB7D62UCZdTWEHOzurAYU7G73
	bsR6eBh+IK/x0lnuU/uUH+e2VZFE8xnXZ5LLpsVauMge9sdeon8zTzZiahoC5E4Rift
	WEP7+6b93R969ZZJpDFilgam0hSQgtdnUNJsVbF4=
Received: by mx.zohomail.com with SMTPS id 1757949944890797.1711543955779;
	Mon, 15 Sep 2025 08:25:44 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 254FD180BBB; Mon, 15 Sep 2025 17:25:41 +0200 (CEST)
Date: Mon, 15 Sep 2025 17:25:41 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 9/9] power: supply: max77976_charger: fix constant
 current reporting
Message-ID: <7awe2cieliyncwdkpgmralboramhaik5p3uyukv3rgzilnpsc6@gid6eeg64xun>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
 <20250911-max77705_77976_charger_improvement-v3-9-35203686fa29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nwf6vcedawbu4iq7"
Content-Disposition: inline
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-9-35203686fa29@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.892.47
X-ZohoMailClient: External


--nwf6vcedawbu4iq7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 9/9] power: supply: max77976_charger: fix constant
 current reporting
MIME-Version: 1.0

Hi,

On Thu, Sep 11, 2025 at 08:57:17PM +0300, Dzmitry Sankouski wrote:
> CHARGE_CONTROL_LIMIT is a wrong property to report charge current limit,
> because `CHARGE_*` attributes represents capacity, not current. The
> correct attribute to report and set charge current limit is
> CONSTANT_CHARGE_CURRENT.
>=20
> Rename CHARGE_CONTROL_LIMIT to CONSTANT_CHARGE_CURRENT.
>=20
> Fixes: 715ecbc10d6a ("power: supply: max77976: add Maxim MAX77976 charger=
 driver")
>=20

^^^ this newline does not belong here. Also you should reorder the
patches in this series, so that Fixes (i.e. this patch) are at the
beginning.

Greetings,

-- Sebastian

> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  drivers/power/supply/max77976_charger.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supp=
ly/max77976_charger.c
> index e6fe68cebc32..3d6ff4005533 100644
> --- a/drivers/power/supply/max77976_charger.c
> +++ b/drivers/power/supply/max77976_charger.c
> @@ -292,10 +292,10 @@ static int max77976_get_property(struct power_suppl=
y *psy,
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		err =3D max77976_get_online(chg, &val->intval);
>  		break;
> -	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>  		val->intval =3D MAX77976_CHG_CC_MAX;
>  		break;
> -	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  		err =3D max77976_get_integer(chg, CHG_CC,
>  					   MAX77976_CHG_CC_MIN,
>  					   MAX77976_CHG_CC_MAX,
> @@ -330,7 +330,7 @@ static int max77976_set_property(struct power_supply =
*psy,
>  	int err =3D 0;
> =20
>  	switch (psp) {
> -	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  		err =3D max77976_set_integer(chg, CHG_CC,
>  					   MAX77976_CHG_CC_MIN,
>  					   MAX77976_CHG_CC_MAX,
> @@ -355,7 +355,7 @@ static int max77976_property_is_writeable(struct powe=
r_supply *psy,
>  					  enum power_supply_property psp)
>  {
>  	switch (psp) {
> -	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  		return true;
>  	default:
> @@ -368,8 +368,8 @@ static enum power_supply_property max77976_psy_props[=
] =3D {
>  	POWER_SUPPLY_PROP_CHARGE_TYPE,
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_ONLINE,
> -	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
> -	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>=20
> --=20
> 2.39.5
>=20

--nwf6vcedawbu4iq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjIL/EACgkQ2O7X88g7
+pqGXBAAk/KnXxC9J9LKzzcf8Vbp3jf0tX/RMWcNuKQhw/E0d9v2c26ApNsULMhC
eXkYH53iTjr/ZlbsIFLkhEWam52Wl7au4jpl9lXE9gLVFGSAfY9szDinibjzMCh5
IiT0XQ1ASRe9yJjLuzTPRSKgCMgmtNJH8tDyD92MevLnOFJf1kT6cUtRlyOehdia
mf2/H7Op2Aww2pHwizRLo+yRdqOQs6LPEtOV+MW7VkJl3tuSQD20RSC/LCMwflMl
e7XwAWCSW3IaGwikWJeCUaXCDx2/Zvzf7KcHS+akm9FctYQXWbr8Ro/+rVEJl3Ng
g93nz57k6iFB2+Je2CNnjXqvT4Vs2St0odcnl5uPtUySg+YNIAYs2ROhNaFMBH8y
G0AvdOXUbxi5Nk5HdsyceE++qexk9JPEmiNhps5Kux/39TSQTZhnozE/T2rL3Kzj
aCRIYZhJXGlQx5u4GjbJjn2OAKfnrd4kKB/ZX3MfrhO4ACBHQANgEYbVS9j+p23M
EoImIcmjP7f8Yjm2k0eSQgoXqOLMzWMVqYnouS9OLdPEyRNvs7246GRu0VIzrXyi
FpUcDzBDGpuKUu8/r/5gbqEdgF5/9uIES+exZUaSdAjqlRZLt4YjTyJr9TqM1J0i
MEddmWQNTawU3IgbbwWc8TRg3ZwzwO3xg+PHpXBsYdPkS1GLysg=
=bDLC
-----END PGP SIGNATURE-----

--nwf6vcedawbu4iq7--

