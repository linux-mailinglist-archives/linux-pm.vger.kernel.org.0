Return-Path: <linux-pm+bounces-25102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD706A84163
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64E21B685A0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECC26FA40;
	Thu, 10 Apr 2025 11:04:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD61DF991;
	Thu, 10 Apr 2025 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283076; cv=none; b=ecyykA/2xzIKqXohM+BOBDyfJqaQUUXiGsrS0uheM8poDrVqpjjeF5K1qBjm3RWEAsccQFWE8BTXDT1zr351QCoBWQtAcarkOmeyYZVVSBXavM/vJmE74L/k9Ajhxt6OiL0CeEsmhEJPqUhmMitHtUMqPN00YBW9dZN5IkOvBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283076; c=relaxed/simple;
	bh=0Y1XnrQEe3NOjFlcNK2ehU36OMVowYRQh6cyPGFkes0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n24lwq1IH8NgdpxK5ZLfACD5cvilev1FZ6zfycI82Yg1aongtXWHYOx07TMNTb1MAloEgMxNXN8nUnCWLmsQv+Zum/qrP2JEupyBLnL3F/v7rQs53ZXuZaAZN5HRgCZlV33KQYYz/4kFCjDA5LUciu03wAED06ikhlEEWFkvmi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201601.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504101904235318;
        Thu, 10 Apr 2025 19:04:23 +0800
Received: from locahost.localdomain.com (10.94.12.92) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 10 Apr 2025 19:04:24 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <s.nawrocki@samsung.com>, <a.swigon@samsung.com>, <djakov@kernel.org>,
	<krzk@kernel.org>, <alim.akhtar@samsung.com>, <cw00.choi@samsung.com>
CC: <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] interconnect: samsung: Add NULL check in exynos_generic_icc_probe
Date: Thu, 10 Apr 2025 19:04:20 +0800
Message-ID: <20250410110421.77580-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025410190423d4e3250a732bb1a33e9b6b03863240d7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure,but this
returned value in exynos_generic_icc_probe() is not checked.
Add NULL check in exynos_generic_icc_probe(), to handle kernel NULL
pointer dereference error.

Fixes: 2f95b9d5cf0b ("interconnect: Add generic interconnect driver for Exynos SoCs")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/interconnect/samsung/exynos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index 9e041365d909..f3568f0d92d1 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -134,6 +134,11 @@ static int exynos_generic_icc_probe(struct platform_device *pdev)
 	priv->node = icc_node;
 	icc_node->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
 					bus_dev->of_node);
+	if (!icc_node->name) {
+		devm_kfree(&pdev->dev, priv);
+		return -ENOMEM;
+	}
+
 	if (of_property_read_u32(bus_dev->of_node, "samsung,data-clock-ratio",
 				 &priv->bus_clk_ratio))
 		priv->bus_clk_ratio = EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO;
-- 
2.43.0


