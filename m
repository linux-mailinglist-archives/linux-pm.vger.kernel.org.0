Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E453F7FBA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 20:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKKTVs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 14:21:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43295 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfKKTVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 14:21:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so10028930pgh.10
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 11:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UVAsYyOtTY7yCZZg91Nnlffb0PtNpyh5VPvYW2P7zjk=;
        b=J0NutncSIf5O1lj9Itw2YBF0ST/hNSRqdlY3Srhe9qCNbYbanXEZ2/YFBOrz9iCQfw
         v5jauQry5zjKgucYfWMLFQt2Q6kc6UK3TtisAhEu/ZnxKh7mihgVugdB2E93Uq8TO2z3
         mXdfPPNa0RaQipmLOUb5RnedHJ9vSihtVBj8lH/H1wf8znBFNiXmdXGgjldHh/s9H1h6
         GubwhNLl1AAqzONSRAmp2oMXnxUM8AsIhN3znGlsa/A3hjNvDDHAIQGUULG2dgxfPq3e
         VZMwXcSyAhKRSN2TSbYLwpACKIykgylYO9OZ3r9DSub+XYcR/wjs57nf/FFbeAavSF5s
         1gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UVAsYyOtTY7yCZZg91Nnlffb0PtNpyh5VPvYW2P7zjk=;
        b=nEGy9WhLtjp2cuAG5NoibKcNhbkOhrastYQzvQGGfk3xNbZnaTdNS23NhGg0o1tIcY
         hDOqRVU/qTYYGo+Ep8duAc8PR0xjBXMUlhua1G8B9Rj9CKwomH2uZ+6KM+bfbeAjB4hg
         K5wzx7At+9RQOTSRp2jch66Cw+94sMRSFXun1YcZradxFUQi3eXFFla2/qW09UKa/eWI
         yjSo601+cygeQauyeh26BbcPwd6X5wsJZnce78VdXw/IVTl5guWwpNFSc+3Lhgt7sfCA
         bFWHTiMB6FtLVzqlnf4mgouZoSsVv9qVu1fOT+0mHvCDV1Y0+l291iylBonVO1ZC2xNz
         HBVA==
X-Gm-Message-State: APjAAAXqQR4gsijoC1pyLIzYp+31F67pPXba4HsaVyZSY3lu0cQsK6Cm
        E0atTMzxheamFU4lsdDHc7rkwQ==
X-Google-Smtp-Source: APXvYqwuRwemijMVRpuMi9VV7VN31pQzOofvWdh/nRcT7u6+D/+FlOPjMJb1q/jScM9/WmtLs023Vg==
X-Received: by 2002:a17:90a:e50a:: with SMTP id t10mr761842pjy.67.1573500102466;
        Mon, 11 Nov 2019 11:21:42 -0800 (PST)
Received: from localhost ([49.248.192.129])
        by smtp.gmail.com with ESMTPSA id u3sm15707494pgp.51.2019.11.11.11.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 11:21:42 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/3] drivers: thermal: tsens: Add watchdog support
Date:   Tue, 12 Nov 2019 00:51:28 +0530
Message-Id: <c08cf285b8696c4fd00706b85cd3c88d12f97df3.1573499020.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573499020.git.amit.kucheria@linaro.org>
References: <cover.1573499020.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1573499020.git.amit.kucheria@linaro.org>
References: <cover.1573499020.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.3 onwards adds support for a watchdog to detect if the TSENS
HW FSM is frozen. Add support to detect and restart the FSM in the
driver. The watchdog is configured by the bootloader, we just enable the
feature in the kernel.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 41 +++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c     | 10 +++++++
 drivers/thermal/qcom/tsens.h        | 12 +++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 2989cb952cdb..9432518502a7 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -378,6 +378,28 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
 	bool enable = true, disable = false;
 	unsigned long flags;
 	int temp, ret, i;
+	u32 wdog_status, wdog_count, ver_minor;
+
+	ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
+	if (ret)
+		return ret;
+
+	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
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
+			dev_err(priv->dev, "%s: watchdog count: %d\n", __func__, wdog_count);
+	}
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		struct tsens_sensor *s = &priv->sensor[i];
@@ -685,6 +707,7 @@ int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
+	u32 ver_minor;
 	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
@@ -734,6 +757,9 @@ int __init init_common(struct tsens_priv *priv)
 			if (IS_ERR(priv->rf[i]))
 				return PTR_ERR(priv->rf[i]);
 		}
+		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
+		if (ret)
+			goto err_put_device;
 	}
 
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
@@ -794,6 +820,21 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
+	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
+		/* Watchdog is present only on v2.3+ */
+		for (i = 0, j = WDOG_BARK_STATUS; j <= CC_MON_MASK; i++, j++) {
+			priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
+							      priv->fields[j]);
+			if (IS_ERR(priv->rf[j])) {
+				ret = PTR_ERR(priv->rf[j]);
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
index 47d831df0803..4184850d1e42 100644
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
index 9b5a30533c52..7608e7877a7b 100644
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
-- 
2.17.1

