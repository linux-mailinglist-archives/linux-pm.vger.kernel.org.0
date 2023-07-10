Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBA74D18B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGJJdW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 05:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjGJJdC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 05:33:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2926BD
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 02:31:34 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="344624695"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344624695"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865281487"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865281487"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 02:31:03 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 1/4] x86/umwait: use 'IS_ENABLED()'
Date:   Mon, 10 Jul 2023 12:30:57 +0300
Message-Id: <20230710093100.918337-2-dedekind1@gmail.com>
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

Both kernel coding style and x86 maintainers prefer using 'IS_ENABLED()'
instead of '#ifdef' whenever possible.

Switch '__tpause()' to 'IS_ENABLED()'.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/x86/include/asm/mwait.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..03bef2bc28d4 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -130,15 +130,15 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
 static inline void __tpause(u32 ecx, u32 edx, u32 eax)
 {
 	/* "tpause %ecx, %edx, %eax;" */
-	#ifdef CONFIG_AS_TPAUSE
-	asm volatile("tpause %%ecx\n"
-		     :
-		     : "c"(ecx), "d"(edx), "a"(eax));
-	#else
-	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
-		     :
-		     : "c"(ecx), "d"(edx), "a"(eax));
-	#endif
+	if (IS_ENABLED(CONFIG_AS_TPAUSE)) {
+		asm volatile("tpause %%ecx\n"
+			     :
+			     : "c"(ecx), "d"(edx), "a"(eax));
+	} else {
+		asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
+			     :
+			     : "c"(ecx), "d"(edx), "a"(eax));
+	}
 }
 
 #endif /* _ASM_X86_MWAIT_H */
-- 
2.40.1

