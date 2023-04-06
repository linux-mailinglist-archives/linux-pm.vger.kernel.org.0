Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCAA6D9B0D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 16:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbjDFOsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbjDFOrs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 10:47:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FBFA5F8
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 07:46:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pskns5wjWz4xFg;
        Fri,  7 Apr 2023 00:45:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1680792353;
        bh=PhB58uze5HlGPHSG/12cRhkZxsbgZpkZh1JDz6mWDqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PomG6mQ/2mwsj91pMOfaq7VGozCNnqo7xGd3TcNgdJaArP1yzdIS0/Bpt6jpF7Phy
         52r4c0TlQIOisgmJjwevDhaUAhTS3uKcyviEoPj1EIX3qABFLwThWqVf/bBLw5BY0a
         WXXwhxJ5widHbtL8W9pfZBjN5Iuu3Wm7HlIxQJo90wa2gfqmSkcv8IaJBMrVgnxeju
         Ihor3ePVjXDjYZPyZLoHivHAaWLcuLlerVqilNBwEtvTal+xNU0xUjKfx9zCUB4xuP
         vIr/RAxYstKjPG3hw5x59OwxvjdZgVXoD76NsCjJY9EKbdA9QqudBXv9U+0LIEKm8c
         mK5Hk2K8Sm6uQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <peterz@infradead.org>, <npiggin@gmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 4/4] powerpc/pseries: Always inline functions called from cpuidle
Date:   Fri,  7 Apr 2023 00:45:35 +1000
Message-Id: <20230406144535.3786008-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144535.3786008-1-mpe@ellerman.id.au>
References: <20230406144535.3786008-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Code in the idle path is not allowed to be instrumented because RCU is
disabled, see commit 0e985e9d2286 ("cpuidle: Add comments about
noinstr/__cpuidle usage").

Force inlining of the inline functions called from cpuidle, to ensure
they are not emitted out-of-line and then available for tracing.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/idle.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/idle.h b/arch/powerpc/include/asm/idle.h
index accd1f50085a..00f360667391 100644
--- a/arch/powerpc/include/asm/idle.h
+++ b/arch/powerpc/include/asm/idle.h
@@ -9,17 +9,17 @@ DECLARE_PER_CPU(u64, idle_spurr_cycles);
 DECLARE_PER_CPU(u64, idle_entry_purr_snap);
 DECLARE_PER_CPU(u64, idle_entry_spurr_snap);
 
-static inline void snapshot_purr_idle_entry(void)
+static __always_inline void snapshot_purr_idle_entry(void)
 {
 	*this_cpu_ptr(&idle_entry_purr_snap) = mfspr(SPRN_PURR);
 }
 
-static inline void snapshot_spurr_idle_entry(void)
+static __always_inline void snapshot_spurr_idle_entry(void)
 {
 	*this_cpu_ptr(&idle_entry_spurr_snap) = mfspr(SPRN_SPURR);
 }
 
-static inline void update_idle_purr_accounting(void)
+static __always_inline void update_idle_purr_accounting(void)
 {
 	u64 wait_cycles;
 	u64 in_purr = *this_cpu_ptr(&idle_entry_purr_snap);
@@ -29,7 +29,7 @@ static inline void update_idle_purr_accounting(void)
 	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
 }
 
-static inline void update_idle_spurr_accounting(void)
+static __always_inline void update_idle_spurr_accounting(void)
 {
 	u64 *idle_spurr_cycles_ptr = this_cpu_ptr(&idle_spurr_cycles);
 	u64 in_spurr = *this_cpu_ptr(&idle_entry_spurr_snap);
@@ -37,7 +37,7 @@ static inline void update_idle_spurr_accounting(void)
 	*idle_spurr_cycles_ptr += mfspr(SPRN_SPURR) - in_spurr;
 }
 
-static inline void pseries_idle_prolog(void)
+static __always_inline void pseries_idle_prolog(void)
 {
 	ppc64_runlatch_off();
 	snapshot_purr_idle_entry();
@@ -49,7 +49,7 @@ static inline void pseries_idle_prolog(void)
 	get_lppaca()->idle = 1;
 }
 
-static inline void pseries_idle_epilog(void)
+static __always_inline void pseries_idle_epilog(void)
 {
 	update_idle_purr_accounting();
 	update_idle_spurr_accounting();
-- 
2.39.2

