Return-Path: <linux-pm+bounces-11254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4B93777D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFA01F22640
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ABB12D1EA;
	Fri, 19 Jul 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h8kB7BDU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80C12C530
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390994; cv=none; b=bErbL7UPdw0OjzaQNO+ooHX0gGWSL0mC4zhilSUTogiiIyRl4NWFJABpdYeL1JAYiQyKJQbLXb8r0+1EeuzFr2HUCCuAPE82vlfKX+Dpn8Q23Ud/SWrzfDhmNZhBIhYwpgmqldm85VEbIq5VoM0/EnbQUm02BrgDtxMPf3ob1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390994; c=relaxed/simple;
	bh=KGT1xetgjj3hkmYa/x+nByR9akz8lXZmdXZcEbp4tw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=t540yDZDuJST69tH5PHDDYlOWnowwmqKurB2/HAFf6j5JIIkBUY5dtI0FmwXrGX6+wZsAHthp749qLKrddMI1v6adu3gq31w2TlCJ0gq1gds/G7O1pdY/qIUUl7FuDGAsFvhZ1/RvvbcWJK8UxH4V4dRLa0CpEDl+eF8o1QEoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h8kB7BDU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240719120945euoutp017f295bbbbdb2791c188c40452ce2def9~jm-seWFRA1212912129euoutp01a
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240719120945euoutp017f295bbbbdb2791c188c40452ce2def9~jm-seWFRA1212912129euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721390985;
	bh=2oggq1cJ/h58DEMA1EPnxpHzRV+N2oiFBW83Vf5fiXo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=h8kB7BDUMPu2jLSJK6dMYh4oT251AmETCSRK+YB3mpLEfO1NWkSTS+XR2e86dWrE1
	 HPZQwpcLq2Ggz1AsenZgfBot7BOXjoknvBO33koW4AML6nIdzW4KvJNaE2pcLp6IhA
	 GTRz7uwoZm1oy6PxXDBywlE98TwUuJPUQfvgQRzQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240719120945eucas1p1cf150bcfe0c8d6cd7b5d63bbe0ba81d5~jm-sL3Byi0040800408eucas1p1c;
	Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id CA.8A.09875.8875A966; Fri, 19
	Jul 2024 13:09:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240719120944eucas1p29318fb588150b15f60f637fbea48271f~jm-rZB7nX0386803868eucas1p2n;
	Fri, 19 Jul 2024 12:09:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240719120944eusmtrp12f10a72f3fb4694ccba8d2e46727ecca~jm-rYPaxe0596405964eusmtrp1O;
	Fri, 19 Jul 2024 12:09:44 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-be-669a57888b3b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.85.08810.8875A966; Fri, 19
	Jul 2024 13:09:44 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120943eusmtip16111bf602808784812aeb176aa5561a0~jm-qlF-NG0493704937eusmtip1e;
	Fri, 19 Jul 2024 12:09:43 +0000 (GMT)
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
Subject: [PATCH 0/6] Add initial Exynos 850 support to the thermal driver
Date: Fri, 19 Jul 2024 14:08:44 +0200
Message-ID: <20240719120853.1924771-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djP87qd4bPSDFbdZbR4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oLpuU1JzMstQifbsEroxv6/6zFSxhr3g6o521gbGDrYuRk0NCwETi0uMFQDYXh5DA
	CkaJJcf3skM4XxglHqxdxwzhfGaUuPT1GVzLp787WSESyxklZu57wQThtDJJPPyyiBGkik3A
	QOLBm2Vgs0QEFjNKNP54B9bCLDCJWeLgmoVADgeHsICnxL7/XiANLAKqEh++HWcBsXkF7CTO
	9zxghlgnL9G7v48JIi4ocXLmE7AaZqB489bZYPdJCHzgkFg7bTUTRIOLxL+zp6CahSVeHd/C
	DmHLSJye3MMCYedLzNj8ngXkBgmBCom7B70gTGuJj2eYQUxmAU2J9bv0IYodJZa/WcMEUcEn
	ceOtIMQBfBKTtk1nhgjzSnS0CUFUq0oc3zMJar20xJOW21BneUjMvbUUbL2QQKzEpcUT2SYw
	KsxC8tYsJG/NQrhhASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMCUdvrf8S87GJe/
	+qh3iJGJg/EQowQHs5IIr9+3mWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1Kz
	U1MLUotgskwcnFINTI7m07fVqMw7OKdkdbyHI2+DG8u6JfsKtvVVGq+wPeL0re99sNiZGZc1
	v/8se/Ztx8I1s9p3r9ZL8OGprc3a8P+esm2ET9zyj9+Vt6T17mGNEzKes8nma9KUqSJc7kxX
	DwmWzLGOEvDrjJA+Pe3i29U5CV9zdj2Yb5CwP2Lq8vjjpkaB/zj5t37bdYrnFsuqcvVIGcmY
	LMYsRuf9CZvKZULPV39aFrZm5nZlpkVbjzyXZ5pWzeOp8UNfN4d9yYW7//Jizp44IuL34Zu+
	SJOcDYNGreB2ho2FaqXd3ZvbM2J+X9Gbu15QV3lC0AHr1uUH5loG23+4NLGkJ+LsLvGSqMl8
	X3ZOqWDq+sEneXLXRiWW4oxEQy3mouJEABydUpLYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7od4bPSDGYc5bJ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
	vYxv6/6zFSxhr3g6o521gbGDrYuRk0NCwETi09+drF2MXBxCAksZJSbe/cMEkZCWOPxlCjuE
	LSzx51oXWIOQQDOTxItljiA2m4CBxIM3y8BqRASWM0psbvcAGcQsMItZovfUVMYuRg4OYQFP
	iX3/vUBqWARUJT58O84CYvMK2Emc73nADDFfXqJ3fx8TRFxQ4uTMJ2A1zEDx5q2zmScw8s1C
	kpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYDRtO/Zz8w7Gea8+6h1iZOJgPMQo
	wcGsJMLr921mmhBvSmJlVWpRfnxRaU5q8SFGU6D7JjJLiSbnA+M5ryTe0MzA1NDEzNLA1NLM
	WEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBaeXaOV85Ok6klV7j33hD6H/vi2IL5m1yix6c
	llhTEFn7/TzDxl7NXbc1Q+/5iZjHK0kvDKu68q42wz3r4a74715raz9J/JT5oiTk7v2qdoVW
	wTOT3rS5B991J+kUXczY7HDz/XcPgRS2ou8JNdwlE/yYJbse6v256drU0pPFxthdcePx9Ekh
	B79fVEw9HTCpOW+VFFPc1aCMLPMQh1XzXnkuXZsc7KG7ZJLsl4P37ee1ZkrprGT8bnPw6dZC
	9Wmqym6fnYyvnI61TmPfw75mrt+tv95nbXinaxz7e7Fv1fNK67dzX7mVaC5aa+MuuK5C40XE
	oqmlAu/Xmvw+zfZVaeqeKczWaRE3t6e/7u7TVWIpzkg01GIuKk4EAGFZDXcvAwAA
X-CMS-MailID: 20240719120944eucas1p29318fb588150b15f60f637fbea48271f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240719120944eucas1p29318fb588150b15f60f637fbea48271f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240719120944eucas1p29318fb588150b15f60f637fbea48271f
References: <CGME20240719120944eucas1p29318fb588150b15f60f637fbea48271f@eucas1p2.samsung.com>

This series adds initial Exynos 850 support to the thermal driver
together with its requirements (tmu_temp_mask fix, making data->clk
optional, adding the new string to dt-bindings), while also cleaning up
a bit (using DEFINE_SIMPLE_DEV_PM_OPS and removing some outdated
information from dt-bindings).

Mateusz Majewski (6):
  drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
  drivers/thermal/exynos: use tmu_temp_mask consistently
  drivers/thermal/exynos: check IS_ERR(data->clk) consistently
  dt-bindings: thermal: samsung,exynos: add exynos850-tmu string
  drivers/thermal/exynos: add initial Exynos 850 support
  dt-bindings: thermal: samsung,exynos: remove outdated information on
    trip point count

 .../thermal/samsung,exynos-thermal.yaml       |  33 ++-
 drivers/thermal/samsung/exynos_tmu.c          | 279 +++++++++++++++---
 2 files changed, 270 insertions(+), 42 deletions(-)

-- 
2.45.1


