Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7B52D631
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbiESOfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiESOfB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 10:35:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B2079398
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652970900; x=1684506900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=grVHVfnQcCkY5NNHHusPqfHhqogqTiQtd6RoR7OdIBc=;
  b=FazwNPB91SPYzkENZvl0JLdKCCr8vjkhpcpXAN9859ru3OYIjX0y8rOg
   KI5SenwFryVnYW3vA4sjv3O7OpKtKOZk41f3JPq5vGggstZDylCwAA3lo
   Wsn4ZJZPNtjiVMm1zY0vWJIeGcW97Tmrs+h2AD1cpTnMJiTdMox3bzPUo
   /4FInH0+MflZ9inXOc9P9aPM1i7L/XebCJo6OeygexJfgS7hCFWFI8z1E
   aSIusKT2aAgY3hTa1lTajljF0u8+UBJfikbySTX7vVucOaRa6VR1MT8Jf
   /cAAq8XWT6qyLb73t1V+PmuPlEXXm4u4cNCY2+lkmOO7ka1Klbx/apXlq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259804229"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259804229"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 07:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="570244553"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2022 07:34:59 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH V2 3/4] thermal: intel: pch: enhance overheat handling
Date:   Thu, 19 May 2022 22:35:07 +0800
Message-Id: <20220519143508.3803894-4-rui.zhang@intel.com>
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

Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
temperature above threshold") introduces delay loop mechanism that allows
PCH temperature to go down below threshold during suspend so it won't
block S0ix. And the default overall delay timeout is 1 second.

However, in practice, we found that the time it takes to cool the PCH down
below threshold highly depends on the initial PCH temperature when the
delay starts, as well as the ambient temperature.
And in some cases, the 1 second delay is not sufficient. As a result, the
system stays in a shallower power state like PCx instead of S0ix, and
drains the battery power, without user' notice.

To make sure S0ix is not blocked by the PCH overheating, we
1. expand the default overall timeout to 60 seconds.
2. make sure the temperature is below threshold rather than equal to it.

At the same time, as the cooling delay can be much longer and many wakeup
events (ACPI Power Button press, USB mouse move, etc) becomes valid in the
suspend_noirq phase, add detection of wakeup event so that the driver
does not delay blindly when the system suspend is likely to abort soon.

This patch may introduce longer suspend time, but only in the cases when
the system overheats and Linux used to enter a shallower S2idle state,
say, PCx instead of S0ix.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index c0f651b5905d..b7b32e2f5ae2 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -70,8 +70,8 @@ static unsigned int delay_timeout = 100;
 module_param(delay_timeout, int, 0644);
 MODULE_PARM_DESC(delay_timeout, "amount of time delay for each iteration.");
 
-/* Number of iterations for cooling delay, 10 counts by default for now */
-static unsigned int delay_cnt = 10;
+/* Number of iterations for cooling delay, 600 counts by default for now */
+static unsigned int delay_cnt = 600;
 module_param(delay_cnt, int, 0644);
 MODULE_PARM_DESC(delay_cnt, "total number of iterations for time delay.");
 
@@ -197,7 +197,7 @@ static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 {
 	u8 tsel;
-	u8 pch_delay_cnt = 1;
+	int pch_delay_cnt = 1;
 	u16 pch_thr_temp, pch_cur_temp;
 
 	/* Shutdown the thermal sensor if it is not enabled by BIOS */
@@ -234,7 +234,10 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 	 * which helps to indentify the reason why S0ix entry was rejected.
 	 */
 	while (pch_delay_cnt <= delay_cnt) {
-		if (pch_cur_temp <= pch_thr_temp)
+		if (pch_cur_temp < pch_thr_temp)
+			break;
+
+		if (pm_wakeup_pending())
 			break;
 
 		dev_warn(&ptd->pdev->dev,
@@ -246,7 +249,7 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 		pch_delay_cnt++;
 	}
 
-	if (pch_cur_temp > pch_thr_temp)
+	if (pch_cur_temp >= pch_thr_temp)
 		dev_warn(&ptd->pdev->dev,
 			"CPU-PCH is hot [%dC] even after delay, continue to suspend. S0ix might fail\n",
 			pch_cur_temp);
-- 
2.17.1

