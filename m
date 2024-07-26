Return-Path: <linux-pm+bounces-11422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286AB93D180
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EFF1C20BA2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE117A5BB;
	Fri, 26 Jul 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rpte5i3M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2A17A589
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991707; cv=none; b=UDPDI3eytQbzx6j4WnAbP1GYFqUZa0Ht3wTho/xCX86qKgybJY4AfQ/r1Zcds9sEE8hauoPVZBNwUQOVIaLH/ZJOB0Ffv+aUfAOUTyrrMib4rFZ2BjVZO1prfVBKO5g7/+OMyT6C8+/aug0Q4A6umWI0Y2I4qXcQmkrW4vVyoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991707; c=relaxed/simple;
	bh=8ahWflBSjlzz2k5Q81pq1wcP8GcQpLkNXO7oc2N5v5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=DSKM4PDvJgDWTGUcAwV7XBCAiOXByMdUoBYxUyoBW25TakwJKda3Xe8PaZCQBH8B6rRkehXPnFpHslNPlvGssBPti4zPoxzszf+d78inEE1bSKRqYiySvNl8dMuPpEHQ//EKKcapfzBHadN8pCZTesPLY+uuie5N5rHmVkWYm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rpte5i3M; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240726110140euoutp029aedf823a1aea7d4f73497cb0d6e7be3~lvlQC_xP10040700407euoutp02r
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240726110140euoutp029aedf823a1aea7d4f73497cb0d6e7be3~lvlQC_xP10040700407euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721991700;
	bh=Ahutt9jotAItCpm9CVKeN2uagxPr0VroM4F/KsXNw5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpte5i3Mc7dWSPGTzLUJGHaOYU5nauv/Kq259Ovt9+z7CuNkJP0OIWBhZ0jetGfN2
	 s2eEXwPHFySg2VC5xGgMJIKsTZaey3btz1DWK2y9I/mdiKWl9lPFIj2Dnt8L6g3lHc
	 mrL8kr+lvQaFRxh4mnyXRVgiKrwcLpmdjmEmD+kQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240726110140eucas1p1d68c4dbebbd2ef1d56db11fe0e00620a~lvlPpM9cv1389013890eucas1p1L;
	Fri, 26 Jul 2024 11:01:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 54.72.09620.31283A66; Fri, 26
	Jul 2024 12:01:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110139eucas1p24eb41978fdad0d37a95c2c829180a203~lvlPOaZv62815028150eucas1p2E;
	Fri, 26 Jul 2024 11:01:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240726110139eusmtrp2cf175f10530fd495bc1e7bfe35071a1c~lvlPNrye91722517225eusmtrp2X;
	Fri, 26 Jul 2024 11:01:39 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-da-66a382138dac
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 16.27.08810.31283A66; Fri, 26
	Jul 2024 12:01:39 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110138eusmtip2175b3f27859094bc16436db673dd3a52~lvlOWtz0K2566125661eusmtip2b;
	Fri, 26 Jul 2024 11:01:38 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 4/6] dt-bindings: thermal: samsung,exynos: add
 exynos850-tmu string
Date: Fri, 26 Jul 2024 13:01:08 +0200
Message-ID: <20240726110114.1509733-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240726110114.1509733-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7oiTYvTDDY9ZrR4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVsW/VLraCUxwVW8+eZG9gvMXWxcjJISFg
	IjFzxgnmLkYuDiGBFYwSx39MZ4FwvjBKTJ1wnQnC+cwocf71TXaYlu2r57GA2EICyxkl/l41
	gShqZZJYPu8ZM0iCTcBA4sGbZewgCRGBxYwSjT/esYI4zAJPmCV+vlrMCFIlLBAh0dtzHGws
	i4CqxNnVF8C6eQXsJO62HmOFWCcv0bu/jwnE5hSwl1gy6SMjRI2gxMmZT8DOYAaqad46G+wL
	CYHZnBKvph9lhGh2kZh1fhYLhC0s8er4FqgfZCT+75zPBGHnS8zY/B6ohgPIrpC4e9ALwrSW
	+HiGGcRkFtCUWL9LH6LYUaLxzm6oYj6JG28FIQ7gk5i0bTozRJhXoqNNCKJaVeL4nknMELa0
	xJOW21ArPSQuLZ3JOoFRcRaSV2YheWUWwt4FjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLz
	czcxAtPc6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK8y+4vTBPiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOq5oinyokkJ5YkpqdmlqQWgSTZeLglGpg4tae4umUetX3xLT0ZNHsmg2r3tl1Vte7KIl0
	brnEV3P+ceqnK39vWi46/Hzpf/VTF6IPiak2t9lM5nPxL+ePzBT54LtiqcYs16T9h1yitvuY
	2/VmsXu5PLSc0vMm7G2G962ii4JM8a/k5ufu/jXL+dbBGfdvc+//z7e+7YtKVomx6oz9nNbb
	1gZM5TuzUfDI4tlaNvNO7ggsLMoSDd0hfvCz5pqM6smiPCdvpdrclbiVy+N5K0m67invi+LA
	5bvX7n8m+f1I5nYvv7zr5ba92znM/j5JZHr/0/JewXVDa9PimMSfV1v/BPxyKL9/64XZ9I57
	T3Z+8nzPv8qj/XUM+3L2jPudT1XX88jKdujPVGIpzkg01GIuKk4EAF9Vh1PiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7rCTYvTDL5vUbV4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXsW/VLraCUxwVW8+eZG9gvMXWxcjJISFgIrF99TyWLkYuDiGBpYwSsze8
	YIZISEsc/jKFHcIWlvhzrYsNoqiZSWL13JusIAk2AQOJB2+WgRWJCCxnlNjc7gFiMwu8Y5Zo
	P+/XxcjBISwQJrFvewRImEVAVeLs6gtg83kF7CTuth5jhZgvL9G7v48JxOYUsJdYMukjI4gt
	BFRzv3c1I0S9oMTJmU9YIMbLSzRvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz
	0vWS83M3MQIjctuxn5t3MM579VHvECMTB+MhRgkOZiUR3mX3F6YJ8aYkVlalFuXHF5XmpBYf
	YjQFunsis5Rocj4wJeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBK
	NTBxrvLI4OC62VpXt3rDzpkBZzZJ1Z/ZxZDstmTy7aqZM56e+3Pr19tXJwyCwzOVRDW+TL4l
	9OFsvO6aLze+xpv2sO3N2PXM0iCDq8r1yO0tmjnBuz3Y1cUctp/e4Xfvld5KBtndv7oOBnjl
	sW7/Uig69byZp021r0Kv+NNjEolHFKN2W9Sem/ggIdgwKmBh/ZY3nK/3vOZOU9326ONOyznG
	KV77lyxbvnhzuU9Xg8T/Uu21tkoci+6LmhXf/yXR1Nx+ILV14r/zF9Pt1u+61VgmsjTlVkhh
	k/ed4PQ1wVX6cRGpYhyyXJ9Z2F9kuuXqLfueKLhNI019z5JtV65uCZc8ZBuZUaij1dl5MU/+
	xXElluKMREMt5qLiRAAqiSS+UQMAAA==
X-CMS-MailID: 20240726110139eucas1p24eb41978fdad0d37a95c2c829180a203
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240726110139eucas1p24eb41978fdad0d37a95c2c829180a203
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240726110139eucas1p24eb41978fdad0d37a95c2c829180a203
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
	<CGME20240726110139eucas1p24eb41978fdad0d37a95c2c829180a203@eucas1p2.samsung.com>

Like most of the SoCs, it requires 1 clock and 1 register.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: make the clock required in Exynos850.

 .../devicetree/bindings/thermal/samsung,exynos-thermal.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index 29a08b0729ee..b8c0bb7f4263 100644
--- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -27,6 +27,7 @@ properties:
       - samsung,exynos5420-tmu-ext-triminfo
       - samsung,exynos5433-tmu
       - samsung,exynos7-tmu
+      - samsung,exynos850-tmu
 
   clocks:
     minItems: 1
@@ -131,6 +132,7 @@ allOf:
               - samsung,exynos5250-tmu
               - samsung,exynos5260-tmu
               - samsung,exynos5420-tmu
+              - samsung,exynos850-tmu
     then:
       properties:
         clocks:
-- 
2.45.1


