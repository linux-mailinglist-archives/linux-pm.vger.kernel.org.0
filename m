Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD23E158A51
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 08:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgBKHY4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 02:24:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45366 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBKHY4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 02:24:56 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01B7OntF041310;
        Tue, 11 Feb 2020 01:24:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581405889;
        bh=t1zdbUy3wKpxVvWbk6TLsJ4+AsPZpXT7Lus31I/HQg8=;
        h=From:To:CC:Subject:Date;
        b=FQMHv87RWk0WDhxvUR0HWabGYDugs4YTBqqd0rv4njnv3N/mlv0V7EUy6abckCTbv
         cycWkmrz/sA3lddxTOcpy4kKXpCaCSZSGVzukceGM05dKpryyB7RqWdBTlport/qp8
         tb7NOEGiRJhVv/hf6xy95mbn0o5u7CPQ95BVia/k=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01B7OnI7050682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 01:24:49 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 11
 Feb 2020 01:24:48 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 11 Feb 2020 01:24:48 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01B7OjYI129498;
        Tue, 11 Feb 2020 01:24:46 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC:     Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] cpufreq: ti-cpufreq: Add support for OPP_PLUS
Date:   Tue, 11 Feb 2020 12:53:55 +0530
Message-ID: <20200211072355.5476-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DRA762 SoC introduces OPP_PLUS which runs at 1.8GHz. Add
support for this OPP in ti-cpufreq driver.

Acked-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 557cb513bf7f..ab0de27539ad 100644
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
@@ -80,6 +83,10 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	 */
 
 	switch (efuse) {
+	case DRA76_EFUSE_HAS_PLUS_MPU_OPP:
+	case DRA76_EFUSE_HAS_ALL_MPU_OPP:
+		calculated_efuse |= DRA76_EFUSE_PLUS_MPU_OPP;
+		/* Fall through */
 	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
 	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
 		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
-- 
2.23.0

