Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD35721A9EF
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGIVv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGIVvy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 17:51:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5ACC08C5CE;
        Thu,  9 Jul 2020 14:51:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d18so3013945edv.6;
        Thu, 09 Jul 2020 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JK4Zw9j/9Nb+LcGFZ1W5eUWt8QvNlgcbGlicFgmNlgc=;
        b=lpqg4hSjr3FxFCd1jZMnDK108KGA0tHFf1qXzQG+VrSwbdNGCgdgwyg3bN9SuEyrYr
         IHuNFzM0j+Vp4egvYZrgZCYaJuuhWLYbTcwHUFvTtbMamU1GYtPh9WqEGjkuRtiIEVaz
         iRdcI0tv5/BAximGo6Abtro+C2yaafWTRje2+u9vxGPSmcDLdt44J3VzUAEotua+6y+D
         xacLOnOxwhn2tldxB4xvOYbSqUNjpVlpdNeIrx6qY1Nf7gs2YN6mR+njvZWiYTvb3p74
         bPD33a4Z0zr+bho1UzU3ClY3jEuLobtR9ldj8ZRiqWD2g6+UrBw8t3UET/F858WZ48Eu
         qzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JK4Zw9j/9Nb+LcGFZ1W5eUWt8QvNlgcbGlicFgmNlgc=;
        b=W0XXAOE9ClQcVvggHd2WXhicHQNfrz/xsfWjjDD7HbBQiVan4aTolNPHPmwkV1oSed
         sHQjNn0eCZ1Bs3nr1PPtxj5zcaI8UcAL/ucs+0TSLlN3R2/id3nimQt8xR94FoZUQMBI
         h1hw6SQs8IZc/+0L9TPviGBi/zkRBnpz5MJtXouH6t5pAGXkwKfGoHowniKSmaa6vjjD
         tTehsOqww/PPSNhHwSK1ujsEimPUkUxIFbDDvVZsdzNKb/ePG95Ol14M4tU3/JcxHR67
         w4f4B2WtCtaVxVees3Cp9HO9bby45k0blKr+q7qidSjYftDcEj+i5WqLS/YOKZhF8un6
         Zuxg==
X-Gm-Message-State: AOAM533QQfgAUyfyBAurbjKPsm8O1XqfALE4tRD3aiqmlBO+kZrw/BWj
        WSpi4hRdGroPt9e1JpbHJk4=
X-Google-Smtp-Source: ABdhPJydKjHsm+/9nDCCgVV1a1f67AlisMviUtWQEEFcnf/Ig/0aJhwmWvC4Xet7z5KsL0fDYFfoKA==
X-Received: by 2002:a50:ee01:: with SMTP id g1mr65996830eds.264.1594331513117;
        Thu, 09 Jul 2020 14:51:53 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id e16sm2498260ejt.14.2020.07.09.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:51:52 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] drivers: thermal: tsens: add support for custom set_trip function
Date:   Thu,  9 Jul 2020 23:51:35 +0200
Message-Id: <20200709215136.28044-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709215136.28044-1-ansuelsmth@gmail.com>
References: <20200709215136.28044-1-ansuelsmth@gmail.com>
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

