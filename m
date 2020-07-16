Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CF9222B91
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 21:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgGPTIv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 15:08:51 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:44352 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgGPTIv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jul 2020 15:08:51 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B68BBBC063;
        Thu, 16 Jul 2020 19:08:45 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     edubezval@gmail.com, j-keerthy@ti.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] thermal: ti-soc-thermal: Replace HTTP links with HTTPS ones
Date:   Thu, 16 Jul 2020 21:08:39 +0200
Message-Id: <20200716190839.63380-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
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


 drivers/thermal/ti-soc-thermal/dra752-bandgap.h     | 2 +-
 drivers/thermal/ti-soc-thermal/omap3-thermal-data.c | 2 +-
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h   | 2 +-
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h   | 2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c         | 2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.h         | 2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c  | 2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal.h         | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
index d1b5b699cf23..c3eae80b2ab5 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/dra752-bandgap.h
@@ -2,7 +2,7 @@
 /*
  * DRA752 bandgap registers, bitfields and temperature definitions
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact:
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  *   Tero Kristo <t-kristo@ti.com>
diff --git a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
index 72e1ff270af7..80af315bae35 100644
--- a/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap3-thermal-data.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2014 Pavel Machek <pavel@ucw.cz>
  *
  * Note
- * http://www.ti.com/lit/er/sprz278f/sprz278f.pdf "Advisory
+ * https://www.ti.com/lit/er/sprz278f/sprz278f.pdf "Advisory
  * 3.1.1.186 MMC OCP Clock Not Gated When Thermal Sensor Is Used"
  *
  * Also TI says:
diff --git a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
index a453ff8eb313..23352183dfe8 100644
--- a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
@@ -2,7 +2,7 @@
 /*
  * OMAP4xxx bandgap registers, bitfields and temperature definitions
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact:
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  */
diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index 3880e667ea96..c5a2e2abbe5f 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -2,7 +2,7 @@
 /*
  * OMAP5xxx bandgap registers, bitfields and temperature definitions
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact:
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  */
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ab19ceff6e2a..7bb7e9d12cda 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -2,7 +2,7 @@
 /*
  * TI Bandgap temperature sensor driver
  *
- * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011-2012 Texas Instruments Incorporated - https://www.ti.com/
  * Author: J Keerthy <j-keerthy@ti.com>
  * Author: Moiz Sonasath <m-sonasath@ti.com>
  * Couple of fixes, DT and MFD adaptation:
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index fce4657e9486..457027d07f05 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -2,7 +2,7 @@
 /*
  * OMAP4 Bandgap temperature sensor driver
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  * Contact:
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  */
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 85776db4bf34..9121d28325a8 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -2,7 +2,7 @@
 /*
  * OMAP thermal driver interface
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  * Contact:
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  */
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal.h b/drivers/thermal/ti-soc-thermal/ti-thermal.h
index c388ecf31834..7fb1e56a8333 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal.h
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal.h
@@ -2,7 +2,7 @@
 /*
  * OMAP thermal definitions
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  * Contact:
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  */
-- 
2.27.0

