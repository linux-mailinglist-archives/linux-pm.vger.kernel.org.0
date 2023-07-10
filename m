Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B205D74D18D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjGJJdZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjGJJdD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 05:33:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E54127
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 02:31:35 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="344624705"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344624705"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865281507"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865281507"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 02:31:05 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 2/4] x86/mwait: Add support for idle via umwait
Date:   Mon, 10 Jul 2023 12:30:58 +0300
Message-Id: <20230710093100.918337-3-dedekind1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710093100.918337-1-dedekind1@gmail.com>
References: <20230710093100.918337-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,
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

Sapphire Rapids Xeon supports new idle states - C0.1 and C0.2 (later
C0.x). These idle states have lower latency comparing to C1, and can be
requested with either 'tpause' or 'umwait' instructions.

Linux kernel already supports the 'tpause' instruction and uses it in
delay functions like 'udelay()'. Add 'umwait' support by implementing
the 'umwait_idle()' function. This function is analogous to
'mwait_idle_with_hints()', but instead of requesting a C-state with
'monitor/mwait', it requests C0.x with 'umonitor/umwait'.

Tested with both gcc/binutils and clang/llvm.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/x86/include/asm/mwait.h | 67 ++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 03bef2bc28d4..48210f4d7c77 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -141,4 +141,71 @@ static inline void __tpause(u32 ecx, u32 edx, u32 eax)
 	}
 }
 
+#ifdef CONFIG_X86_64
+/*
+ * Monitor a memory address at 'rcx' using the 'umonitor' instruction.
+ */
+static __always_inline void __umonitor(const void *rcx)
+{
+	/* "umonitor %rcx" */
+	if (IS_ENABLED(CONFIG_AS_TPAUSE)) {
+		asm volatile("umonitor %%rcx\n"
+			     :
+			     : "c"(rcx));
+	} else {
+		asm volatile(".byte 0xf3, 0x0f, 0xae, 0xf1\t\n"
+			     :
+			     : "c"(rcx));
+	}
+}
+
+/*
+ * Same as '__tpause()', but uses the 'umwait' instruction. It is very
+ * similar to 'tpause', but also breaks out if the data at the address
+ * monitored with 'umonitor' is modified.
+ */
+static __always_inline void __umwait(u32 ecx, u32 edx, u32 eax)
+{
+	/* "umwait %ecx, %edx, %eax;" */
+	if (IS_ENABLED(CONFIG_AS_TPAUSE)) {
+		asm volatile("umwait %%ecx\n"
+			     :
+			     : "c"(ecx), "d"(edx), "a"(eax));
+	} else {
+		asm volatile(".byte 0xf2, 0x0f, 0xae, 0xf1\t\n"
+			     :
+			     : "c"(ecx), "d"(edx), "a"(eax));
+	}
+}
+
+/*
+ * Enter C0.1 or C0.2 state and stay there until an event happens (an interrupt
+ * or 'need_resched()'), the explicit deadline is reached, or the implicit
+ * global limit is reached.
+ *
+ * The deadline is the absolute TSC value to exit the idle state at. If it
+ * exceeds the global limit in the 'IA32_UMWAIT_CONTROL' register, the global
+ * limit prevails, and the idle state is exited earlier than the deadline.
+ */
+static __always_inline void umwait_idle(u64 deadline, u32 state)
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
+#else /* CONFIG_X86_64 */
+static __always_inline void umwait_idle(u64 deadline, u32 state)
+{
+	WARN_ONCE(1, "umwait CPU instruction is not supported");
+}
+#endif /* !CONFIG_X86_64 */
+
 #endif /* _ASM_X86_MWAIT_H */
-- 
2.40.1

