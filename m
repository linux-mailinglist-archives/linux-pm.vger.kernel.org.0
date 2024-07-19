Return-Path: <linux-pm+bounces-11255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A356937782
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 14:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B21282FF1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682B12BF32;
	Fri, 19 Jul 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cd5m33Ur"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CB12CD88
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390995; cv=none; b=YSZKPuTyGFlVhy7bGo2qcvHlE5kZRVY388+7PAe8KAy+5ZsR1uTUrkqstoKwZQgVBeZJ7Btd3qmCehZur0kZ7TyEdklai+CTwZEJGRPAfx/zsF/KZcXNYgoWCUl32dDeMsmKpKNpIVd8oAcmcTwaMWukrrjT8cd31oNT9IUMi5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390995; c=relaxed/simple;
	bh=t/JSKrNn17xxIU0XVqXg8T1CfhnUWQvG/4vnPaJ/u6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Qy6tpKRMeHCzM3dAl0lqUH7PDC6Ck6Fw2X//PUjh1HwQQimmQ1ixt9OdaBXxD1eXA/6ogc1OEKCGdoG2xVwruUeAFO8mWnxD2Tz2d6cQALYR4d7vQ6f9NaEnLGiKq1mr8+yiN5JZugOv33JG54kiC5JHRYXFPXhze+1v8WxLCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Cd5m33Ur; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240719120945euoutp0238b705486dd4a26985b11bc63199a9d9~jm-s6QTec2292422924euoutp02j
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240719120945euoutp0238b705486dd4a26985b11bc63199a9d9~jm-s6QTec2292422924euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721390985;
	bh=Svgmx1goIwZYGZC88T6ddmseZZap5QnMpm/fEQm2mU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cd5m33UrTllO1IykgZrSf8z/PNuN3Mdj2zxyr+x2JZ6BbDCQQbvcnTk0w2usn0Y/7
	 mkJLWtJ40R+ObNoRBAlaUe0dwqNnvO1n0J2CgDVjEX8H2CacoXif5fvi46NT1j5GIx
	 nJCP92Ir3LhXdV6V5oJmZy8V96qM/HH9qwVW7SVk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240719120945eucas1p18a7f1898ccd162a60573634690512da1~jm-sj5mT62653726537eucas1p1v;
	Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 1C.8A.09875.9875A966; Fri, 19
	Jul 2024 13:09:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240719120945eucas1p2aa5e35f78daa7ec1ea07f512180db468~jm-sGu_fh2595125951eucas1p2d;
	Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240719120945eusmtrp13e13d84c71a9fa89688122967f81d207~jm-sFw1W60596405964eusmtrp1T;
	Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-c0-669a578993b4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 62.EF.09010.8875A966; Fri, 19
	Jul 2024 13:09:44 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120944eusmtip10862f3e2f568be4fee49910d243a5f0d~jm-rVInij1193511935eusmtip1S;
	Fri, 19 Jul 2024 12:09:44 +0000 (GMT)
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
Subject: [PATCH 1/6] drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
Date: Fri, 19 Jul 2024 14:08:45 +0200
Message-ID: <20240719120853.1924771-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240719120853.1924771-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7djPc7qd4bPSDLrmils8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaLiccmM1vM
	/TKV2eL/nh3sFk8e9rE58HusmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R79G1Zxejx
	eZNcAEcUl01Kak5mWWqRvl0CV8a111+YCrawVfTsvsDWwHiEtYuRk0NCwETiytm77F2MXBxC
	AisYJS6e6GOEcL4wShx72cgM4XxmlNjS18AI07JywUSoluWMEq/OdEBVtTJJnF/+mQ2kik3A
	QOLBm2VgVSICixklGn+8YwVxmAUmMUscXLMQbL2wgKfEu+UX2UFsFgFViWcX9rOA2LwCdhJz
	9jQzQ+yTl+jd38cEYnMK2Ev8bnrLBlEjKHFy5hOwemagmuats8HOkBBo55R48uw50LEcQI6L
	xJGdYRBzhCVeHd/CDmHLSJye3MMCYedLzNj8ngWivELi7kEvCNNa4uMZZhCTWUBTYv0ufYhi
	R4nFu6YyQVTwSdx4Kwixn09i0rbpzBBhXomONiGIalWJ43smQb0hLfGk5TYThO0hseref/YJ
	jIqzkHwyC8knsxD2LmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY0k7/O/5lB+Py
	Vx/1DjEycTAeYpTgYFYS4fX7NjNNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6Yklq
	dmpqQWoRTJaJg1OqganlydTl3QUL4ty1XnbOOufHVLZ+rbVT6al49Q1tO913hQSXaz9PnL5N
	9ixLS2nG8Rv77F2FA1ja67jVbpl9rFJ/IKgqrq18fYmOpvIpt8xglSUrHYQ1vj3sjHme9epk
	7ffF7npZTJ06lRt9nnI+eLzhk7Wh4n3e3KVMV59WyS449vu5sXnW6r73Wr2LLRYr+GwvnrFo
	5okoG5n1E2oWTUuKTcuJbq7bzHy2OuqIndBuW3vGn09/sn9e+2niugmb5p/mvvLT3ue54kxl
	h5ytX1eyfTncWm3w0jJU821NsF97peIvM9vNSU82WG742zZvZa8N3409l45s4Ra9GPjlX31g
	zbzET48fcNYf2M+35pISS3FGoqEWc1FxIgCUFNFg2AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7od4bPSDDautLZ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
	vYxrr78wFWxhq+jZfYGtgfEIaxcjJ4eEgInEygUT2bsYuTiEBJYySky+PpERIiEtcfjLFHYI
	W1jiz7UuNoiiZiaJ9S3LwbrZBAwkHrxZBlYkIrCcUWJzuwdIEbPALGaJ3lNTwSYJC3hKvFt+
	EayIRUBV4tmF/SwgNq+AncScPc3MEBvkJXr39zGB2JwC9hK/m96ygdhCQDU7P85jg6gXlDg5
	8wlYLzNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzACtx37
	uWUH48pXH/UOMTJxMB5ilOBgVhLh9fs2M02INyWxsiq1KD++qDQntfgQoynQ3ROZpUST84Ep
	IK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgamuxbGwZ5uXEEvb
	/zX5ly6HNp7g+9G5fymr6WmzfF2XvJWKDk3Np14w7G1QYlsdJx846XzKT9eXZ2cYp81eklW3
	UK+Z8RZrG+9nh09dUalXLL+faPRmTdwq9DS0dPpX0xeT5medze497mrjclzizN++x6L8CQd9
	DO2sCte8X3ycq1D7/db1P6znTXCbacv6OFKSqTlm8y7tw6Hn83Rr3hs9qU81mGuZcHLXOv3c
	mmvZU15f29x6qXhW51ZnG5c4+/d3o3euCqnadlJDsWLZtND1Ph985Nv7zdqvHP7+Y6bGf8bk
	/XvONvgWO6yWmTHxDFudRuG5QyX87gHfP240azNNKbZNmXBV8aN0smBeoxJLcUaioRZzUXEi
	ADXuk2lJAwAA
X-CMS-MailID: 20240719120945eucas1p2aa5e35f78daa7ec1ea07f512180db468
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240719120945eucas1p2aa5e35f78daa7ec1ea07f512180db468
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240719120945eucas1p2aa5e35f78daa7ec1ea07f512180db468
References: <20240719120853.1924771-1-m.majewski2@samsung.com>
	<CGME20240719120945eucas1p2aa5e35f78daa7ec1ea07f512180db468@eucas1p2.samsung.com>

SIMPLE_DEV_PM_OPS is deprecated, as noted next to its definition.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 96cffb2c44ba..9b7ca93a72f1 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1150,8 +1150,8 @@ static int exynos_tmu_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
-			 exynos_tmu_suspend, exynos_tmu_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
+				exynos_tmu_suspend, exynos_tmu_resume);
 #define EXYNOS_TMU_PM	(&exynos_tmu_pm)
 #else
 #define EXYNOS_TMU_PM	NULL
-- 
2.45.1


