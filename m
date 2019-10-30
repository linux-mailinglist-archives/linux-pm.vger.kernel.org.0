Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42A2EA32C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 19:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfJ3SWC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 14:22:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37426 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJ3SWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 14:22:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id u9so2157642pfn.4;
        Wed, 30 Oct 2019 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pa+oF3hZUeqW4RFci5wsFzOB4YnQ5ce9tEfET98r1hc=;
        b=U6u7pFKLSGa+JRMgqp9kblGervY+IyWiO4wkunKZZffv48BI4ukJQ0upxCU7W7V0vS
         rUEBcdhd1VLbIROucxSZkiAYojKyNSaHvFhzi8C+kM1n1yZEzD7wvq/gUdwdxZzF9HEz
         rZyyiky/nP14K16AaM+Fsn37480Gehzpy5UWbnHUCTzx59BcWb5eo9BG0obS8Uda52ye
         wDUjb3ICAFs/9WtQh3wSF75fq79usIy807BBD26bbPNi/jjpi8lbc0E8c6mK70f3IcGH
         JdZ92gch8Q0y6UKW3K0mZO3ofEFxDeeZn/KGOd/IMCfcHr4gdWPbeMX9AKcrmEmHgPgm
         IZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pa+oF3hZUeqW4RFci5wsFzOB4YnQ5ce9tEfET98r1hc=;
        b=NKVDZP8b6ZkWMfLc+JhvQoz+AmX70D2DEwGARlCkc7mOyczf33SkGBL8Sd64HjA/Kj
         porMiGUNnS6kXDhJ/ekszS+gZQU4fHOGYscpiNTndK5E+NLURyXSsuR9Y3JgxfyqAK4h
         qJCvptes+bMYMC5LNKqR5x7CQ1ydIurNcDgytNh6hhJ72bTwC43VtcjYtXScpaz7XVN7
         b4DFkbZHB+WAVI6ldq/raWAXYh2IWZBm8r8lJFGkggM4UYMMXBVKZItkNOHuu2wd/f3t
         C7kb18UyoyIuDqN+CV6qJtf73aG9Ww2BoB7nG6VubIkVNf6Xlc533fTJGSKkMh1maqAr
         sbuw==
X-Gm-Message-State: APjAAAVaxDno1rTAMMJ1o4TATJK7Nzt7USeqD0+lJGozC263b8K//GjB
        tVxzyKuawETiXO8vt+pnngiLqAf0
X-Google-Smtp-Source: APXvYqxSBks/kNKPqH1UTcXtmYr83X3kp7jWIIIyY0d24Kn7LnwX7gSlsY6ZvmhmTYMDEBWihXEkKw==
X-Received: by 2002:a17:90a:a00e:: with SMTP id q14mr795480pjp.132.1572459717112;
        Wed, 30 Oct 2019 11:21:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z5sm521637pgi.19.2019.10.30.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:21:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 2/6] thermal: brcmstb_thermal: Prepare to support a different process
Date:   Wed, 30 Oct 2019 11:21:28 -0700
Message-Id: <20191030182132.25763-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030182132.25763-1-f.fainelli@gmail.com>
References: <20191030182132.25763-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver is currently assuming that it is operating with a 28nm
process chip, which has a specific formula to convert temperature to a
code and vice versa. Update the code to support providing two key
values: offset and multiplier to derive the correct formulas.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 49 +++++++++++++++++-----
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 42482af0422e..2ad4eeb79f9c 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -93,17 +93,27 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
 	},
 };
 
+struct brcmstb_thermal_params {
+	unsigned int offset;
+	unsigned int mult;
+};
+
 struct brcmstb_thermal_priv {
 	void __iomem *tmon_base;
 	struct device *dev;
 	struct thermal_zone_device *thermal;
+	/* Process specific thermal parameters used for calculations */
+	struct brcmstb_thermal_params temp_params;
 };
 
 /* Convert a HW code to a temperature reading (millidegree celsius) */
-static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
+static inline int avs_tmon_code_to_temp(struct brcmstb_thermal_priv *priv,
 					u32 code)
 {
-	return (410040 - (int)((code & 0x3FF) * 487));
+	int offset = priv->temp_params.offset;
+	int mult = priv->temp_params.mult;
+
+	return (offset - (int)((code & 0x3FF) * mult));
 }
 
 /*
@@ -112,19 +122,22 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
  * @temp: temperature to convert
  * @low: if true, round toward the low side
  */
-static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
+static inline u32 avs_tmon_temp_to_code(struct brcmstb_thermal_priv *priv,
 					int temp, bool low)
 {
+	int offset = priv->temp_params.offset;
+	int mult = priv->temp_params.mult;
+
 	if (temp < -88161)
 		return 0x3FF;	/* Maximum code value */
 
-	if (temp >= 410040)
+	if (temp >= offset)
 		return 0;	/* Minimum code value */
 
 	if (low)
-		return (u32)(DIV_ROUND_UP(410040 - temp, 487));
+		return (u32)(DIV_ROUND_UP(offset - temp, mult));
 	else
-		return (u32)((410040 - temp) / 487);
+		return (u32)((offset - temp) / mult);
 }
 
 static int brcmstb_get_temp(void *data, int *temp)
@@ -142,7 +155,7 @@ static int brcmstb_get_temp(void *data, int *temp)
 
 	val = (val & AVS_TMON_STATUS_data_msk) >> AVS_TMON_STATUS_data_shift;
 
-	t = avs_tmon_code_to_temp(priv->thermal, val);
+	t = avs_tmon_code_to_temp(priv, val);
 	if (t < 0)
 		*temp = 0;
 	else
@@ -176,7 +189,7 @@ static int avs_tmon_get_trip_temp(struct brcmstb_thermal_priv *priv,
 	val &= trip->reg_msk;
 	val >>= trip->reg_shift;
 
-	return avs_tmon_code_to_temp(priv->thermal, val);
+	return avs_tmon_code_to_temp(priv, val);
 }
 
 static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
@@ -189,7 +202,7 @@ static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
 	dev_dbg(priv->dev, "set temp %d to %d\n", type, temp);
 
 	/* round toward low temp for the low interrupt */
-	val = avs_tmon_temp_to_code(priv->thermal, temp,
+	val = avs_tmon_temp_to_code(priv, temp,
 				    type == TMON_TRIP_TYPE_LOW);
 
 	val <<= trip->reg_shift;
@@ -206,7 +219,7 @@ static int avs_tmon_get_intr_temp(struct brcmstb_thermal_priv *priv)
 	u32 val;
 
 	val = __raw_readl(priv->tmon_base + AVS_TMON_TEMP_INT_CODE);
-	return avs_tmon_code_to_temp(priv->thermal, val);
+	return avs_tmon_code_to_temp(priv, val);
 }
 
 static irqreturn_t brcmstb_tmon_irq_thread(int irq, void *data)
@@ -270,19 +283,32 @@ static const struct thermal_zone_of_device_ops of_ops = {
 	.set_trips	= brcmstb_set_trips,
 };
 
+static const struct brcmstb_thermal_params brcmstb_28nm_params = {
+	.offset	= 410040,
+	.mult	= 487,
+};
+
 static const struct of_device_id brcmstb_thermal_id_table[] = {
-	{ .compatible = "brcm,avs-tmon" },
+	{ .compatible = "brcm,avs-tmon", .data = &brcmstb_28nm_params },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcmstb_thermal_id_table);
 
 static int brcmstb_thermal_probe(struct platform_device *pdev)
 {
+	const struct brcmstb_thermal_params *params;
+	const struct of_device_id *of_id = NULL;
 	struct thermal_zone_device *thermal;
 	struct brcmstb_thermal_priv *priv;
 	struct resource *res;
 	int irq, ret;
 
+	of_id = of_match_node(brcmstb_thermal_id_table, pdev->dev.of_node);
+	if (!of_id || !of_id->data)
+		return -EINVAL;
+
+	params = of_id->data;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -292,6 +318,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->tmon_base))
 		return PTR_ERR(priv->tmon_base);
 
+	memcpy(&priv->temp_params, params, sizeof(priv->temp_params));
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 
-- 
2.17.1

