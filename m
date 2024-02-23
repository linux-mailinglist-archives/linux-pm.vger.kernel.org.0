Return-Path: <linux-pm+bounces-4340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C281E8619A2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 18:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D3E1F26B90
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7851448FD;
	Fri, 23 Feb 2024 17:26:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B3143C5E;
	Fri, 23 Feb 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709160; cv=none; b=nzP9TFAxSw3Aj4KYvfR4UH0TvffD8Q09hlhq+Gd54IvBhRRxMz1Ik4Xcden88X6DSUQbDg1xS3nmE4g1Y/GptmrTAx6h7ynSTort+t7b9M82BvvSX55epy1Yi+NjfSezQLAuE+jnW97qLO2jERRglZaMGAJoQJSpH6N7V7/0sWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709160; c=relaxed/simple;
	bh=9MKWMsALILdtYY3gW9cjWQ4lbfz+JKHguq9klD5wDEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv8N661BqZH/RtSjZd28FiUpju8ThN3ldoq9EclsgA5V4CsE6wXrUg3nLWwd0j30NMRodVaKmCA1l4aIrOXm49IfR4TVqBsA2c7Zk4PUowQfhOn2z5cNDdFrhODkBihrFFy1MCtflHV+3YXJygVA98r1gxLOYj5vsc8SYBTIDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CE31DA7;
	Fri, 23 Feb 2024 09:26:35 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03D5C3F762;
	Fri, 23 Feb 2024 09:25:53 -0800 (PST)
Date: Fri, 23 Feb 2024 17:25:51 +0000
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
Message-ID: <20240223172551.57b7e066@donnerap.manchester.arm.com>
In-Reply-To: <469e83f3-57ef-492b-8f27-5a052b064106@linaro.org>
References: <20240219153639.179814-1-andre.przywara@arm.com>
	<20240219153639.179814-2-andre.przywara@arm.com>
	<2717467.mvXUDI8C0e@jernej-laptop>
	<dcd115fd-dc38-4f48-8485-9e4d64f53b4a@linaro.org>
	<20240223160258.504a1577@donnerap.manchester.arm.com>
	<469e83f3-57ef-492b-8f27-5a052b064106@linaro.org>
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

On Fri, 23 Feb 2024 18:00:51 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

Hi Daniel,

> On 23/02/2024 17:02, Andre Przywara wrote:
> > On Thu, 22 Feb 2024 19:44:12 +0100
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >=20
> > Hi Daniel,
> >  =20
> >> On 22/02/2024 19:26, Jernej =C5=A0krabec wrote: =20
> >>> Dne ponedeljek, 19. februar 2024 ob 16:36:33 CET je Andre Przywara na=
pisal(a): =20
> >>>> The Allwinner H616 SoC contains a mysterious bit at register offset =
0x0
> >>>> in the SRAM control block. If bit 16 is set (the reset value), the
> >>>> temperature readings of the THS are way off, leading to reports about
> >>>> 200C, at normal ambient temperatures. Clearing this bits brings the
> >>>> reported values down to the expected values.
> >>>> The BSP code clears this bit in firmware (U-Boot), and has an explic=
it
> >>>> comment about this, but offers no real explanation.
> >>>>
> >>>> Experiments in U-Boot show that register 0x0 has no effect on the SR=
AM C
> >>>> visibility: all tested bit settings still allow full read and write
> >>>> access by the CPU to the whole of SRAM C. Only bit 24 of the registe=
r at
> >>>> offset 0x4 makes all of SRAM C inaccessible by the CPU. So modelling
> >>>> the THS switch functionality as an SRAM region would not reflect rea=
lity.
> >>>>
> >>>> Since we should not rely on firmware settings, allow other code (the=
 THS
> >>>> driver) to access this register, by exporting it through the already
> >>>> existing regmap. This mimics what we already do for the LDO control =
and
> >>>> the EMAC register.
> >>>>
> >>>> To avoid concurrent accesses to the same register at the same time, =
by
> >>>> the SRAM switch code and the regmap code, use the same lock to prote=
ct
> >>>> the access. The regmap subsystem allows to use an existing lock, so =
we
> >>>> just need to hook in there.
> >>>>
> >>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com> =20
> >>>
> >>> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >>>
> >>> I guess this one goes through sunxi tree, right? =20
> >>
> >> I'll pick this patch along with the patch 2-6, so through the thermal
> >> tree. The patch 7/7 will go indeed via the sunxi tree =20
> >=20
> > many thanks for picking those up! I see them in your bleeding-edge bran=
ch,
> > but are they on route for 6.9, so will you put them in -next soon? Or a=
re
> > you waiting for more ACKs? =20
>=20
> I've enough ack. The bleeding-edge is merged with the linux-pm tree. If=20
> everything is going well, I will move it to the linux-next branch=20
> probably today or Monday

thanks for the quick reply, that's great to hear. All fine then!

Thanks,
Andre


