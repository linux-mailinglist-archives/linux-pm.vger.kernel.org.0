Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4191C2F92E3
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jan 2021 15:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbhAQO2V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 09:28:21 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:57927 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbhAQO2U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 09:28:20 -0500
Received: from localhost.localdomain ([92.131.99.25])
        by mwinf5d43 with ME
        id HqSa2400C0Ys01Y03qSbg7; Sun, 17 Jan 2021 15:26:36 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Jan 2021 15:26:36 +0100
X-ME-IP: 92.131.99.25
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 1/2] cpufreq: brcmstb-avs-cpufreq: Fix some resource leaks in the error handling path of the probe function
Date:   Sun, 17 Jan 2021 15:26:35 +0100
Message-Id: <20210117142635.568686-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If 'cpufreq_register_driver()' fails, we must release the resources
allocated in 'brcm_avs_prepare_init()' as already done in the remove
function.

To do that, introduce a new function 'brcm_avs_prepare_uninit()' in order
to avoid code duplication. This also makes the code more readable (IMHO).

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1->v2: be less verbose when writing the error handling path of the probe
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 3e31e5d28b79..e25ccb744187 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -597,6 +597,16 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 	return ret;
 }
 
+static void brcm_avs_prepare_uninit(struct platform_device *pdev)
+{
+	struct private_data *priv;
+
+	priv = platform_get_drvdata(pdev);
+
+	iounmap(priv->avs_intr_base);
+	iounmap(priv->base);
+}
+
 static int brcm_avs_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
@@ -732,21 +742,22 @@ static int brcm_avs_cpufreq_probe(struct platform_device *pdev)
 
 	brcm_avs_driver.driver_data = pdev;
 
-	return cpufreq_register_driver(&brcm_avs_driver);
+	ret = cpufreq_register_driver(&brcm_avs_driver);
+	if (ret)
+		brcm_avs_prepare_uninit(pdev);
+
+	return ret;
 }
 
 static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
 {
-	struct private_data *priv;
 	int ret;
 
 	ret = cpufreq_unregister_driver(&brcm_avs_driver);
 	if (ret)
 		return ret;
 
-	priv = platform_get_drvdata(pdev);
-	iounmap(priv->base);
-	iounmap(priv->avs_intr_base);
+	brcm_avs_prepare_uninit(pdev);
 
 	return 0;
 }
-- 
2.27.0

