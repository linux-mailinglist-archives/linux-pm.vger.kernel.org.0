Return-Path: <linux-pm+bounces-28548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C8AD74DA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 16:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D76E1890C50
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FE27145F;
	Thu, 12 Jun 2025 14:52:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623F270575;
	Thu, 12 Jun 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739959; cv=none; b=iGjQsurIjx8TPKVR7sJyvbF57oqWIcmy/lInG9ybXOiSVXefxCV/YSdx/l8fGs/C/jdustDFv5fmobwtTdoEDHtB7PosSI+059ODKcq3X2J7Z3an5z9vkOrAcE5bQaXM+1ZkZbPyLjlKAUgxMaidlYgCGxXcUyUYGf1uqARNLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739959; c=relaxed/simple;
	bh=GqYAzQTTqOixsKkeHNFxk70fTgCxt/tudq0aJ4T0s2o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gyg9EozQ6Y183L7rNRn96ZNX7DT9diYejKV6rmC6Sr1bnkWFz0IRJudzVVnib4kEFEHwuptXzuQP0wu3Zy6zGSow6b3waPyC1DQxlMPTpkZ60anBAgP66gPvWPNlvLdq95N8Z/27LKjF1sVWOMk4UxoShu4gldYDTOFeagn4wnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 967A0BF42D;
	Thu, 12 Jun 2025 14:52:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id A99CF20;
	Thu, 12 Jun 2025 14:52:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPjJg-00000001lPb-1eeF;
	Thu, 12 Jun 2025 10:54:08 -0400
Message-ID: <20250612145408.246703478@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 10:53:13 -0400
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
Subject: [PATCH 3/4] PM: tracing: Hide device_pm_callback events under PM_SLEEP
References: <20250612145310.563358597@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: A99CF20
X-Stat-Signature: fpyn74mhzgi6edsr6q5dyg95485qe48o
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19j43D1p8tely174eW3U7IK9BarJsJXwwI=
X-HE-Tag: 1749739952-946871
X-HE-Meta: U2FsdGVkX19Y+FZTAuN70shmtNMQh8PF2z5w7Al6e+s8ndEXUZ5waGRazYm5aCm2Wr9+0EzyzaKU8+39h43/bI6vwC1JF3awrJxUzixgqFB3CkY/vNKmEsPT/OV5hI4lu+/m0RfUj7nkgQJbHak4qGw+xUParAwYSnfDYmsnUA8nJAyD6BG+V0ytFtMXWmALmab5EFfBTUI5MdjZAAdTv/cWm6PKSm5M9NWf1SX25RHOP6PmO6myilu4l5HiqBpSf6h20aPkkJZ6xNU6nuhYc2en4NRWWwSTYaJqJxRD5a1I7uOniuYR3SvoNNigOYTMI1LKxCHOU2Q1hJiFGU31S+MkEnNyOtsQ3FRNqXap5c/U/vbNbY4d1XhRVHkiS/T/NNdisUq1KQZm54tC8qipcA==

From: Steven Rostedt <rostedt@goodmis.org>

The events device_pm_callback_start and device_pm_callback_end events are
only called when CONFIG_PM_SLEEP is defined. As each event can take up to
5K regardless if they are used or not, it's best not to define them when
they are not used. Add #ifdef around these events when they are not used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/power.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index a10ad300d660..5b1df5e1e092 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -212,6 +212,7 @@ TRACE_EVENT(cpu_frequency_limits,
 		  (unsigned long)__entry->cpu_id)
 );
 
+#ifdef CONFIG_PM_SLEEP
 TRACE_EVENT(device_pm_callback_start,
 
 	TP_PROTO(struct device *dev, const char *pm_ops, int event),
@@ -260,6 +261,7 @@ TRACE_EVENT(device_pm_callback_end,
 	TP_printk("%s %s, err=%d",
 		__get_str(driver), __get_str(device), __entry->error)
 );
+#endif
 
 TRACE_EVENT(suspend_resume,
 
-- 
2.47.2



