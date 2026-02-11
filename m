Return-Path: <linux-pm+bounces-42515-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOo7GSO3jGnlsQAAu9opvQ
	(envelope-from <linux-pm+bounces-42515-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 18:06:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B722212669E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 18:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0018B301014A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090F343216;
	Wed, 11 Feb 2026 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8ABi0LK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2131197C;
	Wed, 11 Feb 2026 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829597; cv=none; b=lD/MkQvFMjJoDKIMxc4wblxbuODg2wPrwTEK7h0LJ9dXfleUsrzdys+rbaBu6mQyboF5M46XYyEjEV7ST3oSDCnqUeiUHTbuWv76MlPADrqJ+r3a7sVDsA4o4CmXjKF6znolJ9DcMt/piXY5dlIVFrAuKT6Y2uDGM2V16faUYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829597; c=relaxed/simple;
	bh=5/mcrSaCWXevZn1xgFspCk2VjAB+ct0uw/F/l3YfssY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoB3NhF8YutSQ0VTepoLpy7tLOEOqp5nPHM2Y87qjiE/s+iYJGfLuqAEjPEcsCuSDGi2fi0LuwMYbTNCm7NRUbkeUK7PfXy3g0yfdGEbOzKLHhC7Euj2ZAdxcysjs3226Ew3yYQgXjzP6Cc3fFlWPejfxarFG3pWbBzwrGELM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8ABi0LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86123C4CEF7;
	Wed, 11 Feb 2026 17:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770829597;
	bh=5/mcrSaCWXevZn1xgFspCk2VjAB+ct0uw/F/l3YfssY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8ABi0LKTGRSUMbyeePfqYveaQYS7/lOY6vUIAjF9bVpzymxlrB2p4uh5qeDycVdp
	 zs4QlwBI53WPcEqrBRldR2pBSi0c8Wl51P8SUivtGAERRWZd/BtFNUh9DEeOQYxxRg
	 W6nwoIA4YEloJYgXhSxafmNq2F5I3XDJLZMEJtH0ADrB1q3LPhNYpoSL+g4aMFqckk
	 59TZyy/OHLpDf6SsHGepNFEIyU0tQEBDI92cD4+xXvgKbZetpxykOlQU0y3vZau+tW
	 4S5SyBVonmHN8nHaa4f/iPJEijb4sLIBfxbIX96dX6idHQKF4YP+8RfQJGRC4G0IcT
	 VlDzPQkjPyoGw==
Date: Wed, 11 Feb 2026 18:06:33 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Xin Zhao <jackzxcui1989@163.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Boqun Feng <boqun.feng@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-s390@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-pm@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/15 v2] tick/sched: Refactor idle cputime accounting
Message-ID: <aYy3GTXDwZFM3VLy@localhost.localdomain>
References: <20260206142245.58987-1-frederic@kernel.org>
 <f5f7cc0e-81c1-49c4-9bfa-61b111c69ae2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5f7cc0e-81c1-49c4-9bfa-61b111c69ae2@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42515-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,linaro.org,kernel.org,redhat.com,163.com,nvidia.com,gmail.com,suse.de,arm.com,google.com,ellerman.id.au,linutronix.de,siemens.com,infradead.org,goodmis.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B722212669E
X-Rspamd-Action: no action

Le Wed, Feb 11, 2026 at 07:13:45PM +0530, Shrikanth Hegde a écrit :
> Hi Frederic,
> Gave this series a spin on the same system as v1.
> 
> On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
> > Hi,
> > 
> > After the issue reported here:
> > 
> >          https://lore.kernel.org/all/20251210083135.3993562-1-jackzxcui1989@163.com/
> > 
> > It occurs that the idle cputime accounting is a big mess that
> > accumulates within two concurrent statistics, each having their own
> > shortcomings:
> > 
> > * The accounting for online CPUs which is based on the delta between
> >    tick_nohz_start_idle() and tick_nohz_stop_idle().
> > 
> >    Pros:
> >         - Works when the tick is off
> > 
> >         - Has nsecs granularity
> > 
> >    Cons:
> >         - Account idle steal time but doesn't substract it from idle
> >           cputime.
> > 
> >         - Assumes CONFIG_IRQ_TIME_ACCOUNTING by not accounting IRQs but
> >           the IRQ time is simply ignored when
> >           CONFIG_IRQ_TIME_ACCOUNTING=n
> > 
> >         - The windows between 1) idle task scheduling and the first call
> >           to tick_nohz_start_idle() and 2) idle task between the last
> >           tick_nohz_stop_idle() and the rest of the idle time are
> >           blindspots wrt. cputime accounting (though mostly insignificant
> >           amount)
> > 
> >         - Relies on private fields outside of kernel stats, with specific
> >           accessors.
> > 
> > * The accounting for offline CPUs which is based on ticks and the
> >    jiffies delta during which the tick was stopped.
> > 
> >    Pros:
> >         - Handles steal time correctly
> > 
> >         - Handle CONFIG_IRQ_TIME_ACCOUNTING=y and
> >           CONFIG_IRQ_TIME_ACCOUNTING=n correctly.
> > 
> >         - Handles the whole idle task
> > 
> >         - Accounts directly to kernel stats, without midlayer accumulator.
> > 
> >     Cons:
> >         - Doesn't elapse when the tick is off, which doesn't make it
> >           suitable for online CPUs.
> > 
> >         - Has TICK_NSEC granularity (jiffies)
> > 
> >         - Needs to track the dyntick-idle ticks that were accounted and
> >           substract them from the total jiffies time spent while the tick
> >           was stopped. This is an ugly workaround.
> > 
> > Having two different accounting for a single context is not the only
> > problem: since those accountings are of different natures, it is
> > possible to observe the global idle time going backward after a CPU goes
> > offline, as reported by Xin Zhao.
> > 
> > Clean up the situation with introducing a hybrid approach that stays
> > coherent, fixes the backward jumps and works for both online and offline
> > CPUs:
> > 
> > * Tick based or native vtime accounting operate before the tick is
> >    stopped and resumes once the tick is restarted.
> > 
> > * When the idle loop starts, switch to dynticks-idle accounting as is
> >    done currently, except that the statistics accumulate directly to the
> >    relevant kernel stat fields.
> > 
> > * Private dyntick cputime accounting fields are removed.
> > 
> > * Works on both online and offline case.
> > 
> > * Move most of the relevant code to the common sched/cputime subsystem
> > 
> > * Handle CONFIG_IRQ_TIME_ACCOUNTING=n correctly such that the
> >    dynticks-idle accounting still elapses while on IRQs.
> > 
> > * Correctly substract idle steal cputime from idle time
> > 
> > Changes since v1:
> > 
> > - Fix deadlock involving double seq count lock on idle
> > 
> > - Fix build breakage on powerpc
> > 
> > - Fix build breakage on s390 (Heiko)
> > 
> > - Fix broken sysfs s390 idle time file (Heiko)
> > 
> > - Convert most ktime usage here into u64 (Peterz)
> > 
> > - Add missing (or too implicit) <linux/sched/clock.h> (Peterz)
> > 
> > - Fix whole idle time acccounting breakage due to missing TS_FLAG_ set
> >    on idle entry (Shrikanth Hegde)
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	timers/core-v2
> > 
> > HEAD: 21458b98c80a0567d48131240317b7b73ba34c3c
> > Thanks,
> > 	Frederic
> 
> idle and runtime utilization with mpstat while running stress-ng looks
> correct now.
> 
> However, when running hackbench I am noticing the below data. hackbench shows
> severe regressions.
> 
> base: tip/master at 9c61ebbdb587a3950072700ab74a9310afe3ad73.
> (nit: patch 7 is already part of tip. so skipped applying it)
> +-----------------------------------------------+-------+---------+-----------+
> | Test                                          | base  | +series | % Diff    |
> +-----------------------------------------------+-------+---------+-----------+
> | HackBench Process 10 groups                   |  2.23 |  3.05   |   -36.77%  |
> | HackBench Process 20 groups                   |  4.17 |  5.82   |   -39.57%  |
> | HackBench Process 30 groups                   |  6.04 |  8.49   |   -40.56%  |
> | HackBench Process 40 groups                   |  7.90 | 11.10   |   -40.51%  |
> | HackBench thread 10                           |  2.44 |  3.36   |   -37.70%  |
> | HackBench thread 20                           |  4.57 |  6.35   |   -38.95%  |
> | HackBench Process(Pipe) 10                    |  1.76 |  2.29   |   -30.11%  |
> | HackBench Process(Pipe) 20                    |  3.49 |  4.76   |   -36.39%  |
> | HackBench Process(Pipe) 30                    |  5.21 |  7.13   |   -36.85%  |
> | HackBench Process(Pipe) 40                    |  6.89 |  9.31   |   -35.12%  |
> | HackBench thread(Pipe) 10                     |  1.91 |  2.50   |   -30.89%  |
> | HackBench thread(Pipe) 20                     |  3.74 |  5.16   |   -37.97%  |
> +-----------------------------------------------+-------+---------+-----------+
> 
> I have these in .config and I don't have nohz_full or isolated cpus.
> 
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=y
> 
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_SCHED_AVG_IRQ=y
> 
> I did a git bisect and below is what it says.
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [6821315886a3b5267ea31d29dba26fd34647fbbc] sched/cputime: Handle dyntick-idle steal time correctly
> git bisect bad 6821315886a3b5267ea31d29dba26fd34647fbbc
> # status: waiting for good commit(s), bad commit known
> # good: [9c61ebbdb587a3950072700ab74a9310afe3ad73] Merge branch into tip/master: 'x86/sev'
> git bisect good 9c61ebbdb587a3950072700ab74a9310afe3ad73
> # good: [dc8bb3c84d162f7d9aa6becf9f8392474f92655a] tick/sched: Remove nohz disabled special case in cputime fetch
> git bisect good dc8bb3c84d162f7d9aa6becf9f8392474f92655a
> # good: [5070a778a581cd668f5d717f85fb22b078d8c20c] tick/sched: Account tickless idle cputime only when tick is stopped
> git bisect good 5070a778a581cd668f5d717f85fb22b078d8c20c
> # bad: [1e0ccc25a9a74b188b239c4de716fde279adbf8e] sched/cputime: Provide get_cpu_[idle|iowait]_time_us() off-case
> git bisect bad 1e0ccc25a9a74b188b239c4de716fde279adbf8e
> # bad: [ee7c735b76071000d401869fc2883c451ee3fa61] tick/sched: Consolidate idle time fetching APIs
> git bisect bad ee7c735b76071000d401869fc2883c451ee3fa61
> # first bad commit: [ee7c735b76071000d401869fc2883c451ee3fa61] tick/sched:
> Consolidate idle time fetching APIs

I see. Can you try this? (or fetch timers/core-v3 from my tree)
Perhaps that mistake had some impact on cpufreq.

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 057fdc00dbc6..08550a6d9469 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -524,7 +524,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 	do_div(res, NSEC_PER_USEC);
 
 	if (last_update_time)
-		*last_update_time = res;
+		*last_update_time = ktime_to_us(now);
 
 	return res;
 }




