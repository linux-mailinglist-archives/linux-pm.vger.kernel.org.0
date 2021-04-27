Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB736CBE3
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbhD0TpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbhD0TpM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:12 -0400
Date:   Tue, 27 Apr 2021 19:44:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64hkk+BdQbKjS64uOQGSpFV0aqdzOq8HuS5LWhL2Zio=;
        b=W51Qhto7LzlQvTtAYCtyPCwR1GepTFBwX1qbFZWwjjCL0jyrN8Ohom+45wVREYsgOOjzNt
        Fi1FgT4PqAndq2/sE4fbnoYLGox96NTPBpezqB3xpUylKcRouuA/RSB5DflAuJQB+N9gah
        FgZJ2aDsfsuHiZW1cfoxTKTsU/C8OTUx9lI3tENPt+CYSsQ0j662pAZFMgolIfc9N0wxBh
        ktR1ypc4CDiEVdw33NeUcB/qV70a11hTUoyJWVaydBOfxTktH6tELqK39OGAkaBl5aKKE9
        MjZFAUi/lkcP95/QJrxpupSN1SGzAIgdPGofiajOikGJEYVnYxscKMckLX95jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64hkk+BdQbKjS64uOQGSpFV0aqdzOq8HuS5LWhL2Zio=;
        b=vHE/fh9TA1E5zkTT7GWrv+nr7eLw1k4qcJGJcX09+6w3kH1zOEaswprJSHt1DSp+73kemk
        t6vqCS78iQbwUcBA==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Use init_common for msm8960
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210420183343.2272-5-ansuelsmth@gmail.com>
References: <20210420183343.2272-5-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161955266769.29796.1431929500829979560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     fdda131f8fbadee2dfc21f0787d11547b42a961e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//fdda131f8fbadee2dfc21f0787d11547b42a961e
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Tue, 20 Apr 2021 20:33:38 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 14:09:23 +02:00

thermal/drivers/tsens: Use init_common for msm8960

Use init_common and drop custom init for msm8960.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210420183343.2272-5-ansuelsmth@gmail.com
---
 drivers/thermal/qcom/tsens-8960.c | 52 +------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 0dd15e8..83746ee 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -173,56 +173,6 @@ static void disable_8960(struct tsens_priv *priv)
 	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
 }
 
-static int init_8960(struct tsens_priv *priv)
-{
-	int ret, i;
-	u32 reg_cntl;
-
-	priv->tm_map = dev_get_regmap(priv->dev, NULL);
-	if (!priv->tm_map)
-		return -ENODEV;
-
-	/*
-	 * The status registers for each sensor are discontiguous
-	 * because some SoCs have 5 sensors while others have more
-	 * but the control registers stay in the same place, i.e
-	 * directly after the first 5 status registers.
-	 */
-	for (i = 0; i < priv->num_sensors; i++) {
-		if (i >= 5)
-			priv->sensor[i].status = S0_STATUS_OFF + 40;
-		priv->sensor[i].status += i * 4;
-	}
-
-	reg_cntl = SW_RST;
-	ret = regmap_update_bits(priv->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
-	if (ret)
-		return ret;
-
-	if (priv->num_sensors > 1) {
-		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
-		reg_cntl &= ~SW_RST;
-		ret = regmap_update_bits(priv->tm_map, CONFIG_ADDR,
-					 CONFIG_MASK, CONFIG);
-	} else {
-		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
-		reg_cntl &= ~CONFIG_MASK_8660;
-		reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
-	}
-
-	reg_cntl |= GENMASK(priv->num_sensors - 1, 0) << SENSOR0_SHIFT;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	reg_cntl |= EN;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
@@ -338,7 +288,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 };
 
 static const struct tsens_ops ops_8960 = {
-	.init		= init_8960,
+	.init		= init_common,
 	.calibrate	= calibrate_8960,
 	.get_temp	= get_temp_8960,
 	.enable		= enable_8960,
