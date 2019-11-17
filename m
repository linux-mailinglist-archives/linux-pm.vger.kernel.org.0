Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D593FF9CE
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2019 14:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfKQNH3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Nov 2019 08:07:29 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44186 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfKQNH3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Nov 2019 08:07:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 53DB61A0215;
        Sun, 17 Nov 2019 14:07:27 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 743B61A0016;
        Sun, 17 Nov 2019 14:07:23 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6030D4029F;
        Sun, 17 Nov 2019 21:07:18 +0800 (SGT)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/1] firmware: imx: scu-pd: do not power off console domain
Date:   Sun, 17 Nov 2019 21:05:24 +0800
Message-Id: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Do not power off console domain in runtime pm.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index b556612207e5..770e3681bbbf 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -85,6 +85,8 @@ struct imx_sc_pd_soc {
 	u8 num_ranges;
 };
 
+int imx_con_rsrc;
+
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
 	{ "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
@@ -173,6 +175,23 @@ to_imx_sc_pd(struct generic_pm_domain *genpd)
 	return container_of(genpd, struct imx_sc_pm_domain, pd);
 }
 
+static void imx_sc_pd_get_console_rsrc(void)
+{
+	struct of_phandle_args specs;
+	int ret;
+
+	if (!of_stdout)
+		return;
+
+	ret = of_parse_phandle_with_args(of_stdout, "power-domains",
+					 "#power-domain-cells",
+					 0, &specs);
+	if (ret)
+		return;
+
+	imx_con_rsrc = specs.args[0];
+}
+
 static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct imx_sc_msg_req_set_resource_power_mode msg;
@@ -233,6 +252,7 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 		      const struct imx_sc_pd_range *pd_ranges)
 {
 	struct imx_sc_pm_domain *sc_pd;
+	bool is_off = true;
 	int ret;
 
 	sc_pd = devm_kzalloc(dev, sizeof(*sc_pd), GFP_KERNEL);
@@ -251,6 +271,10 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 			 "%s", pd_ranges->name);
 
 	sc_pd->pd.name = sc_pd->name;
+	if (imx_con_rsrc == sc_pd->rsrc) {
+		sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
+		is_off = false;
+	}
 
 	if (sc_pd->rsrc >= IMX_SC_R_LAST) {
 		dev_warn(dev, "invalid pd %s rsrc id %d found",
@@ -260,7 +284,7 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 		return NULL;
 	}
 
-	ret = pm_genpd_init(&sc_pd->pd, NULL, true);
+	ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
 	if (ret) {
 		dev_warn(dev, "failed to init pd %s rsrc id %d",
 			 sc_pd->name, sc_pd->rsrc);
@@ -326,6 +350,8 @@ static int imx_sc_pd_probe(struct platform_device *pdev)
 	if (!pd_soc)
 		return -ENODEV;
 
+	imx_sc_pd_get_console_rsrc();
+
 	return imx_scu_init_pm_domains(&pdev->dev, pd_soc);
 }
 
-- 
2.23.0

