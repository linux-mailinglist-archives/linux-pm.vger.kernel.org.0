Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72656118DFB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfLJQmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41780 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfLJQmP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so9159249pgk.8;
        Tue, 10 Dec 2019 08:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kNjFdHXf8jZm7sjagZ2hATQl5PtTR6d1QOCcaqLh2I=;
        b=mOIiF9oPquNnCy4V6LIjRZvWTVS5vV33CcpIUt8APDh+1oFKSKWx3dE3e8OM6H0gYe
         FjKc0F319QN/um7fHtsnuO4wgEM7zsILukEF4PylaQh+P+eQK8MN0y5QTtVaU9avXrlA
         5Q4rCrcXPs+825DlJNMvjz11hHhYUt7kTpbD9h8Rx5uJj7ii/mDClvOlC3KaT064oTAY
         Npp+ghUgG+pStWpPeYLs7LlI4Abf3acFZY+4ZaiRpWhrDwegweNEDAJkGnbc9yB3hv3f
         pSWV6qrMfscpVZhdZslfjP2aACSlo7/JFr1cUMqf9vo5sdniamNDPrf2+cN2pErkBgzO
         t8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kNjFdHXf8jZm7sjagZ2hATQl5PtTR6d1QOCcaqLh2I=;
        b=ZAdtyQS6WCuVvJM157QO+0HhohivI556F3S15xWijp3uODlbncZUw7kIiQXDcg990o
         AZGlfw9x++eldtfNGpqdFbdEokG01ZZ5Ibw+BiPQbWIeNEdB7CFMsdHFHneQHjEBgPJJ
         KaMDX23rjYGJrppLEhSspmVPBdo9R8U663pHCvY16R/52xqnnNsFz9Uy/dtwbQB9j6Me
         NqE3RXRLYXKfuf7L07Hap8jlFQQg/i5mOPvjTRAM+duNBGemYd+iHn1McqjL0KXE59qU
         2FO1YQItrvHtYkZZjyqWKUsMBBDEeIxM2dZRIXjwjv5DgZkKMd7LEsKfOrBBUFm0eOpf
         ynyA==
X-Gm-Message-State: APjAAAWDo6AgFZAx3Y6/9uRIHzNLgWj7Lhu+zPKQZZGx00kVdJ9G8/kL
        zp1R3/PI2MYH/VP2a4BlKTM=
X-Google-Smtp-Source: APXvYqw7kNA6VaT0g+YqyUQMqtJyNciwqVJCBpHydxtARq7ao18awyG9LMIIEfCeFLNN5E9ywC0sdA==
X-Received: by 2002:a63:3089:: with SMTP id w131mr26268693pgw.453.1575996134840;
        Tue, 10 Dec 2019 08:42:14 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:13 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/12] thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
Date:   Tue, 10 Dec 2019 08:41:45 -0800
Message-Id: <20191210164153.10463-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Embed per-sensor data into struct qoriq_tmu_data so we can drop the
code allocating it. This also allows us to get rid of per-sensor back
reference to struct qoriq_tmu_data since now its address can be
calculated using container_of().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 61733d820e1b..9886daf8ac97 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -104,13 +104,10 @@ struct qoriq_tmu_regs_v2 {
 	u32 ttrcr[4];	/* Temperature Range Control Register */
 };
 
-struct qoriq_tmu_data;
-
 /*
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
 
@@ -120,9 +117,14 @@ struct qoriq_tmu_data {
 	struct qoriq_tmu_regs_v2 __iomem *regs_v2;
 	struct clk *clk;
 	bool little_endian;
-	struct qoriq_sensor	*sensor[SITES_MAX];
+	struct qoriq_sensor	sensor[SITES_MAX];
 };
 
+static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
+{
+	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
+}
+
 static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
 {
 	if (p->little_endian)
@@ -142,7 +144,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 static int tmu_get_temp(void *p, int *temp)
 {
 	struct qoriq_sensor *qsensor = p;
-	struct qoriq_tmu_data *qdata = qsensor->qdata;
+	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 
 	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
@@ -162,19 +164,10 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
-		struct qoriq_sensor *sensor;
+		struct qoriq_sensor *sensor = &qdata->sensor[id];
 		int ret;
 
-		sensor = devm_kzalloc(&pdev->dev,
-				      sizeof(struct qoriq_sensor),
-				      GFP_KERNEL);
-		if (!qdata->sensor[id])
-			return -ENOMEM;
-
-		qdata->sensor[id] = sensor;
-
 		sensor->id = id;
-		sensor->qdata = qdata;
 
 		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
 							   sensor,
-- 
2.21.0

