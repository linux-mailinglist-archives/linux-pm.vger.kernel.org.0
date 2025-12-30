Return-Path: <linux-pm+bounces-40032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A792ACE937A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 10:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746353003F4D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A625CC40;
	Tue, 30 Dec 2025 09:31:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CFE14A8E;
	Tue, 30 Dec 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087063; cv=none; b=u6ATX2IJEGoBwmXLQ3o12votsNHLgjiw8wDTa20rFa+2gA9JSIz7GBVLbQg3P0y3SUf0cchKcUWPkx+6ZuT27WLg9p4WW1D489lbPN+tFeGB6ZXsS2Lt/ydZBYumrh/BXfO3uEcYGK4QBky+G54mWWQXSoB7ouPe0CU27yDLmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087063; c=relaxed/simple;
	bh=VfoAQJDydd9sDjNJrYs/MqBAGuxjR17c1RgwpHzRgLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X5S8ehbfGhueFRjUgsaa7wpvTWUbpcf36nRAfKDSnjhXFjoKdel2hZVc2uliOvglPcOL2t+KR32kTso8XiYtNG3db5rYEzKroThn3xgelL6Ckdyfdc8sZ9381Kbj2Jn28Lj/Cr4SFizKnV8qC2JBljpzED1tmMgbZqDqLCFRLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63E90497;
	Tue, 30 Dec 2025 01:30:47 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.11.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94DA93F63F;
	Tue, 30 Dec 2025 01:30:52 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com
Cc: rafael@kernel.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qperret@google.com,
	sven@svenpeter.dev,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/1] sched: Ignore overutilized by lone task on max-cap CPU
Date: Tue, 30 Dec 2025 09:30:36 +0000
Message-Id: <20251230093037.427141-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm trying to deliver on my overdue promise of redefining overutilized state.
My investigation basically lead to redefinition of overutilized state
bringing very little hard improvements, while it comes with at least
some risk of worsening platforms and workload combinations I might've
overlooked, therefore I only concentrate on one, the least
controversial, for now.
When a task is alone on a max-cap CPU there's no reason to let it
trigger OU because it will only ever be placed on another max-cap CPU,
as such we skip setting overutilized in such a scenario in a careful
way, namely still letting it trigger if there's any other task or the
capacity is (usually temporarily) reduced because of system or thermal
pressure.
On platforms common in phones this strategy didn't prove useful, as
even one such a task would already be the majority of the phones'
thermal (or even power budget) and therefore such a situation not being
very stable and continuing to attempt EAS on the other CPUs seemed
unnecessary.
OTOH there are more and more systems (e.g. apple silicon,
radxa orion o6, x86 hybrids) where such a situation could be sustained
and there are also many more max-cap CPUs, so more possibilites for the
patch to trigger.

For further information and the OSPM discussion see:
https://www.youtube.com/watch?v=N0tZ8GhhQzc

Radxa orion o6 (capacities: 1024, 279, 279, 279, 279, 905, 905, 866, 866, 984, 984, 1024):
Mean of 10 Geekbench6.3 iterations (all values are the mean)
+------------+--------+---------+-------+--------------+
| Test       | patch  | score   | OU %  | OU triggers  |
+------------+--------+---------+-------+--------------+
| GB6 Single | patch  | 1182.4  | 26.14 | 1942.4       |
| GB6 Single | base   | 1186.9  | 71.23 |  573.0       |
+------------+--------+---------+-------+--------------+
| GB6 Multi  | patch  | 5227.7  | 44.11 |  984.5       |
| GB6 Multi  | base   | 5395.6  | 53.17 |  773.1       |
+------------+--------+---------+-------+--------------+
(OU triggers are overutilized rd 0->1 transitions)
GB6 Multi score stdev is 43 for base.

RK3399 ((384, 384, 384, 384)(1024, 1024))
stress-ng --cpu X --timeout 60s
Mean of 10 iterations
+-----------+--------+------+--------------+
| stress-ng | patch  | OU % | OU triggers  |
+-----------+--------+------+--------------+
| 1x        | patch  | 0.01 | 10.5         |
| 1x        | base   | 99.7 |  4.4         |
+-----------+--------+------+--------------+
| 2x        | patch  | 0.01 | 13.8         |
| 2x        | base   | 99.7 |  5.3         |
+-----------+--------+------+--------------+
| 3x        | patch  | 99.8 |  4.1         |
| 3x        | base   | 99.8 |  4.6         |
+-----------+--------+------+--------------+
(System only has 2 1024-capacity CPUs, so for 3x stress-ng
patch and base are intended to behave the same.)

M1 Pro ((485, 485) (1024, 1024, 1024) (1024, 1024, 1024))
(backported to the 6.17-based asahi kernel)
+-----------+--------+-------+--------------+
| stress-ng | patch  | OU %  | OU triggers  |
+-----------+--------+-------+--------------+
| 1x        | patch  |  8.26 |        432.0 |
| 1x        | base   | 99.14 |          4.2 |
+-----------+--------+-------+--------------+
| 2x        | patch  |  8.79 |        470.2 |
| 2x        | base   | 99.21 |          3.8 |
+-----------+--------+-------+--------------+
| 4x        | patch  |  8.99 |        475.2 |
| 4x        | base   | 99.17 |          4.6 |
+-----------+--------+-------+--------------+
| 6x        | patch  |  8.81 |        478.8 |
| 6x        | base   | 99.14 |          5.0 |
+-----------+--------+-------+--------------+
| 7x        | patch  | 99.21 |          4.0 |
| 7x        | base   | 99.27 |          4.2 |
+-----------+--------+-------+--------------+

Mean of 20 Geekbench 6.3 iterations
+------------+--------+---------+-------+--------------+
| Test       | patch  | score   | OU %  | OU triggers  |
+------------+--------+---------+-------+--------------+
| GB6 Single | patch  |  2296.9 |  3.99 |        669.4 |
| GB6 Single | base   |  2295.8 | 50.06 |         28.4 |
+------------+--------+---------+-------+--------------+
| GB6 Multi  | patch  | 10621.8 | 18.77 |        636.4 |
| GB6 Multi  | base   | 10686.8 | 28.72 |         66.8 |
+------------+--------+---------+-------+--------------+

Energy numbers are trace-based (lisa.estimate_from_trace()):
GB6 Single -12.63% energy average (equal score)
GB6 Multi +1.76% energy average (for equal score runs)

No changes observed with geekbench6 on a Pixel 6 6.12-based with patch backported.

Functional test:
Using the above described M1 Pro I created an rt-app workload [1]:
Workload:
- tskbusy: periodic 100% duty, period 1s, duration 10s (single always-running task)
- tsk_{a..d}: periodic 5% duty, 16ms period, duration 10s (four small periodic tasks)
Target system: 8 CPUs (0-7), 2 little (cpu0 & cpu1), 6 big
Metric: per-task CPU residency (seconds) over the 10s run
OU metric: time spent in overutilized state / total time; Number of
OU 0->1 transitions (triggers).

Case A Mainline:
Small task CPU residency (s), 10s run
task   cpu0    cpu1    cpu2    cpu3    cpu4    cpu5    cpu6    cpu7    total
tsk_a  0.124   0.000   0.000   0.000   0.035   1.791   0.492   0.001   2.444
tsk_b  0.002   0.000   0.500   0.000   0.000   0.001   0.004   0.000   0.507
tsk_c  0.000   0.000   0.000   0.000   0.001   0.000   1.895   0.630   2.526
tsk_d  0.000   0.389   0.001   0.000   0.450   0.000   0.000   0.000   0.840

(Little CPUs 0 & 1 rarely get picked for the small tasks due to CAS' task
placement, which isn't deterministically "always picking big CPUs", but since
they make up 6/8 of them this is the common case.)

Overutilized:
- OU time = 10.0s / 11.0s  (ratio 0.909)
- OU triggers = 7

Case B Patch:
Small task CPU residency (s), 10s run
task   cpu0    cpu1    cpu2    cpu3    cpu4    cpu5    cpu6    cpu7    total
tsk_a  0.055   1.907   0.006   0.012   0.002   0.001   0.000   0.005   1.987
tsk_b  1.845   0.115   0.014   0.000   0.004   0.002   0.000   0.000   1.981
tsk_c  0.914   1.069   0.007   0.000   0.004   0.005   0.000   0.000   1.999
tsk_d  1.000   0.985   0.004   0.005   0.000   0.000   0.000   0.000   1.995

Overutilized:
- OU time = 0.1s / 11.2s (ratio 0.007)
- OU triggers = 57

(Little CPUs 0 & 1 get picked by the vast majority of wakeups and aren't migrated
to the big CPUs.)


[1]
LISA's RTApp workload generation description:

rtapp_profile = {
    f'tskbusy': RTAPhase(
        prop_wload=PeriodicWload(
            duty_cycle_pct=100,
            period=1,
            duration=10,
        )
    ),
    f'tsk_a': RTAPhase(
        prop_wload=PeriodicWload(
            duty_cycle_pct=5,
            period=16e-3,
            duration=10,
        )
    ),
    f'tsk_b': RTAPhase(
        prop_wload=PeriodicWload(
            duty_cycle_pct=5,
            period=16e-3,
            duration=10,
        )
    ),
    f'tsk_c': RTAPhase(
        prop_wload=PeriodicWload(
            duty_cycle_pct=5,
            period=16e-3,
            duration=10,
        )
    ),
    f'tsk_d': RTAPhase(
        prop_wload=PeriodicWload(
            duty_cycle_pct=5,
            period=16e-3,
            duration=10,
        )
    )
}

Christian Loehle (1):
  sched/fair: Ignore OU for lone task on max-cap CPU

 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.34.1


