Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985F6E7D0A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjDSOkf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 10:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjDSOkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 10:40:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B4729C
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 07:40:15 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325079385"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325079385"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 07:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021232761"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="1021232761"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2023 07:39:56 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 6/7] intel_idle: do not sprinkle module parameters definitions around
Date:   Wed, 19 Apr 2023 17:39:46 +0300
Message-Id: <20230419143947.1342730-7-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230419143947.1342730-1-dedekind1@gmail.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This is a cleanup which improves code consistency. Move the 'force_irq_on'
module parameter variable and definition to the same place where we have
variables and definitions for other module parameters.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index bff0d17aeda4..9e4105b532da 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -68,6 +68,7 @@ static struct cpuidle_driver intel_idle_driver = {
 static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask;
 static unsigned int preferred_states_mask;
+static bool force_irq_on __read_mostly;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
@@ -1838,9 +1839,6 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 	return true;
 }
 
-static bool force_irq_on __read_mostly;
-module_param(force_irq_on, bool, 0444);
-
 static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
@@ -2157,3 +2155,8 @@ MODULE_PARM_DESC(states_off, "Mask of disabled idle states");
  */
 module_param_named(preferred_cstates, preferred_states_mask, uint, 0444);
 MODULE_PARM_DESC(preferred_cstates, "Mask of preferred idle states");
+/*
+ * Debugging option that forces the driver to enter all C-states with
+ * interrupts enabled.
+ */
+module_param(force_irq_on, bool, 0444);
-- 
2.38.1

