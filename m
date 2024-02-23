Return-Path: <linux-pm+bounces-4336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0D8616C4
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52E71F24FC5
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A9A84FAA;
	Fri, 23 Feb 2024 16:03:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBBC84A50;
	Fri, 23 Feb 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704198; cv=none; b=uQyAaBSPR3Uza52jzlOWlnX6fPVd8mrDUoagyZGhrvTaE4qj6lVsTQGhwuPxTFJ9YgEVAvV7Y/nbsZsj0X9tHejuw1FygNVEPMKzu3ZYFBNE66Bslr1PGFQu/by0RF1dBKZfV1lrNmhl114aIjZoiZEwfO3ZL4sM9VF7IDgngB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704198; c=relaxed/simple;
	bh=2QxYsbtNpv6jtUv2wxx1Te6piZjhjrREIDgL6Jx6xkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iwl48BtNYOpBHcvl5/cuhzZ5CZqsmAnoamRHJi0uRCZ8BbnxEE8OuPrQ1ec3YFHSrtlGPsyOFllfuvo3aPPKj58H8wCEhcSO/Yn/unAsGI1AauJCG6N099qgQeyYHtr/L+N763rrhMOzWU258RW+9XbuTDtm+kThYnXW8YWo8Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51D28DA7;
	Fri, 23 Feb 2024 08:03:42 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DD453F762;
	Fri, 23 Feb 2024 08:03:01 -0800 (PST)
Date: Fri, 23 Feb 2024 16:02:58 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>, Vasily
 Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz
 Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Botka <martin.botka@somainline.org>, Maksim
 Kiselev <bigunclemax@gmail.com>, Bob McChesney <bob@electricworry.net>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 1/7] soc: sunxi: sram: export register 0 for THS on
 H616
Message-ID: <20240223160258.504a1577@donnerap.manchester.arm.com>
In-Reply-To: <dcd115fd-dc38-4f48-8485-9e4d64f53b4a@linaro.org>
References: <20240219153639.179814-1-andre.przywara@arm.com>
	<20240219153639.179814-2-andre.przywara@arm.com>
	<2717467.mvXUDI8C0e@jernej-laptop>
	<dcd115fd-dc38-4f48-8485-9e4d64f53b4a@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 19:44:12 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

Hi Daniel,

> On 22/02/2024 19:26, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 19. februar 2024 ob 16:36:33 CET je Andre Przywara napi=
sal(a): =20
> >> The Allwinner H616 SoC contains a mysterious bit at register offset 0x0
> >> in the SRAM control block. If bit 16 is set (the reset value), the
> >> temperature readings of the THS are way off, leading to reports about
> >> 200C, at normal ambient temperatures. Clearing this bits brings the
> >> reported values down to the expected values.
> >> The BSP code clears this bit in firmware (U-Boot), and has an explicit
> >> comment about this, but offers no real explanation.
> >>
> >> Experiments in U-Boot show that register 0x0 has no effect on the SRAM=
 C
> >> visibility: all tested bit settings still allow full read and write
> >> access by the CPU to the whole of SRAM C. Only bit 24 of the register =
at
> >> offset 0x4 makes all of SRAM C inaccessible by the CPU. So modelling
> >> the THS switch functionality as an SRAM region would not reflect reali=
ty.
> >>
> >> Since we should not rely on firmware settings, allow other code (the T=
HS
> >> driver) to access this register, by exporting it through the already
> >> existing regmap. This mimics what we already do for the LDO control and
> >> the EMAC register.
> >>
> >> To avoid concurrent accesses to the same register at the same time, by
> >> the SRAM switch code and the regmap code, use the same lock to protect
> >> the access. The regmap subsystem allows to use an existing lock, so we
> >> just need to hook in there.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
> >=20
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > I guess this one goes through sunxi tree, right? =20
>=20
> I'll pick this patch along with the patch 2-6, so through the thermal=20
> tree. The patch 7/7 will go indeed via the sunxi tree

many thanks for picking those up! I see them in your bleeding-edge branch,
but are they on route for 6.9, so will you put them in -next soon? Or are
you waiting for more ACKs?

Cheers,
Andre

