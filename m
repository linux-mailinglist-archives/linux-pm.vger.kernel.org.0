Return-Path: <linux-pm+bounces-11258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D53393778E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 14:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E351F2260C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E639142642;
	Fri, 19 Jul 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nNBrzS+I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4D13BACC
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390999; cv=none; b=Wltnfo5qeLY7d3NUoiWWJF50l7aGrAPb0g/iM3wKK365atu2Z7JpqLMjRW354friEyF3wkICW5wUrGZi9mA0C38CxRNG+YPR5eUaglGB/RXxyTVk58tp15B7SZiX7Ekxl4aB/SFh/+Ud6FzNGwzGjVgQT/pnD41/jCNOvt5AxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390999; c=relaxed/simple;
	bh=dDos9H05+qDzXMiWfSU5GWiJsLIv3fRso6nnl796kqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=NJlDzOfavsMa4L5WY0wzqMmiVxd1G3rsi7uI6z1bJADr55hHPOkcBu5dJlUjg5fjZ7vVjPfiFkBvPBSgibz2ESjcI3eZKDrHkJVyzD1rkWZGLzPbrfIyURgArGvnFNkMH0/8rDSN/s9+wIMUIP+3w4nB/hNuMNTF2yzl7/erQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nNBrzS+I; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240719120949euoutp01a1e910dace5790ff0c7763d13da41cd6~jm-wpkYSR1063010630euoutp01K
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240719120949euoutp01a1e910dace5790ff0c7763d13da41cd6~jm-wpkYSR1063010630euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721390989;
	bh=8L+8K8twVSGfN5L0l+WoukLvg4jjKeIw7yZBc6vFhrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNBrzS+IWQTG1QheCn+DEs6UQj9c/KCE6cXqirIdcDbV/77FLXNAWsKL49GpBGBRF
	 0xjsvF92X6KfwhwvFAxn3k1nSRIf1RuqxbqDSNdIW5nRdv1bbDVJSGXeW+5qM/Bv4k
	 b4vpn+o39Jrv6mEV9Cv8T5W0sp4nlfnvO+2SivRA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240719120949eucas1p172904c6afe06a283bf168a26ca4ee7f8~jm-wS0mqV0450204502eucas1p1u;
	Fri, 19 Jul 2024 12:09:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 5F.8A.09875.D875A966; Fri, 19
	Jul 2024 13:09:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120949eucas1p1b061c716ac55b4a79ba57c407c0b2d91~jm-v6TaVb0450604506eucas1p1Y;
	Fri, 19 Jul 2024 12:09:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240719120949eusmtrp13362fcffe7cbc3958cca35202c9c984a~jm-v5crZH0596405964eusmtrp1l;
	Fri, 19 Jul 2024 12:09:49 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-cf-669a578d5090
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 28.EF.09010.C875A966; Fri, 19
	Jul 2024 13:09:48 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120948eusmtip18928f131a3ee254973ba2684bb3959a2~jm-vD7J6P0493704937eusmtip1h;
	Fri, 19 Jul 2024 12:09:48 +0000 (GMT)
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
Subject: [PATCH 6/6] dt-bindings: thermal: samsung,exynos: remove outdated
 information on trip point count
Date: Fri, 19 Jul 2024 14:08:50 +0200
Message-ID: <20240719120853.1924771-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240719120853.1924771-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djP87q94bPSDLonSVk8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaLiccmM1vM
	/TKV2eL/nh3sFk8e9rE58HusmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R79G1Zxejx
	eZNcAEcUl01Kak5mWWqRvl0CV8b0dWsYC85xVszYf4+xgfEZexcjJ4eEgIlEz7YWli5GLg4h
	gRWMEive9DBDOF8YJa5em8cI4XxmlHh9ZQ8jTEvf9mVgtpDAckaJWUs0IIpamSQePetmBUmw
	CRhIPHizjB0kISKwmFGi8cc7VhCHWWASs8TBNQuBHA4OYYEciW1vzEAaWARUJc6fv8wGEuYV
	sJPo21ECsUxeond/HxOIzSlgL/G76S0biM0rIChxcuYTFhCbGaimeetssLMlBLo5JRq+rYC6
	1EVi0oO5zBC2sMSr41ugnpaROD25hwXCzpeYsfk9C8heCYEKibsHvSBMa4mPZ5hBTGYBTYn1
	u/Qhih0leu4cY4eo4JO48VYQ4gA+iUnbpjNDhHklOtqEIKpVJY7vmQS1XlriScttJogSD4kb
	T/MmMCrOQvLJLCSfzEJYu4CReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgMjv97/iX
	HYzLX33UO8TIxMF4iFGCg1lJhNfv28w0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLp
	iSWp2ampBalFMFkmDk6pBqaqR5Nz109bL3As+2rQo1tF1yOVtkzfve3S1zTlH042521mLw7Y
	YpMesILnHU/PzWQ1x+Mflx3clGD1pmnWz9ZMtdvMQbw3rCy/BYidXfmwkO+kZlQTq6deuOpj
	nys/zF7NUdr8b2P8o10+weyMfz5mZ9iaVk2otg/zEtiatfCHZlDZxIAzDGsX+HfXii3YoJF8
	+dBa83nrXC5zTI9d+SWBzapw4TTHooiDpvP9GuKEPt/btj1xb8va51pVvU/fnI9nPVzEW7dm
	2UrXhY8urTne25VTIBf8eVLP9OXxdsrB001/fI9JvdsdXxT+68bebTX7jmaszavaKKPgNjmz
	cIr4tNl7fyruO/2CTezvT/e5SizFGYmGWsxFxYkAPTzw1tUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7o94bPSDK7vs7Z4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
	vYzp69YwFpzjrJix/x5jA+Mz9i5GTg4JAROJvu3LGLsYuTiEBJYySuxfuosJIiEtcfjLFKgi
	YYk/17rYIIqamSSerjgHlmATMJB48GYZmC0isJxRYnO7B0gRs8AsZoneU1OBxnJwCAtkSTx8
	lghSwyKgKnH+/GU2kDCvgJ1E344SiPnyEr37+8D2cgrYS/xuessGYgsBlez8OA/M5hUQlDg5
	8wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMvm3H
	fm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeP2+zUwT4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR5Hxg
	/OeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAFnxI6Yq231Jot
	Uevk2wdvzYRvH3uu83hPw7vPcvdFt1r/qU8+cHSGY5vvqeJ9x9iOsOdZNb5d6nlMuivjfXJE
	lvuWEDfdt+mNN5hOPn4vVXwt5dxLo+Qfu45+UeT59z+phuHm5vd6rELWswsfFktYbzozL8wk
	8ru5gLT+960TDig/yH/4sV1fKOxJEHvDPv2DnSl3BCetv67sv8o0RGH5wRmZ1g35G8pCWHjk
	Dq0Rf3fIb67QlOnJPw5M59ubof3j5pO9/MwnK4/Ues/58PuJx83D1/sftKZmJlpfsmo5eln/
	It8ZoYeTDq+/l+V6PXjvne5XBx5qbpfp6RM80HFH+XP5A0ad/ZPKBe4eaJ34VImlOCPRUIu5
	qDgRAGgXxF1HAwAA
X-CMS-MailID: 20240719120949eucas1p1b061c716ac55b4a79ba57c407c0b2d91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240719120949eucas1p1b061c716ac55b4a79ba57c407c0b2d91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240719120949eucas1p1b061c716ac55b4a79ba57c407c0b2d91
References: <20240719120853.1924771-1-m.majewski2@samsung.com>
	<CGME20240719120949eucas1p1b061c716ac55b4a79ba57c407c0b2d91@eucas1p1.samsung.com>

This is not true as of commit 5314b1543787 ("thermal/drivers/exynos: Use
set_trips ops").

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 .../bindings/thermal/samsung,exynos-thermal.yaml           | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index 4363ee625339..5a82764a4dbb 100644
--- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -40,11 +40,8 @@ properties:
   interrupts:
     description: |
       The Exynos TMU supports generating interrupts when reaching given
-      temperature thresholds. Number of supported thermal trip points depends
-      on the SoC (only first trip points defined in DT will be configured)::
-       - most of SoC: 4
-       - samsung,exynos5433-tmu: 8
-       - samsung,exynos7-tmu: 8
+      temperature thresholds. The trip points will be set dynamically in
+      runtime, which means there is no limit on the number of trip points.
     maxItems: 1
 
   reg:
-- 
2.45.1


