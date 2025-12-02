Return-Path: <linux-pm+bounces-39071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A476C9B943
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9879C4E45E0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA33164A8;
	Tue,  2 Dec 2025 13:21:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C583164C2
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764681705; cv=none; b=aAJc9rq6QHO5QPARs2GktbVjvZcXFrq8UjeCj0gFxkQDpBH5cZ4HPUVEmkuudnk3ISbkQo6+JNvXpjliWVrYJ9B+Y4uZt6vxyD6K0xz95MYfW0vjhuV0GDdWpIEQ+cVDxpi99uQ+jESb7kaGk9qKucPJEKUAlLzQMr4/axJdODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764681705; c=relaxed/simple;
	bh=dcfHatMpMTm4tDIi7xxC79fBMuzf0pzfdh2LonpFAHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4FwzJDBeve1y5PJTFPSTVFcBNBI2Nl9zwuJwqPKSbpI2x79rjTTTO7Uz9TOC+ki64F/tFXRAfL31Bpf1Ujm2L56l7eATBWOIa7ARDXHTAdYbB4QN4J6dTP049uJgJs70kDibndBuZAaXRK0jInU2DLs4lbi6yV0gTDOH492BP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vQQJu-0003pJ-PG; Tue, 02 Dec 2025 14:21:30 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 02 Dec 2025 14:21:03 +0100
Subject: [PATCH v2 2/3] pmdomain: imx93-blk-ctrl: convert to devm_* only
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-v6-18-topic-imx93-blkctrl-v2-2-e73501034adc@pengutronix.de>
References: <20251202-v6-18-topic-imx93-blkctrl-v2-0-e73501034adc@pengutronix.de>
In-Reply-To: <20251202-v6-18-topic-imx93-blkctrl-v2-0-e73501034adc@pengutronix.de>
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

Convert the driver to devm_ APIs only by making use of
devm_add_action_or_reset() and devm_pm_runtime_enable() to simplify the
probe error path and to drop the .remove() callback. This also ensures
that the device release order equals the device probe error path order.

Furthermore drop the dev_set_drvdata() usage since the only user was the
.remove() callback which is removed by this commit.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 66 +++++++++++++++--------------------
 1 file changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 2aa163aef8de4ee901b9cde76ce2aad246c8c08a..49610f2389c3bbaf4de4133918fbcacb7924f672 100644
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
@@ -288,39 +301,19 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		bc->onecell_data.domains[i] = &domain->genpd;
 	}
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable pm-runtime\n");
 
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
@@ -455,7 +448,6 @@ MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
 
 static struct platform_driver imx93_blk_ctrl_driver = {
 	.probe = imx93_blk_ctrl_probe,
-	.remove = imx93_blk_ctrl_remove,
 	.driver = {
 		.name = "imx93-blk-ctrl",
 		.of_match_table = imx93_blk_ctrl_of_match,

-- 
2.47.3


