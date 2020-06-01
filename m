Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B261E9EB7
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 09:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAHDo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 03:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAHDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 03:03:44 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7DBC061A0E;
        Mon,  1 Jun 2020 00:03:43 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t8so7871715ilm.7;
        Mon, 01 Jun 2020 00:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=58k1EKTlghaTWCF1GVnAnw6YMCNTVMwN3h07rzZnEbY=;
        b=Kaz+culsoNUnUOZaySh9qqUxqXCNj5wxgjZkkPNVRdRce2CefqaSVv0kyAOUcQafac
         RaDnpb7/x8FJaY6PA/yI0lx5ZvLokAhUTGX3f07Z2qlrIkMWMyvPvP/hDilgRA1DYnSy
         aLa9pI4HGACF0ZZR1w9ZKOMgT8HYWNpY8TsEYQ3wZD8qt6Y+3U/S7XxwG1oNYtlj34zK
         HSQX56CYu3IXgnheSLAnoeWhp97drn67RdtPlHN0OY+aSCu5wVjzwduhZ9L5IQNJZ6mB
         S3Dm+lEYHNT2GgQJYIfF7uni3g1lUJEaSilDhmlsf4UhjeeJ4BJXQ/m5i6/2DyHE+F75
         RjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=58k1EKTlghaTWCF1GVnAnw6YMCNTVMwN3h07rzZnEbY=;
        b=NZbixicc9V9tIXaeRD1EPuqYeiSHwH/iDTW8M//nak54yi9VVV/LK0KWTH7YaDl/E+
         XriRFA4elT/5pBqRUlqoCyZ9JaOVMaFWhySMFRl4S0PqaqLcIC8vzUShAwW0fLHyqAO9
         e8JDur849KR2krYDe4L6E5TMuif1q3Iv7lCs6sL7n9AuWMKKlr/NusiGj+UHFoLjEeh1
         6Yp/hOps25gho6FmiCO45bi6Sdjp3HU5ok3gn71HW0XIEpFkJ9vtywHi7Uh/UYs4P3qu
         zIPdqM4HF8P//IdBwrLy/J1at2dcbEjhDNHLpM7jKV2QH1GyLZPNYbGbZEOL4+pYt4Zv
         3yGQ==
X-Gm-Message-State: AOAM531NdtsjwvgSxzHiM4M2q4aWcsAiVaaFkvm21fp/xpBhFA1rPVzb
        zZzoujeft9vmIomumox8WRM=
X-Google-Smtp-Source: ABdhPJx59ZfGcZmtm7zFY6syV8SV7ShCRhxBuqgduEP1PV7quNNHkSp7AemeNzCr6UIMH1nKtRM9bQ==
X-Received: by 2002:a92:b11:: with SMTP id b17mr19783620ilf.257.1590995023372;
        Mon, 01 Jun 2020 00:03:43 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id p22sm9270608ill.52.2020.06.01.00.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 00:03:42 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu, Navid <navid.emamdoost@gmail.com>
Subject: [PATCH] power: supply: bq24190_charger.c: call pm_runtime_put in pm_runtime_get_sync failed case
Date:   Mon,  1 Jun 2020 02:03:35 -0500
Message-Id: <20200601070335.84800-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Navid <navid.emamdoost@gmail.com>

Even in failed case of pm_runtime_get_sync, the usage_count
is incremented. In order to keep the usage_count with correct
value call pm_runtime_put_autosuspend.

Signed-off-by: Navid <navid.emamdoost@gmail.com>
---
 drivers/power/supply/bq24190_charger.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 453d6332d43a..502ccdac2443 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -448,8 +448,10 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		count = ret;
+		goto out;
+	}
 
 	ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
 	if (ret)
@@ -458,6 +460,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 		count = scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
@@ -481,14 +484,17 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		count = ret;
+		goto out;
+	}
 
 	ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
 	if (ret)
 		count = ret;
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return count;
@@ -1076,7 +1082,7 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 
 	ret = pm_runtime_get_sync(bdi->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
@@ -1132,6 +1138,7 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1148,7 +1155,7 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 
 	ret = pm_runtime_get_sync(bdi->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1174,6 +1181,7 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1409,7 +1417,7 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 
 	ret = pm_runtime_get_sync(bdi->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -1438,6 +1446,7 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
@@ -1455,7 +1464,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 
 	ret = pm_runtime_get_sync(bdi->dev);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1469,6 +1478,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
+out:
 	pm_runtime_put_autosuspend(bdi->dev);
 
 	return ret;
-- 
2.17.1

