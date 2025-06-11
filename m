Return-Path: <linux-pm+bounces-28472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADBAD5294
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 12:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F33A3A7D1C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 10:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD5288C96;
	Wed, 11 Jun 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa4DIAu9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7428850C;
	Wed, 11 Jun 2025 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638685; cv=none; b=PJ6zPTYu0W/9URrUqr43s9etp8MzB4mT3pQ52iJuNys8BuVPWwKATwrw9qhMhm9xPBVo9QIJhqODolTxriHLPLflO1QYAWJYDsFc34XcxV8i5hU5Pfn0hHv6IQrCbUGsc+iqzwg9T8cnrIQVBdt8L05Gwpsho5rjv2spmL2FH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638685; c=relaxed/simple;
	bh=f5qbQ8Fc4E+01P0Dh1oZ2Hoqqa0z07Fu0gRmiBSanlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcV0SzDpD97FWPGrVBq8R97QPoh2GgaIKfWdT0x0AzD+YUoVxpjWozIgR3gdDxo2hcN7yvQZggLYeULksOkKVLM63c/bnVfl/3DSWqa9mBpuVrOr0QgXw85od3Fr8mU8+AAuyVY2MMf+Ncexee2jBwKLU/sId+z5/HV9Qd5Q9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa4DIAu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC3AC4CEF2;
	Wed, 11 Jun 2025 10:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638685;
	bh=f5qbQ8Fc4E+01P0Dh1oZ2Hoqqa0z07Fu0gRmiBSanlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sa4DIAu9Vvf1WurQjI0XhYcEIcBkDlZ3nyZ23fCFbbba0Mh1Iq6uywKVi5H9/NcoI
	 a2Pmjva05ZVRM38aqIYUO9X+GUQW/N69gi1nSvWcd+XEowP3bATpkkt5LqlKNWZRc0
	 OKI+Yi5uJkgMxg9FuyH6L9ebGHnH38BHj/XPVokzGZ0DgVDTzV1Nkh77hEmEeYlSXT
	 6sDR7tP7fyEj3PcrdnTsZEVRcpSImF4PRJiJu1CkAmaANzBfNF2t29cPRKNZtBhC74
	 FeP68e4Jw3uhhr3f2tBxpldJKsvAfnlEKss+6xoyBrDxOJ7T+avAJChry0yU6mnC0A
	 B6OAlJsAeR/HA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: Use dev_fwnode()
Date: Wed, 11 Jun 2025 12:43:48 +0200
Message-ID: <20250611104348.192092-20-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611104348.192092-1-jirislaby@kernel.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_create_simple() takes fwnode as the first argument. It can be
extracted from the struct device using dev_fwnode() helper instead of
using of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
---
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/qcom/lmh.c       |  3 +--
 drivers/thermal/tegra/soctherm.c | 13 +++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 991d1573983d..75eaa9a68ab8 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -209,8 +209,7 @@ static int lmh_probe(struct platform_device *pdev)
 	}
 
 	lmh_data->irq = platform_get_irq(pdev, 0);
-	lmh_data->domain = irq_domain_create_linear(of_fwnode_handle(np), 1, &lmh_irq_ops,
-						    lmh_data);
+	lmh_data->domain = irq_domain_create_linear(dev_fwnode(dev), 1, &lmh_irq_ops, lmh_data);
 	if (!lmh_data->domain) {
 		dev_err(dev, "Error adding irq_domain\n");
 		return -EINVAL;
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 926f1052e6de..53a5c649f4b1 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1206,7 +1206,7 @@ static const struct irq_domain_ops soctherm_oc_domain_ops = {
 /**
  * soctherm_oc_int_init() - Initial enabling of the over
  * current interrupts
- * @np:	The devicetree node for soctherm
+ * @fwnode:	The devicetree node for soctherm
  * @num_irqs:	The number of new interrupt requests
  *
  * Sets the over current interrupt request chip data
@@ -1215,7 +1215,7 @@ static const struct irq_domain_ops soctherm_oc_domain_ops = {
  * -ENOMEM (out of memory), or irq_base if the function failed to
  * allocate the irqs
  */
-static int soctherm_oc_int_init(struct device_node *np, int num_irqs)
+static int soctherm_oc_int_init(struct fwnode_handle *fwnode, int num_irqs)
 {
 	if (!num_irqs) {
 		pr_info("%s(): OC interrupts are not enabled\n", __func__);
@@ -1234,10 +1234,8 @@ static int soctherm_oc_int_init(struct device_node *np, int num_irqs)
 	soc_irq_cdata.irq_chip.irq_set_type = soctherm_oc_irq_set_type;
 	soc_irq_cdata.irq_chip.irq_set_wake = NULL;
 
-	soc_irq_cdata.domain = irq_domain_create_linear(of_fwnode_handle(np), num_irqs,
-						     &soctherm_oc_domain_ops,
-						     &soc_irq_cdata);
-
+	soc_irq_cdata.domain = irq_domain_create_linear(fwnode, num_irqs, &soctherm_oc_domain_ops,
+							&soc_irq_cdata);
 	if (!soc_irq_cdata.domain) {
 		pr_err("%s: Failed to create IRQ domain\n", __func__);
 		return -ENOMEM;
@@ -1968,10 +1966,9 @@ static void tegra_soctherm_throttle(struct device *dev)
 static int soctherm_interrupts_init(struct platform_device *pdev,
 				    struct tegra_soctherm *tegra)
 {
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	ret = soctherm_oc_int_init(np, TEGRA_SOC_OC_IRQ_MAX);
+	ret = soctherm_oc_int_init(dev_fwnode(&pdev->dev), TEGRA_SOC_OC_IRQ_MAX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "soctherm_oc_int_init failed\n");
 		return ret;
-- 
2.49.0


