Return-Path: <linux-pm+bounces-9029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F8B905909
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B261C20456
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9501822F2;
	Wed, 12 Jun 2024 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="St8kYnn2"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F73181CFC;
	Wed, 12 Jun 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210546; cv=none; b=CSwXBK/t2rfIvYEpXi2oMPQxaM6eKxmdZKkp9Er4vCrVHm1eKBKo/glf4/Ek+9jLaoxHgP9kIP31PdM7DISXzQ5QRSc5lSzodi5xhS9bn0NSd7v3fK94IE0hio1vHpB+HnpnR2R47PMBcqjrISvBWu3N4sqmaow3av0kzZeSvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210546; c=relaxed/simple;
	bh=dAnHTtpolYPt15rFjwpq32w6shRczb9Te9yZLBal7IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bVO7Wypxf8rnNAIU+WHOCx1poHtFKbqKAk6ZG7gzajzvRXyLf/SawDRvbH6nRwUelc1blTIpKOZR/AXWsLZMHh/78CYj6JX4ULm50UbUcGZ7rekFFM9bjiMmmBOXMkbzXMTjpz60hmZhdR/hMaSuSpYI+d/2MKp3+20718EUjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=St8kYnn2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgBx3039618;
	Wed, 12 Jun 2024 11:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718210531;
	bh=QygYFQ2htYur7OEp+8UrMIwDjqm0ddORmkB/GzNB+F8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=St8kYnn2BEkWYFKImjpfnppB5Gyt+ruCei7b120oD42MuWmZtRueQOSJ3GwTXYOUC
	 scPncqh+qK8pmcwf3eqEZCkoWPX8XbRhocc4hj5FbvFoBIyCR3ONTQdtBZl8h0v3et
	 +Gw4uPm6ovh0wChUKUznE9RYSD6ZWpmfncTRZRWw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CGgBKH079730
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 11:42:11 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 11:42:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 11:42:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CGgAgA099380;
	Wed, 12 Jun 2024 11:42:10 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 12 Jun 2024 11:41:51 -0500
Subject: [PATCH 2/5] cpufreq: ti: update OPP table for AM62Px SoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-ti-opp-updates-v1-2-3551c31d9872@ti.com>
References: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
In-Reply-To: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
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
 b=owNCWmg5MUFZJlNZeSzJwwAAZn///v9P7m8yftfKqHn8tft/b3O6zo/5r2vbdqy+hftz2/ywA
 RmwHagANDIGQaaNA0eoyZAGmgaAaepk0DQGmmhoMmmgANNBkaBoep6JjUDEzU3qaiANNDAQBiYQ
 DQ0aBgTRgTTQA0GQNGjAgeo0GEMgYgaaYI0ZMBGTIHQekGmTQ9TTIaA0PUGjJiDE0NNA0ABk0NB
 hGE0YCYjRkZBiaGgYTTIDIwgAHoIOB3G2AL0zQpRhQRjw8TK14QoGZnG9FbDhgbr8g152zSoTtH
 vxwzsnJInHL+swCQJcMekxi8RMIEwf4hVhML5onOA4iN35+1v0VodNutIc/mQJNgE9z2bfW2vHF
 zHwBng6+JZMlpfgmj3KCCdtc7HVJlpwnMVTaY/hKBDS4aS5S8DIUoQP5vHhmNE6UIIY8T04MhXu
 UrAy26Pc0cbwnUy/WbDNj05Gdyu2Z9xOsj+0roHQvWjUKlviCbsfo9E9uSbxXYwuMnwpMu2fcI6
 DfDHPFQnjlT6Au3jAWRaPRLNk+AlFha35V5q7M3nDMsX74pqhoqyAQ0t0YxiA1ey9SOOGUXytci
 E/oISlImCMpoZYRIVz+z1iJKOWgCpyqyUIfvyCVcEF87aLIw0o1E5JsMC7nPVoAIuaGSFjkoDsJ
 Vwf4u5IpwoSDyWZOGA=
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


