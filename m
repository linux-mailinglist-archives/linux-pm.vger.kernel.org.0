Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D494D6ABF95
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 13:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCFMeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 07:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCFMeY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 07:34:24 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B4118B27
        for <linux-pm@vger.kernel.org>; Mon,  6 Mar 2023 04:34:23 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="398123474"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="398123474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 04:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="706422148"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="706422148"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga008.jf.intel.com with ESMTP; 06 Mar 2023 04:34:22 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 2/3] x86/umwait: Increase tpause and umwait quanta
Date:   Mon,  6 Mar 2023 14:34:17 +0200
Message-Id: <20230306123418.720679-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230306123418.720679-1-dedekind1@gmail.com>
References: <20230306123418.720679-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

== Background ==

The 'umwait' and 'tpause' instructions both put the CPU in a low power
state while they wait.  They amount of time they wait is influenced by
an explicit deadline value passed in a register and an implicit value
written to an shared MSR (MSR_IA32_UMWAIT_CONTROL).

Existing 'tpause' users (udelay()) can tolerate a wide range of
MSR_IA32_UMWAIT_CONTROL MSR values.  The explicit deadline trumps the
MSR for short delays.  Longer delays will see extra wakeups, but no
functional issues.

== Problem ==

Extra wakeups mean extra power.  That translates into worse idle power
when 'umwait' gets used for idle.

== Solution ==

Increase MSR_IA32_UMWAIT_CONTROL by factor of 100 to decrease idle power
when using 'umwait'.  Make 'tpause' rely on its explicit deadline more
often and reduce the number of wakeups and save power during long delays.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/x86/kernel/cpu/umwait.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index ec8064c0ae03..17c23173da0f 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -14,9 +14,9 @@
 
 /*
  * Cache IA32_UMWAIT_CONTROL MSR. This is a systemwide control. By default,
- * umwait max time is 100000 in TSC-quanta and C0.2 is enabled
+ * umwait max time is 10,000,000 in TSC-quanta and C0.2 is enabled.
  */
-static u32 umwait_control_cached = UMWAIT_CTRL_VAL(100000, UMWAIT_C02_ENABLE);
+static u32 umwait_control_cached = UMWAIT_CTRL_VAL(10000000, UMWAIT_C02_ENABLE);
 
 /*
  * Cache the original IA32_UMWAIT_CONTROL MSR value which is configured by
-- 
2.38.1

