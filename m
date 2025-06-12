Return-Path: <linux-pm+bounces-28549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924E1AD74AB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F70A7A9B30
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B52737F0;
	Thu, 12 Jun 2025 14:52:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3D272E7A;
	Thu, 12 Jun 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739965; cv=none; b=mR0PyeqY6hoF+jRdV5GExRTT8EWZhiqLo8VD5NNbqzl9kZeFJ5Dyg4cyfM7Lhmdg7e+CNmqYTHQ+75UT+NB2bfb4ZaCvgXGEkQ8EXwlyrhnzFw0zb772E2SBeXrqEb6QTErbA8mCDMlaBtyYbeNFincPx3c2ZdtYQJOl1q1CHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739965; c=relaxed/simple;
	bh=KkLFFzSeqv7kFqYh3kVMzg8nLzcSWHcSoDpXamAOTT8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BiVCj28r6jer/Zo1N5N4nRiGGMxlHSIprZnvOTcUgDLRQzb6Wuosl8p655VmpekOHPUpaa0FN1elXNNmRqMlY6l5wwIGJs1m8hTNOJ/sxbnbrmXufkHl/nDNBOkj/vpW+IBdyaHwB8K2C2og4esrq3Q+jMB1RKi1abrDOLN+EoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 4ED67141745;
	Thu, 12 Jun 2025 14:52:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 6037460011;
	Thu, 12 Jun 2025 14:52:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPjJg-00000001lOc-0Dzh;
	Thu, 12 Jun 2025 10:54:08 -0400
Message-ID: <20250612145407.906308844@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 10:53:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/4] PM: cpufreq: powernv/tracing: Move powernv_throttle trace event
References: <20250612145310.563358597@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6037460011
X-Stat-Signature: r5ktidiik4dohh3as5y7g1ua3nqsoqr6
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18SHSQxUEtgi1WSSlhtEFfwEslwEhqeQH4=
X-HE-Tag: 1749739952-861469
X-HE-Meta: U2FsdGVkX1+474gVuLLNZRbGAptp138LPUyuUdfvhTgcPcOpmqZmIs86sI8iiOGnd85w7Ubg9jaDDGsQf7ixxkSB5U9HQZC6OunilCrU613eP9T7FTtVAdkdu/MhdiRm8X5KFNF9WZcYRFxTWg0GvMRTqSA7IrN0vuc/jR+HNK+MzM31piX3ayX40JWpP4vuWZRp2rXQhBeeMRb4Gun+VwhEZz5J2tqSzv+dIJ6pjcOTorQXUTGIFTd23h8n7yvrznOr+sfb4t28smD8w19OMWaktZ+jpOZCGv6TVleowCN5LBdvqp1tbvYni0owxxnyr/UgF0DmJYrbqNxezBFnRrnUjX05rlQ//9vlD6YQyfUzzUhNxR/QUqjyy1zx4zRqHqbfbk3yII38N40UFpZpkA==

From: Steven Rostedt <rostedt@goodmis.org>

As the trace event powernv_throttle is only used by the powernv code, move
it to a separate include file and have that code directly enable it.

Trace events can take up around 5K of memory when they are defined
regardless if they are used or not. It wastes memory to have them defined
in configurations where the tracepoint is not used.

Fixes: 0306e481d479a ("cpufreq: powernv/tracing: Add powernv_throttle tracepoint")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/cpufreq/Makefile          |  1 +
 drivers/cpufreq/powernv-cpufreq.c |  4 ++-
 drivers/cpufreq/powernv-trace.h   | 44 +++++++++++++++++++++++++++++++
 include/trace/events/power.h      | 22 ----------------
 kernel/trace/power-traces.c       |  1 -
 5 files changed, 48 insertions(+), 24 deletions(-)
 create mode 100644 drivers/cpufreq/powernv-trace.h

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index d38526b8e063..681d687b5a18 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CPUFREQ_VIRT)		+= virtual-cpufreq.o
 
 # Traces
 CFLAGS_amd-pstate-trace.o               := -I$(src)
+CFLAGS_powernv-cpufreq.o                := -I$(src)
 amd_pstate-y				:= amd-pstate.o amd-pstate-trace.o
 
 ##################################################################################
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index a8943e2a93be..7d9a5f656de8 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -21,7 +21,6 @@
 #include <linux/string_choices.h>
 #include <linux/cpu.h>
 #include <linux/hashtable.h>
-#include <trace/events/power.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -30,6 +29,9 @@
 #include <asm/opal.h>
 #include <linux/timer.h>
 
+#define CREATE_TRACE_POINTS
+#include "powernv-trace.h"
+
 #define POWERNV_MAX_PSTATES_ORDER  8
 #define POWERNV_MAX_PSTATES	(1UL << (POWERNV_MAX_PSTATES_ORDER))
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
diff --git a/drivers/cpufreq/powernv-trace.h b/drivers/cpufreq/powernv-trace.h
new file mode 100644
index 000000000000..8cadb7c9427b
--- /dev/null
+++ b/drivers/cpufreq/powernv-trace.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(_POWERNV_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _POWERNV_TRACE_H
+
+#include <linux/cpufreq.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_events.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM power
+
+TRACE_EVENT(powernv_throttle,
+
+	TP_PROTO(int chip_id, const char *reason, int pmax),
+
+	TP_ARGS(chip_id, reason, pmax),
+
+	TP_STRUCT__entry(
+		__field(int, chip_id)
+		__string(reason, reason)
+		__field(int, pmax)
+	),
+
+	TP_fast_assign(
+		__entry->chip_id = chip_id;
+		__assign_str(reason);
+		__entry->pmax = pmax;
+	),
+
+	TP_printk("Chip %d Pmax %d %s", __entry->chip_id,
+		  __entry->pmax, __get_str(reason))
+);
+
+#endif /* _POWERNV_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE powernv-trace
+
+#include <trace/define_trace.h>
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 6c631eec23e3..913181cebfe9 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -99,28 +99,6 @@ DEFINE_EVENT(psci_domain_idle, psci_domain_idle_exit,
 	TP_ARGS(cpu_id, state, s2idle)
 );
 
-TRACE_EVENT(powernv_throttle,
-
-	TP_PROTO(int chip_id, const char *reason, int pmax),
-
-	TP_ARGS(chip_id, reason, pmax),
-
-	TP_STRUCT__entry(
-		__field(int, chip_id)
-		__string(reason, reason)
-		__field(int, pmax)
-	),
-
-	TP_fast_assign(
-		__entry->chip_id = chip_id;
-		__assign_str(reason);
-		__entry->pmax = pmax;
-	),
-
-	TP_printk("Chip %d Pmax %d %s", __entry->chip_id,
-		  __entry->pmax, __get_str(reason))
-);
-
 TRACE_EVENT(pstate_sample,
 
 	TP_PROTO(u32 core_busy,
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index 21bb161c2316..f2fe33573e54 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -17,5 +17,4 @@
 EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_frequency);
-EXPORT_TRACEPOINT_SYMBOL_GPL(powernv_throttle);
 
-- 
2.47.2



