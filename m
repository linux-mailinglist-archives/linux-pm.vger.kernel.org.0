Return-Path: <linux-pm+bounces-11963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96B94A34D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 10:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536D7283A0C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC25F1CB327;
	Wed,  7 Aug 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kA20FZQz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626951CB326
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020553; cv=none; b=EBcRIII2zQMjkr1O8p4/RGXbC+8xCLEBDZ06K0cUTKVBlpN3e4za8KIBZBZ46hbEItPJfPzu9dYxCbl9rfEwtXiz3AMN95kFhDXfsqkahnTpvSIJEi0rPESQEbq3AJDpMeQA755p8GQXqp0tke1WT42EOfG5sIGVYU+LQ2Jnd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020553; c=relaxed/simple;
	bh=G8SGnQGahIJiAKPyeQeKvQveyR8NwK/8b3eWpshYTq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MOE/5BsYlT7IL56z8eCZOKRgpccH0RhR0ta8QBPKVHjjuD0I2aDHvnbyf0BsOBqr5ooS3yq05SnQmfJEClTR5YbhKyBtothukfxgTLLO2siBE6EYUqm3edejR8Cbm8Hv+Y2nitbZqO5NRDLcDeconN8RLTuAsQNMMirew4U5+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kA20FZQz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240807084909euoutp01845ff8c12c7eaf66a0e683c7285575cf~pZg_o1Uf01585615856euoutp012
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240807084909euoutp01845ff8c12c7eaf66a0e683c7285575cf~pZg_o1Uf01585615856euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723020549;
	bh=yj+6WZo4Jh1Ovyod4LsdDGfLEkdyiOxcrU/H1erGQ2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kA20FZQz+1+QoF/RH07cKUO5pEIsqZEC1XjBnpKTU3lWLU6RCZUBtYHXEZgb0bz5n
	 Nkx1JWNf+RgdNKkB2N9XgzdIP2sf1V1GwZyrCcYlEcknsciE89oMx35GAnAmP/1MOh
	 /oPidou/rBtq4jIwrch79heZ6AsvBmcBQvH+3iFQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240807084909eucas1p1d463dbd9ead83fabf04376b5018fb323~pZg_LcMxE2890828908eucas1p1z;
	Wed,  7 Aug 2024 08:49:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C7.02.09624.50533B66; Wed,  7
	Aug 2024 09:49:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084908eucas1p29e812ce79d4ec06427bc699321dec3a7~pZg9yLD-o2798127981eucas1p2R;
	Wed,  7 Aug 2024 08:49:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240807084908eusmtrp2bdd511b9a98ee75fd2361c7af6827957~pZg9xaURk2292322923eusmtrp2i;
	Wed,  7 Aug 2024 08:49:08 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-19-66b335053e6a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D4.DC.09010.40533B66; Wed,  7
	Aug 2024 09:49:08 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084908eusmtip2ae4fb7d14ed3e5bb642bc123124fc43b~pZg84rafV1786617866eusmtip22;
	Wed,  7 Aug 2024 08:49:07 +0000 (GMT)
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
Subject: [PATCH v3 1/6] drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
Date: Wed,  7 Aug 2024 10:48:20 +0200
Message-ID: <20240807084829.1037303-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240807084829.1037303-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djP87qsppvTDP5tELZ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVsfT0NraCt2wVO1uPsTUw/mDtYuTkkBAw
	kTj1/BBzFyMXh5DACkaJ7dva2SCcL4wShxZdYIFwPjNKHHu0kgmmZfvhB4wQieVAifZeFpCE
	kEArk8TUpYwgNpuAgcSDN8vYQYpEBBYzSjT+eMcK4jALPGGW+PlqMVAVB4ewgI/EolPeIA0s
	AqoS35b9ZAexeQXsJC6/esEMsU1eond/H9hmTgF7iSXd3UwQNYISJ2c+AVvMDFTTvHU22BMS
	ApM5Jb7cPssG0ewicWXOI6hBwhKvjm9hh7BlJP7vnA/1Tr7EjM3vWUDukRCokLh70AvCtJb4
	eIYZxGQW0JRYv0sfothRYubMK1DFfBI33gpCHMAnMWnbdGaIMK9ER5sQRLWqxPE9k6DWS0s8
	abnNBFHiIbHimdMERsVZSD6ZheSTWQhrFzAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/d
	xAhMcaf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8DaHb0oT4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYIo5bSl0UM/e7uXd1Qefc29LedEuLaYnGy531Pzz
	RpHbV99X7tiRdvBqprz8S3+DlP0O5336ZDZmTdrP0R68sPSm4EfpiPvTTQ7PYVDq3fDzyfa4
	jo1vr6TPLzadXuAtF9N8O6j830a/3y1mr7eotJ4+xF8Zd+Jjx/qYpk06rMZLpB+z5WwtFg0/
	EsF59cerkP+M3ws6d93pLrp2u707qmzyA5tyK8kMfuMz228mZU+qX2P9+1AgD+87PieJ8x+Y
	ec5VnOv7e2brrFjxBNdfFg9nTywumxRk++VQx4xEf2+/iklG8jdUgritNohryV5YciDjJOs/
	pZZDZqcnTrdXYZL+41Tyc9+2hH+f3FeeiFZiKc5INNRiLipOBABFk5zS4AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7osppvTDA7MN7d4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXsfT0NraCt2wVO1uPsTUw/mDtYuTkkBAwkdh++AFjFyMXh5DAUkaJQzfW
	sUMkpCUOf5kCZQtL/LnWxQZR1MwkMXH1YbAEm4CBxIM3y8BsEYHljBKb2z1AbGaBd8wS7ef9
	uhg5OIQFfCQWnfIGCbMIqEp8W/YTrJxXwE7i8qsXzBDz5SV69/cxgdicAvYSS7q7wWwhoJre
	LzuZIeoFJU7OfMICMV5eonnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKRXnJhbXJqXrpec
	n7uJERiR24793LKDceWrj3qHGJk4GA8xSnAwK4nwNodvShPiTUmsrEotyo8vKs1JLT7EaAp0
	90RmKdHkfGBKyCuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYGI5
	Lbn6zywfRfEzF8QfMj64P0PaRC8hr3c3S8Ce2M21tU/m7j7/VPbohpyHgbt7Upc8nur6yNX2
	ivX0YKVFGrMtv++7ru1t0qKwoiN18p0q+WxlwXfXZ68VC+WO89q5bt5BkxjOxMuJugx6eY8r
	1h9Jmbb1afIVuffZfAfavX8ubM9wmXt60T09QVcVCzGxSZvLBW5Vfd3MZjelVCJs/tbfExkP
	BE0QO++WJHT2ue4WSWmxr+I9tYzGRmbt/UWB4i/PCRhalkfa+h145tsw79mrd3kT7PIOrrZT
	mb7WtnpR6o9g1qf8VfK6bJnT7klKH3Bc6f0jwLDj78E3/T+MTxSGTC9NS+LX351U+fH5TyWW
	4oxEQy3mouJEAFukBFNRAwAA
X-CMS-MailID: 20240807084908eucas1p29e812ce79d4ec06427bc699321dec3a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240807084908eucas1p29e812ce79d4ec06427bc699321dec3a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240807084908eucas1p29e812ce79d4ec06427bc699321dec3a7
References: <20240807084829.1037303-1-m.majewski2@samsung.com>
	<CGME20240807084908eucas1p29e812ce79d4ec06427bc699321dec3a7@eucas1p2.samsung.com>

SIMPLE_DEV_PM_OPS is deprecated, as noted next to its definition.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
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


