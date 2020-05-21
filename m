Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8040B1DC715
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 08:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgEUGiH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 02:38:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:49847 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgEUGiH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 May 2020 02:38:07 -0400
IronPort-SDR: tYzyi1S8JT97WUgWKih/aF1tqw0DZzTEWfE3ECHa/zyVHkjELCf6O3MqsuZRcXlmCJfyCPXhaI
 RtHLwVtmVNfw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 23:38:07 -0700
IronPort-SDR: ibIuoUEK0Ft4Cirp2ID2FA8i4K1a/KActYX0MBgGfbZIiFH92bQcHDHpMn7/z4jR5QHrJHvdQe
 UHSj3dpSrVlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="253890784"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.108])
  by fmsmga007.fm.intel.com with ESMTP; 20 May 2020 23:38:05 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, srinivas.pandruvada@linux.intel.com,
        sumeet.r.pawnikar@intel.com
Subject: [PATCH] powercap: remove unused local MSR define
Date:   Thu, 21 May 2020 12:14:26 +0530
Message-Id: <1590043466-11325-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unused PLATFORM_POWER_LIMIT MSR local definition from file
intel_rapl_common.c. This was missed while splitting old RAPL code
intel_rapl.c file into two new files intel_rapl_msr.c and
intel_rapl_common.c as per the commit 3382388d7148
("intel_rapl: abstract RAPL common code"). Currently, this #define
entry is being used only in intel_rapl_msr.c file and local definition
present in this file.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/powercap/intel_rapl_common.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index eb328655bc01..5527a7c76309 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -26,9 +26,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
-/* Local defines */
-#define MSR_PLATFORM_POWER_LIMIT	0x0000065C
-
 /* bitmasks for RAPL MSRs, used by primitive access functions */
 #define ENERGY_STATUS_MASK      0xffffffff
 
-- 
1.7.9.5

