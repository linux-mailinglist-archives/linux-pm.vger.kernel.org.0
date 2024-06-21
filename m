Return-Path: <linux-pm+bounces-9770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F86912B85
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551471F27021
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B925160790;
	Fri, 21 Jun 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xXqMOJbQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37EDDC4;
	Fri, 21 Jun 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987995; cv=none; b=Zsx+XN539MAPoWIzaSXqAXog5/cEcaSneawYgkJniarGPMefNLCleBHiOtl98mEUGlY91H3mrCgS9lT+AW9CCfV164dNGS35zgtf3R+OW48YgH0hDqNm5BYzNE8HQeAUHeQt/v54xqckKQWVCbbq92fSPc1t+NVHziiUXb9fk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987995; c=relaxed/simple;
	bh=aa/UAapxLYnd05XCY2z3WEmwO81o6wpHMQ8kV6F0g0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CnE8UgawjOgv7oAmTVPz/maf6rJlb58so5Aq1USfl7ACL0RH9s24hwC8izPjZ3iMVi3QeQgv6DyVLkOMGlb94opwGkqEWhuOTt9ig3WvD0wiVwIsZ2cq6XWuzWbweNcb55J+TkQBNnxmfVSQ/n+kK0PryJfsfVUW8odrGKndTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xXqMOJbQ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdkmQ051111;
	Fri, 21 Jun 2024 11:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718987986;
	bh=Nbx1zYtIRV0RSr575R1x17x1xodoPxpczYOw9GvbXdY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=xXqMOJbQJClgv/d1+xH7wJtUFANyVqkZLr4j39TBGQgDKefWjoMYblFPMobY7HLET
	 RqyDnNtoUnl4nTo9UCn5RBke4EuF3G/zNOX035twyxZW1fuySGiPif4h3o4/N1+Qb5
	 /lY05TGlQY6jpzeKB97Ife0KxsI6+I7utdT5k5jE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LGdkap085566
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 11:39:46 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 11:39:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 11:39:46 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LGdkvI080074;
	Fri, 21 Jun 2024 11:39:46 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 21 Jun 2024 11:39:37 -0500
Subject: [PATCH v3 1/5] cpufreq: ti: update OPP table for AM62Ax SoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240621-ti-opp-updates-v3-1-d857be6dac8b@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3367; i=bb@ti.com;
 h=from:subject:message-id; bh=aa/UAapxLYnd05XCY2z3WEmwO81o6wpHMQ8kV6F0g0I=;
 b=owNCWmg5MUFZJlNZ9e+uwwAAZn///n99sz/8P2+td14f/+v3Hv96++bzr+9//J25ijr2//wwA
 Rs2g7UGQGgAAAAAA0aaAAepoAAAAGgaaDQyABo0DQAADR6jIeKaeGp6oc0hiBpiZNNBkaGjI0G1
 ABpoNNDQBpk0yDQZAADTRpkyAMjQGEBkaBk00DRoY7UP1NJkYQHqD1BhBkaBoMjIDQ00ANNBkDI
 AAANAAaZADIDIGQyGmgDRgAdI+kHh3gCL0SBNmoYPlwqCePNVt8TaCPoyFFZBEUtK3iEYk07LWg
 UYbX5KF7SanEYIWJ8GMWqM3qbBHyaHcAtfJSjGSyrGNgcG2s7mO4EdezwyVAW0VrciHt+r5OM/G
 p453nwjvrnpPJuk/+sVZjj7/HhYSNOwRdJpZffjjkWmI9ACqT5w61TiIFuzpLUXuPt6qbCdCNab
 VnObohPlSpRr4q6/gDD3FYA1XylrJcr8Wdiaj8sWsEn9XscZTMX1a3FPCcAcmDEl+tnKm/zbZc3
 O49DiL3mRTgSYoM8Ugv/x1+uSTirm2Ws/VU1+yoVOQv8C/obAGRkbRnfyO/Wif3hIT+6eYfJ0Tp
 ZwpkoLQsQXDphJViuos51JbGImpYlHmA12bjPWSd8anjHsAJAzABzFCgxgnNiECU8EQLlQgClpB
 d4P+LuSKcKEh699dhg=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

As the AM62Ax SoC family matures more speed grades are being defined.
These new grades unfortunately no longer align with the AM62x SoC
family. Define a new table with new OPP speed grade limits for the
AM62Ax

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 59 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 714ed53753fa5..51cac31f776f5 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -47,6 +47,28 @@
 #define AM625_SUPPORT_S_MPU_OPP			BIT(1)
 #define AM625_SUPPORT_T_MPU_OPP			BIT(2)
 
+enum {
+	AM62A7_EFUSE_M_MPU_OPP =		13,
+	AM62A7_EFUSE_N_MPU_OPP,
+	AM62A7_EFUSE_O_MPU_OPP,
+	AM62A7_EFUSE_P_MPU_OPP,
+	AM62A7_EFUSE_Q_MPU_OPP,
+	AM62A7_EFUSE_R_MPU_OPP,
+	AM62A7_EFUSE_S_MPU_OPP,
+	/*
+	 * The V, U, and T speed grade numbering is out of order
+	 * to align with the AM625 more uniformly. I promise I know
+	 * my ABCs ;)
+	 */
+	AM62A7_EFUSE_V_MPU_OPP,
+	AM62A7_EFUSE_U_MPU_OPP,
+	AM62A7_EFUSE_T_MPU_OPP,
+};
+
+#define AM62A7_SUPPORT_N_MPU_OPP		BIT(0)
+#define AM62A7_SUPPORT_R_MPU_OPP		BIT(1)
+#define AM62A7_SUPPORT_V_MPU_OPP		BIT(2)
+
 #define VERSION_COUNT				2
 
 struct ti_cpufreq_data;
@@ -112,6 +134,32 @@ static unsigned long omap3_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	return BIT(efuse);
 }
 
+static unsigned long am62a7_efuse_xlate(struct ti_cpufreq_data *opp_data,
+					unsigned long efuse)
+{
+	unsigned long calculated_efuse = AM62A7_SUPPORT_N_MPU_OPP;
+
+	switch (efuse) {
+	case AM62A7_EFUSE_V_MPU_OPP:
+	case AM62A7_EFUSE_U_MPU_OPP:
+	case AM62A7_EFUSE_T_MPU_OPP:
+	case AM62A7_EFUSE_S_MPU_OPP:
+		calculated_efuse |= AM62A7_SUPPORT_V_MPU_OPP;
+		fallthrough;
+	case AM62A7_EFUSE_R_MPU_OPP:
+	case AM62A7_EFUSE_Q_MPU_OPP:
+	case AM62A7_EFUSE_P_MPU_OPP:
+	case AM62A7_EFUSE_O_MPU_OPP:
+		calculated_efuse |= AM62A7_SUPPORT_R_MPU_OPP;
+		fallthrough;
+	case AM62A7_EFUSE_N_MPU_OPP:
+	case AM62A7_EFUSE_M_MPU_OPP:
+		calculated_efuse |= AM62A7_SUPPORT_N_MPU_OPP;
+	}
+
+	return calculated_efuse;
+}
+
 static unsigned long am625_efuse_xlate(struct ti_cpufreq_data *opp_data,
 				       unsigned long efuse)
 {
@@ -234,6 +282,15 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
 	.multi_regulator = false,
 };
 
+static struct ti_cpufreq_soc_data am62a7_soc_data = {
+	.efuse_xlate = am62a7_efuse_xlate,
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
@@ -337,7 +394,7 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
 	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
 	{ .compatible = "ti,am625", .data = &am625_soc_data, },
-	{ .compatible = "ti,am62a7", .data = &am625_soc_data, },
+	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
 	{ .compatible = "ti,am62p5", .data = &am625_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },

-- 
2.45.2


