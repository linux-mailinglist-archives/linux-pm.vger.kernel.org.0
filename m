Return-Path: <linux-pm+bounces-28547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA4FAD74AD
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 16:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2CF1709AE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9D27145C;
	Thu, 12 Jun 2025 14:52:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B8270ED4;
	Thu, 12 Jun 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739959; cv=none; b=f5mbiOXl7EN8RscO2hWTSGgsH/Yp3OaEE4iuzmljTYj09iVAFq99VVPjKWHBL8D4LEvtxPXqzmXr908AITR6jPvlXxpQoTPu+2AQzSEqA+ffIuSlMq86Ml8uDhor2qD1fgo0PEgih5DTPRmEV3cvTY73INZM42JSV7EBk+oBXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739959; c=relaxed/simple;
	bh=IRJXCXJo+dhajKqs/GVW4X4ORkkZ2S8OHxOKkOQph4A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HkgO1C+mmXMuSdVmiiYPph+AmNE/x05quzIzLufr3sS8fVRL2dYAwocxU4Xo7HIPPZAPDyTVUpwNhzsllnLg1Nmej918o7n3q4KBy49AzxNKwpZRJVT/TXJqf/d0hJQHAN9OvdcMpX7TsQlrQEvXdhWiKtVJ+xfjzaam9CEuvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 7925A1D8149;
	Thu, 12 Jun 2025 14:52:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 926A542;
	Thu, 12 Jun 2025 14:52:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPjJg-00000001lP7-0woS;
	Thu, 12 Jun 2025 10:54:08 -0400
Message-ID: <20250612145408.074769245@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 10:53:12 -0400
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
Subject: [PATCH 2/4] PM: tracing: Hide psci_domain_idle events under ARM_PSCI_CPUIDLE
References: <20250612145310.563358597@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: t1gxukcmttsd57ypqjtoxhrrxmtqcbd4
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 926A542
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DsACEpXW1Hxr3qrAKke4Xko/DKEfchDw=
X-HE-Tag: 1749739952-596550
X-HE-Meta: U2FsdGVkX1/IfiTNa6p40H7QmDBnX3sN/6qr5uRq/JvAr7V1bDaJdMzuHdv9rphnCS17FRaeM9YiG/hUMr8hC+mmUkKa0GYv6prfsggZcR30qEBOVcLhtOrcpWkG9Ke5VWnCKzJPAS+oVNTXZLKmnVNRgI8rHLYI+4BIgQ5P+8REpPm0IUyhvyqcvcR6ZrGJXdrvG26x+XwbyxFfx9pCY+/T72i8WHl5FLPqyaya7yCJu7mTuCI++6kdd2AdXw0heORM81ecFOTnPWDnlqGe5AJqYMSrMlgjV4UQkUVFoiPDyxArJdqWfPCA3AWG5OghmNV9H+jgpkjvSB7BKhddo4QqgJNLqXdaKjxk7wGsIF82E/1scem3bHrh9pxweG2gg0+cvTokxC3MRJ/u9tEdqw==

From: Steven Rostedt <rostedt@goodmis.org>

The events psci_domain_idle_enter and psci_domain_idle_exit events are
only called when CONFIG_ARM_PSCI_CPUIDLE is defined. As each event can
take up to 5K (less for DEFINE_EVENT()) regardless if they are used or
not, it's best not to define them when they are not used. Add #ifdef
around these events when they are not used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/power.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 913181cebfe9..a10ad300d660 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -62,6 +62,7 @@ TRACE_EVENT(cpu_idle_miss,
 		(unsigned long)__entry->state, (__entry->below)?"below":"above")
 );
 
+#ifdef CONFIG_ARM_PSCI_CPUIDLE
 DECLARE_EVENT_CLASS(psci_domain_idle,
 
 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
@@ -98,6 +99,7 @@ DEFINE_EVENT(psci_domain_idle, psci_domain_idle_exit,
 
 	TP_ARGS(cpu_id, state, s2idle)
 );
+#endif
 
 TRACE_EVENT(pstate_sample,
 
-- 
2.47.2



