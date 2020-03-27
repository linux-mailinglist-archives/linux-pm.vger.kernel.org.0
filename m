Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DF9195FC0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 21:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC0UaV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 16:30:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:51291 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgC0UaV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 16:30:21 -0400
IronPort-SDR: v+xnDiBMRfvMr7Y1g7LshurXXI8RmYvlDEjIvX2jewc8Sxme/UCLslKjim+17wh/TOkIN2sk/w
 rJs/6i5xdXaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 13:30:21 -0700
IronPort-SDR: jbyilb4pcxxDwl1WM22OuKut3fVRJ7/FIYV2ALxNZoYucA6aOddW50+xqfy5A2gfjXFzM8SZvG
 xF1bVjIS9IHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="358592647"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2020 13:30:20 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, dvhart@infradead.org, alex.hung@canonical.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v1 1/3] ACPI: fix: Update Tiger Lake ACPI device IDs
Date:   Fri, 27 Mar 2020 13:24:52 -0700
Message-Id: <f2b887a74103500ab59c42e6082f9c52f2063e4a.1585335927.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585335927.git.gayatri.kammela@intel.com>
References: <cover.1585335927.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1585335927.git.gayatri.kammela@intel.com>
References: <cover.1585335927.git.gayatri.kammela@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tiger Lake's new unique ACPI device IDs for DPTF and fan drivers are not
valid as the IDs are missing 'C'. Fix the IDs by updating them.

After the update, the new IDs should now look like
INT1047 --> INTC1047
INT1040 --> INTC1040
INT1043 --> INTC1043
INT1044 --> INTC1044

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/acpi/device_pm.c            | 2 +-
 drivers/acpi/dptf/dptf_power.c      | 2 +-
 drivers/acpi/dptf/int340x_thermal.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index b64c62bfcea5..80dae3b3c36a 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1321,7 +1321,7 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	 */
 	static const struct acpi_device_id special_pm_ids[] = {
 		{"PNP0C0B", }, /* Generic ACPI fan */
-		{"INT1044", }, /* Fan for Tiger Lake generation */
+		{"INTC1044", }, /* Fan for Tiger Lake generation */
 		{"INT3404", }, /* Fan */
 		{}
 	};
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 387f27ef3368..e5fb34bfa52c 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -97,7 +97,7 @@ static int dptf_power_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3407_device_ids[] = {
-	{"INT1047", 0},
+	{"INTC1047", 0},
 	{"INT3407", 0},
 	{"", 0},
 };
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 1ec7b6900662..29b5c77256dd 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -13,10 +13,10 @@
 
 #define INT3401_DEVICE 0X01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
-	{"INT1040"},
-	{"INT1043"},
-	{"INT1044"},
-	{"INT1047"},
+	{"INTC1040"},
+	{"INTC1043"},
+	{"INTC1044"},
+	{"INTC1047"},
 	{"INT3400"},
 	{"INT3401", INT3401_DEVICE},
 	{"INT3402"},
-- 
2.17.1

