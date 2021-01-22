Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACE5300789
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbhAVPka (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbhAVO5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:57:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FBC061797;
        Fri, 22 Jan 2021 06:56:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o10so6838057wmc.1;
        Fri, 22 Jan 2021 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//vxmImvEZezGNbMSIPWRQhGQeqxvlD68gBH9D1FgFg=;
        b=JPar7D3w+4QjE7ggC2yQUd84apZvRlfnhsMeP3VfxutsXPkOv2YARWvy7r+jcSbjMz
         g9e1j6lqPQRFHjBJLwCKF/yyOxsVyHSXDhaZOWxRPDxtjcwM870Lcn9ffBsEHLO+hCpS
         plyVfXmYe1PVCbAlQwRpAqQm6oHJ57wUVckSujUam2Pxem58n9WZXuGRQCJ3DJFLKuiW
         yiBwT3Eh5IlssUVChG9xxlTkYC0KYBfzSdJY1OzZxBqc9SEG/hgwIJbWHA4NP2hXDGip
         u0qYtwhxyTziey28d+SPlzqRWSrQaE/MHZXIX6H41fzr8jdJNItEMgVlf9OerZ/RYLBE
         2i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//vxmImvEZezGNbMSIPWRQhGQeqxvlD68gBH9D1FgFg=;
        b=Rb9s2c1I/s2c7VAMqkBz/vGDeiW6Av3SkodDVLVNlxn0whaPuoGzx7dygLRst1Mp4m
         TQAOKW7eU7vY3EidqweiGXVD54nHknLOuAj8Hjj5mm7DrPmvDKe5u7GIr2SLQV1rLABR
         mwAF4iXuulhSfUqloZOTknRlbiAhmUL6BRbG1vGFmnJ+VWw0kzely30i1+X6GgzOla9g
         MM47QO3hyKCXq2GunjYnkVso1UzFeTO66G7ANucZIlM4qMHNCM7p1VB+voKUJZYuw5Jt
         UMw8hijNcf5OUlBtXdbLi+QC2KKagjX5PgYWt2M5vu3pTGOxYeUNntf4DTiXD3vZIpSO
         KJ3w==
X-Gm-Message-State: AOAM533ut2WruRREcc3EV+GZVhtmAXMNkHi2BKVqRcYYKzMVn1YWmuE7
        d7gH8mbh98ig/y7ENiL8nUw=
X-Google-Smtp-Source: ABdhPJzsPfIhwyo5zD/eGSjW/yDGzdjyLGuFZrXt5nMls6xsdf7VpzXEuw2Eosd2paxB7oLsbK7wbg==
X-Received: by 2002:a7b:c779:: with SMTP id x25mr4322874wmk.138.1611327375585;
        Fri, 22 Jan 2021 06:56:15 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-45-3-77.retail.telecomitalia.it. [79.45.3.77])
        by smtp.googlemail.com with ESMTPSA id t67sm12061106wmt.28.2021.01.22.06.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:56:15 -0800 (PST)
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
Subject: [PATCH v9 5/8] drivers: thermal: tsens: Fix bug in sensor enable for msm8960
Date:   Fri, 22 Jan 2021 15:55:54 +0100
Message-Id: <20210122145558.4982-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122145558.4982-1-ansuelsmth@gmail.com>
References: <20210122145558.4982-1-ansuelsmth@gmail.com>
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

