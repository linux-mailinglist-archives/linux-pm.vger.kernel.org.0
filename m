Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD91171F20B
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjFASbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjFASar (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 14:30:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFF71B6
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685644246; x=1717180246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1Jor66igQKrXAvCg2YBr0y0//OW9WNCJBVHPvJAG7E=;
  b=O0dy3hsZ5RijWCS3wFRasbhD+mlvc0XEbA4tao8ZcBszc51juLRik/gv
   a8hq6mM4YGsTEmCQmtxGz4KUcODedoNVA7OeKusZnXs9gqI4+tYKQwGQ8
   B5uF+5hIXEzUNoj3Ro68vx08AzGw06kE9QnRV1h4bGHGw/hGrXTgVxIup
   T5uoDvZss5TkSCX5+rV323HYMi/w9ZKDJK3O9q5cC29XGlQOApeR8rd3B
   RKV29sNNkFNQviHsz+n/OUAY0VEoDP1XRod570VfQ3kih7v615My9vaKr
   XAPs4f5NdFfSVjp6p+hP6GbXmqzIwshu8LybiBh/PUrq9R5vW3WB3Brer
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383921638"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383921638"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657900919"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657900919"
Received: from arjan-box.jf.intel.com ([10.54.74.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:28:20 -0700
From:   arjan@linux.intel.com
To:     linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rafael@kernel.org,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 4/7] intel_idle: Add helper functions to support 'hlt' as idle state
Date:   Thu,  1 Jun 2023 18:27:58 +0000
Message-Id: <20230601182801.2622044-5-arjan@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601182801.2622044-1-arjan@linux.intel.com>
References: <20230601182801.2622044-1-arjan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan.van.de.ven@intel.com>

Currently the intel_idle driver has a family of functions called
intel_idle/intel_idle_irq/intel_idle_xsave/... that use the
mwait instruction to enter into a low power state.

x86 cpus can also use the legacy "hlt" instruction for this,
and in some cases (VM guests for example) the mwait instruction
might not be available.

Because of this, add the basic helpers to allow 'hlt' to be used to enter
a low power state (will be used in later patches), both in the
regular and the _irq enabled variant.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/idle/intel_idle.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8415965372c7..66d262fd267e 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -199,6 +199,43 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
 	return __intel_idle(dev, drv, index);
 }
 
+static __always_inline int __intel_idle_hlt(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
+{
+	raw_safe_halt();
+	raw_local_irq_disable();
+	return index;
+}
+
+/**
+ * intel_idle_hlt - Ask the processor to enter the given idle state using hlt.
+ * @dev: cpuidle device of the target CPU.
+ * @drv: cpuidle driver (assumed to point to intel_idle_driver).
+ * @index: Target idle state index.
+ *
+ * Use the HLT instruction to notify the processor that the CPU represented by
+ * @dev is idle and it can try to enter the idle state corresponding to @index.
+ *
+ * Must be called under local_irq_disable().
+ */
+static __cpuidle int intel_idle_hlt(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
+{
+	return __intel_idle_hlt(dev, drv, index);
+}
+
+static __cpuidle int intel_idle_hlt_irq(struct cpuidle_device *dev,
+                                   struct cpuidle_driver *drv, int index)
+{
+       int ret;
+
+       raw_local_irq_enable();
+       ret = __intel_idle_hlt(dev, drv, index);
+       raw_local_irq_disable();
+
+       return ret;
+}
+
 /**
  * intel_idle_s2idle - Ask the processor to enter the given idle state.
  * @dev: cpuidle device of the target CPU.
-- 
2.40.1

