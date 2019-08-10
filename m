Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C180588898
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 07:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfHJFaV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Aug 2019 01:30:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43321 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfHJFaU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2019 01:30:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so47121674pfg.10;
        Fri, 09 Aug 2019 22:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jx9rIdpPyDLrhQcjiIIVEfnMNx20+ROJhWSfoScLHXY=;
        b=peecNcquOPiuM7iIKtsSfIA1I0Dxu7JsVnKQotHt1q+Qce3IacmQ6yTeBvqDkBGzFK
         LzS43cgpuHmXz4JUUzyyjL28zKH05Hc+2tWuKxa9+XG17jDecW7H3y/Yukd5Eun3pzjD
         Y1nMgLP4jLja2J7JfsK372ktppt4/glNQQnBM5n8jaLqHYkXYD4u0zPgqEExCMGBMsge
         9uRL/Ql1tMDwoxOL8+uY5G+vOfKhNxuYmZCf7sV3CNvy60MB/wZ3He2UICmbP4y7bUKq
         E3lfGBjaax6Hk+MJNiUR3wLCAOGmM7G5LihcqWEEp3kS26SR+bvwS3pEAX+z9pAF80BD
         n3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jx9rIdpPyDLrhQcjiIIVEfnMNx20+ROJhWSfoScLHXY=;
        b=oZotaZCzb4z2z/cEhITykMK0nP+oPBZxOG7yP/r+WAld7KReab+ZMOQ0hX9LagBMof
         JoC5KNQ9CbfFY8V4z0o7lAfbxgBdDQuEYcAqDRzSjczesI/YwNxs387ITpoMvSMnytaV
         l9hdY2sjDTskwp0T8ST/v5e9d97J4eblPiYONofhkUMvQF5IONGzJmoQwHATi8uUZWO4
         yMlxsjNUI6yk9XJhLW3LbkhcNptAAwS7TX6gKVAQOBW2fICAC1RT7XZgoCJ5rM2ntTDI
         RtbydK9I9Y+kL64dTY40psBSBWv0oE+aNYnMCj1++/QoW/NAg+iTLd0ImnaQIU5DXu9x
         XJ6w==
X-Gm-Message-State: APjAAAVIXW57Swsca8Iesy9IoysbD8cyak43TUZU+jqRAv3IgXM63ItA
        DsX0PArLYIhCQxchRubTMHw=
X-Google-Smtp-Source: APXvYqyWKOzcWX7HwlY+V4ut7VgR7PSWiZa3XTBvcf7JoCfOdZzsBeq8k/QGs9LtRDC5/kVc58/k9g==
X-Received: by 2002:a63:5945:: with SMTP id j5mr20501987pgm.452.1565415019890;
        Fri, 09 Aug 2019 22:30:19 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id e189sm86883416pgc.15.2019.08.09.22.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:30:19 -0700 (PDT)
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
Subject: [PATCH v5 16/18] thermal: sun8i: add support for Allwinner H5 thermal sensor
Date:   Sat, 10 Aug 2019 05:28:27 +0000
Message-Id: <20190810052829.6032-17-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The thermal sensor in Allwinner H5 has 2 sensors, and they have a
special segmented temperature calculation formula.

Add support for this thermal sensor.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/thermal/sun8i_thermal.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index a761e2afda08..78a888d85cba 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -99,6 +99,16 @@ static int sun8i_ths_reg2temp(struct ths_device *tmdev,
 		return (reg + tmdev->chip->offset) * tmdev->chip->scale;
 }
 
+static int sun50i_h5_calc_temp(int id, int reg)
+{
+	if (reg >= 0x500)
+		return -1191 * reg / 10 + 223000;
+	else if (!id)
+		return -1452 * reg / 10 + 259000;
+	else
+		return -1590 * reg / 10 + 276000;
+}
+
 static int sun8i_ths_get_temp(void *data, int *temp)
 {
 	struct tsensor *s = data;
@@ -530,6 +540,16 @@ static const struct ths_thermal_chip sun50i_a64_ths = {
 	.irq_ack = sun8i_h3_irq_ack,
 };
 
+static const struct ths_thermal_chip sun50i_h5_ths = {
+	.sensor_num = 2,
+	.has_mod_clk = true,
+	.temp_data_base = SUN8I_THS_TEMP_DATA,
+	.calibrate = sun8i_h3_ths_calibrate,
+	.init = sun8i_h3_thermal_init,
+	.irq_ack = sun8i_h3_irq_ack,
+	.calc_temp = sun50i_h5_calc_temp,
+};
+
 static const struct ths_thermal_chip sun50i_h6_ths = {
 	.sensor_num = 2,
 	.offset = -2794,
@@ -544,6 +564,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
 	{ .compatible = "allwinner,sun50i-a64-ths", .data = &sun50i_a64_ths },
+	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ /* sentinel */ },
 };
-- 
2.17.1

