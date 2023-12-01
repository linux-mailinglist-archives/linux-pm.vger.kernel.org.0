Return-Path: <linux-pm+bounces-602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC08007AD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 10:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A5E1C20EFD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117E41F61D;
	Fri,  1 Dec 2023 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sHcYRry+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40401717
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 01:56:47 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095646euoutp023f0cf008cef98d1d184e87e8c08f6653~crKpR71fJ0691406914euoutp02u
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 09:56:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231201095646euoutp023f0cf008cef98d1d184e87e8c08f6653~crKpR71fJ0691406914euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701424606;
	bh=dXf9wUUf5w5y7OBV4KeN+1ChCSvq94K/h1PmwKd1DP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHcYRry+brrCuAAtjl66Uf683HSsLz/s9LocpmtVvanQklbKQhxMkaSHwemQi+qYr
	 O2i97//VaUQdau7I3ytHcciJsSICNPFt0Ox+rRWe/uKZB+3AN3QOeW+wqDXjXWFoke
	 4C/tK1HggFeECQgI09AHlO8cwhn8vk7RtFVpGSa0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231201095646eucas1p28e2e345ff39006fbd3e1a9f94ee3172b~crKo02P5x1611916119eucas1p2I;
	Fri,  1 Dec 2023 09:56:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D8.FF.09552.EDDA9656; Fri,  1
	Dec 2023 09:56:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231201095645eucas1p2fa7ecbd8c5ea09908c304a395f0672cc~crKoTef9f3114831148eucas1p2K;
	Fri,  1 Dec 2023 09:56:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231201095645eusmtrp154ad233b70b9931a7616d6e36bd2e33f~crKoSyjrV0759907599eusmtrp1C;
	Fri,  1 Dec 2023 09:56:45 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-8f-6569adde859a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.20.09146.DDDA9656; Fri,  1
	Dec 2023 09:56:45 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231201095644eusmtip2e54bf6dd0a189b17138a3bb6282d2918~crKnZL3GY1179711797eusmtip2A;
	Fri,  1 Dec 2023 09:56:44 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>, Alim Akhtar <alim.akhtar@samsung.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Lukasz Luba <lukasz.luba@arm.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH v6 6/9] thermal: exynos: stop using the threshold mechanism
 on Exynos 4210
Date: Fri,  1 Dec 2023 10:56:22 +0100
Message-ID: <20231201095625.301884-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87r31mamGmxaxmnxYN42NovD8yss
	pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
	1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
	85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mr4c+YbW8FK/oqJLyezNTC+4+li5OSQEDCR
	WHtlBUsXIxeHkMAKRomHT/8zQzhfGCVeTn/LDuF8ZpT4tfEmK0zLpd47UC3LGSU+XrvACOG0
	MknsOrSAEaSKTcBA4sGbZewgtohAK6PEzCZ1EJtZYCGLRMu/XBBbWCBG4uXcyWBTWQRUJe4/
	XQhkc3DwCthKrNiUCrFMXmLPou9MIDangJ3E/EOtLCA2r4CgxMmZT1ggRspLNG+dzQxRP5tT
	YvouPgjbReLGraVQRwtLvDq+hR3ClpE4PbmHBcLOl5ix+T0LyFoJgQqJuwe9IExriY9nmEFM
	ZgFNifW79CGKHSV6/25lhKjgk7jxVhBiP5/EpG3TmSHCvBIdbUIQ1aoSx/dMgjpLWuJJy20m
	CNtD4sa0aawTGBVnIflkFpJPZiHsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw
	vZ3+d/zrDsYVrz7qHWJk4mA8xCjBwawkwnv9aXqqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7V
	FPlUIYH0xJLU7NTUgtQimCwTB6dUA5OmSkgix5ZfGsu3lU6fpqcv1HTr38J3C1pfBn/MPyiv
	Uam8mTHn6Y577xRdldZPUpjcpBeVcev74Y4H/sHL1n8oFjPZufyz+H2neMOgi/+NuvR0DYx2
	Xv64/llO18UWnT3/LsomXbwes/P5KYnyi+/1MuxPnhK/+8tBQKXzQ4340rIAxjMCF0qspLW+
	iF2SSt4ZkdBy66PXykk3eNdvyWw+mVq49lusqttWpuq4X3/98m8rnPDkKtkm3MWfN+/J5T0C
	maGnVEw2bpm2ctcx76+5G7+bNiaaRR1j8+TSzt/A9m37F8P50u/u+0U/2TTLQv7DC6v9hz+E
	PLx94NIKCSZpbgMdxe1TYotO7BdW0z6vxFKckWioxVxUnAgAmb9xld4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7p312amGrxYoWrxYN42NovD8yss
	pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
	1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
	85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
	Sc3JLEst0rdL0Mv4c+YbW8FK/oqJLyezNTC+4+li5OSQEDCRuNR7h6WLkYtDSGApo8SZ4y+Y
	IBLSEoe/TGGHsIUl/lzrYoMoamaSuDxzFwtIgk3AQOLBm2XsIAkRgU5Gia7N55hAHGaB1SwS
	x/Z9BxslLBAl8Xf2aTYQm0VAVeL+04WsXYwcHLwCthIrNqVCbJCX2LMIopxTwE5i/qFWsAVC
	QCVdW/4zgti8AoISJ2c+AYszA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL
	89L1kvNzNzECY3LbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd7rT9NThXhTEiurUovy44tKc1KL
	DzGaAp09kVlKNDkfmBTySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4
	pRqYWDa6P9/aMOVvSkQk41aLONmDphnxf/d7Hqt8umYTY/CqcOEjE+zvCHktkYtYs1VvV4aV
	foiDydyLV4+acM+LuXBJw+BbdrvZfNHOKxvFLzz8dqma2W/D/L//p9sFr9XYPu/0i6yGh/r1
	0ZrbfmnZRS/Y/0f4OHOkFP+/5InGVxmDdH9HnWLcxrq4Njd/w27Lpi4F1m/bonurNyybqvb3
	8yV362ctZWznti/8yO3Ffm7q9GzPVY49i0/9EbTf+ymZbwq37NPr7IZn91eLr/2wrOh5pR/L
	q+5d69KuXQ7WcZ7cu2ramd8nYxZahkutFPnx6WDajMceQcn8z3amsf1Njdm/KYgx93JcRN4R
	1Ttz/ZRYijMSDbWYi4oTAQb1MbZSAwAA
X-CMS-MailID: 20231201095645eucas1p2fa7ecbd8c5ea09908c304a395f0672cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095645eucas1p2fa7ecbd8c5ea09908c304a395f0672cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095645eucas1p2fa7ecbd8c5ea09908c304a395f0672cc
References: <20231201095625.301884-1-m.majewski2@samsung.com>
	<CGME20231201095645eucas1p2fa7ecbd8c5ea09908c304a395f0672cc@eucas1p2.samsung.com>

Exynos 4210 supports setting a base threshold value, which is added to
all trip points. This might be useful, but is not really necessary in
our usecase, so we always set it to 0 to simplify the code a bit.

Additionally, this change makes it so that we convert the value to the
calibrated one in a slightly different place. This is more correct
morally, though it does not make any change when single-point
calibration is being used (which is the case currently).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3bdcbab7466f..d918bf6d5359 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -343,20 +343,7 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
 					 int trip_id, u8 temp)
 {
-	struct thermal_trip trip;
-	u8 ref, th_code;
-
-	if (thermal_zone_get_trip(data->tzd, 0, &trip))
-		return;
-
-	ref = trip.temperature / MCELSIUS;
-
-	if (trip_id == 0) {
-		th_code = temp_to_code(data, ref);
-		writeb(th_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
-	}
-
-	temp -= ref;
+	temp = temp_to_code(data, temp);
 	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
 }
 
@@ -371,6 +358,8 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
+
+	writeb(0, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 }
 
 static void exynos4412_tmu_set_trip_temp(struct exynos_tmu_data *data,
-- 
2.42.0


