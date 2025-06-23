Return-Path: <linux-pm+bounces-29407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65569AE5280
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 23:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33EC47A4A92
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 21:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6C222599;
	Mon, 23 Jun 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="CUzB8so1"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557C221FCC;
	Mon, 23 Jun 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715066; cv=pass; b=ZLCRvk5o2CvsJE7mwH7/3GR5pliyia+h1M9u+KDIFBOx+NgfATj7JfX4utd8uyTtus4YMLa7HJP+2DmhfUzfO4njrCQMZGLe9v53Deobg2yvYCan+bQ7nQnFeNiXS74PO3LbvC4iujJcFGEmRy0Oj8ZfvdeJpUZQKlLzFf9ErCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715066; c=relaxed/simple;
	bh=WvueQPXbOdlofjzoj6c6unBpLlzicYo2AWFn5a+Yabo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIyNT2fUtKdqyR1DJ8fg8Xnp6QGC2bJVyxRmKJ/TITiYhwUQ4RgVnsd+NpZcrdvbbYJm1nqJ9cXRUlNhSA4ouSH+Fm1WLaR37FB/b3zaDNagBUTDaW7LUnQzpXy1AIvcUV40/1vKzf+1VSG9/YTpW290CpmS2IDBLUYJ0V4d/90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=CUzB8so1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750715051; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nvN4KGw+bnWl5SsajRojRN8eX8sDznoJen4QlI/ZRptc86ZRzl673qaapjJXIiWBQnZlqvutsh4GLftAQtEDZ5pjMZWU1y+qqqnhF54Ec+alhXtbx1xZPRv6OcSGRTa3wo52ss6ieJSoaWmtMLhgE86gh1OaBNwopwbVOSgfs/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750715051; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wygUX5R3kKWGk7uWXfg5I/qjocbm6NIuv2y5aMjruak=; 
	b=QQj6YFAJhMvHV684MJdPcY5VD2Yvk+3kZis6AaxVV/GFr/hHZdx1FU4iCRURvObzuPt/7pwbbIKmexQDzG6S3uXwqecfCGQvbBs9hgJXCRPU9IXkgF9RIaXKzEgNZUK4/SpKXUg4Vcg2Pt4ScN5mBNZGfV540oQjgfdwYKGorW4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750715051;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=wygUX5R3kKWGk7uWXfg5I/qjocbm6NIuv2y5aMjruak=;
	b=CUzB8so17aknsokQNxikLBWeo36ZwqB5MBqEX7wwNjdOYJI2ftQUWw9NOfRLG0zm
	TG0NS7T8iWum3YiT57s2iRri3L/ZXKUWuV88fMdvCVQVqJuK6H/0fDreZ4VykhUsbzp
	IbgQ+hbkwJ7CEVIvx69SV4fVHzEJhjM0xefx4sP0=
Received: by mx.zohomail.com with SMTPS id 1750715048669621.945132968577;
	Mon, 23 Jun 2025 14:44:08 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id E4217180AAB; Mon, 23 Jun 2025 23:44:03 +0200 (CEST)
Date: Mon, 23 Jun 2025 23:44:03 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: amitsd@google.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] power: supply: core: add vendor and product id
 properties
Message-ID: <5zjoseyepm3tnqbwrh77liwuuqgmghn4kcj43urnk7z4yrttlx@yqqpnnlifdk5>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-4-8d06130bffe6@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dxr7mkhx55msmxh5"
Content-Disposition: inline
In-Reply-To: <20250507-batt_ops-v2-4-8d06130bffe6@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.696.82
X-ZohoMailClient: External


--dxr7mkhx55msmxh5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] power: supply: core: add vendor and product id
 properties
MIME-Version: 1.0

Hi,

On Wed, May 07, 2025 at 06:00:25PM -0700, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add the following properties:
>   * Vendor Identifier (VID): Assigned to the battery manufacturer by USB
>     Implementers Forum (USB-IF).
>   * Product Identifier (PID) assigned by the manufacturer to the
>     battery.
>=20
> This info is required by USB Type-C PD devices containing batteries.
> This enables the USB Type C devices to respond to a Battery capacity
> request from the port partner by querying for the PID & VID assigned to
> the batteries. Refer to "USB Power Delivery Specification Rev3.1 v1.8"
> Chapter 5.5 Battery_Capabilities Message.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 19 +++++++++++++++----
>  Documentation/power/power_supply_class.rst  | 11 +++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  2 ++
>  include/linux/power_supply.h                |  2 ++
>  4 files changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 2a5c1a09a28f91beec6b18ca7b4492093026bc81..5495e82885b2294cdfd5ace0e=
7e5fcbeadfccb5f 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -814,11 +814,22 @@ Description:
>  		Access: Read
>  		Valid values: 1-31
> =20
> -What:		/sys/class/power_supply/<supply_name>/extensions/<extension_name>
> -Date:		March 2025

Why does this remove existing Documentation?

> +What:		/sys/class/power_supply/<supply_name>/usbif_vendor_id

I think we can use USB_VENDOR_ID and USB_PRODUCT_ID for this like
everyone else?

> +Date:		May 2025
>  Contact:	linux-pm@vger.kernel.org
>  Description:
> -		Reports the extensions registered to the power supply.
> -		Each entry is a link to the device which registered the extension.
> +		Reports the vendor id assigned to the battery manufacturer by USB
> +		Implementers Forum (USB-IF).
> =20
>  		Access: Read
> +		Valid values: 0x0-0xffff

If I haven't missed something the formatting will be in decimal. I
think the hex format is more sensible, so this needs some extra
handling in power_supply_format_property() in power_supply_sysfs.c.

> +
> +What:		/sys/class/power_supply/<supply_name>/usbif_product_id
> +Date:		May 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the product id assigned to the battery by the manufacturer
> +		(associated with usbif_vendor_id).
> +
> +		Access: Read
> +		Valid values: 0x0-0xffff
> diff --git a/Documentation/power/power_supply_class.rst b/Documentation/p=
ower/power_supply_class.rst
> index da8e275a14ffb9f84bae9ae1efc4720a55ea3010..6d0a6bcf501e719fa4454845b=
583a8b38d371bb4 100644
> --- a/Documentation/power/power_supply_class.rst
> +++ b/Documentation/power/power_supply_class.rst
> @@ -213,6 +213,17 @@ TIME_TO_FULL
>    seconds left for battery to be considered full
>    (i.e. while battery is charging)
> =20
> +USBIF_VENDOR_ID
> +  Vendor ID (VID) assigned to manufacturer or device vendor associated w=
ith the
> +  battery by USB Implementers Forum (USB-IF). This property is described=
 in
> +  "USB Power Delivery Specification Rev3.1 V1.8" Chapter 6.5.5 Battery
> +  Capabilities, Section 6.5.5.1 Vendor ID (VID).
> +USBIF_PRODUCT_ID
> +  Product ID (PID) assigned to the battery, such that if the VID belongs=
 to the
> +  manufacturer then the PID will be designated by it. Similarly if the V=
ID
> +  belongs to the device vendor then the PID will be designated by it. Th=
is
> +  property is described in "USB Power Delivery Specification Rev3.1 V1.8"
> +  Chapter 6.5.5 Battery Capabilities, Section 6.5.5.2 Product ID (PID).
> =20
>  Battery <-> external power supply interaction
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index edb058c19c9c44ad9ad97a626fc8f59e3d3735a6..534ed3cd049866fa747455bb6=
dae1ec2dc5e2da6 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -211,6 +211,8 @@ static struct power_supply_attr power_supply_attrs[] =
__ro_after_init =3D {
>  	POWER_SUPPLY_ATTR(TIME_TO_EMPTY_AVG),
>  	POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
>  	POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
> +	POWER_SUPPLY_ATTR(USBIF_VENDOR_ID),
> +	POWER_SUPPLY_ATTR(USBIF_PRODUCT_ID),
>  	POWER_SUPPLY_ENUM_ATTR(TYPE),
>  	POWER_SUPPLY_ENUM_ATTR(USB_TYPE),
>  	POWER_SUPPLY_ENUM_ATTR(SCOPE),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index a35b08bd368e9305554e1a608dc8e526983cfa12..100eb559dcede938595ffbf83=
bc5ef3645a5a172 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -165,6 +165,8 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
> +	POWER_SUPPLY_PROP_USBIF_VENDOR_ID,
> +	POWER_SUPPLY_PROP_USBIF_PRODUCT_ID,
>  	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
>  	POWER_SUPPLY_PROP_USB_TYPE,
>  	POWER_SUPPLY_PROP_SCOPE,

Neither this series, nor the Pixel 6 one seems to have any user for
these new properties? This becomes part of the kernel ABI, so we do
not add new properties without a user.

Greetings,

-- Sebastian

--dxr7mkhx55msmxh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhZypwACgkQ2O7X88g7
+pr7WA//TaVfX+0+LRqeZ6ngX5m2XlAKrsPe2iGCVBtcPqkHMRrRTdDXb8+QEP6/
gRsDBJnetRn0OAzU87v6SPrXC7ddIazIwoi2fHcjPpJGnRsW1y3e+Yqyn7L0ZgSp
IsQXMuW+7KVA31p6HRcueDRpI0rTId/3/23IGWck4X6BIIm+UgMx15lTX2Crip60
oNT2a7+6cHWpvVmxM3H2Y4GTYec4B21W66HLiHnXUDcql1G8lsWtXcfKp4nxXZIb
IHFpqSwmfBYUlgZ3T4JXVCZDu/ZuruHS3J8qxVyzUlZiCVJHyCYBF96mEMdeqsJG
5ui96IUp77M65NACgGtKfPqbPig0iijbMoaSstC5EP5V+r8cg+exVF6AZzxURQ33
uXENOlsKdqnJ/K3zsoAwBFoiqm4nRueqBmLeCELt6BwtL/efZgXewHQ67VRkBaWA
KwhoY6wNTolvuV3nLR22CHUFSWs+8hHo2BMccEsxY7OFkzYBC81DbSV8Wzzhuoe5
idJdPUxKLqwGDb3GzttA4IluG+cLflbDdDrv79+xfu4BF/PdEuGQTNueivJvr6Aj
LpSORn3B518EZ2aIMvyl6i5Gnfg+HJSGzzXm7zy+GsvBOjEgGy6l2BLB9V8IXlU/
2OjloiwzoeYVzpdn2ZhIKaUTxUkqsTfb1sDoUJLB0IAklaMQXKk=
=eZcp
-----END PGP SIGNATURE-----

--dxr7mkhx55msmxh5--

