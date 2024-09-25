Return-Path: <linux-pm+bounces-14688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8E9986223
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33CB28E040
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99216188938;
	Wed, 25 Sep 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CDvtJlod"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF666188934;
	Wed, 25 Sep 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276111; cv=none; b=cfvKHGEF6Ni6347E2VlME9x65+PB703O+I3cgSXi3EiAyg8PeCFQkaLJ+LDk2jHDox4oRMEBhqq4I/VjaoBn6xw7XHZnAwrbrp/NDtqVe0JI2wPPfaYA/XDngv3aJCfAibfkW7cyifcipqaxeWj5kc690QKXPWmijlAac25fokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276111; c=relaxed/simple;
	bh=xdbK3sX33TuJDpUjLbXTCDI0D2SFxjFhg9r0p9JHT54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SnXCM9KIJMfasgy/5X14fBtKkyulCNGOxQHeNQd9P2QUUlVpjenmzGjqgGNjWr7rXUZRi7zGbrWNJYN+3ypHvI5zimMhQOSwXVw0Ge/9n43K+ELJfBWhLItAlwppmFif+/Ph1Ld28tl2d6Vt3ugh5WPR7MGbAv9w0TyRf1eG9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CDvtJlod; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PEt4j0062997;
	Wed, 25 Sep 2024 09:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727276104;
	bh=SoE3frTgrrAbkkW+0hWzW5YqidptuOBpjGiZMGx02Ew=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=CDvtJlodjAiDT7Nhnkp/7jYUbnMMzvkawKosGqASR/HqCJ1dsLuM6sWKATA2dHRnY
	 oy2cqf05zgXHk4P8vbvNUGlgpYww7nNURikWbXxltfgF80lIvro4Bg2K5KtsQcAneo
	 MzNGEktsZCQ/ks2QZwAXroZCZ4OmRZP5G0g7ofTo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48PEt4D3092264
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Sep 2024 09:55:04 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 09:55:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 09:55:04 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PEsYCn110564;
	Wed, 25 Sep 2024 09:55:00 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Wed, 25 Sep 2024 20:24:20 +0530
Subject: [PATCH v6 6/6] cpufreq: ti-cpufreq: Update efuse/rev offsets in
 AM62 family
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ti-cpufreq-fixes-v5-v6-6-46f41a903e01@ti.com>
References: <20240925-ti-cpufreq-fixes-v5-v6-0-46f41a903e01@ti.com>
In-Reply-To: <20240925-ti-cpufreq-fixes-v5-v6-0-46f41a903e01@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727276075; l=2875;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=xdbK3sX33TuJDpUjLbXTCDI0D2SFxjFhg9r0p9JHT54=;
 b=NmSRfzqh6TLYqUwObdIiSB6IE4akueqjdw/lEC4Fha1Jn88KcxDq7HkAmiVYRgZFBN5G6+uWR
 jR+3L1vtZzvDViVVX6hXPF+4Cc+vwrPq8p8x5/NQfUR3hut2Ojara8K
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

With the Silicon revision being taken directly from socinfo, there's no
longer any need for reading any SOC register for revision from this driver.
Hence, we do not require any rev_offset for AM62 family of devices.
The efuse offset should be 0x0 for AM625 as well, as the syscon
register being used from DT refers to the efuse_offset directly.

However, to maintain the backward compatibility with old devicetree, also
add condition to handle the case where we have the wrong offset and add
the older efuse_offset value there such that we don't end up reading the
wrong register offset.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ba621ce1cdda694c98867422dbb7f10c0df2afef..8a97b95b4c44a76b12cab76ddc0f9a5b8ae73f84 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -313,10 +313,9 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
 
 static struct ti_cpufreq_soc_data am625_soc_data = {
 	.efuse_xlate = am625_efuse_xlate,
-	.efuse_offset = 0x0018,
+	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 };
 
@@ -325,7 +324,6 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
 	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 };
 
@@ -334,7 +332,6 @@ static struct ti_cpufreq_soc_data am62p5_soc_data = {
 	.efuse_offset = 0x0,
 	.efuse_mask = 0x07c0,
 	.efuse_shift = 0x6,
-	.rev_offset = 0x0014,
 	.multi_regulator = false,
 };
 
@@ -349,11 +346,25 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 				u32 *efuse_value)
 {
 	struct device *dev = opp_data->cpu_dev;
+	struct device_node *np = opp_data->opp_node;
 	u32 efuse;
 	int ret;
 
-	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
-			  &efuse);
+	/*
+	 * The following check is used as a way to check if this is an older devicetree
+	 * being used where the entire wkup_conf node was marked as "syscon",
+	 * "simple-mfd".
+	 * Since this bug only affects AM625, make sure it enters this condition
+	 * only for that SoC.
+	 */
+	if (of_device_is_compatible(np, "simple-mfd") &&
+	    of_device_is_compatible(np, "ti,am625")) {
+		ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset + 0x0018,
+				  &efuse);
+	} else {
+		ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
+				  &efuse);
+	}
 	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
 		/* not a syscon register! */
 		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +

-- 
2.34.1


