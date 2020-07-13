Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4521E090
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGMTQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMTQs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 15:16:48 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16742C061755;
        Mon, 13 Jul 2020 12:16:48 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2B644BC0D1;
        Mon, 13 Jul 2020 19:16:44 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     pali@kernel.org, sre@kernel.org, afd@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] power: supply: bq2xxxx: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 21:16:38 +0200
Message-Id: <20200713191638.37311-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 drivers/power/supply/bq2415x_charger.c     | 16 ++++----
 drivers/power/supply/bq24257_charger.c     |  6 +--
 drivers/power/supply/bq27xxx_battery.c     | 44 +++++++++++-----------
 drivers/power/supply/bq27xxx_battery_hdq.c |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +-
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index a1f00ae1c180..5724001e66b9 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -5,14 +5,14 @@
  * Copyright (C) 2011-2013  Pali Rohár <pali@kernel.org>
  *
  * Datasheets:
- * http://www.ti.com/product/bq24150
- * http://www.ti.com/product/bq24150a
- * http://www.ti.com/product/bq24152
- * http://www.ti.com/product/bq24153
- * http://www.ti.com/product/bq24153a
- * http://www.ti.com/product/bq24155
- * http://www.ti.com/product/bq24157s
- * http://www.ti.com/product/bq24158
+ * https://www.ti.com/product/bq24150
+ * https://www.ti.com/product/bq24150a
+ * https://www.ti.com/product/bq24152
+ * https://www.ti.com/product/bq24153
+ * https://www.ti.com/product/bq24153a
+ * https://www.ti.com/product/bq24155
+ * https://www.ti.com/product/bq24157s
+ * https://www.ti.com/product/bq24158
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index eb151687beb3..8e60cb0f3c3f 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -5,9 +5,9 @@
  * Copyright (C) 2015 Intel Corporation
  *
  * Datasheets:
- * http://www.ti.com/product/bq24250
- * http://www.ti.com/product/bq24251
- * http://www.ti.com/product/bq24257
+ * https://www.ti.com/product/bq24250
+ * https://www.ti.com/product/bq24251
+ * https://www.ti.com/product/bq24257
  */
 
 #include <linux/module.h>
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 942c92127b6d..76a78c3a20a7 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -18,31 +18,31 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  *
  * Datasheets:
- * http://www.ti.com/product/bq27000
- * http://www.ti.com/product/bq27200
- * http://www.ti.com/product/bq27010
- * http://www.ti.com/product/bq27210
- * http://www.ti.com/product/bq27500
- * http://www.ti.com/product/bq27510-g1
- * http://www.ti.com/product/bq27510-g2
- * http://www.ti.com/product/bq27510-g3
+ * https://www.ti.com/product/bq27000
+ * https://www.ti.com/product/bq27200
+ * https://www.ti.com/product/bq27010
+ * https://www.ti.com/product/bq27210
+ * https://www.ti.com/product/bq27500
+ * https://www.ti.com/product/bq27510-g1
+ * https://www.ti.com/product/bq27510-g2
+ * https://www.ti.com/product/bq27510-g3
  * http://www.ti.com/product/bq27520-g1
  * http://www.ti.com/product/bq27520-g2
  * http://www.ti.com/product/bq27520-g3
- * http://www.ti.com/product/bq27520-g4
- * http://www.ti.com/product/bq27530-g1
- * http://www.ti.com/product/bq27531-g1
- * http://www.ti.com/product/bq27541-g1
- * http://www.ti.com/product/bq27542-g1
- * http://www.ti.com/product/bq27546-g1
- * http://www.ti.com/product/bq27742-g1
- * http://www.ti.com/product/bq27545-g1
- * http://www.ti.com/product/bq27421-g1
- * http://www.ti.com/product/bq27425-g1
- * http://www.ti.com/product/bq27426
- * http://www.ti.com/product/bq27411-g1
- * http://www.ti.com/product/bq27441-g1
- * http://www.ti.com/product/bq27621-g1
+ * https://www.ti.com/product/bq27520-g4
+ * https://www.ti.com/product/bq27530-g1
+ * https://www.ti.com/product/bq27531-g1
+ * https://www.ti.com/product/bq27541-g1
+ * https://www.ti.com/product/bq27542-g1
+ * https://www.ti.com/product/bq27546-g1
+ * https://www.ti.com/product/bq27742-g1
+ * https://www.ti.com/product/bq27545-g1
+ * https://www.ti.com/product/bq27421-g1
+ * https://www.ti.com/product/bq27425-g1
+ * https://www.ti.com/product/bq27426
+ * https://www.ti.com/product/bq27411-g1
+ * https://www.ti.com/product/bq27441-g1
+ * https://www.ti.com/product/bq27621-g1
  */
 
 #include <linux/device.h>
diff --git a/drivers/power/supply/bq27xxx_battery_hdq.c b/drivers/power/supply/bq27xxx_battery_hdq.c
index 9aff896c9802..29771967df2e 100644
--- a/drivers/power/supply/bq27xxx_battery_hdq.c
+++ b/drivers/power/supply/bq27xxx_battery_hdq.c
@@ -1,7 +1,7 @@
 /*
  * BQ27xxx battery monitor HDQ/1-wire driver
  *
- * Copyright (C) 2007-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2007-2017 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 2677c38a8a42..8e114a7abfc9 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -1,7 +1,7 @@
 /*
  * BQ27xxx battery monitor I2C driver
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
-- 
2.27.0

