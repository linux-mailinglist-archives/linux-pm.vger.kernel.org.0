Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47C72AE20
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jun 2023 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjFJSfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jun 2023 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjFJSf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jun 2023 14:35:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C00130ED
        for <linux-pm@vger.kernel.org>; Sat, 10 Jun 2023 11:35:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="356683690"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="356683690"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 11:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688116115"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="688116115"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2023 11:35:21 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH v3 1/2] x86/mwait: Add support for idle via umwait
Date:   Sat, 10 Jun 2023 21:35:17 +0300
Message-Id: <20230610183518.4061159-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610183518.4061159-1-dedekind1@gmail.com>
References: <20230610183518.4061159-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

On Intel platforms, C-states are requested using the 'monitor/mwait'
instructions pair, as implemented in 'mwait_idle_with_hints()'. This
mechanism allows for entering C1 and deeper C-states.

Sapphire Rapids Xeon supports new idle states - C0.1 and C0.2 (later C0.x).
These idle states have lower latency comparing to C1, and can be requested
with either 'tpause' and 'umwait' instructions.

Linux already uses the 'tpause' instruction in delay functions like
'udelay()'. This patch adds 'umwait' and 'umonitor' instructions support.

'umwait' and 'tpause' instructions are very similar - both send the CPU to
C0.x and have the same break out rules. But unlike 'tpause', 'umwait' works
together with 'umonitor' and exits the C0.x when the monitored memory
address is modified (similar idea as with 'monitor/mwait').

This patch implements the 'umwait_idle()' function, which works very
similarly to existing 'mwait_idle_with_hints()', but requests C0.x. The
intention is to use it from the 'intel_idle' driver.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/x86/include/asm/mwait.h | 65 ++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..681c281eeaa7 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -141,4 +141,69 @@ static inline void __tpause(u32 ecx, u32 edx, u32 eax)
 	#endif
 }
 
+#ifdef CONFIG_X86_64
+/*
+ * Monitor a memory address at 'rcx' using the 'umonitor' instruction.
+ */
+static inline void __umonitor(const void *rcx)
+{
+	/* "umonitor %rcx" */
+#ifdef CONFIG_AS_TPAUSE
+	asm volatile("umonitor %%rcx\n"
+		     :
+		     : "c"(rcx));
+#else
+	asm volatile(".byte 0xf3, 0x0f, 0xae, 0xf1\t\n"
+		     :
+		     : "c"(rcx));
+#endif
+}
+
+/*
+ * Same as '__tpause()', but uses the 'umwait' instruction. It is very
+ * similar to 'tpause', but also breaks out if the data at the address
+ * monitored with 'umonitor' is modified.
+ */
+static inline void __umwait(u32 ecx, u32 edx, u32 eax)
+{
+	/* "umwait %ecx, %edx, %eax;" */
+#ifdef CONFIG_AS_TPAUSE
+	asm volatile("umwait %%ecx\n"
+		     :
+		     : "c"(ecx), "d"(edx), "a"(eax));
+#else
+	asm volatile(".byte 0xf2, 0x0f, 0xae, 0xf1\t\n"
+		     :
+		     : "c"(ecx), "d"(edx), "a"(eax));
+#endif
+}
+
+/*
+ * Enter C0.1 or C0.2 state and stay there until an event happens (an interrupt
+ * or the 'need_resched()'), the explicit deadline is reached, or the implicit
+ * global limit is reached.
+ *
+ * The deadline is the absolute TSC value to exit the idle state at. If it
+ * exceeds the global limit in the 'IA32_UMWAIT_CONTROL' register, the global
+ * limit prevails, and the idle state is exited earlier than the deadline.
+ */
+static inline void umwait_idle(u64 deadline, u32 state)
+{
+	if (!current_set_polling_and_test()) {
+		u32 eax, edx;
+
+		eax = lower_32_bits(deadline);
+		edx = upper_32_bits(deadline);
+
+		__umonitor(&current_thread_info()->flags);
+		if (!need_resched())
+			__umwait(state, edx, eax);
+	}
+	current_clr_polling();
+}
+#else
+#define umwait_idle(deadline, state) \
+		WARN_ONCE(1, "umwait CPU instruction is not supported")
+#endif /* CONFIG_X86_64 */
+
 #endif /* _ASM_X86_MWAIT_H */
-- 
2.40.1

