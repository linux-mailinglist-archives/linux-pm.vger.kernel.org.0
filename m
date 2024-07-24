Return-Path: <linux-pm+bounces-11365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBC93B39E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383BE1F22123
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA215B14E;
	Wed, 24 Jul 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kOxdbZ63"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BA159217
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835067; cv=none; b=YxWHSXCu0eJkZGBHdj9k8NDHJdysKF9SkcIu0H+qYWONJRqRoXz3IPFYKWGvT/cqM+8gHOqCTfF/kIbqmijGNyhFPhemVKZ0BkC32fuzm6COP50bC4jteiMv4Xui3MAm5X+cBZY8T43wEDn920UYzM28VUfP7yMVZooy5OxekH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835067; c=relaxed/simple;
	bh=r2MN2bBc3Kfp18tWdCR53taAy1x7zD5Ls8IFUyz/n+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bS8QYvIozASkihvmH8c5vp/PwiixukKNfRBUvCHo/fpAd+STLyWY8ja9mMh/b0hQgNGd0S3A545QbByAl4GVykibs2ymoNoYTXa14KwGjjFncyxbMjQH/22QEiabq28uphSq1HA8Aj/mJEX1lglvsQz/+vudX7l3GhfK7PCI0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kOxdbZ63; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240724153057euoutp02efe89349ec3241635cb60f7d980d21e5~lL9y8ia-F2378423784euoutp02K
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:30:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240724153057euoutp02efe89349ec3241635cb60f7d980d21e5~lL9y8ia-F2378423784euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721835057;
	bh=dzddrlA5sh87ryozwXveIOfmk/31qNlAPzRYhrbGzG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOxdbZ63dVTUhtGz6ZfWdFHm7GCH8FxHVpx/rkhpA9+PrKU+q39HYwAY93Fyf9e/k
	 uF5zcLAo4qrPo+zD+AqPZYHHIDXQG9iQK9W4zYyilYo9LqeSuyP+j4yBJDYJk0iTYp
	 VkmJ/2NXAoqmhWHOVS3QEl5UaZzTLk3Ej8PNPWSk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240724153057eucas1p1647824aff7aaf1285d72e32be9fc00b2~lL9yaWgsS3047230472eucas1p1I;
	Wed, 24 Jul 2024 15:30:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D0.5C.09624.03E11A66; Wed, 24
	Jul 2024 16:30:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240724153056eucas1p193056deacd26701e60519fa0466269f5~lL9x61iOs3053930539eucas1p1J;
	Wed, 24 Jul 2024 15:30:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240724153056eusmtrp20b8cf6f68438112bde9364ba673226b7~lL9x6AhQC0772707727eusmtrp2S;
	Wed, 24 Jul 2024 15:30:56 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-f8-66a11e30ac00
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.39.08810.03E11A66; Wed, 24
	Jul 2024 16:30:56 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240724153055eusmtip192f5253364ae6bfc12bf594e3dfd9db6~lL9xFJInI3047830478eusmtip1H;
	Wed, 24 Jul 2024 15:30:55 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 5/6] drivers/thermal/exynos: add initial Exynos 850
 support
Date: Wed, 24 Jul 2024 17:30:36 +0200
Message-ID: <20240724153037.914681-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <CAPLW+4katjgDUS+e4+iYt+Cz_pKizLFUxqV4KGnbQ5ekAq9Mvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87oGcgvTDN7ft7B4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GOzeN63j8lBwGPNvDWMHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j
	b8sqRo/Pm+QCOKK4bFJSczLLUov07RK4Mr42dbEVrOKreNZ/hq2BcSp3FyMHh4SAicSSy+ld
	jFwcQgIrGCWmr2tg62LkBHK+MErcmZ0GkfjMKPFnx3FWkARIw925R9kgEssZJf49mM8E4bQy
	SezcPpEdpIpNwEDiwZtlYLaIgJ7Eupmv2EGKmAU2s0hceDoTbJSwQKDE+TVNLCA2i4CqxPG3
	38F28wrYSmza+5IFYp28RO/+PiYQmxOo/vvs5ywQNYISJ2c+AbOZgWqat85mhqifzCnR89Ie
	wnaRWN55nxHCFpZ4dXwLO4QtI/F/53wmCDtfYsbm9yyQsKiQuHvQC8K0lvh4hhnEZBbQlFi/
	Sx+i2FFi17IGJogKPokbbwUh9vNJTNo2nRkizCvR0SYEUQ300p5JUGdJSzxpuQ210kOiY9Jm
	lgmMirOQfDILySezEPYuYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZjWTv87/mkH
	49xXH/UOMTJxMB5ilOBgVhLhffJqbpoQb0piZVVqUX58UWlOavEhRmkOFiVxXtUU+VQhgfTE
	ktTs1NSC1CKYLBMHp1QD02Lx0PLr3s+F/yRE7WzbP+ffhNKDPKXKYmwcXYwV/HtSbvQyev2e
	Edm/ICFYvevQx4/sf0wPvVky/efqnoL72a6T3i+7yOOw4sVN9WmX9US69cNKtkxz/92i8qhb
	TfejgIL5nPQejp9W9k49uw7ddXz/eNKkFVMW5qqoKUa/qooqC7hd5dC3z1Lmsc9OFytL/p+i
	jQX/nGc6N0z8VMjV6FfDL6n4bdEXa0PlRRc3xS7SKV/F6tuy8+6Keztnav4Q0/6bLRC/ZsWt
	CJV3i2ZUxa08ftxZd730X8+gD+cDNfge823c1WDA6Pg9hO/L5y6Hj+evqPRo+c1LMVTiOPV1
	iwrfrtfcMvcvWqeW8QnuVGIpzkg01GIuKk4EAG59KWXaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7oGcgvTDOY/lLZ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GOzeN63j8lBwGPNvDWMHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j
	b8sqRo/Pm+QCOKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
	Uov07RL0Mr42dbEVrOKreNZ/hq2BcSp3FyMnh4SAicTduUfZuhi5OIQEljJKzFl9kBEiIS1x
	+MsUdghbWOLPtS6oomYmiXU/LrCBJNgEDCQevFkGViQioCexbuYrdpAiZoGDLBJ9r68wgySE
	Bfwlvl9oZwGxWQRUJY6//Q7WzCtgK7Fp70sWiA3yEr37+5hAbE6BQInvs5+DxYUEeCRebdjP
	CFEvKHFy5hOwODNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3uDQvXS85P3cT
	IzAWtx37uXkH47xXH/UOMTJxMB5ilOBgVhLhffJqbpoQb0piZVVqUX58UWlOavEhRlOguycy
	S4km5wOTQV5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1Mpg3X0
	Fq+MD9Fxcz2tLkzljXq/KsxddaNo/prevfxLanLNxQyt4g8tTDYI2pOp3et+al/zf89HVmdM
	P1yLZdIXSheUPr27+/nSQ2K5Ie+LVzFPqN354PadhZ9uxi9beOvrvFlVwhXXL2bcnG9zITqn
	nGv7L5YbOTVz8lRunXdsrlvV67+vYLGDikjhHr3Abc8ilk7Revdlfnhpqsbj0C8PfDclz5qh
	Iz+1Y/McYx5+jSerNWeqtZt86eGPD1Obe+HBqnKVorMNZ70Xf9PX21BcVel7sNMiv7e/Mrvk
	jf1zQfZ/WtMmh6//fZ5J5PFPl4Jdje+Wd9TeZC5yuRTG/a+7ZNfjg6ETrVSKdHdPPqLEUpyR
	aKjFXFScCADGboBITgMAAA==
X-CMS-MailID: 20240724153056eucas1p193056deacd26701e60519fa0466269f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240724153056eucas1p193056deacd26701e60519fa0466269f5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240724153056eucas1p193056deacd26701e60519fa0466269f5
References: <CGME20240724153056eucas1p193056deacd26701e60519fa0466269f5@eucas1p1.samsung.com>

> It feels like there is an error for Exynos7 case there. Take a look at
> this commit:
> 
>     aef27b658b43 ("thermal: exynos: use sanitize_temp_error() in
> exynos7_tmu_initialize()")
> 
> I think that commit just forgets to update the shift value for Exynos7
> properly. This code:
> 
>     data->temp_error1 = trim_info & tmu_temp_mask;
>     data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
>                 EXYNOS_TMU_TEMP_MASK);
> 
> in case of Exynos7 becomes:
> 
>     data->temp_error1 = trim_info & 0x1ff;    // mask = 9 bits
>     data->temp_error2 = (trim_info >> 8) & 0xff;
> 
> it contradicts itself, because it takes 9 rightmost bits for error1,
> and then uses 1 of those bits for error2 too. It's obvious that if 9
> bits are already used for error1, then for error2 it has to be shifted
> by 9 bits, not 8.
> 
> That's why I think your patch 2/6 is legit and useful on its own, and
> it's actually a good catch on your part! But the shift value has to be
> fixed as well (for Exynos7). It's not ideal you don't have the
> hardware to test it, but it just screams *bug* to me :) Also, maybe we
> can ask someone who has Exynos7 hardware to test it for us?

I thought about it for a bit and finally realized that Exynos7 only
supports one point trimming. That is why in that commit, the original
exynos7_tmu_initialize did not do anything with temp_error2. So
temp_error2 will never be used in Exynos7. The real "fix" I guess is to
only calculate temp_error2 if two point trimming is used, which is
possible with a very small reordering of exynos7_tmu_initialize. But
then the shift value will never be reachable in Exynos7 anyway. What do
you think about this? I feel like it's worth it to change the shift
value just because the code is a bit confusing anyway.

