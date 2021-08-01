Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77F3DCBD7
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhHANbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 09:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232017AbhHANbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 09:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627824684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAYBzJYjCndDUNzyo7GCS7T4/TEKnsZRkw8FZBiiYys=;
        b=IGOF7/8SBqoPkSyGfXoebAQQ0mSxy8gBVKzBKYOgE4FV9H1jLjSTX9d2zgOsb4y0fYOzsR
        KpEZ+Z9Zs0eF94MrTFkTysa/VRueweY2qF/4J1rODlCt7pNFwxdNpxuJS5FHsOckmGOrO1
        PECR87qgtJHUUKNrRNN6zbrCUrsqFFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-k71IRgcSNK2HwCtJMl7BRg-1; Sun, 01 Aug 2021 09:31:21 -0400
X-MC-Unique: k71IRgcSNK2HwCtJMl7BRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C1831853027;
        Sun,  1 Aug 2021 13:31:20 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5371260CC4;
        Sun,  1 Aug 2021 13:31:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 10/10] power: supply: axp288_fuel_gauge: Take the P-Unit semaphore only once during probe()
Date:   Sun,  1 Aug 2021 15:31:05 +0200
Message-Id: <20210801133105.101761-11-hdegoede@redhat.com>
In-Reply-To: <20210801133105.101761-1-hdegoede@redhat.com>
References: <20210801133105.101761-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
before it may use the bus. If not explicitly taken by the I2C-driver,
then this semaphore is automatically taken by the I2C-bus-driver for
each I2C-transfer and this is a quite expensive operation.

Explicitly take the semaphore in probe() around the register-accesses
done during probe, so that this only needs to be done once, rather then
once per register-access.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 016d8d6bec40..c1da217fdb0e 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -661,31 +661,35 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret < 0)
+		goto out_free_iio_chan;
+
 	/*
 	 * On some devices the fuelgauge and charger parts of the axp288 are
 	 * not used, check that the fuelgauge is enabled (CC_CTRL != 0).
 	 */
 	ret = regmap_read(axp20x->regmap, AXP20X_CC_CTRL, &val);
 	if (ret < 0)
-		goto out_free_iio_chan;
+		goto unblock_punit_i2c_access;
 	if (val == 0) {
 		ret = -ENODEV;
-		goto out_free_iio_chan;
+		goto unblock_punit_i2c_access;
 	}
 
 	ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);
 	if (ret < 0)
-		goto out_free_iio_chan;
+		goto unblock_punit_i2c_access;
 
 	if (!(ret & FG_DES_CAP1_VALID)) {
 		dev_err(&pdev->dev, "axp288 not configured by firmware\n");
 		ret = -ENODEV;
-		goto out_free_iio_chan;
+		goto unblock_punit_i2c_access;
 	}
 
 	ret = fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1);
 	if (ret < 0)
-		goto out_free_iio_chan;
+		goto unblock_punit_i2c_access;
 	switch ((ret & CHRG_CCCV_CV_MASK) >> CHRG_CCCV_CV_BIT_POS) {
 	case CHRG_CCCV_CV_4100MV:
 		info->max_volt = 4100;
@@ -703,14 +707,20 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 
 	ret = fuel_gauge_reg_readb(info, AXP20X_PWR_OP_MODE);
 	if (ret < 0)
-		goto out_free_iio_chan;
+		goto unblock_punit_i2c_access;
 	info->pwr_op = ret;
 
 	ret = fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG);
 	if (ret < 0)
-		goto out_free_iio_chan;
+		goto unblock_punit_i2c_access;
 	info->low_cap = ret;
 
+unblock_punit_i2c_access:
+	iosf_mbi_unblock_punit_i2c_access();
+	/* In case we arrive here by goto because of a register access error */
+	if (ret < 0)
+		goto out_free_iio_chan;
+
 	psy_cfg.drv_data = info;
 	info->bat = power_supply_register(&pdev->dev, &fuel_gauge_desc, &psy_cfg);
 	if (IS_ERR(info->bat)) {
-- 
2.31.1

