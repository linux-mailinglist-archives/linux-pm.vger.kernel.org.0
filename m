Return-Path: <linux-pm+bounces-35978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73120BD4F1F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 536145472BD
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39EB30AD06;
	Mon, 13 Oct 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fR2YIs+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588B30ACE9
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370838; cv=none; b=nwBrh1OAnDmzCqOQfF9m5k6jXdJDmI5dKFp4bAWwxPKKFUjcuEaAxYg9Swcz9agsjE5XNvOznLn/cbpSaC55iHERG2u8JHCttXphxhe+1QII04tSG1tGPzF+FNyDjSLN/4kIjPWj8zFYqnOSBA+c5phITOHwMAAz6DbAjroRIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370838; c=relaxed/simple;
	bh=/dCx9r/U8UG2l5Mcbc2KOJix8VyRJqMpv2JirRyVJ9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbBwB+YKQhZL42jNdht1/NSwLq3/6ebO8wy9MiDe1cnvVP7L+wVTSSEav04srlSfnqavctoqVIlFdK7/VJUqn8VW+lvBqxAUZp18YUvyIpoSQbZL/Zm4gzIopbCQgcONLvBHo2Svk4RGUIZ6VDvaz0n+Rz1PCIG3QnguKQ1fkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fR2YIs+J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIWnafYZvpDpu4eOTrAw6osXsXYCsEI4K9wvhKujihY=;
	b=fR2YIs+J7zXVnWa1QBZNbfH96kQO24AG9j3HZV0Dpi7KSccIfpG9utrCYXtzbK/Hq6Oz5o
	nuGFbdCM1aMV82+EDLvPbYVh+m5ZrjDOSJjzCbEZ/qJ9pNh/40Auzx7Ahpb5mM//eOm66l
	GQDn4WHE+5EMhYcTB1iIIYgG3SADJos=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-EuVqN5lNPA2qFbLoLfga_w-1; Mon,
 13 Oct 2025 11:53:51 -0400
X-MC-Unique: EuVqN5lNPA2qFbLoLfga_w-1
X-Mimecast-MFC-AGG-ID: EuVqN5lNPA2qFbLoLfga_w_1760370828
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAB71180057B;
	Mon, 13 Oct 2025 15:53:47 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.1])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C68D93000384;
	Mon, 13 Oct 2025 15:53:42 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU counter
Date: Mon, 13 Oct 2025 11:48:03 -0400
Message-ID: <20251013155205.2004838-2-lyude@redhat.com>
In-Reply-To: <20251013155205.2004838-1-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Joel Fernandes <joelagnelf@nvidia.com>

Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
allowing those bits to be repurposed for other uses.  This also has the benefit
of tracking more than 16-levels deep if there is ever a need.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes <joelaf@google.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/linux/hardirq.h   | 17 +++++++++++++----
 kernel/softirq.c          |  2 ++
 rust/kernel/alloc/kvec.rs |  5 +----
 rust/kernel/cpufreq.rs    |  3 +--
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index d57cab4d4c06f..177eed1de35cc 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -10,6 +10,8 @@
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
+DECLARE_PER_CPU(unsigned int, nmi_nesting);
+
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
 
@@ -102,14 +104,17 @@ void irq_exit_rcu(void);
  */
 
 /*
- * nmi_enter() can nest up to 15 times; see NMI_BITS.
+ * nmi_enter() can nest - nesting is tracked in a per-CPU counter.
  */
 #define __nmi_enter()						\
 	do {							\
 		lockdep_off();					\
 		arch_nmi_enter();				\
-		BUG_ON(in_nmi() == NMI_MASK);			\
-		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
+		__this_cpu_inc(nmi_nesting);			\
+		__preempt_count_add(HARDIRQ_OFFSET);		\
+		if (__this_cpu_read(nmi_nesting) == 1)		\
+			__preempt_count_add(NMI_OFFSET);	\
 	} while (0)
 
 #define nmi_enter()						\
@@ -124,8 +129,12 @@ void irq_exit_rcu(void);
 
 #define __nmi_exit()						\
 	do {							\
+		unsigned int nesting;				\
 		BUG_ON(!in_nmi());				\
-		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_sub(HARDIRQ_OFFSET);		\
+		nesting = __this_cpu_dec_return(nmi_nesting);	\
+		if (!nesting)					\
+			__preempt_count_sub(NMI_OFFSET);	\
 		arch_nmi_exit();				\
 		lockdep_on();					\
 	} while (0)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 77198911b8dd4..af47ea23aba3b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,6 +88,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
+DEFINE_PER_CPU(unsigned int, nmi_nesting);
+
 /*
  * SOFTIRQ_OFFSET usage:
  *
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index e94aebd084c83..1d6cc81bdeef5 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -7,10 +7,7 @@
     layout::ArrayLayout,
     AllocError, Allocator, Box, Flags, NumaNode,
 };
-use crate::{
-    fmt,
-    page::AsPageIter,
-};
+use crate::{fmt, page::AsPageIter};
 use core::{
     borrow::{Borrow, BorrowMut},
     marker::PhantomData,
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 21b5b9b8acc10..1a555fcb120a9 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -38,8 +38,7 @@
 const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
 
 /// Default transition latency value in nanoseconds.
-pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =
-        bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
+pub const DEFAULT_TRANSITION_LATENCY_NS: u32 = bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 /// CPU frequency driver flags.
 pub mod flags {
-- 
2.51.0


