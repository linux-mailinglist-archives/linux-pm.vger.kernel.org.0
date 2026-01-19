Return-Path: <linux-pm+bounces-41142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE529D3BA81
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 23:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FA473009227
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5202EC080;
	Mon, 19 Jan 2026 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSOiMAjs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883A22652D;
	Mon, 19 Jan 2026 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768860781; cv=none; b=UvRXygvTi9r423VXfnsQIO/J1vmZOUYJ/dqbSRLeB+EqiYSjjFsf8syu6hVYejP0KMjq0kQnmSaMxN/NjYLNiFzXBF1P1AQPNIxwYHmsTvIi0Qn+N8B9eQuX9gTW2mtUAETDd4RRnnhloA2HJBY1ztjuEPfs5NeYehIAUKtorl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768860781; c=relaxed/simple;
	bh=k70hQr63RUXGOh3ycwl6W+fn7/85Vw2c7ppPZ0urjfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOLRfi9uCGhEO542aAs0g9iygyZ+FztX6N/Sw5Qq3nLIJRSIJPjF3vD/jM7xJO8giPCIu8YoRfU2peCTveIPS2HA8SVsGg/Koap8Rdnwu5TXmeQvNrVL5D412N7uJEjcfxeswoEqoKTNw4QIRW5RowTwftX7eIiWRg4RD/lox/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSOiMAjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8B8C116C6;
	Mon, 19 Jan 2026 22:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768860780;
	bh=k70hQr63RUXGOh3ycwl6W+fn7/85Vw2c7ppPZ0urjfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSOiMAjsZs3jW1KvXp0g4mphAlSBZoZJIIxWDLwthIXy6fvkkLpXd8J2xHfChol+u
	 9lWtJ2L8NGA9nTrBp9IfiGkd8QEwLqu3CuE5ODDorYXu8dCC/dF9tuKxHIIEgkGpuR
	 1mt+syAX3esvNM0UqpS5Rthz+3u8U1SyXtdxdpqujAbw58o2YwjKwyAVaVfDvBw7Bn
	 2tmphoYbo6gSQ3V38Fkd/AHmSIIMk3SAuHfwKNThZPpEZd3Cku/s7U3oG65hiyItMJ
	 5mXALRbvdFiPXzDovY43E/e/q+LCWj9Ms4PwlT2h03DaF6J+YaxgYWYrcuS2Wh2wtp
	 KtM2AXkO85prQ==
Date: Mon, 19 Jan 2026 23:12:57 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <aW6saYApHwG_cgn_@pavilion.home>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260119145330.GI830229@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119145330.GI830229@noisy.programming.kicks-ass.net>

Le Mon, Jan 19, 2026 at 03:53:30PM +0100, Peter Zijlstra a écrit :
> On Fri, Jan 16, 2026 at 03:51:53PM +0100, Frederic Weisbecker wrote:
> >  kernel/sched/cputime.c             | 302 +++++++++++++++++++++++++++++++------
> 
> My editor feels strongly about the below; with that it still has one
> complaint about paravirt_steal_clock() which does not have a proper
> declaration.

I guess it happens to be somehow included in the <linux/sched*.h> wave

> 
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 7ff8dbec7ee3..248232fa6e27 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -2,6 +2,7 @@
>  /*
>   * Simple CPU accounting cgroup controller
>   */
> +#include <linux/sched/clock.h>
>  #include <linux/sched/cputime.h>
>  #include <linux/tsacct_kern.h>
>  #include "sched.h"

Ok I'll include that.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

