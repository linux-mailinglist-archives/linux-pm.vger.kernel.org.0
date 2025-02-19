Return-Path: <linux-pm+bounces-22521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C45A3CD6F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 00:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35282188F78B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628B25D52A;
	Wed, 19 Feb 2025 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UY8AN14L"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352A1D7E30;
	Wed, 19 Feb 2025 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007481; cv=pass; b=W8rMv5NVd+wbV/01bEU7clgXLlOdE1kpRy3nxZ1zOmd+HT/NPKWvzWE3RmkLunSUKYOLCVbw9hAkJf3hUWkylX+NlCeEnMGcFACrSCeh55g4AdkcswDE30HMTyTBhAEaG4H/gGCIw3YpxizGZ2tLnPhbfunGwFScBVR6hfcjJCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007481; c=relaxed/simple;
	bh=V3CGN0lKF/q3qOU1b4AkppylPzoxF+qb2fu3DPnfT+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJggAntjtAmywxykOC3hpmy1XQLYqoFv0nQ2bZ2hGuRSNYNcvHYZ4MsoVOK6FiTzjv1ZDXfyJnl+nCM6iy/eXr9Yclmug6/2yO5/dDsNXxw7ZKIq96BPFGBLmU//g1EjoYaLAUvvTxBgOXdvHIMLaQFQRTWJMw7i8tZYsQWegFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=UY8AN14L; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740007466; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cagkl/9GedJvHoKsRDGyVysBN0UPT1+uIFoLLGWRaNagzbKLat0pf5980hQVb/L1PO7D9u5BR8jxegMsOlTrpA7zVz5PlxiIpqpv/IjZHtvFgmmfSlL3FefqqLxwNTAC5hO92ckzWKRMvArghd9TriEGYLgASqc4td/klncwez4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740007466; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B9UM5CHRqI9N5KMlJt1yOv1c3fYmGbfXEqGaAuGl/eE=; 
	b=EPL0bwH8Stx1MxeK/rgFyvoIS8pgVCAwC8WPAdmPD8QxsrzYBydjKRw7HmjhaykTXMs26Go1L8cq+bNl0LIGqP6SGasEoz1+L0Ks1SHrm/qtMUyKMiI6K5zi5GzyQX6gs4uaq1AHuwm+5EJyOnT2L/4cTehFDwFOVNDg/ZWyHGs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740007466;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=B9UM5CHRqI9N5KMlJt1yOv1c3fYmGbfXEqGaAuGl/eE=;
	b=UY8AN14LGVSAEwkXgqijjz2ML8GEtQgwXGVxX32U8PKI1/RCtDsSqF+USZp3nPiM
	G/0MFvmY9ivZR75gFS6sdR6bZ++FIXIATYEXkyiQxK9tz9vrqm0txweSBTWNA7CwFXe
	4ew8FNTHHmxDPy6EvscG2bKH5OTel9w08nYrLtUg=
Received: by mx.zohomail.com with SMTPS id 1740007464646884.4598862835086;
	Wed, 19 Feb 2025 15:24:24 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 4CF5E18093B; Thu, 20 Feb 2025 00:24:20 +0100 (CET)
Date: Thu, 20 Feb 2025 00:24:20 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, lee@kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com, 
	wens@csie.org, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 3/4] power: supply: axp20x_battery: Update temp sensor
 for  AXP717 from device tree
Message-ID: <5hgcizrvf3wzj3a3tigj7warkaqfoarhux3uwnxaelxid2uhde@prklvm4ihpag>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
 <20250204155835.161973-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x67wn3vqkt5ilw3i"
Content-Disposition: inline
In-Reply-To: <20250204155835.161973-4-macroalpha82@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/239.939.29
X-ZohoMailClient: External


--x67wn3vqkt5ilw3i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 3/4] power: supply: axp20x_battery: Update temp sensor
 for  AXP717 from device tree
MIME-Version: 1.0

Hi,

On Tue, Feb 04, 2025 at 09:58:33AM -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Allow a boolean property of "x-powers,no-thermistor" to specify devices
> where the ts pin is not connected to anything. This works around an
> issue found with some devices where the efuse is not programmed
> correctly from the factory or when the register gets set erroneously.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/axp20x_battery.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 3c3158f31a48..f4cf129a0b68 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -89,6 +89,8 @@
>  #define AXP717_BAT_CC_MIN_UA		0
>  #define AXP717_BAT_CC_MAX_UA		3008000
> =20
> +#define AXP717_TS_PIN_DISABLE		BIT(4)
> +
>  struct axp20x_batt_ps;
> =20
>  struct axp_data {
> @@ -117,6 +119,7 @@ struct axp20x_batt_ps {
>  	/* Maximum constant charge current */
>  	unsigned int max_ccc;
>  	const struct axp_data	*data;
> +	bool ts_disable;
>  };
> =20
>  static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_=
batt,
> @@ -984,6 +987,24 @@ static void axp717_set_battery_info(struct platform_=
device *pdev,
>  	int ccc =3D info->constant_charge_current_max_ua;
>  	int val;
> =20
> +	axp_batt->ts_disable =3D (device_property_read_bool(axp_batt->dev,
> +							  "x-powers,no-thermistor"));
> +
> +	/*
> +	 * Under rare conditions an incorrectly programmed efuse for
> +	 * the temp sensor on the PMIC may trigger a fault condition.
> +	 * Allow users to hard-code if the ts pin is not used to work
> +	 * around this problem. Note that this requires the battery
> +	 * be correctly defined in the device tree with a monitored
> +	 * battery node.
> +	 */
> +	if (axp_batt->ts_disable) {
> +		regmap_update_bits(axp_batt->regmap,
> +				   AXP717_TS_PIN_CFG,
> +				   AXP717_TS_PIN_DISABLE,
> +				   AXP717_TS_PIN_DISABLE);
> +	}
> +
>  	if (vmin > 0 && axp717_set_voltage_min_design(axp_batt, vmin))
>  		dev_err(&pdev->dev,
>  			"couldn't set voltage_min_design\n");
> --=20
> 2.43.0
>=20

--x67wn3vqkt5ilw3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme2aCMACgkQ2O7X88g7
+ppoyg//cAPQdD8x374xBKtkhMZtTr4J9MjS4kFft3DFDlzGV53/Yj95angNmQst
FmTIt7dNBOI6YeQuUF2hDzehbAgSYEBgcH5oUrN+G2qy8y5jafYdNzWQfkmrI2Gu
r9jFyEPlf0GdW2R1WfHHY49b1RpMD6K6vM0IucFBV8qbeBCPiam0fwz4B3XFmapP
kNR47A6NDYqpLKHTb4BFQbLptBOTdduWVeb7Xgftr42Mfg+yjN9bHQWvrAnmDmrx
anGzD3qheDnHdCfzxi4rLy4HzX6XKKU/rHIgblfy8mzpebzpWUaJ81bQI2jbiGdU
NdGhm379Z131QKHhB1cyBOdSgXSsSG4N5q1WV/ppdRDgt2GrJK2xzFO/uzVa+U9p
7fxdhQunqQX3n2+Gygnl1ULtLVIzdYROI0MOoHW8rJWVSwGGRQWTwi1Ab9+skFcr
34SeSiJC8NyKyxVZHk3V6HIH8Qg/6pYJkqj0+NMjTnrbNHJofexb3OF42sW0oXWM
jB6MGAMiYjbxV/5J/4uJBgV2aKi2UshdTthJdgabwvTHPShknjrYsqL6mPfG1uho
dW+qvINgOFY28hHilvBx4A1JUesA0YsENWuRVHLNy+9JR1a3fYvkHU9YF0OAITEW
ADqyy4nLs/OQmhXasvyIp6CFp/+TxdKANjC+ODoT2KlOVtuOyFw=
=n2h4
-----END PGP SIGNATURE-----

--x67wn3vqkt5ilw3i--

