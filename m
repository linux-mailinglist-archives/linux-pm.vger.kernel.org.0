Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6476F14E
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jul 2019 04:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfGUCtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Jul 2019 22:49:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:50076 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfGUCtt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Jul 2019 22:49:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2019 19:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,289,1559545200"; 
   d="scan'208";a="344080452"
Received: from jiajial1-mobl1.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.255.30.115])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2019 19:49:47 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com, kenny@panix.com
Subject: [PATCH] powercap: adjust init order
Date:   Sun, 21 Jul 2019 10:49:44 +0800
Message-Id: <1563677384-20163-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MMIO RAPL interface driver depends on both powercap subsystem and
the intel_rapl_common code.
But when all of them are built in, the MMIO RAPL interface driver is
loaded before the later two and this breaks the system during boot.
This is because the powercap sysfs class is not registered and the
rapl_defaults ops is not set when built-in MMIO RAPL interface driver
gets loaded.

Fix this by adjusting the init order of powercap subsystem and the
intel_rapl_common code, so that their init functions are executed before
MMIO RAPL interface driver in any case.

Fixes: 555c45fe0d04 ("int340X/processor_thermal_device: add support for MMIO RAPL")
Reported-and-tested-by: Kenneth R. Crudup <kenny@panix.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 drivers/powercap/powercap_sys.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 9fd6dd3..6df4818 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1454,7 +1454,7 @@ static void __exit rapl_exit(void)
 	unregister_pm_notifier(&rapl_pm_notifier);
 }
 
-module_init(rapl_init);
+fs_initcall(rapl_init);
 module_exit(rapl_exit);
 
 MODULE_DESCRIPTION("Intel Runtime Average Power Limit (RAPL) common code");
diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 540e8aa..f808c5f 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -671,7 +671,7 @@ static int __init powercap_init(void)
 	return class_register(&powercap_class);
 }
 
-device_initcall(powercap_init);
+fs_initcall(powercap_init);
 
 MODULE_DESCRIPTION("PowerCap sysfs Driver");
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
-- 
2.7.4

