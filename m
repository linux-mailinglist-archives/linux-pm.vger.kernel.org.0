Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D370F195FC2
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 21:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgC0UaX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 16:30:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:51291 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgC0UaX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 16:30:23 -0400
IronPort-SDR: jl4H+99Y0Bz5VfCL4MWl8dmxy/DMvnBe3TSqSgwfWRNXTBneDiiOUX/oEffM4ONe2OJHDmjQio
 tBaVSc6WzKeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 13:30:22 -0700
IronPort-SDR: gjhrgaRikKuLGoRzuJ9UaElWS0LV9pvmGcVha6M6+TR3bU/xjcqEMa7TdBQZXP88kGb5biaEp6
 ihEToXScSNGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="358592663"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2020 13:30:22 -0700
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
Subject: [PATCH v1 2/3] platform/x86: intel-hid: fix: Update Tiger Lake ACPI device ID
Date:   Fri, 27 Mar 2020 13:24:53 -0700
Message-Id: <76d9ea413ccd72fd080fc3bf60aa02e3556d5e70.1585335927.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585335927.git.gayatri.kammela@intel.com>
References: <cover.1585335927.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1585335927.git.gayatri.kammela@intel.com>
References: <cover.1585335927.git.gayatri.kammela@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tiger Lake's new unique ACPI device IDs for intel-hid driver is not
valid because of missing 'C' in the ID. Fix the ID by updating it.

After the update, the new ID should now look like
INT1051 --> INTC1051

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 43d590250228..c0a4696803eb 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -19,7 +19,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alex Hung");
 
 static const struct acpi_device_id intel_hid_ids[] = {
-	{"INT1051", 0},
+	{"INTC1051", 0},
 	{"INT33D5", 0},
 	{"", 0},
 };
-- 
2.17.1

