Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B62219FE
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 04:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgGPC2l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgGPC2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:28:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B05C061755;
        Wed, 15 Jul 2020 19:28:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so8699533wmo.1;
        Wed, 15 Jul 2020 19:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESxPvjOg/M0b94Gq1OGqi1pUcN1nE3zYRLLlIkcJLwU=;
        b=IqzVrO6bpFVJMnKF2Iy149n7Mgr+SnjSUNZjbbTDQENDIMhpAVei/3t/9kzQdXzyqF
         xIkY5biSBqPjVD46aTsOWllm34DxiezGe+KNDf5vWNPuy0HdRmhfMHzYnpoY8sYG3V1U
         yKCnUG+IYmkIOIYQ7ZuXcO0qWcn7isGFvCkdQbplnbOr5dkC84McFxAxY6N/eDmeMNzf
         oKdvs0SseOkLD9okfGLuNKh+ZIqI/CNnetsYAaFm4RRXt0mqByA5VK+3KKVvqVnGaKcX
         7WINjQRjF2J7akzU21GZhv9MR4AWDiYrZksfG82Jm7SWdMbXutCxjNbANM9Dy4mVUBSG
         Xuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESxPvjOg/M0b94Gq1OGqi1pUcN1nE3zYRLLlIkcJLwU=;
        b=jBDmgEOWYQLiJT3idNFnvasexj/32GsSByPNhJtIZOdGo6mPeAVLCUFw6KzCV4hUUr
         0YdouUxDcBks5R4sVJ/YYc0QX0W/Igb8LfmeUgNLMIgA1lGWWfuOckp2qWpisxtg4sF2
         fVMgKNvZtp5a5jfGzAx9dzQZ6v3OxsIro3odgMRglMTa6w2dnTjM6nuUlpODrqb8RnGv
         T5WbdV4iHgkF11I+IZ3GVeO0OqvXVuxXjENPUeAD6c9x8zGcOeFD0X6Gw3jg0g4kGtqL
         W87yu5+f8VafBwdLKdpb4j57yfxcQ62knv/V1+qxa27EwFu+Ym0GsHhRRMkZPgfDOzRT
         fjIA==
X-Gm-Message-State: AOAM530pyGgB6sq/6x3kLV/tXb8L/gOhhdrc3JO5Rs5eyJhGMH7DBrUv
        Tok9MLa9eRoCMghBx6cQpag=
X-Google-Smtp-Source: ABdhPJxKEIBLPZoqyV04U9TIOoADK3i9+srFiq66flMSuILK932X+QGrfSNjtvMsCX01JN7SgV/sUw==
X-Received: by 2002:a1c:7d85:: with SMTP id y127mr2277029wmc.181.1594866518123;
        Wed, 15 Jul 2020 19:28:38 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id u1sm7477611wrb.78.2020.07.15.19.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:28:37 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 7/7] drivers: thermal: tsens: add set_trip support for 8960
Date:   Thu, 16 Jul 2020 04:28:16 +0200
Message-Id: <20200716022817.30439-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716022817.30439-1-ansuelsmth@gmail.com>
References: <20200716022817.30439-1-ansuelsmth@gmail.com>
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
index 20d0bfb10f1f..4ad65ab3fd18 100644
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
@@ -448,6 +467,64 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
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
@@ -456,6 +533,7 @@ static const struct tsens_ops ops_8960 = {
 	.disable	= disable_8960,
 	.suspend	= suspend_8960,
 	.resume		= resume_8960,
+	.set_trip_temp	= set_trip_temp_ipq8064,
 };
 
 struct tsens_plat_data data_8960 = {
-- 
2.27.0

