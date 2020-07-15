Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABDD22180C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 00:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGOWpt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 18:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgGOWps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 18:45:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6994C061755;
        Wed, 15 Jul 2020 15:45:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so4654477wrs.11;
        Wed, 15 Jul 2020 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JK4Zw9j/9Nb+LcGFZ1W5eUWt8QvNlgcbGlicFgmNlgc=;
        b=gN57gKkiCFJSYOk9y7XXG6mcrhYIapPPDq4rVT0KSalfIyGFW3WXAYoyqjgTdoKhr7
         b8+h5FYLOue3iibV1n+jTbeWlkEuaYnm0ySlDJ3cBEeA9n2K5iyAiYqkWXYHQ5ZKyKvD
         rStbhfV9x5Q5OYTqTSWZgy39N454JCtA4ZZ834ua1ipVSNs1FME1APqVlaP4jUlMqmKC
         xp1f/UkQD/uA+3AZXh8z15/ftksO3zLWG+gQlBQaWoSzDxC4g/7O4Y/ynncrnErIFSF6
         FWaHlqjHiaVd2oEmUWrPEOXq+k6XfCMEdE+G8FBUqZGyD02vPCkRFoVj1IcYiIyjp+M+
         eCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JK4Zw9j/9Nb+LcGFZ1W5eUWt8QvNlgcbGlicFgmNlgc=;
        b=qFKbkCnc14r/yofMMG2ZU576NgSNosK9ZWbNVv9AttNCLcM3ClEPor0g/vS6Y3JO3q
         6kqYh8dsQ0RH6A3PW5ud8UXAVVX5rk7/05ZtZdQL5qEp8fd4HpZEuDah/vBJIjIwcPMa
         S8Khk30e4O6diLzpqdug0EUfib/at3bFxNBYMkOjxSVmnDkMFLKWTMEmRJZavyZP7eKh
         Tnb2mQNiwO1ZAh+/EYA5nONZS33CPog6Q5ORFmZ+legjk6UJsjzcI5tTdDp9D7HKPBE4
         iLRZ+xBbgNlUD67M4q+D97xz1Ygu3Fjw+Bnvqu6n0wfruQBLQx34d+xwsJIrNru+5uQE
         Ne4Q==
X-Gm-Message-State: AOAM532keK80YH5dP31sQ868WtEM4VbxYcgVe0fC/CWL413KsEqiRJod
        fSwFXP339q0GFWK4zIrU2q4=
X-Google-Smtp-Source: ABdhPJwBXbhvy6eeQU/EsAaxMHo8lPzWAxnjLFwnHuoLjr0E/EbAhM6OmsV3XzoRwc91vaYtbrhR9g==
X-Received: by 2002:adf:f388:: with SMTP id m8mr1917359wro.338.1594853146495;
        Wed, 15 Jul 2020 15:45:46 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id b186sm5759898wme.1.2020.07.15.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:45:45 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 6/7] drivers: thermal: tsens: add support for custom set_trip function
Date:   Thu, 16 Jul 2020 00:45:01 +0200
Message-Id: <20200715224503.30462-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715224503.30462-1-ansuelsmth@gmail.com>
References: <20200715224503.30462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

8960 tsens driver have a custom implementation to set set_trip function.
Permit the generic driver to use the custom function if provided.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 4 ++++
 drivers/thermal/qcom/tsens.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 2985a064a0d1..2b55b34d66fb 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -530,6 +530,10 @@ static int tsens_set_trips(void *_sensor, int low, int high)
 	int high_val, low_val, cl_high, cl_low;
 	u32 hw_id = s->hw_id;
 
+	// Use the driver set_trips if present
+	if (priv->ops->set_trip_temp)
+		return priv->ops->set_trip_temp(_sensor, low, high);
+
 	dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
 		hw_id, __func__, low, high);
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2f145001e4d5..c27fae39d542 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -65,6 +65,7 @@ struct tsens_sensor {
  * @suspend: Function to suspend the tsens device
  * @resume: Function to resume the tsens device
  * @get_trend: Function to get the thermal/temp trend
+ * @set_trip_temp: Function to get trip temp
  */
 struct tsens_ops {
 	/* mandatory callbacks */
@@ -77,6 +78,7 @@ struct tsens_ops {
 	int (*suspend)(struct tsens_priv *priv);
 	int (*resume)(struct tsens_priv *priv);
 	int (*get_trend)(struct tsens_sensor *s, enum thermal_trend *trend);
+	int (*set_trip_temp)(void *data, int trip, int temp);
 };
 
 #define REG_FIELD_FOR_EACH_SENSOR11(_name, _offset, _startbit, _stopbit) \
-- 
2.27.0

