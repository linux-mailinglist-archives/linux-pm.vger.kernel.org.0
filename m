Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6F486373
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 12:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiAFLGR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 06:06:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238277AbiAFLGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 06:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641467176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSHofIoXxgGGITki1qxFv1SasuC/kWDVjCCHqFqr4K4=;
        b=AFWMPgHPaLeSr9HwLG4JZ0ZH6YayiplvhUyRTnNHTSsulJSyegqRKFxpFf2bdQw3MVfSrk
        hnz2NeQJEJl3IJWmKmLGh3xAHnWyWKI45zEKTW5F9BsKBvhvDmhXEqj+ZedbyQvMV6uJDS
        2HMiL+h3TdW5+/Merxfz0fia1DiLLAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-2BCuPqJxOwCVdZZiHWfjYQ-1; Thu, 06 Jan 2022 06:06:13 -0500
X-MC-Unique: 2BCuPqJxOwCVdZZiHWfjYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9776718C8C04;
        Thu,  6 Jan 2022 11:06:12 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4C51752B4;
        Thu,  6 Jan 2022 11:06:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 3/7] power: supply: axp288_fuel_gauge: Use devm_add_action_or_reset() for iio chan release
Date:   Thu,  6 Jan 2022 12:06:04 +0100
Message-Id: <20220106110608.66231-3-hdegoede@redhat.com>
In-Reply-To: <20220106110608.66231-1-hdegoede@redhat.com>
References: <20220106110608.66231-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

An existing comment already mentions we: "cannot use devm_iio_channel_get
because x86 systems lack the device<->channel maps which iio_channel_get
will try to use when passed a non NULL device pointer".

Work around this by registering a devm action to free the iio-channels.
This is a step on the way to fully converting the probe() function to
only use devm managed resources.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 33 ++++++++++++++----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 35f9edf3da09..aaf2d5542316 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -666,6 +666,16 @@ static int axp288_fuel_gauge_read_initial_regs(struct axp288_fg_info *info)
 	return 0;
 }
 
+static void axp288_fuel_gauge_release_iio_chans(void *data)
+{
+	struct axp288_fg_info *info = data;
+	int i;
+
+	for (i = 0; i < IIO_CHANNEL_NUM; i++)
+		if (!IS_ERR_OR_NULL(info->iio_channel[i]))
+			iio_channel_release(info->iio_channel[i]);
+}
+
 static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 {
 	int i, ret = 0;
@@ -711,37 +721,35 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 			if (ret == -ENODEV)
 				ret = -EPROBE_DEFER;
 
-			goto out_free_iio_chan;
+			axp288_fuel_gauge_release_iio_chans(info);
+			return ret;
 		}
 	}
 
+	ret = devm_add_action_or_reset(dev, axp288_fuel_gauge_release_iio_chans, info);
+	if (ret)
+		return ret;
+
 	ret = iosf_mbi_block_punit_i2c_access();
 	if (ret < 0)
-		goto out_free_iio_chan;
+		return ret;
 
 	ret = axp288_fuel_gauge_read_initial_regs(info);
 	iosf_mbi_unblock_punit_i2c_access();
 	if (ret < 0)
-		goto out_free_iio_chan;
+		return ret;
 
 	psy_cfg.drv_data = info;
 	info->bat = power_supply_register(dev, &fuel_gauge_desc, &psy_cfg);
 	if (IS_ERR(info->bat)) {
 		ret = PTR_ERR(info->bat);
 		dev_err(dev, "failed to register battery: %d\n", ret);
-		goto out_free_iio_chan;
+		return ret;
 	}
 
 	fuel_gauge_init_irq(info, pdev);
 
 	return 0;
-
-out_free_iio_chan:
-	for (i = 0; i < IIO_CHANNEL_NUM; i++)
-		if (!IS_ERR_OR_NULL(info->iio_channel[i]))
-			iio_channel_release(info->iio_channel[i]);
-
-	return ret;
 }
 
 static const struct platform_device_id axp288_fg_id_table[] = {
@@ -761,9 +769,6 @@ static int axp288_fuel_gauge_remove(struct platform_device *pdev)
 		if (info->irq[i] >= 0)
 			free_irq(info->irq[i], info);
 
-	for (i = 0; i < IIO_CHANNEL_NUM; i++)
-		iio_channel_release(info->iio_channel[i]);
-
 	return 0;
 }
 
-- 
2.33.1

