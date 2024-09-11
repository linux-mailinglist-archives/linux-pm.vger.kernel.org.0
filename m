Return-Path: <linux-pm+bounces-14016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBA975190
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B981F22B85
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A256419C563;
	Wed, 11 Sep 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UVma+JWN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED419341A
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056721; cv=none; b=KkqZ8cBa/ZbOxcicOFpebvi4w4NlyVr+gDu3Vw3y8hQTP+0WiIwag9+FUVyndGKWu5nMBryrtAzQohrv3hkZDA8p9HtfcRtm4T/UVwS5I/Ux2qEf1q2LKwByufTmK8zU/bIwJyhVyJWEpMya+AGhF5RqLZOBIWcwVpNOofyHkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056721; c=relaxed/simple;
	bh=QYuOvbi3yolBODIX0i/1mxP3qBTmhqEHCAIEx2DAgN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=oWzn30Gfjdy3vDT2pO++vlgp7h9aDUQ5EevQAke6b2u43RVv2IHpxsJNzVXk52cPKhW8W6CpD4cuKLX2kx6iH5iqcj3I2QEPlXIuFZGEpCqQayFktnXqjFkVISe0SDYtePvPiBFMxaOgt1Jc+5tihsCu0h2u7N/Slq8cFZ7aGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UVma+JWN; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240911121158euoutp02a8d9c8383eaaf453e9b619fb49ce3583~0L3C7ZIRh3252932529euoutp02i
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240911121158euoutp02a8d9c8383eaaf453e9b619fb49ce3583~0L3C7ZIRh3252932529euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726056718;
	bh=a5aoA1DUV1XIYRXDrlemZ2Dc7B1rAnuJ/1tYUrMlhp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVma+JWNnQAA8QGUksAY4FyXIm2HMYH/n5+hcXP1eQS+tDe1Jhj0NZOzm+hmr0AzI
	 mkNZL97GQ6yOSktlD+bZA1vYMAAIJjIcGVp5FjIUQ/BLlaUvqywOJwRZpSKU9Y4FfH
	 7zOOmEt1YXD1dY9cPXdgW9mK9JRJFRvF2z4CRWB0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240911121158eucas1p282816a798880d1990c3dc3eca36930df~0L3ClV4I62862528625eucas1p25;
	Wed, 11 Sep 2024 12:11:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F4.48.09620.D0981E66; Wed, 11
	Sep 2024 13:11:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911121157eucas1p2a8ff398f0f30f141de974763680bb041~0L3BweUzC1735017350eucas1p2p;
	Wed, 11 Sep 2024 12:11:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911121157eusmtrp2e855c8a04f0574368ccac78e19b0e260~0L3Bvnbmo2708727087eusmtrp2p;
	Wed, 11 Sep 2024 12:11:57 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-84-66e1890d6518
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 0E.E9.14621.D0981E66; Wed, 11
	Sep 2024 13:11:57 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121155eusmtip1732f687d82842f00a1e798253f9d46f6~0L3AkkBZy0956609566eusmtip1G;
	Wed, 11 Sep 2024 12:11:55 +0000 (GMT)
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
Subject: [PATCH v4 5/7] dt-bindings: thermal: samsung,exynos: add
 exynos850-tmu string
Date: Wed, 11 Sep 2024 14:11:28 +0200
Message-ID: <20240911121136.1120026-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121136.1120026-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTZxjA9961d9eOuqOY+AxEsLa6LRvoJMsb3JgbcznIEpeYTLNk024c
	lY0P04ogiQHHRyzB6opIKayKqBDscJRStAOyQldkKEhYbIN2sxsb3zOkMBybY5TTzP9+z/v8
	nq/kZUi5TxzJZGQf5rXZ6kwFJRU5PH8NviLTB9K3Li8m4PsWB4UX7V4CW7sGCWwJRuNz7kEx
	Hhr6hsZd0+00tv16R4xHnHUUDp50I2wa6iZwS+sojeu/KKHxl55KEn/t9tP4q/kqEi93XqPx
	WMBA4XFDN7EzgrNarIi7bvbTXEPnJMHZmvUUd+9OJ8W1XSzkDPZmxAVtG95nPpS+nsZnZhzh
	tfFJB6QHl3ovoEMeSX79pI8uQjfpciRhgE0Aj71ihaWMnG1C0GQyiIRgHsHfrUZSCIIIyqrO
	oyclZ783P040IlgYv0QJQSkBN3o7yJBFsVvh/szl1cZr2QYExx/+IQ4lSLZfBJVXUkMcwe6D
	+R9/W20rYlXgrRpfLZaxSeCfuiEWxsXAsHWcCrGEfRMWpxuR4IRDf82YSOgZA8XttasrAdso
	gYUBHyUUvwPHv5sQCRwBU332x2evh+Xr5wiBc8DU9mDFYVY4H/yuVAF3wNxNMoQk+yJcdcYL
	8lvw4MxpWjDWgG82XFhgDRgd1aTwLIMTZXLBVkFfp5EUOArGSu4SgsJB/a31p9FG81OXmJ+6
	xPz/2POIbEbr+FxdlobXbc/m8+J06ixdbrYm7tOcLBta+XwD//YtXENNU3NxPYhgUA8ChlSs
	lZ1K+ildLktTHy3gtTn7tbmZvK4HRTEixTqZKi2Gl7Ma9WH+c54/xGufZAlGEllEiAxzlNf2
	WsYbPtO2+DO3ZBOjw9Xi94pc7fl1O/d5jLqG3ZcVgaiaZ/ubaH3KlHKXt2DCMhl2YPPV2Xr/
	7Nt5Ru/I87G7io4NKPO2RBIxySc7ZhIrao+FtbxqbQgc+Yy4Pa1JerdDX60qj671TmyayTct
	dbQEHkU7Pyl1meVX6o7ucSXmBDbXVEzvSV6sMzQXOuQW1d2X3d9Wan65mOrY0vbRXFih9tHt
	heAJe+y9BDMa3fu7cqy7Pz2rtPoHZWswtjBcWrChhN1/6QNi5AXnMlrakbKXK3b/k5KoP9U7
	TOQ6N4aF69nyltmCrrJa5c+uPze57PT2vDL4OPm5sw+Ln1GIdAfV214itTr1f69wAwHrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7q8nQ/TDL69ZbF4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38Busff1VnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrNt4i91i
	YVMLu8XEY5OZLdYeuctuMffLVGaL/3t2sFs8edjHZvG8bx+Tg7DHmnlrGD12zrrL7rF4z0sm
	j02rOtk87lzbw+axeUm9R9+WVYwenzfJBXBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjq
	GRqbx1oZmSrp29mkpOZklqUW6dsl6GX8OryIseAYZ8XClzfYGxjPsHcxcnJICJhITDs6i7mL
	kYtDSGApo8T1q6eZIRLSEoe/TIEqEpb4c62LDaKomUli1bQJYEVsAgYSD94sAysSEVjOKLG5
	3QOkiFngKovEoddzWEESwgJhEqubNrCB2CwCqhLXpz4Ha+YVsJO4++oEK8QGeYmLa56D1XAK
	2Et8f72cEcQWAqr5uPEkK0S9oMTJmU9YQGxmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56
	brGhXnFibnFpXrpecn7uJkZgpG479nPzDsZ5rz7qHWJk4mA8xCjBwawkwttvdy9NiDclsbIq
	tSg/vqg0J7X4EKMp0N0TmaVEk/OBqSKvJN7QzMDU0MTM0sDU0sxYSZzX7fL5NCGB9MSS1OzU
	1ILUIpg+Jg5OqQamhVE6qnYH1zgsPCK123WX1DyvadtWrvpwZHdrzDeGU2cKnpdX+aoukNjv
	rr2mqU34+bGTXReE9QT+ie46O1s2YlE+B5vOJe7oQJlVvh3G4fy6nI2KHowd9uXqk/wvmnme
	+lKW3qKsrD1liuNf1e9BjV4msSe2fvrxpZJBS2x1qkzpo/tfDbTrSu10bzP7rjk/t0s7Xlow
	ZcECESG/tD6jj2LJIrXbojb/iM59WsxXXVFsvXarXfSL2B9H5+hdWXotdpv3E+bAUAat+bsf
	xr1bbbvilZXOnLW7fGKW2jUYqc7Z/HYBT1GUw3q9vTmmyTMYJR9rOa9qrjgZ9JJl73u9b69E
	Nt1rVjixvq1orbsSS3FGoqEWc1FxIgC2kcgKXQMAAA==
X-CMS-MailID: 20240911121157eucas1p2a8ff398f0f30f141de974763680bb041
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240911121157eucas1p2a8ff398f0f30f141de974763680bb041
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240911121157eucas1p2a8ff398f0f30f141de974763680bb041
References: <20240911121136.1120026-1-m.majewski2@samsung.com>
	<CGME20240911121157eucas1p2a8ff398f0f30f141de974763680bb041@eucas1p2.samsung.com>

Like most of the SoCs, it requires 1 clock and 1 register.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.45.2


