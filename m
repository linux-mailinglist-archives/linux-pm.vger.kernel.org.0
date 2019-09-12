Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EFEB067E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfILB3o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:29:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45164 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbfILB3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:29:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so14802068pfb.12;
        Wed, 11 Sep 2019 18:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZI89W7IaixNfucadKsVf0r9M2xz9qgAVdHmzWYig2g=;
        b=tnsQq+odE1etiRE++QpDdmxAK4vcon3IKW+D+GDGYqPpHweEpAtCme3odhqcXgcKbc
         coNngI4dzWjsIzN5t2myh+6NR5AOqhd1Frq7aE68r5c8jFXNz5IS+wBo65YhXmjrNBps
         jIuoKCyriqZEsXq1XJgF1LQXBIb+S7NiHqA5NvFOZf7Of1/imaYzGtb+tsZZbriEFdIh
         CUp2Id5Welqts73ueLpVL7e/wFfeaAXfClkKtcZSqZjrDtZDfGN1g9Xrr0BL5zjhmW3P
         1RlNoL4EUAadSJf3G+MJwv3Lg5v4R853IhNxzTZ7/izQoKAnDvZUEt3blbEckUdE2sai
         mCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZI89W7IaixNfucadKsVf0r9M2xz9qgAVdHmzWYig2g=;
        b=KC3HZ7Yu0j5w1qVobxkk6e3eNMAkjssnJ5qCgn4LkcrfIB7tQYl45Z/rkDgdpv5F9J
         HCExcA55Yq1hHTb1B/ZORvE+YRWIW53Js+KOhxvJX1g8zPxzrFYY0QnBZR4yD0rQGoNC
         sICwCc84tb0neXHi++y6v95pmJ1oUwWA1jTmf0BgMXHF3U+EznSWGYSr2TsrNQOQy16g
         xYFMBTkkmazwb720YZYd7yfDYnnqebGlpLglV3xe1KmVAnfNf57Bqg4QihTHTovWfEqm
         fmOUOV8AJzkKxOn3CbyANhBg86dyec5c8HJczxq7E9UqLwvf0d0YoizHQTVeIF5A+k8N
         P7Tg==
X-Gm-Message-State: APjAAAWXr+x/aZtrYUa/yAQt6tvD437NmWNhxhEgp2j+/Ksjhdg5ltgr
        X0LnFhALPE3Ze7TB4+XMP4Y=
X-Google-Smtp-Source: APXvYqwJp6ormbc2GCjZy26O2TiA17rS5z52ROWSpn0v5oD7kGDFK3Y+kYtCdkq1vXYqvHsxkZ2ogw==
X-Received: by 2002:a63:5402:: with SMTP id i2mr35600956pgb.414.1568251782137;
        Wed, 11 Sep 2019 18:29:42 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id u4sm20781699pfh.55.2019.09.11.18.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:29:41 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/12] thermal: qoriq: Add local struct qoriq_sensor pointer
Date:   Wed, 11 Sep 2019 18:29:11 -0700
Message-Id: <20190912012920.29601-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912012920.29601-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add local struct qoriq_sensor pointer in qoriq_tmu_register_tmu_zone()
for brevity.

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
 drivers/thermal/qoriq_thermal.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index b471c226f06b..ae22836c471d 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -116,18 +116,22 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
+		struct qoriq_sensor *sensor;
 		int ret;
 
-		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
-				sizeof(struct qoriq_sensor), GFP_KERNEL);
+		sensor = devm_kzalloc(&pdev->dev,
+				      sizeof(struct qoriq_sensor),
+				      GFP_KERNEL);
 		if (!qdata->sensor[id])
 			return -ENOMEM;
 
-		qdata->sensor[id]->id = id;
-		qdata->sensor[id]->qdata = qdata;
+		qdata->sensor[id] = sensor;
+
+		sensor->id = id;
+		sensor->qdata = qdata;
 
 		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
-							   qdata->sensor[id],
+							   sensor,
 							   &tmu_tz_ops);
 		ret = PTR_ERR_OR_ZERO(tzd);
 		if (ret) {
-- 
2.21.0

