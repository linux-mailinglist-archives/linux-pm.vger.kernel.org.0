Return-Path: <linux-pm+bounces-14018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C964B975198
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257E9B29C51
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C019E971;
	Wed, 11 Sep 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g5+kyYFK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713D19C564
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056723; cv=none; b=FhklIKEpYTcl9Tz8Rn3y+IAuwOMO4YiNFOIVy9QQxN+KVHZARavFuEi+H2Xmm7fqfBzPpGcPQQIs5yLpTW1YcyW4NuITRFlanF4NPaVwDjTKksMrngfNJu5EcwFmZO+1gQ88wPvpvHXxEQehJbhZ3w8X2TPGNoYanAgfOyjPAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056723; c=relaxed/simple;
	bh=kuHpYla48FL3IoPXA3I3u/L0oNHA2kLHhX+p73plfos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=h7rsbW69xVCSq58wv6zLss2HHc3pwTIwvvg0mjTvGv+WnanNEE1waRbtM8tu9KfApb5ZYbc5WMjnKzU98Oaa1CbkIPGMhUlQlCeYiLd1GhCjm7IRZ43b/BPr//suzNT3dAsROf7sbHREAn7VCGZdEmZJ+ce+2FYVAARY4Chfvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g5+kyYFK; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240911121200euoutp01ed585b20b0ebae9196e099b1ff49681a~0L3EjE3jW0991009910euoutp01J
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:12:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240911121200euoutp01ed585b20b0ebae9196e099b1ff49681a~0L3EjE3jW0991009910euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726056720;
	bh=Y0Eg0QBpQbCUuL7P46NlXOmSQkcvzkcL2BjioU95Oh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5+kyYFKZjkkO7S+uLiYh25SmDmbbO5hncMsJxX1/vja5aRYTJXtTAr7JFOjLBAZZ
	 TgSWDRaD9KhGhZGWfEljMLHVPMGvDXJrLCWIy3d4+KPg+z6mNSPR2gKLsDMrWsCpTR
	 ewebVMmShKW3jyFdkY5HEJFqPW6SsauvRQSGvtoY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240911121159eucas1p218ace4e87ae9e4ecf30cdf23b6f5e2a0~0L3EIX72E2873128731eucas1p2Y;
	Wed, 11 Sep 2024 12:11:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F7.48.09620.F0981E66; Wed, 11
	Sep 2024 13:11:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121159eucas1p1ecfa41871f21953b49d90c287d121409~0L3DmH--S2500425004eucas1p1E;
	Wed, 11 Sep 2024 12:11:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911121159eusmtrp21828e598ebcdf09e9c799a63cc01525c~0L3DlDyHi2708727087eusmtrp2r;
	Wed, 11 Sep 2024 12:11:59 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-8b-66e1890f8fd3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.5D.19096.E0981E66; Wed, 11
	Sep 2024 13:11:58 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121158eusmtip1eb216979373ba6be7882e3e7022bd6ac~0L3CmHKMU0718707187eusmtip1h;
	Wed, 11 Sep 2024 12:11:58 +0000 (GMT)
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
	Moon <linux.amoon@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 7/7] dt-bindings: thermal: samsung,exynos: remove
 driver-specific information
Date: Wed, 11 Sep 2024 14:11:30 +0200
Message-ID: <20240911121136.1120026-8-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121136.1120026-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87r8nQ/TDPZsVrF4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38Busff1VnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrNt4i91i
	YVMLu8XEY5OZLdYeuctuMffLVGaL/3t2sFs8edjHZvG8bx+Tg7DHmnlrGD12zrrL7rF4z0sm
	j02rOtk87lzbw+axeUm9R9+WVYwenzfJBXBEcdmkpOZklqUW6dslcGX0fXzDWNDMV/Fv6QrG
	BsaL3F2MHBwSAiYSi1/6dTFycQgJrGCUWNK+kw3C+cIoseNfIyuE85lR4sqx30AZTrCOE7eu
	M4HYQgLLGSWe9KtBFLUySbRdmM8MkmATMJB48GYZO0hCRGAxo0Tjj3esIAlmgZMsEpNXe4HY
	wgJJEk/OnWIBsVkEVCXuTNkKNpVXwE7iy7Y/rBDb5CUurnkOtplTwF7i++vljBA1ghInZz5h
	gZgpL9G8dTYzyDIJgeWcEp+/TIFqdpGYfn0ulC0s8er4FnYIW0bi/875TBB2vsSMze9ZIIFR
	IXH3oBeEaS3x8QwziMksoCmxfpc+RLGjxI6Ja5ghKvgkbrwVhDiAT2LStulQYV6JjjYhiGpV
	ieN7JjFD2NIST1puQ630kGh9O4N5AqPiLCSvzELyyiyEvQsYmVcxiqeWFuempxYb56WW6xUn
	5haX5qXrJefnbmIEpr3T/45/3cG44tVHvUOMTByMhxglOJiVRHj77e6lCfGmJFZWpRblxxeV
	5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTBZndzZMTs0UPbBls3RwjsUA65K
	r2LoMRLb933iS2YfmU03Yu4fbSvQy3JSz0645Xnk6F229RPVxZ7JH3FbteL5sl6GJS4bBf6l
	rbOqq/ilcPjakj/Feo1KLFd2bs+3qHS9Kr3+195vNxYkVpXXXd1+KqlcVKjAz8Qo2fbChuMe
	ixbZXXy4QHlWQWhy94MPGyKP13wS+lryRDpBv/DIdMErUxfXZh9ckK/FMn/ishdZGzK+fr3c
	tuvcuTOfnVyed8Zosq/8f8VVdR7fY4mVCzUNNSOTouY5s57MM3vr5xO7LlD53aPpv5f3JR1g
	tZ/+Tc53+bZm/ZZIbePW8HtHOz70SG45+OtPeVD5v5/SbRP0lFiKMxINtZiLihMBHgqeGOoD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7r8nQ/TDFY6WTyYt43N4vuW60wW
	a/aeY7KY91nWYv6Rc6wW589vYLfY+3oru8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCzWbbzFbrGw
	qYXdYuKxycwWa4/cZbeY+2Uqs8X/PTvYLZ487GOzeN63j8lB2GPNvDWMHjtn3WX3WLznJZPH
	plWdbB53ru1h89i8pN6jb8sqRo/Pm+QCOKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUM
	jc1jrYxMlfTtbFJSczLLUov07RL0Mvo+vmEsaOar+Ld0BWMD40XuLkZODgkBE4kTt64zdTFy
	cQgJLGWU2NlxiwUiIS1x+MsUdghbWOLPtS42iKJmJomeA72MIAk2AQOJB2+WgRWJCCxnlNjc
	7gFSxCxwlUXi0Os5rCAJYYEEiS2XHoDZLAKqEnembGUCsXkF7CS+bPvDCrFBXuLimudsIDan
	gL3E99fLwRYIAdV83HiSFaJeUOLkzCdg1zED1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nz
	i430ihNzi0vz0vWS83M3MQLjdNuxn1t2MK589VHvECMTB+MhRgkOZiUR3n67e2lCvCmJlVWp
	RfnxRaU5qcWHGE2B7p7ILCWanA9MFHkl8YZmBqaGJmaWBqaWZsZK4rxsV86nCQmkJ5akZqem
	FqQWwfQxcXBKNTBNW7LCJeg3i9nfaQX5p/L2x93Zvtok+uaXKq6VZ6QmW7yqEY3uXba9+orR
	bBfGKTU3RCVmsYW2ztt6YOnSWSX3jiltOLQqxSkj1T6EVXHDC/MjfJO71jte4Vq841Tl52tV
	Hn6GKz41NnSFf8nTqL1vstEtfNfBk2tF/nDqPGc7K2WeMHtD1Ce2nbkPhcT/SPfcSOKUO/a0
	4uaJaW72iZ59524xXmf0qrsrrC9VG6J/PflojvmLRKGQ9UGveqz03yw49+TqvCW3vv38vXeB
	2kTZr+Ye+8UXHAlgn9Wi9oRjgZNUia36566ppwT/TdsrFin4Qn2hk7u58PM1asv5jv9e/Kg9
	ub/83IRQ2ZsLm76sUWIpzkg01GIuKk4EAA3DAb9cAwAA
X-CMS-MailID: 20240911121159eucas1p1ecfa41871f21953b49d90c287d121409
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240911121159eucas1p1ecfa41871f21953b49d90c287d121409
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240911121159eucas1p1ecfa41871f21953b49d90c287d121409
References: <20240911121136.1120026-1-m.majewski2@samsung.com>
	<CGME20240911121159eucas1p1ecfa41871f21953b49d90c287d121409@eucas1p1.samsung.com>

The number of supported trip points was only limited by the driver
implementation at the time, which mapped each trip point defined in the
devicetree source file to a hardware trip point. An implementation that
does not have this limitation is possible; indeed, that is how the
driver works currently. Therefore, this information should be removed
from the bindings description, which are meant to be independent of
the details of the driver implementation.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v2 -> v3: reword the commit message to be easier to understand in
  context of dt-bindings.
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
2.45.2


