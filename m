Return-Path: <linux-pm+bounces-28171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0B4ACF8AD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 22:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C93178B08
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC727C163;
	Thu,  5 Jun 2025 20:19:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D221DFF8;
	Thu,  5 Jun 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749154792; cv=none; b=c7B/XgkT7ROoGZIX4yk+WGjfrg31jH5lTIVn73qYS7fac9NxhtQD6a+ZKB2XAQZ1MmmsYh0pY0nF26qKad5Vv883rawR5uHjlQzXLGGDT+pVvW3RSptCAQLOXjF+CA9GMExu8auYZSkqf5Y/K8/2UaI33FLmpNMJCZGOIKXPl8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749154792; c=relaxed/simple;
	bh=bCoVjlodrgkYzGyi6l6AfakjRkc/l/4mvqDviZz/Z/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SjoYynQFKNUG8NLDBQkv4Iv7U5Eri6v/lOce1bnBQp6UP2qhnFipCcnjW20gh1dvLIQSrkUeEuVQRzsn99DK4bZ0HUWSFVf7/8o8uD6JKnK9GJ+oqnr4wkdL3LgFp3t2MwggA8smnOekRB8emUMv7nVOEbsgxXPyvfkSmR35GIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id AC5C4815F5;
	Thu,  5 Jun 2025 20:19:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id C1ECA80009;
	Thu,  5 Jun 2025 20:19:46 +0000 (UTC)
Date: Thu, 5 Jun 2025 16:21:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kajetan Puchalski
 <kajetan.puchalski@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
Subject: [PATCH] tracing: PM: Remove unused clock events
Message-ID: <20250605162106.1a459dad@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uizkqrykdouwbnzti41gsigjsm9qq4b5
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: C1ECA80009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+dspzweXgzXk3Nxn8TcOfSZ5im+XcUehg=
X-HE-Tag: 1749154786-832789
X-HE-Meta: U2FsdGVkX18nRbL1UU7fx6tinbnfYDnaPK4rk8GK75NQj/edkXAHq0Pz9T+AVZdy+pBKVrPKhilDDu7J5DL4dF1/Yplwi2uGdrBmJc/62lYd6vbEDiHR18x+5oI+B2LjA7JWX/ZoHOhkGI7sL0VTsOVnrFKGKFUSE+gWfg2Q66RLvNxEOZKrAJxExo+byRApfWsRds2N0pZa7obeJA8v+ezLh+/c+Rs9jury1fq8dyH0cd/3LFzQqeDMN781UOIeqsEI2wwIwoysDmcV40msrSrtlLar+/I8g2Ul4xdOC8EzWGOu7YjDq3t1sn72Q3GZlFIcytI/Sh0/f29S5eQ6ZOBM26m1PYajjyXNynd0nQO/AaFIEDJ6U2Rrmtuqu/c9b/rKuEvIjdihX4Hau7DcCQ==

From: Steven Rostedt <rostedt@goodmis.org>

The events clock_enable, clock_disable, and clock_set_rate were added back
in 2010. In 2011 they were used by the arm architecture but removed in
2013. These events add around 7K of memory which was wasted for the last 12
years.

Remove them.

Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/

Fixes: 74704ac6ea402 ("tracing, perf: Add more power related events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/power.h | 47 ------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 9253e83b9bb4..6c631eec23e3 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -337,53 +337,6 @@ DEFINE_EVENT(wakeup_source, wakeup_source_deactivate,
 	TP_ARGS(name, state)
 );
 
-/*
- * The clock events are used for clock enable/disable and for
- *  clock rate change
- */
-DECLARE_EVENT_CLASS(clock,
-
-	TP_PROTO(const char *name, unsigned int state, unsigned int cpu_id),
-
-	TP_ARGS(name, state, cpu_id),
-
-	TP_STRUCT__entry(
-		__string(       name,           name            )
-		__field(        u64,            state           )
-		__field(        u64,            cpu_id          )
-	),
-
-	TP_fast_assign(
-		__assign_str(name);
-		__entry->state = state;
-		__entry->cpu_id = cpu_id;
-	),
-
-	TP_printk("%s state=%lu cpu_id=%lu", __get_str(name),
-		(unsigned long)__entry->state, (unsigned long)__entry->cpu_id)
-);
-
-DEFINE_EVENT(clock, clock_enable,
-
-	TP_PROTO(const char *name, unsigned int state, unsigned int cpu_id),
-
-	TP_ARGS(name, state, cpu_id)
-);
-
-DEFINE_EVENT(clock, clock_disable,
-
-	TP_PROTO(const char *name, unsigned int state, unsigned int cpu_id),
-
-	TP_ARGS(name, state, cpu_id)
-);
-
-DEFINE_EVENT(clock, clock_set_rate,
-
-	TP_PROTO(const char *name, unsigned int state, unsigned int cpu_id),
-
-	TP_ARGS(name, state, cpu_id)
-);
-
 /*
  * The power domain events are used for power domains transitions
  */
-- 
2.47.2


