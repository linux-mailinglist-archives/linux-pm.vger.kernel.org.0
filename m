Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1A2219F8
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 04:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGPC2i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 22:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgGPC2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:28:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D47C061755;
        Wed, 15 Jul 2020 19:28:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so5216595wrl.8;
        Wed, 15 Jul 2020 19:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gt3RCGelEvEHlQYyVX2wViJWDr9KU7NH0CW3BsI1M0Q=;
        b=AqmFDFtmtarmwpD5ywmshJAZ93olO+eOQSNH3h7RzkYyHJ7EbgVEL3OoVBfATuUO1e
         7dAzNYdpMiwzRuxsZe5yJG/Tk8cIJi5XbThe2E65ldymeJA5EGb8lobBk2o5mHzMyMRV
         FmlNsEtss91tJVu0ViqCPDhgibB8vbZKqR0lmPRcmLYW1z3bZmkI74aqGpvk8rZeClSf
         KS1b7H9qGorQXf6EQxO7ET1RGERZWytZcHGJm/BQr/yHuTf7grdCyHAJq3+JhyFhVNUF
         0zOfYshpvPriif96Wd+J2Fs2kx7j3saWgCZ5kbytyyzTmRm5NhzY75Cn3eT2hbb0rN7z
         2LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gt3RCGelEvEHlQYyVX2wViJWDr9KU7NH0CW3BsI1M0Q=;
        b=XSs8MJZtE2Jg69Z5lJAXSRyX/0F9iidHUG9qFjTGem3P0bItx6fymzj/q2OMO2iRzq
         ZxbOkzdKOdE3Z4m8t0aIduZBcaUjaiglaWLl4wyBd44yaEBbHtVp1BQY4Kq/MVtAyFkZ
         aCyA7TB0Ra3FVt4NI2IRwxQVnY5uSCQIX3i7ii/zf6YreRM36bWfs7F1UdL3APdYLuvu
         K4n/pZR/Rz1SBajsWBQ6LOqY9h728b9EUSAjyA61ATzS0Lh0l8QXMFZCczwKgiZMySX6
         kGcQGsi8F5Y8PDltaEHmkb3XB4l+OuQT1YKg72EYfNdN/JRCmcEXSTI1AKmaZEjpzEHc
         /6fQ==
X-Gm-Message-State: AOAM533r/jYQ5+6pjEtgHuVOjIk4A0NpAW6NBoFE1FaPamc8CJ6JRMqa
        dFwMPK0lnYxzGhLl6l7E2WQ+zU4Lf7FtIw==
X-Google-Smtp-Source: ABdhPJz8f2JaBkeFXJuUTIy1BAPkCDu4uVn32K6Bs9WiH6mlxVOq49EwNNiCzuuwewgcLzHiOK6d1w==
X-Received: by 2002:adf:f350:: with SMTP id e16mr2508832wrp.43.1594866515654;
        Wed, 15 Jul 2020 19:28:35 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id u1sm7477611wrb.78.2020.07.15.19.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:28:35 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 6/7] drivers: thermal: tsens: add support for custom set_trip function
Date:   Thu, 16 Jul 2020 04:28:15 +0200
Message-Id: <20200716022817.30439-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716022817.30439-1-ansuelsmth@gmail.com>
References: <20200716022817.30439-1-ansuelsmth@gmail.com>
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
index 23f63dfbf13d..5f49f4117610 100644
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
index e66048fabcc7..4f0ab4aa5fd1 100644
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

