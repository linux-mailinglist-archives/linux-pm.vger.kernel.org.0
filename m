Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FDA174967
	for <lists+linux-pm@lfdr.de>; Sat, 29 Feb 2020 21:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgB2Ure (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Feb 2020 15:47:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44127 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2Ure (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Feb 2020 15:47:34 -0500
Received: by mail-lf1-f68.google.com with SMTP id 7so4690231lfz.11
        for <linux-pm@vger.kernel.org>; Sat, 29 Feb 2020 12:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77yAkILi0z+2XYkMGpGropVZLKBtHqtDJgfn0DzU2/M=;
        b=HhgTz73tibkpsZ+aXgzqTkZK4O7sdWljU1++J00M1yEPywqNEeTlDV+xrCFKDYPgo0
         5CRWgxPs+acaZFk/MDAd65HY4DTSv9ttPMGWsEmKw1Su/Lotiz9YDV8cfoCzW1UY2CNT
         Ci/CgGV3JCYEfYzE3XslRVVEl8BTIyKAuEUNeYhRbM6tufNWj9EGKHE59FS6FnZp45WU
         JRxiofW9Cgd61l6ZPNwcB7IIq+haLgY06lNzIWAAM+uJjhL45cn/Y0ejKYuaxFVci2rv
         FlAtUhY+AOOIOdPNS9pcduf6XZkrCjtz/4y+p4xyz1CSMoTUOx/29ycVG2l3RmVsOf1s
         nWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77yAkILi0z+2XYkMGpGropVZLKBtHqtDJgfn0DzU2/M=;
        b=S9VesikOKnjr37YiQox3PmbnEsLcwunGmFsTO8Y7ppzsWgi8/CpC3WTXqpDLcSVX6l
         j/s8TPTiYvnO5xapVttB1kB4GVR+9MSsYQdtoA1i7NvQuVYqBlANARYyMc3C9MxcrZuZ
         Lpu7aGO/YaGldhQW20nKA7AFX5LtJaBSf6jb4WcaAal5TiglaMoFc1RCTdougXMUL8H6
         QhNTprN+mWmnrLZOIUmFqqMkDxpGO232BeucSNKGawegr39geelkUMRiW+iVcnTdhZBK
         /qlofvlPQRQKK2pXn9l/A9rXyLaKo/4aGEP7f4MJKgNh4HYAo5FEDrSbbx1JX/Gxehdh
         LAcQ==
X-Gm-Message-State: ANhLgQ0HIftF9ojX9b6xC2QOv4ROqUn9I0L7lQLHseSLtXvdQ000CGLK
        ImpB8AvrZxnEAsLnGMmA9gCcEw==
X-Google-Smtp-Source: ADFU+vvxOMrLE7UWc4U3sOBjnDpIeT0PYDzHTREPFV2scLdct95ot/Vnpu3+gjhoqT4JmATJ8gbLaQ==
X-Received: by 2002:a19:8c4d:: with SMTP id i13mr6100887lfj.42.1583009252289;
        Sat, 29 Feb 2020 12:47:32 -0800 (PST)
Received: from localhost.localdomain (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id r25sm8524026lfn.36.2020.02.29.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 12:47:31 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] thermal: Rephrase the Kconfig text for thermal
Date:   Sat, 29 Feb 2020 21:45:27 +0100
Message-Id: <20200229204527.143796-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal subsystem may have relied on sysfs in 2008 when it
was introduced, but these days the thermal zones will more often
than not come from the hardware descriptions and not from sysfs.

Drop the "Generic" phrases as well: there are no non-generic
drivers that I know of, the thermal framework is by definition
generic.

Reword a bit and fix some grammar.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/thermal/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 5a05db5438d6..a88aa0f6c5a8 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -1,17 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Generic thermal sysfs drivers configuration
+# Generic thermal drivers configuration
 #
 
 menuconfig THERMAL
-	bool "Generic Thermal sysfs driver"
+	bool "Thermal drivers"
 	help
-	  Generic Thermal Sysfs driver offers a generic mechanism for
+	  Thermal drivers offers a generic mechanism for
 	  thermal management. Usually it's made up of one or more thermal
-	  zone and cooling device.
+	  zones and cooling devices.
 	  Each thermal zone contains its own temperature, trip points,
-	  cooling devices.
-	  All platforms with ACPI thermal support can use this driver.
+	  and cooling devices.
+	  All platforms with ACPI or Open Firmware thermal support can use
+	  this driver.
 	  If you want this support, you should say Y here.
 
 if THERMAL
-- 
2.24.1

