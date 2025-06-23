Return-Path: <linux-pm+bounces-29346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA6AE469D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2963E7A423D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642A248F4A;
	Mon, 23 Jun 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEHrMkC3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931A246BB4;
	Mon, 23 Jun 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688708; cv=none; b=n6EIWqk95MvrQpr2M80IJc0OP8paDiAI04o3rLghqvHzV4gA2bh0R/HuvwpERU4r/qbO5WXXP45wWxmKX603qD7kwkyxYfumfCJ2DNqVMX+Wejb398VWNIRVd4c5Y9EKJ69LBpuIwRrmbIRyeMzacBwJFcIwzGY4yI/J30q8llA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688708; c=relaxed/simple;
	bh=DwatPil1kiw2bB7RdLdxAbx2UQPaiRT/izcYQBaKOfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYqajjLQ8k7sHa8DdArOUGAYeA4qyAlT4+3ipxWANCrwvhvf9Dl2ZC+4v+4fB/LvldUFye/LzHElWsk8YVN+73fKuIHIvApSBAJZwLFb/BbhEjAOTfYIDB2ZWW1eiVa3uxeeqKdKSbzbOx2y/hxLDqxCuIT0LYYziFvAUPbvp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEHrMkC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086A2C4CEF0;
	Mon, 23 Jun 2025 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750688708;
	bh=DwatPil1kiw2bB7RdLdxAbx2UQPaiRT/izcYQBaKOfc=;
	h=From:To:Cc:Subject:Date:From;
	b=UEHrMkC3+xLCc/uMAggm8K8LStm1DhGUy+I3ZaXIGQxzEN6zZtkPtkrjaMwHLk/5y
	 v7TI5rDex2dj62GjVKOA0Y11gyDRuflWHIWkdV4zvkZjuQLkTthi/RXt61Q6NJyq1A
	 hidq+ShB35cxwjKB7qOAphK08WcPUAk2r8OJ4Z8tzZ9xtPBuRZlj7lmaspN/BBJfgI
	 0+d6pRVksueRECDVCR+ugPbzk9ZEDYehs2n2LNUFlGGoic+3r6I5YuOYR6FPUaXV81
	 BOBUNgRogFL3Mhc2VHrO5r/MmW9kAuVjBO4Q3BcteLCeaEQqPMekCBrkoppeLy80ZD
	 8xCC5Y+FbUuqQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uTi6Z-0000000060g-0XlU;
	Mon, 23 Jun 2025 16:25:03 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	=?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
	Georgi Djakov <djakov@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] interconnect: exynos: handle node name allocation failure
Date: Mon, 23 Jun 2025 16:24:37 +0200
Message-ID: <20250623142437.23068-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing error handling in case node name allocation ever fails.

Fixes: 2f95b9d5cf0b ("interconnect: Add generic interconnect driver for Exynos SoCs")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/interconnect/samsung/exynos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index 9e041365d909..8e8f56186a36 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -134,6 +134,11 @@ static int exynos_generic_icc_probe(struct platform_device *pdev)
 	priv->node = icc_node;
 	icc_node->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
 					bus_dev->of_node);
+	if (!icc_node->name) {
+		icc_node_destroy(pdev->id);
+		return -ENOMEM;
+	}
+
 	if (of_property_read_u32(bus_dev->of_node, "samsung,data-clock-ratio",
 				 &priv->bus_clk_ratio))
 		priv->bus_clk_ratio = EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO;
-- 
2.49.0


