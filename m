Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47656173A31
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgB1Opg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 09:45:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49806 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgB1Opg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 09:45:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01SEjXZM059045;
        Fri, 28 Feb 2020 08:45:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582901133;
        bh=LClidEhMakJ9azCSCmF19f1My8yyf6YsRzolNJCMSE8=;
        h=From:To:CC:Subject:Date;
        b=CqcNDJAzE/7vA52SGId7T2zcxynj+YOTqoZngDOnG1mzcJILq0SpGD4BnIkS175sx
         LUoPS8Itw0s0Nktf8p766l1eIT5W1zgGFRvIKGD9YrB0BHD82MjaWNAYtUqGUhwRPN
         Y1ft8XUa2HYyex3PFUcE6FoFRMIidPzcQ5zr0H24=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01SEjXow063219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 08:45:33 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 08:45:31 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 08:45:31 -0600
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01SEjTi4079785;
        Fri, 28 Feb 2020 08:45:30 -0600
From:   Tero Kristo <t-kristo@ti.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] cpufreq: ti-cpufreq: Add support for OPP_PLUS
Date:   Fri, 28 Feb 2020 16:45:29 +0200
Message-ID: <20200228144529.14548-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

DRA762 SoC introduces OPP_PLUS which runs at 1.8GHz. Add
support for this OPP in ti-cpufreq driver.

Acked-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 557cb513bf7f..d62b6b21325a 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -25,11 +25,14 @@
 
 #define DRA7_EFUSE_HAS_OD_MPU_OPP		11
 #define DRA7_EFUSE_HAS_HIGH_MPU_OPP		15
+#define DRA76_EFUSE_HAS_PLUS_MPU_OPP		18
 #define DRA7_EFUSE_HAS_ALL_MPU_OPP		23
+#define DRA76_EFUSE_HAS_ALL_MPU_OPP		24
 
 #define DRA7_EFUSE_NOM_MPU_OPP			BIT(0)
 #define DRA7_EFUSE_OD_MPU_OPP			BIT(1)
 #define DRA7_EFUSE_HIGH_MPU_OPP			BIT(2)
+#define DRA76_EFUSE_PLUS_MPU_OPP		BIT(3)
 
 #define OMAP3_CONTROL_DEVICE_STATUS		0x4800244C
 #define OMAP3_CONTROL_IDCODE			0x4830A204
@@ -80,6 +83,9 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	 */
 
 	switch (efuse) {
+	case DRA76_EFUSE_HAS_PLUS_MPU_OPP:
+	case DRA76_EFUSE_HAS_ALL_MPU_OPP:
+		calculated_efuse |= DRA76_EFUSE_PLUS_MPU_OPP;
 	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
 	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
 		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
