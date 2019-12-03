Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8746110F6FC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 06:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfLCFXn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 00:23:43 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36888 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfLCFXm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 00:23:42 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep17so1035738pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 21:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/nB1fYa5n9lqubCyUBVAtESr33YzPH2vKA4mG1o1BMA=;
        b=G4NHZCtaScI13ud9Mx0Sn8CcLA81Z5aAXTxjKQg/X07I6EdgIJgEm/z74mLnrkqGe7
         suhIexigSE/ogvHIMIwb2iucC++fFuyFbohiwt7Qejhb5x65KrM14ZEekYlQGhKZN8iM
         y7XDyQueLzSEpRW/oAeLCEHVP6l7TtteYWNCOh4jLSmCUHY4If9PoKUV0yYdD3P67sMX
         RtksZUSxCq8QGbvUebXvCOWXklHuLymyZXQrCh7LtFAtd23QNcxuUaXwi13e2MDmKgGp
         MX3j5QOP4GTF+Kivk9dtFf5kyEYImstQUdKQQLQ9wfWBuQWThGMZqDLfXi//IVJeMuhy
         RVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/nB1fYa5n9lqubCyUBVAtESr33YzPH2vKA4mG1o1BMA=;
        b=im/awzVmSCA91e4pRh5K9iceBGDEG6q1KZe43ShjPZmU0nejRfQrndTwuiAbH3w99s
         xf2mabMsKMRjPGNr8ldCQsZnixADvWBOp9iwaTBHwJrY8JO5FrwN6xCLShLquIYN4Dxt
         gd4jhR318h3We981txfO2RKPKy5RGXKYzPbyOGiQT/2w22zOPKUznae5U8l58UHujaNq
         tkN5BMMl4Cogo8/VrR5wCk2Vrpu366nvbjKk5ReNwc5kvjNJiDtbtZEG5H9l/3GX/HAu
         Ul2tEKBwbEdGJJHCGvupNN3tuFAwKP+T5jKW9oF0VwH8jvBDb2skLBUbz8d/BhoexVF5
         DfOA==
X-Gm-Message-State: APjAAAWndjeHejogZzIZZD/4lUy8cz5yfcoJVIrApGjmiTEN72YCnJpB
        rPuL0Ct4LJ4ywkzgp7l9tE6guQ==
X-Google-Smtp-Source: APXvYqw01mqlT0Kebsq/fKYvNedhsbHCUq2O5qTPO5WnkhpvtR1a82eSvBHbHEjQ/goPXrNmy0qVfA==
X-Received: by 2002:a17:90a:db43:: with SMTP id u3mr3587202pjx.56.1575350620471;
        Mon, 02 Dec 2019 21:23:40 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id o67sm1453975pga.62.2019.12.02.21.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:39 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/9] drivers: thermal: tsens: De-constify struct tsens_features
Date:   Tue,  3 Dec 2019 10:53:22 +0530
Message-Id: <4ea61a3f0c1b58e139eb20493a5d757d1eddb878.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

struct tsens_features is currently initialized as part of platform data
at compile-time and not modifiable. We now have some usecases in feature
detection across IP versions where it is more flexible to update the
features after probing registers.

Remove const qualifier from tsens_features and the encapsulating
tsens_plat_data.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c |  2 +-
 drivers/thermal/qcom/tsens-v0_1.c |  6 +++---
 drivers/thermal/qcom/tsens-v1.c   |  6 +++---
 drivers/thermal/qcom/tsens-v2.c   |  6 +++---
 drivers/thermal/qcom/tsens.h      | 12 ++++++------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index fb77acb8d13b9..a383a57cfbbcb 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -279,7 +279,7 @@ static const struct tsens_ops ops_8960 = {
 	.resume		= resume_8960,
 };
 
-const struct tsens_plat_data data_8960 = {
+struct tsens_plat_data data_8960 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8960,
 };
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 4b8dd6de02ce4..959a9371d205c 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -327,7 +327,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 
 /* v0.1: 8916, 8974 */
 
-static const struct tsens_features tsens_v0_1_feat = {
+static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
 	.crit_int	= 0,
 	.adc		= 1,
@@ -377,7 +377,7 @@ static const struct tsens_ops ops_8916 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_plat_data data_8916 = {
+struct tsens_plat_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
 	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
@@ -392,7 +392,7 @@ static const struct tsens_ops ops_8974 = {
 	.get_temp	= get_temp_common,
 };
 
-const struct tsens_plat_data data_8974 = {
+struct tsens_plat_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
 	.feat		= &tsens_v0_1_feat,
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index bd2ddb684a45d..b682a4df00810 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -299,7 +299,7 @@ static int calibrate_8976(struct tsens_priv *priv)
 
 /* v1.x: msm8956,8976,qcs404,405 */
 
-static const struct tsens_features tsens_v1_feat = {
+static struct tsens_features tsens_v1_feat = {
 	.ver_major	= VER_1_X,
 	.crit_int	= 0,
 	.adc		= 1,
@@ -368,7 +368,7 @@ static const struct tsens_ops ops_generic_v1 = {
 	.get_temp	= get_temp_tsens_valid,
 };
 
-const struct tsens_plat_data data_tsens_v1 = {
+struct tsens_plat_data data_tsens_v1 = {
 	.ops		= &ops_generic_v1,
 	.feat		= &tsens_v1_feat,
 	.fields	= tsens_v1_regfields,
@@ -381,7 +381,7 @@ static const struct tsens_ops ops_8976 = {
 };
 
 /* Valid for both MSM8956 and MSM8976. Sensor ID 3 is unused. */
-const struct tsens_plat_data data_8976 = {
+struct tsens_plat_data data_8976 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8976,
 	.hw_ids		= (unsigned int[]){0, 1, 2, 4, 5, 6, 7, 8, 9, 10},
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index a4d15e1abfddd..f1c8ec62e69f9 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -27,7 +27,7 @@
 
 /* v2.x: 8996, 8998, sdm845 */
 
-static const struct tsens_features tsens_v2_feat = {
+static struct tsens_features tsens_v2_feat = {
 	.ver_major	= VER_2_X,
 	.crit_int	= 1,
 	.adc		= 0,
@@ -81,14 +81,14 @@ static const struct tsens_ops ops_generic_v2 = {
 	.get_temp	= get_temp_tsens_valid,
 };
 
-const struct tsens_plat_data data_tsens_v2 = {
+struct tsens_plat_data data_tsens_v2 = {
 	.ops		= &ops_generic_v2,
 	.feat		= &tsens_v2_feat,
 	.fields	= tsens_v2_regfields,
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
-const struct tsens_plat_data data_8996 = {
+struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
 	.feat		= &tsens_v2_feat,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index e24a865fbc34c..be364bf1d5a63 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -440,7 +440,7 @@ struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
 	unsigned int		*hw_ids;
-	const struct tsens_features	*feat;
+	struct tsens_features	*feat;
 	const struct reg_field		*fields;
 };
 
@@ -481,7 +481,7 @@ struct tsens_priv {
 
 	struct regmap_field		*rf[MAX_REGFIELDS];
 	struct tsens_context		ctx;
-	const struct tsens_features	*feat;
+	struct tsens_features		*feat;
 	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
 
@@ -502,15 +502,15 @@ int tsens_set_trips(void *_sensor, int low, int high);
 irqreturn_t tsens_irq_thread(int irq, void *data);
 
 /* TSENS target */
-extern const struct tsens_plat_data data_8960;
+extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern const struct tsens_plat_data data_8916, data_8974;
+extern struct tsens_plat_data data_8916, data_8974;
 
 /* TSENS v1 targets */
-extern const struct tsens_plat_data data_tsens_v1, data_8976;
+extern struct tsens_plat_data data_tsens_v1, data_8976;
 
 /* TSENS v2 targets */
-extern const struct tsens_plat_data data_8996, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.17.1

