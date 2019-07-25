Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C182A75AB4
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 00:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfGYWUQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 18:20:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43390 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfGYWTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 18:19:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so16939981pld.10
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sgLAsMf3tNoy5aMAxpDD6qYpvryasSPOG21vNe1gMGQ=;
        b=xCw3C5AXZ3iwVVspZ/Sf7un1Xb/Y4ptsWpDNoVLh+zKSqefc1xJXf6Njj/TLjTMVO5
         Y21PIn9jQvX7V1Cx0GJrSmxAU8xRmVOZMFr2xdbaNNHSMpK9BL72d9/6Fccmo1k8Puf6
         14hjjLAjP6lE2HM6wF5bUr/5jQOfoU+gw5zj+Ij6OzjmlkmpuQgDLd6OD47TL0s1qAa7
         CCGzY/E7uzgwcNDKXCHA3e9mM4YUfsBmPi3jboqweXzwDjhPwyWVw/xkycFVej9+JUa7
         sqtaKqkWnv5mivp2UxDpl1cRO4EHYhFCzwRsVpiYw4fS7oMfpJNRTC1KGiipLbL7kZg5
         E+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sgLAsMf3tNoy5aMAxpDD6qYpvryasSPOG21vNe1gMGQ=;
        b=TH9FUIQOzY3FA3/FByoJuFKOFngjmv3jAqJ7rRWvTT9Gn66EPK8nJ6zQJeLcidsyyO
         NKTlQdWfsCVjcEWpQwQfbE2ALefoar7+qY3eA3o6tCXUgepQMn6BRl5urRErYR+92QPP
         YUjTyRw+wkC72hGCekQh9dTERt8A7HKuMfH+q7mNeiJPXWzO1idpe2qMnzdNVQDd9qi5
         xk0qVc6weapXuu5WB4iVBsqKjaMn+coEA1eSBKz/5APEofaCmusFVQvOz5WTjR/4DiBm
         GuM/Jm8GBFtANy3Lk1zhRyyzKsaY0dc7uyPq/k1o3F903xVqSTAVtPboxkfEC97FSsCP
         8Xbg==
X-Gm-Message-State: APjAAAVW3Cc4Ad00wE0ICw5t5f84oUD1VYILlpIO1MX/7+X8eBo7YxI0
        XhA1xvcotL+hJVYK3pEkkOxz1w==
X-Google-Smtp-Source: APXvYqw6caS6FrzKnwk5660tgEQTZU3oROBvcbiOWhz90/aDLwqmMQvaggmOjeUBNjg0JmZxZuykdg==
X-Received: by 2002:a17:902:102c:: with SMTP id b41mr91445248pla.204.1564093153359;
        Thu, 25 Jul 2019 15:19:13 -0700 (PDT)
Received: from localhost ([49.248.170.216])
        by smtp.gmail.com with ESMTPSA id p68sm61956062pfb.80.2019.07.25.15.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 15:19:12 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 04/15] drivers: thermal: tsens: Add debugfs support
Date:   Fri, 26 Jul 2019 03:48:39 +0530
Message-Id: <534b5017c2210ba8d541c206dace204d6617b4c9.1564091601.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dump some basic version info and sensor details into debugfs

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 85 +++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c        |  2 +
 drivers/thermal/qcom/tsens.h        |  6 ++
 3 files changed, 93 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 7437bfe196e5..7ab2e740a1da 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/nvmem-consumer.h>
@@ -139,6 +140,79 @@ int get_temp_common(struct tsens_sensor *s, int *temp)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int dbg_sensors_show(struct seq_file *s, void *data)
+{
+	struct platform_device *pdev = s->private;
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	seq_printf(s, "max: %2d\nnum: %2d\n\n",
+		   priv->feat->max_sensors, priv->num_sensors);
+
+	seq_puts(s, "      id   slope  offset\n------------------------\n");
+	for (i = 0;  i < priv->num_sensors; i++) {
+		seq_printf(s, "%8d%8d%8d\n", priv->sensor[i].hw_id,
+			   priv->sensor[i].slope, priv->sensor[i].offset);
+	}
+
+	return 0;
+}
+
+static int dbg_version_show(struct seq_file *s, void *data)
+{
+	struct platform_device *pdev = s->private;
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	u32 maj_ver, min_ver, step_ver;
+	int ret;
+
+	if (tsens_ver(priv) > VER_0_1) {
+		ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[VER_STEP], &step_ver);
+		if (ret)
+			return ret;
+		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
+	} else {
+		seq_puts(s, "0.1.0\n");
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(dbg_version);
+DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
+
+static void tsens_debug_init(struct platform_device *pdev)
+{
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	struct dentry *root, *file;
+
+	root = debugfs_lookup("tsens", NULL);
+	if (!root)
+		priv->debug_root = debugfs_create_dir("tsens", NULL);
+	else
+		priv->debug_root = root;
+
+	file = debugfs_lookup("version", priv->debug_root);
+	if (!file)
+		debugfs_create_file("version", 0444, priv->debug_root,
+				    pdev, &dbg_version_fops);
+
+	/* A directory for each instance of the TSENS IP */
+	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
+	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
+
+	return;
+}
+#else
+static inline void tsens_debug_init(struct platform_device *pdev) {}
+#endif
+
 static const struct regmap_config tsens_config = {
 	.name		= "tm",
 	.reg_bits	= 32,
@@ -199,6 +273,15 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	if (tsens_ver(priv) > VER_0_1) {
+		for (i = VER_MAJOR; i <= VER_STEP; i++) {
+			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
+							      priv->fields[i]);
+			if (IS_ERR(priv->rf[i]))
+				return PTR_ERR(priv->rf[i]);
+		}
+	}
+
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN])) {
@@ -238,6 +321,8 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
+	tsens_debug_init(op);
+
 	return 0;
 
 err_put_device:
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 06c6bbd69a1a..772aa76b50e1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -176,6 +177,7 @@ static int tsens_remove(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(priv->debug_root);
 	if (priv->ops->disable)
 		priv->ops->disable(priv);
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index d022e726d074..e1d6af71b2b9 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -292,6 +292,8 @@ struct tsens_context {
  * @feat: features of the IP
  * @fields: bitfield locations
  * @ops: pointer to list of callbacks supported by this device
+ * @debug_root: pointer to debugfs dentry for all tsens
+ * @debug: pointer to debugfs dentry for tsens controller
  * @sensor: list of sensors attached to this device
  */
 struct tsens_priv {
@@ -305,6 +307,10 @@ struct tsens_priv {
 	const struct tsens_features	*feat;
 	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
+
+	struct dentry			*debug_root;
+	struct dentry			*debug;
+
 	struct tsens_sensor		sensor[0];
 };
 
-- 
2.17.1

