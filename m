Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E533483FC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 22:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhCXVoj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbhCXVoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 17:44:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C07C06174A;
        Wed, 24 Mar 2021 14:44:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y6so161106eds.1;
        Wed, 24 Mar 2021 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4I8SseA+uAjlNmTN1EGCZ72iXk5YAbU2hCUeH8QSlQ=;
        b=ZIsW/OfUynNNsmjFSoPRr8WWcbqh2ZDKBROsEmev3YYEk1WQP2WstIjf4u7JeA/4bY
         XbZorPerq/S+GpN5sznpqKqj0g9eekbUCsERMojrdgYm/hn959bAlOfEiRoHTSZqyZdo
         5CFIfOjA0SvcsyCrD4L5QfBtvIoTBSBiDFIEg3yT2hyU3W3ONyvCUDIv8G3eXGs7s/Y6
         uuQrXgeRB3b58IRsXP+KDHK4pBr+epNmZ1tGNftD1isJCcTidnUkn0/iADWCVgewBKuN
         yYHqc3ZacOm1dCMRR2qgKBg9dzybJIKkAiWKXKiZLeB+rqE9mEnwLqhThRjQKMb7/wI2
         IUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4I8SseA+uAjlNmTN1EGCZ72iXk5YAbU2hCUeH8QSlQ=;
        b=rHzpZ7AXTH0JZoMTCx+mgWG7C4owQgjnq+lMYXZX25TYj/lA5GNFUvg76wSPB9Tx0D
         plLxuDmmAJuqGs4JWfqIuBiYGjdq22XYhvyM3lMiXP5Mjqc4eBitkS6Lr8OBCxp2Y0sJ
         lQK48UyyQt0MNVUxtcdHfj4XdcFBM7c0rcYRJXvIhYgvKaQTP35AdDYC84huK2XkRbUo
         IeOJF6jZQTQU0wHpi1+ayBM+BJmwa14aVe97YJsUvJLCF0xsOKQNl4xPUZ5C8Wb6wxvu
         aYGEWyEjqLzPGrsoHSUQ0qvMZHwSVE/PWSeBSlUxYuYT2XLbqWEvaD6J4AK9w5DF86Hg
         M8ZQ==
X-Gm-Message-State: AOAM530aQcAhFgXyCdVm5MY/ix91UorSIgD2kbRxpAO0l3Rfx8Abrd81
        Jpu1NxWXpMu37F1fkNB2BuA=
X-Google-Smtp-Source: ABdhPJxEha5r6bnLXQQUEirqd/5IlE1pC2JJFU2/vIfZnIxE8bUyT67P++5sjUTWlZHo0WNYdMaDcQ==
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr5569173edb.29.1616622255762;
        Wed, 24 Mar 2021 14:44:15 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id z9sm1871211edr.75.2021.03.24.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:44:15 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v13 5/9] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Wed, 24 Mar 2021 22:43:59 +0100
Message-Id: <20210324214404.798-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324214404.798-1-ansuelsmth@gmail.com>
References: <20210324214404.798-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Device based on tsens VER_0 contains a hardware bug that results in some
problem with sensor enablement. Sensor id 6-11 can't be enabled
selectively and all of them must be enabled in one step.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 86585f439985..95fcccafae14 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -27,9 +27,9 @@
 #define EN			BIT(0)
 #define SW_RST			BIT(1)
 #define SENSOR0_EN		BIT(3)
+#define MEASURE_PERIOD		BIT(18)
 #define SLP_CLK_ENA		BIT(26)
 #define SLP_CLK_ENA_8660	BIT(24)
-#define MEASURE_PERIOD		1
 #define SENSOR0_SHIFT		3
 
 /* INT_STATUS_ADDR bitmasks */
@@ -126,17 +126,34 @@ static int resume_8960(struct tsens_priv *priv)
 static int enable_8960(struct tsens_priv *priv, int id)
 {
 	int ret;
-	u32 reg, mask;
+	u32 reg, mask = BIT(id);
 
 	ret = regmap_read(priv->tm_map, CNTL_ADDR, &reg);
 	if (ret)
 		return ret;
 
-	mask = BIT(id + SENSOR0_SHIFT);
+	/* HARDWARE BUG:
+	 * On platforms with more than 6 sensors, all remaining sensors
+	 * must be enabled together, otherwise undefined results are expected.
+	 * (Sensor 6-7 disabled, Sensor 3 disabled...) In the original driver,
+	 * all the sensors are enabled in one step hence this bug is not
+	 * triggered.
+	 */
+	if (id > 5)
+		mask = GENMASK(10, 6);
+
+	mask <<= SENSOR0_SHIFT;
+
+	/* Sensors already enabled. Skip. */
+	if ((reg & mask) == mask)
+		return 0;
+
 	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg | SW_RST);
 	if (ret)
 		return ret;
 
+	reg |= MEASURE_PERIOD;
+
 	if (priv->num_sensors > 1)
 		reg |= mask | SLP_CLK_ENA | EN;
 	else
-- 
2.30.2

