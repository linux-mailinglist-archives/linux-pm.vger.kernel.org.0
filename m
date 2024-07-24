Return-Path: <linux-pm+bounces-11366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D393B3A1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D09283F76
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F915B97C;
	Wed, 24 Jul 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PKRu3A4z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BE1591F3
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835069; cv=none; b=drJOv50LziPCQauPYRtZ+VjeGJ+wEfbtSxl20f7axqF6DddK07mUSjAUHWWeShcCC4wbSiWR3qb5yB/4sPBO6/VZQfuE5TEBjcdBptBjJPRshrmzQRDAQwx8Tey0QtNX2F7LWBKzrO0rOPDketAaVUUFAORg5he1WHQ6/p7phq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835069; c=relaxed/simple;
	bh=4RfJssJQ9HjIHcDyK1JUzGFVvG/AiMxUtgoLwWZobnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bUatjsaMX2+hU565fwb295Ud8ocw4xJy5jjOH4bRELOg0PJSQ7n7RFvfCLgOI9ZKxlWCBYMkumQBgP6T4P8fs8RiYPlpfA7c3sTHRbrG+FTm/PTu1hcEyZKvMuDG7HQOrH5wPzlUdfNBnx6J1pqb7Hnk4kYjDBYxaOGUh9MYUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PKRu3A4z; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240724153106euoutp027118b87777a38f626932b39fd94f70dc~lL97YoKlW2378223782euoutp02b
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:31:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240724153106euoutp027118b87777a38f626932b39fd94f70dc~lL97YoKlW2378223782euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721835066;
	bh=ZYBphSSEMUkgpKaud4bfuBHU1vOAyn6VcDZ81FkewqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKRu3A4zsTNc1u5IjDLPVb9fS39MrnCFr6TqAPiwLMfLUz2LlqOFGRiXQTFK+F/qj
	 CW6xod0jP1PlY2JVThwaGJeQZPPC/+CbUuxvwmOh6nKGN6HUNQCMioajC6L065thch
	 t/AufmNg/CkO7obrXGQpOTUj6KEAU/TKDX+SPH9k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240724153106eucas1p26e46976701452b257b2f1f55bd46071c~lL97BR8hA0139601396eucas1p2Z;
	Wed, 24 Jul 2024 15:31:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B2.1D.09875.A3E11A66; Wed, 24
	Jul 2024 16:31:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240724153105eucas1p2f46f2128ba9ce4dc42a5d952cd816c38~lL96liXV_2351323513eucas1p2D;
	Wed, 24 Jul 2024 15:31:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240724153105eusmtrp285e1bc842599c3f3ba876d917964a892~lL96kicqB0772707727eusmtrp2r;
	Wed, 24 Jul 2024 15:31:05 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-2c-66a11e3a49f3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.39.08810.93E11A66; Wed, 24
	Jul 2024 16:31:05 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240724153104eusmtip18a6ad08554142b896ee2553cb69ab47c~lL95vFUtp3047830478eusmtip1M;
	Wed, 24 Jul 2024 15:31:04 +0000 (GMT)
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
Date: Wed, 24 Jul 2024 17:30:56 +0200
Message-ID: <20240724153058.914693-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <CAPLW+4n6XB3fm8KQA=6_2z8ay9pDPtu-VFgAaW5imZkRH2ywkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7pWcgvTDK72cVk8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaLiccmM1vM
	/TKV2eL/nh3sFk8e9rFZPO/bx+Qg4LFm3hpGj52z7rJ7LN7zkslj06pONo871/aweWxeUu/R
	t2UVo8fnTXIBHFFcNimpOZllqUX6dglcGWsW7WUteCBU8fjjO7YGxjaBLkZODgkBE4mm81NY
	uhi5OIQEVjBKPP7TwgbhfGGUeDFvI1TmM6PEpQfzmWBaVtzdDFW1nFHixuv3UE4rk8Td7j5m
	kCo2AQOJB2+WsYPYIgJ6EutmvmIHKWIW2MwiceHpTFaQhLBAoMT5NU0sIDaLgKrE/955jCA2
	r4CtxJUVh9gh1slL9O7vA1vNCVR/70kXG0SNoMTJmU/AepmBapq3zmaGqO/nlJg5KQnCdpE4
	cukmVFxY4tXxLVAzZST+74R5J19ixub3QHM4gOwKibsHvSBMa4mPZ5hBTGYBTYn1u/Qhih0l
	bvd8YISo4JO48VYQYj+fxKRt05khwrwSHW1CENWqEsf3TIJaLy3xpOU2E0SJh8SiZo0JjIqz
	kDwyC8kjsxDWLmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY2E7/O/5lB+PyVx/1
	DjEycTAeYpTgYFYS4X3yam6aEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTU
	gtQimCwTB6dUA5P1bH8lc4UDP9n9kjt+BfNMO61VqbQ/es2DuH1zk5SCvGc4bZr8WEhP93RS
	kKJc1drSzdx5pdYNMr2lpQqWB5o0XDecOPQmb6/3cYH+BR8fsOt8TWCtSFx3Zt+/iJZniybw
	n5GcbfyoU8FqzbZqdVNe88Lu3TWbpZyuqu19vvRz9Iz7bUtmu82vXNJeUFi1d9a1poY9DGai
	oivUCq4Guf7//iQ34fOPiYtvPfuifWkx576XHa/svtUdLwt/0dI2TVDhQ+HSRU94Ox5c5RVf
	xXNUeH6+mZfp9lUVGyJSHgdzZz+/rZDeYLKvy26/pPQko9XHVc+kvNd/6aHbEC5iaLdCzubH
	zDM9VrF97UKxYUosxRmJhlrMRcWJAELQjOzbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7qWcgvTDBqm61s8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaLiccmM1vM
	/TKV2eL/nh3sFk8e9rFZPO/bx+Qg4LFm3hpGj52z7rJ7LN7zkslj06pONo871/aweWxeUu/R
	t2UVo8fnTXIBHFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
	qUX6dgl6GWsW7WUteCBU8fjjO7YGxjaBLkZODgkBE4kVdzezdTFycQgJLGWUuPHuBDtEQlri
	8JcpULawxJ9rXVBFzUwSfzdfZQRJsAkYSDx4swysSERAT2LdzFfsIEXMAgdZJPpeX2EGSQgL
	+Et8v9DOAmKzCKhK/O+dB9bMK2ArcWXFIagN8hK9+/uYQGxOgUCJe09AtnECbeOReLVhP1S9
	oMTJmU/A5jAD1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJj
	cduxn5t3MM579VHvECMTB+MhRgkOZiUR3iev5qYJ8aYkVlalFuXHF5XmpBYfYjQFunsis5Ro
	cj4wGeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBtvO00z8CP
	z0WFcxbH5YCi4jPHPIJs6xVsww2ehyaJLNn4dc1kyQ+v3/7Z1PN72bIJLHkchcu9Lyju/LJM
	QGNesKguV+h0zdn8xkuWvbxhsXJX/5tc7a2v14U/O84jsGHe0XeqOfeWnfu3Lb/VcMIOrc9X
	kramesUdidop3LmHcWZQiEfd+inb9BdM79OYcOGZxddXipv3y+mu1xCzLE/5zyPotYRlwf4W
	u0d/LFZV18VZej6dafKvVWTdy7Ts7J8ngzP5mKrSY/fwfeU5Or1r1Rs+1XOK7fN9nLinSa27
	zJK442TpU+MJhkv/brCpf/qqNPJ1U0TUmwQ1tXKmTI/l4luOHbKbeJBzV7XB5YMflFiKMxIN
	tZiLihMBOcxdrU4DAAA=
X-CMS-MailID: 20240724153105eucas1p2f46f2128ba9ce4dc42a5d952cd816c38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240724153105eucas1p2f46f2128ba9ce4dc42a5d952cd816c38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240724153105eucas1p2f46f2128ba9ce4dc42a5d952cd816c38
References: <CGME20240724153105eucas1p2f46f2128ba9ce4dc42a5d952cd816c38@eucas1p2.samsung.com>

> I'd suggest to group all the definitions here as such:
> 
> #define REG1_OFFSET
> #define REG1_FIELD1_OFFSET
> #define REG1_FIELD2_OFFSET
> ...empty line...
> #define REG2_OFFSET
> #define REG2_FIELD1_OFFSET
> #define REG2_FIELD2_OFFSET
> ...etc...
> 
> Or otherwise each shift/mask constant should contain its register name
> as a prefix, to avoid confusion. But right now it's kinda hard to
> understand what belongs to what :) But that's just a nitpick.

I came up with this:

/* Exynos850 specific registers */
#define EXYNOS850_TMU_REG_CURRENT_TEMP0_1	0x40
#define EXYNOS850_TMU_REG_THD_TEMP0_RISE	0x50
#define EXYNOS850_TMU_REG_THD_TEMP0_FALL	0x60
#define EXYNOS850_TMU_TEMP_SHIFT		9

#define EXYNOS850_TMU_TRIMINFO_SHIFT		4
#define EXYNOS850_TMU_TRIMINFO_OFFSET(n) \
	(EXYNOS_TMU_REG_TRIMINFO + (n) * EXYNOS850_TMU_TRIMINFO_SHIFT)
#define EXYNOS850_TMU_T_TRIM0_SHIFT		18

#define EXYNOS850_TMU_REG_CONTROL1		0x24
#define EXYNOS850_TMU_LPI_MODE_MASK		1
#define EXYNOS850_TMU_LPI_MODE_SHIFT		10

#define EXYNOS850_TMU_REG_COUNTER_VALUE0	0x30
#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK	0xffff
#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT	0

#define EXYNOS850_TMU_REG_COUNTER_VALUE1	0x34
#define EXYNOS850_TMU_CLK_SENSE_ON_MASK		0xffff
#define EXYNOS850_TMU_CLK_SENSE_ON_SHIFT	16

#define EXYNOS850_TMU_REG_AVG_CON		0x38
#define EXYNOS850_TMU_AVG_MODE_MASK		0x7
#define EXYNOS850_TMU_DEM_ENABLE		BIT(4)

#define EXYNOS850_TMU_REG_TRIM0			0x3c
#define EXYNOS850_TMU_TRIM0_MASK		0xf
#define EXYNOS850_TMU_VBEI_TRIM_SHIFT		8
#define EXYNOS850_TMU_VREF_TRIM_SHIFT		12
#define EXYNOS850_TMU_BGRI_TRIM_SHIFT		20

#define EXYNOS850_TMU_TEM1051X_SENSE_VALUE	0x028a
#define EXYNOS850_TMU_TEM1456X_SENSE_VALUE	0x0a28

This also omits some definitions that were in v1, as they had the same
value and they were the same thing anyway. For instance, I dropped
EXYNOS850_TMU_T_BUF_VREF_SEL_MASK in favor of
EXYNOS_TMU_REF_VOLTAGE_MASK, and have a single EXYNOS850_TMU_TRIM0_MASK
instead of EXYNOS850_TMU_BGRI_TRIM_MASK, EXYNOS850_TMU_VREF_TRIM_MASK,
EXYNOS850_TMU_VBEI_TRIM_MASK and EXYNOS850_TMU_T_TRIM0_MASK. Also,

> Suggest using GENMASK() macro whenever possible.

This would make me have a separate mask for each of these again. Maybe
if this driver gets refactored in the future to use u32_get_bits() and
so on this would make more sense?

