Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27988878
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfHJF3m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:29:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45458 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:29:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so3659598plr.12;
        Fri, 09 Aug 2019 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9CD9LJDj5saAwmZmvd1ahBknyBpZymFtazDBAWPuA/w=;
        b=fDUlzBke9GKEgLeJdcJPCjtMbl9SDaWLS9gqlKxufaa4DWNk2ua2icR1P5zQFlBho+
         ltQ7fP0946RuhfAiOuQiaMqNG+yF/XU5uPLMl5Yn4TF83zaz7slUN7Nh66x3m2RP4xFg
         JKM9RWrzuXpuVa2RKbk29FOvRXQtq1VuL5gkHiqsBS9lVwaL2TS6aaYUqVfe7IctIffN
         i5kRinHbJAIp+f9qWntf+hhLlPOU0CbA+aAYxoAR3cRxchVYapHiWGzIDWg6vaVKCafR
         mSY11weuX6dcfki1ENoMoiPtR0ptyVUPwlgq1Q/6Dgb3FTo9J7IQEZIyrVWXDWVDEDBA
         I/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9CD9LJDj5saAwmZmvd1ahBknyBpZymFtazDBAWPuA/w=;
        b=QmyMMmgDHLdeIjx9QXQgIR7ml08kZ5sqbq+kGelmb5oz36a01NzvZZHiuBgUzX9SYu
         KkiDcNgZFYt2WNXCbME6mXvK7uC+eWRaTzQLYqPfz6ioPVrYAqE77/yLRtn2tDTNYWVt
         nQ+Et4ido0SKGqt931tYoRgEc5lYs6YnAOy6ZHeJTmN3ORs3oYM6eJmXQbE0CfTNC8H8
         d4CreUUBxjjGlU2AbzvCP+uYp0EPnnQnmNBSHkR/Dn6Mbda9yLaOPMg01DbQ0PzjYU4z
         K1FdECeTbGxTKeTBE50t4oofC/0c5T/vz0n1ZfqB+GSu6x+9YQwQm0zanbdBbHXpvdfh
         E5TA==
X-Gm-Message-State: APjAAAVNdgMCfYcMCj+jfe0/y/TqRbbmHTmnOq0Ks8LNlLqTn5jRIOjZ
        jxZiI9hs3DeLRuhmXshVzLU=
X-Google-Smtp-Source: APXvYqwcMDp1wIDPEfH9ZNziCnr+sazmApAC7Z15OOCFSDzNfuB/vRjfDqfeFnQK4y8GQZPZto9DDw==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr1402329pls.10.1565414981650;
        Fri, 09 Aug 2019 22:29:41 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id 185sm100125591pfd.125.2019.08.09.22.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:41 -0700 (PDT)
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
Subject: [PATCH v5 07/18] thermal: sun8i: rework for ths irq handler func
Date:   Sat, 10 Aug 2019 05:28:18 +0000
Message-Id: <20190810052829.6032-8-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here, we do something to prepare for the subsequent
support of multiple platforms.

1) rename sun50i_h6_irq_thread to sun8i_irq_thread, because
   this function should be suitable for all platforms.

2) introduce irq_ack callback to mask interrupt register
   differences.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index ad877b54f58e..b934bc81eba7 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -60,6 +60,7 @@ struct ths_thermal_chip {
 	int		ft_deviation;
 	int		temp_data_base;
 	int		(*init)(struct ths_device *tmdev);
+	int             (*irq_ack)(struct ths_device *tmdev);
 };
 
 struct ths_device {
@@ -116,23 +117,34 @@ static const struct regmap_config config = {
 	.fast_io = true,
 };
 
-static irqreturn_t sun50i_h6_irq_thread(int irq, void *data)
+static int sun50i_h6_irq_ack(struct ths_device *tmdev)
 {
-	struct ths_device *tmdev = data;
-	int i, state;
+	int i, state, ret = 0;
 
 	regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
 
 	for (i = 0; i < tmdev->chip->sensor_num; i++) {
-
 		if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
-			/* clear data irq pending */
 			regmap_write(tmdev->regmap, SUN50I_H6_THS_DIS,
 				     SUN50I_H6_THS_DATA_IRQ_STS(i));
+			ret |= BIT(i);
+		}
+	}
+
+	return ret;
+}
 
+static irqreturn_t sun8i_irq_thread(int irq, void *data)
+{
+	struct ths_device *tmdev = data;
+	int i, state;
+
+	state = tmdev->chip->irq_ack(tmdev);
+
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
+		if (state & BIT(i))
 			thermal_zone_device_update(tmdev->sensor[i].tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
-		}
 	}
 
 	return IRQ_HANDLED;
@@ -371,7 +383,7 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	 * the end.
 	 */
 	ret = devm_request_threaded_irq(dev, irq, NULL,
-					sun50i_h6_irq_thread,
+					sun8i_irq_thread,
 					IRQF_ONESHOT, "ths", tmdev);
 	if (ret)
 		return ret;
@@ -396,6 +408,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.ft_deviation = SUN50I_H6_FT_DEVIATION,
 	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
 	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
 };
 
 static const struct of_device_id of_ths_match[] = {
-- 
2.17.1

