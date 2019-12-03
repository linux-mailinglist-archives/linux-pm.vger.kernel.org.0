Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5C010F708
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 06:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfLCFYA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 00:24:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37600 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfLCFYA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 00:24:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so1122502pga.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 21:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pxI8Cguos0cKTF66KT8H5qjY9kYioUE26xd0gbt68Gc=;
        b=R/khThpTZ5VGKEcaAzltnXnGVMvls+2niXJixyEaM7T6feDm4Rsn+Jc+OseJvEUtQn
         90wFYjXIl233asz+Nl1z5xXwvkXUJLXtkQr0HqbiHXZbhTb7hMSWw/JI53lV3vmZo3Kb
         67TjZMFxmrfSW7V+aqyBPgll3RqxDmIqj/o5DjMfEbc6zaOqeTVrfhr/6pJ3onjPFMM2
         x/UVOR9XjeWCZ98luMqS4meyhImXXcEWvxuJTiUojMF+ok84dH+pYHCYf0fWl3drBzGp
         OJT6ha/blImEElUM064/UbT2yzBf4EbNS8+x0k9tmoMr+lrLETgFewaxbBFVENgkiJ/s
         xYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pxI8Cguos0cKTF66KT8H5qjY9kYioUE26xd0gbt68Gc=;
        b=VDhyx+H6pe/BLZajAG46oOGRDai31hDQ5EAiLl6H9aLJ69KxwTelOgdELWccTieaab
         HeR7qzT3tDvbTfw93jcT3yokQhQz+rf7G42hUZvbdjAIRcm3DIRhsGja0lE4B6SJr2Ej
         SSd4SRtQjQad6sDShq2TRgbUhvy2SzYWKFMLIpQ9F4A6/b6CI/srmtHLNygIFO6hevlc
         KoKHUP9mnZFM+W7SfWkzHfQQw9PxAPC+wJs+bUuuWaV1pv+I2UQCGJTy4WokoP9QoG1j
         +FufLI96teose22VoqmVspYGzr/cQLvOalZH8MFFQ1uB0+8tN+yqslla2q8ZslZXtxVv
         +Tdw==
X-Gm-Message-State: APjAAAUv3+2qyP2r0hS6NAxYycKV6S/x2lme36/ueSODBk3R+KTMMpnH
        HS8omt99VW2oBX5+3ZWlQxqUBA==
X-Google-Smtp-Source: APXvYqwEHaDBttyrg0oYI1U7P0VDlO3SVQ9lwX0GOb7tR2Ob8+L59vwzNbg1zoqaYEt32gep2Z6oKQ==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr3371433pgr.77.1575350639600;
        Mon, 02 Dec 2019 21:23:59 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id k19sm1449664pfg.132.2019.12.02.21.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:59 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 6/9] drivers: thermal: tsens: Add watchdog support
Date:   Tue,  3 Dec 2019 10:53:27 +0530
Message-Id: <06b51a577b17120cd6003408034ca15ff9d33b70.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.3 onwards adds support for a watchdog to detect if the TSENS
HW FSM is stuck. Add support to detect and restart the FSM in the
driver. The watchdog is configured by the bootloader, we just enable the
feature in the kernel.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 38 +++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c     | 10 ++++++++
 drivers/thermal/qcom/tsens.h        | 14 +++++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 4cf550766cf66..ecbc722eb3487 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -377,6 +377,24 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
 	struct tsens_irq_data d;
 	unsigned long flags;
 	int temp, ret, i;
+	u32 wdog_status, wdog_count;
+
+	if (priv->feat->has_watchdog) {
+		/* Watchdog is present only on v2.3+ */
+		ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS], &wdog_status);
+		if (ret)
+			return ret;
+
+		/* Clear WDOG interrupt */
+		regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
+		regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
+
+		ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT], &wdog_count);
+		if (ret)
+			return ret;
+		if (wdog_count)
+			dev_dbg(priv->dev, "%s: watchdog count: %d\n", __func__, wdog_count);
+	}
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		const struct tsens_sensor *s = &priv->sensor[i];
@@ -684,6 +702,7 @@ int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
+	u32 ver_minor;
 	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
@@ -733,6 +752,9 @@ int __init init_common(struct tsens_priv *priv)
 			if (IS_ERR(priv->rf[i]))
 				return PTR_ERR(priv->rf[i]);
 		}
+		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
+		if (ret)
+			goto err_put_device;
 	}
 
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
@@ -793,6 +815,22 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
+	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
+		/* Watchdog is present only on v2.3+ */
+		priv->feat->has_watchdog = 1;
+		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
+			priv->rf[i] = devm_regmap_field_alloc(dev, priv->tm_map,
+							      priv->fields[i]);
+			if (IS_ERR(priv->rf[i])) {
+				ret = PTR_ERR(priv->rf[i]);
+				goto err_put_device;
+			}
+		}
+		/* Enable WDOG and disable cycle completion monitoring */
+		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+		regmap_field_write(priv->rf[CC_MON_MASK], 1);
+	}
+
 	spin_lock_init(&priv->ul_lock);
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index ce5ef0055d136..b293ed32174b5 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -24,6 +24,7 @@
 #define TM_Sn_CRITICAL_THRESHOLD_OFF	0x0060
 #define TM_Sn_STATUS_OFF		0x00a0
 #define TM_TRDY_OFF			0x00e4
+#define TM_WDOG_LOG_OFF		0x013c
 
 /* v2.x: 8996, 8998, sdm845 */
 
@@ -66,6 +67,15 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_CLEAR,  TM_CRITICAL_INT_CLEAR_OFF),
 	REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_MASK,   TM_CRITICAL_INT_MASK_OFF),
 
+	/* WATCHDOG on v2.3 or later */
+	[WDOG_BARK_STATUS] = REG_FIELD(TM_CRITICAL_INT_STATUS_OFF, 31, 31),
+	[WDOG_BARK_CLEAR]  = REG_FIELD(TM_CRITICAL_INT_CLEAR_OFF,  31, 31),
+	[WDOG_BARK_MASK]   = REG_FIELD(TM_CRITICAL_INT_MASK_OFF,   31, 31),
+	[CC_MON_STATUS]    = REG_FIELD(TM_CRITICAL_INT_STATUS_OFF, 30, 30),
+	[CC_MON_CLEAR]     = REG_FIELD(TM_CRITICAL_INT_CLEAR_OFF,  30, 30),
+	[CC_MON_MASK]      = REG_FIELD(TM_CRITICAL_INT_MASK_OFF,   30, 30),
+	[WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0,  7),
+
 	/* Sn_STATUS */
 	REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
 	REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 05d5f73178683..f93f7509a5a46 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -440,6 +440,18 @@ enum regfield_ids {
 	CRIT_THRESH_13,
 	CRIT_THRESH_14,
 	CRIT_THRESH_15,
+
+	/* WATCHDOG */
+	WDOG_BARK_STATUS,
+	WDOG_BARK_CLEAR,
+	WDOG_BARK_MASK,
+	WDOG_BARK_COUNT,
+
+	/* CYCLE COMPLETION MONITOR */
+	CC_MON_STATUS,
+	CC_MON_CLEAR,
+	CC_MON_MASK,
+
 	MIN_STATUS_0,		/* MIN threshold violated */
 	MIN_STATUS_1,
 	MIN_STATUS_2,
@@ -484,6 +496,7 @@ enum regfield_ids {
  * @adc:      do the sensors only output adc code (instead of temperature)?
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
+ * @has_watchdog: does this IP support watchdog functionality?
  * @max_sensors: maximum sensors supported by this version of the IP
  */
 struct tsens_features {
@@ -491,6 +504,7 @@ struct tsens_features {
 	unsigned int crit_int:1;
 	unsigned int adc:1;
 	unsigned int srot_split:1;
+	unsigned int has_watchdog:1;
 	unsigned int max_sensors;
 };
 
-- 
2.17.1

