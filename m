Return-Path: <linux-pm+bounces-11965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B394A358
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0411C24321
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE901D0DD1;
	Wed,  7 Aug 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vRHHJDRY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E41CB325
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020558; cv=none; b=eO1o8e9y/BvnvfR+yo14thLgYIKJ2qqwX4P84CWWXrExthr/V1618ksQX4Nol3D4sd8v9MlmdcSG5FQE+0yOP1AvF87RV0FQ7zRLJ2HQOIwjN793zgy4kxpf99o8U9IDsUfJULThKdqX+MtaVdEd5RVAzUO23XV8Ffoc6bIlVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020558; c=relaxed/simple;
	bh=yv9uVaTacL7z+fYBHLxQtNpsQcrLOb9EJvfryrwkLwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=nNTYLqkxhIPCIjBCiqRsJAWGiEGkLLbrLgC2v8Kq9YqON8PdB17UrrYfsBGFSFwcmfu2nNkqtMmIzbnpYrHYzz4/bky+fumuMTbnomKs0nvhGyKGl4KfrThJ0F9xkf15SiMzqDbGkjU2Ifj53MgKY1BBiF605vgErnu6VwrHHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vRHHJDRY; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240807084913euoutp0269722e9b40c03c513509de0701743468~pZhCU6l-g3165231652euoutp02X
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240807084913euoutp0269722e9b40c03c513509de0701743468~pZhCU6l-g3165231652euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723020553;
	bh=5wsELEEviwJQsFZ5DJNpJB4cw/iPr7KJRjxHSkMlBYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRHHJDRYvh+fbcCAtR/0F+kAcuu1YzShmPtRZhEcabmesCf8plzMMgpn+KNRJUWa9
	 tMdb44fGss3jm0lBFKpajQXtXZLR2x46KTCleKgs7LW5lOpEdr1B28g6MgyutBtt0e
	 oHWeEFxjSM5gisEQlAUNj3o23lMlLhSgH/3+Hd2A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240807084913eucas1p1e697ebbfbc4f8d624aca443af1dcf46f~pZhBzbo9E2070720707eucas1p1P;
	Wed,  7 Aug 2024 08:49:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id DB.02.09624.90533B66; Wed,  7
	Aug 2024 09:49:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084912eucas1p20af043b96b6d741a0c7d7ae36efe5ac5~pZhBZLkTm2538325383eucas1p2p;
	Wed,  7 Aug 2024 08:49:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240807084912eusmtrp2364066f1788ca33e808c4e54b006ef3d~pZhBXaoDr2319723197eusmtrp2d;
	Wed,  7 Aug 2024 08:49:12 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-29-66b33509e903
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.01.08810.80533B66; Wed,  7
	Aug 2024 09:49:12 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084911eusmtip235da50f51f8113a83e734e05da542ba2~pZhAdxbIX2807028070eusmtip2S;
	Wed,  7 Aug 2024 08:49:11 +0000 (GMT)
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
Subject: [PATCH v3 3/6] drivers/thermal/exynos: improve sanitize_temp_error
Date: Wed,  7 Aug 2024 10:48:22 +0200
Message-ID: <20240807084829.1037303-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240807084829.1037303-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87qcppvTDGZf5bJ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVcW5uM3vBdOmKi5unMjUwHhLrYuTgkBAw
	kVi0pKiLkYtDSGAFo8TSVWfYIJwvjBInOhczQjifGSUu7jzP2sXICdbRtv0eVNVyRonzx76y
	QzitTBI/f39gB6liEzCQePBmGVhCRGAxo0Tjj3esIA6zwBNmiZ+vQAZzcggLeEvca5rFAmKz
	CKhKNP+YwwJyFa+AncT3yzkQ6+Qlevf3MYHYnAL2Eku6u8FsXgFBiZMzn4C1MgPVNG+dzQwy
	X0JgOqfEskfHoG51kdi2axE7hC0s8er4FihbRuL/zvlMEHa+xIzN71kgoVEhcfegF4RpLfHx
	DDOIySygKbF+lz5EsaPE1s2P2SAq+CRuvBWEOIBPYtK26cwQYV6JjjYhiGpVieN7JjFD2NIS
	T1puQ630kLj0dgPLBEbFWUhemYXklVkIexcwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P
	3cQITHKn/x3/tINx7quPeocYmTgYDzFKcDArifA2h29KE+JNSaysSi3Kjy8qzUktPsQozcGi
	JM6rmiKfKiSQnliSmp2aWpBaBJNl4uCUamCq04xetPCcsu3Eq0YxcwzvFxy+967edo9r87vq
	3dFn4kMldU0XzX284IUe/10hvg1rNI9vm/no1jeVOR+D5pYUu3MvN+iM3bfsba778Sr5N9db
	lGVVt7snKIi+/Lyv5Z7aW+aJmd4S+1g+X78hmpextiORfav37adK5rs/C8/dE9l+7CaX+8xS
	hbnNYk8uTD4ZeHHHY2tTbjsx9qtMt/Y9/hfSxtvq/Wrfv9Cm/ev3vTv/6uGx+88t00pbT37Z
	KtPoInD8Rm1ki3LUbS5lHRvx17/ZrOZ9T/9wz1Xh527pI7o1JnwPvzfqTxZ02d4T3dway++S
	c+HSdEXnMvHNrJbtXp4VbZE+/MeffGyZ/vqfEktxRqKhFnNRcSIABNK/BOEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7ocppvTDFa907V4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXcW5uM3vBdOmKi5unMjUwHhLrYuTkkBAwkWjbfo+ti5GLQ0hgKaPEscfz
	WCAS0hKHv0xhh7CFJf5c64IqamaSePzsIhNIgk3AQOLBm2VgRSICyxklNrd7gNjMAu+YJdrP
	+4HYwgLeEveaZoENZRFQlWj+MQfI5uDgFbCT+H45B2K+vETv/j6wkZwC9hJLurvBbCGgkt4v
	O5lBbF4BQYmTM5+wQIyXl2jeOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl
	5+duYgRG5LZjPzfvYJz36qPeIUYmDsZDjBIczEoivM3hm9KEeFMSK6tSi/Lji0pzUosPMZoC
	nT2RWUo0OR+YEvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphi
	26012stzXjQe6//auPKCgYk1399bEhblAon7FkksObH81/n8Gra0FwlRpoatc6J/ffCd1hvV
	7bvmT8Wm3PC4ZSXvQrSOJj2Tr35az6AUOPHzfbkKq6vSsjfbJr+8rHdlCVdR67KipytzOjVO
	Tr616NwC9VT7m1wSp5+454cbdB5QTNp+/Nvhgz5z3/nbWzNIHZjlteWV4wmjFRxLl+jmKJsc
	VVz+3vh4wEedrzo9Xw0v7m65Mtfxwanf8qJ98l0CHsH2EmfeODkxr50we3Yhn0PxSfFHqxZP
	X71L4GkXZ2lpd2fJHq4LuSo8AW/62ibszlrc1/24eJKphHLupNtHL++59XWrxcdnDasY1usp
	sRRnJBpqMRcVJwIAysa3+FEDAAA=
X-CMS-MailID: 20240807084912eucas1p20af043b96b6d741a0c7d7ae36efe5ac5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240807084912eucas1p20af043b96b6d741a0c7d7ae36efe5ac5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240807084912eucas1p20af043b96b6d741a0c7d7ae36efe5ac5
References: <20240807084829.1037303-1-m.majewski2@samsung.com>
	<CGME20240807084912eucas1p20af043b96b6d741a0c7d7ae36efe5ac5@eucas1p2.samsung.com>

There are two minor issues regarding this function.

One is that it attempts to calculate the second calibration value even
if 1-point trimming is being used; in this case, the calculated value is
probably not useful and is never used anyway. Changing this also
requires a minor reordering in Exynos5433 initialization function, so
that we know which type of trimming is used before we call
sanitize_temp_error.

The second issue is that the function is not very consistent when it
comes to the use of Exynos7-specific parameters. This seems to not be an
issue in practice, in part because some of these issues are related to
the mentioned calculation of the second calibration value. However,
fixing this makes the code a bit less confusing, and will be required
for Exynos850 which has 9-bit temperature values and uses 2-point
trimming.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: reworked to change shift instead of only mask and to also fix
  the 2-point trimming issue.

 drivers/thermal/samsung/exynos_tmu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index b68e9755c933..087a09628e23 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -111,6 +111,7 @@
 #define EXYNOS7_TMU_REG_EMUL_CON		0x160
 
 #define EXYNOS7_TMU_TEMP_MASK			0x1ff
+#define EXYNOS7_TMU_TEMP_SHIFT			9
 #define EXYNOS7_PD_DET_EN_SHIFT			23
 #define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
 #define EXYNOS7_EMUL_DATA_SHIFT			7
@@ -234,20 +235,23 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 	u16 tmu_temp_mask =
 		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
 						: EXYNOS_TMU_TEMP_MASK;
+	int tmu_85_shift =
+		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_SHIFT
+						: EXYNOS_TRIMINFO_85_SHIFT;
 
 	data->temp_error1 = trim_info & tmu_temp_mask;
-	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
-				EXYNOS_TMU_TEMP_MASK);
-
 	if (!data->temp_error1 ||
 	    (data->min_efuse_value > data->temp_error1) ||
 	    (data->temp_error1 > data->max_efuse_value))
-		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
+		data->temp_error1 = data->efuse_value & tmu_temp_mask;
 
-	if (!data->temp_error2)
-		data->temp_error2 =
-			(data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
-			EXYNOS_TMU_TEMP_MASK;
+	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
+		data->temp_error2 = (trim_info >> tmu_85_shift) & tmu_temp_mask;
+		if (!data->temp_error2)
+			data->temp_error2 =
+				(data->efuse_value >> tmu_85_shift) &
+				tmu_temp_mask;
+	}
 }
 
 static int exynos_tmu_initialize(struct platform_device *pdev)
@@ -510,7 +514,6 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 	int sensor_id, cal_type;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
-	sanitize_temp_error(data, trim_info);
 
 	/* Read the temperature sensor id */
 	sensor_id = (trim_info & EXYNOS5433_TRIMINFO_SENSOR_ID_MASK)
@@ -532,6 +535,8 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 		break;
 	}
 
+	sanitize_temp_error(data, trim_info);
+
 	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
 			cal_type ?  2 : 1);
 }
-- 
2.45.1


