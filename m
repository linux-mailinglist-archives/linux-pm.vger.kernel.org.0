Return-Path: <linux-pm+bounces-42208-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qATnJUb5hWlEIwQAu9opvQ
	(envelope-from <linux-pm+bounces-42208-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:23:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04978FEC22
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95923300C58B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE63EFD04;
	Fri,  6 Feb 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHOkkP+g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57A212542;
	Fri,  6 Feb 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387777; cv=none; b=d+M9DdgrWt2jF9KlksZ6j2FE1JIP3yHyQZs5SWb9Lns/nX6Jxqwms/Np9NYpZJbOmt3Dh2F4ptedk7bB510a6ESawWx8wGZflT7KNn73MHEoJ/fpCMqP1YNIWgR8sPotlGnueCxN8E8ZOzlm7ifhQ6uTIkiJ7F/IYyjxPEmvhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387777; c=relaxed/simple;
	bh=5RNRg1BFmFbwFXPge2vBQ/jTNMfqGWngL8N/C51PA/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2adl0pBeMmTFRWa4Hiyhp9440ryfcfviYlCOI6a+xLUHLcmMaHsdRfHmDbsFAw3I464qZ1xyJeMGexNMtwybGw+h7bnpkcc/Vl+N6PcksnV2tN/E6IlBsQCd+qbqECEFAVKG6yejlT1iWqzzFuzEXXPLNACuqeKZ6wVbZhafm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHOkkP+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00D4C116C6;
	Fri,  6 Feb 2026 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387777;
	bh=5RNRg1BFmFbwFXPge2vBQ/jTNMfqGWngL8N/C51PA/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=gHOkkP+gSugbWlo8bJ3uh+YpAx9mDAXAt1cR8dVvhEzYIgOtVBeZsQp64HqmFTY9i
	 YBBA5G/vgdPOgEYP7STZwjGxeEg/GvrZJ3LFK02feY+CrMC99Kh5eSbysAP37BZYwz
	 ypvjlwZSiruBiiudWtg4RNrxhfrSiT8T8WKOZ85y+nObwyke/zdwbm56GMuw17QM0c
	 98g6uujXQlFBaoB6dgRUer8icV5B5JOP6pGn7iq3h4W1M+A0t8ciXwxHh2ptcH5XZP
	 jTswPP1hbzx0c0qPUOY7y1auZxM+C4s+7fvbqq5GcjikUbtO7fRRUXurwwWg+ix21O
	 wW6HZLFnaK26g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mel Gorman <mgorman@suse.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-pm@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 00/15 v2] tick/sched: Refactor idle cputime accounting
Date: Fri,  6 Feb 2026 15:22:30 +0100
Message-ID: <20260206142245.58987-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linaro.org,redhat.com,163.com,nvidia.com,gmail.com,suse.de,arm.com,google.com,ellerman.id.au,linutronix.de,vger.kernel.org,siemens.com,infradead.org,goodmis.org,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[36];
	TAGGED_FROM(0.00)[bounces-42208-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04978FEC22
X-Rspamd-Action: no action

Hi,

After the issue reported here:

        https://lore.kernel.org/all/20251210083135.3993562-1-jackzxcui1989@163.com/

It occurs that the idle cputime accounting is a big mess that
accumulates within two concurrent statistics, each having their own
shortcomings:

* The accounting for online CPUs which is based on the delta between
  tick_nohz_start_idle() and tick_nohz_stop_idle().

  Pros:
       - Works when the tick is off

       - Has nsecs granularity

  Cons:
       - Account idle steal time but doesn't substract it from idle
         cputime.

       - Assumes CONFIG_IRQ_TIME_ACCOUNTING by not accounting IRQs but
         the IRQ time is simply ignored when
         CONFIG_IRQ_TIME_ACCOUNTING=n

       - The windows between 1) idle task scheduling and the first call
         to tick_nohz_start_idle() and 2) idle task between the last
         tick_nohz_stop_idle() and the rest of the idle time are
         blindspots wrt. cputime accounting (though mostly insignificant
         amount)

       - Relies on private fields outside of kernel stats, with specific
         accessors.

* The accounting for offline CPUs which is based on ticks and the
  jiffies delta during which the tick was stopped.

  Pros:
       - Handles steal time correctly

       - Handle CONFIG_IRQ_TIME_ACCOUNTING=y and
         CONFIG_IRQ_TIME_ACCOUNTING=n correctly.

       - Handles the whole idle task

       - Accounts directly to kernel stats, without midlayer accumulator.

   Cons:
       - Doesn't elapse when the tick is off, which doesn't make it
         suitable for online CPUs.

       - Has TICK_NSEC granularity (jiffies)

       - Needs to track the dyntick-idle ticks that were accounted and
         substract them from the total jiffies time spent while the tick
         was stopped. This is an ugly workaround.

Having two different accounting for a single context is not the only
problem: since those accountings are of different natures, it is
possible to observe the global idle time going backward after a CPU goes
offline, as reported by Xin Zhao.

Clean up the situation with introducing a hybrid approach that stays
coherent, fixes the backward jumps and works for both online and offline
CPUs:

* Tick based or native vtime accounting operate before the tick is
  stopped and resumes once the tick is restarted.

* When the idle loop starts, switch to dynticks-idle accounting as is
  done currently, except that the statistics accumulate directly to the
  relevant kernel stat fields.

* Private dyntick cputime accounting fields are removed.

* Works on both online and offline case.

* Move most of the relevant code to the common sched/cputime subsystem

* Handle CONFIG_IRQ_TIME_ACCOUNTING=n correctly such that the
  dynticks-idle accounting still elapses while on IRQs.

* Correctly substract idle steal cputime from idle time

Changes since v1:

- Fix deadlock involving double seq count lock on idle

- Fix build breakage on powerpc

- Fix build breakage on s390 (Heiko)

- Fix broken sysfs s390 idle time file (Heiko)

- Convert most ktime usage here into u64 (Peterz)

- Add missing (or too implicit) <linux/sched/clock.h> (Peterz)

- Fix whole idle time acccounting breakage due to missing TS_FLAG_ set
  on idle entry (Shrikanth Hegde)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core-v2

HEAD: 21458b98c80a0567d48131240317b7b73ba34c3c
Thanks,
	Frederic
---

Frederic Weisbecker (15):
      sched/idle: Handle offlining first in idle loop
      sched/cputime: Remove superfluous and error prone kcpustat_field() parameter
      sched/cputime: Correctly support generic vtime idle time
      powerpc/time: Prepare to stop elapsing in dynticks-idle
      s390/time: Prepare to stop elapsing in dynticks-idle
      tick/sched: Unify idle cputime accounting
      cpufreq: ondemand: Simplify idle cputime granularity test
      tick/sched: Remove nohz disabled special case in cputime fetch
      tick/sched: Move dyntick-idle cputime accounting to cputime code
      tick/sched: Remove unused fields
      tick/sched: Account tickless idle cputime only when tick is stopped
      tick/sched: Consolidate idle time fetching APIs
      sched/cputime: Provide get_cpu_[idle|iowait]_time_us() off-case
      sched/cputime: Handle idle irqtime gracefully
      sched/cputime: Handle dyntick-idle steal time correctly

 arch/powerpc/kernel/time.c         |  41 +++++
 arch/s390/include/asm/idle.h       |  14 +-
 arch/s390/kernel/idle.c            |  19 ++-
 arch/s390/kernel/vtime.c           |  57 ++++++-
 drivers/cpufreq/cpufreq.c          |  29 +---
 drivers/cpufreq/cpufreq_governor.c |   6 +-
 drivers/cpufreq/cpufreq_ondemand.c |   7 +-
 drivers/macintosh/rack-meter.c     |   2 +-
 fs/proc/stat.c                     |  40 +----
 fs/proc/uptime.c                   |   8 +-
 include/linux/kernel_stat.h        |  76 ++++++++--
 include/linux/tick.h               |   6 +-
 include/linux/vtime.h              |  22 ++-
 kernel/rcu/tree.c                  |   9 +-
 kernel/rcu/tree_stall.h            |   7 +-
 kernel/sched/cputime.c             | 304 +++++++++++++++++++++++++++++++------
 kernel/sched/idle.c                |  13 +-
 kernel/sched/sched.h               |   1 +
 kernel/time/hrtimer.c              |   2 +-
 kernel/time/tick-internal.h        |   2 -
 kernel/time/tick-sched.c           | 210 ++++++-------------------
 kernel/time/tick-sched.h           |  12 --
 kernel/time/timer.c                |   2 +-
 kernel/time/timer_list.c           |   6 +-
 scripts/gdb/linux/timerlist.py     |   4 -
 25 files changed, 525 insertions(+), 374 deletions(-)

