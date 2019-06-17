Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21257488A2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfFQQPL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42096 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfFQQPL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id l19so6071600pgh.9;
        Mon, 17 Jun 2019 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRKPAiBDdS7Afghqz/SOxRPJ6FPjN+ps+2ffOIEw7VU=;
        b=sW9fpUjdaRZWsNdxItpc/ms/cp9fd/mjIEjj/kdPJbqJ/hFrjrOBoxqs82IG5xzNFl
         AywCgH5XOFyNqIzhyakCRmeHDLn1bfa6/F45xG8Zyj0wb5rXgfV0+yGm1b1yD8bRkh8I
         yHqH/vXwbPmcClg/wG2roE2+MPFh2lPuUeRVBMtMgF5zrCeTOSLIVZR3LrmL6h9iqkf2
         sebAVQEY9vXA2RwqCOMZT7V4nX5vIDvgPGAGBKvZVk7PVtAwWkdiKHwToSWqorC4EASn
         YpegTKhNbS1I5DwQ5TCxXNfk5Q3QotEVVK7FZarP74Y/ubYXA+MTLP57flgePfW1wR8H
         WS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRKPAiBDdS7Afghqz/SOxRPJ6FPjN+ps+2ffOIEw7VU=;
        b=Do3XEZi+l7C2pAOvoMPsbZ2XixARdkRkE2Qu/lvnUm2QyHZ4OHSyPigl/7fxPzzjPj
         JPxcLpqlsuzH6dWkmSbvD/2DJnz8hBwzfWChr6+LC2iFfSa9sbqBled/7B6FOURB1Dx5
         e8XxQKbPNbPsz3uORd0UhUJwMJk8a/R/yS1VST4FqzsxVu0EA3sHXOR3NKDA4R58W30Z
         GNqlKT9YlohdktkSebFU0OpIZBFY38HH0UauOo5MP04pF617F1ctd0uoLQJfPUrEO2rJ
         F5rXMnjPfGhEG5lEzGP4n9mXSjjP0ys4XeEXuI+zTcOsf9EUUGSuS7L3MuIV5WKDO6/w
         jIDw==
X-Gm-Message-State: APjAAAXHULpmOtXS4w1cLXBfqfZwPy2+kQOfyktbg72AU/WT0MVtSkJb
        E1d0H2FzRQpWimGvmRXKOTJ4avrbiVU=
X-Google-Smtp-Source: APXvYqxS7N66AVrCeD0fXY+6DE1zAFMbrOtSpmOzGTkbkfVwSrV+lsK3t24TPALJtrLzRMn3OTfk8w==
X-Received: by 2002:a17:90a:cf0d:: with SMTP id h13mr26157865pju.63.1560788110218;
        Mon, 17 Jun 2019 09:15:10 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:09 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/12] thermal: qoriq: Don't store struct thermal_zone_device reference
Date:   Mon, 17 Jun 2019 09:14:48 -0700
Message-Id: <20190617161458.3754-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
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

