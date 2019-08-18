Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B319152D
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 08:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfHRGvJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 02:51:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50474 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfHRGvJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Aug 2019 02:51:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BD741A02EC;
        Sun, 18 Aug 2019 08:51:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B78771A00D1;
        Sun, 18 Aug 2019 08:50:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EDF3C40318;
        Sun, 18 Aug 2019 14:50:48 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND V2 4/7] cpufreq: imx-cpufreq-dt: Add i.MX8MN support
Date:   Sun, 18 Aug 2019 02:32:22 -0400
Message-Id: <1566109945-11149-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX8MN has different speed grading definition as below, it has 4 bits
to define speed grading, add support for it.

 SPEED_GRADE[3:0]    MHz
    0000            2300
    0001            2200
    0010            2100
    0011            2000
    0100            1900
    0101            1800
    0110            1700
    0111            1600
    1000            1500
    1001            1400
    1010            1300
    1011            1200
    1100            1100
    1101            1000
    1110             900
    1111             800

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 drivers/cpufreq/imx-cpufreq-dt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 4f85f31..35db14c 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -16,6 +16,7 @@
 
 #define OCOTP_CFG3_SPEED_GRADE_SHIFT	8
 #define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)
+#define IMX8MN_OCOTP_CFG3_SPEED_GRADE_MASK	(0xf << 8)
 #define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
 #define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
 
@@ -34,7 +35,12 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	speed_grade = (cell_value & OCOTP_CFG3_SPEED_GRADE_MASK) >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
+	if (of_machine_is_compatible("fsl,imx8mn"))
+		speed_grade = (cell_value & IMX8MN_OCOTP_CFG3_SPEED_GRADE_MASK)
+			      >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
+	else
+		speed_grade = (cell_value & OCOTP_CFG3_SPEED_GRADE_MASK)
+			      >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
 	mkt_segment = (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
 
 	/*
-- 
2.7.4

