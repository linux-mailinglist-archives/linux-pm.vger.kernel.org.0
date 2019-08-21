Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4464F96EE0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfHUB0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:26:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45277 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHUB0u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so369697plr.12;
        Tue, 20 Aug 2019 18:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnAuUwzgMNkund4HFbyzfCfrHx67s1Khkw3zRwQVHks=;
        b=Mr91wQBcOwuPFQ6U+I/VrFEXdHffd/SJhg3jtJihSjPcKkcPIZQKfQ9IuFpav650em
         aJ+Q+PeGevFfmVpDuForjCcpmAyUAcjQke+lXir+xQtzJr2tbYJ5W35RgtPaxDKfsR5k
         MJSPO08sTgZSg0njBXBd3+NvKz4LczARe5Eeo4/0Kbr5YdpGeJATlcreA5tZe0jHKkll
         AyDHdixcMc6tRTaN7w1gHuMHKrnceqQP6rUqp0Olh+lfHVp3WGMpAPZHSY4aVt5e2zIT
         5h68axzfWjL6raNCCL7m95DwvRvVjn8ytapfncYFv+A/kcJ2LFZft1notxx7DulhnI2d
         bOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnAuUwzgMNkund4HFbyzfCfrHx67s1Khkw3zRwQVHks=;
        b=oHik3fIUlGi4ohYNrAiBRiX/ZgLw4edMPbwRl2ReC8ud4yQmTIYa6bY/BPs490B3nD
         GV4gK4tRgaTdZ6FpSVzRvP1YrGV3Gz3tdNiM0gwurc/r+YrY38d4vd3Gem5l2zJuN4vM
         CXO6X/3X7ED69z+8l8UN/ifBKCpokJ5qgM77pDVOwqykOCeijjz+tm0f5EllHB2fA0O6
         obcSzNBLP3WRRGLNkODKr2hFgE+KMGfSFoPq4aJt5+gq+iuRB1pqNe6IEvAK6SLQ4zLy
         +pGxsPAO9gWzpSsD1sUsbLS3VmOYv+0s1+DFOf+6LMbdON3PBrx1YwSNhbxZazISJONW
         r1Rg==
X-Gm-Message-State: APjAAAXNtGUB8oG7ZuOafhf+ETSSqTICMc2t4GienrY9SBPRAvmufHPy
        9OVjNse5n+75j4F/P68ycHW2hDeSwiU=
X-Google-Smtp-Source: APXvYqwVd+y5JZxyHRRDmuRZYNsnfcMXMRBAcONoncAC7G9QQR96Vx90tAforPtbKxtBGifuYne5pg==
X-Received: by 2002:a17:902:e60c:: with SMTP id cm12mr30048089plb.304.1566350809295;
        Tue, 20 Aug 2019 18:26:49 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:48 -0700 (PDT)
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
Subject: [RESEND PATCH v6 04/12] thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
Date:   Tue, 20 Aug 2019 18:26:04 -0700
Message-Id: <20190821012612.7823-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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

