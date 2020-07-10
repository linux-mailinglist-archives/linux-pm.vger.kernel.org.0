Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D7E21BDF7
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGJTqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgGJTqT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 15:46:19 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD61C08E6DC;
        Fri, 10 Jul 2020 12:46:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so7289446ejn.10;
        Fri, 10 Jul 2020 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItfQ8L/Er3Hk4c2uSxofOAEu4o/bM64EAYLfz2K5ECQ=;
        b=FHYMRFQOPQBahtYhgz8M1TfOZPMyoiEsVlfldmypxKAHVYOe/DPRNk9hocDMdZBXbL
         Xp8/QHddPGFWBsp/EzId0hEm/PBFZHHy+SylzYzP0Nm2y+dbCDepU/81bNe3FD/+BrwU
         q7WxCE+3AT8aLGvvBZvT2bKG6qL0LJwb7Erju6Ox5h98vhLfOLgShWBHscBGOAy53Et3
         5stZvE08xLJc0R88/1KtZLrQJpX6MO5g7ZCHzd0SAGOSgz8DvXeRHCQK9KRekyrdXkTh
         2hG11a9n7P8CpiQHQg4BVJYidFhgZuHt6GEOuCpwccEU1iOePvwIUsdtWUMn3XQoTMLN
         cvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItfQ8L/Er3Hk4c2uSxofOAEu4o/bM64EAYLfz2K5ECQ=;
        b=bXk9LklmwWjZ72r4rYNZkd2GHr+p3+reLmSjJPO+R+p84owtwBUaFdnK8RdCG9bkjk
         fzqRvGdaBGtttzYHXZ1gCDlnDvI+aw/KUNJoPEynTKgd+dhNDvjOvF+DNO0GjiMAglCp
         LsiQGSboDPPARpCWGYDj9JkJrzvMJoR3w2wjH+maOW8cniJYPJS7inuWJhhzyVV9QBb2
         QGhBnEoyQ++ghNCWpMmHjWYTF91KrJRbvn/Rn+sAD2kM/sGm/hhOICf1WtBKXAIwPP1J
         /81DS4frqkN8c0eU/jjoJASPENZxQWNJcOy1Iw0xgHsvpFqlmNe2HlWF/+F4+1PBw2bN
         n5uA==
X-Gm-Message-State: AOAM53270Hysim7ZJpjlHjSoj8ZPFolHHWKT1F/cKWKNeWDlG95YhwDM
        5WLNGuW554SGafeJOyeJDhE=
X-Google-Smtp-Source: ABdhPJyegOvV7pWaDXp0wHvfbYv+3ypu27dlyWQ1uNiRjTQ2sOXdeePRRXUtVRAURro7V1LfQcouwQ==
X-Received: by 2002:a17:906:b353:: with SMTP id cd19mr55772899ejb.395.1594410377750;
        Fri, 10 Jul 2020 12:46:17 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id kt4sm4155768ejb.48.2020.07.10.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:46:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] drivers: thermal: tsens: add set_trip support for 8960
Date:   Fri, 10 Jul 2020 21:45:57 +0200
Message-Id: <20200710194558.26487-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710194558.26487-1-ansuelsmth@gmail.com>
References: <20200710194558.26487-1-ansuelsmth@gmail.com>
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

