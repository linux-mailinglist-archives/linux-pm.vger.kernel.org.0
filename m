Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA622BEB4
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgGXHM3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 03:12:29 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:52863 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbgGXHM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 03:12:29 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1472325|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0288318-0.000377861-0.97079;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.I6qVYnt_1595574739;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I6qVYnt_1595574739)
          by smtp.aliyun-inc.com(10.147.40.200);
          Fri, 24 Jul 2020 15:12:24 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        linux-pm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH v5 08/16] thermal: sun8i: add TEMP_CALIB_MASK for calibration data in sun50i_h6_ths_calibrate
Date:   Fri, 24 Jul 2020 15:11:42 +0800
Message-Id: <dcf98648c16aff7649ff82438bfce6caae3e176f.1595572867.git.frank@allwinnertech.com>
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

For sun50i_h6_ths_calibrate(), the data read from nvmem needs a round of
calculation. On the other hand, the newer SOC may store other data in
the space other than 12bit sensor data. Add mask operation to read data
to avoid conversion error.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/thermal/sun8i_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 74d73be16496..f423d44b9290 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -244,7 +244,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	ft_temp = (caldata[0] & FT_TEMP_MASK) * 100;
 
 	for (i = 0; i < tmdev->chip->sensor_num; i++) {
-		int sensor_reg = caldata[i + 1];
+		int sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
 		int cdata, offset;
 		int sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
 
-- 
2.24.0

