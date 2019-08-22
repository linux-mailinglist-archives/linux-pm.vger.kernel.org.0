Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305A3997C4
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389025AbfHVPJf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 11:09:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52288 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387755AbfHVPJf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 11:09:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id o4so6013619wmh.2;
        Thu, 22 Aug 2019 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=epm2bxhgoCj95Z6p1gy2pWq2N6Ff7EZzq5imHpCeV+4=;
        b=lZHWEANJk9q8e3J5u6ELsHoHhgUAunenXbzK0S065hZGcXYJpjrA21l0Jh9RzjmoLp
         XcyT/ax5hsAVKggrmLmnhZAzOb+irzZv0dHc5yMnbxijC5t3QXmBfHQS8uxRwEt2dX/U
         kSuv5od6kXGLqdX2MafspALjJ1Ok0M0KWRA2m1n0j0HxOul1KfhD1+mAcZfkrIV+Tge3
         hqZQ44uujiRlLU0kS+fFE5WzP6ZlyFDimsosAFkHUNecAH2dLtL9ekx+C6ztqRcC6hTJ
         oVnqYMz2Dfy2IvEU5+/uNdcHLrIScplQiw+yvlglqBBW6zttoZc96eK/JIFKCyMPv7vs
         cxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=epm2bxhgoCj95Z6p1gy2pWq2N6Ff7EZzq5imHpCeV+4=;
        b=MrUSycZOCYZ+nMz1zMg76Uky0OknMuoHJWdz4aYm9LD0vZP2uMpvwtd8zl7AWpmMjQ
         4E1Z0x6D4uUZl90Fj4pRGP7JvkZ7pUp4kKrR6C3pclEVprPa6RqJyS81tE+gNWttbMAy
         0bgYcHPQfM7dhNFc/w+yh+foLLSLfGaZ2rmpQMkb7Aw8yvxLJRSt9y79OV+3DoHbzA5n
         UFR3CVpTPQGH6KyfujWpDrTz6j6gTPm75nbF98ZC+Fu/9v8kB6T/I341A+doXXXWXDJU
         efAjR4QcP6NwJf0sTUdq42XGJk83Gu1IyOAjqWtj39Ca6yYnJS/3NlbvEnbwcBQpz2nB
         JcNw==
X-Gm-Message-State: APjAAAWfYDCCceZti15NKAMp43TJknYKdGa6QBmGvG6FCCkpve3NJwEt
        Evxg0uf/4moxM/SCLOEYdcQ=
X-Google-Smtp-Source: APXvYqztOWmcfGgIEa/AcSEB1HKR9AkPS518AMmGWGqnFP955b4sP47G/L4meyzONf553c3+SAhNJA==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr6968856wmg.15.1566486572549;
        Thu, 22 Aug 2019 08:09:32 -0700 (PDT)
Received: from 5WDYG62.mdi (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id f17sm3458098wmf.27.2019.08.22.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 08:09:31 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] power: supply: register HWMON devices with valid names
Date:   Thu, 22 Aug 2019 17:09:19 +0200
Message-Id: <20190822150919.18290-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the introduction of the HWMON compatibility layer to the power
supply framework in Linux 5.3, all power supply devices' names can be
used directly to create HWMON devices with the same names.

But HWMON has rules on allowable names that are different from the power
supply framework. The dash character is forbidden, as it is used by the
libsensors library in userspace as a separator, whereas this character
is used in the device names in more than half of the existing power
supply drivers. This last case is consistent with the typical naming
usage with MFD and Device Tree.

This leads to warnings in the kernel log, with the format:

power_supply gpio-charger: hwmon: \
	'gpio-charger' is not a valid name attribute, please fix

Add a protection to power_supply_add_hwmon_sysfs() that replaces any
dash in the device name with an underscore when registering with the
HWMON framework. Other forbidden characters (star, slash, space, tab,
newline) are not replaced, as they are not in common use.

Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/power/supply/power_supply_hwmon.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 51fe60440d12..ebe964bd512c 100644
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
+		name = (const char *) new_name;
+	}
+	hwmon = devm_hwmon_device_register_with_info(dev, name,
 						psyhw,
 						&power_supply_hwmon_chip_info,
 						NULL);
-- 
2.17.1

