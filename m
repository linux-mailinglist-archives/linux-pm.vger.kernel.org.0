Return-Path: <linux-pm+bounces-9040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C5905F02
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 01:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85C31C212BF
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 23:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932A412D1FE;
	Wed, 12 Jun 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MJIYB5/Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EAC5464A;
	Wed, 12 Jun 2024 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234274; cv=none; b=S1Qs6bQh3L4PRiaATGktBHGIJmLM+R6qfZ50UeM2KwcsNspOf/+ux8z0+LmiBvkpmflk3P6Fo1GJKNiq/3GC0dgLZsIADqTrB6yQ2aurPHwCNJaOxLPr18DDkdhoo7we3NjgTnOMh95rEp/QLu91kE6sFesSFQNmRvWBqeVl+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234274; c=relaxed/simple;
	bh=dAnHTtpolYPt15rFjwpq32w6shRczb9Te9yZLBal7IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DgPyV54X6VjwEPDelq4gIX9q8YRaXDlSMbhMLO/fzu658g56u+b9Z6CRrmSujzfuiSiyJb6qWh4bZjg8BKyPy0iUpgZt+lKtyy02vn3dlMC4b4WoMQRK0MnooIsBwZT5HF6wYQgiVOKGZ+yfuY0n5kux/C2onzAM6AALIq+Gamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MJIYB5/Y; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHeBt084781;
	Wed, 12 Jun 2024 18:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718234260;
	bh=QygYFQ2htYur7OEp+8UrMIwDjqm0ddORmkB/GzNB+F8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=MJIYB5/YfGBvmjCCR1gqUgghEVISFD89/B4Vhrl1duMbRcqsPnhrjXkbtw5w6rlgL
	 0eoyyTU6bUuPNzhdnF8N6cvXPIdQizB4eWBmmfz6cBJwG4X9nCOagczH4SxdKwW87+
	 N3i61KvhmPYTVcbAgANB3QFK3nYp3SuXfbPUYmas=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CNHeHZ008018
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 18:17:40 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 18:17:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 18:17:40 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHeYh023162;
	Wed, 12 Jun 2024 18:17:40 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 12 Jun 2024 18:17:35 -0500
Subject: [PATCH v2 2/5] cpufreq: ti: update OPP table for AM62Px SoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-ti-opp-updates-v2-2-422b6747a254@ti.com>
References: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
In-Reply-To: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: Vibhore Vardhan <vibhore@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=bb@ti.com;
 h=from:subject:message-id; bh=dAnHTtpolYPt15rFjwpq32w6shRczb9Te9yZLBal7IQ=;
 b=owNCWmg5MUFZJlNZiiqEegAAZ3///vZ9A7dve3efv6buvTQ+V/3q5z82/u7ffnub7Xt2/vcwA
 RrEIeo0ZAAAHqDRo0DIPUAAANBoHqGgD0TQ0DTQABoGgAMjI9QyA9R6mntRHtUMoDRoAPU0eoGT
 QAGQAGjQHpqAAADIB6hp5NQDGkYj1AbUAAHqDTT1GRoZB0HqaAMRoDQaYjTCDQGgBoGEDCYmmE0
 aAAMgxANMAgwjQMmmjJggDAAE0tgyWXnATUuEG1AMQDXirVZczE4EBCXIIlH8T7t1KXbraRY8jp
 tQPCjXrWIdGRzKBmx8I04yWSO3BVBadwZLuPvvr1aEdFPdLPiWVbZKlFX+uFXHVe6pFCmxb1fjG
 IFyxOI6oxWSl/I0ZSSFGMXmE+DVC0ReLVvNkkT3xa840DCKghQfdiaSUPfaUwsewCgsw4LrFfZT
 M2woT+a+scFmtsas08yruUMeK3FpZCJtvhpjvImEGBEbnd4A4u6/2kLLP3IFMqx7dHxGJRgel39
 A22hwIcivHCdD0TqoGnrJvQDjViva9x7VR+ZBqC8PwMAoYN0ikBLQhchKKVe4Po8kJexU3wOYqw
 ywGvOXLthFreiLEMYHxub7IdXyjkHf2EaEjIn0P6ndjACmm4OYPmhu4ZRy6PAJSbxRoVYUM1/i7
 kinChIRRVCPQA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

More speed grades for the AM62Px SoC family have been defined which
unfortunately no longer align with the AM62x table. So create a new
table with these new speed grades defined for the AM62Px

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index a80698f3cfe65..6c84562de5c6b 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -69,6 +69,13 @@ enum {
 #define AM62A7_SUPPORT_R_MPU_OPP		BIT(1)
 #define AM62A7_SUPPORT_V_MPU_OPP		BIT(2)
 
+#define AM62P5_EFUSE_O_MPU_OPP			15
+#define AM62P5_EFUSE_S_MPU_OPP			19
+#define AM62P5_EFUSE_U_MPU_OPP			21
+
+#define AM62P5_SUPPORT_O_MPU_OPP		BIT(0)
+#define AM62P5_SUPPORT_U_MPU_OPP		BIT(2)
+
 #define VERSION_COUNT				2
 
 struct ti_cpufreq_data;
@@ -134,6 +141,23 @@ static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	return BIT(efuse);
 }
 
+static unsigned long am62p5_efuse_xlate(struct ti_cpufreq_data *opp_data,
+					unsigned long efuse)
+{
+	unsigned long calc_efuse = AM62P5_SUPPORT_O_MPU_OPP;
+
+	switch (efuse) {
+	case AM62P5_EFUSE_U_MPU_OPP:
+	case AM62P5_EFUSE_S_MPU_OPP:
+		calc_efuse |= AM62P5_SUPPORT_U_MPU_OPP;
+		fallthrough;
+	case AM62P5_EFUSE_O_MPU_OPP:
+		calc_efuse |= AM62P5_SUPPORT_O_MPU_OPP;
+	}
+
+	return calc_efuse;
+}
+
 static unsigned long am62a7_efuse_xlate(struct ti_cpufreq_data *opp_data,
 					unsigned long efuse)
 {
@@ -291,6 +315,15 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
 	.multi_regulator = false,
 };
 
+static struct ti_cpufreq_soc_data am62p5_soc_data = {
+	.efuse_xlate = am62p5_efuse_xlate,
+	.efuse_offset = 0x0,
+	.efuse_mask = 0x07c0,
+	.efuse_shift = 0x6,
+	.rev_offset = 0x0014,
+	.multi_regulator = false,
+};
+
 /**
  * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
  * @opp_data: pointer to ti_cpufreq_data context
@@ -395,7 +428,7 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
 	{ .compatible = "ti,am625", .data = &am625_soc_data, },
 	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
-	{ .compatible = "ti,am62p5", .data = &am625_soc_data, },
+	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
 	{ .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },

-- 
2.45.2


