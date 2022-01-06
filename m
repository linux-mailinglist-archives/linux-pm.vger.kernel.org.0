Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9EE486372
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 12:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbiAFLGQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 06:06:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238265AbiAFLGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 06:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641467175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0a0x/yg3X1N24efHRlEKIGZaiGyQzHGcCtxoM1WjAaw=;
        b=M5WNW2EMXcA4wgvEhONH3oOzIvgWxh1XPcQXAmfTlAwG+7eKOEGxq0BEiASQLUK//v94xT
        0Y4r3yMZKrbvDAoSTm/WAidBNWUmKedL0qqtHy6TYI1BkMbilF+X6XO8ezQZzVndGOegRG
        LlxemA4KI9s7lps/Cjzwa7aiMOmP+Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-bcUlInanMdC4o3EXzOmRlg-1; Thu, 06 Jan 2022 06:06:12 -0500
X-MC-Unique: bcUlInanMdC4o3EXzOmRlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A861F2DA;
        Thu,  6 Jan 2022 11:06:11 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABA4D752AE;
        Thu,  6 Jan 2022 11:06:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 2/7] power: supply: axp288_fuel_gauge: Add axp288_fuel_gauge_read_initial_regs()
Date:   Thu,  6 Jan 2022 12:06:03 +0100
Message-Id: <20220106110608.66231-2-hdegoede@redhat.com>
In-Reply-To: <20220106110608.66231-1-hdegoede@redhat.com>
References: <20220106110608.66231-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Refactor probe a bit, introducing a new
axp288_fuel_gauge_read_initial_regs() helper. This replaces a whole
bunch of gotos and removes the unblock_punit_i2c_access label.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 109 ++++++++++++-----------
 1 file changed, 56 insertions(+), 53 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 1495402f440c..35f9edf3da09 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -611,6 +611,61 @@ static const struct dmi_system_id axp288_no_battery_list[] = {
 	{}
 };
 
+static int axp288_fuel_gauge_read_initial_regs(struct axp288_fg_info *info)
+{
+	unsigned int val;
+	int ret;
+
+	/*
+	 * On some devices the fuelgauge and charger parts of the axp288 are
+	 * not used, check that the fuelgauge is enabled (CC_CTRL != 0).
+	 */
+	ret = regmap_read(info->regmap, AXP20X_CC_CTRL, &val);
+	if (ret < 0)
+		return ret;
+	if (val == 0)
+		return -ENODEV;
+
+	ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & FG_DES_CAP1_VALID)) {
+		dev_err(info->dev, "axp288 not configured by firmware\n");
+		return -ENODEV;
+	}
+
+	ret = fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1);
+	if (ret < 0)
+		return ret;
+	switch ((ret & CHRG_CCCV_CV_MASK) >> CHRG_CCCV_CV_BIT_POS) {
+	case CHRG_CCCV_CV_4100MV:
+		info->max_volt = 4100;
+		break;
+	case CHRG_CCCV_CV_4150MV:
+		info->max_volt = 4150;
+		break;
+	case CHRG_CCCV_CV_4200MV:
+		info->max_volt = 4200;
+		break;
+	case CHRG_CCCV_CV_4350MV:
+		info->max_volt = 4350;
+		break;
+	}
+
+	ret = fuel_gauge_reg_readb(info, AXP20X_PWR_OP_MODE);
+	if (ret < 0)
+		return ret;
+	info->pwr_op = ret;
+
+	ret = fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG);
+	if (ret < 0)
+		return ret;
+	info->low_cap = ret;
+
+	return 0;
+}
+
 static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 {
 	int i, ret = 0;
@@ -623,7 +678,6 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		[BAT_VOLT] = "axp288-batt-volt",
 	};
 	struct device *dev = &pdev->dev;
-	unsigned int val;
 
 	if (dmi_check_system(axp288_no_battery_list))
 		return -ENODEV;
@@ -665,59 +719,8 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_free_iio_chan;
 
-	/*
-	 * On some devices the fuelgauge and charger parts of the axp288 are
-	 * not used, check that the fuelgauge is enabled (CC_CTRL != 0).
-	 */
-	ret = regmap_read(axp20x->regmap, AXP20X_CC_CTRL, &val);
-	if (ret < 0)
-		goto unblock_punit_i2c_access;
-	if (val == 0) {
-		ret = -ENODEV;
-		goto unblock_punit_i2c_access;
-	}
-
-	ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);
-	if (ret < 0)
-		goto unblock_punit_i2c_access;
-
-	if (!(ret & FG_DES_CAP1_VALID)) {
-		dev_err(&pdev->dev, "axp288 not configured by firmware\n");
-		ret = -ENODEV;
-		goto unblock_punit_i2c_access;
-	}
-
-	ret = fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1);
-	if (ret < 0)
-		goto unblock_punit_i2c_access;
-	switch ((ret & CHRG_CCCV_CV_MASK) >> CHRG_CCCV_CV_BIT_POS) {
-	case CHRG_CCCV_CV_4100MV:
-		info->max_volt = 4100;
-		break;
-	case CHRG_CCCV_CV_4150MV:
-		info->max_volt = 4150;
-		break;
-	case CHRG_CCCV_CV_4200MV:
-		info->max_volt = 4200;
-		break;
-	case CHRG_CCCV_CV_4350MV:
-		info->max_volt = 4350;
-		break;
-	}
-
-	ret = fuel_gauge_reg_readb(info, AXP20X_PWR_OP_MODE);
-	if (ret < 0)
-		goto unblock_punit_i2c_access;
-	info->pwr_op = ret;
-
-	ret = fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG);
-	if (ret < 0)
-		goto unblock_punit_i2c_access;
-	info->low_cap = ret;
-
-unblock_punit_i2c_access:
+	ret = axp288_fuel_gauge_read_initial_regs(info);
 	iosf_mbi_unblock_punit_i2c_access();
-	/* In case we arrive here by goto because of a register access error */
 	if (ret < 0)
 		goto out_free_iio_chan;
 
-- 
2.33.1

