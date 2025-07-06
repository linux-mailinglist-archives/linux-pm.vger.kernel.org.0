Return-Path: <linux-pm+bounces-30230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0DBAFA868
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586DE7A2798
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9101F8EEC;
	Sun,  6 Jul 2025 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="fHqd48Hj"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572919005E;
	Sun,  6 Jul 2025 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751844862; cv=pass; b=jcuZfsZJ+hk8WrGYA0NDbelXBqgPflxZSX3vFRMQuT1NFEl+f/ACyTWYdSTsYkMFQxh1+Wq9JoWtG56NmR+XhxsIc6CASMLrE1+3PtGUv3biglAGjBBZSn36pmJEZWzWlBg78SzXK9AnbZeeKFWJWraZhtusprwreu7JZ6neBoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751844862; c=relaxed/simple;
	bh=itjhecGpCikTA7dpGfNaSXg7eAyxUUlQBMvigTlb97k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqwzD+wYdi4Y72fHoqPnDTJuufPjwGr5cFE+6cbhkFQYBn3Q3S41FHAt4zUfwVw0YxJBzVtv8mzL79Q1HYFkHRN09kZPjAUmApeQqTHXywlzq8aUJwzvfjoQ77kUXlvDmsysSdlS7cF40exNbks8AZSPw0HBguZP4FB/i2dMmHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=fHqd48Hj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751844824; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BGHqLupuRiyOQ1O3SOFWjX1OzBR9/2L7EWvrdj4HC3DJ/jytlmR2oTGkvdkTTkiGWcc8Ijn6VTC1kcu+TMse5Y80UZe0qUlI6QQChhRRH7LGlSMsZEy+GsbqZ/7lN/ntpebKG6WsrhazZdgqCCUDZ1MmH2+12uixVLJqE9lKYMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751844824; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=itjhecGpCikTA7dpGfNaSXg7eAyxUUlQBMvigTlb97k=; 
	b=FSCPsjbHM/QxheLzaj2IeDe18PIhW0v9YYck/XB+AhqrAH+Igv0HShxRaF+Te00iJIxc6hvX71Zx45J6YXOVfO2/989rxIPCP8vy9sQrfNb1BC6Cpuo70EQrezls9lAIEly5Kwl7b0jx86Nr3F84LgSqfV/XV79qnmFxzs4Bulg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751844824;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=itjhecGpCikTA7dpGfNaSXg7eAyxUUlQBMvigTlb97k=;
	b=fHqd48HjBTov/+ORYD0F1yxkLSXlu7JcNS+HeYvgngpp78UczV/swrwXMnSBXcsn
	ZpocJNHdOcJepk9PPLo/xl+BkCf0242YbOp1zk0tR52eccGEVyS44J/A/RCSaEmq9fN
	4ZqtNx/s+j96u+Ghlcc7+UlC+M4VRjM7Z5H2gBmo=
Received: by mx.zohomail.com with SMTPS id 1751844821754603.230935627197;
	Sun, 6 Jul 2025 16:33:41 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 2C647180F14; Mon, 07 Jul 2025 01:33:36 +0200 (CEST)
Date: Mon, 7 Jul 2025 01:33:36 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, 
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v7 5/6] power: supply: pf1550: add battery charger support
Message-ID: <i7qehdo46eegyj7ebp4hetr7jtwkxceoate6tqw6aukw4cbgsl@pl6lgh4k5m4o>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
 <20250612-pf1550-v7-5-0e393b0f45d7@savoirfairelinux.com>
 <xgwx65axwiebh27hrq7rluuf7jynb7v4o77mf2zztsf64bx3bw@iagwzeumk2su>
 <aFwFhYoaWoSXcFdR@fedora>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hkm4pffdfaovyioh"
Content-Disposition: inline
In-Reply-To: <aFwFhYoaWoSXcFdR@fedora>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/251.827.75
X-ZohoMailClient: External


--hkm4pffdfaovyioh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 5/6] power: supply: pf1550: add battery charger support
MIME-Version: 1.0

Hello Samuel,

On Wed, Jun 25, 2025 at 10:19:49AM -0400, Samuel Kayode wrote:
> The pf1550 charger receives a VBUS power input which can be provided eith=
er by
> an AC adapter or a USB bus. A depleted battery is charged using the VBUS =
power
> input (VBUSIN). When no power is supplied to VBUSIN, the pf1550 switches =
the
> load to the connected non-depleted battery.
>=20
> I could have two power_supply_desc, one for battery and one for the exter=
nal
> power?

That's acceptable. But don't you have a fuel-gauge for the battery?
If you register two POWER_SUPPLY_TYPE_BATTERY devices, then your
board should have two batteries. If you have a fuel-gauge it will
very likely provide much better battery data then anything you get
out of pf1550.

Greetings,

-- Sebastian

--hkm4pffdfaovyioh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhrB88ACgkQ2O7X88g7
+po93Q/6A6bYXRf5lstEnL9kwKOfTphsoJCMbORUtvQ+oD/fFxd9tJ2CL8+hZ9GZ
++4xcLZp7Qc6HnLXF3OjnZBjCsCVUd/uUyfH6fU6ZqrXqLTJC2hFHHsuIvJUw3zZ
GQY06j7LYRgvXuM2orQoxqtyi1x/GnajlmYzeUzT5NvvWWyXPE+rOPea7DeLghvM
VVtlcnRIFQO2K/ZS6U0reUFDlzzjX+BfiyRDciBRIj9Xb8L5vwEiUdKXe3edZXyR
xZ9/shpsmELBMo2QNjKN3dT9ReGqX+z/MxubOhR5CdK54nYsxl5fSanVIvNZ9AF3
0sMvhYm1Iop4JZ6pCJhCLd2GCrAsys1LQ0f/6ppYU+zH4DHYO1+gb/g/UN7uFdvy
aGl1q3E2XBQXUdVPsoHCuPId77Om7+opGaxk+vEtCw0H1a/1cmLvkfvkShy+XqKP
nb73pvL9o2zECr6zeb+M2Ff+/1zv+R2p2HVfv51CHYC/LHvZcs+2UVQ+ZlqOEB+X
Vr/9khKhm2E/WOPoINRAWbu17bvy5TCfyAej6hJbAB/TGkNv1FjYBmxmLgb1BwDT
NN9dJVyBoDh5hqn9qAvs/cP40RWuP/dABj6GZ6AHYWaJMHOb4eC7zavrvWSBemWn
Sow9U1YcnEF2WcTpp6WtK0PO8T83Gae4fY1iRlWLjN2tkqYffUE=
=hZ0x
-----END PGP SIGNATURE-----

--hkm4pffdfaovyioh--

