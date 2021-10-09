Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0D4278FF
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244632AbhJIKW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbhJIKWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 06:22:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4BEC061755;
        Sat,  9 Oct 2021 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1avdWCLFfnkWkJZxCtxvKNwEgLq95F/2dFoOMOk8Azo=; b=RNc+5TXOFvTNFrsxt54vB5LO2u
        Ky2GQcJ22Q/o2Ks7Jr/hZ5XbTQqPuEgy4n24QEqdHocq+mhiuXdC8SCW61NufKFJ27WErf+LRMCFu
        +lx7zpiUeLyC/K6m54G0sxe7yPsTIDtbqQZzdWZNYI8P700fZLDJ7s6jsjqKaOqZ/qO+51M+FWmZy
        rAzOoHaZ0xtUVAeQL0/I40166QvIweDCEzilM3rFeESi/OC71bvuEm0r4B21v0XflDA2LTbnWyMRL
        PBXOgYYthrIFzPLPuykGYHxEYAOnpzP5TeRb0qJ4Do2Yff6bM6MaxXrZ/LxwNbvineS2eohhE9XIq
        h4I9sPcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZ9Re-0043WL-B5; Sat, 09 Oct 2021 10:19:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 057203005B9;
        Sat,  9 Oct 2021 12:19:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DD2F22C6B0485; Sat,  9 Oct 2021 12:19:09 +0200 (CEST)
Message-ID: <20211009101444.971532166@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 09 Oct 2021 12:07:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 3/6] ptrace: Order and comment PT_flags
References: <20211009100754.690769957@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a comment to the PT_flags to indicate their actual value, this
makes it easier to see what bits are used and where there might be a
possible hole to use.

Notable PT_SEIZED was placed wrong, also PT_EVENT_FLAG() space seems
ill defined, as written is seems to be meant to cover the entire
PTRACE_O_ range offset by 3 bits, which would then be 3+[0..21],
however PT_SEIZED is in the middle of that.

XXX if at all possible, PT_SEIZED should be moved outside of this
range.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/ptrace.h      |   32 +++++++++++++++++---------------
 include/uapi/linux/ptrace.h |    3 +++
 2 files changed, 20 insertions(+), 15 deletions(-)

--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -28,30 +28,32 @@ extern int ptrace_access_vm(struct task_
  * flags.  When the a task is stopped the ptracer owns task->ptrace.
  */
 
-#define PT_SEIZED	0x00010000	/* SEIZE used, enable new behavior */
-#define PT_PTRACED	0x00000001
-#define PT_DTRACE	0x00000002	/* delayed trace (used on m68k, i386) */
+#define PT_PTRACED	0x00000001						// 0x00000001
+#define PT_DTRACE	0x00000002 /* delayed trace (used on m68k, i386) */	// 0x00000002
 
 #define PT_OPT_FLAG_SHIFT	3
 /* PT_TRACE_* event enable flags */
 #define PT_EVENT_FLAG(event)	(1 << (PT_OPT_FLAG_SHIFT + (event)))
-#define PT_TRACESYSGOOD		PT_EVENT_FLAG(0)
-#define PT_TRACE_FORK		PT_EVENT_FLAG(PTRACE_EVENT_FORK)
-#define PT_TRACE_VFORK		PT_EVENT_FLAG(PTRACE_EVENT_VFORK)
-#define PT_TRACE_CLONE		PT_EVENT_FLAG(PTRACE_EVENT_CLONE)
-#define PT_TRACE_EXEC		PT_EVENT_FLAG(PTRACE_EVENT_EXEC)
-#define PT_TRACE_VFORK_DONE	PT_EVENT_FLAG(PTRACE_EVENT_VFORK_DONE)
-#define PT_TRACE_EXIT		PT_EVENT_FLAG(PTRACE_EVENT_EXIT)
-#define PT_TRACE_SECCOMP	PT_EVENT_FLAG(PTRACE_EVENT_SECCOMP)
 
-#define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
-#define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
+#define PT_TRACESYSGOOD		PT_EVENT_FLAG(0)			        // 0x00000008
+#define PT_TRACE_FORK		PT_EVENT_FLAG(PTRACE_EVENT_FORK)	        // 0x00000010
+#define PT_TRACE_VFORK		PT_EVENT_FLAG(PTRACE_EVENT_VFORK)	        // 0x00000020
+#define PT_TRACE_CLONE		PT_EVENT_FLAG(PTRACE_EVENT_CLONE)	        // 0x00000040
+#define PT_TRACE_EXEC		PT_EVENT_FLAG(PTRACE_EVENT_EXEC)	        // 0x00000080
+#define PT_TRACE_VFORK_DONE	PT_EVENT_FLAG(PTRACE_EVENT_VFORK_DONE)	        // 0x00000100
+#define PT_TRACE_EXIT		PT_EVENT_FLAG(PTRACE_EVENT_EXIT)	        // 0x00000200
+#define PT_TRACE_SECCOMP	PT_EVENT_FLAG(PTRACE_EVENT_SECCOMP)	        // 0x00000400
+
+#define PT_SEIZED		0x00010000 /* SEIZE used, enable new behavior */// 0x00010000
+
+#define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)	// 0x00800000
+#define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT) // 0x01000000
 
 /* single stepping state bits (used on ARM and PA-RISC) */
 #define PT_SINGLESTEP_BIT	31
-#define PT_SINGLESTEP		(1<<PT_SINGLESTEP_BIT)
+#define PT_SINGLESTEP		(1<<PT_SINGLESTEP_BIT)				// 0x80000000
 #define PT_BLOCKSTEP_BIT	30
-#define PT_BLOCKSTEP		(1<<PT_BLOCKSTEP_BIT)
+#define PT_BLOCKSTEP		(1<<PT_BLOCKSTEP_BIT)				// 0x40000000
 
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -134,6 +134,7 @@ struct ptrace_rseq_configuration {
 #define PTRACE_EVENT_STOP	128
 
 /* Options set using PTRACE_SETOPTIONS or using PTRACE_SEIZE @data param */
+/* Consider overlap with task->ptrace PT_flags */
 #define PTRACE_O_TRACESYSGOOD	1
 #define PTRACE_O_TRACEFORK	(1 << PTRACE_EVENT_FORK)
 #define PTRACE_O_TRACEVFORK	(1 << PTRACE_EVENT_VFORK)
@@ -143,6 +144,8 @@ struct ptrace_rseq_configuration {
 #define PTRACE_O_TRACEEXIT	(1 << PTRACE_EVENT_EXIT)
 #define PTRACE_O_TRACESECCOMP	(1 << PTRACE_EVENT_SECCOMP)
 
+/* PTRACE_O_SEIZED			(1 << 13) */
+
 /* eventless options */
 #define PTRACE_O_EXITKILL		(1 << 20)
 #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)


