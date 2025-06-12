Return-Path: <linux-pm+bounces-28546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AFAD74D5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD49189A29E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796B926E717;
	Thu, 12 Jun 2025 14:52:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F026C397;
	Thu, 12 Jun 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739958; cv=none; b=c9I8W12YzzWVZu4mTPAVKsEk5seYehqEtVeAmuME51M6+T38ILa0Rb6WilqoCRnYDFdfwZr/DXVV+znXmAkDI5rx0+YnjCjwX0ytMxYEAnAwAs+GjuQqwjGe5+tNYt466OdNyVqD6tdbkdi3jIAoKPRb3eNYRfLxixvxeC7Q4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739958; c=relaxed/simple;
	bh=SNJt80qACwYsMfBYoQhUvMzRumLNnmU93cx7xgvWIhA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=a+4Xd1Q3GB2UuDcVg2a4IiLLVzHtVfdtdoA/p+vq1rjY0GeDmERupajVOzpPp+BNqw238XzHKP/3wHLCnuXUXORm6rGk+3DMnDgLv2zjHecRWuMwhNi/YbV7w9YIVlG1xdPoHycPAC+bk2HBHSWGka4fshwTdc+LpVd0ww8fsM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 14D5E16172E;
	Thu, 12 Jun 2025 14:52:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 50B2120027;
	Thu, 12 Jun 2025 14:52:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPjJf-00000001lO7-3fv0;
	Thu, 12 Jun 2025 10:54:07 -0400
Message-ID: <20250612145310.563358597@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 10:53:10 -0400
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
Subject: [PATCH 0/4] PM: tracing: Don't compile in unused trace events
X-Rspamd-Queue-Id: 50B2120027
X-Stat-Signature: 671yypn3d1k3f91qa3qgzfbjcctxm555
X-Rspamd-Server: rspamout07
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+HKFgC2IAPMdV6bVqFLIbbF0jglEfehXs=
X-HE-Tag: 1749739952-202480
X-HE-Meta: U2FsdGVkX18Zx3d1zrK96W9dRamojZiOj5sofUya+o14Daoe7ojSHmOmb2s5GCt5YqPHpM1G8bLnUG/WIUTBXwRBtJwYtlfgrxTX17b23DSwS0eZSUvTQkJFnB1mcwNkl+rR+yNlKs3HsGqZZZ/lU0baogzv2nP/UhAXHDG1oSB1QhuzC4BYT4Fr94+ZQJSMoxez9+vSEX6GDuWdy6ulboooEBha/F2H9AGjz8NDn6k4bqAf61sU3pb9w5KRCdc/TsCnaSiurMzym7k84yRzZW3IhWukYIFB5JY/R4GhyA8=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>


I have code that makes unsued events trigger a warning. I'm currently cleaning
up the kernel to remove the majority of events that are defined but not used.
When an event is defined, it can take up to 5K of text and meta data per
event. An event should not be created if it is not being used.

The powernv_throttle event is only used by the powernv code so I moved it to
its own header file and it gets created when the powernv code is compiled in.

For the other power events, I just added #ifdef around them with the configs
that enable them.

Steven Rostedt (4):
      PM: cpufreq: powernv/tracing: Move powernv_throttle trace event
      PM: tracing: Hide psci_domain_idle events under ARM_PSCI_CPUIDLE
      PM: tracing: Hide device_pm_callback events under PM_SLEEP
      PM: tracing: Hide power_domain_target event under ARCH_OMAP2PLUS

----
 drivers/cpufreq/Makefile          |  1 +
 drivers/cpufreq/powernv-cpufreq.c |  4 +++-
 drivers/cpufreq/powernv-trace.h   | 44 +++++++++++++++++++++++++++++++++++++++
 include/trace/events/power.h      | 28 ++++++-------------------
 kernel/trace/power-traces.c       |  1 -
 5 files changed, 54 insertions(+), 24 deletions(-)
 create mode 100644 drivers/cpufreq/powernv-trace.h

