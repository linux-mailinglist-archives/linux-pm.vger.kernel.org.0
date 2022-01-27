Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8149D760
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiA0BO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiA0BO5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:14:57 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452FC06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:56 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a28so2230955lfl.7
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctCYoyyJFkpZolUjzwLxdyw/U34O4ojHAy2N2y/LCUo=;
        b=toBAE5YmuPv7wEVymjPSWeF9nV5wt8CXCkvWXhAF9XuL60mbV9MSxCPwkIUB5hNnNO
         M2zTUm/TAZ4nWUFm7i5w9nz8QS/qFF4QMkG/i5hbn2Z3rAZF7GgWKuZgQGZ2xaUzpZOH
         lPd9HNriiaEpgHb2Lm3XCiumGp1PITI0ja8DQ5GBeX/ZN2JGwG2IIXk5xUNu2hqcMThB
         WRHJOmYEjSmfkxOcH2lUa7QwKYZbRU4zDKbc4DMS2uyi1O73ACkyimpZz0W+QD5ljaMc
         8xZ/7/JK2dS+CfiKXTQvcE2iDC4QDhVF0EKLu6IDxXrRV2gZjSXSzLKC2LbnDUr2kwq8
         yHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctCYoyyJFkpZolUjzwLxdyw/U34O4ojHAy2N2y/LCUo=;
        b=MThcbOyBTusjIBMotqZ7j6j2EkBgBfs5THiD+ZVAZbIjzJhXdLBz62yqCyHxEgN/ve
         LzMqxUSEsTROEHPNaB729JN70MSk6DUdMveCJpUeLLPfXrr21wXZITnSVTdPcbL3ZP5T
         w2olenkvSkA+QCXJ4QDO6nvNvIGLvjCJjk+M09+v+6Z8eWNc2UzXpd3LQI+dNBXM6tHS
         xVmdubd3muhAZgjF7GxdGS3v9sEx5tXJYEzbMXr1vj2mqp/LJxJkUdHrnZMD2HB2jxkU
         gpIXg1jPFoWDmrPY7AAPHqqn6JbWcPQfHHxX9JgssOmqBqw+wavzOFHSQXO6bwssZ7Bg
         Tkdw==
X-Gm-Message-State: AOAM530sdgdtsaXaVOvp6wW70sx1MpsEkZ82yg7jgLCgqyLmB5xinQHC
        6KuCy7hi+ykF2udzvDO6Z5N1AQ==
X-Google-Smtp-Source: ABdhPJxvPCip2bV9AcH3UyX8oiMizy1OfXpY4oeL3VbxjaiLk39nRUpQIvb5FW+jRqWF1iFg7zglSg==
X-Received: by 2002:a05:6512:2815:: with SMTP id cf21mr1136175lfb.619.1643246095055;
        Wed, 26 Jan 2022 17:14:55 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:14:54 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/11] power: supply: ab8500_fg: Break out load compensated voltage
Date:   Thu, 27 Jan 2022 02:12:30 +0100
Message-Id: <20220127011236.332687-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127011236.332687-1-linus.walleij@linaro.org>
References: <20220127011236.332687-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Break out the part of the function providing the load compensated
capacity that provides the load compensated voltage and use
that to get the load compensated capacity.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_fg.c | 50 ++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 29896f09fd17..8c907900a56d 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -909,18 +909,20 @@ static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
 }
 
 /**
- * ab8500_fg_load_comp_volt_to_capacity() - Load compensated voltage based capacity
+ * ab8500_load_comp_fg_bat_voltage() - get load compensated battery voltage
  * @di:		pointer to the ab8500_fg structure
  *
- * Returns battery capacity based on battery voltage that is load compensated
- * for the voltage drop
+ * Returns compensated battery voltage (on success) else error code.
+ * If always is specified, we always return a voltage but it may be
+ * uncompensated.
  */
-static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
+static int ab8500_load_comp_fg_bat_voltage(struct ab8500_fg *di)
 {
-	int vbat_comp_uv, res;
 	int i = 0;
 	int vbat_uv = 0;
+	int rcomp;
 
+	/* Average the instant current to get a stable current measurement */
 	ab8500_fg_inst_curr_start(di);
 
 	do {
@@ -932,25 +934,37 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
 
 	if (i > WAIT_FOR_INST_CURRENT_MAX) {
 		dev_err(di->dev,
-			"TIMEOUT: return capacity based on uncompensated measurement of VBAT\n");
-		goto calc_cap;
+			"TIMEOUT: return uncompensated measurement of VBAT\n");
+		di->vbat_uv = vbat_uv / i;
+		return di->vbat_uv;
 	}
 
 	ab8500_fg_inst_curr_finalize(di, &di->inst_curr_ua);
 
-calc_cap:
-	di->vbat_uv = vbat_uv / i;
-	res = ab8500_fg_battery_resistance(di);
+	vbat_uv = vbat_uv / i;
 
-	/*
-	 * Use Ohms law to get the load compensated voltage.
-	 * Divide by 1000 to get from milliohms to ohms.
-	 */
-	vbat_comp_uv = di->vbat_uv - (di->inst_curr_ua * res) / 1000;
+	/* Next we apply voltage compensation from internal resistance */
+	rcomp = ab8500_fg_battery_resistance(di, vbat_uv);
+	vbat_uv = vbat_uv - (di->inst_curr_ua * rcomp) / 1000;
+
+	/* Always keep this state at latest measurement */
+	di->vbat_uv = vbat_uv;
+
+	return vbat_uv;
+}
+
+/**
+ * ab8500_fg_load_comp_volt_to_capacity() - Load compensated voltage based capacity
+ * @di:		pointer to the ab8500_fg structure
+ *
+ * Returns battery capacity based on battery voltage that is load compensated
+ * for the voltage drop
+ */
+static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
+{
+	int vbat_comp_uv;
 
-	dev_dbg(di->dev, "%s Measured Vbat: %d uV,Compensated Vbat %d uV, "
-		"R: %d mOhm, Current: %d uA Vbat Samples: %d\n",
-		__func__, di->vbat_uv, vbat_comp_uv, res, di->inst_curr_ua, i);
+	vbat_comp_uv = ab8500_load_comp_fg_bat_voltage(di);
 
 	return ab8500_fg_volt_to_capacity(di, vbat_comp_uv);
 }
-- 
2.34.1

