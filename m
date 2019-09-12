Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608CEB0675
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2019 03:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfILB3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 21:29:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45170 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfILB3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 21:29:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so14802132pfb.12;
        Wed, 11 Sep 2019 18:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7A3LgznRtqP7+oj98IopNyB7NhpOkF3e2xGfR20W9Jk=;
        b=tgE/XhYxInBshm09b8VR1hQyQIOlarEvYnCG0u76UcIrqvn1b6L/7dTQD/hE82GAuU
         8X10oJ/wijYa+aMWcmjPpMzwME5oq3Evc60+kVXg5DNn/Ss1Ubl3VVZL821JMB2tGEoL
         olNGSJF6KnfeDJJtHG5VeVWdCZKVSUDo6nTw7nmHfeo693jYO15vVJhk5dg0VMwllVm7
         yEGh/Up9U51upw8NhAFCwvDHncltye/BzQb1Py+JxklOixXSo5/sIK1us70TUaD/x7jL
         X6lGU4E5u5iwCFE7Uv/MFf92ynOZoXLBXNMp/KZqM6wkLOyZv/kH+vX4aNlMdBB6SxU7
         prVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7A3LgznRtqP7+oj98IopNyB7NhpOkF3e2xGfR20W9Jk=;
        b=A6azdNWOGFLLZuKH+Szn0TdxQEeQHRueNgAwwmGGr5FbZKECJ5IYtsPwYtTTqDERH2
         FsSpJUHKaYXvhDv45gVCodrW5soEG2b6E/2SpDnWv7VJ9rRiFJsCY83KSRA4ca/qikHJ
         Zngxb16QXNm2OTB862UMGnBcEiEV/LV02by6KqCW/PXpf42AeA5fQ0p+B/odI8aq+Z0z
         H5BORpeghw+giGGWHr3cDFjrTqniQMUN1RnVGfkWPtbhthFdCvaivZSGq1NIQFaPTrTN
         bNGixvEH4d/nt4qggqRsgA8V2kiPGRQY4RVKV7kZnsrQTG5w/lPHnrT/4VbYslN1InMa
         WuIw==
X-Gm-Message-State: APjAAAVx+ah7fj8fLDgZwSHAQ/s+9z+OGIplw6zEgQaqBbwKhMYuAayY
        PYh+lIbl024J001XlyOeehE=
X-Google-Smtp-Source: APXvYqyXuEZYGsXT+NYIjec2ZLo1RXxejSNUh0wQ7LsWPOqfDB74MRmPdR8cVoFWsXgBnADv5ghz6g==
X-Received: by 2002:a63:6c43:: with SMTP id h64mr10554345pgc.106.1568251784804;
        Wed, 11 Sep 2019 18:29:44 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id u4sm20781699pfh.55.2019.09.11.18.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:29:43 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/12] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date:   Wed, 11 Sep 2019 18:29:13 -0700
Message-Id: <20190912012920.29601-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912012920.29601-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
instead of passing a platform device and then deriving it. This is
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
index f8f5228d83af..5b9f2a31d275 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -111,9 +111,9 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
-static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
+static int qoriq_tmu_register_tmu_zone(struct device *dev,
+				       struct qoriq_tmu_data *qdata)
 {
-	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
@@ -123,7 +123,7 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		sensor->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   sensor,
 							   &tmu_tz_ops);
 		ret = PTR_ERR_OR_ZERO(tzd);
@@ -229,7 +229,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err;
 
-	ret = qoriq_tmu_register_tmu_zone(pdev);
+	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-- 
2.21.0

