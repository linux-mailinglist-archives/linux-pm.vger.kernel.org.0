Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6588C96ECC
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfHUB0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:26:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43873 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfHUB0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so270847pfn.10;
        Tue, 20 Aug 2019 18:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRKPAiBDdS7Afghqz/SOxRPJ6FPjN+ps+2ffOIEw7VU=;
        b=gSKfRhAK+EzZRhN2FpgE9Q2cmcrP32GsNwi6Iz/UX0eAv7f9iCdZkG5ckN8KLSx9/Z
         skowsvX3/hVKMrybFR43CWHof7xM2Npk3iIqSYere1NCpKrMfjhQXrpWCNCiw0bZXblZ
         Xb0BrXR/EmTXI1R6HUud74ldPl30djuJGZ02Axi/LjHCi5ffVNNGGL9fA4Zq5ELShMel
         vLyuZTSNIoInbjCScqPe2IC86Cv1tZr6jNC/1/Za28wTIqG8NcgIve3vbK9UsKA6QlKm
         0QJmmmjYinztrXNe05wL7E9xCzxtFb/x1+76jAxH+lb2bzzIyg9atQboBJD4DrM4N2yv
         NO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRKPAiBDdS7Afghqz/SOxRPJ6FPjN+ps+2ffOIEw7VU=;
        b=WJD0QMpHI5IaJX6s2Oa25F/kC/lAEwyzGhv5xMPqCkM3ePA/jXpnfcsAy2tOr/bpaD
         AsOiKrKK9eTeY5jvjo0+SR+pO+vJ160RJnoiKS5I7OgjkrTq+PkJ7iw6/r0tggjZow5K
         d1cd0cfsVHLHWXO1tcobCHAshhob/zbUdN+OtsYNvZL9o4c/XOxMb5k3fkNaeG0GjgLb
         Lt+GZ/ixdu7omid/VTu0SE4HU992r9rQLbnHk2QIPZBWj4BHupxToezw3LHUD+Cs+wrH
         qlQD/Ph1DtuF2UBg7yo8z8N5i2q2GAbt0JvOxbtreQNbrF1hgempo5mt8wKQl0E8ghwz
         LbAA==
X-Gm-Message-State: APjAAAXi/suI1+MKioK2whGAUzp4EFufJSQ7SFx5r6NNryA/nh4OIRBr
        9LogovO6MiEo4iGOphyrYg04PVRI5ZE=
X-Google-Smtp-Source: APXvYqwkq3fwbj8m6pwSYM0PMS4kV6anuJlOmEc/vrJFwK51Qv4BPyFQd9ebkFtfms/Xci27PmVWrA==
X-Received: by 2002:a17:90a:d593:: with SMTP id v19mr2849201pju.1.1566350806538;
        Tue, 20 Aug 2019 18:26:46 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:45 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 02/12] thermal: qoriq: Don't store struct thermal_zone_device reference
Date:   Tue, 20 Aug 2019 18:26:02 -0700
Message-Id: <20190821012612.7823-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Struct thermal_zone_device reference stored as sensor's private data
isn't really used anywhere in the code. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 91f9f49d2776..6d40b9788266 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -65,7 +65,6 @@ struct qoriq_tmu_data;
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct thermal_zone_device	*tzd;
 	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
@@ -114,6 +113,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
+		struct thermal_zone_device *tzd;
+
 		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
@@ -121,13 +122,15 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		qdata->sensor[id]->id = id;
 		qdata->sensor[id]->qdata = qdata;
-		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
-				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
-		if (IS_ERR(qdata->sensor[id]->tzd)) {
-			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
+
+		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+							   qdata->sensor[id],
+							   &tmu_tz_ops);
+		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV)
 				continue;
 			else
-				return PTR_ERR(qdata->sensor[id]->tzd);
+				return PTR_ERR(tzd);
 		}
 
 		sites |= 0x1 << (15 - id);
-- 
2.21.0

