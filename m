Return-Path: <linux-pm+bounces-11259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9E93778F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 14:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A83B21738
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F7142E85;
	Fri, 19 Jul 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZpTiFt3j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03113C67D
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390999; cv=none; b=FtVuec1cmb4bQ0euUoHa/YpDISoZUVqYTmrQ2WiC16zQKlrAj6yrLuXRbkDQ+unqBGMurswCu9XMzHDOc0uEesGumbB1VwNPTDeB8s0Tj/Pv5tpP64xy9APGQO3MscKW/cNltxvacByeEImcNCXt6OImHHEmOfTk4ZHHI/+pNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390999; c=relaxed/simple;
	bh=vu1g3g08bthgCSc+u5QDIWYclXTqVwOm8qrwDEGKMh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=HtUZJcoDy+oTW3ydlVPAEFdgowbZzAUaEaS84dIqHeWoIQukZBIll7bryCTT33PYJTVvRJs0p451FYKHUrlRD2pBQgmsJ61Cj2c0g7WQ/D1LY/0NGz/tj3co3CfS9oooYbuwy9AgS80YSyQ9QGPsiF/VVIdhbmywQhtcEzecyPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZpTiFt3j; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240719120948euoutp02a0a7cb1cbc77d1db0b74d31f15c1fa5d~jm-vTGwtP2413724137euoutp02F
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240719120948euoutp02a0a7cb1cbc77d1db0b74d31f15c1fa5d~jm-vTGwtP2413724137euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721390988;
	bh=s3mF2LZ2ghyJSjgTkkt5iV7uLpvClwedPpIveDotTwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpTiFt3jeTMIRCFoq7oE01j/nYrwcy5D4Mig363HoRaEGfakx7F1+JtwiqdQ7gMcA
	 4TSiLW6MnghXYNJjmKStfZe6grpp8gsrN8IT1jzv7Jxo9eY9du4D4gVgpUm6a99vSN
	 8bRBCcdOtn1znitT7weSPtW1wHuJeWcWZazOMy1w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240719120948eucas1p10a3ad078ffc22289a03f0a513f5d76b6~jm-u5QPLc0448404484eucas1p1Z;
	Fri, 19 Jul 2024 12:09:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 89.DA.09624.B875A966; Fri, 19
	Jul 2024 13:09:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120947eucas1p1344134823e100feaf49238de0e226431~jm-uWbRUq2870028700eucas1p1w;
	Fri, 19 Jul 2024 12:09:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240719120947eusmtrp1485f7090bab0f83be990b7d925e3e018~jm-uVvhTC0596405964eusmtrp1f;
	Fri, 19 Jul 2024 12:09:47 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-86-669a578be80a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.85.08810.B875A966; Fri, 19
	Jul 2024 13:09:47 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120946eusmtip117a8b881459e2782bfcf9ea80ab6e31a~jm-tj4fA00607006070eusmtip11;
	Fri, 19 Jul 2024 12:09:46 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>
Subject: [PATCH 4/6] dt-bindings: thermal: samsung,exynos: add exynos850-tmu
 string
Date: Fri, 19 Jul 2024 14:08:48 +0200
Message-ID: <20240719120853.1924771-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240719120853.1924771-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7rd4bPSDJr6zC0ezNvGZvF9y3Um
	izV7zzFZzPssazH/yDlWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/JYmFTC7vFxGOTmS3m
	fpnKbPF/zw52iycP+9gc+D3WzFvD6LFz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9+rasYvT4
	vEkugCOKyyYlNSezLLVI3y6BK6N3/2v2gj8CFRP7H7I3MO7m7mLk5JAQMJH4sfgxcxcjF4eQ
	wApGiaaVf5kgnC+MElc/r2OBcD4zSiyZu54JpuX4jr2sEInljBKndn2Hqmplkjjw9AFYFZuA
	gcSDN8vYQRIiAosZJRp/vANrYRaYxCxxcM1CVpAqYYFQifWzfzKC2CwCqhI/D8xjAbF5Bewk
	XvzrgdonL9G7vw/M5hSwl/jd9JYNokZQ4uTMJ2D1zEA1zVtng70hIdDNKbHgWh9Us4vE2Z0z
	mSFsYYlXx7ewQ9gyEqcn97BA2PkSMza/B7I5gOwKibsHvSBMa4mPZ5hBTGYBTYn1u/Qhih0l
	/v97yA5RwSdx460gxAF8EpO2TWeGCPNKdLQJQVSrShzfMwlqvbTEk5bbUGd5SPQuPMsygVFx
	FpJXZiF5ZRbC3gWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECk9rpf8c/7WCc++qj
	3iFGJg7GQ4wSHMxKIrx+32amCfGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5N
	LUgtgskycXBKNTDpRMt6P+SdZD8jwWKT+vWtjHJJwnFvL1Tznu+9uHDOtVuCq2I5t3RbCcxl
	fdx1vTCfd+rb+ccYrp/+uuLGrB9ehjkP8wODyoIbBIXyQpZtW11SemzNDI5WFvP95SJqzWzO
	vssP/Vqzh9HjXn3b+t6rv09c+ns06gyH0MdPllN2ej1fHPvJcmbw68iqBTduHndN8CkPdny8
	6ckyFqv86057FeOTdTr/hV7bZlMsuL1sy9s97MdfvLfZaXZjmyi72J5t05V5Z2kKml7ocJ9r
	e29H1JKe7nurl1rbrN0fe8sqwXbb/ab5StcWH1Z+1Z+emDD76T0jfomtTq1BJWsKo0qZv9zT
	8vp2eeqmacaeLftvKLEUZyQaajEXFScCAEMuz+7ZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7rd4bPSDKZfE7N4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
	vYze/a/ZC/4IVEzsf8jewLibu4uRk0NCwETi+I69rCC2kMBSRom3T1Mg4tISh79MYYewhSX+
	XOti62LkAqppZpI4e6eDDSTBJmAg8eDNMrAiEYHljBKb2z1AipgFZjFL9J6aygiSEBYIllhz
	bSkTiM0ioCrx88A8FhCbV8BO4sW/HiaIDfISvfv7wGxOAXuJ301v2SAuspPY+XEeG0S9oMTJ
	mU/AepmB6pu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHxt+3Y
	z807GOe9+qh3iJGJg/EQowQHs5IIr9+3mWlCvCmJlVWpRfnxRaU5qcWHGE2B7p7ILCWanA9M
	AHkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUx2Fmqs030v7+It
	/h97K+G2teGt40y3rneXNGZpXXZanLzv8hf+NZ9mRpZ8VKm4kHiiaPGeha/DUnhNXstuP+8o
	IlUz4XUeY9GnZUU3fjzdl/j7/5UXivLSdxcbdjt07bPYud2U+VjDs5Macu7LCvxdj6pO2nTv
	+yXvG5U7HPftdtaWkrna1Hn5Cucvt0KdYwm9e+ZtWW50bP6tUg3dr9M9Vpa4NcS0BK49q17F
	tW7ZugkPcuc+mvXK87H0rSL+zbuutq9b1fxgg1KTVP6x2L2l6Sonq0JnLlyaKjZfde2C2hsf
	Jfgzjj/fovO4SHlnp+b3pzNXPNgl3T7DYmFNRXLXsiW8IdwCITUTj+cqifF8VWIpzkg01GIu
	Kk4EAOUgSLtIAwAA
X-CMS-MailID: 20240719120947eucas1p1344134823e100feaf49238de0e226431
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240719120947eucas1p1344134823e100feaf49238de0e226431
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240719120947eucas1p1344134823e100feaf49238de0e226431
References: <20240719120853.1924771-1-m.majewski2@samsung.com>
	<CGME20240719120947eucas1p1344134823e100feaf49238de0e226431@eucas1p1.samsung.com>

Note that unlike others, Exynos 850 does not require clocks, hence we
have to be a little be more specific about when the related properties
are required.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 .../thermal/samsung,exynos-thermal.yaml       | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index 29a08b0729ee..4363ee625339 100644
--- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -27,6 +27,7 @@ properties:
       - samsung,exynos5420-tmu-ext-triminfo
       - samsung,exynos5433-tmu
       - samsung,exynos7-tmu
+      - samsung,exynos850-tmu
 
   clocks:
     minItems: 1
@@ -69,8 +70,6 @@ properties:
 
 required:
   - compatible
-  - clocks
-  - clock-names
   - interrupts
   - reg
 
@@ -82,6 +81,9 @@ allOf:
           contains:
             const: samsung,exynos5420-tmu-ext-triminfo
     then:
+      required:
+        - clocks
+        - clock-names
       properties:
         clocks:
           items:
@@ -105,6 +107,9 @@ allOf:
               - samsung,exynos5433-tmu
               - samsung,exynos7-tmu
     then:
+      required:
+        - clocks
+        - clock-names
       properties:
         clocks:
           items:
@@ -132,6 +137,9 @@ allOf:
               - samsung,exynos5260-tmu
               - samsung,exynos5420-tmu
     then:
+      required:
+        - clocks
+        - clock-names
       properties:
         clocks:
           minItems: 1
@@ -140,6 +148,20 @@ allOf:
           minItems: 1
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos850-tmu
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+        reg:
+          minItems: 1
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.45.1


