Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64290B0673
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfILB3m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:29:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44421 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfILB3l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:29:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so14823869pfn.11;
        Wed, 11 Sep 2019 18:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymu8f8cvhmZmTX/wIizpAWbB6vsQLcw46eunxAg5tiw=;
        b=PUnEMn0PYut00Ae6LfA+TkLSo4AUtnp4uaubaCT0QOhJAKPz/tY3sqcgtiJNaDZc2T
         16gZBqGMnb4xC9qnJERSoFP2jI4icCZ4HPfAzpte1LJyEPGaashudufer+eg5vsYzZSF
         PbZyaKHdiCcE37H65l10s/6eYOGqeFIYUIGKnB4TPz6nNWZthx/AsA60D8jp3OmRt5qX
         Shrdn5d+lFNJMhtmpEAG6H+yj53pUxvFyFfI+M2j22ccxFwAk/smYLUxGvQc4ghMbdIt
         hpCuk38jFobz+6uFW+2xVYZMlQeHxdevw6bTVfBXmtF2Zb/A8ADQqz4VQU/uHQSVU+RT
         y/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymu8f8cvhmZmTX/wIizpAWbB6vsQLcw46eunxAg5tiw=;
        b=XflWWFgWsKTrZ6P0v0OZVrmgnHl1Q30jleiJ7zavQPiMEa7BUxF0zY30IUUxKeRdb2
         wEjq7kk8585aCBeE2E+sLgKgHHS/O9ObhfXBWwIjUNs3TbJ5/PvJ64I2TnBR/iG8RwaN
         3sa8ZRMQZVjRdzkWj81tatEGLe38ni7VPBTxF28NFc0OlKTsNo07juNbociMGfJ2qQr4
         ZJBi7c/bASgUCzM3/jSrngYUOQBiqrtV+xjxOJLsKWG4MzpWbmmiQNY+YVqximClt1Nt
         65lhS4YtPLByr8KrKjtdmj3cUBrpfQG2URC8cPoQOw4Usm+8BYHe0BIyWHr0Q7xEMcSj
         UsiA==
X-Gm-Message-State: APjAAAV5QGGbSRJ5i6BHiwAW4HXDaCY+t93jET+DqtrtvlfItfPYzGpi
        6X+73u/3pblylKVQv90jkHc=
X-Google-Smtp-Source: APXvYqyD06mHM5o5I8BgYBm+gOCD0UOsGAnoGHpqgMLQB3caY3hgF4fyKketVvdrEq0Vd5IQ1ZxBtA==
X-Received: by 2002:a63:6c02:: with SMTP id h2mr36998260pgc.61.1568251780768;
        Wed, 11 Sep 2019 18:29:40 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id u4sm20781699pfh.55.2019.09.11.18.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:29:39 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/12] thermal: qoriq: Don't store struct thermal_zone_device reference
Date:   Wed, 11 Sep 2019 18:29:10 -0700
Message-Id: <20190912012920.29601-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912012920.29601-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 5df6267a5da0..b471c226f06b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -66,7 +66,6 @@ struct qoriq_tmu_data;
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct thermal_zone_device	*tzd;
 	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
@@ -116,6 +115,9 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
+		struct thermal_zone_device *tzd;
+		int ret;
+
 		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
@@ -123,13 +125,16 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
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
+		ret = PTR_ERR_OR_ZERO(tzd);
+		if (ret) {
+			if (ret == -ENODEV)
 				continue;
 			else
-				return PTR_ERR(qdata->sensor[id]->tzd);
+				return ret;
 		}
 
 		sites |= 0x1 << (15 - id);
-- 
2.21.0

