Return-Path: <linux-pm+bounces-9043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EF905F0C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 01:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878CAB236EA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46212E1F6;
	Wed, 12 Jun 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xD4mbgFm"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916FB12CDB1;
	Wed, 12 Jun 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234276; cv=none; b=SFHhRhxVKRBX/ficvoa8WTPHqzgejV5uWWQn2x+4N6+o9a/gtbW4dmwsL8Zz6ZJrS9f2GGBiPkE8R83QlTWgzHaNhQwLnmP2zjbLZA70cjYenKvtvCDBHIfFxIonL2i4yWVLuG47Yg4QxooOsYl6/bd18K/6z/7jVEOMLJ0CwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234276; c=relaxed/simple;
	bh=247OK9zNWZq/7rcJM9RO5Cm+DJpgqUplY1Dpd5HKDN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mnCIWNx6hAJOJjPEc/eX9HyN/8azfx73w19EEYpntT2jk5SLnuv9Iem6l4VfnLe9dPGHGsPyXIkU4oN7xuoR9EV3+JtJymTkJ8uY+jdmu/bX47UG1lgZ8r6G9AoXA5Td5kYSB4EJKI/Xvhg+f5VMl238YVF8EGYiT+ssxNJmFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xD4mbgFm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHhmv128877;
	Wed, 12 Jun 2024 18:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718234263;
	bh=wHMo0gFYCsj9ZWMq+/FqNrzcoxxWNik6KZfcZeOTevA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=xD4mbgFmjTMyZ6gYZr+rNGust3+rM059FAk5zNwWqkI+vh5EqEAjQ/IP3wN4WdxAt
	 OgoQXfo4LOmYOAJ/q7wLVWWyqwOTFwuWuotbbiYQF/Bbr4n0LireVEcr2/BAZHdmJ1
	 UpgQvYCZb8HjFRyFneQlMa2u1sXoPbOcSkZh1Y9Y=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CNHhD5017793
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 18:17:43 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 18:17:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 18:17:40 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CNHeNo023159;
	Wed, 12 Jun 2024 18:17:40 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 12 Jun 2024 18:17:34 -0500
Subject: [PATCH v2 1/5] cpufreq: ti: update OPP table for AM62Ax SoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-ti-opp-updates-v2-1-422b6747a254@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3295; i=bb@ti.com;
 h=from:subject:message-id; bh=247OK9zNWZq/7rcJM9RO5Cm+DJpgqUplY1Dpd5HKDN0=;
 b=owNCWmg5MUFZJlNZgCEKrgAAbH////9b9jH3+2X5n9VJv7wf3f7++nX+Cdsp/X//+//Go1WwA
 Rmwx2oaABoGgNGQ9QaNAaMg0AAyDQGmgBoyaDINAAAMmQDRoaaZMnqZNNP0TKaIDQDTQDTEyGjR
 kA0ZDBNNGQZDEANGRk0wAaAIAyaDQBo00AA0A0YmgYiekHqNA00ekyAaaNGmhoYEyHpDQANBkGj
 T0hoGCGgaGjQNADQBoBo0AaZNAQWJC1JBZARAfBmxaaZNzqsuGIpcfjrjMw3ovjBiwgCQA/2AFu
 /fWBZK2VTVU3quwUewJtIJ5wKL8NLZaxkKQZL0WLqDjmhAkXc+uOAK97W8PNJcH5t8qfcq8KIB6
 HH4YhigH4hwblKjQVNg6OSm6oZVZNADvh+6NYSzuhTn8RK9meu5xlXPQOXq1GDFji99upQL/XTV
 kiFuiOOjAszE2Oq8HNk2bLueOYIkksD0GHWv/YaaJ8+u87EHujxKpYVeklKH4myHSidJWhksGCm
 8kzVW1bzTtkX6xmUCIb/ODOXiTgVZlVYypvypWZoPD1jDhfErov+Qfe+7aghzuXyMxN5D8Irk4M
 UMmHBcWwFAfOjBAYlrNmudBJwEz6VpICvNUV3dDkBEUYfTpaCl9ETYVOoQuYMxkHyZQ4Vefb8wD
 /ZZhIS/xdyRThQkIAhCq4A=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

As the AM62Ax SoC family matures more speed grades are being defined.
These new grades unfortunately no longer align with the AM62x SoC
family. Define a new table with new OPP speed grade limits for the
AM62Ax

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 59 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 714ed53753fa5..a80698f3cfe65 100644
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
+	unsigned long calc_efuse = AM62A7_SUPPORT_N_MPU_OPP;
+
+	switch (efuse) {
+	case AM62A7_EFUSE_V_MPU_OPP:
+	case AM62A7_EFUSE_U_MPU_OPP:
+	case AM62A7_EFUSE_T_MPU_OPP:
+	case AM62A7_EFUSE_S_MPU_OPP:
+		calc_efuse |= AM62A7_SUPPORT_V_MPU_OPP;
+		fallthrough;
+	case AM62A7_EFUSE_R_MPU_OPP:
+	case AM62A7_EFUSE_Q_MPU_OPP:
+	case AM62A7_EFUSE_P_MPU_OPP:
+	case AM62A7_EFUSE_O_MPU_OPP:
+		calc_efuse |= AM62A7_SUPPORT_R_MPU_OPP;
+		fallthrough;
+	case AM62A7_EFUSE_N_MPU_OPP:
+	case AM62A7_EFUSE_M_MPU_OPP:
+		calc_efuse |= AM62A7_SUPPORT_N_MPU_OPP;
+	}
+
+	return calc_efuse;
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


