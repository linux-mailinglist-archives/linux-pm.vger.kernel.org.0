Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC84118DFE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfLJQmM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42312 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfLJQmL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so108837pfz.9;
        Tue, 10 Dec 2019 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1CVdA9r3UVKQnabq2mx7w9JDC1aJtWHX+VPZ20Gprac=;
        b=SeHa9vyU4/5ORBBMIwkil5fZpYyec136edPWMMh+HEhNU6zc9cWB9Qx+uE2+58kuep
         5L70XerBhwQ4FqIHu4/ZKmJAHLUSC5TCHhkSQthO8sqZSGZq1uMr1uysm2Ja2IqEMHy8
         tpivOuNxjQcQBBqV5puReQtQteCyL1LOCOeAc6A17KDUob4iHSozZYgfDP6Ow9oRBFYY
         H6/yAgnkrhHH+pvh0rYBjYO6vvZr2om4LWeb2yqNovgMhfbqYXT2vesX9zdU7fXi5S2G
         ne4MW1Vc9a25MecMJVb0pvi7spG7pa1ER3hzRx7BPXXTXiqCDb8uRtDCHsee5rpoPNXi
         GqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CVdA9r3UVKQnabq2mx7w9JDC1aJtWHX+VPZ20Gprac=;
        b=PUYMcwthJgYRSPkHIZVGsDUQZWtnc65S/0YwVe5lX3o7JwSAlYRE7V9yHNnNEcdXdf
         gTmhN3bnte5HvtSs2Edi3lZ4TmI/x1hSNdmXm6ngE0icgiNL2jDF49354/znKH7eVpxL
         QPY2vaMrw90sslktaqtlXtjiThxDj3A1ztArFlw/ACkxd16w6ZcuMq4vgJpmcIQYBASW
         Ck2KLzt0zJ+86oLyyAS+DFdxek78o+m92p6lw5bBJEHRIO7RJJYGTaqjkwC9ykVeg/aV
         0tFau2MfZsg85ht7/u+m3neQR8N1S5r+yyfhE1ngoaHGU5PneGWo8aJPyd0dZq3rvsZY
         IoAg==
X-Gm-Message-State: APjAAAUIraUykaEcgWyqu4PNQxEJF0lDl0aRDcyZnPmY3kJf7Fgz96aI
        M5XPmLG9OzPqXN96z5iz7YE=
X-Google-Smtp-Source: APXvYqxUtptb6cnnNgY1Bwgg6JzPFzKBJ6mgYUz1QfoIVpSeV9cebiCsDCynPLK5dYhXpHISIBUExA==
X-Received: by 2002:a63:28c7:: with SMTP id o190mr24892871pgo.394.1575996130884;
        Tue, 10 Dec 2019 08:42:10 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:08 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/12] thermal: qoriq: Don't store struct thermal_zone_device reference
Date:   Tue, 10 Dec 2019 08:41:43 -0800
Message-Id: <20191210164153.10463-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
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
index dd47b31aeecc..2f2f5ffa8f26 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -110,7 +110,6 @@ struct qoriq_tmu_data;
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct thermal_zone_device	*tzd;
 	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
@@ -162,6 +161,9 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
+		struct thermal_zone_device *tzd;
+		int ret;
+
 		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
@@ -169,13 +171,16 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
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
 
 		if (qdata->ver == TMU_VER1)
-- 
2.21.0

