Return-Path: <linux-pm+bounces-3928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3928558C4
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 02:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421C41C214E4
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6C1378;
	Thu, 15 Feb 2024 01:30:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D41362;
	Thu, 15 Feb 2024 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960607; cv=none; b=O9Go4FrXXeDe4RsJVv5MZjXnSTA0e5ry+w16NoprBHUeVcwS/SpN3Z3OwC+0g/Bfx8D+dzSgedktHDsupWghzVKvgWKx1E7WbvK6upFDIs54GXl2Zp9BWrHvRbwDbRSkl9h8f0cPsFS//fStQxWr0rPYkpUmpYjlldLhqpcTWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960607; c=relaxed/simple;
	bh=j4y+oYzFDpLtjS+IP4m5Jl8dpeyTDhYGTff+PyAWbfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCvC5QqJhut6+WLmga2eVHr2Zi6QMAL8nOkgYSLgFAT+alXUH8MwYTnYssPD4uM87YjVwsMi1vuvZw4g6W3qN9rPi37+9kTI3EPNQm+V+I5TWAfV8FiPd7Zx286yZjz++PDMMzNVNytFzRi4ZLv9/SB3D0Y4GX3JsC4V3+fCXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 394141FB;
	Wed, 14 Feb 2024 17:30:45 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12C383F762;
	Wed, 14 Feb 2024 17:30:01 -0800 (PST)
Date: Thu, 15 Feb 2024 01:28:47 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland
 <samuel@sholland.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Botka <martin.botka@somainline.org>, Maksim
 Kiselev <bigunclemax@gmail.com>, Bob McChesney <bob@electricworry.net>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 1/7] soc: sunxi: sram: export register 0 for THS on
 H616
Message-ID: <20240215012847.7d0eeda9@minigeek.lan>
In-Reply-To: <2172811.irdbgypaU6@jernej-laptop>
References: <20240209144221.3602382-1-andre.przywara@arm.com>
	<20240209144221.3602382-2-andre.przywara@arm.com>
	<2172811.irdbgypaU6@jernej-laptop>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 21:29:30 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

thanks for having a look and the tags on the other patches!

> Dne petek, 09. februar 2024 ob 15:42:15 CET je Andre Przywara napisal(a):
> > The Allwinner H616 SoC contains a mysterious bit at register offset 0x0
> > in the SRAM control block. If bit 16 is set (the reset value), the
> > temperature readings of the THS are way off, leading to reports about
> > 200C, at normal ambient temperatures. Clearing this bits brings the
> > reported values down to reasonable ranges.
> > The BSP code clears this bit in firmware (U-Boot), and has an explicit
> > comment about this, but offers no real explanation.
> >=20
> > Since we should not rely on firmware settings, allow other code (the THS
> > driver) to access this register, by exporting it through the already
> > existing regmap. This mimics what we already do for the LDO control and
> > the EMAC register. =20
>=20
> Are you sure that this bit doesn't control actual SRAM region?

Pretty much so, yes: I did some experiments from U-Boot:
I filled SRAM C with some pattern, then read this back. Then flipped bit
16, read again: same result. Then wrote something again and read it
back: no change. In fact no bits at 0x3000000 had any effect on SRAM
accessibility, only clearing bit 24 in 0x3000004 made the whole SRAM C
(0x28000-0x47fff) go read-as-zero/write-ignore, from the CPU side.

I then triggered the THS device, to do temperature readings, but
this didn't change a single byte in the SRAM regions, with or without
bit 16 set. It only changed the returned values, at 0x50704c0.

So yes, I am pretty certain there is no SRAM region that gets switched.
Even if we would want to claim there is: I wouldn't know which
address values to put into the SRAM DT node.

So I guess it's another example of: oh, we have this spare bit here. Or
it's some kind of chicken bit? I don't know, and I think the BSP code
we have seen didn't offer an explanation as well.

Cheers,
Andre
>=20
> Best regards,
> Jernej
>=20
> >=20
> > Since this bit is in the very same register as the actual SRAM switch,
> > we need to change the regmap lock to the SRAM lock. Fortunately regmap
> > has provisions for that, so we just need to hook in there.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/soc/sunxi/sunxi_sram.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >=20
> > diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_s=
ram.c
> > index 4458b2e0562b0..71cdd1b257eeb 100644
> > --- a/drivers/soc/sunxi/sunxi_sram.c
> > +++ b/drivers/soc/sunxi/sunxi_sram.c
> > @@ -287,6 +287,7 @@ EXPORT_SYMBOL(sunxi_sram_release);
> >  struct sunxi_sramc_variant {
> >  	int num_emac_clocks;
> >  	bool has_ldo_ctrl;
> > +	bool has_ths_offset;
> >  };
> > =20
> >  static const struct sunxi_sramc_variant sun4i_a10_sramc_variant =3D {
> > @@ -308,8 +309,10 @@ static const struct sunxi_sramc_variant sun50i_a64=
_sramc_variant =3D {
> > =20
> >  static const struct sunxi_sramc_variant sun50i_h616_sramc_variant =3D {
> >  	.num_emac_clocks =3D 2,
> > +	.has_ths_offset =3D true,
> >  };
> > =20
> > +#define SUNXI_SRAM_THS_OFFSET_REG	0x0
> >  #define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
> >  #define SUNXI_SYS_LDO_CTRL_REG		0x150
> > =20
> > @@ -318,6 +321,8 @@ static bool sunxi_sram_regmap_accessible_reg(struct=
 device *dev,
> >  {
> >  	const struct sunxi_sramc_variant *variant =3D dev_get_drvdata(dev);
> > =20
> > +	if (reg =3D=3D SUNXI_SRAM_THS_OFFSET_REG && variant->has_ths_offset)
> > +		return true;
> >  	if (reg >=3D SUNXI_SRAM_EMAC_CLOCK_REG &&
> >  	    reg <  SUNXI_SRAM_EMAC_CLOCK_REG + variant->num_emac_clocks * 4)
> >  		return true;
> > @@ -327,6 +332,21 @@ static bool sunxi_sram_regmap_accessible_reg(struc=
t device *dev,
> >  	return false;
> >  }
> > =20
> > +
> > +static void sunxi_sram_lock(void *_lock)
> > +{
> > +	spinlock_t *lock =3D _lock;
> > +
> > +	spin_lock(lock);
> > +}
> > +
> > +static void sunxi_sram_unlock(void *_lock)
> > +{
> > +	spinlock_t *lock =3D _lock;
> > +
> > +	spin_unlock(lock);
> > +}
> > +
> >  static struct regmap_config sunxi_sram_regmap_config =3D {
> >  	.reg_bits       =3D 32,
> >  	.val_bits       =3D 32,
> > @@ -336,6 +356,9 @@ static struct regmap_config sunxi_sram_regmap_confi=
g =3D {
> >  	/* other devices have no business accessing other registers */
> >  	.readable_reg	=3D sunxi_sram_regmap_accessible_reg,
> >  	.writeable_reg	=3D sunxi_sram_regmap_accessible_reg,
> > +	.lock		=3D sunxi_sram_lock,
> > +	.unlock		=3D sunxi_sram_unlock,
> > +	.lock_arg	=3D &sram_lock,
> >  };
> > =20
> >  static int __init sunxi_sram_probe(struct platform_device *pdev)
> >  =20
>=20
>=20
>=20
>=20
>=20


