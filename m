Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096863DCBD5
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhHANbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 09:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231953AbhHANba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627824673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhhFJsN4uaWwrvVc5CNcekyun2R2NhbUY5AUOcH4/A0=;
        b=KXUg65QKHALd2jFTmgcV3UP84QfaJv0NFLmRRMBonM5eSqvJ3Nm3QGlO1LmVWITDRfWsTO
        7ZR9ct3fkTzgz/MGByirZgSFhzGLoSKYks4fdBmfQ3u87sYacK3wcoO9KEn9AIy08xVFhQ
        NFo/rub1Eg5lpPZYpMIX8m02FEOr/N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-PlruZiMaMAOOkehW-eg2nA-1; Sun, 01 Aug 2021 09:31:12 -0400
X-MC-Unique: PlruZiMaMAOOkehW-eg2nA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F7FF1006C85;
        Sun,  1 Aug 2021 13:31:10 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B369A60916;
        Sun,  1 Aug 2021 13:31:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 02/10] power: supply: axp288_fuel_gauge: Remove debugfs support
Date:   Sun,  1 Aug 2021 15:30:57 +0200
Message-Id: <20210801133105.101761-3-hdegoede@redhat.com>
In-Reply-To: <20210801133105.101761-1-hdegoede@redhat.com>
References: <20210801133105.101761-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The debugfs code is simply just dumping a bunch of registers, the same
information can also easily be gotten through the regmap debugfs
interface or through the i2cdump utility.

I've not used the debugfs interface once in all these years that I've
been working on the axp288_fuel_gauge driver, so lets just remove it.

Note this also removes the temperature-channels from the list of
IIO ADC channels used by the driver, since these were only used in the
debugfs interface.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 123 -----------------------
 1 file changed, 123 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 99928789040d..d189849564db 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -19,8 +19,6 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/iio/consumer.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
 #include <asm/unaligned.h>
 
 #define PS_STAT_VBUS_TRIGGER			(1 << 0)
@@ -98,9 +96,6 @@ enum {
 };
 
 enum {
-	BAT_TEMP = 0,
-	PMIC_TEMP,
-	SYSTEM_TEMP,
 	BAT_CHRG_CURR,
 	BAT_D_CURR,
 	BAT_VOLT,
@@ -204,119 +199,6 @@ static int fuel_gauge_read_12bit_word(struct axp288_fg_info *info, int reg)
 	return (buf[0] << 4) | ((buf[1] >> 4) & 0x0f);
 }
 
-#ifdef CONFIG_DEBUG_FS
-static int fuel_gauge_debug_show(struct seq_file *s, void *data)
-{
-	struct axp288_fg_info *info = s->private;
-	int raw_val, ret;
-
-	seq_printf(s, " PWR_STATUS[%02x] : %02x\n",
-		AXP20X_PWR_INPUT_STATUS,
-		fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS));
-	seq_printf(s, "PWR_OP_MODE[%02x] : %02x\n",
-		AXP20X_PWR_OP_MODE,
-		fuel_gauge_reg_readb(info, AXP20X_PWR_OP_MODE));
-	seq_printf(s, " CHRG_CTRL1[%02x] : %02x\n",
-		AXP20X_CHRG_CTRL1,
-		fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1));
-	seq_printf(s, "       VLTF[%02x] : %02x\n",
-		AXP20X_V_LTF_DISCHRG,
-		fuel_gauge_reg_readb(info, AXP20X_V_LTF_DISCHRG));
-	seq_printf(s, "       VHTF[%02x] : %02x\n",
-		AXP20X_V_HTF_DISCHRG,
-		fuel_gauge_reg_readb(info, AXP20X_V_HTF_DISCHRG));
-	seq_printf(s, "    CC_CTRL[%02x] : %02x\n",
-		AXP20X_CC_CTRL,
-		fuel_gauge_reg_readb(info, AXP20X_CC_CTRL));
-	seq_printf(s, "BATTERY CAP[%02x] : %02x\n",
-		AXP20X_FG_RES,
-		fuel_gauge_reg_readb(info, AXP20X_FG_RES));
-	seq_printf(s, "    FG_RDC1[%02x] : %02x\n",
-		AXP288_FG_RDC1_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_RDC1_REG));
-	seq_printf(s, "    FG_RDC0[%02x] : %02x\n",
-		AXP288_FG_RDC0_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_RDC0_REG));
-	seq_printf(s, "     FG_OCV[%02x] : %04x\n",
-		AXP288_FG_OCVH_REG,
-		fuel_gauge_read_12bit_word(info, AXP288_FG_OCVH_REG));
-	seq_printf(s, " FG_DES_CAP[%02x] : %04x\n",
-		AXP288_FG_DES_CAP1_REG,
-		fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG));
-	seq_printf(s, "  FG_CC_MTR[%02x] : %04x\n",
-		AXP288_FG_CC_MTR1_REG,
-		fuel_gauge_read_15bit_word(info, AXP288_FG_CC_MTR1_REG));
-	seq_printf(s, " FG_OCV_CAP[%02x] : %02x\n",
-		AXP288_FG_OCV_CAP_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_OCV_CAP_REG));
-	seq_printf(s, "  FG_CC_CAP[%02x] : %02x\n",
-		AXP288_FG_CC_CAP_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_CC_CAP_REG));
-	seq_printf(s, " FG_LOW_CAP[%02x] : %02x\n",
-		AXP288_FG_LOW_CAP_REG,
-		fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG));
-	seq_printf(s, "TUNING_CTL0[%02x] : %02x\n",
-		AXP288_FG_TUNE0,
-		fuel_gauge_reg_readb(info, AXP288_FG_TUNE0));
-	seq_printf(s, "TUNING_CTL1[%02x] : %02x\n",
-		AXP288_FG_TUNE1,
-		fuel_gauge_reg_readb(info, AXP288_FG_TUNE1));
-	seq_printf(s, "TUNING_CTL2[%02x] : %02x\n",
-		AXP288_FG_TUNE2,
-		fuel_gauge_reg_readb(info, AXP288_FG_TUNE2));
-	seq_printf(s, "TUNING_CTL3[%02x] : %02x\n",
-		AXP288_FG_TUNE3,
-		fuel_gauge_reg_readb(info, AXP288_FG_TUNE3));
-	seq_printf(s, "TUNING_CTL4[%02x] : %02x\n",
-		AXP288_FG_TUNE4,
-		fuel_gauge_reg_readb(info, AXP288_FG_TUNE4));
-	seq_printf(s, "TUNING_CTL5[%02x] : %02x\n",
-		AXP288_FG_TUNE5,
-		fuel_gauge_reg_readb(info, AXP288_FG_TUNE5));
-
-	ret = iio_read_channel_raw(info->iio_channel[BAT_TEMP], &raw_val);
-	if (ret >= 0)
-		seq_printf(s, "axp288-batttemp : %d\n", raw_val);
-	ret = iio_read_channel_raw(info->iio_channel[PMIC_TEMP], &raw_val);
-	if (ret >= 0)
-		seq_printf(s, "axp288-pmictemp : %d\n", raw_val);
-	ret = iio_read_channel_raw(info->iio_channel[SYSTEM_TEMP], &raw_val);
-	if (ret >= 0)
-		seq_printf(s, "axp288-systtemp : %d\n", raw_val);
-	ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &raw_val);
-	if (ret >= 0)
-		seq_printf(s, "axp288-chrgcurr : %d\n", raw_val);
-	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &raw_val);
-	if (ret >= 0)
-		seq_printf(s, "axp288-dchrgcur : %d\n", raw_val);
-	ret = iio_read_channel_raw(info->iio_channel[BAT_VOLT], &raw_val);
-	if (ret >= 0)
-		seq_printf(s, "axp288-battvolt : %d\n", raw_val);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(fuel_gauge_debug);
-
-static void fuel_gauge_create_debugfs(struct axp288_fg_info *info)
-{
-	info->debug_file = debugfs_create_file("fuelgauge", 0666, NULL,
-		info, &fuel_gauge_debug_fops);
-}
-
-static void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
-{
-	debugfs_remove(info->debug_file);
-}
-#else
-static inline void fuel_gauge_create_debugfs(struct axp288_fg_info *info)
-{
-}
-static inline void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
-{
-}
-#endif
-
 static void fuel_gauge_get_status(struct axp288_fg_info *info)
 {
 	int pwr_stat, fg_res, curr, ret;
@@ -753,9 +635,6 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
 	static const char * const iio_chan_name[] = {
-		[BAT_TEMP] = "axp288-batt-temp",
-		[PMIC_TEMP] = "axp288-pmic-temp",
-		[SYSTEM_TEMP] = "axp288-system-temp",
 		[BAT_CHRG_CURR] = "axp288-chrg-curr",
 		[BAT_D_CURR] = "axp288-chrg-d-curr",
 		[BAT_VOLT] = "axp288-batt-volt",
@@ -844,7 +723,6 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		goto out_free_iio_chan;
 	}
 
-	fuel_gauge_create_debugfs(info);
 	fuel_gauge_init_irq(info);
 
 	return 0;
@@ -869,7 +747,6 @@ static int axp288_fuel_gauge_remove(struct platform_device *pdev)
 	int i;
 
 	power_supply_unregister(info->bat);
-	fuel_gauge_remove_debugfs(info);
 
 	for (i = 0; i < AXP288_FG_INTR_NUM; i++)
 		if (info->irq[i] >= 0)
-- 
2.31.1

