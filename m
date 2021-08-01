Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DCF3DCBD8
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhHANbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 09:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231985AbhHANba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627824678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7BGnJUzzGbSH/EL3CtZjHdXIxO8MHB+Pm20xTtcVtw=;
        b=FMK8YB2R44vezzIkLb0DpaWbf3wISe9tUdnEkzcGIrbjBEq9UQ/INxhmBIt8L3ph/QqUiK
        q9+5qTVykmynN6v/UjkdAJPLkEdW0YOEoMY73C+IElES127uQlhAr75HH1ECzEXleNvCWD
        odKbfzy9/Kbm2mx4jrAaaJiUPTMOWkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-CW9t3M5zOjSV5x6jLGaN3A-1; Sun, 01 Aug 2021 09:31:15 -0400
X-MC-Unique: CW9t3M5zOjSV5x6jLGaN3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EF4A1853027;
        Sun,  1 Aug 2021 13:31:14 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FEC160916;
        Sun,  1 Aug 2021 13:31:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 05/10] power: supply: axp288_fuel_gauge: Drop retry logic from fuel_gauge_reg_readb()
Date:   Sun,  1 Aug 2021 15:31:00 +0200
Message-Id: <20210801133105.101761-6-hdegoede@redhat.com>
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
before it may use the bus. This semaphore is automatically taken by the
I2C-bus-driver.

The retry on -EBUSY logic in fuel_gauge_reg_readb() likely was added to
deal with the I2C-bus-drive returning -EBUSY when it failed to take the
semaphore, but this really should never happen. The semaphore code even
has a WARN_ON(ret) to log a kernel backtrace if this does somehow happen,
when this happens something is seriously wrong and the system typically
freezes soon afterwards.

TL;DR: the regmap_read() should never fail with -EBUSY so the retries
are unnecessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 796153caf5e0..d58a1f81fcea 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -76,7 +76,6 @@
 #define FG_LOW_CAP_CRIT_THR			4   /* 4 perc */
 #define FG_LOW_CAP_SHDN_THR			0   /* 0 perc */
 
-#define NR_RETRY_CNT				3
 #define DEV_NAME				"axp288_fuel_gauge"
 
 /* 1.1mV per LSB expressed in uV */
@@ -132,15 +131,10 @@ static enum power_supply_property fuel_gauge_props[] = {
 
 static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)
 {
-	int ret, i;
 	unsigned int val;
+	int ret;
 
-	for (i = 0; i < NR_RETRY_CNT; i++) {
-		ret = regmap_read(info->regmap, reg, &val);
-		if (ret != -EBUSY)
-			break;
-	}
-
+	ret = regmap_read(info->regmap, reg, &val);
 	if (ret < 0) {
 		dev_err(&info->pdev->dev, "Error reading reg 0x%02x err: %d\n", reg, ret);
 		return ret;
-- 
2.31.1

