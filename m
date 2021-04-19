Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72F7363917
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhDSBaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Apr 2021 21:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhDSBaT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Apr 2021 21:30:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3220C061760;
        Sun, 18 Apr 2021 18:29:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sd23so41698261ejb.12;
        Sun, 18 Apr 2021 18:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyio+zXMVMJ7Uz88On71j+PqEMDFxBYUNNuIBYyFxT8=;
        b=NJnPBzkDirodq8hbHuRfEQrt27cLdZZeSqt/jCw3Bm2L/kE2vt4EOhA+LC5X6m4FpW
         sqOb1CpjcTIy8NZBhCQwDw7HUVtvj/zpaHz+vbEJqvkrvrkmngHALo/nRUF08lx394U9
         vh8tPH4W0I029I2H36gHMjyJ9I0So6fJWbta4n9gcO4HI4lJFbT7cL0pddLijgKaOUTS
         Waxr5nLT0rsrZvxCPpzL3LZEzyB4M6nDWGZZYpSzepyCQ+A5a2t2ld401RhY8LfQOsRp
         Y9I8N3s+Ikcv5ZFhANC0buBQaomXoJdVx5Jg6JGbKHBcpOAaxDB2kAwhjfnjP4xBiOIG
         GSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyio+zXMVMJ7Uz88On71j+PqEMDFxBYUNNuIBYyFxT8=;
        b=F7LwPZvrp/VxpwnP/TOct+7AbEaKQ/exfueTMZDxMTus9Uci2hi+ouUB82JrB5rBvI
         pseFPIuRN3lQqTf/ktyDpPun2vGFNZCpM/vkY/FbGHOYOfw1TQuqBJjshUejQT+kZDJy
         vr1OukHNssrYFZfx7sGJEsngkM2YwjkEJNAn/nrCENasbubVsVMR9iJ4B9FzdvSqSaG1
         aL0wOdHQr/wIsRQDnh71kvp9yS7++rArJoorkU/P4ChnQ8FaLASx29oR/yWTS7A12UyQ
         KF50R1SCnx2JWUMs7astv76d6gTNRQ2ddkx+Soo/gQQeQqJ7bWfxi/ln8WwFzP94g+sl
         CBfA==
X-Gm-Message-State: AOAM533Tu9KvltKxzYkmA8gWNXjoISxle6UfNeG0vSqH+27Y1JMC0904
        HuratOZOwgUaU/HAa9dq9mFtCAmM9wCorw==
X-Google-Smtp-Source: ABdhPJxEOHY6dhXbVJoawZsMi2xGVHy/z8wvsBDyo953717LkPZl1Af7qHaAafvaoLEWABQNZll0Cg==
X-Received: by 2002:a17:907:3f9f:: with SMTP id hr31mr19290251ejc.349.1618795789597;
        Sun, 18 Apr 2021 18:29:49 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id mj3sm9083579ejb.3.2021.04.18.18.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 18:29:49 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [thermal-next PATCH 2/2] thermal: qcom: tsens: simplify debugfs init function
Date:   Mon, 19 Apr 2021 03:29:30 +0200
Message-Id: <20210419012930.7727-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419012930.7727-1-ansuelsmth@gmail.com>
References: <20210419012930.7727-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify debugfs init function.
- Drop useless variables
- Add check for existing dev directory.
- Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
  incorrectly reported)

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index f9d50a67e..b086d1496 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
 			return ret;
 		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
 	} else {
-		seq_puts(s, "0.1.0\n");
+		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
 	}
 
 	return 0;
@@ -704,21 +704,19 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
 static void tsens_debug_init(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
-	struct dentry *root, *file;
 
-	root = debugfs_lookup("tsens", NULL);
-	if (!root)
+	priv->debug_root = debugfs_lookup("tsens", NULL);
+	if (!priv->debug_root)
 		priv->debug_root = debugfs_create_dir("tsens", NULL);
-	else
-		priv->debug_root = root;
 
-	file = debugfs_lookup("version", priv->debug_root);
-	if (!file)
+	if (!debugfs_lookup("version", priv->debug_root))
 		debugfs_create_file("version", 0444, priv->debug_root,
 				    pdev, &dbg_version_fops);
 
 	/* A directory for each instance of the TSENS IP */
-	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
+	priv->debug = debugfs_lookup(dev_name(&pdev->dev), priv->debug_root);
+	if (!priv->debug)
+		priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
 	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
 }
 #else
-- 
2.30.2

