Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DDA1B7CEF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgDXRf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728871AbgDXRfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 13:35:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D3C09B047
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:35:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w3so3986596plz.5
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=33hdVZdIvdo3r9ulzCeqVPA1lq6sxl5V/50+KNNX3vA=;
        b=RkeTuMr6pQxS9kGQ1szZoB7f5ty7zYGnPdIZBCe2ITN1R7VrKR6yI0p9MOpKHYnxo3
         0Brs7q3clGo3BgEVWdBjge9STeM5CRm7P2uyr8Mzr8kWWDVlBmgfl6BCE7UoOLb1896D
         biUAhpRWUo7UjVhyGr6DCwQpy2UUSC3zc+iP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33hdVZdIvdo3r9ulzCeqVPA1lq6sxl5V/50+KNNX3vA=;
        b=UW84/1wWaiS/4jTYSDhHAIyKENw6yM9ep4RXWVr+g7TaA4GWQgk0dvEgIwdoPPzE4i
         fLaaUz3f6+M8T4uZCxkVg/3RW12IkbYQ2tXJX91KBY7kSIkvtiPpgGs+/XVywAQL40dH
         GUrl/yEfxJVHksUHG4G18ovyxRy4FgBApwSxrJk/Xt49X/N4fRW3QGJ2wmgfvVqsv48g
         PFyCc8+gqHQJOVu0rJxg78pki55+hIQB13YMhzEyvu87zBd010Q2ABwOvcrXQxxNlySd
         7JIlIPdvSHoe3vwKoq4jmopmYIDWNM9y5RJow7DJ5RQ8qCcscZ4speV14vy83uGzFX94
         MFCQ==
X-Gm-Message-State: AGi0PuaKGlorZtODlDRrf2dYllaw2gW+uHLdPjgzfb0FV9D3x5NR8L4e
        uHlt/mLwKlbR2+XTiysIcrr4mQ==
X-Google-Smtp-Source: APiQypLJyUYhCmBaJxgPQFab/PXXMhS2ejilK7aTPfMJlbmAfwvBlF1nccjDo6PyB52i/djxAENRDg==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr10219965plf.115.1587749747510;
        Fri, 24 Apr 2020 10:35:47 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id t188sm5360641pgc.3.2020.04.24.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:35:46 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 4/4] power_supply: Add power supply type property to uevent env
Date:   Fri, 24 Apr 2020 11:35:33 -0600
Message-Id: <20200424173533.48572-5-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200424173533.48572-1-mathewk@chromium.org>
References: <20200424173533.48572-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add POWER_SUPPLY_TYPE to the uevent env for power supply. Type is a
property of all power supplies and there is a sysfs entry for it but it
is not included in the properties array of the power supply so
explicitly add it to the udev env.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/power/supply/power_supply_sysfs.c | 61 ++++++++++++++---------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index fbb05466b9a5..c7087cd7ffe3 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -448,6 +448,37 @@ void power_supply_destroy_attrs(void)
 	}
 }
 
+static int add_prop_uevent(struct device *dev, struct kobj_uevent_env *env,
+			   enum power_supply_property prop, char *prop_buf)
+{
+	int ret = 0;
+	struct power_supply_attr *pwr_attr;
+	struct device_attribute *dev_attr;
+	char *line;
+
+	pwr_attr = &power_supply_attrs[prop];
+	dev_attr = &pwr_attr->dev_attr;
+
+	ret = power_supply_show_property(dev, dev_attr, prop_buf);
+	if (ret == -ENODEV || ret == -ENODATA) {
+		/*
+		 * When a battery is absent, we expect -ENODEV. Don't abort;
+		 * send the uevent with at least the the PRESENT=0 property
+		 */
+		return 0;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	line = strchr(prop_buf, '\n');
+	if (line)
+		*line = 0;
+
+	return add_uevent_var(env, "POWER_SUPPLY_%s=%s",
+			      pwr_attr->upper_name, prop_buf);
+}
+
 int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
@@ -467,31 +498,13 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (!prop_buf)
 		return -ENOMEM;
 
-	for (j = 0; j < psy->desc->num_properties; j++) {
-		struct power_supply_attr *pwr_attr;
-		struct device_attribute *dev_attr;
-		char *line;
-
-		pwr_attr = &power_supply_attrs[psy->desc->properties[j]];
-		dev_attr = &pwr_attr->dev_attr;
-
-		ret = power_supply_show_property(dev, dev_attr, prop_buf);
-		if (ret == -ENODEV || ret == -ENODATA) {
-			/* When a battery is absent, we expect -ENODEV. Don't abort;
-			   send the uevent with at least the the PRESENT=0 property */
-			ret = 0;
-			continue;
-		}
-
-		if (ret < 0)
-			goto out;
-
-		line = strchr(prop_buf, '\n');
-		if (line)
-			*line = 0;
+	ret = add_prop_uevent(dev, env, POWER_SUPPLY_PROP_TYPE, prop_buf);
+	if (ret)
+		goto out;
 
-		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s",
-				     pwr_attr->upper_name, prop_buf);
+	for (j = 0; j < psy->desc->num_properties; j++) {
+		ret = add_prop_uevent(dev, env, psy->desc->properties[j],
+				      prop_buf);
 		if (ret)
 			goto out;
 	}
-- 
2.26.2.303.gf8c07b1a785-goog

