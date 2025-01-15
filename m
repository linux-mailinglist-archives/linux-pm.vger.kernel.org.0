Return-Path: <linux-pm+bounces-20514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38BA12DC0
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 22:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0EC1886F94
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF0A1DA60B;
	Wed, 15 Jan 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="jJNd7Ms5"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86E156F57;
	Wed, 15 Jan 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976704; cv=pass; b=jiyIWz+b0AAbvc/UavQSjO2S8rFgKIq+cIjJXXhLskWapfzs21YtBRV1ZE02Cq+cXY+8wIrQ1WHLyBGGd3aPQCG1JY62K/CbyK3XuQV2PHHX80LXJBKzK9WrO3YpXfA8AAZR7mfHpqXjEUEwhfIZg1jWRebvhZ5g+WIcPxMvx8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976704; c=relaxed/simple;
	bh=EiKc2+ElfVUDvxV/nsfw5ZdjjC98oAGrYP8FONOp9EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT+y0tZsRQN0rmFgMHznfr/Lhc5/4hMuEcpVUa5nwV3JUwD1CtFKMP2wl0Fcr1BuOR8jClffPh0hYW1c+ughKeeAH8ECJhpmXo1jNYeeKY++bGeqCiuljKvvlLy0y/SNIf4CkP5pWTtj9uA6ClNai64+MK5rI1oSyd7VhJKcM0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=jJNd7Ms5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736976622; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SE5c+9QEd23cengqfVBIxvKi1XlVmqPNd6ZxKiUvOfowwOTkS1jv4mJrrZJlXVM6aPN4Z4/G8nVxwyY5xamCcxWiyu8fiTbeZxIWujaYUP/0o1U9qDNOz6xDEj0kyBDrSx7UUuX3t8VGbRY3uKuXXlu3olABywxGoHFloIsungA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736976622; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=44yBoEaBN9BUqiayzCJKrONcQRlrzsyZDx1UtPfWWvc=; 
	b=MYGT+w+2dDZCwN9Kljm62tsiSjpLgQlABLvDpGygj06DFpCrnMlttSSDADBWTMPRELc7pVGPyRVRueCuqA8s85iIhX/6KCSrjvdNHrxttcK/CrAyQXt1Vc/rme30TT6/3zgO2PGM2qlsZnHzfOiabEnuHqeY8ggY2ET19bWVkjo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736976622;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=44yBoEaBN9BUqiayzCJKrONcQRlrzsyZDx1UtPfWWvc=;
	b=jJNd7Ms5UGIFw5cUCEDDTr5D+pS2J3XEkdHQHSj92ICil7Fm59YPsKJnEYHBP0hS
	160pFHTnC7b6F4s6qaH6nTh4TX9OjxOrFPydPQx8HWLl/Vi646/DeMzgcq2uSwrYtrT
	bwV3F61ygnsxkzKm5O4MJtDaXIxg3uYO9Xsj5iBU=
Received: by mx.zohomail.com with SMTPS id 1736976620687410.3754694103633;
	Wed, 15 Jan 2025 13:30:20 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 2A79A1060346; Wed, 15 Jan 2025 22:30:16 +0100 (CET)
Date: Wed, 15 Jan 2025 22:30:16 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel gauge
Message-ID: <ocx5n42h25ztwo5twlir5zoajavpcxce2ra5jjyl6ae4qg6c3e@akhc3dylsprm>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
 <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vjczpwchn3jh5lgv"
Content-Disposition: inline
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.1/234.845.73
X-ZohoMailClient: External


--vjczpwchn3jh5lgv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel gauge
MIME-Version: 1.0

Hi,

On Thu, Jan 02, 2025 at 12:15:03PM +0100, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> The interface of the Maxim max77759 fuel gauge has a lot of common with t=
he
> Maxim max1720x. The major difference is the lack of non-volatile memory
> slave address. No slave is available at address 0xb of the i2c bus, which
> is coherent with the following driver from google: line 5836 disables
> non-volatile memory for m5 gauge.
>=20
> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c3=
6bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>=20
> Other differences include the lack of V_BATT register to read the battery
> level and a difference in the way to identify the chip (the same register
> is used but not the same mask).
>=20
> Add support for the max77759 by allowing to use the non-volatile
> memory or not based on the chip. Also add the V_CELL regsister as a
> fallback to read voltage value in the case where read of V_BATT fails.
>=20
> The cast is necessary to avoid an overflow when the value of the register
> is above 54975 (equivalent to a voltage around 4.29 V).
>=20
> The regmap of the max77759 will lead the read to fail for V_BATT and to
> correctly use V_CELL instead. This regmap was proposed by Andr=E9 Draszik=
 in
>=20
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a11=
6.camel@linaro.org/
>=20
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---

Please add output from to the cover letter to allow easily verifying
that all values are correctly scaled.

=2E/tools/testing/selftests/power_supply/test_power_supply_properties.sh

> +static const struct regmap_access_table max77759_write_table =3D {
> +	.yes_ranges =3D max77759_registers,
> +	.n_yes_ranges =3D ARRAY_SIZE(max77759_registers),
> +	.no_ranges =3D max77759_ro_registers,
> +	.n_no_ranges =3D ARRAY_SIZE(max77759_ro_registers),
> +};

Drop the yes_range from the write table. It is wrong and confusing.

Greetings,

-- Sebastian

--vjczpwchn3jh5lgv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmeIKOQACgkQ2O7X88g7
+poemg/7BYKpgndddd6KOyNkHh1f7/mS1SrEz1rSArQasRTtCaXiMgBvA1wRxh1R
RLDCrfuUsmbgw3iO6bwMOXIxz+YdjJsaiSgLrM4mOrDPILOyWLmmv0rSPVEdVpFj
S7KksQTPj003J/3xHzVaJtBApMhPDZW2vjbgK4GkL23Gj7fOC4PEyI+5A6tU2Ejo
WsvcViBfCbQrOKD9N0Mub9pS5xztIhVllEdYMqbSRuyq4r0Uj00UqVBkrc6mx8zQ
Hicb5UJsB8cARvRz+gnWqAYGvtgI/NO9LaoNb5jHO3NtyGjpYyivwUqUnkN6Y/F3
38pyNM4dgSZG443aPNM1c+IyBYPXubSDFk0T4cOtR4SQdPIr7c2njf6+n/7O3YkO
tbFGhYHqpHKN3M1tTOEhY8wQi5LFojGQw3n3QcN/TKCRUkoUXQh8//GFWlSU8vIq
5Y1iBGTcURolyOtrhkXCaqs/6aBzV7TBa0XIO3P5E01h6kS4PjUzYSKzO7mekwKR
BSXXUPDr2MniTUSqQ1tTjQrl6+LwI4Xg5PS/+eR+Eu71TZXdqB/CYtfNjrnXMR2k
ryHOn+JwYxptH5KlAApF9c7N0Bvzvqnkv6x6ti4DyU6IaYpQUE/s/jPrBbKyfcng
/ogbZww2lQZhhqfYHRf4MneuwRIUKKTY4aytf8zMg80rGjJIxvk=
=6QDh
-----END PGP SIGNATURE-----

--vjczpwchn3jh5lgv--

