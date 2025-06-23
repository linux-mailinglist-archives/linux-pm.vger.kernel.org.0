Return-Path: <linux-pm+bounces-29406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E2AE50CD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 23:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6D917F82A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E3221299;
	Mon, 23 Jun 2025 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="aJUjdr9F"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9F1EDA0F;
	Mon, 23 Jun 2025 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714081; cv=pass; b=BySnnxceE8mSGpmcBwNVAqB0vcUML2zibdo3w6N/OdM9EkhWKABjgfKO/Mt+h1KxwtxrEJBkq7GvmcTyELGxMoIKCc+wZ6eo/JiG5ZgP+ntf0/zpBoK7qQzvqvH8pe2YXt0pxx5impYmTgm7eRAGL0j6YYohdB15d/nJwwKzY3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714081; c=relaxed/simple;
	bh=eavMjGPTqGzQIzHZGIMxTJh0ITJeBmp6lze0L+JQxEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji6E2RzJoEHvZNFywguAYfzzr12Huewc9tGePhyZIUa8K0tlBaaxLVha1kamGFZKC4zvWaxGcph65sb8FkJeQ2GHfELRxz9Dg25G2pClSDmcGxcY8GgyVt+EjkV6pFm+fDgOjxtYvP3sCNO3jgkD/ZgMXJPJFlo8YaaHIB3HekM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=aJUjdr9F; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750714068; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XZpR3d1yairrFpFm75ilCvkZ9UWhISocwuL+bJOfTKJNoFefmgMSIOi8AloAe21brwretNmhCfPG7FlsNEzMC7/STAiDdmxLl3UyyN156am6UbJ+3CuDIPq5/ShOBQTl1pIgXjlthz3cnrR3ISYDv6uhwEQuLOUEs8HFPz7ARbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750714068; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XcgGMhxGkYvwiMgM2QxzC87EaD/VMquOZCNHTL2GpbM=; 
	b=dqCAYzmsq2WN4V7n1TOLIk+Ff2kMjnQEU6u8WSP3e0oeWBX1RfeKiB+98mQBNB5JT8evgwyG8HlXG1/nJ3UndPXvgKRikMDGKxrFXZTlNY2ZKce+FhUHujz1SqFEFVU+490Oii7Y7Sx7y6+PuJwul1WCPW931ZawiLjxoXC3+a4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750714068;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=XcgGMhxGkYvwiMgM2QxzC87EaD/VMquOZCNHTL2GpbM=;
	b=aJUjdr9FJOq5V7jsORSj9prz5oBq+9gu6IbI9mrqcbHgnuL6NVrpn8V+b8ff3Xd4
	IHubsjCwDf/QTggnfC0T0rTxTnfU29Y1+8b5jA6pv/YNNOZGRDeCwnvehyPHdlSGpK1
	G0u6AfKaxVkLjSpqDc2xsjD45zmlf9c9Qloy34+w=
Received: by mx.zohomail.com with SMTPS id 1750714067400350.06194474162146;
	Mon, 23 Jun 2025 14:27:47 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id B67E0180AAB; Mon, 23 Jun 2025 23:27:42 +0200 (CEST)
Date: Mon, 23 Jun 2025 23:27:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: amitsd@google.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] usb: typec: tcpm: Add support for Battery Status
 response message
Message-ID: <iqsj5w5pqcbjof3vqohhzptdp5xj7bir6digzqes775at2tpj2@r7kzy4j2fqmw>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-3-8d06130bffe6@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s27v4sw3pnebflzu"
Content-Disposition: inline
In-Reply-To: <20250507-batt_ops-v2-3-8d06130bffe6@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.696.82
X-ZohoMailClient: External


--s27v4sw3pnebflzu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/5] usb: typec: tcpm: Add support for Battery Status
 response message
MIME-Version: 1.0

Hi,

On Wed, May 07, 2025 at 06:00:24PM -0700, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add support for responding to Get_Battery_Status (extended) request with
> a Battery_Status (data) msg. The requester shall request the status of
> an individual battery by providing an index in Get_Battery_Status. In
> case of failure to identify battery, the responder shall reply with an
> appropriate message indicating so.
>=20
> Battery status support is only provided for fixed batteries indexed from
> 0 - 3.
>=20
> Support for Battery_Status message is required for sinks that contain
> battery as specified in USB PD Rev3.1 v1.8
> ("Applicability of Data Messages" section).
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Kyle Tso <kyletso@google.com>
> ---

(partial review)

> +static int tcpm_pd_send_batt_status(struct tcpm_port *port)
> +{
> +	struct pd_message msg;
> +	struct power_supply *batt;
> +	u32 bsdo;
> +	u32 batt_id =3D port->batt_request;
> +	union power_supply_propval val;
> +	int ret;
> +	bool batt_present =3D false;
> +	u8 charging_status =3D BSDO_BATTERY_INFO_RSVD;
> +	u16 present_charge =3D BATTERY_PROPERTY_UNKNOWN;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	if (batt_id < MAX_NUM_FIXED_BATT && port->fixed_batt[batt_id]) {
> +		batt_present =3D true;

power_supply_get_property(batt, POWER_SUPPLY_PROP_PRESENT, &batt_present);

> ...

Greetings,

-- Sebastian

--s27v4sw3pnebflzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhZxs4ACgkQ2O7X88g7
+prX8w//eXySjzU8zhY0Cdhr5c9eK9R0aV6ZD93z73P6hZpIJ7St7LBheCKjROBn
aFZKJAWzSmDRv60tlLIskVE7NQCtTVZ6V31mBhDh7B46WhFRMrIjfdKs4Y1GrbXq
opP91qZj0y5xddpr2oZUOOOFs8pvurJHrKKWz0m82PRTdh3pAJnZVBcHakYqUdQv
zCplY3iJcyseZytMqWa6GnZks1TMwHAhwcH4KaqpMsPgZ88sNuljWl84nARCZM+K
9lBqOylCnHI8MwQ4IYKjyrKIaIXXI+GY9EuLeK08LVDPDH+OiA1JK0BvSAoW6P3l
+/I9Kkr9cZWMv4huBz61T+QDlhbWvGikkGvIhJ6wSYrROmiMBhg9X0OQKrwNXOIR
FdJiEmLy91OTI24CHFXSoffcD08oXoeS/1fVEFr1RF2AITKaRZylTAmHd5qMuF/9
zaeTjc1ytT2t9ktHKQ8Ju3Z1B+X+xtMjm407eceS1OyFKhbdBvlAQnw63Ms18W2T
eRGkT7TGpbEepdu8saDFr7E4TSAWHKdJr9+8sGKswcNBRDSUsnSHk7IvQShlbqcN
bwfLwmuZVnPx0xfYyNgXeWlZdl0SW12xSGxvwIuEBp2+aPD3IscwLeAtq1tCBcLQ
Is6j4ojjiExdqvzHI3a1fP+3bOidcrnlAu7Vn/69/LcGW5pq6Nw=
=qeSd
-----END PGP SIGNATURE-----

--s27v4sw3pnebflzu--

