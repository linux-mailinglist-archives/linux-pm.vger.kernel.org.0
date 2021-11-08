Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7124D447EA7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 12:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhKHLRN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 06:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239101AbhKHLQf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 06:16:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1435D61352;
        Mon,  8 Nov 2021 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636370031;
        bh=7EkTaZzukkgs/hh3SjAaERFUDJy9rR7bOREfGZkdmGo=;
        h=From:To:Cc:Subject:Date:From;
        b=sZe99ox3hHG9riCTn6E24IZPBeSxYXz4d0ei8nxK3zy+zqEeftDNZwh1aVLg1qVsm
         4fQ/0OqckQYR78XM3MdYPV75wbIVWV6C9ipHXklbFk2j8VN3C2ZRjKTHkm+yHQ7hWe
         iGwJK/Y8zQhsMMToQYAHnFxfbKQ8T0rCefW8oCRUVpgjqPV5XcdqvHWhN+D/S/P1Ey
         d8cpHDvvpobZOopZvcuUepH8hC/hQRg/aTKW3MuAlCXCcpsRRS691vUXjpP7iyLX7E
         lisxUnKt6KqfUEW52Ek8S0u4j19oHiO9u8kJmFL03fE8IrpLdmSUCaGdROxSC6ZOek
         Wkrs5jb0xo75w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/int340x: limit Kconfig to 64-bit
Date:   Mon,  8 Nov 2021 12:13:41 +0100
Message-Id: <20211108111347.3928294-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

32-bit processors cannot generally access 64-bit MMIO registers
atomically, and it is unknown in which order the two halves of
this registers would need to be read:

drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c: In function 'send_mbox_cmd':
drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c:79:37: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
   79 |                         *cmd_resp = readq((void __iomem *) (proc_priv->mmio_base + MBOX_OFFSET_DATA));
      |                                     ^~~~~
      |                                     readl

The driver already does not build for anything other than x86,
so limit it further to x86-64.

Fixes: aeb58c860dc5 ("thermal/drivers/int340x: processor_thermal: Suppot 64 bit RFIM responses")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/intel/int340x_thermal/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 45c31f3d6054..5d046de96a5d 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -5,12 +5,12 @@
 
 config INT340X_THERMAL
 	tristate "ACPI INT340X thermal drivers"
-	depends on X86 && ACPI && PCI
+	depends on X86_64 && ACPI && PCI
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
 	select INTEL_SOC_DTS_IOSF_CORE
-	select PROC_THERMAL_MMIO_RAPL if X86_64 && POWERCAP
+	select PROC_THERMAL_MMIO_RAPL if POWERCAP
 	help
 	  Newer laptops and tablets that use ACPI may have thermal sensors and
 	  other devices with thermal control capabilities outside the core
-- 
2.29.2

