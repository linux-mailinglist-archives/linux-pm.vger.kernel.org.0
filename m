Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F94889D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfFQQPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46453 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfFQQPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so4264811pls.13;
        Mon, 17 Jun 2019 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnAuUwzgMNkund4HFbyzfCfrHx67s1Khkw3zRwQVHks=;
        b=VxKYExHdQwgyW+4bWrQQ3AJMfTS3QHqEqVyMf4RFHfMxJhZVKJVl05gUFt5t1txupr
         F52vU+RbuJvDbXDpIeFAX2qVcLmvG0xmMibFQ6NiPInhs4fDKOtOojIVrSQl0H2+CuUz
         IQvrq/eRmVPob8CiQVnFob4vkHgqMDDrt6ocxPN8xxtle5eUnB2BC9M7/OVlsdUjqkaL
         tbZBd3h2WvnbF1I7ZOGdxtCxPZKZZe7LOGLsPKYr7EckWpf7I7AZBX9fzzw4w62viiE9
         XY4Hy7mwON51ddkQv69dOX+DlyYMqd8Tso/aKl7lykdzCP4iOIDcBVvsbzOyu2usqDZY
         Rp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnAuUwzgMNkund4HFbyzfCfrHx67s1Khkw3zRwQVHks=;
        b=OsEv+sJ1TwlxSlfChhhik0ldLOxmIKCqZzc9pHxh5iXT41uliTpqA5ltcaEGlNu++Q
         FkNAzhTrWpJ8PucuXj3EbMVjHQZIm4smc9oWfqAKoF8fFuEM1ldta4x27uUyYlNS8gDp
         RD2rJ5MB+wfaBJrwEPx03LmRGZiJpWWAR6dBugaIWwklZcPV6FGdePGa+p6Qn5f9I9ZW
         ZuDvTs7uRSF5DzKx5KKnqrOaEWLSo7iGkAmFrrRgDgcueaEr1ffOI8jyxPFLnNfLhaJD
         YCIoHlsn3hZMzxKNBY2SO8Ko4Sak2wFEI4VJwIOFMADnpWMnI5rFVCH6MteBohBD/IEs
         oFog==
X-Gm-Message-State: APjAAAU373TNJC5P6c04joaNAtlNegKrLnpHZ4TmHae3lCFEpHaby0za
        DB5nwA6Vw7wI6u/iirWP/zyBjVZ3AG8=
X-Google-Smtp-Source: APXvYqw4UbH1JusNif6881cHAMpwV11NsOd0fQUIZ/zNAgVxASO7xwLoD9Yxr35X7AckprXu5DIcDg==
X-Received: by 2002:a17:902:e512:: with SMTP id ck18mr2810622plb.53.1560788112874;
        Mon, 17 Jun 2019 09:15:12 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:12 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/12] thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
Date:   Mon, 17 Jun 2019 09:14:50 -0700
Message-Id: <20190617161458.3754-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Embed per-sensor data into struct qoriq_tmu_data so we can drop the
code allocating it. This also allows us to get rid of per-sensor back
reference to struct qoriq_tmu_data since now its address can be
caluclated using container_of().

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
index d74c6c494f77..4d5c74173f08 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -59,22 +59,24 @@ struct qoriq_tmu_regs {
 	u32 ttr3cr;		/* Temperature Range 3 Control Register */
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
 
 struct qoriq_tmu_data {
 	struct qoriq_tmu_regs __iomem *regs;
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
@@ -94,7 +96,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 static int tmu_get_temp(void *p, int *temp)
 {
 	struct qoriq_sensor *qsensor = p;
-	struct qoriq_tmu_data *qdata = qsensor->qdata;
+	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 
 	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
@@ -114,18 +116,9 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
-		struct qoriq_sensor *sensor;
-
-		sensor = devm_kzalloc(&pdev->dev,
-				      sizeof(struct qoriq_sensor),
-				      GFP_KERNEL);
-		if (!qdata->sensor[id])
-			return -ENOMEM;
-
-		qdata->sensor[id] = sensor;
+		struct qoriq_sensor *sensor = &qdata->sensor[id];
 
 		sensor->id = id;
-		sensor->qdata = qdata;
 
 		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
 							   sensor,
-- 
2.21.0

