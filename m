Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED71B27A6B9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 07:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI1FFj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 01:05:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37142 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgI1FFj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Sep 2020 01:05:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B20121A0275;
        Mon, 28 Sep 2020 07:05:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5171B1A01A4;
        Mon, 28 Sep 2020 07:05:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 934B7402B7;
        Mon, 28 Sep 2020 07:05:27 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx: Correct run_measurement check method
Date:   Mon, 28 Sep 2020 13:01:43 +0800
Message-Id: <1601269303-12167-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is incorrect to use irq_enabled flag for run_measurement check, as
irq_enabled is NOT always equal to thermal mode, when temperature is
higher than passive point, an alarm irq will be pending, and irq_enabled
flag will be set to false while thermal mode is still enabled, then the
following temperature read will power down thermal sensor, and next time
irq_enabled flag will set to true when temperature drop to below than
passive point, next temperature read will fail due to thermal sensor is NOT
power up at all, the error log is as below:

  root@imx6qdlsolo:~# cat /sys/class/thermal/thermal_zone0/temp
  cat: /sys/class/thermal/thermal_zone0/temp: Resource temporarily unavailable

So, it should read the thermal sensor's power down bit to decide whether
to run measurement.

Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide whether to run a measurement")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 2c7473d..9f00182 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -255,7 +255,8 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	bool wait, run_measurement;
 	u32 val;
 
-	run_measurement = !data->irq_enabled;
+	regmap_read(map, soc_data->sensor_ctrl, &val);
+	run_measurement = val & soc_data->power_down_mask;
 	if (!run_measurement) {
 		/* Check if a measurement is currently in progress */
 		regmap_read(map, soc_data->temp_data, &val);
-- 
2.7.4

