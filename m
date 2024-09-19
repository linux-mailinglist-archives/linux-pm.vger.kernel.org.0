Return-Path: <linux-pm+bounces-14493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB86697CE21
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 21:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2912B1F21EFF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44045225A8;
	Thu, 19 Sep 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="boxTSPfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E014A96;
	Thu, 19 Sep 2024 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774079; cv=pass; b=nVfOScKYJfx0V+hvuxTp6E5DwtugNfmijpnsyu27mCQfkNvPNdKiwLqGtyZB2gEjmjUEMhHiWSyYIYEArnE8Aprb9FpDYjWm89l2mTZSR4PEu/PEZ+z0D9m7wVxOTCZg5bvVSekEOWtQ/Hk3sYqwwZRb7Xn6JWlBhUyDtAcDs2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774079; c=relaxed/simple;
	bh=YJa2JxVMqhfa9RmCyikEb1Uo1+h8M9rFrkHlJndLIOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfXi8+pW7GLgoPOXyRGco/k4krArLk5yfez4ufM/eIfl1EDgU0lbmx3Izo/5+x+Elgnio5AP15fGbJJTeSxD1hUMbjiKp8dQlajeH8nirCc35p4uUTB57fwXD81IIlQetQw1epIiZNJ3IiiqZ7G9cfvkouze3cadNl0cckOd3aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=boxTSPfr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726774046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gzUFKT1zZHbHP8nrXYFQSeK/Vbu95YHXygfLOyzh7xLvaS+kfB4wbx7xPFlCub3gcfSEVOV+gb1jAd4z3YCyXyaaaMgRJeeLYjDWGYm1Qc03X19kr1YChlB9U8mZhbyNv/UQ8GRvrL/eIft9KpVGH6enO/Ar+IH21aGflvFqlWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726774046; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t4Ne6sfF33Z90OyTmpxA9lLW1DDECmfnMlVBavSL5ic=; 
	b=ipzXPtcdqeWebG+eqHH0DMV6ZnEIBxSP4DKIKEkSVEDO435h2ibNSrpjCYffUYGkQx3Z1aLp7YArZuwxew4/LtGjBCiv7qySAPT1qIfiPpR2pGv5n8XZHe36JOaU8I4YVnEbrM/98Cov5/H9f6JJzhGzal3i47/5Z5etbrJ3blE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726774046;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=t4Ne6sfF33Z90OyTmpxA9lLW1DDECmfnMlVBavSL5ic=;
	b=boxTSPfrtotkdSf8bMksmMn/hm2KakSAkiCoWXnsGwZZxhVlxlbNwcY4zmfbtW0U
	zWipuumOiMSwc5x2E510uzqFaxClI7zwIiMr1L6ubMeeoE1FN+keULZZ7pIGqfz+fYG
	vX8EOjOkteMYJzqcXO8Qy6jVGQWLEPWUkiUPjJyA=
Received: by mx.zohomail.com with SMTPS id 1726774044357158.77599800361543;
	Thu, 19 Sep 2024 12:27:24 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id BC5CE106031C; Thu, 19 Sep 2024 21:27:17 +0200 (CEST)
Date: Thu, 19 Sep 2024 21:27:17 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Elaine Zhang <zhangqing@rock-chips.com>, 
	=?utf-8?B?QWRyacOhbiBNYXJ0w61uZXo=?= Larumbe <adrian.larumbe@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 6/6] arm64: dts: rockchip: Add GPU power domain
 regulator dependency for RK3588
Message-ID: <zvzrjkacazxbv4cjxcnihv4rb2t3tu2zjd6zkny63ygfifpz7i@j4saijws5rcp>
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
 <20240919091834.83572-7-sebastian.reichel@collabora.com>
 <a4d94eab-8543-45e1-b657-fa7f12470538@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qcskwoh6fbt5qu6y"
Content-Disposition: inline
In-Reply-To: <a4d94eab-8543-45e1-b657-fa7f12470538@kwiboo.se>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--qcskwoh6fbt5qu6y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 19, 2024 at 01:33:25PM GMT, Jonas Karlman wrote:
> On 2024-09-19 11:12, Sebastian Reichel wrote:
> > Enabling the GPU power domain requires that the GPU regulator is
> > enabled. The regulator is enabled at boot time, but automatically
> > gets disabled when there are no users.
> >=20
> > If the GPU driver is not probed at boot time or rebound while
> > the system is running the system will try to enable the power
> > domain before the regulator is enabled resulting in a failure
> > hanging the whole system. Avoid this by adding an explicit
> > dependency.
> >=20
> > Reported-by: Adri=E1n Mart=EDnez Larumbe <adrian.larumbe@collabora.com>
> > Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts         | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                | 2 +-
> >  arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi          | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts               | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts             | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts           | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts              | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi               | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts           | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts        | 4 ++++
> >  arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts          | 4 ++++
> >  12 files changed, 45 insertions(+), 1 deletion(-)
>=20
> Any reason why following rk3588 DTs was not updated?
>=20
> rk3588-evb1-v10.dts
> rk3588-quartzpro64.dts

These two I skipped initially, since they have the GPU regulators
always enabled due to the coupling. I'm not 100% sure if the GPU
or the GPU-MEM regulator (or both) are required for the GPU power
domain.

> rk3588-nanopc-t6.dtsi
> rk3588s-gameforce-ace.dts
> rk3588s-odroid-m2.dts

=2E.. And these I missed, since they are new.

I don't have enough time to prepare a v3 before my vacation.
Note, that not describing the regulator just keeps the current
behaviour.

> I also expect we may need to define domain-supply for the npu on
> rk3588 and also both gpu and npu on rk356x in a future series.

Yes, I already discussed that in Vienna with Heiko and Tomeu. The
binding change also allows adding a regulator to the NPU power
domain.

> Similar freeze issue has been observed on rk356x when booting vendor
> kernel with npu support enabled using mainline U-Boot and DT [1].
>=20
> To work around that issue on rk356x the npu regulator could be changed
> to always-on/boot-on to get past the kernel freeze [2].
>=20
> [1] https://github.com/armbian/build/pull/7025#issuecomment-2291067748
> [2] https://github.com/Kwiboo/u-boot-rockchip/commit/da31da4b68f858f54364=
a21b0dd00fef2ab0d0d6

Yes, that looks like the same issue and I guess the changes to the Rockchip
power-domain driver should also work for rk356x. I don't have one, though.

-- Sebastian

--qcskwoh6fbt5qu6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbsexIACgkQ2O7X88g7
+ppTJxAAkEXAcW4m8OiEyvh+R+umb7431j7PO5cBpN3NM+cGmUD+ARwYE4yCH5Mi
lqLf72szC73KnWPS5Eu9mhCEFBIrhNmEVrQM69ibmlHyihhZh2CO3X2wDV+UAm79
ZyJ+OP71kvCHndjSNEXILKxXAyoARczvn+tbFICz3di3S+UXlqs1s3NnzGvjjBlo
GwxkCx5JwIKsdc3FOe5Mtj3Lw08lCF3qxJTXxT9anF/2h055IJco8diIsGlAAXy7
LnCQkpgZZBLKeJFhFeuMV7lJgjGK0bsymHl6P8dzXSIZtXBLbMRTXql8qunv4cUY
hkVH0V6iduGVdcj/uZEpoOAAXqFQE+1UVA8Bsyf69/o3806iUzR3Z2zJk7CdZgu3
3PUw/fpgDmFpMI7nIIH2GY6Q5+4yssZb0nd6kzCepIf41dQWAXAvvq3bBCjRz0cw
eOP/BIZYEFwRSOu0YL+EQ7ae4kQ/j05sFMCBRFRGUB4uoLZbKWSos/SRt0DWTNQv
N97DxGJmjfxH/zSxExgLqebsV1KZd6Frg4G7Nzp4XgW8hghoqPe+0YvQVNMLRfq7
Y+y67lrBNCnEfnGv+mIU+cDWaH1NDlPAz1Zfjb8jdBOizYJjfohFdOyRNWc6RVh1
i8kJklC2dA/K95e/LTU+1bPYFnnrycmrvFKrjECNmIGRAuRIz6Q=
=nKZO
-----END PGP SIGNATURE-----

--qcskwoh6fbt5qu6y--

