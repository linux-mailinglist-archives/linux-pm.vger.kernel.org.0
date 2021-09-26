Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65903418549
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 02:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhIZASt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Sep 2021 20:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhIZASt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Sep 2021 20:18:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F59C061570
        for <linux-pm@vger.kernel.org>; Sat, 25 Sep 2021 17:17:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t10so57940353lfd.8
        for <linux-pm@vger.kernel.org>; Sat, 25 Sep 2021 17:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlWdpxs06o6BKntUmFuTyMgh8/xRKIkF0pvChWN0UpU=;
        b=ZWO6j8xFGrmCeKdk5ZpAvCzINooHu1X7fZjLDjMoTCqb0HBb4NZ3C+vl2ZBPLtG06X
         ISpF8CHjNViRl9OrTAqfZB6nkKfC0YIPlKdtzfpxEZeaIwILV40wMn6e+YVKM+7/JuKF
         b/JdxLcv0WcBfJsKQ2PSRBB64Fj47e6DRuPFgCXnaLHJ8iUOmd16IuJffZt0dRTcPU+g
         K65sIcCXNTmsXDGrB7TIsvhLgII9vgwn6wNXzt08xD27l5x0c62dBzBi79nFCxyiy+XG
         5KXdccFz+COwbkDfhoDyOFde6jxAIPV49AAKPehnuo54I0QpEFC+UDZ5l3C1a6AX2jMu
         uUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rlWdpxs06o6BKntUmFuTyMgh8/xRKIkF0pvChWN0UpU=;
        b=qF9rd+NWOISeM+bIIH5jz1Tr4oCHU9hahp0u9/iYPQdl7RYqbGv4VWqKsD8I4R2AZI
         D7kGyhW9QWFtYPFAnC4ZAxwelWdEJ7bkCrVlbYJWd0b1YRoR++OCjFNOXnQwsVtWG0JZ
         nS3WDjbnZqQtX22A8w1OodjckEAZkQZlaL5wAxX/Mgm+rTTU6BcbQoDc+D/XxrKwzw6J
         zmitpQeQcwXIE58Zk2np7G4Pl5nS+2bklIONWmw6FsmyBrYzys+OnMdB2Q+7rb4v7XWj
         nsl79retI6U7VU5dRPQDLgN2bcq4cbGuSUQROxEEzO7wHMQ6apzxYt3Ar5UHMnBdQ6Vr
         Arng==
X-Gm-Message-State: AOAM530ApGZrxOm3YTGShDZ0EWG+AyB4cLbpdA7opFNT3dwiGTWvbZVy
        dA5s/iN/Bluga98NjBRzWK0A4A==
X-Google-Smtp-Source: ABdhPJwKcpeyAFwALJf87wgsixDKV3Ef2fyAzV2eXecAjsWtePf5Ij9FnTLOyU5YXal+6Lwrg9iT/Q==
X-Received: by 2002:ac2:5e3b:: with SMTP id o27mr17251316lfg.521.1632615432038;
        Sat, 25 Sep 2021 17:17:12 -0700 (PDT)
Received: from umbar.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i10sm1146270lfu.71.2021.09.25.17.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 17:17:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] thermal: qcom: tsens: remove data indirection in the debugfs
Date:   Sun, 26 Sep 2021 03:17:10 +0300
Message-Id: <20210926001711.2431912-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no reason to pass platform device to debugfs just to get the
tsens_priv from it. Not to mention that for TSENS_V0 the platform device
(gcc) might have other device data. Pass the tsens_priv data to debugfs
callbacks directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4c7ebd1d3f9c..6aeea74c1bb0 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -657,8 +657,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp)
 #ifdef CONFIG_DEBUG_FS
 static int dbg_sensors_show(struct seq_file *s, void *data)
 {
-	struct platform_device *pdev = s->private;
-	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	struct tsens_priv *priv = s->private;
 	int i;
 
 	seq_printf(s, "max: %2d\nnum: %2d\n\n",
@@ -675,8 +674,7 @@ static int dbg_sensors_show(struct seq_file *s, void *data)
 
 static int dbg_version_show(struct seq_file *s, void *data)
 {
-	struct platform_device *pdev = s->private;
-	struct tsens_priv *priv = platform_get_drvdata(pdev);
+	struct tsens_priv *priv = s->private;
 	u32 maj_ver, min_ver, step_ver;
 	int ret;
 
@@ -701,9 +699,8 @@ static int dbg_version_show(struct seq_file *s, void *data)
 DEFINE_SHOW_ATTRIBUTE(dbg_version);
 DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
 
-static void tsens_debug_init(struct platform_device *pdev)
+static void tsens_debug_init(struct platform_device *pdev, struct tsens_priv *priv)
 {
-	struct tsens_priv *priv = platform_get_drvdata(pdev);
 	struct dentry *root, *file;
 
 	root = debugfs_lookup("tsens", NULL);
@@ -715,14 +712,14 @@ static void tsens_debug_init(struct platform_device *pdev)
 	file = debugfs_lookup("version", priv->debug_root);
 	if (!file)
 		debugfs_create_file("version", 0444, priv->debug_root,
-				    pdev, &dbg_version_fops);
+				    priv, &dbg_version_fops);
 
 	/* A directory for each instance of the TSENS IP */
 	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
-	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
+	debugfs_create_file("sensors", 0444, priv->debug, priv, &dbg_sensors_fops);
 }
 #else
-static inline void tsens_debug_init(struct platform_device *pdev) {}
+static inline void tsens_debug_init(struct platform_device *pdev, struct tsens_priv *priv) {}
 #endif
 
 static const struct regmap_config tsens_config = {
@@ -918,7 +915,7 @@ int __init init_common(struct tsens_priv *priv)
 	if (tsens_version(priv) >= VER_0_1)
 		tsens_enable_irq(priv);
 
-	tsens_debug_init(op);
+	tsens_debug_init(op, priv);
 
 err_put_device:
 	put_device(&op->dev);
-- 
2.30.2

