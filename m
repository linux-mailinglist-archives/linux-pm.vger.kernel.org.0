Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E388879
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfHJF3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:29:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37426 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:29:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so14035993pgp.4;
        Fri, 09 Aug 2019 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SZBPS8zX1lZ/DonV5C3komhokQ/V7ug4it4W/EoGy10=;
        b=Z1VAV24vg4CQO/RAn7VbwJQFpjru/ocEIBsBk0qmfgVAcVSZPT/FcVCmkdU9IlZ1Ka
         Oc/1YloYmzzKO0Db83AB6D5gnVGah40VCwhk3qBijk6A7R2FFZdcxyNCgJNjVgFjSQ89
         gS9dqvB8OILKpmhDVKj95toNNPOYSwf4tGM9xEg6ae5IO3c06X+1FQXXNjccX6LDIEfp
         GIp1nvLiSooojE5mPj406ljHLub9v1/y5aIPEYVf8JIgpacJPn06cLCj9AqNFapdofGP
         9qN97TZ6HHo2VHwCIvaiEQIpCE8+hvg+SrXi969f020vIZ+IFlMtD/cEBAMmi9hX9uei
         9g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SZBPS8zX1lZ/DonV5C3komhokQ/V7ug4it4W/EoGy10=;
        b=MCVvz2X/dV/q2SF/YInC6jO8M75G+B3zXOMxkn+kcimrMcGk5V9HOqU+15H8paD027
         EC7PP0Iob7i+xHuoTr7PxyjiAM6EBX4Wo+lqscLNrisw9en2SEs2v4nZ8TFan4bY5rCV
         rDa62qE/teQcl1eEA9loXpAdsWFvpwf1IjlkS067q4/X1pUZTNAIQ4NXgAqrYVg9Ko9o
         C5Xc2taWIm8lQ4Y8d+Lk1XHiW2MCFVxc996NAAV2spZCOVihTvxCor4/gb+UThK8ZRjB
         r3StGRhxuid3Tfe0j4YBYvjlkQdPAcUNyH+SrIla7dbPYoLUL3r37udMYLrs2AySg143
         OgYw==
X-Gm-Message-State: APjAAAWZufk19URbnrvwUKzsDQaOHXuBf8tXiSJEWAqkLvIH6D8ghkC/
        USyBes1yU2WZLDnSbyH5zoA=
X-Google-Smtp-Source: APXvYqxslAn91+Gj9uqWPdAgQd4zH50Cp4kKggNShpSaPtsQosYJo1BWGkVX8KozpR9h/90K+ktYjA==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr25970077pfd.207.1565414985703;
        Fri, 09 Aug 2019 22:29:45 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id j20sm95375157pfr.113.2019.08.09.22.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:45 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 08/18] thermal: sun8i: support mod clocks
Date:   Sat, 10 Aug 2019 05:28:19 +0000
Message-Id: <20190810052829.6032-9-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
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
index b934bc81eba7..6f4294c2aba7 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -54,6 +54,7 @@ struct tsensor {
 };
 
 struct ths_thermal_chip {
+	bool            has_mod_clk;
 	int		sensor_num;
 	int		offset;
 	int		scale;
@@ -69,6 +70,7 @@ struct ths_device {
 	struct regmap				*regmap;
 	struct reset_control			*reset;
 	struct clk				*bus_clk;
+	struct clk                              *mod_clk;
 	struct tsensor				sensor[MAX_SENSOR_NUM];
 };
 
@@ -274,6 +276,12 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (IS_ERR(tmdev->bus_clk))
 		return PTR_ERR(tmdev->bus_clk);
 
+	if (tmdev->chip->has_mod_clk) {
+		tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		if (IS_ERR(tmdev->mod_clk))
+			return PTR_ERR(tmdev->mod_clk);
+	}
+
 	ret = reset_control_deassert(tmdev->reset);
 	if (ret)
 		return ret;
@@ -282,12 +290,18 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		goto assert_reset;
 
-	ret = sun50i_ths_calibrate(tmdev);
+	ret = clk_prepare_enable(tmdev->mod_clk);
 	if (ret)
 		goto bus_disable;
 
+	ret = sun50i_ths_calibrate(tmdev);
+	if (ret)
+		goto mod_disable;
+
 	return 0;
 
+mod_disable:
+	clk_disable_unprepare(tmdev->mod_clk);
 bus_disable:
 	clk_disable_unprepare(tmdev->bus_clk);
 assert_reset:
@@ -395,6 +409,7 @@ static int sun8i_ths_remove(struct platform_device *pdev)
 {
 	struct ths_device *tmdev = platform_get_drvdata(pdev);
 
+	clk_disable_unprepare(tmdev->mod_clk);
 	clk_disable_unprepare(tmdev->bus_clk);
 	reset_control_assert(tmdev->reset);
 
-- 
2.17.1

