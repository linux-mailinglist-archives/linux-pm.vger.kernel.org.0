Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41813B2AB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgANTG1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:06:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44834 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgANTG0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:06:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so6806789pgl.11;
        Tue, 14 Jan 2020 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bf0QfjjCsEX6qf2wgGfocQt3AiGtxcihlNrld2yiLRI=;
        b=FSwE2eZhaM7nJ7cTgrrBAV6iKrrO/hGwchd/X7aWSYE2ukOUFyVX655ZvOD15Z+Hmp
         T91KugPoI8ZJ/ViKtd5gHA74xwYojhutrSgCUx31ZArAOd37a/2iwEw+blOhxOg1+RIZ
         pSAuHklHQku2gfAbnAN0TomOhoMfbK26PxKtLk0bDEVqkGXc2SS7CKiD2h6NQDC6XXk1
         C4FsSEgU3pq9bMfDV0Ii4eHpAVI03rm/xMNWEqj8jLLtZ5eNPOOw3pLWvL/elZ1OSic1
         cz5Br4dWgqteE8oBdldD2wWlfJzsS1IiEihJfp2cQUaOizLplbRvaGSJPeo4AE+/e9Oo
         M5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bf0QfjjCsEX6qf2wgGfocQt3AiGtxcihlNrld2yiLRI=;
        b=Ak2HE6O2dEwmmBC7NuZkIB/OGCqXKFptwyaN2BL0U1I+NdS6Bdo9Uto1Vxni7zHUJC
         QiR41iWPV+dV+dJTfe03igNQ1R179J/o7/CxtZSKG4W/z2arL7bwcjYJLhXqAM4BTWVu
         +VmbzqGt1L61DLAKQ/P7npNiGJACbHHyPjxyXd6ET7cyWVNvZ2sQIhnPNIJnrT6OYe20
         sguz7ghCbRFFcBj0Qr91PNpRxWeHhpFpvlXbedUtTkr8E96GAZuEvmURPApIluckrC3X
         8wbX1XeW4h1KCy20LUSt0UUn+xp8MoULB272orvfrRVDEMIfK5r4ZQOeBGp9e8Yv3AkE
         EuPQ==
X-Gm-Message-State: APjAAAWVPwEIOaYFikt0fs9nYWFa6FYJQMKdcMB5HoLl8Bge6G+4Oz4C
        7fETVQqEWS/sA64YxyFUK0yJwFpq
X-Google-Smtp-Source: APXvYqynKjbTkRhlt7ZhyxsnDVhelk0OAduVnKYo4JAVKCKxwfB13+aOcP4ENHL5soycSATHTCi7Aw==
X-Received: by 2002:a63:d00f:: with SMTP id z15mr28363045pgf.143.1579028785296;
        Tue, 14 Jan 2020 11:06:25 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a195sm19284528pfa.120.2020.01.14.11.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:06:24 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v3 2/6] thermal: brcmstb_thermal: Prepare to support a different process
Date:   Tue, 14 Jan 2020 11:06:03 -0800
Message-Id: <20200114190607.29339-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114190607.29339-1-f.fainelli@gmail.com>
References: <20200114190607.29339-1-f.fainelli@gmail.com>
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
 drivers/thermal/broadcom/brcmstb_thermal.c | 47 +++++++++++++++-------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 680f1a070606..2d555e7b884a 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -102,18 +102,27 @@ static struct avs_tmon_trip avs_tmon_trips[] = {
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
+	const struct brcmstb_thermal_params *temp_params;
 };
 
 /* Convert a HW code to a temperature reading (millidegree celsius) */
-static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
+static inline int avs_tmon_code_to_temp(struct brcmstb_thermal_priv *priv,
 					u32 code)
 {
-	return (AVS_TMON_TEMP_OFFSET -
-		(int)((code & AVS_TMON_TEMP_MAX) * AVS_TMON_TEMP_SLOPE));
+	int offset = priv->temp_params->offset;
+	int mult = priv->temp_params->mult;
+
+	return (offset - (int)((code & AVS_TMON_TEMP_MASK) * mult));
 }
 
 /*
@@ -122,21 +131,22 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
  * @temp: temperature to convert
  * @low: if true, round toward the low side
  */
-static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
+static inline u32 avs_tmon_temp_to_code(struct brcmstb_thermal_priv *priv,
 					int temp, bool low)
 {
+	int offset = priv->temp_params->offset;
+	int mult = priv->temp_params->mult;
+
 	if (temp < AVS_TMON_TEMP_MIN)
 		return AVS_TMON_TEMP_MAX;	/* Maximum code value */
 
-	if (temp >= AVS_TMON_TEMP_OFFSET)
+	if (temp >= offset)
 		return 0;	/* Minimum code value */
 
 	if (low)
-		return (u32)(DIV_ROUND_UP(AVS_TMON_TEMP_OFFSET - temp,
-					  AVS_TMON_TEMP_SLOPE));
+		return (u32)(DIV_ROUND_UP(offset - temp, mult));
 	else
-		return (u32)((AVS_TMON_TEMP_OFFSET - temp) /
-			      AVS_TMON_TEMP_SLOPE);
+		return (u32)((offset - temp) / mult);
 }
 
 static int brcmstb_get_temp(void *data, int *temp)
@@ -154,7 +164,7 @@ static int brcmstb_get_temp(void *data, int *temp)
 
 	val = (val & AVS_TMON_STATUS_data_msk) >> AVS_TMON_STATUS_data_shift;
 
-	t = avs_tmon_code_to_temp(priv->thermal, val);
+	t = avs_tmon_code_to_temp(priv, val);
 	if (t < 0)
 		*temp = 0;
 	else
@@ -188,7 +198,7 @@ static int avs_tmon_get_trip_temp(struct brcmstb_thermal_priv *priv,
 	val &= trip->reg_msk;
 	val >>= trip->reg_shift;
 
-	return avs_tmon_code_to_temp(priv->thermal, val);
+	return avs_tmon_code_to_temp(priv, val);
 }
 
 static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
@@ -201,7 +211,7 @@ static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
 	dev_dbg(priv->dev, "set temp %d to %d\n", type, temp);
 
 	/* round toward low temp for the low interrupt */
-	val = avs_tmon_temp_to_code(priv->thermal, temp,
+	val = avs_tmon_temp_to_code(priv, temp,
 				    type == TMON_TRIP_TYPE_LOW);
 
 	val <<= trip->reg_shift;
@@ -218,7 +228,7 @@ static int avs_tmon_get_intr_temp(struct brcmstb_thermal_priv *priv)
 	u32 val;
 
 	val = __raw_readl(priv->tmon_base + AVS_TMON_TEMP_INT_CODE);
-	return avs_tmon_code_to_temp(priv->thermal, val);
+	return avs_tmon_code_to_temp(priv, val);
 }
 
 static irqreturn_t brcmstb_tmon_irq_thread(int irq, void *data)
@@ -282,8 +292,13 @@ static const struct thermal_zone_of_device_ops of_ops = {
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
@@ -299,6 +314,10 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->temp_params = of_device_get_match_data(&pdev->dev);
+	if (!priv->temp_params)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->tmon_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->tmon_base))
-- 
2.17.1

