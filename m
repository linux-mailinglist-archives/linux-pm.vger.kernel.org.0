Return-Path: <linux-pm+bounces-38992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96FC98710
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 18:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66BE3A38AD
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C01335BB4;
	Mon,  1 Dec 2025 17:12:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408A335093
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609132; cv=none; b=Q/NR1kA0W2eyWaYNehZZNc9GYQfX52Cg2GhyJVuJcfYe3KHvAjpXgq3OXla1jC9HzrHFWyDXCAhwCSkXAmwk81+CkENayDOJFQ4ZO0mCL8ItBo88vKtoT3viZeK8k+hNFgpi3qH+aZppcHGk/cqYYb1AS+SpZytl39r1eLzHph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609132; c=relaxed/simple;
	bh=3UebCuYz5xGW6Q3uKUWSuaCckT5JCsx8BsMRxukQRGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BrGQc0EGdGjnKQ8NMnSA2ybbrld4AkxNw2TU8zm8lSfhtkVas61ThW05RSSixkOFPWYC+f6W0mkLvxiDByxK0m77IpC+k59i5H4u6sXkI+qENnH9IWOAEA5pxqoXKvuOq/3Zq2kfSNkwPvxY8TpvQ7NvIaMhAf36EbRnstkrP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vQ7RX-0002dz-DS; Mon, 01 Dec 2025 18:12:07 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 01 Dec 2025 18:12:06 +0100
Subject: [PATCH 2/3] pmdomain: imx93-blk-ctrl: convert to devm_* only
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-v6-18-topic-imx93-blkctrl-v1-2-b57a72e60105@pengutronix.de>
References: <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
In-Reply-To: <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Some APIs used by this driver don't have devm_ helpers yet. Instead of
using the devm_add_action_or_reset() the current driver is based on hand
crafted error goto paths and a .remove() callback.

Convert the driver to devm_ APIs only by making use of
devm_add_action_or_reset() and devm_pm_runtime_enable() to simplify the
release and error path.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 64 +++++++++++++++--------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 2aa163aef8de4ee901b9cde76ce2aad246c8c08a..13b0de6dd689cf944e034f7666a4e97b0118e3bd 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -188,6 +188,20 @@ static int imx93_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static void imx93_release_genpd_provider(void *data)
+{
+	struct device_node *of_node = data;
+
+	of_genpd_del_provider(of_node);
+}
+
+static void imx93_release_pm_genpd(void *data)
+{
+	struct generic_pm_domain *genpd = data;
+
+	pm_genpd_remove(genpd);
+}
+
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
 static int imx93_blk_ctrl_probe(struct platform_device *pdev)
@@ -256,10 +270,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 			domain->clks[j].id = data->clk_names[j];
 
 		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
-		if (ret) {
-			dev_err_probe(dev, ret, "failed to get clock\n");
-			goto cleanup_pds;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get clock\n");
 
 		domain->genpd.name = data->name;
 		domain->genpd.power_on = imx93_blk_ctrl_power_on;
@@ -267,11 +279,12 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		domain->bc = bc;
 
 		ret = pm_genpd_init(&domain->genpd, NULL, true);
-		if (ret) {
-			dev_err_probe(dev, ret, "failed to init power domain\n");
-			goto cleanup_pds;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to init power domain\n");
 
+		ret = devm_add_action_or_reset(dev, imx93_release_pm_genpd, &domain->genpd);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to add pm_genpd release callback\n");
 		/*
 		 * We use runtime PM to trigger power on/off of the upstream GPC
 		 * domain, as a strict hierarchical parent/child power domain
@@ -288,39 +301,17 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		bc->onecell_data.domains[i] = &domain->genpd;
 	}
 
-	pm_runtime_enable(dev);
+	devm_pm_runtime_enable(dev);
 
 	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to add power domain provider\n");
-		goto cleanup_pds;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add power domain provider\n");
 
-	dev_set_drvdata(dev, bc);
+	ret = devm_add_action_or_reset(dev, imx93_release_genpd_provider, dev->of_node);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add genpd_provider release callback\n");
 
 	return 0;
-
-cleanup_pds:
-	for (i--; i >= 0; i--)
-		pm_genpd_remove(&bc->domains[i].genpd);
-
-	return ret;
-}
-
-static void imx93_blk_ctrl_remove(struct platform_device *pdev)
-{
-	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
-	int i;
-
-	of_genpd_del_provider(pdev->dev.of_node);
-
-	pm_runtime_disable(&pdev->dev);
-
-	for (i = 0; i < bc->onecell_data.num_domains; i++) {
-		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
-
-		pm_genpd_remove(&domain->genpd);
-	}
 }
 
 static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
@@ -455,7 +446,6 @@ MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
 
 static struct platform_driver imx93_blk_ctrl_driver = {
 	.probe = imx93_blk_ctrl_probe,
-	.remove = imx93_blk_ctrl_remove,
 	.driver = {
 		.name = "imx93-blk-ctrl",
 		.of_match_table = imx93_blk_ctrl_of_match,

-- 
2.47.3


