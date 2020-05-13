Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF9A1D053F
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 05:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgEMDHl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 23:07:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45484 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEMDHl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 23:07:41 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D93F9201201;
        Wed, 13 May 2020 05:07:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 42BE5201200;
        Wed, 13 May 2020 05:07:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C9014402B4;
        Wed, 13 May 2020 11:07:26 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx8mm: Add get_trend ops
Date:   Wed, 13 May 2020 10:58:08 +0800
Message-Id: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add get_trend ops for i.MX8MM thermal to apply fast cooling
mechanism, when temperature exceeds passive trip point, the
highest cooling action will be applied, and when temperature
drops to lower than the margin below passive trip point, the
lowest cooling action will be applied.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx8mm_thermal.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e6061e2..8f6a0b8 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -38,6 +38,8 @@
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
+#define IMX_TEMP_COOL_MARGIN	10000
+
 struct thermal_soc_data {
 	u32 num_sensors;
 	u32 version;
@@ -103,8 +105,33 @@ static int tmu_get_temp(void *data, int *temp)
 	return tmu->socdata->get_temp(data, temp);
 }
 
+static int tmu_get_trend(void *p, int trip, enum thermal_trend *trend)
+{
+	struct tmu_sensor *sensor = p;
+	int trip_temp, temp, ret;
+
+	if (!sensor->tzd)
+		return -EINVAL;
+
+	ret = sensor->tzd->ops->get_trip_temp(sensor->tzd, trip, &trip_temp);
+	if (ret)
+		return ret;
+
+	temp = READ_ONCE(sensor->tzd->temperature);
+
+	if (temp > trip_temp)
+		*trend = THERMAL_TREND_RAISE_FULL;
+	else if (temp < (trip_temp - IMX_TEMP_COOL_MARGIN))
+		*trend = THERMAL_TREND_DROP_FULL;
+	else
+		*trend = THERMAL_TREND_STABLE;
+
+	return 0;
+}
+
 static struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
+	.get_trend = tmu_get_trend,
 };
 
 static void imx8mm_tmu_enable(struct imx8mm_tmu *tmu, bool enable)
-- 
2.7.4

