Return-Path: <linux-pm+bounces-23321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6205A4C410
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3777A6AEE
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 14:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C6215058;
	Mon,  3 Mar 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tq7M70wU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B32144C9
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013970; cv=none; b=oGfzI2h5uayOEeRu7MRu5W8VjzIr5Dm/At/Vl1YUJZCGbobCc8otFi1QjJKJYh2SmnnFhVKHxnIl9Q5NE6jdH6K3HehYcfpvW4kXQlAY5RhxJwx3mwMpe5fg6TbW+Ijoj7CSh2YRpycs1uH7okYlOzm/6CC027TGEPr7S6bvbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013970; c=relaxed/simple;
	bh=LjNeeGPZTSfwAfwVgmY6/aONFof+BNi8pWf8VZUD+9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YDXDkCZ8mZOzfsUJzcGUtKJ0WLn85OyuZnnzWnspDB2urQujUVgZD5liKQfX5ukj4ulamP2sqsrv9eFSO0B+4kqAa8dwk67DKMN+9w8uT9DMYAJtRtNDlFukbhB6yQjwGIkuyPnMzya2DNem3ZWK3uTVRN8vqn0kU6Sof004AAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tq7M70wU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250303145922euoutp01ee4959968953bee181e108e2ad2fb25c~pUvmWOSBy0131001310euoutp01H
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 14:59:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250303145922euoutp01ee4959968953bee181e108e2ad2fb25c~pUvmWOSBy0131001310euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741013962;
	bh=GvH+KGxOLMWPvCT3kvkzzW6sq/iRIHCpZUQmHgtdxxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tq7M70wUn6VUGmTO1XN8lvHUQ/n2lzmkRDVi0wnDhv8RqxLtwI8Sw9EEVE0H0zLhA
	 Xn7UiTPJqUdmDGUgtNDt46LKLQig+dhXyV5W+8SXR2PtPQ2aIBB8KM9v8E2tPfVX/n
	 Dd2vuEnqC+EMvHnwk6jlSckyctnVsrLY6LUO5HXQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303145922eucas1p2c9fb5c5a0c86d7c0e4e22530e031a541~pUvl__aG73212832128eucas1p2e;
	Mon,  3 Mar 2025 14:59:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.D1.20409.AC3C5C76; Mon,  3
	Mar 2025 14:59:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250303145922eucas1p1224cdbd627f5e3d7f854073ebbd93c42~pUvloWqzy3228832288eucas1p1O;
	Mon,  3 Mar 2025 14:59:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303145921eusmtrp15f79bbff6f92ac43526e025605572ab3~pUvldkeGy2312323123eusmtrp1h;
	Mon,  3 Mar 2025 14:59:21 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-bd-67c5c3caecf6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.2D.19654.9C3C5C76; Mon,  3
	Mar 2025 14:59:21 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303145921eusmtip28416f0c951b2f94563d2b03444b42495~pUvkrdOt70060900609eusmtip2g;
	Mon,  3 Mar 2025 14:59:21 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 5/5] riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
Date: Mon,  3 Mar 2025 15:59:01 +0100
Message-Id: <20250303145901.446791-6-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303145901.446791-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7qnDh9NNzh8XtLi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdxWWTkpqTWZZapG+XwJUxe+0Z
	poIpnBU9uy+wNTCeZu9i5OCQEDCRuL46sYuRi0NIYAWjxMb9K1m7GDmBnC+MEgffVUMkPjNK
	TDiylBkkAdLwcv52Joii5YwSbxoKIIreMEr0rT/KBpJgEzCSeLB8PitIQkSgn0mi78h/MIdZ
	YCWjxP0LZ8FGCQt4SJw+vQBsH4uAqkT/qs9gNq+AnUTXkSdMEOvkJfYfBKnn4OAUsJf41KAJ
	USIocXLmExYQmxmopHnrbKjrNnNKnLsL9ZqLxNEfMRBhYYlXx7ewQ9gyEqcn97BA2PkSD7Z+
	gmqtkdjZcxzKtpa4c+4XG8gYZgFNifW79CHCjhKX5k9ghJjOJ3HjrSDEAXwSk7ZNZ4YI80p0
	tAlBVKtJTO3phVt6bsU2qJc8JL48bWOewKg4C8krs5C8Mgth7wJG5lWM4qmlxbnpqcVGeanl
	esWJucWleel6yfm5mxiBafD0v+NfdjAuf/VR7xAjEwfjIUYJDmYlEd5b7UfThXhTEiurUovy
	44tKc1KLDzFKc7AoifMu2t+aLiSQnliSmp2aWpBaBJNl4uCUamASnVDr7se/Il26f/2e6svH
	FTZHZZ98b2m0qdlp85dl/Pw3+5vC1Dg1WAvEXhuuWzC/etvku1+P/njmaLO4QeyE4NZXVRuC
	1+iy9jS/3brjx4WX/9Ut1uuvW/OjXz+KM6b05uckmwlHli86mbuv48FOq7Prb2hN6J7KlGLJ
	vfZs79xKkflaycdL/OftYHLnXu/tcI07JOPVp6P7G0/Ky1z11Issjm+0ZVzyo447o8jh8qY4
	c83N7MEswqJhscX3D1a0OV7cfmjr9V6efbPOHkyW+aD2f89x5p5ZrXuMnT10GDi02bcqbX4t
	kKehfJDPtzFQ40u386LtnN9PGxgtaqwrFDE7fWGpCoPkFNb4jDtKLMUZiYZazEXFiQCDYMew
	8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7onDx9NN/i/2tTi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdpWdTlF9akqqQkV9cYqsUbWhh
	pGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcxe+0ZpoIpnBU9uy+wNTCeZu9i5OSQ
	EDCReDl/O1MXIxeHkMBSRomzE6+xQCRkJK51v4SyhSX+XOtigyh6xSjx93sXWIJNwEjiwfL5
	rCAJEYGFTBJXp2xgBnGYBdYyShy+eglsh7CAh8Tp0wtYQWwWAVWJ/lWfwWxeATuJriNPmCBW
	yEvsP3gWqJmDg1PAXuJTgyaIKQRU8uoTB0S1oMTJmU/A9jIDVTdvnc08gVFgFpLULCSpBYxM
	qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjd9uxn1t2MK589VHvECMTB+MhRgkOZiUR3lvt
	R9OFeFMSK6tSi/Lji0pzUosPMZoCXT2RWUo0OR+YOvJK4g3NDEwNTcwsDUwtzYyVxHnZrpxP
	ExJITyxJzU5NLUgtgulj4uCUamCyT6jfqrlQzzo+c3HSC9a2Zwmehze8faa0f8dZxZcHdu1m
	mMPAPHkez1vHEP/nH049lzv2bQULn3Ne2dFbf1inzVArM/6hvTF8cZPZuoy7k1dlvo+Jf3lr
	4+s/v2R5fMXMuu6zGW4sd8+xL1tVf3pFZkZ7y70r6u9+TAquWFgbsvTVuw2ZmhXarwTFVvSu
	ruZn8GEr8P7aJP9ezOSoIutKu9db5UQen3T/rXXSm21f7ARZbpdQbUPvaKGph45tT5Pp2JV0
	sJtpFpPAgl7Jp2WLon4o3pjTdffPjJ7Fe5/6pUkLbG/0PqDe1atyLlrDJDdG7721ed/Ox3kv
	slO+f9mdMH3XS5tJZgvbDRIMNrMpsRRnJBpqMRcVJwIA8FM+TGUDAAA=
X-CMS-MailID: 20250303145922eucas1p1224cdbd627f5e3d7f854073ebbd93c42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303145922eucas1p1224cdbd627f5e3d7f854073ebbd93c42
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303145922eucas1p1224cdbd627f5e3d7f854073ebbd93c42
References: <20250303145901.446791-1-m.wilczynski@samsung.com>
	<CGME20250303145922eucas1p1224cdbd627f5e3d7f854073ebbd93c42@eucas1p1.samsung.com>

T-Head SoCs feature separate power domains (power islands) for major
components like the GPU, Audio, and NPU. To manage the power states of
these components effectively, the kernel requires generic power domain
support.

This commit enables `CONFIG_PM_GENERIC_DOMAINS` for T-Head SoCs,
allowing the power domain driver for these components to be compiled and
integrated. This ensures proper power management and energy efficiency
on T-Head platforms.

By selecting `PM_GENERIC_DOMAINS`, we provide the necessary framework
for the power domain drivers to function correctly on RISC-V
architecture with T-Head SoCs.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 1916cf7ba450..83833ded8908 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -53,6 +53,7 @@ config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
 	depends on MMU && !XIP_KERNEL
 	select ERRATA_THEAD
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the RISC-V based T-HEAD SoCs.
 
-- 
2.34.1


