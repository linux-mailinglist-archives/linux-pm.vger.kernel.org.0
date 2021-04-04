Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE63539D9
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhDDUfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhDDUfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:35:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB4EC061756;
        Sun,  4 Apr 2021 13:35:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o19so10656695edc.3;
        Sun, 04 Apr 2021 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4I8SseA+uAjlNmTN1EGCZ72iXk5YAbU2hCUeH8QSlQ=;
        b=gHVVrudpqwk6BKc70SzI/EGmRh+XiyHKhjeOSRp+GVIReRWn7bsViLC7DVk/ZiitSD
         ZqAayRhmK7Ys+/BSJ4V9DJ+HGKSVtAW3DhnwUKzYRFe3mSmbvxeZDm8S7hkgvF/yX20h
         NGIxNSsA21VUYl6KftVAfKBW+mAvNdpHBkGxNzaRrrFocvKedXy03ajxPdISxVm0iu8y
         MDCo3IBJki3jNkAJyyffrXe84OMNM00Hdx+i7n50W0FoEZl7xrucBWY/VZsYCBSK9WqC
         B0CXqINlGV4V9YfjHud7bNHmKSEXl7GWfRBMFVzpxDgJS+DVHGbUo9Kiz5zifY6GZ9KT
         YBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4I8SseA+uAjlNmTN1EGCZ72iXk5YAbU2hCUeH8QSlQ=;
        b=ueOl65JVeOA+rSWWHMqjwV0JMYhImvCLHVOJtGKMeTtLBj3MoC2HVetfRqwAKkICyC
         vl1YeTQfE8cdjVVSjj0NCpUZSoxK4YYDOnn+EebT/+GW0R/Z7dqY8xuMR9IyP8C7mPu6
         lbw7gZCQxNVp1Bez1RG+RVAyDThJROs2r12ubqRFUoNeEF6Xfh63yteEhqY1vyOZAQu/
         aSO6WV/eEC1HAab2f4XMrf9nTJoI2aK6GbMo5OXEvL+Y7w+xoAjbrWE2kvs1ix2za2Ep
         oFszZTrWXPehFh4E6sI1zeNK2TCbuEHOpczFzDxW6k1QToTqfakNb0f7qzYkQxA9eROQ
         PnpQ==
X-Gm-Message-State: AOAM533/9Hf0VSxP8dM3XmRz2vXi3fgNPSpir0Ocylg2kNmZi2DtGYIu
        aQNYZuT9bE1C3P1nsWh9lmQ9V/kBLQY=
X-Google-Smtp-Source: ABdhPJxCG1LbUCc2+gqmgWSDiRCJIaQRZTpaweAIh3eGU+m8dYKt8HwUZh9EbwbNARARrlKw6iAWrg==
X-Received: by 2002:aa7:c957:: with SMTP id h23mr27276746edt.301.1617568513184;
        Sun, 04 Apr 2021 13:35:13 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-52-251-187.retail.telecomitalia.it. [79.52.251.187])
        by smtp.googlemail.com with ESMTPSA id s4sm7191140ejf.108.2021.04.04.13.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:35:12 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14 5/9] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Sun,  4 Apr 2021 16:48:19 +0200
Message-Id: <20210404144823.31867-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210404144823.31867-1-ansuelsmth@gmail.com>
References: <20210404144823.31867-1-ansuelsmth@gmail.com>
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

