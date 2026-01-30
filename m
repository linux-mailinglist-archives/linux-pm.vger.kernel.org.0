Return-Path: <linux-pm+bounces-41805-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGM/BJoufWmrQgIAu9opvQ
	(envelope-from <linux-pm+bounces-41805-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:20:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66915BF151
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE64D3011C6E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54337647D;
	Fri, 30 Jan 2026 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iM/yrcI2"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46E3876A5;
	Fri, 30 Jan 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811605; cv=pass; b=k+afIl9ARV4Vp8lQZ2qAjyoavmhyM7Mh3lozPooTUPykvQjRYY2pXMXkVMZcjj1kB3/ExmW9hlrnsqO/K4NH9MRJcKmh+y74cOQqlTo6stSy9P6pTleel5koT4StRx95yUNmacjt+Xf3s7saqw6FEbDlxK+9Kit0+kcQoOBgOfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811605; c=relaxed/simple;
	bh=QZBZcJ/a2YLuRr4I5mZ22MCVNSH92w/f/Or85ijWxr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwD4bX1CZfthAYUiysydvIsA6nJbCauc7C6Wmin13pwbkSXAhdvauhathYklP6FFZDJYhNIV3viWBDJZE+QpaEqMFX+CO+aQu/y96np0if/JVLVdIys/1RKoDKZz+oShKYmOimb6GMWR+XZSu7NI+fGEbhdg8ZSisnlAvrjbJOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=iM/yrcI2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769811594; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O9tS+jzQr8Iq3/3cz6knJ2509CXjCe2Kj270x0lCOT6m5EedusIk1MYS4ZBq4OBt1tf7n2sKz6rceA5DpZHCB7TD/9wOot520SPW8FZWryZqs8c3feqRhtifugZmnnK2rocnPDvm5m9VPE7t/UyGVXzS3quPGzCHVP1SLXR30gQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769811594; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xiw8nJda/MuhHJ7vgPDTrB7e8C6rz/9MlJACeb1t/8M=; 
	b=T2jX+sSImU+fFW6vR5fDjgdiOojclrJwSjlNTfdvxbM825wmo05zutv9v+elTNdUaJeNCPiYnlnU68tQt0PA7VMl0pTEMp3tUlTw/omsE3Uy+KY6LJ0G2SIwnkomuDnnNV6vdRS/KKbGqa0/WNi+3OmSYpZ6TYEjmC5TkcfhpEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769811594;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Xiw8nJda/MuhHJ7vgPDTrB7e8C6rz/9MlJACeb1t/8M=;
	b=iM/yrcI2dp8nsbjL9S49q31GlQsWXYX3SokAq2g26SNjNC+WMODbPq+NyJJhnS78
	2LdXLUIfOBL3L5gqO6JPciv6bSooDB2C0ePOQY0sXrVuvZdZb+34mECC4NC2mjftTva
	P6hM+PxUBvts80cCh1tHOyy9zfrxPu3izGr3KCHo=
Received: by mx.zohomail.com with SMTPS id 1769811592639656.6976022591397;
	Fri, 30 Jan 2026 14:19:52 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 867A218050E; Fri, 30 Jan 2026 23:19:44 +0100 (CET)
Date: Fri, 30 Jan 2026 23:19:44 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: dimitri.fedrau@liebherr.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v2 2/2] power: supply: gpio-charger: add support for
 fast-charge timer
Message-ID: <aX0tJLqfY7b9oNAi@venus>
References: <20260109-gpio-charger-timer-v2-0-63fd1ba75830@liebherr.com>
 <20260109-gpio-charger-timer-v2-2-63fd1ba75830@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bkek7r6fybwvklhn"
Content-Disposition: inline
In-Reply-To: <20260109-gpio-charger-timer-v2-2-63fd1ba75830@liebherr.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/269.789.21
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41805-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:dkim,liebherr.com:email]
X-Rspamd-Queue-Id: 66915BF151
X-Rspamd-Action: no action


--bkek7r6fybwvklhn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] power: supply: gpio-charger: add support for
 fast-charge timer
MIME-Version: 1.0

Hi,

On Fri, Jan 09, 2026 at 07:41:20PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> On some devices like TIs BQ24081 battery charger it is possible to activa=
te
> or deactivate a fast-charge timer that provides a backup safety for charge
> termination. In case of the BQ24081 it is a fixed 7-hour timer. Add suppo=
rt
> for enabling/disabling the fast-charge timer via GPIO.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---

The documentation is missing _a lot of information_. What happens
when the fast-charge timer is disabled? What happens when it is
enabled and times out? What do you expect users to do with this
control knob?

Greetings,

-- Sebastian

>  .../ABI/testing/sysfs-class-power-gpio-charger     | 10 ++++++
>  drivers/power/supply/gpio-charger.c                | 39 ++++++++++++++++=
++++++
>  2 files changed, 49 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-gpio-charger b/D=
ocumentation/ABI/testing/sysfs-class-power-gpio-charger
> new file mode 100644
> index 0000000000000000000000000000000000000000..95fb31ac4af3d5354bdc642c9=
8baa7df267d150d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-gpio-charger
> @@ -0,0 +1,10 @@
> +What:		/sys/class/power_supply/<supply_name>/fast_charge_timer
> +Date:		October 2025
> +KernelVersion:	6.19.0
> +Contact:	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> +Description:
> +		This entry enables or disables the timer in fast-charge mode.
> +
> +		Access: Write
> +
> +		Valid values: 0 (disabled) or 1 (enabled)
> diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/g=
pio-charger.c
> index 2504190eba82e69b79382320e67de6b8f3dedc77..52997205879406fae600171b0=
70a0328657fa79b 100644
> --- a/drivers/power/supply/gpio-charger.c
> +++ b/drivers/power/supply/gpio-charger.c
> @@ -32,6 +32,7 @@ struct gpio_charger {
>  	struct power_supply_desc charger_desc;
>  	struct gpio_desc *gpiod;
>  	struct gpio_desc *charge_status;
> +	struct gpio_desc *timer;
> =20
>  	struct gpio_descs *current_limit_gpios;
>  	struct gpio_mapping *current_limit_map;
> @@ -259,6 +260,36 @@ static int init_charge_current_limit(struct device *=
dev,
>  	return 0;
>  }
> =20
> +static ssize_t fast_charge_timer_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct gpio_charger *gpio_charger =3D power_supply_get_drvdata(psy);
> +	int ret;
> +	bool en;
> +
> +	if (kstrtobool(buf, &en))
> +		return -EINVAL;
> +
> +	if (!gpio_charger->timer)
> +		return -ENODEV;
> +
> +	ret =3D gpiod_set_value_cansleep(gpio_charger->timer, en);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_WO(fast_charge_timer);
> +
> +static struct attribute *gpio_charger_attrs[] =3D {
> +	&dev_attr_fast_charge_timer.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(gpio_charger);
> +
>  /*
>   * The entries will be overwritten by driver's probe routine depending
>   * on the available features. This list ensures, that the array is big
> @@ -308,6 +339,13 @@ static int gpio_charger_probe(struct platform_device=
 *pdev)
>  		num_props++;
>  	}
> =20
> +	gpio_charger->timer =3D devm_gpiod_get_optional(dev, "fast-charge-timer=
",
> +						      GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio_charger->timer)) {
> +		return dev_err_probe(dev, PTR_ERR(gpio_charger->timer),
> +				     "error getting fast-charge timer GPIO descriptor\n");
> +	}
> +
>  	charge_status =3D devm_gpiod_get_optional(dev, "charge-status", GPIOD_I=
N);
>  	if (IS_ERR(charge_status))
>  		return PTR_ERR(charge_status);
> @@ -336,6 +374,7 @@ static int gpio_charger_probe(struct platform_device =
*pdev)
> =20
>  	psy_cfg.fwnode =3D dev_fwnode(dev);
>  	psy_cfg.drv_data =3D gpio_charger;
> +	psy_cfg.attr_grp =3D gpio_charger_groups;
> =20
>  	if (pdata) {
>  		charger_desc->name =3D pdata->name;
>=20
> --=20
> 2.39.5
>=20
>=20
>=20

--bkek7r6fybwvklhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAml9LoAACgkQ2O7X88g7
+po+Jg//YPNBeeK3bgk8ywXnjfmPv+a9xrrtF24PkLNWEsAHdPeROYruZ21/uYkz
dSUs4O8AwOLbt7s82FE12VZpTeAle3t3A6Iyz7tnz4s8da93tYLysRXRSvRzRBEH
6mtNW+NFOTj1Ln+BX3uE6FpUeRDvNK9qSSPDDV7sUspU7boq2Yut47MTb/+HusNr
l/vzFo32UewrddRaSyCK+lMtkmfJ/oPiSyzVWUzTosM1b4iIvkEU4HhMpSJeDXut
QvcjiRzFfKRd8/nTH0lyAyJ4A0CyFqurY0c2YyPG3fiDJVhhcmBpR1TXC/8ESKIv
khJlQqeseixmYBeSg5Wb/mP8UQ+emE6YopB+tSCj3CAf4UV+2awcARa2r1Xvsvib
Jr5i1Lg7AmH6FUkoGu0jz7QdPY7G+FQeiMIGpFDdTXot6lhVzYk3fZt84nfTwNUN
NakyY3EhlvuALEZ8B4mNcibcY7JxTHd1ChCT7CQQJ+Sw+egqPYNuUoSjFbD5u14x
RezySazatCLFcDBmHjEpb3COvnXFnZjU3RRMHIqewa0U/srdk6tpAzXRsgE0S/fM
qRNjeYieJ5WMyunLpXL6ObGkUbn93tzUIvIkU/Mv4GDI++VQjkMtXigC5h6owJs/
335anAp1DeSND3WdeFH8nKtCU9wadfa5TNJ48UYw0Iv9d0VnVOs=
=JOtt
-----END PGP SIGNATURE-----

--bkek7r6fybwvklhn--

