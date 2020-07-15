Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C94221812
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 00:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGOWpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 18:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgGOWpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 18:45:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50914C061755;
        Wed, 15 Jul 2020 15:45:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so7877517wmo.1;
        Wed, 15 Jul 2020 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSHTL/qZogSjk1wO7b+ejuOIxDcTABgsaA2ehIcOuNQ=;
        b=l7yPardrrhmbRMrWutIl+KhLaS2AJhZTE6aDuLh3xW9EEadz2rOHI4ADjDfkMcSx0u
         ot5xXWPIgoyu8AE+aOPTWHgERdbH0cjioqmvPaeOk0Zrz52NSBhdDkoNiI6FFS80WJlR
         z8PZyuX/eZhIeJQdETXtQcTwigc+CmpzY1ETtdG1cJYQbTnzOekFS3Sd7zz+0WtTXQrM
         WOHLrskI5lP5iPuruQL7Qa8bjtMRI7WVkOG820qLxSWKEkCZ3rzgq5mrFqI8cisqtaiQ
         JDMXSnTodNGY4N5+YL49tvQb2gMaZEWcBSZqny5Aw2nfYjx6eXEjMXuMWrRYHQNEDI6u
         7Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSHTL/qZogSjk1wO7b+ejuOIxDcTABgsaA2ehIcOuNQ=;
        b=slpYsN4CDbhNOTdmYWSf2OArXtIIt0IQ6STfuJTZNRbs+4LZM27oGZ2+nn7DDbv0YS
         v19vFmkqvG+/FIkJi5D6IWxga8yGRhFLHKKeKs/0r2T+rbpynIyyJ5MvtI8oa+uiVlxw
         15ytkcRA5wBgGGkClm54iBTbxhjqHcWtXyH38OxubPxpDCOCL51aQe97aurwkXupL3QG
         UQHh4+tez8qnDSiqzr3rItHAUgOsQi+1Rycr7PkwrPog0XKemT2EXgZ/VOoBNWiInrWY
         oOamBPNPzm9yPUXs0gwKn4WLLyWvCcBtWhMt1jR72JYuAsuuLaelO/xPWr4mB+LvuhEi
         1jAg==
X-Gm-Message-State: AOAM533olszVWbJBMh73g+O0UIMrePPATRi+BhwYeW4E6zhvOi/auBnD
        RRwaRkdsB/YR7UItPXPy5mk=
X-Google-Smtp-Source: ABdhPJyEpeU+85g0hQNr/pmFERueh6E8y4wDvOslPNIfjQ78xD4IVyzkF5MQ4O5454OT2dami8jC0Q==
X-Received: by 2002:a05:600c:2202:: with SMTP id z2mr1777495wml.13.1594853149012;
        Wed, 15 Jul 2020 15:45:49 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id b186sm5759898wme.1.2020.07.15.15.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:45:48 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 7/7] drivers: thermal: tsens: add set_trip support for 8960
Date:   Thu, 16 Jul 2020 00:45:02 +0200
Message-Id: <20200715224503.30462-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715224503.30462-1-ansuelsmth@gmail.com>
References: <20200715224503.30462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add custom set_trip function for 8960 needed to set trip point to the
tsens driver for 8960 driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 78 +++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index b302bfb924a6..f6ed2450a7ba 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -93,6 +93,15 @@
 						TSENS_8064_SENSOR9_EN | \
 						TSENS_8064_SENSOR10_EN)
 
+/* Trips: from very hot to very cold */
+enum tsens_trip_type {
+	TSENS_TRIP_STAGE3 = 0,
+	TSENS_TRIP_STAGE2,
+	TSENS_TRIP_STAGE1,
+	TSENS_TRIP_STAGE0,
+	TSENS_TRIP_NUM,
+};
+
 u32 tsens_8960_slope[] = {
 			1176, 1176, 1154, 1176,
 			1111, 1132, 1132, 1199,
@@ -110,6 +119,16 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
 	return adc_code * slope + offset;
 }
 
+static int mdegC_to_code(int degC, const struct tsens_sensor *s)
+{
+	int slope, offset;
+
+	slope = thermal_zone_get_slope(s->tzd);
+	offset = CAL_MDEGC - slope * s->offset;
+
+	return degC / slope - offset;
+}
+
 static void notify_uspace_tsens_fn(struct work_struct *work)
 {
 	struct tsens_sensor *s = container_of(work, struct tsens_sensor,
@@ -447,6 +466,64 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
 	return -ETIMEDOUT;
 }
 
+static int set_trip_temp_ipq8064(void *data, int trip, int temp)
+{
+	unsigned int reg_th, reg_cntl;
+	int ret, code, code_chk, hi_code, lo_code;
+	const struct tsens_sensor *s = data;
+	struct tsens_priv *priv = s->priv;
+
+	code = mdegC_to_code(temp, s);
+	code_chk = code;
+
+	if (code < THRESHOLD_MIN_CODE || code > THRESHOLD_MAX_CODE)
+		return -EINVAL;
+
+	ret = regmap_read(priv->tm_map, STATUS_CNTL_ADDR_8064, &reg_cntl);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->tm_map, THRESHOLD_ADDR, &reg_th);
+	if (ret)
+		return ret;
+
+	hi_code = (reg_th & THRESHOLD_UPPER_LIMIT_MASK)
+			>> THRESHOLD_UPPER_LIMIT_SHIFT;
+	lo_code = (reg_th & THRESHOLD_LOWER_LIMIT_MASK)
+			>> THRESHOLD_LOWER_LIMIT_SHIFT;
+
+	switch (trip) {
+	case TSENS_TRIP_STAGE3:
+		code <<= THRESHOLD_MAX_LIMIT_SHIFT;
+		reg_th &= ~THRESHOLD_MAX_LIMIT_MASK;
+		break;
+	case TSENS_TRIP_STAGE2:
+		if (code_chk <= lo_code)
+			return -EINVAL;
+		code <<= THRESHOLD_UPPER_LIMIT_SHIFT;
+		reg_th &= ~THRESHOLD_UPPER_LIMIT_MASK;
+		break;
+	case TSENS_TRIP_STAGE1:
+		if (code_chk >= hi_code)
+			return -EINVAL;
+		code <<= THRESHOLD_LOWER_LIMIT_SHIFT;
+		reg_th &= ~THRESHOLD_LOWER_LIMIT_MASK;
+		break;
+	case TSENS_TRIP_STAGE0:
+		code <<= THRESHOLD_MIN_LIMIT_SHIFT;
+		reg_th &= ~THRESHOLD_MIN_LIMIT_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_write(priv->tm_map, THRESHOLD_ADDR, reg_th | code);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static const struct tsens_ops ops_8960 = {
 	.init		= init_8960,
 	.calibrate	= calibrate_8960,
@@ -455,6 +532,7 @@ static const struct tsens_ops ops_8960 = {
 	.disable	= disable_8960,
 	.suspend	= suspend_8960,
 	.resume		= resume_8960,
+	.set_trip_temp	= set_trip_temp_ipq8064,
 };
 
 struct tsens_plat_data data_8960 = {
-- 
2.27.0

