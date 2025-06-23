Return-Path: <linux-pm+bounces-29405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB74AE500B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 23:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439051B61DEE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 21:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFA1EF397;
	Mon, 23 Jun 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="djTOojxP"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C1221F0F;
	Mon, 23 Jun 2025 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713706; cv=pass; b=AI4ueNE8uzaYuZuCfi75pL5tws7/ywSwy5Zhvq72JmvU/Y2uxWRzsdlHxk4WCzeVIWdPjaa7TRunChVEV0mPlxLl5MgMteC9pHPs/V+6eCOtdpalT7Mi7u9NfZLA2fJGt69rgqnyAxiqNH90laSaTIM9kcgXAOU9bRiZGgITitY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713706; c=relaxed/simple;
	bh=KtakUjgv+UZf2zaxQpHTQu+8cOFck/+XtuwX2MXy47c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5OuHF6AKvYuZJTKeQMxaazt/6k6GPk086ppss5ZtuBabF3eDdwkp+ATC4ayEP/HNP+L/TGAMWQ5jB32y1uxrkp7ca/m2Eqk6sqTTnoS8ejNOtril/9+5+8HwuvLuDcXiM0JUmNVQoZaf18YbYU+aad5h/urswhfXmqCD1Ith9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=djTOojxP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750713689; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m/XM4rTD4QhoU7m/KHv0O/CbvojXCAGpoveJYiDyugG6jrPiy+ovLCuFL5xdIpbq8g1Ezw/SBpxdy12FllDjoEKYO+tbvpjgXA1UU767DRSKtWstXrSvNFWWmETC7RqkhDPsuN5BHEEX4utxIGznQS89puhFpXpCft4K5uBn2ks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750713689; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZfiWeBvfNnXnUysh0G/D5Vm9Y8TLgU9BFV02Xs7k2HE=; 
	b=ZwD+qKKO1bwXT24zCaTJMJS84YZwzNRFij1DX28o5oHxiK8e/45SF/LUzjrQeda/cqvGdo7MnhbrQrm8KNmSnPdxDCGK9Q2hqUw+cW7Baqz5c5vNFxBrFh4JnbdsfS2E4JCp1vTCQidiOKWXkA4Yyea1cxN4fSH3OemfMv7LLtg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750713689;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ZfiWeBvfNnXnUysh0G/D5Vm9Y8TLgU9BFV02Xs7k2HE=;
	b=djTOojxPua9C2oq5c7PAFfYvDezovncq8tTlPMGXz9g15tH4l5DAyXu1xXpJsN1n
	iA+ULtjIp2ndaFNHjogkiBq136100Y1jehHHnC8vXkyyrotY19GUZSoUlOuTZH2vtvC
	DN1sdOSt81zXYPNIqPlEKZkWBXEO+1XwUvg+jGdw=
Received: by mx.zohomail.com with SMTPS id 1750713688281148.819607680059;
	Mon, 23 Jun 2025 14:21:28 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 139A4180AAB; Mon, 23 Jun 2025 23:21:23 +0200 (CEST)
Date: Mon, 23 Jun 2025 23:21:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: amitsd@google.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] power: supply: core: add helper to get power
 supply given a fwnode
Message-ID: <djqmdlnsftquum3wayigqryzfy7xkn67uj4pfk3wugxl3lx3wr@y26ydci57iwi>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-2-8d06130bffe6@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kdcwqy7o5osxokcj"
Content-Disposition: inline
In-Reply-To: <20250507-batt_ops-v2-2-8d06130bffe6@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.696.82
X-ZohoMailClient: External


--kdcwqy7o5osxokcj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/5] power: supply: core: add helper to get power
 supply given a fwnode
MIME-Version: 1.0

Hi,

On Wed, May 07, 2025 at 06:00:23PM -0700, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add a helper function power_supply_get_by_fwnode() to retrieve
> power_supply given a valid fwnode reference.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/power/supply/power_supply_core.c | 30 ++++++++++++++++++++++++++=
++++
>  include/linux/power_supply.h             |  3 +++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 76c340b38015af0a67a0d91305e6242a8646bf53..ef6ba22b837b0b9463f9a3065=
425e2720f40b9eb 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -496,6 +496,36 @@ struct power_supply *power_supply_get_by_name(const =
char *name)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_get_by_name);
> =20
> +static int power_supply_match_device_by_fwnode(struct device *dev, const=
 void *data)
> +{
> +	return dev->parent && dev_fwnode(dev->parent) =3D=3D data;
> +}

This already exists as power_supply_match_device_fwnode().

> +
> +/**
> + * power_supply_get_by_fwnode() - Search for power supply given a fwnode=
 ref.
> + * @fwnode: fwnode reference
> + *
> + * If power supply was found, it increases reference count for the inter=
nal
> + * power supply's device. The user should power_supply_put() after use.
> + *
> + * Return: Reference to power_supply node matching the fwnode on success=
 or
> + * NULL on failure.
> + */
> +struct power_supply *power_supply_get_by_fwnode(struct fwnode_handle *fw=
node)
> +{
> +	struct power_supply *psy =3D NULL;
> +	struct device *dev =3D class_find_device(&power_supply_class, NULL, fwn=
ode,
> +					       power_supply_match_device_by_fwnode);
> +
> +	if (dev) {
> +		psy =3D dev_get_drvdata(dev);
> +		atomic_inc(&psy->use_cnt);
> +	}
> +
> +	return psy;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_by_fwnode);

And this is a 50% of power_supply_get_by_reference(), so the
function should be updated to use power_supply_get_by_fwnode().

Greetings,

-- Sebastian

>  /**
>   * power_supply_put() - Drop reference obtained with power_supply_get_by=
_name
>   * @psy: Reference to put
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6ed53b292162469d7b357734d5589bff18a201d0..a35b08bd368e9305554e1a608=
dc8e526983cfa12 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -801,10 +801,13 @@ extern void power_supply_unreg_notifier(struct noti=
fier_block *nb);
>  #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>  extern struct power_supply *power_supply_get_by_name(const char *name);
>  extern void power_supply_put(struct power_supply *psy);
> +extern struct power_supply *power_supply_get_by_fwnode(struct fwnode_han=
dle *fwnode);
>  #else
>  static inline void power_supply_put(struct power_supply *psy) {}
>  static inline struct power_supply *power_supply_get_by_name(const char *=
name)
>  { return NULL; }
> +static inline struct power_supply *power_supply_get_by_fwnode(struct fwn=
ode_handle *fwnode)
> +{ return NULL; }
>  #endif
>  #ifdef CONFIG_OF
>  extern struct power_supply *power_supply_get_by_phandle(struct device_no=
de *np,
>=20
> --=20
> 2.49.0.987.g0cc8ee98dc-goog
>=20
>=20

--kdcwqy7o5osxokcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhZxU4ACgkQ2O7X88g7
+ppp0w//bAvpD5lKXf4rI7iyQxFwENWWOhcb8530kiDRTCMw5KdjDEG6u8UvZyGy
ScKNgaGNGvqy4su03assapnNnpOtb+N+CDm80bcgDYDNooRO9LX7S4eyB+I6wKp3
BPj87u055U50RJ8RQmkvOq40rmJY2Ri8e5Grd1yRqHtt4uEaF5ev1Me7msnxr41v
mnyMOE6s9Qv13a6u/TZlP+XDVoHeCwvg10w3XWZHYss/PfOgMSbPO/Zm3i7nF7QL
yWBM0HrbQsNj0FRaGcTU8EiGKhzgejgveRuKsfLFhyExlyK1NhDfAK07UwRdfcBG
FeliJKPdRpCNZyGMSPNuv1f48L9TIj6Vq7sWh4HNJkanMOYXgsgPgrXA63GShm+d
XQRvAhqBNVG7Ym1iQrWA6YaS+6AQL7I+kvfp6HeYWx2v7xtveDkw2xkJ6tzTsQYr
4QWZi5QFCxGCnOh+KYfhUyxNhai41kkaDXefBD5RaYdAEI572kNAJHGlyv4TAaFZ
OkWNG/37vuP7/BN0J1AjXzplAkgIdXhLO6sEFBRdh4IHgNuZZZHEA111cv8D5yOU
aKTwsLL3S8Pu1JFMuN/KoB7zaIfeRlRbGo6P5FNvKWg1mlq6cyrZkHjHnZUGag5q
c0IgY+o69cn4LAOVmVL3vgLYNo1buOzYhxdis0G1z1pz//G1Hi4=
=wVCb
-----END PGP SIGNATURE-----

--kdcwqy7o5osxokcj--

