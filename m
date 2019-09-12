Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6EDB067D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfILB3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:29:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34266 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfILB3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:29:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id r12so14876941pfh.1;
        Wed, 11 Sep 2019 18:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OR6DWQhTypRBQHla5x+NK6izgQjlqJvyqAknMpBOllI=;
        b=ZcKKJm8FaDFbn0QfMEd8lIidM69k4WK9BSHKdg8nZNQtq+Nle2LTESZhRGOorSfFIh
         4qGL+RZ15HRjmHQTS/E2KvTotuQAKpUbF6hfpCheDtUBC/TGanwrPek2jtnTp9UVU6lI
         eFRqxtArPy7fEmeNxj2ScXfpP8LePMXGx0vTiV/+vDA+rbILSykWZWw0hHH6e4d/wHSN
         ja9fKwqCvTZpWm6YjqQ+q3CmpmzjqRk7xzbRWMDHE/v/8B4imJ74nlcmggH96SfhILDp
         ukum5NCzTHWGoUPZqp/pojDNjf2owzcrInMW8nR7whEdFzOQplfS/0iHDMGEGzOa77GD
         Ob9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OR6DWQhTypRBQHla5x+NK6izgQjlqJvyqAknMpBOllI=;
        b=ZpM3r0tOCDb9fw+em31b2Z6mfrluHoAeUj3EovHVn8slkLFmLwoG67j/atE3W8mwGR
         EnM47SA1aOJ5xEVnqE4MiaocA9BF5nSNrqSuwDfgw+4TtkdsKC92vUZIKUT0b/E3pSVM
         qXmM3UR1d5APGG4lUXiMNCZSpU6lBEMpEh9XxjCtGmQQwnkaZT+ryIO/I28IfCOvSuCb
         LqCjVkUMf3Bmzdd1i0IULDGNpb43txb9jqUZPPleKTzpS+0WwQeg/HBBmC8Zaf48EWml
         Rru3jox1v4xv0ZDSuo+/fvkV3lalkzdqT2YiVfEPHdIumpHd8xeexbnqJjx0XsCpY0AT
         qqaw==
X-Gm-Message-State: APjAAAX7MdmhXtISO3JyKw3w3RU9dVrnV/etQkCFp0JkTTHF1MC9QNmQ
        8dLeXg52IEmhmfqLHLdlwtM=
X-Google-Smtp-Source: APXvYqxz6Ycf+vKYiZPhzTMgmz9HOyCTLFAamUMrRD89fVPwIiAZlSJiCY6h6oSQVnzysASKZvOqGg==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr36194656pgi.70.1568251783401;
        Wed, 11 Sep 2019 18:29:43 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id u4sm20781699pfh.55.2019.09.11.18.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:29:42 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/12] thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
Date:   Wed, 11 Sep 2019 18:29:12 -0700
Message-Id: <20190912012920.29601-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912012920.29601-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
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
index ae22836c471d..f8f5228d83af 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -60,13 +60,10 @@ struct qoriq_tmu_regs {
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
 
@@ -74,9 +71,14 @@ struct qoriq_tmu_data {
 	struct qoriq_tmu_regs __iomem *regs;
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
@@ -96,7 +98,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 static int tmu_get_temp(void *p, int *temp)
 {
 	struct qoriq_sensor *qsensor = p;
-	struct qoriq_tmu_data *qdata = qsensor->qdata;
+	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 
 	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
@@ -116,19 +118,10 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
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

