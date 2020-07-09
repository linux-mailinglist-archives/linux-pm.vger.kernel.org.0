Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECD121A9F0
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 23:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgGIVv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 17:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgGIVv4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 17:51:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7EC08C5DC;
        Thu,  9 Jul 2020 14:51:56 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d15so2997801edm.10;
        Thu, 09 Jul 2020 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItfQ8L/Er3Hk4c2uSxofOAEu4o/bM64EAYLfz2K5ECQ=;
        b=ZxPgT4AUp2+vo6mZ57j8c7IbaQnpm3m6ie3CigiT9z5eT/38nTYREAtriLTnkq8Lwf
         4GpfBUCR+F4TwwtJDKmTMikAA1mYDkCtZnvenE0cd5r25is63mIL2oMDAwCJfIi7kttm
         J/1DTMkeonJSRMV9ua+TFSTSS1Y8Qjsr5GUALrcsfDmNmX1QW7LyP6AxMSx3wp04RxdP
         nTHeNyEh7Yd7TMelPlk+WfgjOwiAjrEYG2zHWnWX+mIMjXc7maFTPWUgQnKpQMV70x+o
         IYPo6KlxpBxCqrrTZAcNZconvzQTlE3xHJpZbTfvic42kgu5iYu35H+grluIU4UdG/M8
         DvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItfQ8L/Er3Hk4c2uSxofOAEu4o/bM64EAYLfz2K5ECQ=;
        b=oDoHhkjQIHTQzV/vPY3ZGXH0mFSut5L6Jumyy9ANpZmhdiKPYw93K5ZqsZoYXCXdTx
         fwGYNtRyFX/+2InFzypRkV0VyB3EFZ8X8geuVSC5pPvmKrfw7h79bUmvkxgcrKGyVCHT
         5hSIgTJ0Sx7o+1QAObc22j31L7l/+dYdDfV4bTNLXez3tys+Tgz9sZfSziWrxokYhSVu
         io5FJGii7O+jADOGTVYMH2CQFatFBHg7ZNjTPNRKOWs51Xtpp8VWHVyn+7MnNwk8rqtk
         S+sTIPnlIjao0/WaXkO/mUp97Cqx5DWIZkaLH34fImEmaoAKF84n/yTM+hQKE5HeSghx
         kIsQ==
X-Gm-Message-State: AOAM531wbWz/FEjk/K2ZyfLJTRndWVT8aUcxFYJOj0fCTjUS+tsEV3fg
        qZuIsBbV/CvaYVdtuiPvlME=
X-Google-Smtp-Source: ABdhPJz3P5Adz2dZxyYUEZXHp3Fcl0wTBk1V3i80J7DWD2gRIAxKKfpvDMvc+IKU01B3QLekYTH+sA==
X-Received: by 2002:aa7:d285:: with SMTP id w5mr46413518edq.174.1594331515142;
        Thu, 09 Jul 2020 14:51:55 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id e16sm2498260ejt.14.2020.07.09.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:51:54 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] drivers: thermal: tsens: add set_trip support for 8960
Date:   Thu,  9 Jul 2020 23:51:36 +0200
Message-Id: <20200709215136.28044-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709215136.28044-1-ansuelsmth@gmail.com>
References: <20200709215136.28044-1-ansuelsmth@gmail.com>
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
index 2dc670206896..321791b8aabf 100644
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
@@ -442,6 +461,64 @@ static int get_temp_8960(const struct tsens_sensor *s, int *temp)
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
@@ -450,6 +527,7 @@ static const struct tsens_ops ops_8960 = {
 	.disable	= disable_8960,
 	.suspend	= suspend_8960,
 	.resume		= resume_8960,
+	.set_trip_temp	= set_trip_temp_ipq8064,
 };
 
 struct tsens_plat_data data_8960 = {
-- 
2.27.0

