Return-Path: <linux-pm+bounces-11966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5771694A370
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 10:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C38B2980C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9AD1D1724;
	Wed,  7 Aug 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DEvKfMTt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AA1CCB4D
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020558; cv=none; b=pIjg3pvekn7U+sTuequxSI2KQp/PYgaCR7ZWInpa4bULCY8z0cIOF0lgsdyDR/FbhK5r68wCvJJrNSLcYQHXtDNlz3C+tCI/9/2LGcnAGMtFgt/7HUOA/AQQc1QTNsdkkYsbanawxefWYTh8o+Lb1CwsK3efRq1mYuCRaQNn+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020558; c=relaxed/simple;
	bh=3IyJsucNrSjVQzmbqVhLY7sy8ydrU10/8DfKd+LzvxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=o95sNDTKC/+TAGkLsM0dinz9iuiUAVqrLXyLD//Y6Nxo4H0kcA/vEOVn911uccB1+DY35xsDXQ14r5tfuqGEzk/JM6eLNC4klqjZdjP26BUurxADfznpoWXwnr75/ILhSgMw98+9RftXpmm7y8np3fK5fhzaV6gU3cRqryP+aLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DEvKfMTt; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240807084915euoutp02305289d09f2573189683cae1ac0397f5~pZhDwDcIn3208832088euoutp02D
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240807084915euoutp02305289d09f2573189683cae1ac0397f5~pZhDwDcIn3208832088euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723020555;
	bh=Gy1BdGoquaXX5jKVUxDAPfjrKOOj4FV/TLRx6aCdfoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEvKfMTtl7y4eJm9l7x9bPwvAOlvVpnX+1elA/AfZOh+vmugoLFkK3pse6cKoeoHw
	 z7QIJ5sDDP2tYyfgQ2V8QDZIE6h+3+JKeaF1RrKcd/U84z1BXq8BaPo/Aq9VTtiQbu
	 lCRBE7ywUhiAdMCRTZfMmakBu8M1nib3ndnW1BfA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240807084915eucas1p1f71083d16c5471c6b48d887637f9e877~pZhDZ-0PR0340503405eucas1p1h;
	Wed,  7 Aug 2024 08:49:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 8E.02.09624.A0533B66; Wed,  7
	Aug 2024 09:49:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240807084914eucas1p1948d159c31b0dce8243d84fd43a7d94e~pZhC4LO_e2696226962eucas1p15;
	Wed,  7 Aug 2024 08:49:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240807084914eusmtrp1aa09a4680c82998a28046324b9038db2~pZhC3eUtK0287102871eusmtrp1N;
	Wed,  7 Aug 2024 08:49:14 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-33-66b3350a1c31
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.DC.09010.A0533B66; Wed,  7
	Aug 2024 09:49:14 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084913eusmtip2d59cdd6d8735ba2305482c2bbc87d1c1~pZhB8C4ad2807028070eusmtip2T;
	Wed,  7 Aug 2024 08:49:13 +0000 (GMT)
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
Subject: [PATCH v3 4/6] dt-bindings: thermal: samsung,exynos: add
 exynos850-tmu string
Date: Wed,  7 Aug 2024 10:48:23 +0200
Message-ID: <20240807084829.1037303-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240807084829.1037303-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87pcppvTDPr3mFs8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLul6nMFv/37GC3ePKwj83ied8+JgdBjzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofN
	Y/OSeo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKeHBNtKCZs+Ltz91MDYx97F2MnBwSAiYS
	v6dPZ+xi5OIQEljBKLFh/29WCOcLkDPjPTOE85lR4vajo2wwLXM2nYBKLGeUuPznM5TTyiSx
	7MErJpAqNgEDiQdvlrGDJEQEFjNKNP54BzaYWeAJs8TPV4uBVnJwCAtESGz6WQPSwCKgKvFs
	Vj8LiM0rYCfxu/Ma1Dp5id79fWBDOQXsJZZ0dzNB1AhKnJz5BKyeGaimeetssCskBCZzSlzb
	Og+q2UWitbsByhaWeHV8C9TbMhKnJ/ewQNj5EjM2v2cBuUdCoELi7kEvCNNa4uMZZhCTWUBT
	Yv0ufYhiR4n5/+8wQ1TwSdx4KwhxAJ/EpG3TocK8Eh1tQhDVqhLH90xihrClJZ603GaCsD0k
	zh/sYJ7AqDgLySuzkLwyC2HvAkbmVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIFJ7vS/
	4592MM599VHvECMTB+MhRgkOZiUR3ubwTWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOF
	BNITS1KzU1MLUotgskwcnFINTInfYuc9fTs9c6HtBOGvHl+Z122KK32X4WV/PMkp9f6Mqva1
	K3lj9a1vxandvZ87bXlWu3SxqNYfRVH1FSu3M858OO3F1A+v5FZw3nz/68j1v18OPFy4MiN3
	Pk+GupXgIq+5zYvfzrh0LF43kl1+4W2z3pC1jS1KD1ZOqJPn8bv07b309tLQPh1nqbS3WZcS
	X3mdjPktse3onhcvP+gFWuZ7cwTpR9TOsZ6feIyp+4r1xSMHdrmtmaGQtd/26g6f3GeezTW1
	Jk8dnPmE3N9IvGvzKwxSXsK55UBz8m/+n4XhBYuyLAvlJBdN43CRFumSKfjC0JJZybposoyc
	zvNrFV/EnkRe+mhXW/bxzyMhRyWW4oxEQy3mouJEAMoas+DhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7pcppvTDM71i1g8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLul6nMFv/37GC3ePKwj83ied8+JgdBjzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofN
	Y/OSeo++LasYPT5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
	SUnNySxLLdK3S9DLeHBNtKCZs+Ltz91MDYx97F2MnBwSAiYSczadYO5i5OIQEljKKPHw4XY2
	iIS0xOEvU6CKhCX+XOtigyhqZpJo33sYrIhNwEDiwZtlYEUiAssZJTa3e4DYzALvmCXaz/uB
	2MICYRITJrUygtgsAqoSz2b1s4DYvAJ2Er87r0Etk5fo3d/HBGJzCthLLOnuBrOFgGp6v+xk
	hqgXlDg58wkLxHx5ieats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4m
	RmBEbjv2c8sOxpWvPuodYmTiYDzEKMHBrCTC2xy+KU2INyWxsiq1KD++qDQntfgQoynQ3ROZ
	pUST84EpIa8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSlp/5kO
	3SV99c8bHnYrJ5zxlJNKPSzJOC3znOJv2dydASGPVQO0n1ilbsq1i5vetLZM9PrC/8cmK6tI
	CYXPC1A55vd1sqXt+YOxB2VYawW6eHk85iS8mfT0U5ufWJnuRom/t+NXVL9L1TNJ+2A978dU
	axFzy5O3Mv8ubysoYf+54SPPmsvSj0vfd3loLtS0f6I7iZ2hYTHjHo3j284yV2gVCi4WlIlf
	/eLUg6rFXfP18ieHPTvMlDXL+veV5ubNW/fcCZ86hY3PWlE7/UEcg//T7ierav7f4jlk8MFu
	38yr3F8PyBUkzni3dMdlw2AFk9BEi+6C/NvHjhWcaOFrZ1qkLFvz+ccKsapbKpz35imxFGck
	GmoxFxUnAgBGczVDUQMAAA==
X-CMS-MailID: 20240807084914eucas1p1948d159c31b0dce8243d84fd43a7d94e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240807084914eucas1p1948d159c31b0dce8243d84fd43a7d94e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240807084914eucas1p1948d159c31b0dce8243d84fd43a7d94e
References: <20240807084829.1037303-1-m.majewski2@samsung.com>
	<CGME20240807084914eucas1p1948d159c31b0dce8243d84fd43a7d94e@eucas1p1.samsung.com>

Like most of the SoCs, it requires 1 clock and 1 register.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
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


