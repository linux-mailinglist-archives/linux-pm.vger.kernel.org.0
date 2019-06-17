Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C68704889C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfFQQPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32900 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfFQQPM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so6095716pga.0;
        Mon, 17 Jun 2019 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPtNRLf/SrSAgB1w5g/hOa8brwvMvBa7EQaySVw1mH0=;
        b=jWMVS0FVPO6glDrv/sMoRX6352I8Z0iMxkVNwkLWhK6ct115V+yjbKAPACOAGO7cUW
         iWKB4WXp/7eyB4cgGeMIVTIFS8W5y8gz3pqju4k2STfYulQxy+DJRnKBmP2Wq4iCBoFF
         L8/U76yrhm/zuBSughla27Mx5LvNY4tnMbkZT0ilRtInL8tFCChBkCHYP1wZFhaWPSqF
         /nAHV8/kgtOY6zE8f9weP1M1SfC8mudHPAzBDh/Vb27voUYAeocHOWnukHC40M/UuWb0
         MXbra05k9jV+uX/sqO5ixige+I+3N7j+FZLxlG6ecaboc3NZ/2DYDr2cOlGvhGKrV3dM
         otig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPtNRLf/SrSAgB1w5g/hOa8brwvMvBa7EQaySVw1mH0=;
        b=hw5HIfag0Zo6rtm4J6SntqVC1qwEChG+ORDjCgKwyjfUxaUmA4u+CYv30CJEsFpaR9
         xhHzBeGefFHOZUhWk9//lPmNpyiWnQb33NphXz3dFePqrtL355yKSD+18gX443D2JXof
         MlEAPZeKHjh11yuVlMbteE/YrqIJt4wAUlwug+jl3vxpEbvxdFMHeGd/d4cfsT2yz8zb
         hQbwwbOD/x/5Ud4ZSxugDuJ+x89tebiTx6LEQkO2Cx96GDWBIpuQ5RwHCz9Mr7QkP6iV
         mnf6bSAAjD/n+5tl7pP7ugusMJPdzbQUCoYIF9oBrwiF+8hPi49ntMcGuN/18+qt7qCn
         YN7Q==
X-Gm-Message-State: APjAAAUsiGq8I7v71h48e4opec+SoKLdOpbzjgJEhKEoQzOSOBkz1j02
        bL3kVKttfuVTtBHnYWbCLsqK/vi6coM=
X-Google-Smtp-Source: APXvYqwvHMPgK6+tRvOgOfIOlTF4I6kM7hR9GmnG0KDoYvho4levE3FR+bVA38aD6IqG7J2imQsGjg==
X-Received: by 2002:a65:5889:: with SMTP id d9mr23381440pgu.39.1560788111298;
        Mon, 17 Jun 2019 09:15:11 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:10 -0700 (PDT)
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
Subject: [PATCH v6 03/12] thermal: qoriq: Add local struct qoriq_sensor pointer
Date:   Mon, 17 Jun 2019 09:14:49 -0700
Message-Id: <20190617161458.3754-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
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

