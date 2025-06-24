Return-Path: <linux-pm+bounces-29420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8844EAE5E8F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 09:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927EA4028B1
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156CD253355;
	Tue, 24 Jun 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mT9p1Sp2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAB2512C8
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750751932; cv=none; b=jLThpGv2J64xk2lRllIXlANAwVe5UrqNfN0aFTYpar73zl+R8zMoK81UGbxEkYSP7kDsuqr+14g+UvEYxjMniWZ0kzx6g46Iw1XkwBG+ZoF+zqngKiDcL8VfpHifUis8vxNI7K147KC8ZtHCQm5haTQUtS1rErvgbg/ZA32iXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750751932; c=relaxed/simple;
	bh=ENvY8RUTg0ngZcZnFi91Ox53Hs6bpGD+Qm851FktIMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=S6MWHRZL2bwY4qQbAhlBpJvAXEkPPER75N+ZOH5SSJIHwqIc8aV2ZPLgI0H/V+W1ilktVG4S3kg0DRuboA5ceSLLxKLmZZoik5hmqeUS9VRtiDkSTBtMkr4GwgjfFr3JVdcZlxYtMuttt5u3lcDZlcg0v40M+ZAZP5Kp9H0Dhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mT9p1Sp2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250624075848euoutp022677475f969dc87d0009b607ab4a071b~L65pLCYd01238612386euoutp02D
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 07:58:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250624075848euoutp022677475f969dc87d0009b607ab4a071b~L65pLCYd01238612386euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750751928;
	bh=y4ezkbR7PDS9TMoPTn+QPbo+C1HfywmnDzGxcCIVA1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mT9p1Sp26cUx6K5nplYYZmYGB4FMcPPl9u6+VCsHOSD196slnMS++HLW6/APXECS3
	 uYWjwxM+pSAZkzvdE+gn5/wjh3B1gjez6DbbvwQiR8GcVCH+48ohaVop6myXW8PyAE
	 IJr7kKiHthRX2OzQXtw8HPZjQ+MTE76ft5VvWIvI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250624075847eucas1p2db6e908f78aa603bdf6aec38b653e9af~L65oyHT-r0882308823eucas1p2N;
	Tue, 24 Jun 2025 07:58:47 +0000 (GMT)
Received: from AMDC4515.digital.local (unknown [106.120.51.28]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250624075846eusmtip15b3b3e53371028a9ef3fb5ed7461df69~L65n2jQHD0986509865eusmtip1Y;
	Tue, 24 Jun 2025 07:58:46 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux.amoon@gmail.com
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, lukasz.luba@arm.com,
	m.majewski2@samsung.com, rafael@kernel.org, rui.zhang@intel.com
Subject: Re: [RRC v1 2/3] thermal/drivers/exynos: Handle temperature
 threshold interrupts and clear corresponding IRQs
Date: Tue, 24 Jun 2025 09:58:15 +0200
Message-ID: <20250624075815.132207-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CANAwSgQ=G1yJXOg1LdeEf-J56epyNiohCSdNYUvs2AHNv90Hkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250624075847eucas1p2db6e908f78aa603bdf6aec38b653e9af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250624075847eucas1p2db6e908f78aa603bdf6aec38b653e9af
X-EPHeader: CA
X-CMS-RootMailID: 20250624075847eucas1p2db6e908f78aa603bdf6aec38b653e9af
References: <CANAwSgQ=G1yJXOg1LdeEf-J56epyNiohCSdNYUvs2AHNv90Hkg@mail.gmail.com>
	<CGME20250624075847eucas1p2db6e908f78aa603bdf6aec38b653e9af@eucas1p2.samsung.com>

> I tried to configure this, referring to the comment in the driver
>         /*
>          * Clear the interrupts.  Please note that the documentation for
>          * Exynos3250, Exynos4412, Exynos5250 and Exynos5260 incorrectly
>          * states that INTCLEAR register has a different placing of bits
>          * responsible for FALL IRQs than INTSTAT register.  Exynos5420
>          * and Exynos5440 documentation is correct (Exynos4210 doesn't
>          * support FALL IRQs at all).
>          */
>
> By the way, I don't see Exynos5433 and Exynos7 support
> INTSTAT and INTCLEAR registers. We are using TMU_REG_INTPEND
>  to read and update the same register.
>
>         if (data->soc == SOC_ARCH_EXYNOS5260) {
>                 tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
>                 tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
>         } else if (data->soc == SOC_ARCH_EXYNOS7) {
>                 tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
>                 tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
>         } else if (data->soc == SOC_ARCH_EXYNOS5433) {
>                 tmu_intstat = EXYNOS5433_TMU_REG_INTPEND;
>                 tmu_intclear = EXYNOS5433_TMU_REG_INTPEND;
>         } else {
>                 tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
>                 tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
>         }

My understanding of this comment and the situation in general is like
this:

1. On 5420, whenever there is edge interrupt, no matter if rise or fall,
   a bit gets set to 1 inside INTSTAT, and we clear it by setting the
   same bit to 1 inside INTCLEAR. The current code does not rely on the
   concrete bit index, it will just check the temperature after the
   interrupt.
2. On 4210, there is no falling edge interrupts (so
   exynos4210_tmu_set_low_temp is empty, we enable polling in DT etc).
   This is what the "Exynos4210 doesn't support FALL IRQs at all" means.
   However, rising edge interrupts work exactly the same as on 5420:
   a bit gets set to 1 inside INTSTAT, and we clear it by setting the
   same bit to 1 inside INTCLEAR.
3. On 3250, 4412, 5250, 5260, it again works the same way as 5420.
   However, somebody had a copy of documentation that was incorrect: it
   said that bit indices does not match somehow, which is not true.
4. On 5433 and 7, it one more time works the same way as 5420, with a
   single change: a bit gets set to 1 inside INTPEND, and we clear it
   by setting it to 1 inside the same INTPEND.

So, all we need to do to support existing SoCs is to read the 1 bit from
one register, and set the bit with the same index in another register
(which on some SoCs is the same register). We could interpret the index
to see what kind of interrupt is this, but we read the temperature to
get similar information.

So in the end, is it helpful to interpret the INTSTAT bit index, only to
reset the exact same index inside INTCLEAR? I guess it could be valuable
if we also used the information about which interrupt it is and somehow
used it elsewhere (which could actually help with some issues), but that
is another thing to do.

> If you have details on how INTSTAT and INTCLEAR are used
> particularly regarding the update bits, please share them.
> Specifically, I'm interested in how bits [7:0] correspond to rising edge
> interrupts and bits [23:16] to falling edge interrupts
> I feel it's the same as Exynos54222.

Regarding concrete indices on 5433:
- the 0th bit corresponds to RISE0,
- the 1st bit corresponds to RISE1,
- ...
- the 7th bit corresponds to RISE7,
- the 16th bit corresponds to FALL0,
- the 17th bit corresponds to FALL1,
- ...
- the 23th bit corresponds to FALL7.

That is probably because this SoC supports more interrupts than others.
Though do note that currently, we only use part of them (one RISE, one
FALL if supported, and another RISE for critical temperature (one
supporting hardware thermal tripping if possible)). Also note that the
indices in INTSTAT/INTCLEAR/INTPEND match the ones in INTEN, though I
have not checked thoroughly if that is true for all the SoCs.

Thank you,
Mateusz Majewski

