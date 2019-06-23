Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3665A4FCD7
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfFWQmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 12:42:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34780 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfFWQmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 12:42:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so6126389pfc.1;
        Sun, 23 Jun 2019 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wt7RMWJEU5nf2APAW5wITney1vGRi8ExyzwA2ly5tbM=;
        b=DO56xL8GNC3pRjMbczek/js2aH+Jr00XhhADU2CusMADs20FUQ6om0QfFNRcH7bIok
         utY8iKwz2gs/7WHR18tlrl+XRM9KtdS9MZyCglgz5ZWErisPeGVp+BPEcw81Ezw1KyjP
         +I7gFX+cYEvLyjmwJRHb04L6mRZ4LjmdVX+GURXCGE4Ky2HFiZkXGwRma8nQVRg7xzb1
         OpjjtLiiCN+Zc/sg6Vk26H04UbcX2a5L9ZDyAyFJkne9LJuc3SjKpjccxQ4NfVaSg62X
         sX8QGDvadx5+1F6N6uKmqbh/oIFj9SbUUmdqZyIvf9VMIoiCKn8bIS68Io+mfdDuE05u
         4YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wt7RMWJEU5nf2APAW5wITney1vGRi8ExyzwA2ly5tbM=;
        b=fuO5jCXvT1vmpjRvtSuaDIkIg7S+7itQPALdSigBTo1jNPKqr0yf8Dx0+lljpn5ZnE
         Y7wx43I3jTcF/jLWNG1xsZM66eosR8ZukLbd/Q+vP+Eqt6sDCHdHnoc4kKBLckAcVmlO
         rL9tlvuPW1tqKyBSTzGw54rDqlo3IxTDbfw6knFH0TcctocewGuudeEaJGsmTzYMAHzG
         /6ZCmCUPKrH+a81RT767/E5rhZjxLQ1kUBM2+hhtc1wQ010ndZc+xCFPtVeLfqnl1xab
         Rx1pVE+YxKHMNHgkwfUN8qrAS4+/jbZj8vg3ul/3tO0m/1q0wJA1+xnqDUqtfkm48kiC
         vZxA==
X-Gm-Message-State: APjAAAVQHO5c5sns6gO7YkZPIOAX/sTt94K5OVx3W4YGnTByMEZPPGZ2
        JmsewR9rTpyCUo6IqmFaZN0=
X-Google-Smtp-Source: APXvYqyPdz3cE/WXdIcDs7kmAR8F/niCfqMamQH54dQcogysOpQv1BP/blKrSSByCMUg+zO2djgwVA==
X-Received: by 2002:a17:90a:7f02:: with SMTP id k2mr19642846pjl.78.1561308154262;
        Sun, 23 Jun 2019 09:42:34 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y17sm4923619pfe.148.2019.06.23.09.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 09:42:33 -0700 (PDT)
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
Subject: [PATCH v4 11/11] thermal: sun8i: add thermal driver for h3
Date:   Sun, 23 Jun 2019 12:42:06 -0400
Message-Id: <20190623164206.7467-12-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190623164206.7467-1-tiny.windzz@gmail.com>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds the support for allwinner h3 thermal sensor.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 72 +++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 260b24340f5b..c8ee291f3b17 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -27,6 +27,14 @@
 #define TEMP_TO_REG				672
 #define CALIBRATE_DEFAULT			0x800
 
+#define SUN8I_THS_CTRL0				0x00
+#define SUN8I_THS_CTRL2				0x40
+#define SUN8I_THS_IC				0x44
+#define SUN8I_THS_IS				0x48
+#define SUN8I_THS_MFC				0x70
+#define SUN8I_THS_TEMP_CALIB			0x74
+#define SUN8I_THS_TEMP_DATA			0x80
+
 #define SUN50I_THS_CTRL0			0x00
 #define SUN50I_H6_THS_ENABLE			0x04
 #define SUN50I_H6_THS_PC			0x08
@@ -36,6 +44,9 @@
 #define SUN50I_H6_THS_TEMP_CALIB		0xa0
 #define SUN50I_H6_THS_TEMP_DATA			0xc0
 
+#define SUN8I_THS_CTRL0_T_ACQ0(x)		(GENMASK(15, 0) & (x))
+#define SUN8I_THS_CTRL2_T_ACQ1(x)		((GENMASK(15, 0) & (x)) << 16)
+
 #define SUN50I_THS_CTRL0_T_ACQ(x)		((GENMASK(15, 0) & (x)) << 16)
 #define SUN50I_THS_FILTER_EN			BIT(2)
 #define SUN50I_THS_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
@@ -121,6 +132,21 @@ static const struct regmap_config config = {
 	.fast_io = true,
 };
 
+static int sun8i_h3_irq_ack(struct ths_device *tmdev)
+{
+	int state, ret = 0;
+
+	regmap_read(tmdev->regmap, SUN8I_THS_IS, &state);
+
+	if (state & BIT(8)) {
+		regmap_write(tmdev->regmap, SUN8I_THS_IS,
+			     BIT(8));
+		ret |= BIT(1);
+	}
+
+	return ret;
+}
+
 static int sun50i_h6_irq_ack(struct ths_device *tmdev)
 {
 	int i, state, ret = 0;
@@ -154,6 +180,14 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int sun8i_h3_ths_calibrate(struct ths_device *tmdev,
+			       u16 *caldata, int callen)
+{
+	regmap_write(tmdev->regmap, SUN8I_THS_TEMP_CALIB, *caldata);
+
+	return 0;
+}
+
 static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 				   u16 *caldata, int callen)
 {
@@ -325,6 +359,32 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	return ret;
 }
 
+static int sun8i_h3_thermal_init(struct ths_device *tmdev)
+{
+	/* average over 4 samples */
+	regmap_write(tmdev->regmap, SUN8I_THS_MFC,
+		     SUN50I_THS_FILTER_EN |
+		     SUN50I_THS_FILTER_TYPE(1));
+	/*
+	 * period = (x + 1) * 4096 / clkin; ~10ms
+	 * enable data interrupt
+	 */
+	regmap_write(tmdev->regmap, SUN8I_THS_IC,
+		     SUN50I_H6_THS_PC_TEMP_PERIOD(58) | BIT(8));
+	/*
+	 * clkin = 24MHz
+	 * T acquire = clkin / (x + 1)
+	 *           = 20us
+	 * enable sensor
+	 */
+	regmap_write(tmdev->regmap, SUN8I_THS_CTRL0,
+		     SUN8I_THS_CTRL0_T_ACQ0(479));
+	regmap_write(tmdev->regmap, SUN8I_THS_CTRL2,
+		     SUN8I_THS_CTRL2_T_ACQ1(479) | BIT(0));
+
+	return 0;
+}
+
 static int sun50i_thermal_init(struct ths_device *tmdev)
 {
 	int val;
@@ -431,6 +491,17 @@ static int sun8i_ths_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct ths_thermal_chip sun8i_h3_ths = {
+	.sensor_num = 1,
+	.offset = -1794,
+	.scale = -121,
+	.has_ahb_clk = true,
+	.temp_data_base = SUN8I_THS_TEMP_DATA,
+	.calibrate = sun8i_h3_ths_calibrate,
+	.init = sun8i_h3_thermal_init,
+	.irq_ack = sun8i_h3_irq_ack,
+};
+
 static const struct ths_thermal_chip sun50i_h6_ths = {
 	.sensor_num = 2,
 	.offset = -2794,
@@ -443,6 +514,7 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 };
 
 static const struct of_device_id of_ths_match[] = {
+	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ /* sentinel */ },
 };
-- 
2.17.1

