Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DA765B93
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jul 2023 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjG0SrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jul 2023 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjG0SrH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2023 14:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE85430D4
        for <linux-pm@vger.kernel.org>; Thu, 27 Jul 2023 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690483581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a86H4y4z8KX0kr9JT7xslzvC5qr9VS6pS7JR1Mg/VpQ=;
        b=OEKUCFLQk7Dh6GhDnZyDXMbLDpzaV0w7rEB8bU7we001WN7YwYjq4nAo2HLbMxR30OQ8WA
        BwGoVxlAD2yV/acQY0Z8VZeM5tqSAXtbfD5IfG0Q/0Yr7xohcbak6IdLz7lOsqeeDf2Kbu
        6cF47LVaCXKfPWeMJDtAn1/miFIxCjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-mjyQeE1zOLGs7AetcTKNHA-1; Thu, 27 Jul 2023 14:46:17 -0400
X-MC-Unique: mjyQeE1zOLGs7AetcTKNHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04B9888D518;
        Thu, 27 Jul 2023 18:46:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 371AFC57964;
        Thu, 27 Jul 2023 18:46:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 1/4] x86/speculation: Add __update_spec_ctrl() helper
Date:   Thu, 27 Jul 2023 14:45:57 -0400
Message-Id: <20230727184600.26768-2-longman@redhat.com>
In-Reply-To: <20230727184600.26768-1-longman@redhat.com>
References: <20230727184600.26768-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a new __update_spec_ctrl() helper which is a variant of
update_spec_ctrl() that can be used in a noinstr function.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/include/asm/spec-ctrl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index cb0386fc4dc3..d03408e0468a 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -4,6 +4,7 @@
 
 #include <linux/thread_info.h>
 #include <asm/nospec-branch.h>
+#include <asm/msr.h>
 
 /*
  * On VMENTER we must preserve whatever view of the SPEC_CTRL MSR
@@ -76,6 +77,16 @@ static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
 }
 
+/*
+ * This can be used in noinstr function & should only be called in bare
+ * metal context.
+ */
+static __always_inline void __update_spec_ctrl(u64 val)
+{
+	__this_cpu_write(x86_spec_ctrl_current, val);
+	native_wrmsrl(MSR_IA32_SPEC_CTRL, val);
+}
+
 #ifdef CONFIG_SMP
 extern void speculative_store_bypass_ht_init(void);
 #else
-- 
2.31.1

