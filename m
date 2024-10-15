Return-Path: <linux-pm+bounces-15713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365A99FAFF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 00:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90E31F22ED7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE171B0F3A;
	Tue, 15 Oct 2024 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Y8MlYOVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1021B0F2A;
	Tue, 15 Oct 2024 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030314; cv=pass; b=PIqqmk11RtR5IIUBqRkbvDHy5A3n2ENkFKEKTfnREW1EB83tlFQF0e9bQJ1fu919sATwrjQowPV4ZDFLX6PAqwf3Qb1ak2QbsdC1G5OlHyjh6xI0sI6r+lpbXMD7IiU4DEBbH+35NggLmgcQ0inLuN0c/wPEfH0qYQhitUF44cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030314; c=relaxed/simple;
	bh=HMj/ZyO9zNpccPB0josTS7wpa0dytJ4KoeNtxF9AKRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPU2uKOiMT9DXVSv4rLRj9kQ9nOm07xcQiH0p9HbcN9c+TUF/VLv3KBr4x5msGln81CpUni8HOtRii8g/JuK8yC8Nc9iwDLUDM4/G3cmXwH0CN4AwGFCkP+pwgLZuuNaHBicb+yz0+m0AzLsm2SDMv6cWrWX82x7TCCSOT8mzzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Y8MlYOVa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729030293; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JvPspVLsF+z9g2UWZCKpHn+pWhy37tJ9ndVdbmFdzRYnovcBFYNv8zVZKou8o3B+VFftpcJpy2ge4hJh2xigOa+EPmxlwATMSGmW1XltIxVw74/CdH9UiqRAgoP6QRmabvdke+65H9jszG9flVxo6i0WqIooBCNyf3xGrlzwXog=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729030293; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HMj/ZyO9zNpccPB0josTS7wpa0dytJ4KoeNtxF9AKRA=; 
	b=G2pUFb4TDq2aT4WM7TFjsULRNIMTP18C4V9zDvuZfAPpP66Kge+2Qe4uzN7YNmnNon/g/GF15HBtrV3s0Z+V1Xx3gxchBffp5AoGToOa9WTfQtcnt0HNF9HDR7UzFFfFaSZZyLq2TETckbk6U3sJRG3QF2dvcMAq+IXXvTx0xUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729030293;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=HMj/ZyO9zNpccPB0josTS7wpa0dytJ4KoeNtxF9AKRA=;
	b=Y8MlYOVantCVrTrickvcshdEGEY58KLgbYcyZ+a8Eo8pEWNrbx7UVYCiHEKXsuFH
	kgH0JeSbnlC4uF97D+iCnHXfsM/5F0B0ApOIgaNRbp1FMQKV+9BsJUGwrOFmGKVDm/o
	PPq4xBK/p1yd/RmKwULLjavvEo40PeQJRZepOanM=
Received: by mx.zohomail.com with SMTPS id 1729030292653381.82924626488114;
	Tue, 15 Oct 2024 15:11:32 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 90E5F1060433; Wed, 16 Oct 2024 00:11:15 +0200 (CEST)
Date: Wed, 16 Oct 2024 00:11:15 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, tony@atomide.com, Rob Herring <robh@kernel.org>, 
	linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, khilman@baylibre.com, 
	linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v4 3/4] power: supply: initial support for TWL6030/32
Message-ID: <7ucahlofrnajeb7z3tmkx2aninkxpbwx3mdykeeugtsct2o5gh@5dxrvnl23dsy>
References: <20241007150120.1416698-1-andreas@kemnade.info>
 <20241007150120.1416698-4-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="feqi6aul6coybbv6"
Content-Disposition: inline
In-Reply-To: <20241007150120.1416698-4-andreas@kemnade.info>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/228.353.45
X-ZohoMailClient: External


--feqi6aul6coybbv6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/4] power: supply: initial support for TWL6030/32
MIME-Version: 1.0

Hi,

On Mon, Oct 07, 2024 at 05:01:19PM +0200, Andreas Kemnade wrote:
> Add a driver for the charger in the TWL6030/32. For now it does not report
> much in sysfs but parameters are set up for USB, charging is enabled with
> the specified parameters. It stops charging when full and also restarts
> charging.
> This prevents ending up in a system setup where you run out of battery
> although a charger is plugged in after precharge completed.
>=20
> Battery voltage behavior was checked via the GPADC.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Looks mostly good, but the driver should set the fwnode for the
power_supply device to be ready for better battery support in
the future:

psy_cfg.fwnode =3D dev_fwnode(&pdev->dev);

Greetings,

-- Sebastian

--feqi6aul6coybbv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmcO6HkACgkQ2O7X88g7
+pqLdQ/+PXvfJs7me93/MDmbZz1KCEnmFhnBP3VDUkgMuOeF0/AtoiXKlImJOjSl
Vd8WmGESe5nbalm0muNz9j83t96RxDZaBJl1wS637l3A760SyMuBrLJaQ6WNPNnW
kW8VUW4uzPRLPs9/QjxVaeYqAnPG/xaavLiuWvbh3LJcgnNEgwTlWjqOKr1qtAr8
1GuhPGndgRMIPfdWrwXMZH5ovXGRTcGCaXsBgKrqodsE9fF0C50ZM7+JluOD8aRX
SnrC61Ik+WEJ8J1aHgwg20dhK4TmcpTjRRPHbZlFgGv3wLUapuCr4ngZdxUyDuOJ
A6VSxvVd7dJmbz1UQkOwCJcDQBtTUTMKu5si4f3gw8SoGpjuFCuwkphF1YWaOQ/+
8AON8jOAJLotGQ692uirk/7XbNJv2/oEtM8Rb/rj96sY7veumxEqW79o9HhzhT+/
u9r0HB/em0nCOxHZthflcK3oSGKi7tR9HHiEO/P7cncztqZHyL5SHb4T6/6hgt8a
GKYVC58MK0VomCMOe1Du/YOFw0y+ldtoCGpanTMcUC1ZbIn/k8M65ikSTQgfxjCo
NwfaH5hSSo+YxeSolMyPtvFRB/vkadBmvPy3MsTuEv6vzQbaw6EmowqJa1uxRBwM
CUw5YY1XiunxmbDO4eZpFeK5qgmwiA0DdrgcKSsdpLoCOt+DoQg=
=iWqU
-----END PGP SIGNATURE-----

--feqi6aul6coybbv6--

