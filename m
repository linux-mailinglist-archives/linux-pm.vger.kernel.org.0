Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC896EDF
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfHUB1X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:27:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37730 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfHUB0v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:26:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so327883pgp.4;
        Tue, 20 Aug 2019 18:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZ90DhHT8CO/5qNgjTb6mBPSn8GWQK6QCs0cgFE8TtA=;
        b=S4hkkpluTlhx1lM2rWILPxqM/B3k579x3OgNJNig3prxsY0uGDoHAWzS7M5fyYSWKd
         0SBdKi2So0uhJlaTAtV4dKLriQVqxIuXvjKJGRNKnNJwip4rJUWp3rZdsTyig7o41Irw
         fQ8vS1/63YtYIchnw0w3HHh/Qa6i620jKOTP2Kx5zHQqwjX/tf0grSvdN+5TB2blBCt0
         H6myFmsDLQMHKS6MvGDOj9EeBOMqU0af6kuZa5FVH4bRzbW/VIWpjCu7d5z/H+Kn5OI1
         FixQdHNFZvTwRKbqWZKhkk9jHh8ov18R8fupeEApV1+CE4OkJSgKzDhedHu5AfFnjxBe
         ZA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZ90DhHT8CO/5qNgjTb6mBPSn8GWQK6QCs0cgFE8TtA=;
        b=hP1aFSNOvXRrnQF1ECzpWYvZeonV3S0ggiv91jPR5tLiAhiEEhGt+e86Ubu4tsa2k7
         9P5LJ6E8s5wtDMxDlvn7FUziAU9ZBTYZz5wMIDI6TGXX7WjBNoOXguVnZeMZeUn2DOdu
         KWo438DijraY2I5ObfaED5AT6tJDJDkMoobJz6SL2HqXj26tVX0oP6cKChNoUi5cHByI
         g4t11x9OWBUCQjQv4mmGTT9IoE1YqqJnW9dpATu7O3BkX8Yi1TIUq60W4bmRcMXo/hgO
         HPn6EguXleOUUKOxSFWMG6+9uNXTqWVmFsJrIWFAaUQVw5p4Uzl5q95rtvM6gu8o+eoK
         y1Bg==
X-Gm-Message-State: APjAAAWFm44wlHJVbShOJMDuC/zkjvqMWqfzAuvXo/k2eNj4utAOI7E6
        AgTast3IYEWqdiRaKsti3ynimaqZxcI=
X-Google-Smtp-Source: APXvYqxJ5SCCCYtGFqQio25YNUBVtXbkJ+GcicRiGDf9W1ibDWivLlga3NiTwfq3pQHN3+c0pIWpBg==
X-Received: by 2002:a17:90a:a611:: with SMTP id c17mr2944453pjq.17.1566350810482;
        Tue, 20 Aug 2019 18:26:50 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id bt18sm1162700pjb.1.2019.08.20.18.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:26:49 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v6 05/12] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date:   Tue, 20 Aug 2019 18:26:05 -0700
Message-Id: <20190821012612.7823-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821012612.7823-1-andrew.smirnov@gmail.com>
References: <20190821012612.7823-1-andrew.smirnov@gmail.com>
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

