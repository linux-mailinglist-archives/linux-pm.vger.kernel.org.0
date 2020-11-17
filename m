Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6D2B6F42
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 20:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgKQTsU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 14:48:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:52925 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgKQTsU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 14:48:20 -0500
IronPort-SDR: iFEGiG2lFdBbxLrib+0VoTEDL18Y5l2dNKOCksGCTUE5eUjeWBe/nZAkqG3NtGCAuLNGFfnqSA
 6FEGMqd2Yn9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="189059962"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="189059962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:48:14 -0800
IronPort-SDR: uK2aDNABIkYVgWjxiZ7a31Em1YrqeOxpE6X8G9o9d5vYHpuVUdGevKZeD2U39F5Oxl2snQFaeW
 3Fz9xC97YIhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="356728752"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2020 11:48:14 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: Support Alder Lake
Date:   Tue, 17 Nov 2020 11:48:02 -0800
Message-Id: <20201117194802.503337-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add ACPI IDs for thermal drivers for Alder Lake support.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 0966551cbaaa..823354a1a91a 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -584,6 +584,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 static const struct acpi_device_id int3400_thermal_match[] = {
 	{"INT3400", 0},
 	{"INTC1040", 0},
+	{"INTC1041", 0},
 	{}
 };
 
diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index ec1d58c4ceaa..c3c4c4d34542 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -284,6 +284,7 @@ static int int3403_remove(struct platform_device *pdev)
 static const struct acpi_device_id int3403_device_ids[] = {
 	{"INT3403", 0},
 	{"INTC1043", 0},
+	{"INTC1046", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
-- 
2.25.4

