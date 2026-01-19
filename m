Return-Path: <linux-pm+bounces-41120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA1D3AE57
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 16:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1823A307B397
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8C39280F;
	Mon, 19 Jan 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ov9hOHxz"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D239281B;
	Mon, 19 Jan 2026 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834426; cv=none; b=rKzbQDwNM/chiXb9o+3Gf6FWDFBEjraqrUsbZatjHou4fZHTjgcoRprGP6Ds9z6Pr2xF/9Cy9xhgrbZ+G+HERrTlCb2Wklr5pdDbFul/nfxRyV+ivQiz5twBQskR06WaPic0QfgzVvv5cROHXlIrLTKkuc4Ca22zwyAjIKTgJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834426; c=relaxed/simple;
	bh=T/HmJfxY0ZqSNDHs1UOoXna80pEALR8yUlN6/bQPKVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHFpKKcprKhDRnoLwNYdkK53EhSZYS0Gnis0sabMVt4Jthe8Ci+QZ8WDXKUOlWS3qnu33sM1xPBTlUP190Kn1KwzU2Ybt9H7oJa+0/lp7JUxLhbM2M5xfNdzzoCRUvVjWoc+yjE8Zb1hhMDM0HToQm2nqPr0zwDAaTwE6HDwA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ov9hOHxz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jrDAxjhFf3FPLMbr/IOqWmWDDR5q/doAeWiuVFjaQvY=; b=ov9hOHxzzbUcf3Ie3aSb0QShDF
	+YggQwKOQw7guQyXSafiQuLquH2AQbsBQ3vkAOn72zXdtbwnjH7i/NB1rWne47GWzjcFfdit1ZyvC
	0EMVON8aMu6/psOQ5YiuIsyOgTH88WTbE+Tf7kmQzZbEp1VcvVBUV/KFQIab9FCWncqn5bUdc1lrs
	uoQND/4S7c4z4KnKbJYBuR+fY0Qipf+lsWIqYo9Hd+Go3BfKLBUf9Xiwmqg6IDtji8FRXBjy1tbBp
	NTyLzfmVtOnLvPkLTKHfEjWnAtsk/sZ2cqJltxnpRBd6WEidzOCDKMmjzFI2oe57Wwa068Bx9GzuR
	YPQz3Z2g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqdH-0000000CLEC-0iMk;
	Mon, 19 Jan 2026 14:53:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 959123006CD; Mon, 19 Jan 2026 15:53:30 +0100 (CET)
Date: Mon, 19 Jan 2026 15:53:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linuxppc-dev@lists.ozlabs.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-pm@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Nicholas Piggin <npiggin@gmail.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 00/15] tick/sched: Refactor idle cputime accounting
Message-ID: <20260119145330.GI830229@noisy.programming.kicks-ass.net>
References: <20260116145208.87445-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-1-frederic@kernel.org>

On Fri, Jan 16, 2026 at 03:51:53PM +0100, Frederic Weisbecker wrote:
>  kernel/sched/cputime.c             | 302 +++++++++++++++++++++++++++++++------

My editor feels strongly about the below; with that it still has one
complaint about paravirt_steal_clock() which does not have a proper
declaration.


diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7ff8dbec7ee3..248232fa6e27 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -2,6 +2,7 @@
 /*
  * Simple CPU accounting cgroup controller
  */
+#include <linux/sched/clock.h>
 #include <linux/sched/cputime.h>
 #include <linux/tsacct_kern.h>
 #include "sched.h"

