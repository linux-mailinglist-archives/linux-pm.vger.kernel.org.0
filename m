Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6023347A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgG3Obb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 10:31:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35914 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgG3Oba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 10:31:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UEVT0C108946;
        Thu, 30 Jul 2020 09:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596119489;
        bh=pPJ6p0ZJS+oKBcH5exACrkQEeimRt+3aawEGkIsNGXU=;
        h=From:To:CC:Subject:Date;
        b=BTuZ53ROd5r1zj3jvHoWsTViaCZjhbzVj4qg+oa/rBWi0pKjM4IpJPH4OgwQMBNaf
         TSuPQy+ElTUPqmPA3dv8qOFQWTIndYqtgJBcXxDuWd75v2iqSSE99TJrLkNyXlZKKZ
         oqTcunxK7o8J18kyzlKMgKioRBDpwQXJ4N3imh30=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UEVTWL088250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 09:31:29 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 09:31:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 09:31:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UEVSdw010625;
        Thu, 30 Jul 2020 09:31:28 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] power: bq27xxx: Update to SPDX licensing
Date:   Thu, 30 Jul 2020 09:31:21 -0500
Message-ID: <20200730143122.28519-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the license to the SPDX licensing format.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c     |  9 +--------
 drivers/power/supply/bq27xxx_battery_hdq.c |  9 +--------
 drivers/power/supply/bq27xxx_battery_i2c.c | 10 +---------
 3 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index a123f6e21f08..8b112449ace8 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * BQ27xxx battery driver
  *
@@ -9,14 +10,6 @@
  *
  * Based on a previous work by Copyright (C) 2008 Texas Instruments, Inc.
  *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- *
  * Datasheets:
  * https://www.ti.com/product/bq27000
  * https://www.ti.com/product/bq27200
diff --git a/drivers/power/supply/bq27xxx_battery_hdq.c b/drivers/power/supply/bq27xxx_battery_hdq.c
index 29771967df2e..12b10dad77d3 100644
--- a/drivers/power/supply/bq27xxx_battery_hdq.c
+++ b/drivers/power/supply/bq27xxx_battery_hdq.c
@@ -1,16 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * BQ27xxx battery monitor HDQ/1-wire driver
  *
  * Copyright (C) 2007-2017 Texas Instruments Incorporated - https://www.ti.com/
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index ab02456d69e5..765873dfc495 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * BQ27xxx battery monitor I2C driver
  *
  * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/i2c.h>
-- 
2.28.0

