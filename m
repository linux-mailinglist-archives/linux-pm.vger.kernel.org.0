Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9343608C3
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhDOMEV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhDOMEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:20 -0400
Date:   Thu, 15 Apr 2021 12:03:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8FxIGJS1PAZxaV4eli1EJQtj0pCC/8O/ev67rza+xg=;
        b=0lEeEk37nuyTmndk8vkhzxpaRdtcrgWXq4unzZjrxYz3LAsimZpvnVxQVmUdwGPaVs9SUt
        Je3G1mEtkIGHBbDt7JiohE/+LOpS/3YAaCeKAth09iLTAykhUvca6j68iMLOBrO9xm/5Dg
        Zg/6UM7upnq6PiGXLjnNXXEMOBnepZZJWhLkQncicUafDobs158f6DbdEwGEdP5iyKltUV
        JD6AeVXFBK/4cEonvCGy40TXPHNJIpMMH3kVK5zUBqr2yoHxvBlQZPRo9hYoY6YVam+HLJ
        FmSfQwHCDobDfkaMtHALSHB1iok8xu9k+m5oQv/O50MSShmijRI1Qr2SXUntZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8FxIGJS1PAZxaV4eli1EJQtj0pCC/8O/ev67rza+xg=;
        b=QRqr9DFZnmttY8hFspczMR9tDS5DYXQko6uOiI5ANOKI1coQ72Sq9mbm3YF01FN8RoblOp
        APntKJyzRPlJP8Bg==
From:   "thermal-bot for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/tsens-v0_1: Add support
 for MDM9607
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210319220802.198215-2-konrad.dybcio@somainline.org>
References: <20210319220802.198215-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Message-ID: <161848823608.29796.13297556997561625278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     949b2962c0ac60e0fb6b581a1350049e726d2d42
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//949b2962c0ac60e0fb6b581a1350049e726d2d42
Author:        Konrad Dybcio <konrad.dybcio@somainline.org>
AuthorDate:    Fri, 19 Mar 2021 23:08:02 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:43 +02:00

thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607

MDM9607 TSENS IP is very similar to the one of MSM8916, with
minor adjustments to various tuning values.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210319220802.198215-2-konrad.dybcio@somainline.org
---
 drivers/thermal/qcom/tsens-v0_1.c | 98 +++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.c      |  3 +-
 drivers/thermal/qcom/tsens.h      |  2 +-
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 4ffa2e2..f136cb3 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -190,6 +190,39 @@
 
 #define BIT_APPEND		0x3
 
+/* eeprom layout data for mdm9607 */
+#define MDM9607_BASE0_MASK	0x000000ff
+#define MDM9607_BASE1_MASK	0x000ff000
+#define MDM9607_BASE0_SHIFT	0
+#define MDM9607_BASE1_SHIFT	12
+
+#define MDM9607_S0_P1_MASK	0x00003f00
+#define MDM9607_S1_P1_MASK	0x03f00000
+#define MDM9607_S2_P1_MASK	0x0000003f
+#define MDM9607_S3_P1_MASK	0x0003f000
+#define MDM9607_S4_P1_MASK	0x0000003f
+
+#define MDM9607_S0_P2_MASK	0x000fc000
+#define MDM9607_S1_P2_MASK	0xfc000000
+#define MDM9607_S2_P2_MASK	0x00000fc0
+#define MDM9607_S3_P2_MASK	0x00fc0000
+#define MDM9607_S4_P2_MASK	0x00000fc0
+
+#define MDM9607_S0_P1_SHIFT	8
+#define MDM9607_S1_P1_SHIFT	20
+#define MDM9607_S2_P1_SHIFT	0
+#define MDM9607_S3_P1_SHIFT	12
+#define MDM9607_S4_P1_SHIFT	0
+
+#define MDM9607_S0_P2_SHIFT	14
+#define MDM9607_S1_P2_SHIFT	26
+#define MDM9607_S2_P2_SHIFT	6
+#define MDM9607_S3_P2_SHIFT	18
+#define MDM9607_S4_P2_SHIFT	6
+
+#define MDM9607_CAL_SEL_MASK	0x00700000
+#define MDM9607_CAL_SEL_SHIFT	20
+
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	int base0 = 0, base1 = 0, i;
@@ -452,7 +485,56 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
-/* v0.1: 8916, 8939, 8974 */
+static int calibrate_9607(struct tsens_priv *priv)
+{
+	int base, i;
+	u32 p1[5], p2[5];
+	int mode = 0;
+	u32 *qfprom_cdata;
+
+	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
+	if (IS_ERR(qfprom_cdata))
+		return PTR_ERR(qfprom_cdata);
+
+	mode = (qfprom_cdata[2] & MDM9607_CAL_SEL_MASK) >> MDM9607_CAL_SEL_SHIFT;
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+
+	switch (mode) {
+	case TWO_PT_CALIB:
+		base = (qfprom_cdata[2] & MDM9607_BASE1_MASK) >> MDM9607_BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & MDM9607_S0_P2_MASK) >> MDM9607_S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & MDM9607_S1_P2_MASK) >> MDM9607_S1_P2_SHIFT;
+		p2[2] = (qfprom_cdata[1] & MDM9607_S2_P2_MASK) >> MDM9607_S2_P2_SHIFT;
+		p2[3] = (qfprom_cdata[1] & MDM9607_S3_P2_MASK) >> MDM9607_S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[2] & MDM9607_S4_P2_MASK) >> MDM9607_S4_P2_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = ((base + p2[i]) << 2);
+		fallthrough;
+	case ONE_PT_CALIB2:
+		base = (qfprom_cdata[0] & MDM9607_BASE0_MASK);
+		p1[0] = (qfprom_cdata[0] & MDM9607_S0_P1_MASK) >> MDM9607_S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & MDM9607_S1_P1_MASK) >> MDM9607_S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[1] & MDM9607_S2_P1_MASK) >> MDM9607_S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & MDM9607_S3_P1_MASK) >> MDM9607_S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[2] & MDM9607_S4_P1_MASK) >> MDM9607_S4_P1_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = ((base + p1[i]) << 2);
+		break;
+	default:
+		for (i = 0; i < priv->num_sensors; i++) {
+			p1[i] = 500;
+			p2[i] = 780;
+		}
+		break;
+	}
+
+	compute_intercept_slope(priv, p1, p2, mode);
+	kfree(qfprom_cdata);
+
+	return 0;
+}
+
+/* v0.1: 8916, 8939, 8974, 9607 */
 
 static struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
@@ -540,3 +622,17 @@ struct tsens_plat_data data_8974 = {
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
 };
+
+static const struct tsens_ops ops_9607 = {
+	.init		= init_common,
+	.calibrate	= calibrate_9607,
+	.get_temp	= get_temp_common,
+};
+
+struct tsens_plat_data data_9607 = {
+	.num_sensors	= 5,
+	.ops		= &ops_9607,
+	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4 },
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 139e580..4c7ebd1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -971,6 +971,9 @@ static const struct of_device_id tsens_table[] = {
 		.compatible = "qcom,ipq8064-tsens",
 		.data = &data_8960,
 	}, {
+		.compatible = "qcom,mdm9607-tsens",
+		.data = &data_9607,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 8e6c1fd..1471a2c 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -587,7 +587,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8939, data_8974;
+extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976;
