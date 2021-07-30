Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1563DB682
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbhG3J43 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 05:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238307AbhG3J43 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 05:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627638984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nv0qlxmWEsIaYuBR2s/acFg+5H+397HISkhkkk33W9o=;
        b=NdVG/0YtJHenJVu8DkLaA0wK3KYIRVRwbX9GwWO3iNlK8INBZ7VT8+AP7aQbC1sPm7tQ3b
        rNHQrlWfzgX7XK7YiLI6vqev1vOIqF4bhdpp+pp2heEEg7UaWNGUWTCVAAhgY4PfuxM1Yy
        4xB5rZ1DyXRksOBSHdoQR2mLzIMESTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-jPsoDiImN9SNPOfB5U9-uA-1; Fri, 30 Jul 2021 05:56:22 -0400
X-MC-Unique: jPsoDiImN9SNPOfB5U9-uA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B9593922;
        Fri, 30 Jul 2021 09:56:21 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01419399;
        Fri, 30 Jul 2021 09:56:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 09/10] power: supply: axp288_fuel_gauge: Move the AXP20X_CC_CTRL check together with the other checks
Date:   Fri, 30 Jul 2021 11:56:06 +0200
Message-Id: <20210730095607.57541-10-hdegoede@redhat.com>
In-Reply-To: <20210730095607.57541-1-hdegoede@redhat.com>
References: <20210730095607.57541-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
before it may use the bus. If not explicitly taken by the I2C-driver,
then this semaphore is automatically taken by the I2C-bus-driver for
each I2C-transfer.

Move the AXP20X_CC_CTRL check done in probe() together with the other
register-accesses done in probe, so that we can take the semaphore once
for the entire set of register-accesses.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 8db8ab0827e4..016d8d6bec40 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -627,16 +627,6 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	if (dmi_check_system(axp288_no_battery_list))
 		return -ENODEV;
 
-	/*
-	 * On some devices the fuelgauge and charger parts of the axp288 are
-	 * not used, check that the fuelgauge is enabled (CC_CTRL != 0).
-	 */
-	ret = regmap_read(axp20x->regmap, AXP20X_CC_CTRL, &val);
-	if (ret < 0)
-		return ret;
-	if (val == 0)
-		return -ENODEV;
-
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -671,6 +661,18 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * On some devices the fuelgauge and charger parts of the axp288 are
+	 * not used, check that the fuelgauge is enabled (CC_CTRL != 0).
+	 */
+	ret = regmap_read(axp20x->regmap, AXP20X_CC_CTRL, &val);
+	if (ret < 0)
+		goto out_free_iio_chan;
+	if (val == 0) {
+		ret = -ENODEV;
+		goto out_free_iio_chan;
+	}
+
 	ret = fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);
 	if (ret < 0)
 		goto out_free_iio_chan;
-- 
2.31.1

