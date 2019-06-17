Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2125488A1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfFQQPs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:15:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44894 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfFQQPP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 12:15:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so6074998pgp.11;
        Mon, 17 Jun 2019 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZ90DhHT8CO/5qNgjTb6mBPSn8GWQK6QCs0cgFE8TtA=;
        b=dG+wreBxEaHsComMHuxEBKpM4K02esxOz2dAqzsHat4NaD3V2dYuDVPU84ZlxCU0j0
         IlohTIpmFk+eRGQRtVBZ4n/8+SYjiNqM2ddLvkfsd5l/KS1Z79pdKMAYb5JEqOKLKvcN
         ppZrbxw7MwuZo6fRg5Wxz+dW/NB+Qoncc9n1AZJyxZndHpKWp3jW22+1Xnj9lLV1+e1R
         /BQ5maDg1LlZPWgjMPwOCfqAxOqRfUBCLW3iw6Qdbx4ab9DfzUAU6zQ6oMig58oEdh0y
         bQznKkgpuxVv3lEayF1PsFliiYTNZjg+011u3uj8bYb7ljqBxMFZCNHVyveef5ZU6VOQ
         jiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZ90DhHT8CO/5qNgjTb6mBPSn8GWQK6QCs0cgFE8TtA=;
        b=hxl6ZzuElwTMnxeq5y8P/Bw9P9wIivXAAM5zU0OVXx3o7GRKUeL2drwfj8uvig1kKT
         AK3amwA0JogKbSczbi5WQ7ETEh4cx5mkPqSABHazrBUd60Wr3oc89bDqycRsV54InzVz
         HKO4U//k3O4KlSLiFdRXm64dk6iZvdrlZg5qO8bVhV+HGqVxPvUPpoNTubBmGNrVQ7n2
         eXMWumhoYB134ny2imUUNJadKLemEpKeGvVSVIP6X+HGNTySvUESWcCS1H5nHr1gcKCp
         ozwIrFsLiv/sV87GOJ/Veh9hzrEuUkc8sSJb4/L8YoOMVg6iiKRMqq+Dog/2szOPxfM/
         e0oA==
X-Gm-Message-State: APjAAAWrTxyOhCZ7EvHKeh8mEkPS7zrOAscNJMpxTdCc7wPaH3+h0ROq
        Y8HzRvoysJZGmz30R5YG2JmNQFiltJU=
X-Google-Smtp-Source: APXvYqw6Qhib+IyT1joRfGJMLyhc/2ztGk+uWqSnqm9Cb9VXKUul3LISBGmNRLlV/5b2VEPAwacAWA==
X-Received: by 2002:a63:6c87:: with SMTP id h129mr51006479pgc.427.1560788114037;
        Mon, 17 Jun 2019 09:15:14 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c9sm14791953pfn.3.2019.06.17.09.15.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 09:15:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/12] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date:   Mon, 17 Jun 2019 09:14:51 -0700
Message-Id: <20190617161458.3754-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617161458.3754-1-andrew.smirnov@gmail.com>
References: <20190617161458.3754-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
instead of passing a paltform device and then deriving it. This is
done as a first step to simplify resource deallocation code.

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
 drivers/thermal/qoriq_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 4d5c74173f08..61700881d9f0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -109,9 +109,9 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
-static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
+static int qoriq_tmu_register_tmu_zone(struct device *dev,
+				       struct qoriq_tmu_data *qdata)
 {
-	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
@@ -120,7 +120,7 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		sensor->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   sensor,
 							   &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
@@ -216,7 +216,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	ret = qoriq_tmu_register_tmu_zone(pdev);
+	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-- 
2.21.0

