Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0250422C021
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 09:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXHqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 03:46:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:11362 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXHqF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 03:46:05 -0400
IronPort-SDR: JzdIJqygoMNZ8elYvIfNfd5i7AWHkopxuFPNNGQN1gtdoJJd8koGVPU3594nG/Qf9Y4rCav+SX
 vZkQ7znw2oIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="130747285"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="130747285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 00:46:05 -0700
IronPort-SDR: rU/Cwu5qpqN4dqJvfokhsi58VqlnL7kKTPjeY/tZFS6nozV2LMlNKswJ03we88mGhFbs+vcFKC
 cs6DEeMFv8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="311319087"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.108])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2020 00:46:03 -0700
From:   Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] thermal: int340x: processor_thermal: fix: update Jasper Lake PCI id
Date:   Fri, 24 Jul 2020 13:22:26 +0530
Message-Id: <1595577146-1221-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

Update PCI device id for Jasper Lake processor thermal device.
With this proc_thermal driver is getting loaded and processor
thermal functionality works on Jasper Lake system.

Fixes: f64a6583d3f5 ("thermal: int340x: processor_thermal: Add Jasper Lake support")
Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 .../int340x_thermal/processor_thermal_device.c     |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 297db1d2d960..81e8b15ef405 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -43,7 +43,7 @@
 #define PCI_DEVICE_ID_PROC_ICL_THERMAL	0x8a03
 
 /* JasperLake thermal reporting device */
-#define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4503
+#define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4E03
 
 /* TigerLake thermal reporting device */
 #define PCI_DEVICE_ID_PROC_TGL_THERMAL	0x9A03
-- 
1.7.9.5

