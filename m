Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F316A69D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 13:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBXM7P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 07:59:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41338 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBXM7P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 07:59:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id t14so4033823plr.8
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 04:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEoIHk1DMNFlUDlS2mHYQ7hw5/edQugGUZCmTbk0oQY=;
        b=WhmJc4o0Hei2T5dVmOwsPi0dhRuZXdo+2t1CwfjSjQ01c+rVJ3o197eZe9jaivHhsS
         Af9MO2dlYF1ozNWbTJR0uSnI1yg7VmouHRFRUyrKhDQfFdCuxFZ77K4qjKUuuVDRGXMO
         pp3f9dsEUX4X9+jPFCr1Fx43GgP4QZIlHNutaxoT2tf8eKnxnwKDoEWy1WxIa1ktJv+n
         l1fBmEGKoSIwZaIYNWSPhkyugR64Z1osmk2kMcJuru4J5pkgt9iZMyGqtcozwJreizYV
         /sE7KvwquUjMGUI2hROeGofUGqdk/NaEpiGRy1SQXlw2K9z+AaXNcYQBoCI7EcNiqjjt
         8dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEoIHk1DMNFlUDlS2mHYQ7hw5/edQugGUZCmTbk0oQY=;
        b=KmS1rTHNEeFcRKnBgRB60gC+3l0BNs4gRRWvNKmXicIma9imVwiHl/lIfV7mBq/9GX
         4JF8HYJCkfsU6/xuzOWyYSGS1m2H2AjIRgI00t438XzM+G4CM+d0/vOYgKcFtfk0W6ZC
         hQAp90996JNER/exw4HXOhXTYmYx+sdORFdUUKsRSQOypPEpgJDFH7ddZny6QJlpH7VF
         jRrqmdO0t6MWZnjQoYfAU41ox/EIFN/h2Pm5kzpFqsD9fZCGkJI4Ag8KKuMuiFbO9jb5
         KWXhw9IpTM45keLR22wVR+PeCL6j8rI5I899COyIIZB8vIakhTxq2SHSq9h0sbxWXP7O
         k9Zg==
X-Gm-Message-State: APjAAAXLNbfR3XGm447zkR/0Nqd70TDI/ia6Ytwu3s6GSI8ZVQUPWuji
        XdDHOrdo/LCCGaaW+kTapJlnDA==
X-Google-Smtp-Source: APXvYqzj5TeDP+eGemW8oZ0tWxCwY2kgIztJ5SvpSDmy6jWDsr3H7/EWg24A7BqInCkuWierFcgMNw==
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr48441653pln.178.1582549154055;
        Mon, 24 Feb 2020 04:59:14 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id u13sm12519095pjn.29.2020.02.24.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:59:13 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 3/8] drivers: thermal: tsens: use simpler variables
Date:   Mon, 24 Feb 2020 18:28:50 +0530
Message-Id: <ec300c8cf25c0fc841ab7919f2b3b6b975b34a4b.1582548319.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582548319.git.amit.kucheria@linaro.org>
References: <cover.1582548319.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We already dereference the sensor and save it into a variable. Use the
variable directly to make the code easier to read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/6f95b3f0d39433c7e6b01094bdb200a7ac8e9f0d.1582048155.git.amit.kucheria@linaro.org
---
 drivers/thermal/qcom/tsens-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c2df30a08b9e..1cbc5a6e5b4f 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -368,7 +368,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 			tsens_set_interrupt(priv, hw_id, UPPER, disable);
 			if (d.up_thresh > temp) {
 				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
-					priv->sensor[i].hw_id, __func__);
+					hw_id, __func__);
 				tsens_set_interrupt(priv, hw_id, UPPER, enable);
 			} else {
 				trigger = true;
@@ -379,7 +379,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 			tsens_set_interrupt(priv, hw_id, LOWER, disable);
 			if (d.low_thresh < temp) {
 				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
-					priv->sensor[i].hw_id, __func__);
+					hw_id, __func__);
 				tsens_set_interrupt(priv, hw_id, LOWER, enable);
 			} else {
 				trigger = true;
@@ -392,7 +392,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 		if (trigger) {
 			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
 				hw_id, __func__, temp);
-			thermal_zone_device_update(priv->sensor[i].tzd,
+			thermal_zone_device_update(s->tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
 		} else {
 			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
@@ -435,7 +435,7 @@ int tsens_set_trips(void *_sensor, int low, int high)
 	spin_unlock_irqrestore(&priv->ul_lock, flags);
 
 	dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
-		s->hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
+		hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
 
 	return 0;
 }
-- 
2.20.1

