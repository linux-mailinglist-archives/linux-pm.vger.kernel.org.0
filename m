Return-Path: <linux-pm+bounces-11616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F00794035E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 03:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3701F23F07
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A872C95;
	Tue, 30 Jul 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V6h3Ovto"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE96442C
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302438; cv=none; b=T7CdDNUphqI7o7wOCSOwsM1tY/fxn+IndbS6gKgVikrqwjcUobwYZZ7p6nN/pfDlk/SzfCd2DXACnUR+GJxtgi279HZoF4EjqI1jIxicroUDGglgSuGK5blmGO9UWR1EVr9ExFmzfUvfDvnJsbszN2fvXNyZWgdqkV/wsWRNR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302438; c=relaxed/simple;
	bh=7sFpW7FaITWJsV3JL8gPx+PMEupv+MzEs6hdIq87RFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=gHMVLEdjPzENPJ6axDzahmuub01MRfSJvlI9PMxNOaMUjqS4OvzmPFOotx0fCQvVlmy/mKYIBRBDrmPSU+AqhguDqcDlb+pKO6+KSpwqnFWy7Bk3JtKhtPZVuhEAWTyXIQjJ/ALVo0kfs8YaPI7P7Bo1xWY/Q0+MxYw45VO10jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V6h3Ovto; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240730012029euoutp02aa8a374c751e633fe153d66adce9a4d8~m2O8e2tNV1131111311euoutp02E
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 01:20:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240730012029euoutp02aa8a374c751e633fe153d66adce9a4d8~m2O8e2tNV1131111311euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722302429;
	bh=2l/Tm+GJl5Bpguh8RXXKnXyxWbBEPbxWdMDeWf66q1M=;
	h=From:To:Cc:Subject:Date:References:From;
	b=V6h3OvtoYZJdcTQCuXsYxastm/0qIHRn6ROjN+mnORb/0IcBA9FRDDJWQvBb4PePB
	 tP/dRBEpEpziJKURJKGFVpVJwj7pj5e/oWNfN4kl4BZHK4kaDgcyG0aUI5eiZqurdp
	 f6GrJHIXlIlGQWUZ8ZFM4/BYbtSyGlaYsP3tnDJE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240730012028eucas1p1c7788a9c69a8a91c64a2cf55e9d00fcc~m2O7yh1ly0853308533eucas1p1D;
	Tue, 30 Jul 2024 01:20:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 73.BD.09620.CDF38A66; Tue, 30
	Jul 2024 02:20:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240730012027eucas1p2882c9c45e4d2203916af28ad86493a9a~m2O7SrMaF1785217852eucas1p2H;
	Tue, 30 Jul 2024 01:20:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240730012027eusmtrp114fd7575832f1901d6807488e14d08ad~m2O7RBonx0370503705eusmtrp1a;
	Tue, 30 Jul 2024 01:20:27 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-44-66a83fdc538f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.8B.09010.BDF38A66; Tue, 30
	Jul 2024 02:20:27 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240730012026eusmtip251c63c014f4962008b1526e5f2a733b9~m2O6Ue2Qc3180331803eusmtip2G;
	Tue, 30 Jul 2024 01:20:26 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, ALIM AKHTAR
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>
Subject: [PATCH] MAINTAINERS: thermal: samsung: add myself as maintainer of
 the driver
Date: Tue, 30 Jul 2024 03:20:18 +0200
Message-ID: <20240730012019.1680121-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7p37FekGezdyWHxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFus23mK3WNjUwm4x
	8dhkZou5X6YyW/zfs4Pd4snDPjaL5337mBwEPdbMW8PosXPWXXaPxXteMnlsWtXJ5nHn2h42
	j81L6j36tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEro+vDVraC2awVT2bdZ25g3MfSxcjJISFg
	InH2TytbFyMXh5DACkaJ5Sd7oZwvjBIv1y9mhnA+M0qcuvyXDablRs9FJojEckaJtrOLoZxW
	Jonns1+ADWYTMJB48GYZO0hCROAqk8Szp5/AHGaBJ8wSm59MA5slLBAhseX0VXYQm0VAVWL/
	kxlA3RwcvAJ2Es8vVUCsk5fo3d/HBGLzCghKnJz5BGwBM1C8eetssPskBP5zSJzp+8cE0eAi
	Mb9vFpQtLPHq+BZ2CFtG4vTkHqi38yVmbH4PtktCoELi7kEvCNNa4uMZZhCTWUBTYv0ufYhi
	R4nfn28xQlTwSdx4KwhxAJ/EpG3TmSHCvBIdbUIQ1aoSx/dMYoawpSWetNyGOsVD4sS7G2Bv
	CwnESpy7foFtAqPCLCRvzULy1iyEGxYwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQI
	THOn/x3/uoNxxauPeocYmTgYDzFKcDArifDGX1maJsSbklhZlVqUH19UmpNafIhRmoNFSZxX
	NUU+VUggPbEkNTs1tSC1CCbLxMEp1cCUN91Y2p8l4dTlS2G/YwwDJzd4GF+81d6e+ebHgRdr
	N7XM5f24L0j57+13HGf00oqDbvJOW7Tt4NHII/PFt0+w3CoV1XthEq/T7QbG6A/5UzTXLlik
	FHL9EtdK4VMPv1rUxH3mdfj0g7P0VByX2HW9iz93fC7Juub0jLtK+HhxubfXOqUJ+lGnBd5p
	GF7xjTGJeafROGVLOPuz6dkfbqc/X7G7lJvTa+1Hmb07lkSsExSMlrxmYLfhCd+5zHeTkg/b
	NHPXTUw9p+mnkv5X/5/ZdgOnTUtevwg6YiKe3rQyt/Zco8UkA4EDTwRuaFZec+v/L578nK2s
	rOo3x2P/z9MfGKm93vPpq9n7l7ujzffuUmIpzkg01GIuKk4EAKnXCvjiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7q37VekGaxboGzxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFus23mK3WNjUwm4x
	8dhkZou5X6YyW/zfs4Pd4snDPjaL5337mBwEPdbMW8PosXPWXXaPxXteMnlsWtXJ5nHn2h42
	j81L6j36tqxi9Pi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEvo+vDVraC2awVT2bdZ25g3MfSxcjJISFgInGj5yJTFyMXh5DAUkaJhe8X
	MkMkpCUOf5nCDmELS/y51sUGUdTMJHH50xmwBJuAgcSDN8vAbBGBy0wSO2ergBQxC7xjlujq
	aQBLCAuEScx4380EYrMIqErsfzIDaDUHB6+AncTzSxUQC+Qlevf3gZXwCghKnJz5BOw6ZqB4
	89bZzBMY+WYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMMa2Hfu5ZQfjylcf
	9Q4xMnEwHmKU4GBWEuGNv7I0TYg3JbGyKrUoP76oNCe1+BCjKdB5E5mlRJPzgVGeVxJvaGZg
	amhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAlKv6+MWjuzskPjGELdmWbBR3
	XfAee3vnqpOPvYTUboi/PrRoVapKyIUXt9cJ72+ur/P5p7pD8I1nutYDtwudF9f1Ji4rOFE+
	Q9jqU55NoPqVH50nr/v0PGO+xnO0+fmU3ltnbOSn93Rq8TgL1ki+lNgt1fn27MFuu7w/BxJY
	3u7jiOVdmTD1wqXoowqva6Pn/p70+HYaW8+Rz0o/ZDgveIfIpz7z3mGu13Nlorau/dU8I5fj
	ulO9dM62L5JYn5HV4Cmp4GweGBLD1Hrjb0dsmlTv0qmXD+zwYcvYYXz/z+eqN8eN2t4lTD14
	4lGYsdvKvOKb3bkr1Ba8CXrvKMMlEb1xzffnq0wuBvV+TW9QUWIpzkg01GIuKk4EAIKcqf06
	AwAA
X-CMS-MailID: 20240730012027eucas1p2882c9c45e4d2203916af28ad86493a9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240730012027eucas1p2882c9c45e4d2203916af28ad86493a9a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240730012027eucas1p2882c9c45e4d2203916af28ad86493a9a
References: <CGME20240730012027eucas1p2882c9c45e4d2203916af28ad86493a9a@eucas1p2.samsung.com>

As discussed in
https://lore.kernel.org/lkml/e73e1a14-dfa0-4a36-bc6e-5d6421553788@kernel.org

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12b870712da4..9133257a8509 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20247,6 +20247,7 @@ F:	drivers/net/ethernet/samsung/sxgbe/
 SAMSUNG THERMAL DRIVER
 M:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
 M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Mateusz Majewski <m.majewski2@samsung.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-- 
2.45.1


