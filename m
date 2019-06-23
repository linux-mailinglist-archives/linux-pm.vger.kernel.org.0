Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F534FCE0
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFWQmb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41540 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfFWQma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so5477942pls.8;
        Sun, 23 Jun 2019 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ddH5x5C4Xtp9rpA7ryYSwYalCmUTcgexoa3qISyw2Ug=;
        b=tsMXbUAgFpwgrGExbojVFp6U+eGCSeVvQ9COwf0RIP4o6x6lu/cIpPJiU6z+BFl/nK
         9uFezX6fSwPv9SbDVCJn3nhgK/wYhAFSTfVVRRAhcNasUfzmZNRNBq5NprqM6MXbisSq
         rP+DULOHG0lJXd/9kgnzSrzrblAND0GWor0omm6c0+wmv5e+fOLhzGZjm7zOzgfuEABy
         EfrYFjcW3IBzwSMs9sbgOeJ77y8uOu5Y7HxeZXjGZXnEXTILq1rFPK51guGEWRnO8mqK
         Fl40iQX/QBS5ZgxCR5H+2+oJHs4rCVb6WIRs3UE5BrsYv6TcH8ldw/s+ObnC9wRjr8gT
         JZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ddH5x5C4Xtp9rpA7ryYSwYalCmUTcgexoa3qISyw2Ug=;
        b=jp86XKVu9KpDDvZ7NINRUECULfpFHE8o1qhnfyUe3ScWbKFC2IRnfvksHLIwWINKux
         MMYblL24cE2VPhBnTQhyahmewJQCCiFOMghYAhb6VXmosNMhxxiuXavu9i4In7GseUrB
         70Q+9ozQROuil/8oQjNo9hOSMyoUw5niiOhrySEsOc+ALE+MI186uQDsUfDiC0SkZKU9
         TEanmDdL2qaOPe1nxk2puneSPI3E6+giYJMVs8Vzm9BE0TwXPYu2ebn6dbuZc9YxEqd2
         s4UpQGWpMPC0xB1DqjGb9tm3B94aRZM3NU07Pc893iatZDEdPf2/sO+drgAyedBCvGZj
         Mwuw==
X-Gm-Message-State: APjAAAXhb1NSBGwYDyJrSZvZ7b28LE1TD+pL2QXUGOROCmQ2N4ASw0Lv
        qh0AXrsD9oGpX484bvH2PV0=
X-Google-Smtp-Source: APXvYqykivldidC6OTPZpmATBM7ATqQAb23IP4aVg9WLyjsROhNPDhwqIZxuE7cbseWPK8Nr0H/tlQ==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35mr142206227plg.190.1561308149084;
        Sun, 23 Jun 2019 09:42:29 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l13sm7708993pjq.20.2019.06.23.09.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:28 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 08/11] thermal: sun8i: support ahb clocks
Date:   Sun, 23 Jun 2019 12:42:03 -0400
Message-Id: <20190623164206.7467-9-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

H3 has extra clock, so introduce something in ths_thermal_chip/ths_device
and adds the process of the clock.

This is pre-work for supprt it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index ed1c19bb27cf..04f53ffb6a14 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -54,6 +54,7 @@ struct tsensor {
 };
 
 struct ths_thermal_chip {
+	bool            has_ahb_clk;
 	int		sensor_num;
 	int		offset;
 	int		scale;
@@ -69,6 +70,7 @@ struct ths_device {
 	struct regmap				*regmap;
 	struct reset_control			*reset;
 	struct clk				*bus_clk;
+	struct clk                              *ahb_clk;
 	struct tsensor				sensor[MAX_SENSOR_NUM];
 };
 
@@ -280,6 +282,12 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (IS_ERR(tmdev->bus_clk))
 		return PTR_ERR(tmdev->bus_clk);
 
+	if (tmdev->chip->has_ahb_clk) {
+		tmdev->ahb_clk = devm_clk_get(&pdev->dev, "ahb");
+		if (IS_ERR(tmdev->ahb_clk))
+			return PTR_ERR(tmdev->ahb_clk);
+	}
+
 	ret = reset_control_deassert(tmdev->reset);
 	if (ret)
 		return ret;
@@ -288,12 +296,18 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		goto assert_reset;
 
-	ret = sun50i_ths_calibrate(tmdev);
+	ret = clk_prepare_enable(tmdev->ahb_clk);
 	if (ret)
 		goto bus_disable;
 
+	ret = sun50i_ths_calibrate(tmdev);
+	if (ret)
+		goto ahb_disable;
+
 	return 0;
 
+ahb_disable:
+	clk_disable_unprepare(tmdev->ahb_clk);
 bus_disable:
 	clk_disable_unprepare(tmdev->bus_clk);
 assert_reset:
@@ -401,6 +415,7 @@ static int sun8i_ths_remove(struct platform_device *pdev)
 {
 	struct ths_device *tmdev = platform_get_drvdata(pdev);
 
+	clk_disable_unprepare(tmdev->ahb_clk);
 	clk_disable_unprepare(tmdev->bus_clk);
 	reset_control_assert(tmdev->reset);
 
-- 
2.17.1

