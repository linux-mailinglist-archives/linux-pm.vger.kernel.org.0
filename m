Return-Path: <linux-pm+bounces-18612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68FB9E533C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812A12857A7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822B81DB37A;
	Thu,  5 Dec 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="XOeIXzj/"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779661D5CE3;
	Thu,  5 Dec 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396451; cv=pass; b=jZyAOJ7exWm4s5u6hnSo9ykZF9PnZz99Nux64k5MAxQhiStm4NR/p3zMft0A9Eic5jf7+cvUPyNqQZ3E9DR2M3M0nSXgxrkrw40ze5wS13waiRlecxxG8NT1rNymTIhTTpqJXOcUXSG/1xCq2k8R6XWN7mwcdKFhWRPdo5/QphU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396451; c=relaxed/simple;
	bh=VKRMaEvta0IGpHZ7vZbbzzDGpeqGDp79B0sTgUeWAB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERMDvN19mxnILZQ73ZtwPfBc/Ut02PQHtLsdTDn71Ak5dqhWqxjrk+S7yaYbEMmhVxhwzmTW8Z9NA7ImSd0T6h5tiAflCoAiICOBEYH47FkyBgkiNv/hzmtfd2ybzti4hGjso+1DEWNvDHh71TZhj1GM6WFpKLzQ2I7p/l8C9IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=XOeIXzj/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733396435; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HuASEWdoUKIu6ysVz7xx9n5bzSoww2898xP2EpdljkaC+MQB9m2jQYNfC6wyVedTSbs5i2wgT8IokyWCPe3g03l2vkuiOvd9XUgutfwOjB8D8bK/gJRwv1ynXkmUg/PmmhfpLk5b9TjqCMgS9yr9rMGWt79g8K4BNeUg5G95tpc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733396435; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2z3wyRuIE35ESn19N6dex7TkqFUd44OkK6seAcXauA8=; 
	b=d/W9I60+1XVWc94E9DVC6FmILpL73lY2Hc1C1R67OFSorn99kjMWyCcK+uwGzkfNbLmWlTygSOvlDrrtczeAja+T4CoUiP8ufkES3C28uwpD45LYKPhzJvZMxTvIsk6zFk0iHOPXXHagrs+5ZLWZQkCjGqkbwnJSXSRwZ1YAx9E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733396435;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=2z3wyRuIE35ESn19N6dex7TkqFUd44OkK6seAcXauA8=;
	b=XOeIXzj/8f1AOGlo8umRZT6do869bFBVyh3qnLSQjXP0j/IMZ2rxl1vZYJWK6XBJ
	K2ECDfp81JKFSNl2o8S1zf91pnM7xaFakGrhr57pX/D7ZvGaJWIecZRCt/Ph27YyCQD
	E/jDWPpmNkiY0r1mbF3YHPZAXbHgvJR2GmQJlC4M=
Received: by mx.zohomail.com with SMTPS id 1733396432244555.8711485051821;
	Thu, 5 Dec 2024 03:00:32 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 0877A10604B0; Thu, 05 Dec 2024 12:00:27 +0100 (CET)
Date: Thu, 5 Dec 2024 12:00:26 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/8] power: ip5xxx_power: Fix return value on ADC read
 errors
Message-ID: <hkmhtj2fasl4x7c2yqi3c6eaygbkecbtcgcz2lduxfzbwirpye@j56gp5vognj4>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
 <20241119180741.2237692-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bfeiau4pldmhijl6"
Content-Disposition: inline
In-Reply-To: <20241119180741.2237692-2-csokas.bence@prolan.hu>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.272.83
X-ZohoMailClient: External


--bfeiau4pldmhijl6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/8] power: ip5xxx_power: Fix return value on ADC read
 errors
MIME-Version: 1.0

Hi,

On Tue, Nov 19, 2024 at 07:07:34PM +0100, Cs=F3k=E1s, Bence wrote:
> If ADC read returns an error, the return value was silently ignored,
> execution continued and an uninitialized value and a return code of 0
> was passed back to userspace. The only exception was
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which bailed out correctly.
> Fix returns for the other cases as well.
>=20
> Fixes: 75853406fa27 ("power: supply: Add a driver for Injoinic power bank=
 ICs")
>=20

No newline between Fixes and Signed-off-by.

> Signed-off-by: Cs=F3k=E1s, Bence <csokas.bence@prolan.hu>
> ---

Fixes should always be at the start of a patch series, so that they
can easily be backported. I fixed both things up when applying the
patch.

Greetings,

-- Sebastian

>  drivers/power/supply/ip5xxx_power.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/i=
p5xxx_power.c
> index 2d4435881a9e..41d91504eb32 100644
> --- a/drivers/power/supply/ip5xxx_power.c
> +++ b/drivers/power/supply/ip5xxx_power.c
> @@ -395,18 +395,24 @@ static int ip5xxx_battery_get_property(struct power=
_supply *psy,
> =20
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  		ret =3D ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.volt=
, &raw);
> +		if (ret)
> +			return ret;
> =20
>  		val->intval =3D 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
>  		return 0;
> =20
>  	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
>  		ret =3D ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.open=
_volt, &raw);
> +		if (ret)
> +			return ret;
> =20
>  		val->intval =3D 2600000 + DIV_ROUND_CLOSEST(raw * 26855, 100);
>  		return 0;
> =20
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		ret =3D ip5xxx_battery_read_adc(ip5xxx, &ip5xxx->regs.battery.adc.curr=
, &raw);
> +		if (ret)
> +			return ret;
> =20
>  		val->intval =3D DIV_ROUND_CLOSEST(raw * 149197, 200);
>  		return 0;
> --=20
> 2.34.1
>=20
>=20
>=20

--bfeiau4pldmhijl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdRh8AACgkQ2O7X88g7
+poRAw/+OVre+iQb6jEDswOfOPURBqZbUG2Q6/9f9He/m4zszbHLUwXiDNZFaRX7
3Xt4ZoF80zreIRS/tOMSf3HdLwoGLrXLPjHbCBFbXL559KznsT3NYH9b+RER8G8+
Z7b4Tg+RmJzdJE2WcjqKCl7mlNZW30Q3SgHenHw8bzX22W0B76poSr3gSykezXDf
J54HPDK7OinnQLDnbIrNFoaNzgyJZfVtY+t4xf+V6XoCgvO/5gHUAhEIBYl3IafK
oExC/zeoHwgNCASfu5VCey0fGTfJVcmmhZAHZBcBfv0zNtBQt76eM7NiZukIKgSo
2l95PRdFq4GYjXAKBpBewK8ScgN+iTcfhzMAOP11fBDfmwARjVhOgbvzYagh/76z
lJ/HLavR9aQmuepgYOES/5kWOtsps2FlJLWg9Z3pOowTXSfDQlBleQN7288KFBLq
3cInqKYvn9o9kCbqF5z//FTY6L0EM2furuO1jbtk8J2XMF/33ZqKyhHxyS5r88cJ
Cgvqk+CAI04jOPjEPjzd/JiHaFwwNcIyPiTUwlcEnu1vQ5MmY5ycgJ+oDM0V1QuZ
kBFQAlSU/pQ4UjOhA4ifKj9BPuzBNQI5Ac/4jwZk3KnQVi/39Ilv85U7qO2yOy/F
U8spyqQ1C6/Z/YDWOq1Bf+eZgE4ovWRraL2I5C9PTv+z2+mISso=
=wT4a
-----END PGP SIGNATURE-----

--bfeiau4pldmhijl6--

