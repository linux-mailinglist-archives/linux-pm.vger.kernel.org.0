Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E705A4100A3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhIQVQz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 17:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhIQVQv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 17:16:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ECFC061574;
        Fri, 17 Sep 2021 14:15:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h17so34815159edj.6;
        Fri, 17 Sep 2021 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYLvmWFA5adKzLqY8vh9rsTQj1QLK0NjY6Bw35bbszk=;
        b=PHb0bolJj9vmBZ77pRP7N/CaAYOPH2gty2ztmn3xwfN6CUptNoqbwingWB0/uvGF2+
         vehMgrQ5RKIHH9mtcxPBWsjbMcfXZcXMvyTPbfw857n07Qy1z0PgKehORm5QW02LGNW3
         l3sMjqZamhOUIxzrHsLpR+0KclMJDTs3gFPy/sZKS+lJrXMmBjCoUUZAX+K73ILwns8p
         uMNR6XqoCmwZj1OG/OxFE4BH2nADsyFa6VEJwudBNcLZOaCGw8AAEECwrnoLrp7xvgt0
         9w7jxOAnyLw6D0sL/nz+A2Pca06NVUYcY7zXYDTHxEbVzPv7u9hw4Ei82o3Nx8RBKWsB
         JoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYLvmWFA5adKzLqY8vh9rsTQj1QLK0NjY6Bw35bbszk=;
        b=cfIKz650SZpKhzOxbNyYPLwuhLOm60Tacjv5CIdnfg1afVX/MlwJ8R2UxC91ZXKVae
         TGvCvixN5HpzKffG37XZ5ahdhiBo0dA53sUwCqePeUcWJOjITFXq3aMS6wS1WQXl+AMv
         oPAPLs8xKvzjmhylBYBh+kfnwd7ytbJwXTNvFLBrzEWV4XcobOnMMD1iN9vO/XNYiKo4
         gwucgEfFQ1wfmPyRkcJ8eXhbuuFdtbO24oVp5Jr8BWP5lL8EuD3FyTtlHrpk6NE7iApD
         H7FQAVGyC/NRqrePAuG7gLaIjuC7tr/KmIJ16dUhBDT5/sOEDp5H0qSaRym3PD1BE73F
         MzJg==
X-Gm-Message-State: AOAM530W6sP73PoPzW58A0kdTh9CxFHuVrpkzMZKgTWi1CX8FbvBKTBz
        8gGXM2g70h6gI3COafv/Zvo=
X-Google-Smtp-Source: ABdhPJxZQQeVwSzhHCPzefmz3laO7kGZR35Zg0G/LP966dLvwt6IKKHiGbSAl9Ojd/Mx6Bg/kqXIIg==
X-Received: by 2002:a17:906:4544:: with SMTP id s4mr14671511ejq.102.1631913326521;
        Fri, 17 Sep 2021 14:15:26 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-67-254.ip85.fastwebnet.it. [93.42.67.254])
        by smtp.googlemail.com with ESMTPSA id la17sm2685763ejb.80.2021.09.17.14.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:14:43 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v3] drivers: thermal: tsens: add timeout to get_temp_tsens_valid
Date:   Fri, 17 Sep 2021 23:14:03 +0200
Message-Id: <20210917211403.19640-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function can loop and lock the system if for whatever reason the bit
for the target sensor is NEVER valid. This is the case if a sensor is
disabled by the factory and the valid bit is never reported as actually
valid. Add a timeout check and exit if a timeout occurs. As this is
a very rare condition, handle the timeout only if the first read fails.
While at it also rework the function to improve readability and convert
to poll_timeout generic macro.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1162e566a70..99a8d9f3e03c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -603,22 +603,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	int ret;
 
 	/* VER_0 doesn't have VALID bit */
-	if (tsens_version(priv) >= VER_0_1) {
-		ret = regmap_field_read(priv->rf[valid_idx], &valid);
-		if (ret)
-			return ret;
-		while (!valid) {
-			/* Valid bit is 0 for 6 AHB clock cycles.
-			 * At 19.2MHz, 1 AHB clock is ~60ns.
-			 * We should enter this loop very, very rarely.
-			 */
-			ndelay(400);
-			ret = regmap_field_read(priv->rf[valid_idx], &valid);
-			if (ret)
-				return ret;
-		}
-	}
+	if (tsens_version(priv) == VER_0)
+		goto get_temp;
+
+	/* Valid bit is 0 for 6 AHB clock cycles.
+	 * At 19.2MHz, 1 AHB clock is ~60ns.
+	 * We should enter this loop very, very rarely.
+	 * Wait 1 us since it's the min of poll_timeout macro.
+	 * Old value was 400 ns.
+	 */
+	ret = regmap_field_read_poll_timeout(priv->rf[valid_idx], valid,
+					     valid, 1, 20 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
+get_temp:
 	/* Valid bit is set, OK to read the temperature */
 	*temp = tsens_hw_to_mC(s, temp_idx);
 
-- 
2.32.0

