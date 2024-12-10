Return-Path: <linux-pm+bounces-18975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E089EBF41
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 00:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D14C188A68E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8BA21126D;
	Tue, 10 Dec 2024 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="RsRnJV2+"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB986324;
	Tue, 10 Dec 2024 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873276; cv=pass; b=cOLU3B5n/8eITrH/Q6Ay4AYQJiz1MPRA6Gp0dc7OT3cCgXNcEafWkFaFNMMucgTM5KLypbFWfagGkjdt1O699zX+ZqNNuHT1IC/md1IiQT5DwCjejcEF/MiYwbuu2nEWQ5wI9vvtLzl2kpiTQBw8/S43Nwygtbc+zFvhHbxTVSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873276; c=relaxed/simple;
	bh=S5Y+gIihRXFWBQSH13/S3EIEmvAEO9vUhJ1pyTVGmIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBeq7ZCbsVbgQxVUUbvjwiiwTClS0MdDKXwssLkujMGIz3UJgmyAMVOmUiPh7F4SCd6zutfefKNrvsVPdpDBNswseFnC3CdB/O3f1TLYbG6TECKVdDkKl6Fl5rySUGVWhSXtaudGwghaWQ/kLl0J9oex24+lD0b/TqGIkSzyUZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=RsRnJV2+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733873245; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T8mwsCj1K4qwWnOKCe3SMccU8Ee2A9OLp88pJzI+MH+en/awE5CNLBeEO/pvHVYnFAwgGIm1Sjm9ckMVzdfGidIqN5GFWd0fJ4JNLdr184lS/izkbeUN3uHh11ttGiyxfGnE6RG6z5SPdrQMbHWa1KkiM8cRPlAQrxvXiiRadVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733873245; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S5Y+gIihRXFWBQSH13/S3EIEmvAEO9vUhJ1pyTVGmIQ=; 
	b=YrVJGnKk5kp8/0z3KhHJ7MdaLvwCY6eE4mivEgobUI1JEmNdHvUBizSQtMfLTgg6bbmsRvqJ4+mJFzaOAuTytomUfCdw4vs0nkBZrpkFVk+gW4M1nTs0NPAVb7znjMtULrFbMPZ+O0hEa55yw4NzQdl4Kz7/2t+MMXr132fNI8A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733873245;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=S5Y+gIihRXFWBQSH13/S3EIEmvAEO9vUhJ1pyTVGmIQ=;
	b=RsRnJV2+l1Dn3E0d12RhK64YIRQDl4uN6YDfJdEPIVrBD27U9kSLyuq/yJXlufCI
	YhBg8p4e5RanCxvLKGKKdd0trEskEAKZJqycXkOHd6U/10D2tn8TQ+nMboqg8AmCO8Y
	D4DvXzestQDc9C7Y8IjYtbQ5R1uinbE991r5wqew=
Received: by mx.zohomail.com with SMTPS id 1733873242779286.3544610017565;
	Tue, 10 Dec 2024 15:27:22 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 85DE110604B1; Wed, 11 Dec 2024 00:27:17 +0100 (CET)
Date: Wed, 11 Dec 2024 00:27:17 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?utf-8?B?QWRyacOhbiBNYXJ0w61uZXo=?= Larumbe <adrian.larumbe@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 6/7] pmdomain: rockchip: add regulator support
Message-ID: <vkeenncm2azxe6topeajc5d43d7gqgqrjtqadaz6cxbe4f7ucm@c4nhv5rrjvhd>
References: <20241210171023.141162-1-sebastian.reichel@collabora.com>
 <20241210171023.141162-7-sebastian.reichel@collabora.com>
 <4082877.3daJWjYHZt@diego>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6k6r4c3ojau36eyv"
Content-Disposition: inline
In-Reply-To: <4082877.3daJWjYHZt@diego>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.863.1
X-ZohoMailClient: External


--6k6r4c3ojau36eyv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 6/7] pmdomain: rockchip: add regulator support
MIME-Version: 1.0

Hi,

On Tue, Dec 10, 2024 at 06:51:34PM +0100, Heiko St=FCbner wrote:
> Am Dienstag, 10. Dezember 2024, 18:06:46 CET schrieb Sebastian Reichel:
> > Some power domains require extra voltages to be applied. For example
> > trying to enable the GPU power domain on RK3588 fails when the SoC
> > does not have VDD GPU enabled. The same is expected to happen for
> > the NPU, which also has a dedicated supply line.
> >=20
> > We get the regulator using devm_of_regulator_get(), so a missing
> > dependency in the devicetree is handled gracefully by printing a warning
> > and creating a dummy regulator. This is necessary, since existing DTs do
> > not have the regulator described. They might still work if the regulator
> > is marked as always-on. It is also working if the regulator is enabled
> > at boot time and the GPU driver is probed before the kernel disables
> > unused regulators.
> >=20
> > The regulator itself is not acquired at driver probe time, since that
> > creates an unsolvable circular dependency. The power domain driver must
> > be probed early, since SoC peripherals need it. Regulators on the other
> > hand depend on SoC peripherals like SPI, I2C or GPIO. MediaTek does not
> > run into this, since they have two power domain drivers.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> sidenote:
> part of me is asking, why we're limiting regulator handling only to
> specific individual domains when all domains sort of have supplying
> regulators - just ones that normally always stay on.
>=20
> But, the binding is generic, so we can extend that later on in the driver
> if needed. Especially as this fixes a problem that happens right now.

I agree, that this should probably be extended to some additional
power domains, like the NPU in the future (as mentioned in the commit
message). Specifying the full requirements for all internal power
domains would result in some dependency cycles since the regulators
(for RK3588) need the SPI PMIC and for SPI controller needs some
power domains to probe :) We are also missing the necessary
information which regulators are needed for each particular power
domain. I don't think its worth the trouble.

Greetings,

-- Sebastian

--6k6r4c3ojau36eyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdYzksACgkQ2O7X88g7
+poMUA//Z2Lub03b71/y64gXVTcpEunaBBeUzXwykw75YBgwV4DgdWbU7pSNKqXH
cyvQB3s9AcyeiW+qkww0CG9DOSTxNW2Ce44VEeoFP1/TMMxk4iLcjCUWyRDUfGiN
MDYlMX9LLgdJpwKvw5LsUduzpDcSc3TLgM90m7Zk+G+qxHThst6F7seiiT4Y2oX3
bmbIVQ9jSirM4mTTCyLQM/ekpD7rTiwjEVbka3n6bCD9O9VeN+bujUogtm6MWUwq
VX/PknC8B7aL1wzcqd38PMueA2WBLkNJJJGMD/RWY4LJGZj6/Ons1Rk5mKOuMxyg
HBwOpUyZhK/8I21j5QSnOvkq1NtCg35WFnfdlv8Ih2S+nHH3Og1yeSanuMCz3kSW
W7BsOaDpX+0oFBE0Bl31uohykfTmGvJfV6+Urn3NrseYLatGJ8ywLtv7zBfijhfp
2gOP7IOwlzlbwGHJyPWlwo7U3vSRdsFQLZliTTuaxQg3hKpk+mM3hu+wYRgeAWCm
ZeFclbVkgBkWUoFha42eNOHJ9SEKav0oqfnowBVOFfG90y+yzQNmes6gL75w2JFZ
loTX3O3I3iEgLcSXWN3vCuH0NuVsykVjPCIByXzOzSPZhz/S2CE8RByxaMkh6C5J
gf/tLVo4mOsqQYitJNWnySLTVjSapJ8sKgdm4PGzRvxx+3lwDmk=
=rwns
-----END PGP SIGNATURE-----

--6k6r4c3ojau36eyv--

