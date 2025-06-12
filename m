Return-Path: <linux-pm+bounces-28550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFC3AD74B7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 16:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183922C36F9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCC273D83;
	Thu, 12 Jun 2025 14:53:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79591273D7F;
	Thu, 12 Jun 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739985; cv=none; b=gx/B0aFCOu7Tuo443NVGwHPqiQNMgianovme/0kXUVo5wbDZwRNx3m6zv6XJab8g/RQwH+c9PrF6Loy1uqSug5eIGBDIzJdSJ3Q8SDmq2c5p7Mw4mrxLTj28tbEyQhV6sr3pOhTpgm7vWLpyXWjP2PZt4PMtcY23gopOV9d8k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739985; c=relaxed/simple;
	bh=iPaMVCvtVq/bIrjuta3WZIZB6tCzbML6yKhL4yeq8kU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gvXoaG330HfKXmMvIs9fjAcfiIQF0ubTS84CfPlpv7r3k7JuVwPOyWndYvcfyOU3j2zw1kataAgSdduhc3uB5crXyUKh8J8293kID7BFRu4+fV3cxyfAD1i8pCh6wBhqWzqHZA07U3Y5x02UBkC1y92DoQNP+KqmS+AbIka44Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B80275FBDE;
	Thu, 12 Jun 2025 14:52:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id D68DE20028;
	Thu, 12 Jun 2025 14:52:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPjJg-00000001lQ5-2NL5;
	Thu, 12 Jun 2025 10:54:08 -0400
Message-ID: <20250612145408.415483176@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 10:53:14 -0400
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
Subject: [PATCH 4/4] PM: tracing: Hide power_domain_target event under ARCH_OMAP2PLUS
References: <20250612145310.563358597@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: D68DE20028
X-Stat-Signature: d779s6b79wo56idmtjbw44h7e3pmcfdt
X-Rspamd-Server: rspamout05
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+p9qLGefh3sHaR9HeWxLmuONQDxFeJOGA=
X-HE-Tag: 1749739952-78830
X-HE-Meta: U2FsdGVkX1+oktxM9QHJotdDuSoK5vAHsGppqxtCgNWEj1VK1VKxq7/y9psVHR+Bs2ogve3wyTswzYhgNOyT0RsushAuh86z1DNqREAWXAVYDIw2j/ZsYhMZLTVYjQ8tO3lOFw5W+hCQAnkWijSF0faDxdMJ9DJ6sGb8RQKmoR3SZNxnb7lAeFHLvABmw29eyA7HWOe3keGbV3AcW1SXcIb1HyTjyHcZ7NsmXrf4Kc7rI+8WmBBmycoB36t9bq5+LBgoUG3rcDrkB7/7MIJ6wtJaGJ+4hMxsfRR+6L3upigYysuBZt6mHOQGwhCgC8DnLSqMPjWh1mkigyDN9bMbVxUntrVmbY2x2r+jJZ9u3EJbauVyndWCWlvOSERxtbTuWU7ND/LoCS+VoL3L5cnl4w==

From: Steven Rostedt <rostedt@goodmis.org>

The power_domain_target event event is only called when CONFIG_OMAP2PLUS
is defined. As each event can take up to 5K regardless if they are used or
not, it's best not to define them when they are not used. Add #ifdef
around these events when they are not used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/power.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 5b1df5e1e092..82904291c2b8 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -319,6 +319,7 @@ DEFINE_EVENT(wakeup_source, wakeup_source_deactivate,
 	TP_ARGS(name, state)
 );
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 /*
  * The power domain events are used for power domains transitions
  */
@@ -350,6 +351,7 @@ DEFINE_EVENT(power_domain, power_domain_target,
 
 	TP_ARGS(name, state, cpu_id)
 );
+#endif
 
 /*
  * CPU latency QoS events used for global CPU latency QoS list updates
-- 
2.47.2



