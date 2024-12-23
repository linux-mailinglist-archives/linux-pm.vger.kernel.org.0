Return-Path: <linux-pm+bounces-19676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD09FAEA8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 13:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CCD1883C92
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DCB1BAEFD;
	Mon, 23 Dec 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FFbRSTkm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C271B21BA
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958585; cv=none; b=WPJpyl6J5xaEUlnpQCYQSjUaz0QK6Mdh0YTnwZzbwmHtTuQWRYgUyBThgQLNq0iDf+uun2KIJNG8B6BGT9Jo7BFyKiPQgQlbJqt9gzRkJwlqZZiVSO54FsaL0xy7ykIZyzzUU+XSJMVvkf1bx5L2MGwJl/wbBHsK9N+aj+7v87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958585; c=relaxed/simple;
	bh=74GQQ1iARGV4ZZF6Ipw2I6AC9+HTNWo1SPXdL5hc2yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=UJeYkx+koNTa+neH33o6HA8K/GiZyeoxm1T2xnMVNmZuc66o4BMHuNk0+nEm5UHSXfkhWNYOtIlh2+yUortdfyM6GjOZ6cgDc5rUjXpXvS+zxK1J5KpCHIFq1HfpTg8SVqRv44C8Nx1VcqXCJ0xE0Y2+KbLL37iLGeFUET2oKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FFbRSTkm; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241223125620euoutp02a3ba2398f52b938409559cd1c4662133~Tz6MWB9Ud0908409084euoutp02D
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 12:56:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241223125620euoutp02a3ba2398f52b938409559cd1c4662133~Tz6MWB9Ud0908409084euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734958580;
	bh=DgeFHCAIbeFBF+0nDHhjAGX/VqaqfX2KAeQLuxONDpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFbRSTkmrBB2xjSfQ5ZUkQvppd2Y5yeUxcoi0NQ+wssspQVkdOVRQSKUmUg1baaYS
	 QFdW8igPioeDZoDewlDn+IaonbpUlB+JwEL4AFGzaa0K0TcyRwrba8u/aI/AXexGzs
	 6GAyHoSsY1OVzCOYQzcTh2iFL5eMDBuV2pd7MCY0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241223125620eucas1p22ec4eecf50867d85ecbffc75512531d4~Tz6L5y41N1249712497eucas1p2s;
	Mon, 23 Dec 2024 12:56:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 09.52.20397.4FD59676; Mon, 23
	Dec 2024 12:56:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241223125619eucas1p1f9c4afd9b4f458ab92750e0526c95581~Tz6LV23GT1526215262eucas1p1k;
	Mon, 23 Dec 2024 12:56:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241223125619eusmtrp1305cc10b48ccbacc2ece9ab38be4a231~Tz6LVG0Hf2059320593eusmtrp1E;
	Mon, 23 Dec 2024 12:56:19 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-a6-67695df4a539
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.04.19920.3FD59676; Mon, 23
	Dec 2024 12:56:19 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241223125618eusmtip2c3abffb1a9d85019fd4b467b1d60676b~Tz6KBDGD90787007870eusmtip2f;
	Mon, 23 Dec 2024 12:56:18 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC PATCH v2 14/19] drm/imagination: Enable PowerVR driver for
 RISC-V
Date: Mon, 23 Dec 2024 13:55:48 +0100
Message-Id: <20241223125553.3527812-15-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223125553.3527812-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xbZRjH855zes6hW+FQiHsd4JCkU0HLhsS9TtQtbubsk9u+kMzM2YyT
	gpaCLZ2CDsa4jEu5TTakg5WNOaDAiNyEZojcWhBWudiCSWFMwa6IMqAQwMCka5379nv+z/95
	/8+TvDQu/J7cTcfIEziFXCILIvlEq2Hd9JrjdIx0X/HaDtQ/fhNDLf9oKFTXYcKQttfEQ1Oj
	zRj6ZWWBRHdmhyn0sCOVQJbqcgqlGRpIZNdMkWhRPcVDY/oyEi3n9QLUupxOovreSQo1rGgx
	dGOxhUC32vQAZWbf5qGRn46iyal+AtnH1DjK1Hihx3fbKLRl+Y5A1/7upFDzfBEPGesjUXpn
	MXHoBXZhIoNi5+12gu3JclBsx2oFwbZrJilW3T4E2EZdNslaLXdJ9vrACfZ+rhFjm26lsOn1
	Bowt2NzHLvxgJtn8Zh1gR9PGqePCU/yIKE4Wc45ThL7zMT/6R/0SFq+nvyia2cQvgEtUDvCg
	IRMOC68ObzOfFjLVAP5uKHEXDgANK2bCVSwD+Gf/+NMRW0ml21UFoLlqwO2aB7DC2kg6XSQT
	BqertDxnw5fJIGBGXypwFjhjA7B1pmzbRdM+zAn4zSOec4BgRLCnbwVzsoA5BKfHJoArbg/s
	7LqHO9ljW6/LcekCxhsOlM4QTsa3PWkt13Dn+5Cp4cOLU4/dw0fgau19994+cM7Y7GZ/OPi1
	mnBxHJxuWcJd/BVsVxvd/Ba0mjae7Ikzr8AGfahLPgxHzE1PZMh4wom/vF0reMLLrSW4SxbA
	rEyhy70XXlHnPQ01VbdiLmbh9VEtVQhe1DxzjOaZYzT/51YAXAd2cSplrJRTvi7nPhcrJbFK
	lVwqPhsX2wi2//bglnGlDVTPLYq7AUaDbgBpPMhX0C2MkQoFUZLEJE4Rd0ahknHKbuBHE0G7
	BKKoPZyQkUoSuE85Lp5T/NfFaI/dF7AWQCdHJ1z5bePBtzWNi4pAP9MnpW17h4IrLyUf6ZN2
	KOMsB5Wlso0Cv62XVu2JvuYP5RvnUh23sy7SP697/jFXVmsthJaR3qaEdf1ObaI2MnR2x/Cr
	b3/Qu2E96f/QkfZyXrLXRJLn8vn3Dgj1wZqu4/05Oktmbg/Y+aBBGiEO7BLZPA+mGjbvFdcd
	jpgN5EI/UwWIwgOevxG/qLOPZTYZf1U9Wq2fP2p+biipyWZbyynKb+4vLz+rSMkdqDkQ8FF4
	6umQd48VyGt9agpCVCOTS5e90s+IUyoH76C198Wy6JA3JkoUomyu29+azEQeC58My/dGb0p0
	X9r2V0JF2KnzQYQyWrI/GFcoJf8Cv0iVrkoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsVy+t/xe7qfYzPTDZ5M1bA4cX0Rk8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFlc+fqezWLd0wvsFi/2NrJYXFsxl92i+dh6NouXs+6xWXzsucdq
	cXnXHDaLz71HGC22fW5hs1h75C67xfqv85ksFn7cymKxZMcuRou2zmWsFhdPuVrcvXeCxeLl
	5R5mi7ZZ/Bb/9+xgt/h3bSOLxex3+9kttryZyGpxfG24Rcv+KSwOch7vb7Sye7x5+ZLF43DH
	F3aPvd8WsHjsnHWX3aNn5xlGj02rOtk87lzbw+Yx72Sgx/3u40wem5fUe7SsPcbk0f/XwOP9
	vqtsHn1bVjF6XGq+zh4gFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXcWDXJ6aCXRwVE5/8ZW5gbGfvYuTkkBAwkXg+fTGQzcUhJLCUUeLu7ePM
	EAkZiWvdL1kgbGGJP9e62CCKXjFKPJm3lBUkwSZgJPFg+XwwW0RgMYvE3n2VIEXMAm8ZJa7P
	3AjWLSzgL3H+w06wdSwCqhKHj35lArF5BRwkHly+wQixQV5i/8GzYJs5geJruiDiQgL2Ev9O
	fWCDqBeUODnzCdhMZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+
	7iZGYILZduzn5h2M81591DvEyMTBeIhRgoNZSYT3kFBmuhBvSmJlVWpRfnxRaU5q8SFGU6C7
	JzJLiSbnA1NcXkm8oZmBqaGJmaWBqaWZsZI4r9vl82lCAumJJanZqakFqUUwfUwcnFINTK3s
	m8K9g6b9UOJm9U6cbFzGdkInsvqDsa3mvNAPix89ZtmSdu6uwINpPbdLa6aubZyXHqG66e41
	qbQTyxojQ9unXJRafVLWkMU9oXu/WonzTmZ1ppA4j3O5EhyXTntt5L7tu/zX1cSN28QvWb04
	doMvd/aXI1NZahSdjRdPO/1pxvG0r80CtQ9TrasYc5tyrwhNbdNin7dUz/iiWFOb6muGlY7z
	NotKmx54pxdb0MNnVvMgK6Nr+/oLij327YX2t7iPXWL9kcWR6J20ruPC3ut7nr8psVPMaWks
	vaPfpnhtfo2dac4Sz3Bf76n7bf48i2lhjnpxcolgdlDHFRuxcqGNcQfC/5R6WeTr2jArsRRn
	JBpqMRcVJwIAdjCs2bkDAAA=
X-CMS-MailID: 20241223125619eucas1p1f9c4afd9b4f458ab92750e0526c95581
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241223125619eucas1p1f9c4afd9b4f458ab92750e0526c95581
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241223125619eucas1p1f9c4afd9b4f458ab92750e0526c95581
References: <20241223125553.3527812-1-m.wilczynski@samsung.com>
	<CGME20241223125619eucas1p1f9c4afd9b4f458ab92750e0526c95581@eucas1p1.samsung.com>

Several RISC-V boards feature Imagination GPUs that are compatible with
the PowerVR driver. An example is the IMG BXM-4-64 GPU on the Lichee Pi
4A board. This commit adjusts the driver's Kconfig dependencies to allow
the PowerVR driver to be compiled on the RISC-V architecture.

By enabling compilation on RISC-V, we expand support for these GPUs,
providing graphics acceleration capabilities and enhancing hardware
compatibility on RISC-V platforms.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
index 3bfa2ac212dc..5f218896114c 100644
--- a/drivers/gpu/drm/imagination/Kconfig
+++ b/drivers/gpu/drm/imagination/Kconfig
@@ -3,7 +3,7 @@
 
 config DRM_POWERVR
 	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG Graphics"
-	depends on ARM64
+	depends on (ARM64 || RISCV)
 	depends on DRM
 	depends on PM
 	select DRM_EXEC
-- 
2.34.1


