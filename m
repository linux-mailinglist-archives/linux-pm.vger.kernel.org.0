Return-Path: <linux-pm+bounces-28097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E5DACD9A5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 10:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BD188CFF5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A82690D4;
	Wed,  4 Jun 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="AwV4yb5t"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1C215179
	for <linux-pm@vger.kernel.org>; Wed,  4 Jun 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025491; cv=none; b=MO1WgtKAc6yHMOl2/EkZevk161UbhnbJ1wqSPiQYtqvvWJc2P0SQR6N+a4JWGA6julZ8yKYCq/9U5T8u2b37wBh0waIpp5jUiQeB9eLCo/QAXXJ9cnLk2WQhDMunKLObGJiiynTyRDa1xKZZ2KhXBS+d4stkL2e7RLKG01nTNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025491; c=relaxed/simple;
	bh=v7m5UbwJ3SjYF5H5l7QgqpE/OOXsuONm1Zx3lX/tmKY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=vDCqVDsYn2OWsgiU6pXeEOdQi3ljZRRCJrLqZCck0zLunpHL6TySh7LT3HLVRKY5kvs7cABtmg1SNAMkbklK4ozGPkr/TEQd7vRhSVmgOtHlskxKAUFNrh4Egeut1G/It8nado1U+zbA95FveEiHAdm9kiZp8fvFLXJ9AfAs+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=AwV4yb5t; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1749025484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kIUCb4+mj18vL7IVMw6tRgCs2/j5HRPHEfYTkdiaDeM=;
	b=AwV4yb5tbzT5syvc27hSpLLoViY4TIGoZg4e8D2mJMfFv5YY5nTSd29CLmW3612NtL140i
	EKKmgmYn7lJQj9bcUKyFbUeLHBuL2hSggdJ4FmqsbPz6RQtVJU8RU8p3CHVtfDBKOJg6di
	HtZ+awSorAM5H6wSi/9l8p9Mx/KTacLaVME0keuXQfzFd6ZqoK6kmP+MLHIBtfOP0DOUXe
	SOgr3RXz9LY3/oCGBNUva+/H/1rddijwVJMqyRxJcQ4S+VNjja1t27oNDqwPKcmF2NGdqf
	ZVwVL9XVM3ZbHrK0Jwfk2rhVhy5x/LNlI8eP0NK9YphZnaTjlMjR9Qx5XCI7bg==
Content-Type: multipart/signed;
 boundary=1972edf4972f0b592376148b0cb4a49b288a246b0dc77c2d96218fcc198e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 04 Jun 2025 10:24:33 +0200
Message-Id: <DADLSAEF1YPO.V0CQK084KFFO@cknow.org>
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>, "Chanwoo Choi"
 <cw00.choi@samsung.com>, "MyungJoo Ham" <myungjoo.ham@samsung.com>,
 "Kyungmin Park" <kyungmin.park@samsung.com>, "Heiko Stuebner"
 <heiko@sntech.de>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "Sebastian Reichel"
 <sebastian.reichel@collabora.com>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>, <kernel@collabora.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] PM / devfreq: rockchip-dfi: add support for LPDDR5
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com> <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com>
In-Reply-To: <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com>
X-Migadu-Flow: FLOW_OUT

--1972edf4972f0b592376148b0cb4a49b288a246b0dc77c2d96218fcc198e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Nicolas,

On Fri May 30, 2025 at 3:38 PM CEST, Nicolas Frattaroli wrote:
> <snip>
> Downstream has some special case handling for a hardware version where
> not just the control bits differ, but also the register. Since I don't
> know whether that hardware version is in any production silicon, it's
> left unimplemented for now, with an error message urging users to report
> if they have such a system.
> <snip>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 84 ++++++++++++++++++++++++++++--=
------
>  include/soc/rockchip/rk3588_grf.h    |  8 +++-
>  include/soc/rockchip/rockchip_grf.h  |  1 +
>  3 files changed, 73 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 54effb63519653d20b40eed88681330983399a77..5a2c9badcc64c552303c2f55c=
52e5420dec5ffc1 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -34,15 +34,18 @@
> =20
>  /* DDRMON_CTRL */
>  #define DDRMON_CTRL	0x04
> +#define DDRMON_CTRL_LPDDR5		BIT(6)
>  #define DDRMON_CTRL_DDR4		BIT(5)
>  #define DDRMON_CTRL_LPDDR4		BIT(4)
>  #define DDRMON_CTRL_HARDWARE_EN		BIT(3)
>  #define DDRMON_CTRL_LPDDR23		BIT(2)
>  #define DDRMON_CTRL_SOFTWARE_EN		BIT(1)
>  #define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
> -#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_DDR4 | \
> +#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_LPDDR5 | \
> +					 DDRMON_CTRL_DDR4 | \
>  					 DDRMON_CTRL_LPDDR4 | \
>  					 DDRMON_CTRL_LPDDR23)
> +#define DDRMON_CTRL_LP5_BANK_MODE_MASK	GENMASK(8, 7)
> =20
>  #define DDRMON_CH0_WR_NUM		0x20
>  #define DDRMON_CH0_RD_NUM		0x24
> @@ -116,13 +119,60 @@ struct rockchip_dfi {
>  	int buswidth[DMC_MAX_CHANNELS];
>  	int ddrmon_stride;
>  	bool ddrmon_ctrl_single;
> +	u32 lp5_bank_mode;
> +	bool lp5_ckr;	/* true if in 4:1 command-to-data clock ratio mode */
>  	unsigned int count_multiplier;	/* number of data clocks per count */
>  };
> =20
> +static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *c=
trl,
> +					u32 *mask)
> +{
> +	u32 ddrmon_ver;
> +
> +	*mask =3D DDRMON_CTRL_DDR_TYPE_MASK;
> +
> +	switch (dfi->ddr_type) {
> +	case ROCKCHIP_DDRTYPE_LPDDR2:
> +	case ROCKCHIP_DDRTYPE_LPDDR3:
> +		*ctrl =3D DDRMON_CTRL_LPDDR23;
> +		break;
> +	case ROCKCHIP_DDRTYPE_LPDDR4:
> +	case ROCKCHIP_DDRTYPE_LPDDR4X:
> +		*ctrl =3D DDRMON_CTRL_LPDDR4;
> +		break;
> +	case ROCKCHIP_DDRTYPE_LPDDR5:
> +		ddrmon_ver =3D readl_relaxed(dfi->regs);
> +		if (ddrmon_ver < 0x40) {
> +			*ctrl =3D DDRMON_CTRL_LPDDR5 | dfi->lp5_bank_mode;
> +			*mask |=3D DDRMON_CTRL_LP5_BANK_MODE_MASK;
> +			break;
> +		}
> +
> +		/*
> +		 * As it is unknown whether the unpleasant special case
> +		 * behaviour used by the vendor kernel is needed for any
> +		 * shipping hardware, ask users to report if they have
> +		 * some of that hardware.
> +		 */
> +		dev_err(&dfi->edev->dev,
> +			"unsupported DDRMON version 0x%04X, please let linux-rockchip know!\n=
",
> +			ddrmon_ver);
> +		return -EOPNOTSUPP;

I'm guessing you mean the linux-rockchip mailing list here? If so, I
think it's better to make that explicit as 'Joe User' who may run into
this issue may not be aware of that mailing list. The 'linux' and
'rockchip' name combo is used in quite a few places.

Cheers,
  Diederik

> +	default:
> +		dev_err(&dfi->edev->dev, "unsupported memory type 0x%X\n",
> +			dfi->ddr_type);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  {
>  	void __iomem *dfi_regs =3D dfi->regs;
>  	int i, ret =3D 0;
> +	u32 ctrl;
> +	u32 ctrl_mask;
> =20
>  	mutex_lock(&dfi->mutex);
> =20
> @@ -136,8 +186,11 @@ static int rockchip_dfi_enable(struct rockchip_dfi *=
dfi)
> <snip>

--1972edf4972f0b592376148b0cb4a49b288a246b0dc77c2d96218fcc198e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaEACzAAKCRDXblvOeH7b
bkQFAP9OdpwIz44YKR7NNVr+icHxXxEQIuDgPcumEG5WTaLrKwD+MC8hHdbqvimT
4XQkVUDdf7DZ/YqAZuzo8OI31a6LOA0=
=z1X1
-----END PGP SIGNATURE-----

--1972edf4972f0b592376148b0cb4a49b288a246b0dc77c2d96218fcc198e--

