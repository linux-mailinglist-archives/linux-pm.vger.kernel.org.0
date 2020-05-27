Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABC61E35E3
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 04:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgE0CuP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 22:50:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37694 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0CuP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 May 2020 22:50:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ED0CB1A0608;
        Wed, 27 May 2020 04:50:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5FF3A1A0610;
        Wed, 27 May 2020 04:50:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D642C402FB;
        Wed, 27 May 2020 10:50:03 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org
Subject: [PATCH v2] mmc: host: sdhci-esdhc-imx: add wakeup feature for GPIO CD pin
Date:   Wed, 27 May 2020 10:39:35 +0800
Message-Id: <1590547175-15070-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When use the specific GPIO to detect the card insert/remove, we can
also add the GPIO as a wakeup source. When system suspend, insert or
remove the card can wakeup the system.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5398af4824c3..5a27511438c8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1599,6 +1599,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (esdhc_is_usdhc(imx_data)) {
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
+
+		/* GPIO CD can be set as a wakeup source */
+		host->mmc->caps |= MMC_CAP_CD_WAKE;
+
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 
@@ -1734,8 +1738,14 @@ static int sdhci_esdhc_suspend(struct device *dev)
 		mmc_retune_needed(host->mmc);
 
 	ret = sdhci_suspend_host(host);
-	if (!ret)
-		return pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		return ret;
+
+	ret = mmc_gpio_set_cd_wake(host->mmc, true);
 
 	return ret;
 }
@@ -1759,6 +1769,9 @@ static int sdhci_esdhc_resume(struct device *dev)
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
+	if (!ret)
+		ret = mmc_gpio_set_cd_wake(host->mmc, false);
+
 	return ret;
 }
 #endif
-- 
2.17.1

