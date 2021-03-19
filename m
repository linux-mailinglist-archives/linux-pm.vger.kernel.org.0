Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049703411AC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 01:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhCSAxJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 20:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhCSAwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 20:52:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81202C06174A;
        Thu, 18 Mar 2021 17:52:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b7so6916683ejv.1;
        Thu, 18 Mar 2021 17:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ht4zFLCjHIKNepjEoTWKseXBzTiNjgPlvBLpquOp4H0=;
        b=LoqNAtUzk1IhOl3fM+F7rr1KccuSClzp48RM7EPXyNojix7QFR3cGHeDVlg+MYzzIi
         fooDGsU/D1b1Nw5XlC3LSEDt6uJNssKjvEtlqDlVGNkehgODxrhkMid+Pb9viFBvpu+N
         DMQVYCMecgVVdPW//E2gCzDEZ9/wHcNivtPuZtcAufaGpV5l2yxIwLHs2ewiHXJuprSv
         fqi/hN8Sp39bCanX+TKs39d+CThD3WHIPtqgG5CT1BrQu0ZTznbZH5TpuZznVkSHk1lX
         CqxxSHbQSObNQ/2AYNyNyqye6Byj84GBLSC/Ome4xcJgd43jO76xaGYE69/d6TvOuuuS
         3ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ht4zFLCjHIKNepjEoTWKseXBzTiNjgPlvBLpquOp4H0=;
        b=ignA2Yau4OvhYgkU1+qx32k5kmWqmJ72+rehLh6rn49jak7e/2sHkz89cOv0wcTBbj
         +IKupbqSvvEqGw1T3NK45AbTQOZ1473aVqBLhE1tAzb9Xe8S7j7j7bGPJ/WGF2FwZDp7
         NsVAwTSU4QCXI4vhy4zVkNWNcqtfwtXUvos4HsdPbD+U82o/fkCki+PyCFjU6TebyXaC
         +TZhllHc1SiLiEm//Cf4WjI+6Pxx+dIRdW9Y/Wd7AgMWtTzgNZsOPpgllY6d1+J9Hyid
         zkN/u+PWRYkXOYD62CmmMTKMCMRYv2lBm4aqUbsEpo+H3PqTohfeCURJIrYO+9rdoSZd
         NXKg==
X-Gm-Message-State: AOAM533Yt3D8n5J7tj+xBg0aseGBBoAD8MaZJQgb2BYOoM/ntuW/VCf3
        FtDDYAnz7/EHMFKUhIuqrJM=
X-Google-Smtp-Source: ABdhPJwF9bMk/lLBms6UOmOS3RTNxSY708wPMXhYXsUx4Dko2xu1V3MN27iubzvb4TWpH2qz9AwqpA==
X-Received: by 2002:a17:907:3ea0:: with SMTP id hs32mr1405936ejc.411.1616115174159;
        Thu, 18 Mar 2021 17:52:54 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-95-233-52-6.retail.telecomitalia.it. [95.233.52.6])
        by smtp.googlemail.com with ESMTPSA id q25sm3186976edt.51.2021.03.18.17.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:52:53 -0700 (PDT)
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
Subject: [PATCH v11 5/9] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Fri, 19 Mar 2021 01:52:23 +0100
Message-Id: <20210319005228.1250-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319005228.1250-1-ansuelsmth@gmail.com>
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
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
 drivers/thermal/qcom/tsens-8960.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 86585f439985..bdc64d4188bf 100644
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
@@ -126,17 +126,35 @@ static int resume_8960(struct tsens_priv *priv)
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
+	if (id > 5) {
+		mask = GENMASK(10, 6);
+
+		/* Sensors already enabled. Skip. */
+		if ((reg & mask) == mask)
+			return 0;
+	}
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
2.30.2

