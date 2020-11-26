Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001AB2C5A67
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404322AbgKZRSj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:18:39 -0500
Received: from mga01.intel.com ([192.55.52.88]:50836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404301AbgKZRSj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 12:18:39 -0500
IronPort-SDR: XXluIQGGS9fgnqrkmHdIUzwI2XNkLhkzA9ATBN/EHeg1oM2kWGJnHDYK5FWKAPE6EXmoCMJnJR
 rFprTO7v2ulw==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="190462920"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="190462920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 09:18:36 -0800
IronPort-SDR: agqtmU8XYSddHa6r2+CRbg7yhLAbhd8ZMs/JlDF57ZNIJpxfKtLY5Xu089dTvbsGGF7WdhCIRx
 qOMQHLVWKNxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="313450927"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2020 09:18:36 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] thermal: int340x: processor_thermal: Add AlderLake PCI device id
Date:   Thu, 26 Nov 2020 09:18:27 -0800
Message-Id: <20201126171829.945969-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201126171829.945969-1-srinivas.pandruvada@linux.intel.com>
References: <20201126171829.945969-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added AlderLake PCI device id to support processor thermal driver. Reuse
the feature set (just includes RAPL) from previous generations.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 5b8dc5e9ec86..589ac7deec02 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -566,6 +566,7 @@ static int proc_thermal_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(proc_thermal_pm, NULL, proc_thermal_resume);
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL) },
 	{ PCI_DEVICE_DATA(INTEL, BDW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BSW_THERMAL, 0) },
 	{ PCI_DEVICE_DATA(INTEL, BXT0_THERMAL, 0) },
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index e20d142a55b4..45214571e00d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -9,6 +9,7 @@
 
 #include <linux/intel_rapl.h>
 
+#define PCI_DEVICE_ID_INTEL_ADL_THERMAL	0x461d
 #define PCI_DEVICE_ID_INTEL_BDW_THERMAL	0x1603
 #define PCI_DEVICE_ID_INTEL_BSW_THERMAL	0x22DC
 
-- 
2.25.4

