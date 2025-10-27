Return-Path: <linux-pm+bounces-36912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2BCC0DD66
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 14:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0E99502BF7
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF328727B;
	Mon, 27 Oct 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AhPmuOpg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8177248867
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569726; cv=none; b=DGVpDKggGtHK6YEQRMzzdy0uKW1N6MxtFbOQDkuTXd1Zl04FZ4N1l8t6mWzbN7QzC8tHzeNYpdbVDbAVSn7pBM/EtXDcqm+eIBx/ITpPu/CyuTENTb+5fkfFyabKbSaHaxCeDKgsCYUgigwyQqWUZgb0CgDRpBUTdqENkJAeiws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569726; c=relaxed/simple;
	bh=ORKglqCo4AjS+KWVxrkbHpKfb2BNZWgSgiMcqdjFSbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=sHGXvuhfCFQJTfSKesSMsBOTguLja2sSoa7Uv2t0MTXM7xcNhuk/V6k4KshN/XYQf41HX5X9mGZWbSWHsGuHhTnLe+y7HrwzLY7SenOI1FV5ZTWBjdt+wynx8/jqPthjlwUD1/mlFWC5uHuTAp8mcyxCBs3RC+KOI+Bin54zbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AhPmuOpg; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251027125521euoutp01e049abd67d9ad450d281da3a365c7252~yWlQyqTcC1132111321euoutp01e
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 12:55:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251027125521euoutp01e049abd67d9ad450d281da3a365c7252~yWlQyqTcC1132111321euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761569721;
	bh=dv9p2PP04hgk3atZfF1Zb7GieMRi3LedopvsYd1QhVs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AhPmuOpgiccMMpOjpudMb57mB2ZYCemLXV0laGDvJQIlI+QB9wLzW6JBNK9WGDGei
	 NQMSK32llANhRm2SyCg1HN1kuPHBx34QiD+85YquVZMIcZBnmF3RX2QlgYFW83AKIn
	 y3i8pD3IICLokZM5T5Kit6f+TiR9foXURIvs9dT8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251027125521eucas1p206cd5a0dd4c3a80bc8abe7d9a5e61706~yWlQdWXw22667626676eucas1p2z;
	Mon, 27 Oct 2025 12:55:21 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251027125521eusmtip172f4dc9597a7f656f2e8e95f00d14fbb~yWlQD4ef20921809218eusmtip1w;
	Mon, 27 Oct 2025 12:55:21 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, =?UTF-8?q?Andr=C3=A9=20Draszik?=
	<andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2] pmdomain: samsung: Rework legacy splash-screen handover
 workaround
Date: Mon, 27 Oct 2025 13:55:15 +0100
Message-Id: <20251027125515.1219940-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251027125521eucas1p206cd5a0dd4c3a80bc8abe7d9a5e61706
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251027125521eucas1p206cd5a0dd4c3a80bc8abe7d9a5e61706
X-EPHeader: CA
X-CMS-RootMailID: 20251027125521eucas1p206cd5a0dd4c3a80bc8abe7d9a5e61706
References: <CGME20251027125521eucas1p206cd5a0dd4c3a80bc8abe7d9a5e61706@eucas1p2.samsung.com>

Limit the workaround for the lack of the proper splash-screen handover
handling to the legacy ARM 32bit systems and replace forcing a sync_state
by explicite power domain shutdown. This approach lets compiler to
optimize it out on newer ARM 64bit systems.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Fixes: 0745658aebbe ("pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- removed label check, as this violates ABI

v1: https://lore.kernel.org/all/20251024093603.3484783-1-m.szyprowski@samsung.com/
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index f53e1bd24798..5c3aa8983087 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -128,6 +128,15 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
 
+	/*
+	 * Some Samsung platforms with bootloaders turning on the splash-screen
+	 * and handing it over to the kernel, requires the power-domains to be
+	 * reset during boot.
+	 */
+	if (IS_ENABLED(CONFIG_ARM) &&
+	    of_device_is_compatible(np, "samsung,exynos4210-pd"))
+		exynos_pd_power_off(&pd->pd);
+
 	on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
 
 	pm_genpd_init(&pd->pd, NULL, !on);
@@ -146,15 +155,6 @@ static int exynos_pd_probe(struct platform_device *pdev)
 				parent.np, child.np);
 	}
 
-	/*
-	 * Some Samsung platforms with bootloaders turning on the splash-screen
-	 * and handing it over to the kernel, requires the power-domains to be
-	 * reset during boot. As a temporary hack to manage this, let's enforce
-	 * a sync_state.
-	 */
-	if (!ret)
-		of_genpd_sync_state(np);
-
 	pm_runtime_enable(dev);
 	return ret;
 }
-- 
2.34.1


