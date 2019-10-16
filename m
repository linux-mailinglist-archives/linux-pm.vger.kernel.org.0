Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AE8D89AD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbfJPHej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 03:34:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45993 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732816AbfJPHej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 03:34:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so12568876pgj.12
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=X8pbmbvndxxAH4F0z0Ew7Vd1EABZ+OrJe/0vppnAxes=;
        b=m2blUIERT53SNTEyx5WOy2++HB63Jg2q6qsys2oeOGLlXKv8Gq+exfQEtDm14SPsVy
         JLRh6aKmCGJfxndpb4LMK3V7snH4kMI5ksP1H8pzeuzTqd3DN0MoyRLtdgzQBn8wWAxY
         B7PFn1D2IbPS/zgrdzHuGfeoPQm0QkLvGohG4gqBs6l+s2tdnDUKRvywOLk1uyNHR9Yt
         Gpy+kDsIJtaQ/ubsggnQ5yzSKH0i+88450twFBnyfGEYgGUZ2pO9d+qAcl8AE2Mxc5sg
         WL9tdFWK2NuX8kB5asflDsKPtdvxN5G2Pz+UDMhK9XLiQhQiM7UzjLZtVgIpbokCMOj7
         HoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=X8pbmbvndxxAH4F0z0Ew7Vd1EABZ+OrJe/0vppnAxes=;
        b=J0S9N3nTvxKhfkGz9HP4LMNhv+FSyCNPMSAIn/+Yx0lKbEc8ic6cE0MxIVjShKggy4
         +rOYNPOXiuhx2Xw+6VqgViDju9Loj7898UY9CZaoeHFR4RJkXavyFZw5tgqJ0A/uQ569
         n4JKNW7m3qRx9nhMlPYIWeuushzjqdsqPFWRcl+StnAHEUYWJoWfDEQng7dlDKUrULK4
         G5IKXDOhB28elz6qCM+tjovOYNMLTAQ5h15rzk4Fys8/Ik4l96LnjCoFTVg1brpjSUHh
         sN3ENbo5TS1VTUD/qer8CNE38ezy3nziMPoeAz530xqLQn1w0Ow6aOWEdSUDJNstzRcP
         jJUA==
X-Gm-Message-State: APjAAAX/s9m2h2MzVwaNNv+1JuT3aopPXqGmgCUJBaSnt7G0SLdZ6+2t
        7Aa+8HVilnyhV8974+Eln0+XXg==
X-Google-Smtp-Source: APXvYqweUuIjibgAjmbmdlFc3afBcb2Ke7WmM01P+ZxSDfwXyBLcFRtXuhcQPpz2/zESTBRLfW4RDA==
X-Received: by 2002:a17:90a:b304:: with SMTP id d4mr3327236pjr.27.1571211277615;
        Wed, 16 Oct 2019 00:34:37 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id v19sm23786315pff.46.2019.10.16.00.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:34:37 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 04/15] drivers: thermal: tsens: Add debugfs support
Date:   Wed, 16 Oct 2019 13:04:03 +0530
Message-Id: <16e39c1bbfc18b5cf6274620cd72cc63205f53a5.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dump some basic version info and sensor details into debugfs. Example
from qcs404 below:

--(/sys/kernel/debug) $ ls tsens/
4a9000.thermal-sensor  version
--(/sys/kernel/debug) $ cat tsens/version
1.4.0
--(/sys/kernel/debug) $ cat tsens/4a9000.thermal-sensor/sensors
max: 11
num: 10

      id    slope   offset
------------------------
       0     3200   404000
       1     3200   404000
       2     3200   404000
       3     3200   404000
       4     3200   404000
       5     3200   404000
       6     3200   404000
       7     3200   404000
       8     3200   404000
       9     3200   404000

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 83 +++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c        |  2 +
 drivers/thermal/qcom/tsens.h        |  6 +++
 3 files changed, 91 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 7437bfe196e5..ea2c46cc6a66 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/nvmem-consumer.h>
@@ -139,6 +140,77 @@ int get_temp_common(struct tsens_sensor *s, int *temp)
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
+	seq_puts(s, "      id    slope   offset\n--------------------------\n");
+	for (i = 0;  i < priv->num_sensors; i++) {
+		seq_printf(s, "%8d %8d %8d\n", priv->sensor[i].hw_id,
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
+}
+#else
+static inline void tsens_debug_init(struct platform_device *pdev) {}
+#endif
+
 static const struct regmap_config tsens_config = {
 	.name		= "tm",
 	.reg_bits	= 32,
@@ -199,6 +271,15 @@ int __init init_common(struct tsens_priv *priv)
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
@@ -238,6 +319,8 @@ int __init init_common(struct tsens_priv *priv)
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
index 84e5447c5686..00899c17e848 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -293,6 +293,8 @@ struct tsens_context {
  * @feat: features of the IP
  * @fields: bitfield locations
  * @ops: pointer to list of callbacks supported by this device
+ * @debug_root: pointer to debugfs dentry for all tsens
+ * @debug: pointer to debugfs dentry for tsens controller
  * @sensor: list of sensors attached to this device
  */
 struct tsens_priv {
@@ -306,6 +308,10 @@ struct tsens_priv {
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

