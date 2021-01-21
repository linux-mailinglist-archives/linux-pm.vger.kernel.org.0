Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9002FF42B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbhAUTTA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbhAUTSG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:18:06 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639BCC061797;
        Thu, 21 Jan 2021 11:17:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q20so2091175pfu.8;
        Thu, 21 Jan 2021 11:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//vxmImvEZezGNbMSIPWRQhGQeqxvlD68gBH9D1FgFg=;
        b=R7KUiUJJWYSwWrD4WNNBgCrqmvJpxhNqd/c1X8Y/559czgj0X2KIIBjCGEgMqvX8PI
         NyS0AQMJncdJ7ZhZvp9mSen31DtOtPAoL7YuOUsSvNk5dxI4yVHyF3hx29f7JSeeCOnl
         bwVYikZrkvTzMYhtDMiWbsG4OAtamVTsyPlS8JfCMsEP/q6qhjiKRplj6Pu6/KkN/vbC
         ikwq8HIj9Dvm87yZbSg9qsvmkJzHdNHdjXb7LfAnRgq1jSpNZYzrx+nncxNU80+c3FtU
         tTYZ5b08d425cDnQaxWbJvA+LViVzKktoJIYmeVfpYEkHd8fHwOPxgwGXuOVHppjOkXp
         jexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//vxmImvEZezGNbMSIPWRQhGQeqxvlD68gBH9D1FgFg=;
        b=hKZjnaqWEVuZ/2Vooxs9A8MkL0pj2B8WVKgl93Zt3KnvIlaWtoqQogi7eWkRNpP0WB
         50RTEk0xWbPf6f9fbgLvcz01TOnuSWkyY6ADfbCYVvMPzk+KUrIYZZCUwE7Iw4N3P97G
         EVW0JXKMG3lCjIl7aIVB9QXerNAhaeXbwQh4qS+KlIAZyCHEDMlkZAztbVZAwlyw/QaG
         Ixq2mVAq+tEZcQetvdWl/B3CsoAyVd4e8yfJNLh4fKkNGPbdYl78I5u7BwxcC8LWUVln
         otBJpPvyCe+NPSIrWrR6kFklmBx2/tcZVCNd7GxKREVe8PLZdpbE/vj68DdOjgUSc6GO
         ZloA==
X-Gm-Message-State: AOAM5308oDpBt26/MufZ1xV3F/LHbhcQT5BEEwiS83RXQwrp7uND+/zI
        IDA2Q0T2uPH7cwDvb54Dh0I=
X-Google-Smtp-Source: ABdhPJzRBGVet/vJkDYEKMJ2TqwbMFDisP8AhdPlmYFcTEsFyHz7AQYOC3M+XNxnE/hvpzpLcDkzGg==
X-Received: by 2002:aa7:87d9:0:b029:1b7:1c6c:56e0 with SMTP id i25-20020aa787d90000b02901b71c6c56e0mr914114pfo.25.1611256622929;
        Thu, 21 Jan 2021 11:17:02 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-41-39-5.retail.telecomitalia.it. [79.41.39.5])
        by smtp.googlemail.com with ESMTPSA id gg6sm11291013pjb.2.2021.01.21.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:17:02 -0800 (PST)
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
Subject: [PATCH v8 5/8] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Thu, 21 Jan 2021 20:15:57 +0100
Message-Id: <20210121191601.14403-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121191601.14403-1-ansuelsmth@gmail.com>
References: <20210121191601.14403-1-ansuelsmth@gmail.com>
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
2.29.2

