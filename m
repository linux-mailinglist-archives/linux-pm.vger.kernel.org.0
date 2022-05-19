Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607252D630
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 16:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbiESOfA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiESOe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 10:34:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F262F79398
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652970898; x=1684506898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tmNxs/F3ojtRb9sOqI1KH8epaDv6aemsd0izOCkyu8E=;
  b=czi8Wk0ykNnDTMDbilKXdKOzk+ftp+inW4QjZeGDD744yrntuGAOGxcp
   m0K7wKMyp/6oPNvJHQoK+dJJhQ9w7Lh5xzT8TmsBOaRQYB7PSBuZSIv7w
   hAnRRywiWkl6F3bCVVyXMdjAw4hVbwxWpA0gnkr8pD/rg/p37/YyUZxqn
   8oJqzcghUGF9eqaZPeMbbhNQQmpwJIc94ZmKAU0jnMHF8gLT0KY7zCMjl
   M18MziyMgw8dDXS4uQbCazc/w64wD0y127Rd0mBFl8deFOW5nm8eIS9Ge
   f5rK6T35G0vYVuy0r9BkzKSBgueXBWZV1l/DAjOuBJu1N3fz9L12pyPPq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259804223"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259804223"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 07:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="570244538"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2022 07:34:57 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH V2 2/4] thermal: intel: pch: move cooling delay to suspend_noirq phase
Date:   Thu, 19 May 2022 22:35:06 +0800
Message-Id: <20220519143508.3803894-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220519143508.3803894-1-rui.zhang@intel.com>
References: <20220519143508.3803894-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the PCH Thermal driver suspend callback to suspend_noirq to do
cooling while the system is more quiescent.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 527c91f5960b..c0f651b5905d 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -193,6 +193,7 @@ static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 	return 0;
 }
 
+/* Cool the PCH when it's overheat in .suspend_noirq phase */
 static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 {
 	u8 tsel;
@@ -455,7 +456,7 @@ static void intel_pch_thermal_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static int intel_pch_thermal_suspend(struct device *device)
+static int intel_pch_thermal_suspend_noirq(struct device *device)
 {
 	struct pch_thermal_device *ptd = dev_get_drvdata(device);
 
@@ -495,7 +496,7 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
 
 static const struct dev_pm_ops intel_pch_pm_ops = {
-	.suspend = intel_pch_thermal_suspend,
+	.suspend_noirq = intel_pch_thermal_suspend_noirq,
 	.resume = intel_pch_thermal_resume,
 };
 
-- 
2.17.1

