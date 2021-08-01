Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9A03DCBCF
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 15:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhHANbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 09:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231945AbhHANba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627824678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRQ+za2BaYYEfjUTnjbumFr9O4fy87Nl58a3MXNm8Sk=;
        b=ZwRhhuOAbEmyA3IlIlJmdLl7Xch2WnK4G1DyvchH5Mq43iOF+SBOv4YehtNG9cQSJGTJdR
        CMC/hFPEt+J370Zi0wVhK9LXX6abnelaJcG1ut17/uGEkhqiNWKEbsJuAcOONX6wmRo0Ks
        1dYRAICr8wMLvQGCDNLxtg2ebrmPNxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-15DiJd48Pgq5jGLSX0ldog-1; Sun, 01 Aug 2021 09:31:17 -0400
X-MC-Unique: 15DiJd48Pgq5jGLSX0ldog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A03AA6409B;
        Sun,  1 Aug 2021 13:31:16 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5EBA60916;
        Sun,  1 Aug 2021 13:31:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 07/10] power: supply: axp288_fuel_gauge: Only read PWR_OP_MODE, FG_LOW_CAP_REG regs once
Date:   Sun,  1 Aug 2021 15:31:02 +0200
Message-Id: <20210801133105.101761-8-hdegoede@redhat.com>
In-Reply-To: <20210801133105.101761-1-hdegoede@redhat.com>
References: <20210801133105.101761-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Accessing registers on the AXP288 is quite expensive, so we should avoid
doing unnecessary accesses.

The FG_LOW_CAP_REG never changes underneath us, so we only need to read
it once. Devices with an AXP288 do not have user-replace (let alone
hot-swappable) batteries and the only bit we care about in the
PWR_OP_MODE register is the CHRG_STAT_BAT_PRESENT bit, so we can get
away with only reading the PWR_OP_MODE register once too.

Note that the FG_LOW_CAP_REG is not marked volatile in the regmap, so we
were effectively already reading it once. This change makes this explicit,
this is done as preparation of a further patch which moves all remaining
register accesses in fuel_gauge_get_property() out of that function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 37 ++++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 1366027edf49..8011628d3704 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -111,6 +111,8 @@ struct axp288_fg_info {
 	struct mutex lock;
 	int status;
 	int max_volt;
+	int pwr_op;
+	int low_cap;
 	struct dentry *debug_file;
 };
 
@@ -336,11 +338,7 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 		val->intval = PROP_CURR(value);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
-		ret = fuel_gauge_reg_readb(info, AXP20X_PWR_OP_MODE);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
-
-		if (ret & CHRG_STAT_BAT_PRESENT)
+		if (info->pwr_op & CHRG_STAT_BAT_PRESENT)
 			val->intval = 1;
 		else
 			val->intval = 0;
@@ -355,10 +353,7 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 		val->intval = (ret & FG_REP_CAP_VAL_MASK);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
-		ret = fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
-		val->intval = (ret & 0x0f);
+		val->intval = (info->low_cap & 0x0f);
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
@@ -398,7 +393,7 @@ static int fuel_gauge_set_property(struct power_supply *ps,
 		const union power_supply_propval *val)
 {
 	struct axp288_fg_info *info = power_supply_get_drvdata(ps);
-	int ret = 0;
+	int new_low_cap, ret = 0;
 
 	mutex_lock(&info->lock);
 	switch (prop) {
@@ -407,12 +402,12 @@ static int fuel_gauge_set_property(struct power_supply *ps,
 			ret = -EINVAL;
 			break;
 		}
-		ret = fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG);
-		if (ret < 0)
-			break;
-		ret &= 0xf0;
-		ret |= (val->intval & 0xf);
-		ret = fuel_gauge_reg_writeb(info, AXP288_FG_LOW_CAP_REG, ret);
+		new_low_cap = info->low_cap;
+		new_low_cap &= 0xf0;
+		new_low_cap |= (val->intval & 0xf);
+		ret = fuel_gauge_reg_writeb(info, AXP288_FG_LOW_CAP_REG, new_low_cap);
+		if (ret == 0)
+			info->low_cap = new_low_cap;
 		break;
 	default:
 		ret = -EINVAL;
@@ -695,6 +690,16 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		break;
 	}
 
+	ret = fuel_gauge_reg_readb(info, AXP20X_PWR_OP_MODE);
+	if (ret < 0)
+		goto out_free_iio_chan;
+	info->pwr_op = ret;
+
+	ret = fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG);
+	if (ret < 0)
+		goto out_free_iio_chan;
+	info->low_cap = ret;
+
 	psy_cfg.drv_data = info;
 	info->bat = power_supply_register(&pdev->dev, &fuel_gauge_desc, &psy_cfg);
 	if (IS_ERR(info->bat)) {
-- 
2.31.1

