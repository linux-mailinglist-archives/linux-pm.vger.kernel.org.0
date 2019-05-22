Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C065A26576
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2019 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfEVOMv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 May 2019 10:12:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46392 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbfEVOMv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 May 2019 10:12:51 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hTRyy-0001BD-5k; Wed, 22 May 2019 16:12:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangqing@rock-chips.com, eballetbo@gmail.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] Revert "thermal: rockchip: fix up the tsadc pinctrl setting error"
Date:   Wed, 22 May 2019 16:12:36 +0200
Message-Id: <20190522141236.26987-1-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 28694e009e512451ead5519dd801f9869acb1f60.

The commit causes multiple issues in that:
- the added call to ->control does potentially run unclocked
  causing a hang of the machine
- the added pinctrl-states are undocumented in the binding
- the added pinctrl-states are not backwards compatible, breaking
  old devicetrees.

Fixes: 28694e009e51 ("thermal: rockchip: fix up the tsadc pinctrl setting error")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/thermal/rockchip_thermal.c | 36 +++---------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index bda1ca199abd..7ef9c7efe950 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -172,9 +172,6 @@ struct rockchip_thermal_data {
 	int tshut_temp;
 	enum tshut_mode tshut_mode;
 	enum tshut_polarity tshut_polarity;
-	struct pinctrl *pinctrl;
-	struct pinctrl_state *gpio_state;
-	struct pinctrl_state *otp_state;
 };
 
 /**
@@ -1283,8 +1280,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	thermal->chip->control(thermal->regs, false);
-
 	error = clk_prepare_enable(thermal->clk);
 	if (error) {
 		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
@@ -1310,30 +1305,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	thermal->chip->initialize(thermal->grf, thermal->regs,
 				  thermal->tshut_polarity);
 
-	if (thermal->tshut_mode == TSHUT_MODE_GPIO) {
-		thermal->pinctrl = devm_pinctrl_get(&pdev->dev);
-		if (IS_ERR(thermal->pinctrl)) {
-			dev_err(&pdev->dev, "failed to find thermal pinctrl\n");
-			return PTR_ERR(thermal->pinctrl);
-		}
-
-		thermal->gpio_state = pinctrl_lookup_state(thermal->pinctrl,
-							   "gpio");
-		if (IS_ERR_OR_NULL(thermal->gpio_state)) {
-			dev_err(&pdev->dev, "failed to find thermal gpio state\n");
-			return -EINVAL;
-		}
-
-		thermal->otp_state = pinctrl_lookup_state(thermal->pinctrl,
-							  "otpout");
-		if (IS_ERR_OR_NULL(thermal->otp_state)) {
-			dev_err(&pdev->dev, "failed to find thermal otpout state\n");
-			return -EINVAL;
-		}
-
-		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
-	}
-
 	for (i = 0; i < thermal->chip->chn_num; i++) {
 		error = rockchip_thermal_register_sensor(pdev, thermal,
 						&thermal->sensors[i],
@@ -1404,8 +1375,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 
 	clk_disable(thermal->pclk);
 	clk_disable(thermal->clk);
-	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
-		pinctrl_select_state(thermal->pinctrl, thermal->gpio_state);
+
+	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
 }
@@ -1450,8 +1421,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	for (i = 0; i < thermal->chip->chn_num; i++)
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
 
-	if (thermal->tshut_mode == TSHUT_MODE_GPIO)
-		pinctrl_select_state(thermal->pinctrl, thermal->otp_state);
+	pinctrl_pm_select_default_state(dev);
 
 	return 0;
 }
-- 
2.20.1

