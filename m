Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818E431E3AD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 01:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhBRA5x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 19:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBRA5j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 19:57:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A425C06178A;
        Wed, 17 Feb 2021 16:56:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b3so785561wrj.5;
        Wed, 17 Feb 2021 16:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pg19YmQGFbUbtJC9noxXJEHibGA0dQJc7KbdOb0hk3k=;
        b=szU2oikcMT+CssIzWLvspTnZZdsUAWClDvRhiJ35kgn4qrlzCOeLvp0a1OlqnM/C99
         h5wNCNuEQD7VbrY0SwMkajAJjSgKHT19XemJxeq4u4H8Qc86eI16MkfLqpjSOQoESjPm
         w3OHTkLrHHnAmNCxJyJHcVze+EIMj753rofnP8mKHp3IVFvyMJcyeYEG715pTyKeGtA+
         aH20IwQzDjMSVbuBYy1RWfBEAHtmSBSW76XCNRsaYFS9ChjRyxSXvzjYBt/2ERungH9g
         CgaE2uQ5/Sf+vQ4IIvZWmeWfJX4iHUuYpc43W5IKjcWcGzxl0+WYQzUCnUFmC3PvLS5S
         mVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pg19YmQGFbUbtJC9noxXJEHibGA0dQJc7KbdOb0hk3k=;
        b=UuNYGoQBYsaq0G45v9GuZX035CebYHUA6a8XbifMoqvPZlI7A53Al1z9CZkeuve3Cq
         cygB931Hs60lBfNWIHpsB9mT0uknkoo/YkLKTl6pMtCko383pBlvms3WXaOVwR5e2xF6
         pC9Qi+ouyzuJDQp5I54aAoHfRuE4oA5YhqZXyL1o+TlSdmr6DJdbqjwSpE80ra+Y8FX1
         dK0rxvJhhcsxMCre6KPBuhn4hfVJdZu35qqQvdlnEoEZI/z9rZqBKj2wOkNVHFLmrJBy
         1NvamulLwM0cnhn3kv0/p3xfNLn2D/NOZAW9w1HzqTGjDMSNhKNgp14F4h7xZDK9FAMU
         gBbA==
X-Gm-Message-State: AOAM532/wTY2f4qJ0Op4KeSJWOKSEwGPUYxj6LZHRkSuhZ5QatTfZ2Pl
        yoc5QbhqA85SxKQUL2JOp4HC1p6qgTE=
X-Google-Smtp-Source: ABdhPJz74sq7L4dnCSOgGnjK6VYNMI6UfN0jhYZnt01ZBfF6DBYTWsnnJMxT8EPohAQgX15mN6J7QA==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr1681492wrt.67.1613609787742;
        Wed, 17 Feb 2021 16:56:27 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-11-13-110.retail.telecomitalia.it. [87.11.13.110])
        by smtp.googlemail.com with ESMTPSA id t16sm6336079wrp.87.2021.02.17.16.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:56:27 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 5/8] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Wed, 17 Feb 2021 20:40:07 +0100
Message-Id: <20210217194011.22649-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's present a hardware bug in tsens VER_0 where if sensors upper to id
6 are enabled selectively, underfined results are expected. Fix this by
enabling all the remaining sensor in one step.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 86585f439985..248aaa65b5b0 100644
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
@@ -132,11 +132,26 @@ static int enable_8960(struct tsens_priv *priv, int id)
 	if (ret)
 		return ret;
 
-	mask = BIT(id + SENSOR0_SHIFT);
+	/* HARDWARE BUG:
+	 * On platform with more than 5 sensors, all the remaining
+	 * sensors needs to be enabled all togheder or underfined
+	 * results are expected. (Sensor 6-7 disabled, Sensor 3
+	 * disabled...) In the original driver, all the sensors
+	 * are enabled in one step hence this bug is not triggered.
+	 */
+	if (id > 5)
+		mask = GENMASK(10, 6);
+	else
+		mask = BIT(id);
+
+	mask <<= SENSOR0_SHIFT;
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
2.30.0

