Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0348887F
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfHJF3v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:29:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37212 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:29:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id 129so203231pfa.4;
        Fri, 09 Aug 2019 22:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OgfjFUuoODNFVR0ZkvXZDxeFbZPjLqSi2JIeoavOMgw=;
        b=MJc3rDZPoveXjHTdN7LEH2hpFio/XloP5QHsQGg4GMD0LCzGAz+jZSCHG50z1LvXaH
         WxRdKkPluVG8Rxm1vvFvttyqFiEBhh5iRxJiPn9BLstbW9LTuN8jej5YcGRl4UOxHmYJ
         CX3mjXj4KVcB5IdyZuVkEEuPe6fBn4rPvPGLj13Ezl08ch19+EJ9IE5oRzoBIK27S2t9
         dtJm9b+iXCbqWT/gZTmPLnyiP/9+fsV/jVGgSXGXNf5x4pe+aQ9Xft6UHuP61Qvha0/O
         1hzCp82QsTbhbZMdC+vEBCCy2BcyldfSQqjIm9dCp0i7OtoPysbMIBLTdXskwuUdhB23
         Oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OgfjFUuoODNFVR0ZkvXZDxeFbZPjLqSi2JIeoavOMgw=;
        b=GYIpb6kiuh0RKIzSJSYTZfZ31mgNQbbvjfVqf7KkGOoW8EX2DL2z4TveyrFMlAAR/e
         evAErIqswK5oCXR6d/kJUSaTeef8qFyKpSJ7vZ883oRr401lDufsHhsiLkKlLd0rGEXt
         f1RovSSR9YgeWwslyCe5+xlSzwPDimlhL7VUaB9tIDg4KDt8qouXAg95lfWSn9+R7E00
         IBCHcYuBpcbx/bTrS7NrJHKjTRTWiVDPiLgyPUIXcQbUspvsxV9PH3OCTURB6V58nuOT
         khHRzP9FKOMQVtRyluI/0N8Rd4Bn1nGac73ld5L8ph2CUnEQRW/3SlP/eBpxEG7WkqGw
         QDAg==
X-Gm-Message-State: APjAAAWSllk6cP+BX+kWp6ygC9qOt6YFHThs/wgI7OcqzEDGJGc6F9hX
        eRgDYGQ+SlOXMKN6jmYdXmc=
X-Google-Smtp-Source: APXvYqwC4638wzZl+8v+psyBs+EeT0oA2gS/8mge82pBrAdHJeehqHQxiVbpjzKmAwzQqbXgrXp7+Q==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr12858514pja.106.1565414990372;
        Fri, 09 Aug 2019 22:29:50 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id i7sm8395873pjk.24.2019.08.09.22.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:49 -0700 (PDT)
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
Subject: [PATCH v5 09/18] thermal: sun8i: rework for ths calibrate func
Date:   Sat, 10 Aug 2019 05:28:20 +0000
Message-Id: <20190810052829.6032-10-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here, we do something to prepare for the subsequent
support of multiple platforms.

1) rename sun50i_ths_calibrate to sun8i_ths_calibrate, because
   this function should be suitable for all platforms now.

2) introduce calibrate callback to mask calibration method
   differences.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 86 ++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 6f4294c2aba7..47c20c4c69e7 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -60,6 +60,8 @@ struct ths_thermal_chip {
 	int		scale;
 	int		ft_deviation;
 	int		temp_data_base;
+	int		(*calibrate)(struct ths_device *tmdev,
+				     u16 *caldata, int callen);
 	int		(*init)(struct ths_device *tmdev);
 	int             (*irq_ack)(struct ths_device *tmdev);
 };
@@ -152,45 +154,14 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int sun50i_ths_calibrate(struct ths_device *tmdev)
+static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
+				   u16 *caldata, int callen)
 {
-	struct nvmem_cell *calcell;
 	struct device *dev = tmdev->dev;
-	u16 *caldata;
-	size_t callen;
-	int ft_temp;
-	int i, ret = 0;
-
-	calcell = devm_nvmem_cell_get(dev, "calib");
-	if (IS_ERR(calcell)) {
-		if (PTR_ERR(calcell) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		/*
-		 * Even if the external calibration data stored in sid is
-		 * not accessible, the THS hardware can still work, although
-		 * the data won't be so accurate.
-		 *
-		 * The default value of calibration register is 0x800 for
-		 * every sensor, and the calibration value is usually 0x7xx
-		 * or 0x8xx, so they won't be away from the default value
-		 * for a lot.
-		 *
-		 * So here we do not return error if the calibartion data is
-		 * not available, except the probe needs deferring.
-		 */
-		goto out;
-	}
+	int i, ft_temp;
 
-	caldata = nvmem_cell_read(calcell, &callen);
-	if (IS_ERR(caldata)) {
-		ret = PTR_ERR(caldata);
-		goto out;
-	}
-
-	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num) {
-		ret = -EINVAL;
-		goto out_free;
-	}
+	if (!caldata[0] || callen < 2 + 2 * tmdev->chip->sensor_num)
+		return -EINVAL;
 
 	/*
 	 * efuse layout:
@@ -245,7 +216,45 @@ static int sun50i_ths_calibrate(struct ths_device *tmdev)
 				   cdata << offset);
 	}
 
-out_free:
+	return 0;
+}
+
+static int sun8i_ths_calibrate(struct ths_device *tmdev)
+{
+	struct nvmem_cell *calcell;
+	struct device *dev = tmdev->dev;
+	u16 *caldata;
+	size_t callen;
+	int ret = 0;
+
+	calcell = devm_nvmem_cell_get(dev, "calib");
+	if (IS_ERR(calcell)) {
+		if (PTR_ERR(calcell) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		/*
+		 * Even if the external calibration data stored in sid is
+		 * not accessible, the THS hardware can still work, although
+		 * the data won't be so accurate.
+		 *
+		 * The default value of calibration register is 0x800 for
+		 * every sensor, and the calibration value is usually 0x7xx
+		 * or 0x8xx, so they won't be away from the default value
+		 * for a lot.
+		 *
+		 * So here we do not return error if the calibartion data is
+		 * not available, except the probe needs deferring.
+		 */
+		goto out;
+	}
+
+	caldata = nvmem_cell_read(calcell, &callen);
+	if (IS_ERR(caldata)) {
+		ret = PTR_ERR(caldata);
+		goto out;
+	}
+
+	tmdev->chip->calibrate(tmdev, caldata, callen);
+
 	kfree(caldata);
 out:
 	return ret;
@@ -294,7 +303,7 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		goto bus_disable;
 
-	ret = sun50i_ths_calibrate(tmdev);
+	ret = sun8i_ths_calibrate(tmdev);
 	if (ret)
 		goto mod_disable;
 
@@ -422,6 +431,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.scale = -67,
 	.ft_deviation = SUN50I_H6_FT_DEVIATION,
 	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun50i_h6_ths_calibrate,
 	.init = sun50i_h6_thermal_init,
 	.irq_ack = sun50i_h6_irq_ack,
 };
-- 
2.17.1

