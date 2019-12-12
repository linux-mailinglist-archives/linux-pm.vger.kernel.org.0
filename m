Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29F811D7E5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 21:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfLLUa2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 15:30:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:4904 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730731AbfLLUa1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Dec 2019 15:30:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 12:30:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208";a="245866864"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2019 12:30:27 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Swaminathan, Nivedita" <nivedita.swaminathan@intel.com>,
        Swaminathan@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: processor_thermal: Add Jasper Lake support
Date:   Thu, 12 Dec 2019 12:30:25 -0800
Message-Id: <20191212203025.36310-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Swaminathan, Nivedita" <nivedita.swaminathan@intel.com>

Added new PCI id for Jasper Lake processor thermal device.

Signed-off-by: Swaminathan, Nivedita <nivedita.swaminathan@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.c  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 89a015387283..b1fd34516e28 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -42,6 +42,9 @@
 /* IceLake thermal reporting device */
 #define PCI_DEVICE_ID_PROC_ICL_THERMAL	0x8a03
 
+/* JasperLake thermal reporting device */
+#define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4503
+
 #define DRV_NAME "proc_thermal"
 
 struct power_config {
@@ -724,6 +727,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_GLK_THERMAL)},
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_ICL_THERMAL),
 		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_JSL_THERMAL)},
 	{ 0, },
 };
 
-- 
2.17.2

