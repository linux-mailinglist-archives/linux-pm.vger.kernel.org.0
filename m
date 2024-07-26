Return-Path: <linux-pm+bounces-11424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B082193D18A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4EBB21DBC
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49117B427;
	Fri, 26 Jul 2024 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="siiZkKgd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345017A932
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991710; cv=none; b=HlQXI3mxpvIZ+eAF6HSQUggoIPx+Ze97SaptHl32tznoXCiXM9B2C5R+AZq2SuTXfwlfJbQ8WRgELlz7UOJV7rPpfepFP9Vj89lQg2/pR+1xjwMPLrN9tpX4NULl3Vl+9skn+QKJNRk1JHv91C/GWe1h7hIFIDaCeNrgLxMMZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991710; c=relaxed/simple;
	bh=L0mvaV8X0WltkVzwlLlXfGwrefXL6s680qW9ibXQejQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Iva79zWzCazOdkNaly7khwhC4fz9ezrOiQ1AorKI2Imb2LSykXDQ4mOMvYNq/TdIylfd8/NgdDrSTi89lEE6RLsltCyF8pgN8ESeDkTC1UcvolsW1Yk+agZXG6QAmn0RbpO/TAlmZfB027dVIJZUvhmnmlKVJAO1t7di/jWCk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=siiZkKgd; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240726110143euoutp01dfe7ab8ffdd7a4ebf314ed7f3d5481af~lvlSq8aPa0351503515euoutp01i
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240726110143euoutp01dfe7ab8ffdd7a4ebf314ed7f3d5481af~lvlSq8aPa0351503515euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721991703;
	bh=AbcoZ8p2EMCAVuh7BMmjXNSk5P3gS4zwK/tIw/0QxX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siiZkKgdVYefKVGL9ufolcTqdhBeHXUJGA6wejP7Qu4tz4CkHMHg9jFyg0p8mK5Bg
	 GLcQBiVtnV86K/dUjdXhDp1GlqAdOUa6wjP5FMhB+WEWUYnw5tdzjMgro+YQB/NXZT
	 xUJQqx8eoTosv7E/d1o629Bx+tNe9e9lAtW3vxlU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240726110143eucas1p21def5a1d68ce1a6e36241c173f91f285~lvlSVYFUF2805028050eucas1p2E;
	Fri, 26 Jul 2024 11:01:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.C8.09875.61283A66; Fri, 26
	Jul 2024 12:01:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110142eucas1p29f261e5e81c177456fd5bb5546871eb4~lvlR0bPsZ2798727987eucas1p2D;
	Fri, 26 Jul 2024 11:01:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240726110142eusmtrp21b714b7d0615118d3070e4559f1f5175~lvlRzdDN11722517225eusmtrp2d;
	Fri, 26 Jul 2024 11:01:42 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-cf-66a382169cf5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.B1.09010.61283A66; Fri, 26
	Jul 2024 12:01:42 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110141eusmtip2f62b99d665a1ea26f7949c90ee2d8d5f~lvlQ6YXCU3264832648eusmtip2Q;
	Fri, 26 Jul 2024 11:01:41 +0000 (GMT)
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
Subject: [PATCH v2 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
Date: Fri, 26 Jul 2024 13:01:10 +0200
Message-ID: <20240726110114.1509733-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240726110114.1509733-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7piTYvTDCbuNbN4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CV8X3Gb+aCJs6K2Z2fWRoYt7F3MXJySAiY
	SOx7dYAFxBYSWMEocXandhcjF5D9hVFiVvsEVgjnM6PEg9ZGuI55u96xQCSWM0qsXjSfHcJp
	ZZJYuu8TG0gVm4CBxIM3y8ASIgKLGSUaf7wDm8Us8IRZ4uerxYwgVcIC+RJ/Zk0C284ioCox
	+fgaZhCbV8BO4taifWwQ++Qlevf3MYHYnAL2EksmfWSEqBGUODnzCVgvM1BN89bZzCALJARm
	c0pMOP2DGaLZRWL1O5jDhSVeHd8CZctI/N85nwnCzpeYsfk90CAOILtC4u5BLwjTWuLjGWYQ
	k1lAU2L9Ln2IYkeJm9NOM0FU8EnceCsIcQCfxKRt05khwrwSHW1CENWqEsf3TII6RVriSctt
	qJUeEh1X+5kmMCrOQvLKLCSvzELYu4CReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg
	mjv97/iXHYzLX33UO8TIxMF4iFGCg1lJhHfZ/YVpQrwpiZVVqUX58UWlOanFhxilOViUxHlV
	U+RThQTSE0tSs1NTC1KLYLJMHJxSDUzJDha113n8mf8cPzLnk3x9zxZ3ZYebj7K5nvpH1647
	+k+op/6Llv3OBZM9bldaKnTUehywi+esk2TLuDqH+/eDZSskGnuFaj5qiMrsu8PfV5XYdptl
	mnJAk3ZwwVJfc+FW+Ydvmfi+Lu68vifEQurH6gt7D2ctaq5waZOeaOrftPmKu7RCia6aXN5L
	qcn7OkMaEr7tenLA7bPmuetLs26wGm46yShvO3vdma+JkfmOkUX7lHouzMyzcfi/7I3jmdPN
	Dy53nGIPf8X7cc3EWZe7SnNv//ih2VMR/3C+nPrJ6yYPW1Y4rNr13PHTe/nvtgWMz04J6Mqq
	/ZF4qfP986cwnwaLUw7qF7efKbi6r1CJpTgj0VCLuag4EQDScKFC4gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7piTYvTDKbOELN4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CX8X3Gb+aCJs6K2Z2fWRoYt7F3MXJySAiYSMzb9Y6li5GLQ0hgKaPExtuT
	oBLSEoe/TIGyhSX+XOtigyhqZpJ40n6ZGSTBJmAg8eDNMrAiEYHljBKb2z1AbGaBd8wS7ef9
	uhg5OIQFciXOXdUCCbMIqEpMPr4GrJVXwE7i1qJ9bBDz5SV69/cxgdicAvYSSyZ9ZASxhYBq
	7veuZoSoF5Q4OfMJC8R4eYnmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGRXnFibnFpXrpe
	cn7uJkZgRG479nPLDsaVrz7qHWJk4mA8xCjBwawkwrvs/sI0Id6UxMqq1KL8+KLSnNTiQ4ym
	QHdPZJYSTc4HpoS8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQam
	6qcdyzS3PxaYcCvv4z+/E/+qDXOK3HbLdp5qmyK6t07i+ZXP23wnTDB7r5wh8E949laG9dsi
	Of/dC3ZY8MHFiWmzBYtNrGdj96Stt/errl5jvefJKc1YH42s6sez99u+dth74MAPKeurUzq9
	jEt3s61pXh0RFHNXoOGP04PVG88I2R5T//bg5HID1ss/11+z3B9a/iCn+94izzjFT3/qTYMO
	BR6um3/6s9Gc9AlZnw4uObHu1tWTVyb3NRjf4/qj8/42zyc1/we5q4v6Gm7OTcqynVbt2bxL
	3vr4lc/nePcX908tWphZtunHZcfT9YX1G6fZXRFW7pe6LnhphdYnN9b6ZytZZZ/VlKYnRiT2
	XVBiKc5INNRiLipOBAB+j/aCUQMAAA==
X-CMS-MailID: 20240726110142eucas1p29f261e5e81c177456fd5bb5546871eb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240726110142eucas1p29f261e5e81c177456fd5bb5546871eb4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240726110142eucas1p29f261e5e81c177456fd5bb5546871eb4
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
	<CGME20240726110142eucas1p29f261e5e81c177456fd5bb5546871eb4@eucas1p2.samsung.com>

This is not true as of commit 5314b1543787 ("thermal/drivers/exynos: Use
set_trips ops").

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: remove an unnecessary sentence.

 .../devicetree/bindings/thermal/samsung,exynos-thermal.yaml | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index b8c0bb7f4263..b85b4c420cd3 100644
--- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -40,11 +40,7 @@ properties:
   interrupts:
     description: |
       The Exynos TMU supports generating interrupts when reaching given
-      temperature thresholds. Number of supported thermal trip points depends
-      on the SoC (only first trip points defined in DT will be configured)::
-       - most of SoC: 4
-       - samsung,exynos5433-tmu: 8
-       - samsung,exynos7-tmu: 8
+      temperature thresholds.
     maxItems: 1
 
   reg:
-- 
2.45.1


