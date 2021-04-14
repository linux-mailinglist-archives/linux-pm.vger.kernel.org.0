Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F0F35ED55
	for <lists+linux-pm@lfdr.de>; Wed, 14 Apr 2021 08:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349256AbhDNGlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 02:41:19 -0400
Received: from m12-18.163.com ([220.181.12.18]:36018 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349254AbhDNGlS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Apr 2021 02:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=T2FgI
        EBnBRmAKPQPAqT1xukyZIsaFUReHtLwyWIQa0g=; b=GugPYnrjMakS1fdwnzdcR
        H0IENcwqferJJ8eUD4U5Jx2otuEqgEzwOxQPs+bk0LN+f/m9n8AjQBSLsTXXFFVL
        WNuDWZ5A8dfcWRGGBRgEv8OygDVVKQDHL3IhuMphxye5rjuu9PkTlcNqQYJt4Wqg
        7Oj2oaxolkRPhjibFCrNnA=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowACXm+NdjnZg1iswdw--.55593S2;
        Wed, 14 Apr 2021 14:40:31 +0800 (CST)
From:   dingsenjie@163.com
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] thermal: tegra: Use devm_platform_ioremap_resource_byname
Date:   Wed, 14 Apr 2021 14:39:43 +0800
Message-Id: <20210414063943.96244-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACXm+NdjnZg1iswdw--.55593S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3ZF13tw4fWFW8GFW3KFg_yoW8uFyUpr
        1xGa4xu398CF48Aa4fJr43ZFs8tF129ayUu34rGw1Sya98JryUAF18JFWrZFW8A3ykKF1U
        tFWYyr48AFyDXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbOz3UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiHh90yFSIt3Yg3wAAsf
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/thermal/tegra/soctherm.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 66e0639..ee289e2 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2118,7 +2118,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	struct tegra_soctherm *tegra;
 	struct thermal_zone_device *z;
 	struct tsensor_shared_calib shared_calib;
-	struct resource *res;
 	struct tegra_soctherm_soc *soc;
 	unsigned int i;
 	int err;
@@ -2140,26 +2139,20 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 
 	tegra->soc = soc;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "soctherm-reg");
-	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
+	tegra->regs = devm_platform_ioremap_resource_byname(pdev, "soctherm-reg");
 	if (IS_ERR(tegra->regs)) {
 		dev_err(&pdev->dev, "can't get soctherm registers");
 		return PTR_ERR(tegra->regs);
 	}
 
 	if (!tegra->soc->use_ccroc) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "car-reg");
-		tegra->clk_regs = devm_ioremap_resource(&pdev->dev, res);
+		tegra->clk_regs = devm_platform_ioremap_resource_byname(pdev, "car-reg");
 		if (IS_ERR(tegra->clk_regs)) {
 			dev_err(&pdev->dev, "can't get car clk registers");
 			return PTR_ERR(tegra->clk_regs);
 		}
 	} else {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "ccroc-reg");
-		tegra->ccroc_regs = devm_ioremap_resource(&pdev->dev, res);
+		tegra->ccroc_regs = devm_platform_ioremap_resource_byname(pdev, "ccroc-reg");
 		if (IS_ERR(tegra->ccroc_regs)) {
 			dev_err(&pdev->dev, "can't get ccroc registers");
 			return PTR_ERR(tegra->ccroc_regs);
-- 
1.9.1


