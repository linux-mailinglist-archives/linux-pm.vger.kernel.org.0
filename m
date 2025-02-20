Return-Path: <linux-pm+bounces-22525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B331A3CE19
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 01:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3905D175A37
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 00:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A335962;
	Thu, 20 Feb 2025 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="YZf3DmPr"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C11BC4E;
	Thu, 20 Feb 2025 00:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011336; cv=pass; b=Q/Mt86qBMZhYITTHxFLrFGDmJH4xg/k1Wl65YMYQ631jefXvdQFVokc8yXDDU592DOq4A5uEZgA1bpt64sURARWfhPODXYeS7YhTl7f32/oXydbDeY21+KK6EsZiaN30TZZUKIji+pFAzwWSK3ucTUxkFFpTgmnT9DA5w6XaWGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011336; c=relaxed/simple;
	bh=XrJymkHrg4Xa0F5pql+/LHtQtO2mzkx0YoxP4rSgNYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff8G+sOLg+cfO2tNmlcdpbkSIdf61IuGsLf+A0pZPAObW0PMkUR5YmVfkb6Jo2kJ+VXfkVvtxDyypmSt3l0jBaxDPBgeduon/0AfV985nKdurMkuRMe0MnXX5joiHjZDpy//LiS00TUAFvLhjVQOaITx3Qtzk8MlwyCFQkJF7lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=YZf3DmPr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740011319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mI2Sw7AZkRks4H3TBok7Wulcmgc4fxoK31qfcsFac99ofE146PaC37j1Wpn0WbU0hFg7dSSdjA1opkdoufEbmoVMxizRV/KA/D43Ysjc5xgenSW0gOV3gRhuRKPb9TljwczuCXr6C375Je8UzQEC9Tb/WZ6JOnD00Zb3apuqFPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740011319; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XrJymkHrg4Xa0F5pql+/LHtQtO2mzkx0YoxP4rSgNYc=; 
	b=iJFiOBBMktREJcG4508TBVNnSUJWECR32GrVlzA6/itFP2lftKZWUg22iezBT23gM+Ir0zP7JFYeI2EWgnmeOcX0dBGhA9TjWtmHQABR5TgLY4yvU55NjyLZPHTrB37MUtyhgwkHwHosIqWtYhST1ytEnwDAeUO3aUnhQa7u2rk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740011319;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=XrJymkHrg4Xa0F5pql+/LHtQtO2mzkx0YoxP4rSgNYc=;
	b=YZf3DmPrSiKg9BP2Z02sidOoJbb8hciHp+HY9zGoFEyf29Ipyrssi7oi8H6rhTwj
	spEKONGkq9i+eiaaZDyExHX7kEHaqFZ1lr5ximCwH+GRYV1V0BRpeD57/EhGJMECWwB
	mv84XSorJA3nuDeQqrw8V9nzaOlSf2uxAwTro0Bo=
Received: by mx.zohomail.com with SMTPS id 1740011316822711.7300853021816;
	Wed, 19 Feb 2025 16:28:36 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id AF4B6180608; Thu, 20 Feb 2025 01:28:31 +0100 (CET)
Date: Thu, 20 Feb 2025 01:28:31 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lee Jones <lee@kernel.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v17 3/7] power: supply: max77705: Add charger driver for
 Maxim 77705
Message-ID: <fvmtrsk2e63zmpn2zlgvv73ir5pvhemipyvytpzbjya4zxcrfr@bv72ij4qgpew>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
 <20250123-starqltechn_integration_upstream-v17-3-8b06685b6612@gmail.com>
 <20250210170337.GE1868108@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r62awjc3xphv45jw"
Content-Disposition: inline
In-Reply-To: <20250210170337.GE1868108@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/239.939.29
X-ZohoMailClient: External


--r62awjc3xphv45jw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v17 3/7] power: supply: max77705: Add charger driver for
 Maxim 77705
MIME-Version: 1.0

Hi,

On Mon, Feb 10, 2025 at 05:03:37PM +0000, Lee Jones wrote:
> On Thu, 23 Jan 2025, Dzmitry Sankouski wrote:
>=20
> > Add driver for Maxim 77705 switch-mode charger.
> > It providing power supply class information to userspace.
> >=20
> > The driver is configured through DTS (battery and system related
> > settings).
> >=20
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
>=20
> Still needs an Ack from Sebastian.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--r62awjc3xphv45jw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme2dy8ACgkQ2O7X88g7
+poaFRAAh/PmM9J04UJMB9Roae3PIGt5e7cnlutZrbKnikubUsy65QA6E1KzaQKM
ubkWPTr4UxQ2EBRzYTaDnvqgMD/r8T5in987cz3oGF0041QpxALkERRg5e6MtLxB
UVHsp/SR8Og1QUveCDzwgvkszdqayxwyLIGchYUNNvPnWzcRgN5WMfL9W+KwpRkO
/eJbg90YYLLyABEn7JAORpelIyVL6TD1jWMC3XUKQT4c/1mygSbQI71yYaUGhW4a
WJfxcZeufE3Y4UOlyzS5woBWYOoisw5N440k3R95sS451jKjyCXa5+fWVL8SC0IX
kelq+n7QfjxRDsm9oUYq4vXYAQVMNbxJGekEaGGt5hMoRidsJ3jmPVXatBj5NXuG
wPnhJrxnO/NgZc4SRBL/cAPnl4iRjwiAiw3hNFrZDilGfnkG6Vc3+zu2ABOGelVH
4/Uuw0l1EOxpXIe+MYkChRvRy2Xz70RwP296kKn/RPaISG/ycdeVRj1GHnx0tTtB
GwbAYVG5XvYdAJgPDtYK7XbXEGpJLoBwQomktolBspnhK1upkk6tDCBAZ61n4cFt
+frSTUajG6L/Mulpt1FIK72sLK1UTKOj4XVIYf5zzmoGhASoPJHXX5B9uewHqEzp
z51oV+E9O1g/F/6LgcbeWF6QHi/MXQ6ZxR34wUov0CRCMHwsXTM=
=9mGS
-----END PGP SIGNATURE-----

--r62awjc3xphv45jw--

