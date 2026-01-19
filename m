Return-Path: <linux-pm+bounces-41105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D12D3A9CC
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 14:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC803042741
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0833624D9;
	Mon, 19 Jan 2026 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AfC2LjX+"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2729363C5A;
	Mon, 19 Jan 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827760; cv=none; b=dWfCXyrGJEV1bpbZy8YapEuZl8oCW9E2BDz13+mdI/eRmXV5rmTYkOIslAI9YVjq8D21iPAEyiFMoe/sNNz0WZGsjx6sd2rdJYQf0GMGvXTmiCYzKa1h+wZKfl/90gAaBnCFsqdPgCAAl2dvGBq2F3boo/EUBxoagSZD9f+Lf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827760; c=relaxed/simple;
	bh=dioFFkMm6JTrUu9b23Spsfx6MzNnQgiKzNjXl7BTIvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UInbtCSeIqdeMkevqZnANO4Z1WagjJfi8bnNj2pjw1NBJGuGExfB9vA0yxb6dfLTCM05B3SjhHiU+UpRAnZ4P9bVD+zhWAAH6yokVGrmSsKqShZZzUhaIPCjpCVcElVBt1rlT6aihz+pDzm1B5ketP/ZVW+RvrNcLIUZSTuTrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AfC2LjX+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K6GIJX4FXlvpq7uMxNyYRLbfDKf0u3wG72kJM/83578=; b=AfC2LjX+NrAKtI09VCS2VApu5r
	TB5u50TAe6rKe0UqNLR+zN084CjDkMuVhwbSmzDwY5UuDDh6EQUGlMMqMbKkNK7ql4UfANuiloz35
	A4S7ItXfX/XkXB8KxXFSF6PKoALuvUcmNK6a6vPKYzeV3HdIgx0VPPlO0XrA1ja/ADs3vlqkDI9tA
	dMQrtDJtzWjg9N7sK+OSoDxPGnKgR4E0BZ2GMH6mKDynRvgFkXi3/bvnbZEcl2081N3hZQ03APAMD
	u+naESOWRL7j5M8hE9v/EdwcoDUWPevfhimo1rR7/PMnk3vRVMEib6SULgy/fk8ZkN5PBmOV9H9KT
	9Cqb9VNw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhoti-0000000C870-3hn0;
	Mon, 19 Jan 2026 13:02:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 58E263006CD; Mon, 19 Jan 2026 14:02:22 +0100 (CET)
Date: Mon, 19 Jan 2026 14:02:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/15] sched/cputime: Correctly support generic vtime
 idle time
Message-ID: <20260119130222.GU830755@noisy.programming.kicks-ass.net>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116145208.87445-4-frederic@kernel.org>

On Fri, Jan 16, 2026 at 03:51:56PM +0100, Frederic Weisbecker wrote:

> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 8ddf74e705d3..f1d07a0276a5 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -780,7 +780,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
>  	ktime_t now, idle;
>  	unsigned int seq;
>  
> -	if (!tick_nohz_active)
> +	if (!tick_nohz_active || vtime_generic_enabled_cpu(cpu))
>  		return -1;
>  
>  	now = ktime_get();

Is this not broken? IIUC this means that you can no longer use
get_cpu_{idle,iowait}_time_us() the moment you have context tracking
enabled.

