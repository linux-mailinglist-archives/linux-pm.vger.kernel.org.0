Return-Path: <linux-pm+bounces-14793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC6A986EF0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E108287906
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB211AC895;
	Thu, 26 Sep 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dpARYpw5"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B831A727A;
	Thu, 26 Sep 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339772; cv=none; b=lBaWVQPZ05MDMlVkarla6GGO2+EqLpDUXUIbRPWDBDd8/tG6b2cvYQ7FMG5XZFqNIzZHihK+yd4VBSXaiXIpa55P2sBhfw9lFnR1p3H7O2r6Uso8oh4X0nShgQVpnxMRnlL12gT5qNJ6X2dhbVPvH7Mf/Zh4EGvf9BHoqaDA1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339772; c=relaxed/simple;
	bh=GJlBJ2nije3417X3Duk+yPak7aNIl/IkHg/i7Ff3tgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=P//t8889myntImuB2iuCSI545jtN/9AFnxX3lD/fnoJ647fxF5l43n5m0mQKjhAMUm7B2bLfuHnU2BIrZyUTYfKeD0hPZwMCiDyi25POoPN9t/i9nxtpKUsg//8V+rKwcxQNxBPMpPathi9zBsM+76RTBABniePCtUl2IY2m7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dpARYpw5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8a0Wp042677;
	Thu, 26 Sep 2024 03:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727339760;
	bh=/NklGAACFNInFGXKnjf+d7lTvw/WjOe5LVumCjbxEJg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=dpARYpw56iNobO0+/RjIDcfeGv8VLqRjLssXsNpq2pGs52IWDiMmhgn+ycsi1lD9p
	 eeECBMs7XUYpVu37T3RSsED/m4cDu+qYW1UxwX9TBs74kTq2coPGVDa/A328TTTCbK
	 Bd0aR8Xytda1X3gP1CJHuTU7LA9tpIyj4v6MN4nc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48Q8a0UT053894
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 03:36:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 03:35:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 03:35:59 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZPKA064456;
	Thu, 26 Sep 2024 03:35:55 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Thu, 26 Sep 2024 14:04:57 +0530
Subject: [PATCH v7 6/6] cpufreq: ti-cpufreq: Update efuse/rev offsets in
 AM62 family
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240926-ti-cpufreq-fixes-v5-v7-6-3c94c398fe8f@ti.com>
References: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
In-Reply-To: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
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
        Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Markus Schneider-Pargmann
	<msp@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727339725; l=2979;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=GJlBJ2nije3417X3Duk+yPak7aNIl/IkHg/i7Ff3tgs=;
 b=SI6s16xvei2mPWIU04o5SUXvMFiKHAW3liKgNmSW0XtdgkRJ8RkPugTxuHbgmbDa5HTg7UGO5
 JkLRdxsqcotCO9U0GLjHWzZ1Ds9v9RApTK770ZYGM9JHmcpG5xwsebk
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
 drivers/cpufreq/ti-cpufreq.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ba621ce1cdda694c98867422dbb7f10c0df2afef..054eadd7a3bf98a15d765e0506dbfa7ed0706f4f 100644
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
 
@@ -349,11 +346,26 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 				u32 *efuse_value)
 {
 	struct device *dev = opp_data->cpu_dev;
+	struct device_node *np = of_find_node_by_path("/bus@f0000/bus@b00000/syscon@43000000");
 	u32 efuse;
 	int ret;
 
-	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
-			  &efuse);
+	/*
+	 * This checks for old AM625 Devicetrees where the syscon was a phandle to the
+	 * wkup_conf parent, this required a hard-coded offset to the efuse register.
+	 * This node had the compatibles "syscon", "simple-mfd".
+	 */
+	if (of_device_is_compatible(np, "simple-mfd") &&
+	    of_machine_is_compatible("ti,am625")) {
+		dev_warn(dev,
+			 "%s: An old devicetree is in use, please consider updating at some point!",
+			 __func__);
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


