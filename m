Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2328096EE2
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfHUB13 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:27:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37608 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHUB0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id bj8so387270plb.4;
        Tue, 20 Aug 2019 18:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPtNRLf/SrSAgB1w5g/hOa8brwvMvBa7EQaySVw1mH0=;
        b=MuSNRG4BXeiLBsWGPoccFlgoMQCn0WJt0aT2/gaiyTt7uk2UhKtQiBSgDt45Feepdh
         CLZszeAJrn6vAqLz8WS6mpyfY1nQ850NpnaU+s7c60B7UKpYD1BZFZKh4YnPhovGDsZY
         DNU4/bZ/abU7KPD/YmxbNG5g/nNwCGJYFjG1W9EGK1PNXlndJquAsaxgkVRQtQheoCoz
         n+qqP3Ui2IJ8u9p5417jhitl5vbr93gHTig4vSaEQGQHsDhqPqxHqTj6Do61H2Esy4jK
         vd3OB5Y6jnRMmP5V5o3NHC9k+Vy0UmZfIZc3vYHAZSiJo7RHdvosjTRv9J05d1FHz3yg
         G5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPtNRLf/SrSAgB1w5g/hOa8brwvMvBa7EQaySVw1mH0=;
        b=mQ6rkpbvCFFRrH3DDuLJt/+6dXiWwM0XZcYYXhUTjoD6g5666NPIiSsOYs6q4Vv7F5
         IbmXIGzlodv/BU5Oodpn3RHIZRt2NP2eXl1w8j7fn7abYQLeQtNUdWApfBLlgzhBeuWh
         8QssV1nx91pQsHoukisH8Fz0yw7uEocVPgOPqX5wFbxf0Tc6F8ghIhAUNRmuC238kDMq
         yszUHupT5s7uwgcuOWqDzmD39lueqWlFLmnBfSwHJ3jCRvcILiJB1Ze2wqBdjko9Xb2S
         sgKpqAsysySMzy1Ws3+xiRXWNVsl+ZrCZWyWidLCoNPDO2Ad68hEZlbcDGPn1aPXSPiV
         szRA==
X-Gm-Message-State: APjAAAVXGVg8pxvpLiWWa+l8Tt1EgRYa4/4xRqg3wsxbx/UqUWmDXHN/
        Izacz07s5H/LACM5gyEJU4fvHEEkawU=
X-Google-Smtp-Source: APXvYqw3CxmCi6+LeIJrDVGcY5kcLU3zGkuLdSA9weHlnelEAnUp/kpFUGQN98ICKbWMmKiDfnrRbw==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr11118151pla.208.1566350807885;
        Tue, 20 Aug 2019 18:26:47 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:47 -0700 (PDT)
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
Subject: [RESEND PATCH v6 03/12] thermal: qoriq: Add local struct qoriq_sensor pointer
Date:   Tue, 20 Aug 2019 18:26:03 -0700
Message-Id: <20190821012612.7823-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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
index 6d40b9788266..d74c6c494f77 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -114,17 +114,21 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
+		struct qoriq_sensor *sensor;
 
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
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
-- 
2.21.0

