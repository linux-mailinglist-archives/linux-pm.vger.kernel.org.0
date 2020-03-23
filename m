Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D310418F6D1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 15:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCWO0Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 10:26:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49278 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgCWO0Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Mar 2020 10:26:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BA6D3201262;
        Mon, 23 Mar 2020 15:26:23 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C05F200ED6;
        Mon, 23 Mar 2020 15:26:18 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CCFB3402AF;
        Mon, 23 Mar 2020 22:26:10 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx8mm: Fix build warning of incorrect argument type
Date:   Mon, 23 Mar 2020 22:19:16 +0800
Message-Id: <1584973156-25734-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix below sparse warning:

drivers/thermal/imx8mm_thermal.c:82:36: sparse: sparse: incorrect type in argument 2 (different address spaces), expected unsigned long const volatile *addr
drivers/thermal/imx8mm_thermal.c:82:36: sparse: expected unsigned long const volatile *addr

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx8mm_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index c32308b..0d60f8d 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -75,15 +75,14 @@ static int imx8mp_tmu_get_temp(void *data, int *temp)
 {
 	struct tmu_sensor *sensor = data;
 	struct imx8mm_tmu *tmu = sensor->priv;
+	unsigned long val;
 	bool ready;
-	u32 val;
 
-	ready = test_bit(probe_status_offset(sensor->hw_id),
-			 tmu->base + TRITSR);
+	val = readl_relaxed(tmu->base + TRITSR);
+	ready = test_bit(probe_status_offset(sensor->hw_id), &val);
 	if (!ready)
 		return -EAGAIN;
 
-	val = readl_relaxed(tmu->base + TRITSR);
 	val = sensor->hw_id ? FIELD_GET(TRITSR_TEMP1_VAL_MASK, val) :
 	      FIELD_GET(TRITSR_TEMP0_VAL_MASK, val);
 	if (val & SIGN_BIT) /* negative */
-- 
2.7.4

