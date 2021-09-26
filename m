Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98E418917
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhIZNoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhIZNoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Sep 2021 09:44:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA0DC061714
        for <linux-pm@vger.kernel.org>; Sun, 26 Sep 2021 06:42:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e15so64045427lfr.10
        for <linux-pm@vger.kernel.org>; Sun, 26 Sep 2021 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzDC9qRKPuHBxoHAYxSycUOQsa5mrl7rHF0tbAdAykE=;
        b=yVd2pVKoUcjEDqDGsqcCyIBOGdZYT4zmoNp4opOXfdveEjNWW7SRuiRjFseu3W63AT
         z2I1TM4ZnWyg0cq104VNRh+tLPlHbI37XEdccMhTy9BshoFF8+8udxImsCYBmZLp6qhM
         AdvGjb68ZmFXGfdaMp98AX2fl+AIfIg/4/erKvFLu1EtS3X3IW1MggGR9X27GfkHDEar
         vkAvPjy8Pfx/vYAIDMI1g96Gy44I79rl3RTj5GKekclp8HhJ5JXOXPu1a0peLX/WoTui
         gOrEYgXBkk600vsPwo6iVyVcaVR6k4zF1BscJELNCoyjrp92ZDZvTbkLJTeVl4/osSPr
         kidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzDC9qRKPuHBxoHAYxSycUOQsa5mrl7rHF0tbAdAykE=;
        b=mW10IT4gLpfo9q/R/AqMe7xIsJ6Ft8kmqhDY5PJWgAXgfwoZIkOr7YjfOIeboHyQSR
         ZWzxLhRdP/8yzH5hhvHdJWbyCCSOTiysznLo3vpoBBwiEKhbnCPqNyc5DixdO4z0XEjv
         eVFYl7Ziiz1NShlCHC8LRSf0eQ+W/ZDzynq7hZDCnwI4PmbeqMadWo8xK3Li89q3/WeF
         TBtyqwGL784GUZZLB/N9+YJmzEwpSJ7TuAEBAJcCPCojWNoCZ5H9Of9/AvbYCmpXvV9+
         J6PE/FHQqeyBc/0uGwQ194ASCIgk+LJgRqh5gYY0jEHVhZpOahUwgaT1vDzpK3Yc2aMM
         Ku9Q==
X-Gm-Message-State: AOAM530D1ByPqCs80dUQCD4IeaKMYE+jGJyz8g2EgA0a8Ckf3/B6K2qk
        +RT/kigqUQ51/c780kilVf3DUg==
X-Google-Smtp-Source: ABdhPJyP1YMmfWYK7vCu1VlXDYTMXzxEhwkLjcgHZlPUl/tbhhS6kNv9FjXhQXp2hrbg2GCL153nxg==
X-Received: by 2002:a2e:82c4:: with SMTP id n4mr23643833ljh.283.1632663759604;
        Sun, 26 Sep 2021 06:42:39 -0700 (PDT)
Received: from umbar.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k21sm1787925lji.81.2021.09.26.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 06:42:39 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] thermal: qcom: tsens: fix VER_0 support
Date:   Sun, 26 Sep 2021 16:42:37 +0300
Message-Id: <20210926134237.23863-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210926134237.23863-1-dmitry.baryshkov@linaro.org>
References: <20210926134237.23863-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For VER_0 tsens shares the device with the clock controller, but
nevertheless it does not use syscon for these registers. Drop
syscon_node_to_regmap() and acquire the regmap on our own.

apq8064 has tsens as a part of gcc device tree node, ipq8064 puts tsens
node as a child node of gcc. Thus check whether tsens resource can be
fetched either from the device itself or from it's parent.

Fixes: 53e2a20e4c41 ("thermal/drivers/tsens: Add VER_0 tsens version")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6aeea74c1bb0..bc0c86a54fe7 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -12,7 +12,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
@@ -773,19 +772,19 @@ int __init init_common(struct tsens_priv *priv)
 	if (tsens_version(priv) >= VER_0_1) {
 		res = platform_get_resource(op, IORESOURCE_MEM, 0);
 		tm_base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(tm_base)) {
-			ret = PTR_ERR(tm_base);
-			goto err_put_device;
-		}
-
-		priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
-	} else { /* VER_0 share the same gcc regs using a syscon */
-		struct device *parent = priv->dev->parent;
+	} else { /* VER_0 share the same gcc regs. It can be either the same device, or parent */
+		res = platform_get_resource(op, IORESOURCE_MEM, 0);
+		if (!res && dev_is_platform(priv->dev->parent))
+			res = platform_get_resource(to_platform_device(priv->dev->parent), IORESOURCE_MEM, 0);
+		tm_base = devm_ioremap(dev, res->start, resource_size(res));
+	}
 
-		if (parent)
-			priv->tm_map = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR(tm_base)) {
+		ret = PTR_ERR(tm_base);
+		goto err_put_device;
 	}
 
+	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
 	if (IS_ERR_OR_NULL(priv->tm_map)) {
 		if (!priv->tm_map)
 			ret = -ENODEV;
-- 
2.30.2

