Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3E7232E3F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 10:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgG3ISo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 04:18:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:20059 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbgG3ISn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jul 2020 04:18:43 -0400
IronPort-SDR: B1etKWDcpeaKtSExcsu6koGiIJtr4/CCePNTsRNXrLVUNgIqLhpJTIvPAHApXEaf1GsDgguif2
 M4apBEynD8Jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="236423480"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="236423480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 01:18:42 -0700
IronPort-SDR: jT1YwYmjCO6/8hTme+5T0L3vRl94aFnGf3RgGPCm+PguQT6V7guNehPyrRwKo3NF0ZwE8lBKaz
 S0V1eJl1hpYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="491051305"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.108])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2020 01:18:40 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Subject: [PATCH] thermal: intel: intel_pch_thermal: Add Cannon Lake Low Power PCH support
Date:   Thu, 30 Jul 2020 13:55:03 +0530
Message-Id: <1596097503-27924-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add LP (Low Power) PCH id for Cannon Lake (CNL) based platforms.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 56401fd4708d..7ed66927d822 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -24,6 +24,7 @@
 #define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100 series */
 #define PCH_THERMAL_DID_CNL	0x9Df9 /* CNL PCH */
 #define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
+#define PCH_THERMAL_DID_CNL_LP	0x02F9 /* CNL-LP PCH */
 #define PCH_THERMAL_DID_CML_H	0X06F9 /* CML-H PCH */
 
 /* Wildcat Point-LP  PCH Thermal registers */
@@ -405,6 +406,8 @@ static int intel_pch_thermal_resume(struct device *device)
 		.driver_data = board_cnl, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),
 		.driver_data = board_cnl, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_LP),
+		.driver_data = board_cnl, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CML_H),
 		.driver_data = board_cml, },
 	{ 0, },
-- 
1.7.9.5

