Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64B342460
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 19:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCSSP5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhCSSPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 14:15:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F771C06174A;
        Fri, 19 Mar 2021 11:15:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so11198929ejr.5;
        Fri, 19 Mar 2021 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JB/0ftcOjq9+74oC8IThoTALbFw94cd5VKg5MgqN4Pk=;
        b=SRc693H7ZgGhNga1rtb3J5AceNhvVJizMEl8s6EO0J/X5Z/pRCd5WkjchI1Okex5e0
         7321d/VhkZfIlvBCT0l6OYZ6cPaXDQyKZepZvXbBtt2uMFbl9pCSJRh0AYTVu/cYjQTy
         8W47OdbLa2TkJsOn5a2LTfXZPlAHCrdHN8Mp0PvrCacTi21e2wAYdLzj+U9oV74RmUnd
         OKuy3o+8uGpzlytDF+nI7Uw/CMRnuxDo1RzRyXSs7uTFYiQprxkcp8z+n8VaN85XTRjn
         1DnA0HTGgxjOE+GQba2s97Hy8T3P/2V+KsvO9B8/Ub55xVMrMlVfcDHe4fvTppMyZRa3
         BIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JB/0ftcOjq9+74oC8IThoTALbFw94cd5VKg5MgqN4Pk=;
        b=Q8Qz0fRWYGjylMpmOquZr1IQWOvnnAvFmzLjkm1AnAvn4ugFRocYsVwUvEXbNJm5j+
         d5tz2V7244ZLFja0PhTAMibvdVKkqooTbvOY41BOqQki+RyQs/+y7SW4iMVvHck4SW55
         SYtRLJ14TwhasUW3iREp7XKHSAFsYEbe0sqCaKp8BBdhj4w8OcqQUW406+3/U29xUWPJ
         AZmWFxp++K+n9Q/lNFY+nY/zpk7U9plx6u+Nhm7Xq+2eZAKZOiso0yav7vX+rmCv3jHN
         PTm3aoU27yZY7N69pbMvCBlLP0REqlIJfiNGUmVSDpGB0FCBKU9DOJmQSr6QDhWj9U0G
         r6Gg==
X-Gm-Message-State: AOAM531dZWESSU/k9sjkQgeIYlG0ZbghItREkxT3n2RMTuLTz0ufFOPS
        Ijcy22DUyclhvvwDWIg5Ijc=
X-Google-Smtp-Source: ABdhPJzQbJlHakNck3Cud33+SWwjJ+hk4THiuV3vj43fjCO/Pn9881zCt8pPuFVbAfXvp9fVVy2Ftg==
X-Received: by 2002:a17:906:23e9:: with SMTP id j9mr5699812ejg.78.1616177731774;
        Fri, 19 Mar 2021 11:15:31 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id u13sm4170288ejn.59.2021.03.19.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:15:31 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 5/9] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Fri, 19 Mar 2021 19:15:08 +0100
Message-Id: <20210319181512.7757-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319181512.7757-1-ansuelsmth@gmail.com>
References: <20210319181512.7757-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Device based on tsens VER_0 contains a hardware bug that results in some
problem with sensor enablement. Sensor id 6-11 can't be enabled
selectively and all of them must be enabled in one step.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 86585f439985..bf8dfaf06428 100644
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
+	 * On platform with more than 6 sensors, all the remaining
+	 * sensors needs to be enabled all togheder or underfined
+	 * results are expected. (Sensor 6-7 disabled, Sensor 3
+	 * disabled...) In the original driver, all the sensors
+	 * are enabled in one step hence this bug is not triggered.
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

