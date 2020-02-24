Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8ED16A692
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 13:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBXM7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 07:59:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37929 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBXM7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 07:59:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so4038480plj.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0b+crmO9rkqPQx6iHoSoONTlJebCAXQkbuG5cT9oj+E=;
        b=YBs7THOfqaJHx2UfYD0aer9/g032PJNKF+gCg212GM3EkgIj5F6Gzm5t2gC5yKC2DB
         mOF2/QUc2eLEyIghsWZ3mqn+LI/qYvbft/xIPNYtja6njNSvl2tY5uAIaQ4iTerTk+v0
         akeY9qZFdUiwecO2DyEWdinh2KKqs1/jePVKx7MnM7EkAuEyYui3qF4ky4m2UzYvUlrO
         Ya3yt1qdvKsOl9FETvOvLre/zm5SyCzs9VFG3GsldLvKb8aCgh/1UVSn1xvbvpFaGyXp
         FoYYlvJkaZqStMbDQPa4S5uaq0f8E+/d+VTe7V7Tdg7U3vMc1GQ42twBOpEP8eSQfYNh
         sc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0b+crmO9rkqPQx6iHoSoONTlJebCAXQkbuG5cT9oj+E=;
        b=hSjUdtgXTF0fknOxfrVBiGimtGA/KqOmY8XXw37O7BhPK7AzcVfdS6pnXCKLLJhhlT
         0n0vFeeUFfq0mhTLCDeZV5RgDYvItz3zBJmozVyfztkZIxoRWuG/6M2Opag18svoTn3z
         ZR6GLvzzL6oSqOFAcjinwks7BEtdhiJ7G3k6cbnHEmToyYcCHOrFxFHBqC6zo9K6dV4T
         sKG29YvbqmZ9I09fGiP4HHwIr1gJRcGPNo2KdVfoLXNm9M3f42Qludw/ATnTJQ6ienm1
         aCrYQicENQFcnBHhLVe6kqQtiel2ah+h9ogzknkrWG7w8H2Z4G6OgTtdB5XVnwSsauOQ
         CD7g==
X-Gm-Message-State: APjAAAVSbXUFJdOEMiR1Su9snM4srk80+L84n9ysRGiDiG9ueo9Wl00t
        fQc1IE+iA+jyrB/mfvZ7+RUDVw==
X-Google-Smtp-Source: APXvYqxM4Ed/GJS+QjzeHJyFYijBKNOt8sM4lRsIe5ggPy6M1CHQgDaCTijDv3M/fgpeIQO7H1VfRg==
X-Received: by 2002:a17:90b:14a:: with SMTP id em10mr19948477pjb.4.1582549145944;
        Mon, 24 Feb 2020 04:59:05 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id r72sm12550112pjb.18.2020.02.24.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:59:05 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 1/8] drivers: thermal: tsens: De-constify struct tsens_features
Date:   Mon, 24 Feb 2020 18:28:48 +0530
Message-Id: <db2d68dc7f10c9ba018866209b160936f14acfca.1582548319.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582548319.git.amit.kucheria@linaro.org>
References: <cover.1582548319.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/8dea9b377998de1617dd14aee90c421297262c5c.1582048155.git.amit.kucheria@linaro.org
---
 drivers/thermal/qcom/tsens-8960.c |  2 +-
 drivers/thermal/qcom/tsens-v0_1.c |  6 +++---
 drivers/thermal/qcom/tsens-v1.c   |  6 +++---
 drivers/thermal/qcom/tsens-v2.c   |  6 +++---
 drivers/thermal/qcom/tsens.h      | 12 ++++++------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index fb77acb8d13b..a383a57cfbbc 100644
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
index 4b8dd6de02ce..959a9371d205 100644
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
index bd2ddb684a45..b682a4df0081 100644
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
index a4d15e1abfdd..f1c8ec62e69f 100644
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
index e24a865fbc34..be364bf1d5a6 100644
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
2.20.1

