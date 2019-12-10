Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFF118DF9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfLJQmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 11:42:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32800 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfLJQmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 11:42:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so9173608pgk.0;
        Tue, 10 Dec 2019 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KrHHV8WagrQw//LLkgB8ANSCBK2Q9bQ9Pa7bMN8q10Q=;
        b=sNq8+BmRFRIpUJlu7Y61TqM613g3/K9Xa44jR5RpgWtbW+U/9hu4ydJ1NmwezZK1E1
         U+LVihdsXKe5IOaSX1+0wk2Do8WlQlspWMnh6jPkf6ThBlk0+i0eCBBVkYLH0gX+6Ess
         ZpoY2fopIkshVVjNnl9BGufqrK9SWARJLURBXxdsWgO8gQ3w2edeCjf7+EOffytsFIZC
         s6xa94kxIETdANklRB/MHmyUYL77K0re0+pDsnsYzRAKrQzbFNzyotODOi+OZ0HvRUJN
         4RkA+gsSHnxev0R2feRBCbtPBaOwAYBAia4tDK5Txi+0W3EOYyhP3L1FNowZQIltwiT1
         TWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KrHHV8WagrQw//LLkgB8ANSCBK2Q9bQ9Pa7bMN8q10Q=;
        b=NuEs0C8ljkL6I/ulnVIvXkAgIggB+OsnSz+jhQGAe5SUpNx/VUIyG4xWgPyN04GKNi
         UfljwTODzXcNPgvQG/+LZIANrTW2+hcbWdSEzAwkM0s5XdN8ZHvi6WJ84+XJuVYn+pi5
         ETbmweCq/OiNs2Q5L7nKAfDSdIcoaf/F5mjI5Tk1A0YpT66ctUkxcZ1HYJRVAnOklV5H
         P9b2Ulmiitf9YyVjvIr4DoqwOMWYGP8tVWw0pGSsnHCin2VinKUv9dhidbevDsV5jb+V
         EGjoz7QSqLjXeiXaaSS21IUVgmrUBI8XVWVYGpF6i6DmSHTCh8AB1W+ys1XOAP3a4/iQ
         6UXQ==
X-Gm-Message-State: APjAAAXZaTli3WckMbBvy6wN0Fa53HcElfvrJRtEkKd9HQ6JSwD0pJ8L
        epoP7ni+DW3KrhmJoPhX/VE=
X-Google-Smtp-Source: APXvYqxyi9b/k2Vg/oO5+FvVdGeeUDa+i4WKHQaorgFlG57MNypLssR4bNffFqPzHTASi7VIfmlm9A==
X-Received: by 2002:a63:fa04:: with SMTP id y4mr25730627pgh.413.1575996133176;
        Tue, 10 Dec 2019 08:42:13 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:11 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/12] thermal: qoriq: Add local struct qoriq_sensor pointer
Date:   Tue, 10 Dec 2019 08:41:44 -0800
Message-Id: <20191210164153.10463-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
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
index 2f2f5ffa8f26..61733d820e1b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -162,18 +162,22 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
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

