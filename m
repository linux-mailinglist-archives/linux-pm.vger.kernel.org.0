Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2C88890
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfHJFaR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:30:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37979 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfHJFaR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:30:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so7153522plt.5;
        Fri, 09 Aug 2019 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iiVQJk9D8CfuggMoVj1p+aqwNp2abkAIMeZ4iA8Pj/0=;
        b=ZPRFOqHEq7Cw2ufw3Mm2fY9Oaz3hac0l3Xu5PsEOGPLF7COULFq05vg+XsWinezM2a
         DZ0T6vL1hWwTe2xwQZll89TldlAUZRYW405qeLdMQcjU3/IGu+ZWJJew0nSuWonus/zJ
         3JLaJenIBmaVCH5FZrduNe0PsSup6K0UKslPlWsK8BA/E8H8JA9+iYl6ErJ8ZnZ29/fe
         OZOCVbAzbxScW9VeRy7Gh84k7HOBfX5j1DeoW/PqwkCJtokhft4JzptwnZPYRzsKe0PT
         0A4y/DS2aRJJGlOsoMiG5W01lR8r2O5CEj7S5GST3f7YsPykvQ1a66hOE3UM1BDrjdfZ
         UZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iiVQJk9D8CfuggMoVj1p+aqwNp2abkAIMeZ4iA8Pj/0=;
        b=hsJqKWs5UtEtlh0XqhGaOS23R5Da3C3+CuhtwuP2Sicfqn28odCnO5CMgFpm7NrhLy
         QjVTgEjDHFNINuYMVf3CNrdT2dSati7h/vD1UWhGILayE8YKSOE1ArgFNuG2SOhfA7QA
         6zc3YflToE3YHZ+hJIUD7qxU6pzOV/8GlqWZWiYu0kpfHRssCjpFd1xkzgbKkMrhArWu
         g0qQBJyn5ItN4BH/TITAVvaI3T9CMJiE0NKj6kTUURj5DLul3xEGB2w+AQId/FB3EfR1
         c0riZ6+Iwj1yKVKOat7YqHneWjUwpn8x8LSaDGtAjOHSWn0tP4Zpz+B131nBkggzehYS
         kbVA==
X-Gm-Message-State: APjAAAV9f91J1HfmnUPlQDyqTaPyUMm0CgTEwEQa5mszfOwpdJyqHDNR
        ob8tpVPnuM0uIYiZU41ZnGc=
X-Google-Smtp-Source: APXvYqyJvqnqpxM/3lHUXCDIW0XlM04lSny/PBrutlyVaXbNaFDXGDzHAnGo7L7W6ut3mw/ucA2TpA==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr22881836pla.212.1565415016564;
        Fri, 09 Aug 2019 22:30:16 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id z4sm86286175pgp.80.2019.08.09.22.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:30:16 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v5 15/18] thermal: sun8i: allow to use custom temperature calculation function
Date:   Sat, 10 Aug 2019 05:28:26 +0000
Message-Id: <20190810052829.6032-16-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The H5 temperature calculation function is strange. Firstly, it's
segmented. Secondly, the formula of two sensors are different in the
second segment.

Allow to use a custom temperature calculation function, in case of
the function is complex.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/thermal/sun8i_thermal.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 3259081da841..a761e2afda08 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -76,6 +76,7 @@ struct ths_thermal_chip {
 				     u16 *caldata, int callen);
 	int		(*init)(struct ths_device *tmdev);
 	int             (*irq_ack)(struct ths_device *tmdev);
+	int		(*calc_temp)(int id, int reg);
 };
 
 struct ths_device {
@@ -90,9 +91,12 @@ struct ths_device {
 
 /* Temp Unit: millidegree Celsius */
 static int sun8i_ths_reg2temp(struct ths_device *tmdev,
-			      int reg)
+			      int id, int reg)
 {
-	return (reg + tmdev->chip->offset) * tmdev->chip->scale;
+	if (tmdev->chip->calc_temp)
+		return tmdev->chip->calc_temp(id, reg);
+	else
+		return (reg + tmdev->chip->offset) * tmdev->chip->scale;
 }
 
 static int sun8i_ths_get_temp(void *data, int *temp)
@@ -108,7 +112,7 @@ static int sun8i_ths_get_temp(void *data, int *temp)
 	if (!val)
 		return -EAGAIN;
 
-	*temp = sun8i_ths_reg2temp(tmdev, val);
+	*temp = sun8i_ths_reg2temp(tmdev, s->id, val);
 	/*
 	 * XX - According to the original sdk, there are some platforms(rarely)
 	 * that add a fixed offset value after calculating the temperature
@@ -232,7 +236,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 
 	for (i = 0; i < tmdev->chip->sensor_num; i++) {
 		int reg = (int)caldata[i + 1];
-		int sensor_temp = sun8i_ths_reg2temp(tmdev, reg);
+		int sensor_temp = sun8i_ths_reg2temp(tmdev, i, reg);
 		int delta, cdata, offset;
 
 		/*
-- 
2.17.1

