Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DA5A379A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2019 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfH3NQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Aug 2019 09:16:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36078 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfH3NQH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Aug 2019 09:16:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so6957786wrd.3;
        Fri, 30 Aug 2019 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/S9eKzefNd7RMHB9sZJ0C1DeLdzhViGsRQEhurBvj1g=;
        b=A+3XGo8eLt+CGtuybCO9ryzkFPRMsbxbjBkOf4VjPVt2rsCOYMfHDej1Di6DOKJXly
         SpSQu6uRxWh3yGTnqY1ZE16DixxGObQ/e2iV7A5lzp6yvh9nQAybLebOV5lsWnA9zy/d
         3/pImBjcK0C0w8gI+jLlA1cbQc8PJ6c+leWm9ZvucIikXtKUEv04Hv3mLGU6IunDmYTN
         6xBR+ITWi02Y8kNVUdiPsCSFBhSGHWKa3AnrM/2VlEvnccV09yikcVhwKlZt5AHqTeSK
         4SG8eG0rDij/3dA363LL084hvv3/seTWBYIIvRXDIV1CNS2Q+3B4uRTdpw/0gMbalxGN
         PBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/S9eKzefNd7RMHB9sZJ0C1DeLdzhViGsRQEhurBvj1g=;
        b=MT5jBdo5clXM813seWcMF9utNlgCbpYuyG4K5NJfu7kou9mBB2E3cb+ksOMQ9d9NMi
         YiY2MX798FiLRMEZTpyeJNSq9ueOm3ft5nL97RuWHkbzcvkPHvPdlJ81JsP5Jq02DRuz
         81IZL1qPhA79gOZoWuKdoVG8aGjgP0om2lMb3otlfmQGm5t/eHD1LWXkigP40jMF53h/
         o/yJaBCl669Y69hFBsCanmNBMtdoPjoX2916U/2oeG0clchbmYR9zqqJ2YIo2KM/HzSe
         c1oBoKJtlfnlp5Xd1Py5buXr+0Z4kO/84EvnEVhGDy20qaDBjMPmily6v2AVpZyR2dZG
         pxHg==
X-Gm-Message-State: APjAAAViB2yMaIQA+WkP154h/t1PL49rsxr/uxBrr45cJXmXoaBdHxGS
        itcUj1kirDxmfq1bOrhhq4k=
X-Google-Smtp-Source: APXvYqwXJjWiBE6NwdOXRxtwcsABPge0Ls8aIICSf4qJIPRfYa8/4rruesJBhd011tmXjtH1LkfrYA==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr19146221wrn.121.1567170965131;
        Fri, 30 Aug 2019 06:16:05 -0700 (PDT)
Received: from 5WDYG62.mdi (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id t19sm6384517wmi.29.2019.08.30.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 06:16:04 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2] power: supply: register HWMON devices with valid names
Date:   Fri, 30 Aug 2019 15:15:56 +0200
Message-Id: <20190830131556.10021-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the introduction of the HWMON compatibility layer to the power
supply framework in Linux 5.3, all power supply devices' names can be
used directly to create HWMON devices with the same names.

But HWMON has rules on allowable names that are different from those
used in the power supply framework. The dash character is forbidden, as
it is used by the libsensors library in userspace as a separator,
whereas this character is used in the device names in more than half of
the existing power supply drivers. This last case is consistent with the
typical naming usage with MFD and Device Tree.

This leads to warnings in the kernel log, with the format:

power_supply gpio-charger: hwmon: \
	'gpio-charger' is not a valid name attribute, please fix

Add a protection to power_supply_add_hwmon_sysfs() that replaces any
dash in the device name with an underscore when registering with the
HWMON framework. Other forbidden characters (star, slash, space, tab,
newline) are not replaced, as they are not in common use.

Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

v2: Remove a superfluous cast

 drivers/power/supply/power_supply_hwmon.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 51fe60440d12..75cf861ba492 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -284,6 +284,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 	struct device *dev = &psy->dev;
 	struct device *hwmon;
 	int ret, i;
+	const char *name;
 
 	if (!devres_open_group(dev, power_supply_add_hwmon_sysfs,
 			       GFP_KERNEL))
@@ -334,7 +335,19 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		}
 	}
 
-	hwmon = devm_hwmon_device_register_with_info(dev, psy->desc->name,
+	name = psy->desc->name;
+	if (strchr(name, '-')) {
+		char *new_name;
+
+		new_name = devm_kstrdup(dev, name, GFP_KERNEL);
+		if (!new_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		strreplace(new_name, '-', '_');
+		name = new_name;
+	}
+	hwmon = devm_hwmon_device_register_with_info(dev, name,
 						psyhw,
 						&power_supply_hwmon_chip_info,
 						NULL);
-- 
2.17.1

