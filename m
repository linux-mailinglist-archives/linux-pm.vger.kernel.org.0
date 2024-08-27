Return-Path: <linux-pm+bounces-12986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5229B9614A5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F64B235C2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84551CF2B8;
	Tue, 27 Aug 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="OpKB9Yrm"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E81CE6E7;
	Tue, 27 Aug 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777543; cv=pass; b=bHVMWJsY+ltma7LX5i8fSN/dgr6jkGHT3UZkIPjOfs3uouGf0w374fpL+t3Yd/XLn6pLK1YkfBky7XJ7E3uPibVTvWSG6KPKF/ElSWBOrvbY3SRFtcC+xDugtrIr7qj6GTSqeE9FUMdoyayLpl9HvoSgu5fRY7t0RcZ23Dzg6SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777543; c=relaxed/simple;
	bh=SdgFpzzLedIEKAkguxPGHN9/qwQWneX547RqSrqEkJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpAKAc2SScICnh3K4Uk5taI9FZGjsoCyePsYhm9h0d90tUd76UGoS0TDz04PxQLE6fRzsV60UwDFC0oHrZGy03zTK3jwcy5Hlz7hqhj5tDOpB5ttWapxxDvKf85EgfkGYfFSpb+0GOOAwF0UuVuTPwEv6TRk1U46F4u/f9L1VPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=OpKB9Yrm; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724777519; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bwIumnAotVC8L8yTnDIJ27UUlcC1PksE78uao2ODkkufl04cSH8JCCogCmrlG5qYZ4bqXwpAq86gVwzplDnQcLzVtc1FxhP1AdtkfI8+IHmNHJhNDDHDaNPXYNQ7kNt5ix099nvgkp6nPRuXGeI29KXMiKbIhSJsdSv4b3yAWlk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724777519; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bYimh/iNRBlXEJfDnSGl77olRxlPtpIHOnaA2x9TrmI=; 
	b=RD1pKMmVbmawE7lCeTfRZtyqt8TXqLOYOEXBxSgTVShiubYZ4b+DoygxqYbjyQevJ9Q/iuG975SzoBiA5+e4mNJh3BjOvE5V5v8RkTjAeURbXe3YHEx0QM2nb4jKPzUFWX76+r+4tpMJxw/pZwi41Cy5ghydDXkWyCf2S97ZPhA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724777519;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=bYimh/iNRBlXEJfDnSGl77olRxlPtpIHOnaA2x9TrmI=;
	b=OpKB9YrmWW3ouB1HwEkLL4oUqdqaKrXgi1GZEm5DD+wiVoAl3NquUSWmuh/JxPcO
	1ELuWZ5FEZKOjF2CCzxuQp9ptPNzLbbdEFBX/1SCJjnAlb0kpVLHd+948hgHE+3L8mF
	52nTZraLSb5xTQvtsNl0NC/ieYRVoCBXdgz/azKE=
Received: by mx.zohomail.com with SMTPS id 1724777517787364.44684154521156;
	Tue, 27 Aug 2024 09:51:57 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 010D010604BD; Tue, 27 Aug 2024 18:51:52 +0200 (CEST)
Date: Tue, 27 Aug 2024 18:51:52 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Artur Weber <aweber.kernel@gmail.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
	Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Subject: Re: [PATCH v4 08/10] ARM: dts: samsung: exynos4212-tab3: Add battery
 node with charge current value
Message-ID: <ekqydclwg6dx6ydqcm3tanyho636hxtwpx3cnpj7c4dwpdxa2d@bbzaqvkoajrg>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
 <20240816-max77693-charger-extcon-v4-8-050a0a9bfea0@gmail.com>
 <f2d19e20-9177-4b30-9781-6904cc1d1638@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ugqlblyosjqwmlb"
Content-Disposition: inline
In-Reply-To: <f2d19e20-9177-4b30-9781-6904cc1d1638@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.300.3
X-ZohoMailClient: External


--2ugqlblyosjqwmlb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 16, 2024 at 12:03:32PM GMT, Krzysztof Kozlowski wrote:
> On 16/08/2024 10:19, Artur Weber wrote:
> > This value was verified by comparing register dumps of the MAX77693
> > charger with on mainline with a downstream kernel under Android; the
> > value on downstream was set to 1.8 amps when charging with a proper
> > charger.
> >=20
> > Add it to a new battery node and pass it to the MAX77693 charger
> > so that the fast charge current setting can be used for charging.
> >=20
> > Tested-by: Henrik Grimler <henrik@grimler.se>
> > Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> > ---
> > Changes in v2:
> > - Switched to monitored-battery
> > ---
> >  arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
>=20
> For next version, please split DTS into separate patchset and provide in
> changelog (---) lore link to power supply patchset with bindings. It
> will be easier for Sebastian to apply entire set for psy.

I'm fine with a splitted series of course, but I am also perfectly
fine with applying partial patchsets. I know at least some SoC
maintainers like this style of a combined patch series, since they
basically get an automatic push notification that the dependencies
have been merged. It also makes testing easier of course :)

-- Sebastian

--2ugqlblyosjqwmlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbOBCIACgkQ2O7X88g7
+pqhmRAAj/YUAksIichzuOKkEA9JWrEqtvZqm9QMWiY8zHymBBNObZKbUjHa+OBZ
jsx8GMQ1+4lnap1Llsyq9MJTQuaICNaNChUd+gAsnAbXW0Fsf+BumCD8Kd0Wu6U9
BugLOA/kYnaMd5nSeclaE+BshGj6wxySqkBvEU2dyFaVmBygHAx+6XAgJT8Q4682
a4gntdDDh3m8x44b1rg6frZoXR0TSome93wGIQGAYWpmuan49kAf1rt9/wFXWMys
79VOMPX57pIVl0kKYFFWefrqsTM/faMyzxxbyx980DB1GzvpEbMW/C3dX9vHhqlX
uKbBW18dkWGIKCfO95ZPVhXjpg+HiTpcN3GTW4O6IoOi+buq5Y/pg8wWk740f7Ck
7bKbmE7ay480qnjVGq/pdu6XVdTyoBr+vifztJYiD78JuQgrP2sHWBShmAEa/fU3
iicuyYE6txTYaEocVrWjVFr4k2eZYA6B4ELeeyAONgIsvIFJe3QK6Ui///lXovSL
Z4jYdo8TQV4WDKgLIQzJNk5EG/HGQFKrcDkcnbzQX442xmXMqEY5KQVeNeeceSwN
PsCop9CbI11zJ40LPP/ydENbhzmG2bgQyEAgAmrZ85YxtBS4wH5b7uVSJfQK4l7h
Aui4+8U3tPCiE/h6ovxqV5pN/CebJ/LOSeDJyp7kcvmOUgs6gco=
=5DI8
-----END PGP SIGNATURE-----

--2ugqlblyosjqwmlb--

