Return-Path: <linux-pm+bounces-22942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6295A44EB7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 22:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030AF171C4E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4BF20C48E;
	Tue, 25 Feb 2025 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="VZMI05Lf"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E81A23BD;
	Tue, 25 Feb 2025 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518651; cv=pass; b=IloHQ9c5uRcJueq/5vMXZ17B2OnjKzwtzEX+2j34MdzEfUH31yEW3Se52xhAiYQhBoEpQO2UNge7a+XSAGDqSa1bOPnPOKUJwHoT5rts7njVnDynMYQgVE7TMrYftTNhF6RT/oXGBhY0yE7rnN7e5Y45cv9Ex2PROY6v5eTwasA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518651; c=relaxed/simple;
	bh=yifWYicXzI3Racy3WLNPfPX3gSInoMk9MGp4tHcStF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+0uozk4BFIFb31un9OVrSHzWHWrXR592FFFDK6GWH2Goonklq7NXFimrkEvANjsvOs5hBXoGlzaBJraogH+s1h75rvjHhLzXVitT9TdLlU+lwFBo1ePhEy7jblXHnZv/Ve6JfnSCky7/1SeZEUVdupiFHjXB0rgiz4eUw9jflQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=VZMI05Lf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740518576; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VQ2zUjBknzn2fmSl3OndjkBykCq6GH3YuUXD5yu7z5+pqCpQNl+Ruz2gb6ReS+PlvB7W790tIhDa3l/BV+tCifHsB3Dn+li2pohgJn8XbT+Wvbx7HFL7knG09YzGcU8EAF0gTtK+wUfpT13Xa5nPWLjHBLXpKBSHOC0GIJ2XLtY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740518576; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PDVTKSM1rcFjNwRRV/0KaHspAmH3vDFXNZuyf3meR0Y=; 
	b=KAqxisptIvOtUWOG3/+nOvLQaLBf8bUImwjIguK5eZHbHnM+kgZK9KxTWbfs5dlGJdHYlvssxgGUmaKlbeOzkvdZFn72sEaN9KaSaEwQ3/bwrzYdno7PYDAl2Iw7FZTQvYNOkSS3NgpBZ5P2lgnymWItTMmsE/QLjOwxyqpzte4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740518576;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=PDVTKSM1rcFjNwRRV/0KaHspAmH3vDFXNZuyf3meR0Y=;
	b=VZMI05LfLyyWPl0+UeCgDE5+u4fdSF4zFhcfpdraUnoy8v/M835dRL/zZFPtJC3j
	RLfixi+m2Bzvlxl6W0sDDNBAV8Gg0bhbeLS7vUzTjosyt1C3Ub+da+pZI3WKB8ifLP7
	O9qzAZPA+h8Q6SweL1iTFwYgc7ut3LVgkZYd/SnA=
Received: by mx.zohomail.com with SMTPS id 17405185698304.8376916548969575;
	Tue, 25 Feb 2025 13:22:49 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 7E04D18040A; Tue, 25 Feb 2025 22:22:42 +0100 (CET)
Date: Tue, 25 Feb 2025 22:22:42 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
	David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Konrad Dybcio <konradybcio@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 7/7] power: supply: core: convert to fwnnode
Message-ID: <duzge5bpxv4cd7b27pq2daisqtaw6mtt6oxl2u3hcdxcnh5tkw@yasxlx33yxbi>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-7-d5e4369936bb@collabora.com>
 <a98547f0-f125-45dc-8bb6-a154ad78f672@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hdfg4ybxxtxchsut"
Content-Disposition: inline
In-Reply-To: <a98547f0-f125-45dc-8bb6-a154ad78f672@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/240.490.19
X-ZohoMailClient: External


--hdfg4ybxxtxchsut
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/7] power: supply: core: convert to fwnnode
MIME-Version: 1.0

Hello Hans,

On Tue, Feb 25, 2025 at 02:16:12PM +0100, Hans de Goede wrote:
> Hi Sebastian,
>=20
> Thank you for your work on this.
>
> A few small remarks inline / below.
>=20
> On 25-Feb-25 12:21 AM, Sebastian Reichel wrote:
>=20
> <snip>
>=20
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index a785742f97721e7e70d0e4c17a1ded7b985acb6d..9afde8c04efc72691c81a37=
3d8dd03477b4efd7e 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -805,7 +805,7 @@ static inline struct power_supply *power_supply_get=
_by_name(const char *name)
> >  { return NULL; }
> >  #endif
> >  #ifdef CONFIG_OF
> > -extern struct power_supply *power_supply_get_by_phandle(struct device_=
node *np,
> > +extern struct power_supply *power_supply_get_by_phandle(struct fwnode_=
handle *fwnode,
> >  							const char *property);
>=20
> this function now no longer is DT/OF/open-firmware specific, so I think i=
t should be moved
> outside of the #ifdef CONFIG_OF block now ?  The same goes for the devm v=
ariant I think
> and the implementations of course also should no longer be "#ifdef CONFIG=
_OF".

Good point. I suppose ideally the name should also change to power_supply_g=
et_by_reference,
since phandle is a DT/OF term. I will prepare these two changes for v2.

Greetings,

-- Sebastian

> >  extern struct power_supply *devm_power_supply_get_by_phandle(
> >  				    struct device *dev, const char *property);
>=20
> Regards,
>=20
> Hans
>=20
>=20

--hdfg4ybxxtxchsut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme+NJcACgkQ2O7X88g7
+poO0w/+PtjuypiPttq8FXdCRzUhU78WLqWOJidkFzOKBqamTFhS0xbCsok/IUFQ
AZSGVeoVEmZoASd8PRsXkGrfTDTq7LU3mcJArxufUITgc3y4xqEBJ82761VW16mJ
g6koal4Wi4eQ/6BPKPXlXk8fcRiMNKmy2dZbTbivI2q7fmFzVTQLmgMTCi9241XP
XYiyyHC7cI7/iHtXomgitOXCTF6qXBdXuB7nx/yE+qUofYF8akM/cD+ya5ktzGym
ZKoizoAVDpu9DyHK6uyJuwBBc6wgmyaH91iIrw8xlfYR+OSHy+HRUyM8NTbROpSr
nrD0I1ORi3uxjJUeoZ5v/bi70gLMXDEDaxQk7FXrqfBRgw43pHGnMIZsACK+b2Zv
sFEez70kMZFHJM99oDJ9ZgvBZwrKXc6ZWvYXakX1IW7iNWUoEhXBLnXf2Zrni/Zx
FMq6lr7s9/QnEtet/17dUKvCp9F3V23kvDbrJRV8C0ujkpW9wfo2VEvfPJNH9Ku+
vdFDUeYNn7RvwHAsHYlmB/GyCUGdYLDsvyHPMbp4l989RUtNC0OF4t9bAVwJFdUt
3oN7y6BOqfQa4EcP0fv3Ui9ITiak9BweFCVPm8aHqsKkqnIbzx1N9aaLB+TqS3is
Xgz0BGWOempPbvaca4fuYrmSOsnC/gNIKFi+LMd5QmMhyO1ybi8=
=g2xY
-----END PGP SIGNATURE-----

--hdfg4ybxxtxchsut--

