Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5D365F5F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhDTSes (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhDTSen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA688C061342;
        Tue, 20 Apr 2021 11:34:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e7so46198300edu.10;
        Tue, 20 Apr 2021 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbGEtXvS4MPCAqcooOSZYviKFO5PutHS6qrWdQUGFi0=;
        b=tVnpsZLuQDzYn4FfMy26p1YDMBWi7MD23/StZ1n+/eIDhDqjU/IpWoKCEsolLO1hGf
         EG25zYqBRKPhxBuN58GwhOK2F2NcBrrW7nVIdazrp6FzqxZOUO1RxP2WFYKONzkADTCL
         Vm6UHbFNdFwnOdm7Bx7CEmcR5yCc8RTXAzdufdO+piV2xkWyi5d3oN7DILy7ysjqp/ah
         OfjjzenUhuwcpr0wVDPT4MfAbIgflGrafRLPUIfH3/JFtY5aXfhB18acPiNEmMpEmZOs
         Ey/hyS/lnw8tXv/f3XmtBLiuS/Zo+vWq7pembIEkRfHMLNuM4/aWEhJXIaNAXQu5hPCy
         poRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbGEtXvS4MPCAqcooOSZYviKFO5PutHS6qrWdQUGFi0=;
        b=HTTEiFGlSJnGggq/PnVU7Sw+SmRJzKna9xFxJjLOEAwe8IRcKsxu8HvnQ0AErtTyEN
         gTUt10HtywV+YJcLRcpSKQnBeBY5o6CgduNMk40rrLTj6g79rg0YNXGojdLtIKaVkmTe
         LRScBbE1RKE6+jctERMiedDVWEGJtcU4sR56IkK/MKwCEFvQZFQQjUiqSQIrLEl3yjzA
         WIL/jP6ytiRkzyH5O6S2lg1AJn4xs0wV00Lg3T5Y7xkQCqifCCMK5H/GSquVuy9DKQYp
         b5LJqzYYN3f6izbaC75jqB/KqyrJ3x/kc+rVfn/4AiT5WQq+GSqrEA0sHTU1ALmbKc7+
         0rvQ==
X-Gm-Message-State: AOAM531SPEtMkOVDCtWzUkp5x2Q2FfsCwdsM2o+m87xQ/chSBFItlOtH
        6wiqE2u6vHOvHGR8pKuK8S8=
X-Google-Smtp-Source: ABdhPJw0JszHrBS0UC4vVxOJDutyCusIUzjObLYcRDX68OzbNbu0MlS0fbbW44Zvk/rIiN77uZPp5w==
X-Received: by 2002:a05:6402:17a8:: with SMTP id j8mr25060879edy.43.1618943648520;
        Tue, 20 Apr 2021 11:34:08 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:08 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 5/9] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Tue, 20 Apr 2021 20:33:39 +0200
Message-Id: <20210420183343.2272-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
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
index 83746ee3f..a96d37c2b 100644
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

