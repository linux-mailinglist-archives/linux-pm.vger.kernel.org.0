Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0304C162DF2
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 19:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBRSMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 13:12:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38497 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBRSMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 13:12:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so8384547plj.5
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SW0vgULHscZsJ8p0egFrW5FyLS48DpnKhbm4QSHmznE=;
        b=UcY2OprhVlroXXa6CER9wxZ8cJb9sNJdYZLnuwHUPRHRQ/JuMuDsP28riO6YKooiWo
         9La7wP+4HKIM9cWOY81aJLkep3qCd9rkW8BFu8sHmPs0Z6AURoXa/nCLykMlt5htYMht
         6P89PsrMjzjvJwfpSkrdVUKs0GgGem8Nwo5gD22NQAYiUWWMqVTZ2m+QCMQDV9crLnou
         g64+LUHWBBBEPj6izTqVOuEWEtwq+x1tJDc5LYJHThWtOZUA1uXnSnwdftcpJQLDfRZ3
         /YYnrgAUf//XVqmoQmUBq1E/haJwhBEdb2OwsH7yPX55bPQnQIaUOVUv6aAn5G0NG84x
         9g7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SW0vgULHscZsJ8p0egFrW5FyLS48DpnKhbm4QSHmznE=;
        b=lTfF66I1xCK925ERpKahk8wL6iO3ZKEKiF2Ui+q3+0jQTx67/5nENnAtq3pjN2gKP5
         WRjPHHGoXmnAto+22L5MnfYEf2dfPGLSJqTe6MjWqguBGD6UMTe0uaF1KVIiGRFBPAbs
         Wga0bTdmhmOZuU2q6DkvKaeKJPihcA3lc/rcvammoK0x0nEQk6ZhuLDatP2l4uJ6xZGk
         SX5Yh8pusydkx/Ey/C3I2HWKJfggRM8/5n38lnWq/iYKArKntk0conYkuRekjHp5YRNE
         ntc2SKcg6LMMYEesbNwOkabt9cz7Nt/CGhbBk4npDRp1Uu13656uIdalkciAz4pajjl0
         ZhlA==
X-Gm-Message-State: APjAAAVQOOrvKtV1bV3pobDh8BvVxBkbtvMz86datAOqeMKPp/1Yvx2C
        zSLHbmBdvCMxvM6USezMIMQW7w==
X-Google-Smtp-Source: APXvYqwauDSPnNJdc/Rm3pO+rtR3pHW8zahL/mAGwc7MTDkJoZgBIw3WqWuDP2JSzWt0eQ7d/hleRw==
X-Received: by 2002:a17:90a:c20d:: with SMTP id e13mr4133784pjt.95.1582049564555;
        Tue, 18 Feb 2020 10:12:44 -0800 (PST)
Received: from localhost ([103.195.202.120])
        by smtp.gmail.com with ESMTPSA id b18sm5005713pfd.63.2020.02.18.10.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:12:43 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 6/8] drivers: thermal: tsens: Add watchdog support
Date:   Tue, 18 Feb 2020 23:42:10 +0530
Message-Id: <eb967cd5a374fa32d93e486b1c9fd7e56796629a.1582048155.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.3 onwards adds support for a watchdog to detect if the TSENS
HW FSM is stuck. Add support to detect and restart the FSM in the
driver. The watchdog is configured by the bootloader, we just enable the
watchdog bark as a debug feature in the kernel.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 44 +++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c     | 10 +++++++
 drivers/thermal/qcom/tsens.h        | 14 +++++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 6f1b9186770d..9de724ab6627 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -362,6 +362,7 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
  * @irq: irq number
  * @data: tsens controller private data
  *
+ * Check FSM watchdog bark status and clear if needed.
  * Check all sensors to find ones that violated their critical threshold limits.
  * Clear and then re-enable the interrupt.
  *
@@ -376,6 +377,26 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
 	struct tsens_priv *priv = data;
 	struct tsens_irq_data d;
 	int temp, ret, i;
+	u32 wdog_status, wdog_count;
+
+	if (priv->feat->has_watchdog) {
+		ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS], &wdog_status);
+		if (ret)
+			return ret;
+
+		if (wdog_status) {
+			/* Clear WDOG interrupt */
+			regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
+			regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
+			ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT], &wdog_count);
+			if (ret)
+				return ret;
+			if (wdog_count)
+				dev_dbg(priv->dev, "%s: watchdog count: %d\n", __func__, wdog_count);
+
+			/* Fall through to handle critical interrupts if any */
+		}
+	}
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		const struct tsens_sensor *s = &priv->sensor[i];
@@ -671,6 +692,7 @@ int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
+	u32 ver_minor;
 	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
@@ -720,6 +742,9 @@ int __init init_common(struct tsens_priv *priv)
 			if (IS_ERR(priv->rf[i]))
 				return PTR_ERR(priv->rf[i]);
 		}
+		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
+		if (ret)
+			goto err_put_device;
 	}
 
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
@@ -780,6 +805,25 @@ int __init init_common(struct tsens_priv *priv)
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
+		/*
+		 * Watchdog is already enabled, unmask the bark.
+		 * Disable cycle completion monitoring
+		 */
+		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+		regmap_field_write(priv->rf[CC_MON_MASK], 1);
+	}
+
 	spin_lock_init(&priv->ul_lock);
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index ce5ef0055d13..b293ed32174b 100644
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
index 2466115a9881..ad7574fe0811 100644
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
2.20.1

