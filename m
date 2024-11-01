Return-Path: <linux-pm+bounces-16891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADD29B9A47
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 22:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45278B21BD3
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509561E32B4;
	Fri,  1 Nov 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kJFGcK7P"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0416F8EB;
	Fri,  1 Nov 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496988; cv=pass; b=fFQIT8wBauQc9z8si+/6EdmfYpa4di/nQo9tvUtYdJXiqfujxAvUDpmxfiTesk4NFJIqZuog0pXlq7vHF4W77QD3E8u+m7OLOqFXQSxuZh9LghbYIxzRTSF3iWsa8RkDvho+WwPa+M3CdHrpvZ5Ea5n/T2o12gxuvsGTqnPgg2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496988; c=relaxed/simple;
	bh=dUYHsEZiYqbUgRMNwFN/xI61QBnMhgl08f0EFMD2ha8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2SWHcnLdE4TH98I6+wXqRMrrk+CmYlFmd6qJScUziGqVc2W5J0py+taoX0zcpY33pR4KUQveVJG4g9wZrnC8lJUWQV/PVxmds8/IRJu8yTfK++NLtyfTZrUHaQx4w7KZ4caGC2UxNabIpCz+TaJ2YhrajzgagyDJ/AVb9lUQZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kJFGcK7P; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730496962; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c0/oSnW3qgXohyX2ioSOL6MsthONf456o2MyAC90ucdp/0GIaV0mDBTaIpySDqr9v3B0qT0UtEDpu6TAlhOQwIaSh9j780dxyYkxDrE1EG1y7MHQ7YGMRIo8UVk+lNPCtbCzboz/SzODmDilpzSLil9N2Oqo7tor286GjYbn3Ro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730496962; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dUYHsEZiYqbUgRMNwFN/xI61QBnMhgl08f0EFMD2ha8=; 
	b=bDR0qiYaIPIRJI79NFUAcvJaXK8Nh8Pnkm1IDgHi+ogZHygWINdPVOUa14mRZMhhCcARQI7x9oq2PzI08ckSlUUuExnFJkLVdPvxpt523SyfU5SH5O1nXBpf6iAZpDn6U3yQFPJ9GzKiOAhX9e6QxkKcBm3RxexYCFSxtzz+4ZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730496962;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=dUYHsEZiYqbUgRMNwFN/xI61QBnMhgl08f0EFMD2ha8=;
	b=kJFGcK7PraYbPv6+lH4VJtSEtn0RmXlwv65YniGVukJFQJjQ7NIEsbipvdd+v4bH
	hTZivSykCSQyzDNBJMKc/7vLrVfrEWnStHsq89EFpVLfRwNGuNJ4yibM2ddoLYDMp81
	xjxcELlEfOhkH2iKkG4LLn1BgBQZu9p4vggHiyTc=
Received: by mx.zohomail.com with SMTPS id 1730496960315327.07503190696764;
	Fri, 1 Nov 2024 14:36:00 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 95B8010604B0; Fri, 01 Nov 2024 22:35:53 +0100 (CET)
Date: Fri, 1 Nov 2024 22:35:53 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?utf-8?B?QWRyacOhbiBNYXJ0w61uZXo=?= Larumbe <adrian.larumbe@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
Message-ID: <avq5v5c23croz7fydzmmuj7zmcfp37ehgrt3gl5csyam5lbx2g@id4prnbhv4ot>
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
 <CAPDyKFoAv1jeQitHmTMhvwG9vGzN-vLby0fPzkX1E6+-Qe2dog@mail.gmail.com>
 <CAPDyKFp=sRLVBhW2aK87pYHVGi_6gNw=e3j3AGMnEWP2SVYFpw@mail.gmail.com>
 <9b4c9b61-a2be-465e-a4d9-034951fc862f@sirena.org.uk>
 <CAGb2v65ahUB_Q+HPFV6B-UqWCbCNLdGz58BGo9iHRhVyf1ruZA@mail.gmail.com>
 <27yrptpmhdbugmrgxaxllnbllv3adu3tzgl7e26b3flsvhlf3g@nfqn2fvmktmc>
 <cbe94b51-09f3-44ca-b2f1-f8da7ffdf05a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qwagicrogdfbufct"
Content-Disposition: inline
In-Reply-To: <cbe94b51-09f3-44ca-b2f1-f8da7ffdf05a@sirena.org.uk>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/230.373.91
X-ZohoMailClient: External


--qwagicrogdfbufct
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
MIME-Version: 1.0

Hi,

On Fri, Nov 01, 2024 at 07:22:28PM +0000, Mark Brown wrote:
> On Fri, Nov 01, 2024 at 08:04:52PM +0100, Sebastian Reichel wrote:
> > On Fri, Nov 01, 2024 at 10:41:14PM +0800, Chen-Yu Tsai wrote:
>=20
> > > There's still the issue of backwards compatibility with older device
> > > trees that are missing said supply though.
>=20
> > Exactly :)
>=20
> > As far as I can see the same misuse potential also exists for the
> > plain devm_regulator_get() version.
>=20
> You'll get warnings but I'm not sure that's such a huge issue?

I see that as a feature and not as an issue. Obviously the
dependency should be properly described in DT. When we upstreamed
GPU support for RK3588 we did not mark the GPU regulator as always-on
[*] and that has been copied to all other upstreamed RK3588 board DTs.
This means all of them are buggy now. Getting a warning might help
people to understand what is going on. In any case I fixed up every
in-tree user as part of this series.

[*] Older Rockchip platforms (which are not touched by this series)
and downstream RK3588 have the GPU regulator marked as always-on.

Greetings,

-- Sebastian

--qwagicrogdfbufct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmclSbYACgkQ2O7X88g7
+prITQ/+Lo2bN91GtZH1sC9wK852DhkaHZ3XYvltKURPIJZu7p2GuqGeFZw+mUWr
PIoHHiVAfjOI+I2Ycvg5cuvXVaTaDV1ATBiJjaKN/qWH7fgq0Q3iQgNi4ArU3KS8
6v6NBCzzUiWslu057EeEIvq3KeH+Q7OSxl3IUWPSJS6NvelgecvneNi1j9KCwq3h
RVl3IuumWYLfFZ4uW5ft/+dy3GNCv6HdlFmLvcGFupZMqpXFv9yOvpZGl83YyPv5
amSxtr++aKMi7h7kryjXHySD7BxR90JL+fPHXMGvxbL8ayKgPVyjM1kfFVhmcYt4
yKRAc/G5Y6TY2d0bshHDRfpuVL4/mv8Nzbz4mxai1+KvLnEAWi1A6845dzKje1Ar
m0CEj0WpiMgffPw/E088YvwNMdntMrLB/okNn+EjMQlecz332dNFDlj/KvXB5+sk
8hwW8MjOK8ALlS9RcVS/s3CzD3dcgTo+5MOGA2i2WqFEwORDvjDmzltwA0Pj5Pl3
Pqy+0T/scBUtdrjGoeTxO4iGZSn49TFjEMO92DAjnyt9MUq7Q7aCUM1qPCtbE1fe
9ukZF7jBz6DhJ4ahNv9Uk8uw1KcwPa7I0jxRAscacZBvBWwb0D9nGF33vY4h1Ivc
dvz68qw0uirqexV2G6aczQ5FoCY3qbZ71NX8MWUWY0ykK5do+cc=
=9b8r
-----END PGP SIGNATURE-----

--qwagicrogdfbufct--

