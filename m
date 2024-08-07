Return-Path: <linux-pm+bounces-11968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FDB94A366
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0CE1F216A2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8F1D27BD;
	Wed,  7 Aug 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cSPqMXr5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FB1D1755
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020563; cv=none; b=aSNzwp5xQHQwsUsvlQBr5d1IUSg27F+nKFctbxq9BAWTk4EiN/H5L9FpqI16ydCeWo3cq0pg1d/fq7YcgXMDoegbLCxqFsa2ddv7Z/YoLrY//JE5zXuBGiCOKipSgMkNXhkpLg5A1wUIvvsiaYmmCsekQnbhmCnQpQtzAOfjQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020563; c=relaxed/simple;
	bh=6zp2AKjGs39uCt5CueCwmJOX3eOvD7ilpXgKjzFAtWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Md2QEkQY91vLz39V2Wfv8eZ+ZOP2Djonp5gBVrii+yZtgdj/gd7UchcNgUzTxE0tqdxslM/osxzT0rAId+RHdaRrLyyLmNFeIwwfPrPtxqbFbsx94s/ni5PvbaxtmGIhsRNfDcLKbP9cNg0Exzc4hQ/6I/WPSyjQ15zHvbQt0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cSPqMXr5; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240807084918euoutp0224928a0a11c9c5633de347b3e0aa5cfd~pZhG4qQLP3051330513euoutp02H
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240807084918euoutp0224928a0a11c9c5633de347b3e0aa5cfd~pZhG4qQLP3051330513euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723020558;
	bh=qLPy4vqwS3UYK5ED/m7wWzuPP6EHMShGRR/7bXdjUuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSPqMXr5GxOfRCUdfrByGOCJFqIOyT4Mi1m7RPaqXRjGZyiLU33shMPb7x5+CP96Q
	 N+ARd9OaCcSbIKLta1edj6x/RfykDkE94biqQWDdUmGl6skgXvfUOguokJBZQ/end0
	 e43t00TYryewiZEd6wwP+3HlQh9V5LzJew7qsIEM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240807084918eucas1p2983c6169f3c321294ad5738d1e5ff21f~pZhGm6y3T2755327553eucas1p2K;
	Wed,  7 Aug 2024 08:49:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 65.6D.09875.E0533B66; Wed,  7
	Aug 2024 09:49:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084917eucas1p28c675c9da74f0de0bb09689819202c39~pZhGCjcHV2756427564eucas1p2V;
	Wed,  7 Aug 2024 08:49:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240807084917eusmtrp16e830202fa79ded18448cca1cfa911ab~pZhF_hFIP0287102871eusmtrp1a;
	Wed,  7 Aug 2024 08:49:17 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-a7-66b3350e5b33
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.01.08810.D0533B66; Wed,  7
	Aug 2024 09:49:17 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084916eusmtip225c4b7cc8c78e2c81c1b8f555d8dab3f~pZhFAmDNl1786617866eusmtip27;
	Wed,  7 Aug 2024 08:49:16 +0000 (GMT)
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
Subject: [PATCH v3 6/6] dt-bindings: thermal: samsung,exynos: remove
 driver-specific information
Date: Wed,  7 Aug 2024 10:48:25 +0200
Message-ID: <20240807084829.1037303-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240807084829.1037303-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87p8ppvTDPZ9FrF4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CV8f7WXaaCPt6Kr0+9Ghifc3UxcnJICJhI
	rJ/xnqmLkYtDSGAFo8SLjpPsEM4XRokFdxuZIZzPjBKbX25l62LkAGuZOCUHIr6cUaJhwSOo
	9lYmiT9v7zCCzGUTMJB48GYZ2CgRgcWMEo0/3rGCOMwCT5glfr5aDFYlLJAk8fR2AzuIzSKg
	KvG/rY8FxOYVsJPoOPyHCeJCeYne/X1gNqeAvcSS7m4miBpBiZMzn4DVMwPVNG+dDXarhMBk
	TonOc7ugml0kzt/9xQJhC0u8Or6FHcKWkTg9uQcqni8xY/N7FojfKiTuHvSCMK0lPp5hBjGZ
	BTQl1u/Shyh2lOh6uIMJooJP4sZbQYgD+CQmbZvODBHmlehoE4KoVpU4vmcSM4QtLfGk5TbU
	WR4SG9ZcYJzAqDgLySuzkLwyC2HvAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFJ
	7vS/4192MC5/9VHvECMTB+MhRgkOZiUR3ubwTWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT
	5FOFBNITS1KzU1MLUotgskwcnFINTGVRxgwSsdzMmaKCP3pi9nVsfXQjulT69jRRRVb7RVOE
	vBXKnYWNFy/Ki7+uLSn4Krs43mtSy2P155P+L13VNzW8Nur1gTVGP3l502JLu8QtOM4WRaxl
	jS4rVJ3jJ/tltdcnv90vKtUnrY86zrbl/uYgxuCwr2wSv2JsLR7ESBpNOLJ15v2ThQ903b9a
	7m58d1RuVuj81TVK4hdM6lOFGV5a32Y4v6PBetbMPns+bfN3YkdbhS/Hhm8WMpScIbMsLPnH
	QoG2K51+AUk7vYUOb5u13TLmvUXBvKrn3at8ytoqv11jnsXiPmX6bh0v1rj938KOme1aeHG6
	tCBn3czMj3or/b21XZe1SmS6sDYpsRRnJBpqMRcVJwIAtkV1VeEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7q8ppvTDA5eV7N4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CX8f7WXaaCPt6Kr0+9Ghifc3UxcnBICJhITJyS08XIxSEksJRRYsffdUxd
	jJxAcWmJw1+msEPYwhJ/rnWxQRQ1M0msbH8IlmATMJB48GYZmC0isJxRYnO7B4jNLPCOWaL9
	vB+ILSyQILHxXS8biM0ioCrxv62PBcTmFbCT6Dj8B2qZvETv/j4wm1PAXmJJdzeYLQRU0/tl
	JzNEvaDEyZlPWCDmy0s0b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
	NzEC43HbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd7m8E1pQrwpiZVVqUX58UWlOanFhxhNge6e
	yCwlmpwPTAh5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MemEf
	nO6Z6Qme19wmGzjLfI7pm4iDNkUf3518m9g3rS5FhMvtZmBEQJ9RbIrvsYzV6+8zJFxYcPfo
	hsVeTaK6JjuYxc83OnNNuOF5e5LM/L5Hv/zKKvp/Na8oD94xY1eJ3hmlKf8f2b9+avMrptCS
	Sbjuq+fRgPkL7JoyP6Q+N8haKnJ30srJ86p5LplM3lVxMmPm5vzkJ+wNCeoy190/HV2+1e1j
	57WZN6zX8x5zS//PwRKjEbzw5Lao/LYa+SSxfQsCdi97tnqZtumfXUvn8R+udTuj0/2D41Uh
	+8mLC72Y3LctuLr405JTzzxuTXecdnJ75acKL4GI23LX94cZ/xOf/VQkKNh69bPsqXWpTEos
	xRmJhlrMRcWJAIRJbWdQAwAA
X-CMS-MailID: 20240807084917eucas1p28c675c9da74f0de0bb09689819202c39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240807084917eucas1p28c675c9da74f0de0bb09689819202c39
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240807084917eucas1p28c675c9da74f0de0bb09689819202c39
References: <20240807084829.1037303-1-m.majewski2@samsung.com>
	<CGME20240807084917eucas1p28c675c9da74f0de0bb09689819202c39@eucas1p2.samsung.com>

The number of supported trip points was only limited by the driver
implementation at the time, which mapped each trip point defined in the
devicetree source file to a hardware trip point. An implementation that
does not have this limitation is possible; indeed, that is how the
driver works currently. Therefore, this information should be removed
from the bindings description, which are meant to be independent of
the details of the driver implementation.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
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
2.45.1


