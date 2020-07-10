Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A5521BDFC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgGJTq0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgGJTqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 15:46:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00355C08C5DD;
        Fri, 10 Jul 2020 12:46:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so7299047eje.7;
        Fri, 10 Jul 2020 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JK4Zw9j/9Nb+LcGFZ1W5eUWt8QvNlgcbGlicFgmNlgc=;
        b=vOj8521AV5oaaZIf2WBazwLsx5p+P2CorVOQn+HmMAgo/KDGQdE6bEzeLtjO/Uj/QT
         sSN6DOXolgFODVcsk/kjdOjppaX0+fqR9jBcEMu655NuPvERrqZm2QMzc5ssBZO2vQqK
         VgRvUeaMZPoXvGgTBxdPoh+lHlyDntpN+LYgNJU8z7lH5Ay9LTiJ6q9smZQ50xvHHXXy
         nYJs2ZwIAttzyFHu48xbZ43klmWK9hrzsiASsQZWoVEJU9JPZhv2TbfRy/imkejlLt+K
         pPqwRn5lxYhX9+GOg/SMKyGVoalMnm78IEIuD92rhSojMcBcp6ljCyR+Wl6iQlQK7qqH
         vAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JK4Zw9j/9Nb+LcGFZ1W5eUWt8QvNlgcbGlicFgmNlgc=;
        b=KSFKdXu5hS8wF6c6ncn3JOigfhvJyYSKVGst1/ZuXKTdpQYpymJVQfXn8INwCe3cRi
         rgGwJeONzgBNUMePE+iCtzKqwxoJwauyBGP+wYE8odULhIai23nYgxmNYJsrnbfUa3OH
         A3KISjONX3Rh2+4SjRpDdAn+g309mr9WhkBQpFpPc/u5i0Q+Cd6kJf4rM3mW8s7ntjQD
         mQSPFmWve+LCXxXcTD4iPDkddsPzYy8gjr7nKEDizp/oywTySUHkDeWOSXcyaOtOoaH/
         s7wLb/Z+zYQrF0bUaSvqwx3cNTJveskIXvXbx7/SN/efyDP0gkKxjO61UZQ21TaQVyKQ
         3n2g==
X-Gm-Message-State: AOAM533e5cLTGQusyqr+aL8nRkpexntMBrQTMjSsq7YS598qXyDv+tAI
        dVCm6LxXEax02wtZ8Cdr2I9/5/+x/B0=
X-Google-Smtp-Source: ABdhPJyiiXwYOhH58M2Om00ssr1q0Y23/QKrEMP4DLNk331/RDUX4MOzfTU6dRYXy8krRcjBGn9fIA==
X-Received: by 2002:a17:906:dbcf:: with SMTP id yc15mr51899560ejb.222.1594410375681;
        Fri, 10 Jul 2020 12:46:15 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id kt4sm4155768ejb.48.2020.07.10.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:46:14 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] drivers: thermal: tsens: add support for custom set_trip function
Date:   Fri, 10 Jul 2020 21:45:56 +0200
Message-Id: <20200710194558.26487-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710194558.26487-1-ansuelsmth@gmail.com>
References: <20200710194558.26487-1-ansuelsmth@gmail.com>
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

