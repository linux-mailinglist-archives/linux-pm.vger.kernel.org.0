Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A14B0305
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfIKRru (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 13:47:50 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:22362 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbfIKRrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568224054;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9bpVfrWumTLzwbXZnEeTQC1ZDdnPwSUlf2P3XT0k/to=;
        b=DwUHUSditlBSE4xQfHtJJVG0EXrO7osEm1S36KcejWPrER6P1V2d7bPvS+I59qB5ao
        yVSlxXu5IoK5bK3Hn0I2yg/MlDvj/Fx5hmuvIrP7IV3KF+baApk465qoOSQhNbzPCSJm
        222X/a3fIyaLxsG5zlx6Sfe9ChSfXBSwMd3BddlT0ws/Ug84+heQl41TgEXk/kob3Oum
        E+dPZRJdm+Gk1j0tChzXDsv7xo8aWRL+B9nxXyn3cTqClNvI9gps/1aQVKqFY9CXwArm
        s6A8TlsIrPxjz8EKdbFq/E5gHezeEq0fLhzJ+EFMwH2Pv8z0EbBr9c/ISoDNk2kaaveO
        i7LQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7Nk1d2C6Y"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v8BHlH8nv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 11 Sep 2019 19:47:17 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/8] cpufreq: ti-cpufreq: omap36xx use "cpu0","vbb" if run in multi_regulator mode
Date:   Wed, 11 Sep 2019 19:47:11 +0200
Message-Id: <1c803be8060fb99b7d92e2f5cde3c0e1962fbe2b.1568224033.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1568224032.git.hns@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In preparation for using the multi_regulator capability of
this driver for handling the ABB LDO for OPP1G of the omap36xx
we have to take care that the (legacy) vdd-supply name is
cpu0-supply = <&vcc>;

To do this we add another field to the SoC description table which
optionally can specify a list of regulator names.

For omap36xx we define "cpu0-supply" and "vbb-supply".

The default remains "vdd-supply" and "vbb-supply".

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt       |  6 +++++-
 drivers/cpufreq/ti-cpufreq.c                         | 12 ++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
index 0c38e4b8fc51..1758051798fe 100644
--- a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
+++ b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
@@ -15,12 +15,16 @@ In 'cpus' nodes:
 
 In 'operating-points-v2' table:
 - compatible: Should be
-	- 'operating-points-v2-ti-cpu' for am335x, am43xx, and dra7xx/am57xx SoCs
+	- 'operating-points-v2-ti-cpu' for am335x, am43xx, and dra7xx/am57xx,
+	  omap34xx, omap36xx and am3517 SoCs
 - syscon: A phandle pointing to a syscon node representing the control module
 	  register space of the SoC.
 
 Optional properties:
 --------------------
+- "vdd-supply", "vbb-supply": to define two regulators for dra7xx
+- "cpu0-supply", "vbb-supply": to define two regulators for omap36xx
+
 For each opp entry in 'operating-points-v2' table:
 - opp-supported-hw: Two bitfields indicating:
 	1. Which revision of the SoC the OPP is supported by
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index f2f58d689320..1a3073a3093e 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -41,6 +41,7 @@
 struct ti_cpufreq_data;
 
 struct ti_cpufreq_soc_data {
+	const char * const *reg_names;
 	unsigned long (*efuse_xlate)(struct ti_cpufreq_data *opp_data,
 				     unsigned long efuse);
 	unsigned long efuse_fallback;
@@ -164,7 +165,10 @@ static struct ti_cpufreq_soc_data omap34xx_soc_data = {
  *    seems to always read as 0).
  */
 
+static const char * const omap3_reg_names[] = {"cpu0", "vbb"};
+
 static struct ti_cpufreq_soc_data omap36xx_soc_data = {
+	.reg_names = omap3_reg_names,
 	.efuse_xlate = omap3_efuse_xlate,
 	.efuse_offset = OMAP3_CONTROL_DEVICE_STATUS - OMAP3_SYSCON_BASE,
 	.efuse_shift = 9,
@@ -298,7 +302,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
-	const char * const reg_names[] = {"vdd", "vbb"};
+	const char * const default_reg_names[] = {"vdd", "vbb"};
 	int ret;
 
 	match = dev_get_platdata(&pdev->dev);
@@ -354,9 +358,13 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	opp_data->opp_table = ti_opp_table;
 
 	if (opp_data->soc_data->multi_regulator) {
+		const char * const *reg_names = default_reg_names;
+
+		if (opp_data->soc_data->reg_names)
+			reg_names = opp_data->soc_data->reg_names;
 		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
 							 reg_names,
-							 ARRAY_SIZE(reg_names));
+							 ARRAY_SIZE(default_reg_names));
 		if (IS_ERR(ti_opp_table)) {
 			dev_pm_opp_put_supported_hw(opp_data->opp_table);
 			ret =  PTR_ERR(ti_opp_table);
-- 
2.19.1

