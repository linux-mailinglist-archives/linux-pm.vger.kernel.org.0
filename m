Return-Path: <linux-pm+bounces-9771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE8912B89
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632BF28AEED
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F51607BB;
	Fri, 21 Jun 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vBba+t2S"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E215FA96;
	Fri, 21 Jun 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987996; cv=none; b=fxDlbFj/P33OoMTI9/5sYH6KrsKjpUDTKykOerIHfSrJFXxTYnThAsvRKU0g3tLAA3XGAt2HLa6Jq/aqjz4pT+HC17C3K4C+Ib05b1lA6veNIzGw9U8KUrMgQcp++KhOUO9YbdoocCRbPIe1ty+WXk34dl/l1kyZ6WULrEnKM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987996; c=relaxed/simple;
	bh=OnjgNJDFxiPKZgZGyPgGQPGW1SV4Zx/0dKqTvtZJ1N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NzQdGEc4/px23lVuTGeoN4AmTBGILRfGysJOL7hGPUEPUBeFPhq0JNXThEbOlc+7oVXK6KmOiZ5Dptz+Zn0Qa4BehI68ASkIm8wXj727pDFRxJtWrMzaolvLLLS4Lexk55jSXu4YmEYOy9WmfW7W6yD+JvlZjMhc47QY5FhjIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vBba+t2S; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdkGL051113;
	Fri, 21 Jun 2024 11:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718987986;
	bh=CdtJfuvLrKhatXcKZWW64Ah4iW+aNtZqKKEFcmNnBEA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=vBba+t2SE5HlJWPBqDRvfFF1kmGXdxdR/WXvW5q9uCMUerkyyCOs/e68HxIQ6Dh2y
	 va+Y0EIgtRrREXAxL4gCB5NUSJ4APg8nsqh70R5nMCukyZ96kILNsVcO0TaOHvH6r+
	 ldRvDDvtgmwmjA7AhWemgA0ODv2ag4br4JJ31TwI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LGdkil085569
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 11:39:46 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 11:39:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 11:39:46 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdkJV057980;
	Fri, 21 Jun 2024 11:39:46 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 21 Jun 2024 11:39:38 -0500
Subject: [PATCH v3 2/5] cpufreq: ti: update OPP table for AM62Px SoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240621-ti-opp-updates-v3-2-d857be6dac8b@ti.com>
References: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
In-Reply-To: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
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
        <linux-arm-kernel@lists.infradead.org>, Bryan Brattlof <bb@ti.com>,
        Dhruva
 Gole <d-gole@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; i=bb@ti.com;
 h=from:subject:message-id; bh=OnjgNJDFxiPKZgZGyPgGQPGW1SV4Zx/0dKqTvtZJ1N0=;
 b=owNCWmg5MUFZJlNZoUljNAAAaf////7ffrt3/n7+9tJvXzSOr9t39b5//cs3fL/7yfbZ/++wA
 Rs2gxQAA0AyPUDQAAMgaAZABoABoAAGQDQ0B6gA2oNMQAGjQPU009EbTJqIAaaDQDQyZAaAAAxq
 ZNND1AGgGTTQGQZDCG1D0IDQ0aBkMgaA0eoDQGgBgyg000aDEaADTJiaNA00MhoAA0wgGQDJhBo
 AyAA0MTQAaBpo0GajRoyZMgAQJzh5Sv10QZIFFR1dBizrHgGlWSJ/JQGj0FiiZG1OC04yJAGFO5
 4yg7PVk6cFz5DoGuqyi2ep/UtqoAhw/jpLtQWuDNVcsPHlzzGJYLKzD2QhAhSXem8b3qFyQloir
 MFGBZAPeo8CZvshdRcwnPC/zt88nwCYA+rFCIEyjDRoPuDXEsJuyRrOM2JZc3rxpOKWGSlH0JaN
 vwtTfUG0kCE2FwG9QmOLDh9UpJHx85Hu6S4ZOn4SAvCm8aIrmAqnxws+ncwD5ELNlgOyXLVRn8z
 y5LDvkg2ZHAH/aPpgGOI9uP2Wsr0E7dvIFCtVYawi9dFf7JDQ0y5jzXOtRsPNctEFvLEU9puBK9
 EWNAM/uSaFDMdoMJPoPoG0DTMNq+QRQ0cwLvp4abDBMnV6dKUyQx6v7sByGJhi9kqSQisJkICiw
 IVIUZ/xdyRThQkKFJYzQA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

More speed grades for the AM62Px SoC family have been defined which
unfortunately no longer align with the AM62x table. So create a new
table with these new speed grades defined for the AM62Px

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 51cac31f776f5..49ee25cc4a105 100644
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
+	unsigned long calculated_efuse = AM62P5_SUPPORT_O_MPU_OPP;
+
+	switch (efuse) {
+	case AM62P5_EFUSE_U_MPU_OPP:
+	case AM62P5_EFUSE_S_MPU_OPP:
+		calculated_efuse |= AM62P5_SUPPORT_U_MPU_OPP;
+		fallthrough;
+	case AM62P5_EFUSE_O_MPU_OPP:
+		calculated_efuse |= AM62P5_SUPPORT_O_MPU_OPP;
+	}
+
+	return calculated_efuse;
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


