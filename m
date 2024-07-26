Return-Path: <linux-pm+bounces-11419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFC93D179
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484042817FC
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433B17A58D;
	Fri, 26 Jul 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IGnFq8Dj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C5145B14
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991706; cv=none; b=dbEijpbyPqIhicpIoYz5qWnXHmkRwnxHlJ5f2vm2bUFcGbevh4Y9f2BJXxkIgCP8bzyMzKYGN94qtM8y8BJSISnww+/bvLRWKff3lx167PHolAvrjUZt/NrHic8kqWT+4vxX63OYzIv1z68IG5u+WXvlCZw+X4hoMRHVMGTfIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991706; c=relaxed/simple;
	bh=Gv0ftQzDJ3EJWBl6xXDHU62sR2UU3NPqgkxGWopDc6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=ABP9Onx9N8tErGVTGSrzSD3YkMZiX3x44lhh0AI6IRi2xR9RxFNXtfQBh1PuD222JiJbuWB1ddvgdSVyn6prQ9iTD15nLv1JavvgwbBy4KmNzgZQGgcenIfsDYj+FXlQcBeYugknSxKjhS/urS8zmfBBP0bKQFpXKb76Wza/eJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IGnFq8Dj; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240726110133euoutp01c44dbe50463d4eb32b92977358a152f7~lvlJuy-2v0353303533euoutp01V
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240726110133euoutp01c44dbe50463d4eb32b92977358a152f7~lvlJuy-2v0353303533euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721991693;
	bh=0E7LtwcPeufFtOSVEEqAZtiyP4gVnHEqxC1AgRNHbFE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IGnFq8Dj6nxalpG/UeEdF+J3LHaLsYYUZY2CCR9o61gHVySy3i4kjotRAn5RPeOIm
	 TJ70QF4sK1Lnnz2RlZWAO0hVJ4pHZi2TAa68LZVHSiFimAsaBQgFfbqYZxQmdQex/E
	 d/59yMpycZeOXll/eKRfe4qnXS22rmr6XfgZN2jM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240726110133eucas1p20a5f1b3649c2ad33197053652596e4aa~lvlJZA9WV2815028150eucas1p29;
	Fri, 26 Jul 2024 11:01:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B0.C8.09875.D0283A66; Fri, 26
	Jul 2024 12:01:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240726110133eucas1p1a20d4fae252520ea6747bc1101c9d59a~lvlJBF5650303903039eucas1p1X;
	Fri, 26 Jul 2024 11:01:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240726110133eusmtrp2bef4f151570af3f9d661eb48217a9019~lvlJAD7xO1722117221eusmtrp2S;
	Fri, 26 Jul 2024 11:01:33 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-a1-66a3820d3710
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id FD.17.08810.C0283A66; Fri, 26
	Jul 2024 12:01:32 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110132eusmtip25fbe6aa06af2249b547bb95285200c3c~lvlIECCRq2391923919eusmtip2e;
	Fri, 26 Jul 2024 11:01:31 +0000 (GMT)
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
Subject: [PATCH v2 0/6] Add initial Exynos850 support to the thermal driver
Date: Fri, 26 Jul 2024 13:01:04 +0200
Message-ID: <20240726110114.1509733-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87q8TYvTDOY0iFo8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLul6nMFv/37GC3ePKwj83ied8+JgdBjzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofN
	Y/OSeo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK2H7oCktBP1fFqwkTGRsY53F0MXJwSAiY
	SLy8YdrFyMkhJLCCUeL4e58uRi4g+wujxJPFx1khnM+MEkf2TGEDqQJpOD73HiNEx3JGiU9H
	RCGKWpkkDqydxwqSYBMwkHjwZhk7SEJEYDGjROOPd2CjmAWeMEv8fLUYrF1YwFuiYVEnM4jN
	IqAqsWrRGzCbV8BOonviFqh18hK9+/uYIOKCEidnPmEBsZmB4s1bZzODDJUQ+MEhcfz4bKgG
	F4m9B/ewQNjCEq+Ob2GHsGUk/u+czwRh50vM2PyeBRIAFRJ3D3pBmNYSH88wg5jMApoS63fp
	Q0QdJW7vqYAw+SRuvBWE2M8nMWnbdGaIMK9ER5sQxGRVieN7JjFD2NIST1puQ230kJi37BEL
	JNRiJV5c2sg8gVFhFpKvZiH5ahbCCQsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIE
	JrjT/45/2cG4/NVHvUOMTByMhxglOJiVRHiX3V+YJsSbklhZlVqUH19UmpNafIhRmoNFSZxX
	NUU+VUggPbEkNTs1tSC1CCbLxMEp1cDkcfRQgFJMxgde+75M6X37eXb8C7+/53VGtYiUrdMt
	ronf30+JtEh/uWHf4bZQ63M9qfF7g5N0a/m5Tf/+3Cf8Y/eN1h8tffdnu/qs43jsGX1OOeiq
	5wbPu2EhWgsT2xyv/b3tYLJa4ec3Fd6Frd+YnimGvyw4WHRnT/z5Kb/TnCx+57tv+HRmuepS
	ea+v+y6XcMdzzbjEcvTYJKPWtQ2XC+v0/PQqFRvn2gZu5K2yi5my+Ld1ar+2s9yjVm7TCYbx
	O5tWzn7mvurLO9+SvNuO5X+ayy2nW/wPmvchNivvYf2l4/dbs77NubOt/rS+4ay9z9a+PO3J
	sXzVrLB2vjWGG4NDbC8yuu/vDLZVm7VWiaU4I9FQi7moOBEA+euU298DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7o8TYvTDD58s7R4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXsf3QFZaCfq6KVxMmMjYwzuPoYuTkkBAwkTg+9x5jFyMXh5DAUkaJQ2v/
	sUEkpCUOf5nCDmELS/y51sUGUdTMJPFyySWwBJuAgcSDN8vAbBGB5YwSm9s9QGxmgXfMEu3n
	/UBsYQFviYZFncwgNouAqsSqRW/AbF4BO4nuiVuglslL9O7vY4KIC0qcnPmEBWKOvETz1tnM
	Exj5ZiFJzUKSWsDItIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwxrYd+7l5B+O8Vx/1DjEy
	cTAeYpTgYFYS4V12f2GaEG9KYmVValF+fFFpTmrxIUZToPsmMkuJJucDozyvJN7QzMDU0MTM
	0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoHJ9st5pkWPDxeHeSaZS69sf3fWxWC7
	81fHC3t/8B/7ndlbEx6mJ3E/KlVvPoOYp/b87onTHr4+Pifrvmz1jXp207zl976E1b+eyDJB
	O/P6u18SGXYXJntkub99ZDXzjpOzztUf/0S3TQs2/7Txifje7ev/ynxx+1h4Tyrrxfr5qZZh
	q/nuTJBtZLDZa8vd99ArZ2aC5pOQh+d5OGQvPH3wZfUErzjPT7utPqjPXbLXXuNYb09GSJHK
	e64t6h8tX17uc5M/F6hucL8vxKt5i/JnR/6rmSsF4qU92SYpvzv+64pr/aOerYarWAoaL9/m
	Te6xSfo3zzDx6QG3QIGidZmRWqnneOasufp52YzySx8dlViKMxINtZiLihMBw7pCXToDAAA=
X-CMS-MailID: 20240726110133eucas1p1a20d4fae252520ea6747bc1101c9d59a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240726110133eucas1p1a20d4fae252520ea6747bc1101c9d59a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240726110133eucas1p1a20d4fae252520ea6747bc1101c9d59a
References: <CGME20240726110133eucas1p1a20d4fae252520ea6747bc1101c9d59a@eucas1p1.samsung.com>

This series adds initial Exynos850 support to the thermal driver
together with its requirements (sanitize_temp_error fix, adding the new
string to dt-bindings), while also cleaning up a bit (improving power
management support and removing some outdated information from
dt-bindings).

Changelog:
 v2:
   - Reimplemented to use the Exynos850 TMU clock: removed the patch to
     make the clock optional and changed dt-bindings change accordingly
   - Improved the Exynos850 implementation itself (style and one correct
     register offset)
   - Removed conditional compilation in favor of pm_sleep_ptr
   - Shortened dt-bindings description

Mateusz Majewski (6):
  drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
  drivers/thermal/exynos: use pm_sleep_ptr instead of conditional
    compilation
  drivers/thermal/exynos: improve sanitize_temp_error
  dt-bindings: thermal: samsung,exynos: add exynos850-tmu string
  drivers/thermal/exynos: add initial Exynos850 support
  dt-bindings: thermal: samsung,exynos: remove outdated information on
    trip point count

 .../thermal/samsung,exynos-thermal.yaml       |   8 +-
 drivers/thermal/samsung/exynos_tmu.c          | 219 ++++++++++++++++--
 2 files changed, 199 insertions(+), 28 deletions(-)

-- 
2.45.1


