Return-Path: <linux-pm+bounces-11367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79993B3A8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 17:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413571F23BCC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF015B554;
	Wed, 24 Jul 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CZVR1Go+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822815B541
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835081; cv=none; b=cQH7T/XFsDHj7WCWP4W4LHIOQM+dLa/LWXHQbmp4CugctUiWR1mZyGrkat1lqtSNhqk107txtm6XBUOhJXWfAl5i7b/fkjQM+dQlG3FiqzBfb4FTV8s0cHbxpd6Q7B032Xde1KYU1FTOPVwF1nw8N0/7OJI2/tb40q3CngdQ/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835081; c=relaxed/simple;
	bh=EFdGYZ3dGchZES4RplWjqITEH/5tlFpzPTXrjwvlx1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QJ36yKDIbiWIFbQIbXSg9oBvc1CNNLhD1/BQFbpqObLfEHv1U62jXDZuXYmnjeZJIkvNieKilqMqvmIT0FW36hmu87ENsVbJDEXN6ObJGI9YQsyAo3WYA/2da53PCc4HPicWelD2pMJQE+L7Ul7+NcS94FLnYhSwoVdvNh81ehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CZVR1Go+; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240724153118euoutp029851170f6a5137e0eaf2049a5c74ce7f~lL_GYjras2104721047euoutp024
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:31:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240724153118euoutp029851170f6a5137e0eaf2049a5c74ce7f~lL_GYjras2104721047euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721835078;
	bh=rXsibAqDB8SLptqUEXYahslc93CwiPePoFUp44hpdd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZVR1Go+XZRvJISM4uUZy6MKNxT3cWmEUi/b9QDxPykeedb0oGamuB18vXpq+d4hk
	 AqEDNx7gYdUSqvWJWvx06TtwcsE4tqBt/Bk1pNGm/4PJcmMx8ZRN0/C+t+9d132Z0i
	 +tOsZQ87Txwru5erNKxUPXYpGqvv0F/zH6ekpWyE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240724153118eucas1p162ee3b0a301e34e9f1d3bce3455dd6c7~lL_GF0ybP3131131311eucas1p1L;
	Wed, 24 Jul 2024 15:31:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id EE.5C.09624.64E11A66; Wed, 24
	Jul 2024 16:31:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240724153117eucas1p1ffac6aa3996c1e8d6a48560082a63a53~lL_Fp9XoV2160721607eucas1p1v;
	Wed, 24 Jul 2024 15:31:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240724153117eusmtrp2e68a4b9556f9e4eb260a217c9bc642fb~lL_FpPJjB0772707727eusmtrp2D;
	Wed, 24 Jul 2024 15:31:17 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-3c-66a11e468b7a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.49.08810.54E11A66; Wed, 24
	Jul 2024 16:31:17 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240724153116eusmtip25e6ebda3783c8190b07b2bf3777245db~lL_E2a4RF2688026880eusmtip2p;
	Wed, 24 Jul 2024 15:31:16 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Rob Herring <robh@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
Date: Wed, 24 Jul 2024 17:31:05 +0200
Message-ID: <20240724153108.914704-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723192439.GA986360-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7pucgvTDKZ9YbF4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GOzeN63j8lBwGPNvDWMHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j
	b8sqRo/Pm+QCOKK4bFJSczLLUov07RK4Mi7dmMZc8Ie54mnrX/YGxpnMXYycHBICJhIfVj9m
	72Lk4hASWMEosWHuR1YI5wujxN3WO1CZz4wSd05/ZoJp2TRnIQtEYjmjxIdHvcwQTiuTxKTV
	D8Cq2AQMJB68WcYOYosIKEr8bpsGNpdZ4ACLxOez+8G2CwsUSFz62ARmswioSmx5uYmxi5GD
	g1fAVmLuFgWIbfISvfv7wGZyCphJtLyewghi8woISpyc+YQFxGYGqmneOhvsCAmByZwSned/
	MUI0u0gsPLQF6lNhiVfHt7BD2DIS/3fOh3onX2LG5vcsIHslBCok7h70gjCtJT6eYQYxmQU0
	Jdbv0ocodpTYe7SXFaKCT+LGW0GIA/gkJm2bzgwR5pXoaBOCqFaVOL5nEtR6aYknLbehVnpI
	TOy4wzaBUXEWkldmIXllFsLeBYzMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQJT2+l/
	xz/tYJz76qPeIUYmDsZDjBIczEoivE9ezU0T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8q
	JJCeWJKanZpakFoEk2Xi4JRqYEoRanAtmMH2S/+d8CJHa6uTNpb5Jz1/bP7z9vtjO6GkL9ee
	3n+aGVX9aMbk3rPzr1RoXi18sDGSUXOx24FPXy817367j2NSxYGSo0+dji+oZ41ktc0UmF8n
	99U7uSZ85y3X2lOiocduyyg4nNmS8yw4vjiubO/fv1NL//st/N77N7NMvYjv6JXXe4wfJ63Z
	UiD7QH1D/j3rrN/pv6Nf5N18u3bFDGHhz/EzzZxPHm32MtXP2ntDNpdNKOzwmo5j9sfsd2rb
	vnK0WN6Yvm+f9aKZu9/fyONUP2T1U1VipW517hSFMvuFXwyk7oZPrvprrzt17tl8HjdL1l+r
	BVn/vHp4OFfy/uSXHA+vbrJKUc9SYinOSDTUYi4qTgQAV3hWKNwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7qucgvTDHp+aVg8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaLiccmM1vM
	/TKV2eL/nh3sFk8e9rFZPO/bx+Qg4LFm3hpGj52z7rJ7LN7zkslj06pONo871/aweWxeUu/R
	t2UVo8fnTXIBHFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
	qUX6dgl6GZduTGMu+MNc8bT1L3sD40zmLkZODgkBE4lNcxaydDFycQgJLGWUaJmwmAkiIS1x
	+MsUdghbWOLPtS42iKJmJomprxpZQBJsAgYSD94sAysSEVCU+N02jRWkiFngHIvEyzWdjCAJ
	YYE8iRU998AaWARUJba83AQU5+DgFbCVmLtFAWKBvETv/j6wxZwCZhItr6eAtQoJ8Ei82rAf
	zOYVEJQ4OfMJ2BhmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGhXnFibnFpXrpecn7u
	JkZgJG479nPzDsZ5rz7qHWJk4mA8xCjBwawkwvvk1dw0Id6UxMqq1KL8+KLSnNTiQ4ymQGdP
	ZJYSTc4HpoK8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamdbw5
	UlUvVc73rlwSnPvvCtuxY0yL9P39n6asu3NC5tRsA53nv8UlZ/7xXvz6zpL+afPvzAkXbcgS
	mcq/7tuWz/HnVuyoy916rqE0e91t/tMhmVHxE4I0bt3pfeDFXSzHrS4x8/Olcze2zj+qmpE/
	S6ZIMlY3MLYgrNJUIuxZ3uSw5ivfObZ/rwzc4O5S8zjWoDHsWd/cnWyPZ/O6J1/N6s10vVz+
	0P3ug7frVFeqzS2bonc2p5lTJbDoUnmR4MN3v6+f37l127GjfakHAuZa7g8L2BkZ8iZIMbRF
	mpfFp+VA886m9VM2CR39FDDXzmJj2ozkkksxKew82cpKm+fFee5Y/L/0pRaf6M4tN1dNUGIp
	zkg01GIuKk4EAF5APhBNAwAA
X-CMS-MailID: 20240724153117eucas1p1ffac6aa3996c1e8d6a48560082a63a53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240724153117eucas1p1ffac6aa3996c1e8d6a48560082a63a53
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240724153117eucas1p1ffac6aa3996c1e8d6a48560082a63a53
References: <CGME20240724153117eucas1p1ffac6aa3996c1e8d6a48560082a63a53@eucas1p1.samsung.com>

> If the old text had nothing to do with the h/w, then I suppose so. I 
> would have assumed the h/w supports some number of thresholds causing 
> some action whether an interrupt or some sort of shutdown.

That is true, but after the mentioned change only 3 are used at the
time: one lower than current temperature, one higher than current
temperature, and one for the critical temperature. So, from the
perspective of somebody writing the devicetree source file this limit is
probably irrelevant?

