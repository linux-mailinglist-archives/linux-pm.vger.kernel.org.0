Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7523311BDF4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLKUcA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 15:32:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42284 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLKUb7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 15:31:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so4580615pgb.9;
        Wed, 11 Dec 2019 12:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nAMyfH4P60dFRDU7m+hosqMx6pv601HbAJ1pQGyNcMg=;
        b=B+s5PbZT4Zv9XI0AjaTATaBNhgYdHqBe7Fe7Fgk6Gne3AfcV6tuqSt2zTuOKkdpzGC
         dWt4Srz4rqMCpUQHt1SNCub76Jw4jI1uspbhQmdK19gtgOt8aLASF+eY4XxtuJ/D9cEF
         bigPSiDXbdFkXCZU9wq2ctSA4B3zePmC56PxF8jVdbfEsZ/e9xzLnSkYdpNBCWQ8FkEU
         c9l2+prZDlmxmUpMzrCUGeVxqvGBVNy2f4BESOpRxkOhb0iGulRPcnqXSTGp3yRw5IYm
         GoEtJlKtZR6oLs6rUesOmwDWLxwy0yk6zmH6Vw8dp/nCpSLBUpJ7kMKCdl+85uanBSvv
         Emxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nAMyfH4P60dFRDU7m+hosqMx6pv601HbAJ1pQGyNcMg=;
        b=UJrodp+D29mayWZGLPNedrPVjuL5dNYnMExG80tpgj80RawcQr6d1Cp2s8R8rdCbO+
         qloYvSPHiHKOBxXHTj9LhI3B8JbW6tR54KSDjSNMCRofY5cusQFrYwdtKXH55tnVepC+
         9htaiNxMKBTLUzbLALcAEyCrUpwjU1s3DoIeq5aebpNjzXjBqMS5xGNzCsg5Db18frcT
         ol1+6PQriLrwYPZ5Ix5f1PJ7jbIC7Md90C0vEGQDmpc6JrVKzNKJAzWeGM+3WLVo5xWP
         EXbZw630shfVluUssYMjEF2ZiQ8RkWyxq+99yR6f1bN9GJZeCpecYJRhc3Nts/NOi9w/
         ZNTg==
X-Gm-Message-State: APjAAAUJjHzILDFKVbDwXp49JNTfUw6EQo/ANQQNP7DyCJ63Ylkq5o4q
        CcW6NI6lt8wLF3/Il6Xs0ug=
X-Google-Smtp-Source: APXvYqw905t0OmMYtvu4Tzun1VIheUVmOA2Ss2518GBDlhcYIjEyhuan6FZ4Ec2WugUBJLN5NY8CXg==
X-Received: by 2002:a63:5b0a:: with SMTP id p10mr6243248pgb.228.1576096318549;
        Wed, 11 Dec 2019 12:31:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19sm917570pju.11.2019.12.11.12.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:31:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/6] thermal: brcmstb_thermal: Prepare to support a different process
Date:   Wed, 11 Dec 2019 12:31:39 -0800
Message-Id: <20191211203143.2952-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211203143.2952-1-f.fainelli@gmail.com>
References: <20191211203143.2952-1-f.fainelli@gmail.com>
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
 drivers/thermal/broadcom/brcmstb_thermal.c | 54 ++++++++++++++++------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 680f1a070606..68f89f7c7e7f 100644
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
+	struct brcmstb_thermal_params temp_params;
 };
 
 /* Convert a HW code to a temperature reading (millidegree celsius) */
-static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
+static inline int avs_tmon_code_to_temp(struct brcmstb_thermal_priv *priv,
 					u32 code)
 {
-	return (AVS_TMON_TEMP_OFFSET -
-		(int)((code & AVS_TMON_TEMP_MAX) * AVS_TMON_TEMP_SLOPE));
+	int offset = priv->temp_params.offset;
+	int mult = priv->temp_params.mult;
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
+	int offset = priv->temp_params.offset;
+	int mult = priv->temp_params.mult;
+
 	if (temp < AVS_TMON_TEMP_MIN)
-		return AVS_TMON_TEMP_MAX;	/* Maximum code value */
+		return AVS_TMON_TEMP_MASK;	/* Maximum code value */
 
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
@@ -282,19 +292,32 @@ static const struct thermal_zone_of_device_ops of_ops = {
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
@@ -304,6 +327,7 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->tmon_base))
 		return PTR_ERR(priv->tmon_base);
 
+	memcpy(&priv->temp_params, params, sizeof(priv->temp_params));
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 
-- 
2.17.1

