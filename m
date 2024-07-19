Return-Path: <linux-pm+bounces-11256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977A0937786
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 14:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A87282F5D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B613C681;
	Fri, 19 Jul 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HwT/Vo2S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93912FB31
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390997; cv=none; b=fDbvCSaOBZPHJJMGh9WPDzWIJpfmgqj7Gc+BguZ79CwnH9T6mKQzF6d+4V+crIJ/1fMXgRh8m3nRDEvYFcbvSPt+SihGqViL70cRnIMyE737psGB47sICDZV0OtbL4WG42KPpciL0Wzf8ga42fQZ9ySswVP6KOUdtmHX+/iM7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390997; c=relaxed/simple;
	bh=BFN3rmh75N5S4hD0Ue1CL+TfLuFH4oAujI9DOxMtYv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=CaxvRTdxv413XvnsyWd1MooUWykYgG/IPnwqgnGpqsbmS78psHYoJ+WWh2TfoR829JRn230mzfRZJgs7hphhGh4q0uv7tJ53CWOqsb4cxRsiZtdggkKRSzRv7pLAXRymWlLu92deLGcM95Kx7yYCVi5+23vGzNUxjTPRbZq6Yn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HwT/Vo2S; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240719120946euoutp013562c6009b8b4ebc1c4558e62301855d~jm-tvye2k1221712217euoutp01W
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240719120946euoutp013562c6009b8b4ebc1c4558e62301855d~jm-tvye2k1221712217euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721390986;
	bh=vpkrpEnmEeMaFik8gd0x3hxK8VWARpcSqM6nm7oQyaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwT/Vo2Sf0IHxfOTEFdTRWS/L0yO3pFwJNK25KQzEL/YrHQL8WMvM5TXzJgvXF2Yj
	 QuX64y7gCjFV9P21kH9GwEzLBBFIjzfnRXVZI0PgqrLA4+CLWlSmewVPu6n/sT/FHm
	 Ciksv6WaQnCHFiMRNun8PEH0sicVepma7hwtqhz4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240719120946eucas1p19396f95d8fa006fb7ce82e03381a58f8~jm-tT4Skv2886728867eucas1p1N;
	Fri, 19 Jul 2024 12:09:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 87.81.09620.A875A966; Fri, 19
	Jul 2024 13:09:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120945eucas1p16058905c95c92840679831ae3383a67a~jm-s7QLFA0450904509eucas1p1h;
	Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240719120945eusmtrp10f6e5e1aa5c8885eb92426bc84ed2ea5~jm-s6V9rd0596405964eusmtrp1Y;
	Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-fc-669a578a9c8c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.EF.09010.9875A966; Fri, 19
	Jul 2024 13:09:45 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120945eusmtip1cb678cde0b3c8309247f1c6180a476c6~jm-sEoZ0r1464214642eusmtip1K;
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
Subject: [PATCH 2/6] drivers/thermal/exynos: use tmu_temp_mask consistently
Date: Fri, 19 Jul 2024 14:08:46 +0200
Message-ID: <20240719120853.1924771-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240719120853.1924771-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87pd4bPSDGb/5bN4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oLpuU1JzMstQifbsEroyL8w4xFnzmquh78JWtgXEqZxcjJ4eEgInEolmbmbsYuTiE
	BFYwSkw/PIkJwvnCKNEyaQcrhPOZUWLShL0sMC3v5q9lArGFBJYzSjx8xwFR1Mok8f/eU1aQ
	BJuAgcSDN8vYQRIiAosZJRp/vAMbxSwwiVni4JqFYFXCAt4S9y//YgexWQRUJe5t7WMEsXkF
	7CQW3DzCBLFOXqJ3fx+YzSlgL/G76S0bRI2gxMmZT8BOYgaqad46mxmivptT4tbxQgjbRWLy
	ZZi4sMSr41vYIWwZidOTe6DeyZeYsfk9kM0BZFdI3D3oBWFaS3w8wwxiMgtoSqzfpQ9R7Chx
	8sYcNogKPokbbwUh9vNJTNo2nRkizCvR0SYEUa0qcXzPJKj10hJPWm5DveQhMefOXtYJjIqz
	kHwyC8knsxD2LmBkXsUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGY0E7/O/51B+OKVx/1
	DjEycTAeYpTgYFYS4fX7NjNNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6Yklqdmpq
	QWoRTJaJg1OqgcnJ06vg3rosp0L31EDPm6JSC+r3dDvHNr532bw4aGO2zSIVqc+O9zf4nr63
	9X0Od8HH5Kxei1vap47du2jSXiATsKtkyxeX73a5daLT5J0dXwoc+HCicZHThFkXHdnX8eXJ
	a7q2WInsitum8vZd1fXZYTN+v7p3q1pYOHtlY7S0YW7oIsV5YjcZCzxEdy9fK72u8hjD47br
	ex+zCUSUuTN9KjIIfVB+yYxD7wb/1zbdq1VKq5q9gy7sNVy3JXXWQgMj2zcTKswuf7I+yrNJ
	3uYYg/CfBZwPv+tz9DMo+HBub2JYueDBi6sMmd7Pvvizy3W7z9s+TykytzHkV8VWWw3epRtC
	drOf2CO46+L3DCWW4oxEQy3mouJEAF8DLbXXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7qd4bPSDO480rN4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
	vYyL8w4xFnzmquh78JWtgXEqZxcjJ4eEgInEu/lrmboYuTiEBJYySqx7N40JIiEtcfjLFHYI
	W1jiz7UuNoiiZiaJ/bdWs4Ik2AQMJB68WQZWJCKwnFFic7sHSBGzwCxmid5TUxlBEsIC3hL3
	L/8CK2IRUJW4t7UPLM4rYCex4OYRqG3yEr37+8BsTgF7id9Nb9lAbCGgmp0f57FB1AtKnJz5
	hAXEZgaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbgtmM/
	t+xgXPnqo94hRiYOxkOMEhzMSiK8ft9mpgnxpiRWVqUW5ccXleakFh9iNAW6eyKzlGhyPjAF
	5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MKmozJm0cuuHgh2a
	xyx6E2/eidj/cMLZ2YW1ExctK/pfVJF/Z5FWulh9UH4Nk+TjIzPb5bv95k83sXScbzyDjc/9
	/NE994R5twit37nuwU32vMBgS6WdihcOx7GmMNauritSU/udZXfsl9WD008n7N3GJ+nkZCef
	JbdKst3ybqSlwv6FLrOX39yueeJ7dkfdX5fge6wTTlgXFrpObt5xIGJVUo6WTFQ5Q8fyeptb
	dbsdjDr8f7Psnr91reGP5nvb/Q3rg5vzZ8nJhZqXf3z37HvNpsRvmQzqFzoabM+f1vP5d2iN
	cuMDRq45OZvPLGya9Hdr5OT1ZdJ752dms13i/tf9JqRwx83KIs7Hq7VWbVJiKc5INNRiLipO
	BADUi6eXSQMAAA==
X-CMS-MailID: 20240719120945eucas1p16058905c95c92840679831ae3383a67a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240719120945eucas1p16058905c95c92840679831ae3383a67a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240719120945eucas1p16058905c95c92840679831ae3383a67a
References: <20240719120853.1924771-1-m.majewski2@samsung.com>
	<CGME20240719120945eucas1p16058905c95c92840679831ae3383a67a@eucas1p1.samsung.com>

Some of the usages in sanitize_temp_error were missed, probably because
the boards being used never actually exceeded 255 in their trimming
information. This is needed for Exynos 850 support, which uses 9-bit
temperature codes.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9b7ca93a72f1..61606a9b9a00 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -237,17 +237,17 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 
 	data->temp_error1 = trim_info & tmu_temp_mask;
 	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
-				EXYNOS_TMU_TEMP_MASK);
+				tmu_temp_mask);
 
 	if (!data->temp_error1 ||
 	    (data->min_efuse_value > data->temp_error1) ||
 	    (data->temp_error1 > data->max_efuse_value))
-		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
+		data->temp_error1 = data->efuse_value & tmu_temp_mask;
 
 	if (!data->temp_error2)
 		data->temp_error2 =
 			(data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
-			EXYNOS_TMU_TEMP_MASK;
+			tmu_temp_mask;
 }
 
 static int exynos_tmu_initialize(struct platform_device *pdev)
-- 
2.45.1


