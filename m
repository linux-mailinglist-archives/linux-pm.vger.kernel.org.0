Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73322BEB6
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 09:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGXHMc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 03:12:32 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:47327 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgGXHMb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 03:12:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2465674|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0178585-0.00014203-0.981999;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.I6qVYnt_1595574739;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I6qVYnt_1595574739)
          by smtp.aliyun-inc.com(10.147.40.200);
          Fri, 24 Jul 2020 15:12:27 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        linux-pm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH v5 09/16] thermal: sun8i: Add A100's THS controller support
Date:   Fri, 24 Jul 2020 15:11:43 +0800
Message-Id: <48cc75920b5c69027134626157089d8b94942711.1595572867.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1595572867.git.frank@allwinnertech.com>
References: <cover.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

This patch add thermal sensor controller support for A100,
which is similar to the previous ones.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/thermal/sun8i_thermal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f423d44b9290..f8b13071a6f4 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -590,6 +590,19 @@ static const struct ths_thermal_chip sun50i_a64_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+static const struct ths_thermal_chip sun50i_a100_ths = {
+	.sensor_num = 3,
+	.has_bus_clk_reset = true,
+	.ft_deviation = 8000,
+	.offset = 187744,
+	.scale = 672,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun50i_h6_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun8i_ths_calc_temp,
+};
+
 static const struct ths_thermal_chip sun50i_h5_ths = {
 	.sensor_num = 2,
 	.has_mod_clk = true,
@@ -619,6 +632,7 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
 	{ .compatible = "allwinner,sun8i-r40-ths", .data = &sun8i_r40_ths },
 	{ .compatible = "allwinner,sun50i-a64-ths", .data = &sun50i_a64_ths },
+	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
 	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ /* sentinel */ },
-- 
2.24.0

