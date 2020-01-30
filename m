Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82B214DBAD
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 14:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgA3N1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 08:27:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36021 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgA3N1h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 08:27:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so1356193plm.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2020 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqQ2qbeoSZa2PGdmqyIm1yHv26U9JsdtE5B4NJEhX9Y=;
        b=ZOG4264hRgHwSSisQw4z3u9jvWtCv/0jSHi48vOuW0UzV4lmVu3P3B/8aKgofx3QsX
         DWtMvc6PX0fdDHVfz4YR//+ZL7v39v4TAX/6y+wvkZULgUJJkF6JOiL1W0WFAmePWhdf
         644470zZqasXfKryoKB22bki4OUMPGBpFZp0fSqUeUaFGLVa4HKafywBxFPC75hDwyxp
         l4aR/PudgehUez3TYy09TmoZEFygSMHNdIG+PGIR+ZLX1JUigrGpHbcz+ihF+285ZFGX
         FX29/1FW5/XDA6yjbsJlGkUPVfnx2Ig/ZCuSAV74J0Zxki35f9w/xhzjdZ6ZTlhMdZZK
         lRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqQ2qbeoSZa2PGdmqyIm1yHv26U9JsdtE5B4NJEhX9Y=;
        b=JereQJlxNFwWaSlkAkRg5gf7BBkKjXdinGdFl0S+vjX5xbW4oiwoQkoariZ4I7nRK3
         mMDAlGNrTf3ZkABdej9GIE2JQVbF1WJKRRbU2xtCCHtOKmdq1iB10d2gaT85hiilG9to
         k+lC5bJvbmCiWozlygf8A10N1B6Ac+VaEqIFsvtOPDB1OlOSdWyQJ6FqDErOLxgggHxq
         41za0nz0MK/fbYwVhl2VI0Cbdcrm1qeQVLFkjOrGfJGejrqpHhvgF2GQtHcVJJZ+ao17
         Z/Pnkv1T/VoJ0+gmVzSM/mYj1ihoM9McqkyNg1Qs+U/aQYLblKJjfI1xfC2iRcdXgvir
         r54A==
X-Gm-Message-State: APjAAAVfT13gZzEqh+hPBMumrcgIIJIZOCUQG+d+Jtto0gvxSTOjqPSZ
        eH1z3ELoZsHWv1xJXbvsf8cswA==
X-Google-Smtp-Source: APXvYqzUD0IgVe2pGtgvpz8T9uNpSadKIFg7p8tm3jLipHveiSPQO6SQSCqAHMHFAG0NqWZDV2nFUw==
X-Received: by 2002:a17:90a:cf08:: with SMTP id h8mr5899662pju.81.1580390857038;
        Thu, 30 Jan 2020 05:27:37 -0800 (PST)
Received: from localhost ([45.127.45.97])
        by smtp.gmail.com with ESMTPSA id c10sm6529664pgj.49.2020.01.30.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:27:36 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 5/7] drivers: thermal: tsens: Add watchdog support
Date:   Thu, 30 Jan 2020 18:57:08 +0530
Message-Id: <a1f7d34b7281c4e40307f67fce9a5c435ee5e7eb.1580390127.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1580390127.git.amit.kucheria@linaro.org>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
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
---
 drivers/thermal/qcom/tsens-common.c | 43 +++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c     | 10 +++++++
 drivers/thermal/qcom/tsens.h        | 14 ++++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 9d1594d2f1ed..ee2414f33606 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -377,6 +377,26 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
 	struct tsens_irq_data d;
 	unsigned long flags;
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
+			return IRQ_HANDLED;
+		}
+	}
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		const struct tsens_sensor *s = &priv->sensor[i];
@@ -677,6 +697,7 @@ int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
+	u32 ver_minor;
 	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
@@ -726,6 +747,9 @@ int __init init_common(struct tsens_priv *priv)
 			if (IS_ERR(priv->rf[i]))
 				return PTR_ERR(priv->rf[i]);
 		}
+		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
+		if (ret)
+			goto err_put_device;
 	}
 
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
@@ -786,6 +810,25 @@ int __init init_common(struct tsens_priv *priv)
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
 	spin_lock_init(&priv->crit_lock);
 	tsens_enable_irq(priv);
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
index a252619c2399..cf0511a947d4 100644
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

