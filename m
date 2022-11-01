Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE96615010
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 18:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKARKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Nov 2022 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKARKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2022 13:10:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02E713E28;
        Tue,  1 Nov 2022 10:10:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1HAMEQ071899;
        Tue, 1 Nov 2022 12:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667322622;
        bh=GXCppyW2/y6Ug4zOwYS4WqyixqE98vJtwT8fpyLJ19o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yIWCjnAE2SuXxzf21CO2N+y2pX/c0kBldKOEFbBpnxaHTQByVO+WISOGy1euamHEV
         P3uhBwqo/4sN+LR9pU8EkVk4xbwQinQfmsJVPO+CUp3AZByJCC1dD3ZBTV7yNFHvYN
         noRkbx5HIxaoyX6Jd4x5hVQChkdk13ZV5mkI9TT8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1HAMRF087421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 12:10:22 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 12:10:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 12:10:22 -0500
Received: from maitri.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1HAMwB106008;
        Tue, 1 Nov 2022 12:10:22 -0500
From:   Vibhore Vardhan <vibhore@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [1/5] cpufreq: ti-cpufreq: Add support for AM625
Date:   Tue, 1 Nov 2022 12:10:18 -0500
Message-ID: <20221101171022.133322-2-vibhore@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101171022.133322-1-vibhore@ti.com>
References: <20221101171022.133322-1-vibhore@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add support for TI K3 AM625 SoC to read speed and revision values from
hardware and pass to OPP layer.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index df85a77d476b..48aa8d734447 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -39,6 +39,14 @@
 #define OMAP34xx_ProdID_SKUID			0x4830A20C
 #define OMAP3_SYSCON_BASE	(0x48000000 + 0x2000 + 0x270)
 
+#define AM625_EFUSE_K_MPU_OPP			11
+#define AM625_EFUSE_S_MPU_OPP			19
+#define AM625_EFUSE_T_MPU_OPP			20
+
+#define AM625_SUPPORT_K_MPU_OPP			BIT(0)
+#define AM625_SUPPORT_S_MPU_OPP			BIT(1)
+#define AM625_SUPPORT_T_MPU_OPP			BIT(2)
+
 #define VERSION_COUNT				2
 
 struct ti_cpufreq_data;
@@ -104,6 +112,25 @@ static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	return BIT(efuse);
 }
 
+static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
+				       unsigned long efuse)
+{
+	unsigned long calculated_efuse = AM625_SUPPORT_K_MPU_OPP;
+
+	switch (efuse) {
+	case AM625_EFUSE_T_MPU_OPP:
+		calculated_efuse |= AM625_SUPPORT_T_MPU_OPP;
+		fallthrough;
+	case AM625_EFUSE_S_MPU_OPP:
+		calculated_efuse |= AM625_SUPPORT_S_MPU_OPP;
+		fallthrough;
+	case AM625_EFUSE_K_MPU_OPP:
+		calculated_efuse |= AM625_SUPPORT_K_MPU_OPP;
+	}
+
+	return calculated_efuse;
+}
+
 static struct ti_cpufreq_soc_data am3x_soc_data = {
 	.efuse_xlate = amx3_efuse_xlate,
 	.efuse_fallback = AM33XX_800M_ARM_MPU_MAX_FREQ,
@@ -198,6 +225,14 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
 	.multi_regulator = false,
 };
 
+static struct ti_cpufreq_soc_data am625_soc_data = {
+	.efuse_xlate = am625_efuse_xlate,
+	.efuse_offset = 0x0018,
+	.efuse_mask = 0x07c0,
+	.efuse_shift = 0x6,
+	.rev_offset = 0x0014,
+	.multi_regulator = false,
+};
 
 /**
  * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
@@ -301,6 +336,7 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
 	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
 	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
+	{ .compatible = "ti,am625", .data = &am625_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
 	{ .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },
-- 
2.34.1

