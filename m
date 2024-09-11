Return-Path: <linux-pm+bounces-14014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5958975189
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D131F226AE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF73196C9B;
	Wed, 11 Sep 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bulYgyZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3118FDBE
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056720; cv=none; b=ibn2VNGzmbXswV7K8OelePMIeGlSmTemqyFjEGevEb6ob+TDkLSJWnd+TapakK0Cu8/UuJ/gwx4jB95QHD9DqcxBi/X9kM5Yr3DKX7SR/pDLhKuf/68ppDis2pjwy47XVgFfAF28pV2JYDsScQRMCq3NvuNyoLAuZfMkcRqKtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056720; c=relaxed/simple;
	bh=ozQqRLSq7IDjYDABSRGssFY6xGkaa/o/USWejNvQnV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=acJZyxF7iI4e09ODRgHKmJKYGmH9bEaVXo8rW99zavzoUStvgVHlrzLHD4yjF0lJR6qvLV3C0in9NhvM2X+ZNnavHcxoQ8VlOvxcrjrGv58NjoAODb3uEkE7TG2CCqB67ZQ+Tha6/simaSbmZj69qMosfvLj/0uM/4bCHS0/lqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bulYgyZV; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240911121157euoutp0196332bfcc2ae08f098e229515ff816e0~0L3BuJ9Fj0990209902euoutp01H
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240911121157euoutp0196332bfcc2ae08f098e229515ff816e0~0L3BuJ9Fj0990209902euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726056717;
	bh=Y23/WQ9wTzL9cT2j+ezI3cB32JYq7m7BkHPWsCs5IOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bulYgyZVce1V8YvoXr78iLNm5Hg1K+qcUUX3D7xewHyjXk8ABm5y8jvAjFltKzZuC
	 zuFjj4EIACqmJRbmN7BAMdQ2/UD583WC9+9MQDofwnUR7pN6KJo7p0asMUACfz93AF
	 Ip0yhRjbyhlXJsSfuLn+izbE/h6jXEWLxCYyYHso=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240911121156eucas1p20fb94f4f1119dd274889d7e029d9c14c~0L3BL0Iqr2873128731eucas1p2S;
	Wed, 11 Sep 2024 12:11:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D7.D1.09624.C0981E66; Wed, 11
	Sep 2024 13:11:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121155eucas1p160223d89bff83a89a03c5447252f44a9~0L3AmQ4Yr1357913579eucas1p1s;
	Wed, 11 Sep 2024 12:11:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911121155eusmtrp2d48ce6715ada201ca38692c9112d690d~0L3AlEb2u2688526885eusmtrp2e;
	Wed, 11 Sep 2024 12:11:55 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-9e-66e1890c2e03
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.E9.14621.B0981E66; Wed, 11
	Sep 2024 13:11:55 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121154eusmtip1fb836354b159274484cd7bc4a3684392~0L2-cRo5h0847908479eusmtip1j;
	Wed, 11 Sep 2024 12:11:54 +0000 (GMT)
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
	Moon <linux.amoon@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 4/7] drivers/thermal/exynos: reuse data->temp_mask in
 exynos_tmu_update_temp
Date: Wed, 11 Sep 2024 14:11:27 +0200
Message-ID: <20240911121136.1120026-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121136.1120026-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djP87o8nQ/TDK5uErN4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XaI3fZLeZ+mcps8X/PDnaLJw/72Cye9+1jchDyWDNvDaPHzll32T0W73nJ5LFpVSeb
	x51re9g8Ni+p9+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6Ma2+2MxUs5Kj4P3MpcwPjB7Yu
	Rk4OCQETidmvdzN3MXJxCAmsYJT4f/sJK4TzhVFi68ZGRpAqIYHPjBKf1urDdMy7s48Fomg5
	o8T27mdQHa1MEvN/PAPrYBMwkHjwZhk7SEJEYDGjROOPd2BVzAITWSTWv+kGqxIWSJTYfOgQ
	O4jNIqAq0d10CszmFbCTaHq9ihVin7zExTXPwa7lFLCX+P56OSNEjaDEyZlPWEBsZqCa5q2z
	wb6QEJjNKTHz5Bao91wklly9wgxhC0u8Or6FHcKWkfi/cz4ThJ0vMWPze6BBHEB2hcTdg14Q
	prXExzPMICazgKbE+l1Q3ztKnDx9lhmigk/ixltBiAP4JCZtmw4V5pXoaBOCqFaVOL5nEtR6
	aYknLbehVnpI7NqzgXECo+IsJK/MQvLKLIS9CxiZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl
	5+duYgQmvNP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEePvt7qUJ8aYkVlalFuXHF5XmpBYfYpTm
	YFES51VNkU8VEkhPLEnNTk0tSC2CyTJxcEo1MNmY6USFPNs/O85uXte82/Pnfj/Zz7QhaWu3
	63e7ZcyizwufuVRvS6h8sP/ViX/u3pc1u9dkyh/3/PnVeOW12gUdU23YtxaYy9mce8HM+erq
	7sDlqqylcrfsYysvbzkaoCiwSGtmldWa1Ha/+sZZshz3lf25Qkv3V0tIauoHX9JxL9NUYRb2
	VhKv5lrdOfWtZvOW3AM9SvPuTzBgL9u0qNTukOtWg7KYZ4dUhKotJ39TkrFN2LqG58wqjr2l
	sstV+wwOOtydsvChcjBzTv197e6jIrqpbGVunhvSzj/SyZzT3tMZduJT3xHWdLaHfgLHLlfN
	Fb9YnxG65f8ebrsnJqdE9zR6y4koXlk7t6VCiaU4I9FQi7moOBEAdC/COucDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7rcnQ/TDD72GVs8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLtkbvsFnO/TGW2+L9nB7vFk4d9bBbP+/YxOQh5rJm3htFj56y77B6L97xk8ti0qpPN
	4861PWwem5fUe/RtWcXo8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayV
	kamSvp1NSmpOZllqkb5dgl7GtTfbmQoWclT8n7mUuYHxA1sXIyeHhICJxLw7+1hAbCGBpYwS
	mzvDIOLSEoe/TGGHsIUl/lzrAqrnAqppZpL4/fARWIJNwEDiwZtlYLaIwHKg5nYPkCJmgbks
	Ep2vV4MlhAXiJTbMewK2jUVAVaK76RRYnFfATqLp9SpWiA3yEhfXPAer4RSwl/j+ejkjxEV2
	Eh83nmSFqBeUODnzCdilzED1zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi0rx0
	veT83E2MwOjcduzn5h2M81591DvEyMTBeIhRgoNZSYS33+5emhBvSmJlVWpRfnxRaU5q8SFG
	U6C7JzJLiSbnA9NDXkm8oZmBqaGJmaWBqaWZsZI4r9vl82lCAumJJanZqakFqUUwfUwcnFIN
	THPMJm3JOPHbcqdl/joF6zP7X3/1jr+c7/ouTUS8O6TpaPFzl9dlVsUzw0yZFlmdXSQlIK9w
	/7WpXLLinfX+Lob2QhM2KoT8Kbpyr8S2SN425mX1C71T5/Qs/bTmftw7NfJuH6vgU+e66+nH
	5gerTP1w/FbJtW+Xc7gzn8y4pHhxyd0WO/9VbPGW00o5FdbON/t5pcEu+Uv2natiV7fWLdfq
	ZK2f9v3tvsLVhkb2m1j0NJwvskbrzl5WuvS6/a+clEV6x99PXzJLX/PqIv3pk87ccU5pP/2j
	Ii1Lt/e8yPI5kmz6Mvfctb/96HqqHfXptabntNXzE0QjJs2rtowI3tH77Mxiu3aXpXdmFd2L
	X6nEUpyRaKjFXFScCADG0pz+VwMAAA==
X-CMS-MailID: 20240911121155eucas1p160223d89bff83a89a03c5447252f44a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240911121155eucas1p160223d89bff83a89a03c5447252f44a9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240911121155eucas1p160223d89bff83a89a03c5447252f44a9
References: <20240911121136.1120026-1-m.majewski2@samsung.com>
	<CGME20240911121155eucas1p160223d89bff83a89a03c5447252f44a9@eucas1p1.samsung.com>

Both the intention and the actual logic is identical, little point in
duplicating it.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 8b1014915c31..9bddf9fd5049 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -357,15 +357,10 @@ static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
 static void exynos_tmu_update_temp(struct exynos_tmu_data *data, int reg_off,
 				   int bit_off, u8 temp)
 {
-	u16 tmu_temp_mask;
 	u32 th;
 
-	tmu_temp_mask =
-		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
-						: EXYNOS_TMU_TEMP_MASK;
-
 	th = readl(data->base + reg_off);
-	th &= ~(tmu_temp_mask << bit_off);
+	th &= ~(data->temp_mask << bit_off);
 	th |= temp_to_code(data, temp) << bit_off;
 	writel(th, data->base + reg_off);
 }
-- 
2.45.2


