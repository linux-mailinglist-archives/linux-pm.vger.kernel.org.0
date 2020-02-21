Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4DB1684E2
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBUR0W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 12:26:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:8972 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgBUR0W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 12:26:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 09:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="270058658"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.129])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2020 09:26:20 -0800
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] thermal: int340x: processor_thermal: Add Tiger Lake support
Date:   Fri, 21 Feb 2020 23:02:39 +0530
Message-Id: <1582306359-17846-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added new PCI id for Tiger Lake processor thermal device
along with MMIO RAPL support.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 .../int340x_thermal/processor_thermal_device.c     |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index b1fd345..11cab67 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -45,6 +45,9 @@
 /* JasperLake thermal reporting device */
 #define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4503
 
+/* TigerLake thermal reporting device */
+#define PCI_DEVICE_ID_PROC_TGL_THERMAL	0x9A03
+
 #define DRV_NAME "proc_thermal"
 
 struct power_config {
@@ -728,6 +731,8 @@ static int proc_thermal_resume(struct device *dev)
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_ICL_THERMAL),
 		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_JSL_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_TGL_THERMAL)},
+		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
 	{ 0, },
 };
 
-- 
1.7.9.5

