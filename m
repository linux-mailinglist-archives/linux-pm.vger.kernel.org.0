Return-Path: <linux-pm+bounces-821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4FD8098CD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 02:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D185B20A1A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 01:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90BC136F;
	Fri,  8 Dec 2023 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="sl7OU0Zm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E3410E3
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 17:52:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-333536432e0so1467687f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 17:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702000374; x=1702605174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMfUFkF8OyeZJffEZnLExwZb8TXV6He0+EMaT/NjaTI=;
        b=sl7OU0ZmE7gIOvjMdPFcsEnl00n3W6W8rLBqFJDKqXWHkgyjmnipobNvE5QYVAzJC0
         wV7JyKkFEyiO7XlC9AYMLRwRjmqBeUFPTwE6Yy+/CXyyFYEgIn9fDp9lG4/ZXRJKwCc0
         7yF9UPRTYdEPeFfbfkOPkrIUZnoAKmGoa/ie3FGGWzbm/YmXP7vpsoCKZ/RIQtQdOUul
         pNBOhzPz+7f+wR+rNFbivJEIlu4z9Qdaz1scOEurPhNYqrB7T+z7h6vAJGy0zE/G3N9K
         I4OiUgNgcP92yeCK3wiFemri2B2DNKeTBvDA11UHbqZ+LlGCWgTKBAXg95IuyEoaCPPe
         CfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702000374; x=1702605174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMfUFkF8OyeZJffEZnLExwZb8TXV6He0+EMaT/NjaTI=;
        b=L3+5goZb5IaqnYPZb6xiSA0Cu5Mi9ShueFII5l0pDFw/M0pjJrHeyEb4R2uJNx6o1H
         EOPnqmjWDG03Uo9F7Dbo4bh4ib33Mv/5tnB2HEnHgYLirqhKDj/nSILt5IPo3SGoifpZ
         zTaaei+YlwEOaqLRJmb3LjyLSwzMcKvZ81nNUJTOqO26iH4lWkJhTKvYS1PP9wY0g7aO
         lljybokKoxL6TDvm2Mz6Uq8uEXf1PJph/hH6J5xpdwiy5h34M8gjldlsYNdLJs7PCbut
         lKV4B13j+Hj4apTbI0dabVvP27CvWe11uxV0DNJZCf49vAUwCpwvthmxhjIMONjrTztY
         JW1Q==
X-Gm-Message-State: AOJu0YypMDdsPxMyfN4V95ACKnMKotPSBXv2ynwzpZSkkQTpR+dw9qc4
	BQuo/1v0rkaXTt/KM1RCqyxBrw==
X-Google-Smtp-Source: AGHT+IGip2mPFWVR80n49xULntwLXIZqEAxv05b2RduOFuW8P9KcKGN30qEBzfCTAHAjbt4o51euYw==
X-Received: by 2002:a5d:4389:0:b0:333:4dbe:1121 with SMTP id i9-20020a5d4389000000b003334dbe1121mr1748945wrq.137.1702000374070;
        Thu, 07 Dec 2023 17:52:54 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id s12-20020adf978c000000b003333a0da243sm902521wrb.81.2023.12.07.17.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:52:53 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/4] sched: cpufreq: Remove uclamp max-aggregation
Date: Fri,  8 Dec 2023 01:52:38 +0000
Message-Id: <20231208015242.385103-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the practical issues that has risen up when trying to deploy uclamp in
practice, was making uclamp_max more effective. Due to max-aggregation at rq,
the effective uclamp_max value for a capped task can easily be lifted by any
task that gets enqueued. Which can be often enough in practice to cause it to
be ineffective and leaving much to be desired.

One of the solutions attempted out of tree was to filter out the short running
tasks based on sched_slice(), and this proved to be effective enough

	https://android-review.googlesource.com/c/kernel/common/+/1914696

But the solution is not upstream friendly as it introduces more magic
thresholds and not sure how it would work after EEVDF changes got merged in.

In principle, the max-aggregation is required to address the frequency hint
part of uclamp. We don't need this at wake up path as the per-task value should
let us know with the task fits a CPU or not on HMP systems.

As pointed out in remove magic hardcoded margins series [1], the limitation is
actually in the governor/hardware where we are constrained to changing
frequencies at a high rate, which uclamp usage can induce.

To address the problems, we can move the problem to be a cpufreq governor issue
to deal with whatever limitation it has to respond to task's perf requirement
hints. This means we need to tell the governor that we need a frequency update
to cater for a task perf hints, hence adding a new SCHED_CPUFREQ_PERF_HINTS
flag.

With the new flag, we can then send special updates to cpufreq governor on
context switch *if* it has perf requirements that aren't met already.

The governor can then choose to honour or ignore these request based on
whatever criteria it sees fit. For schedutil I made use of the new
approximate_util_avg() to create a threshold based on rate_limit_us to ignore
perf requirements for tasks that their util_avg tells us they were historically
running shorter than hardware's ability to change frequency. Which means they
will actually go back to sleep before they see the freq change, so honouring
their request is pointless, hence we ignore it.

Instead of being exact, I made an assumption that the task has to run for at
least 500us above rate_limit_us which is magical but what I've seen in practice
as a meaningful runtime where task can actually do meaningful work that is
worthwhile. But this exact definition of the threshold is subject for debate.
We can make it 1.5 rate_limit_us for example. I preferred the absolute number
as even in lower end hardware; I think this is a meaningful unit of time for
producing meaningful results that can make can impact. There's the hidden
assumption that most modern hardware already has fast enough DVFS. Absolute
number fails for super fast hardware though..

This allows us to remove uclamp max-aggregation logic completely and moves the
problem to be a cpufreq governor problem instead. Which I think is the right
thing to do as the scheduler was overcompensating for what is in reality
a cpufreq governor limitation and policy. We just need to improve the
interface with the governor.

Implementing different policies/strategies to deal with the problem would be
easier now that the problem space has moved to the governor. And it keeps
scheduler code clean and focus on things that matter from scheduling point of
view only.

For example max-aggregation can be implemented in the governor by adding new
flag when sending cpufreq_update_util() at enqueue/dequeue_task(). Not that
I think it's a good idea, but the possibility is there. Especially if platforms
like x86 has a lot of intelligence in firmware and they'd like to implement
something smarter at that level. They'll just need to improve the interface
with the governor.

===

This patch is based on remove margins series [1] and data is collected it
against it as a baseline.

Testing on pixel 6 with mainline(ish) kernel

==

Speedometer browser benchmark

       | baseline  | 1.25 headroom |   patch   | patch + 1.25 headroom
-------+-----------+---------------+-----------+---------------------
score  |  108.03   |     135.72    |   108.09  |    137.47
-------+-----------+---------------+-----------+---------------------
power  |  1204.75  |    1451.79    |  1216.17  |    1484.73
-------+-----------+---------------+-----------+---------------------

No regressions.

===

UiBench

       | baseline  | 1.25 headroom |   patch   | patch + 1.25 headroom
-------+-----------+---------------+-----------+---------------------
jank   |    68.0   |      56.0     |    65.6   |    57.3
-------+-----------+---------------+-----------+---------------------
power  |   146.54  |     164.49    |   144.91  |    167.57
-------+-----------+---------------+-----------+---------------------

No regressions.

===

Spawning 8 busyloop threads each pinned to a CPU with uclamp_max set to low-ish
OPP

```
adb shell "uclampset -M 90 taskset -a 01 cat /dev/zero > /dev/null &" &
adb shell "uclampset -M 90 taskset -a 02 cat /dev/zero > /dev/null &" &
adb shell "uclampset -M 90 taskset -a 04 cat /dev/zero > /dev/null &" &
adb shell "uclampset -M 90 taskset -a 08 cat /dev/zero > /dev/null &" &
adb shell "uclampset -M 270 taskset -a 10 cat /dev/zero > /dev/null &" &
adb shell "uclampset -M 270 taskset -a 20 cat /dev/zero > /dev/null &" &
adb shell "uclampset -M 670 taskset -a 40 cat /dev/zero > /dev/null &" &
adb shell "uclampset -M 670 taskset -a 80 cat /dev/zero > /dev/null &" &
```

And running speedometer for a single iteration

       | baseline  |   patch   |
-------+-----------+-----------+
score  |   73.44   |   75.62   |
-------+-----------+-----------+
power  |   520.46  |   489.49  |
-------+-----------+-----------+

Similar score at lower power.

Little's Freq Residency:

         | baseline  |   patch   |
---------+-----------+-----------+
OPP@90   |   29.59%  |   49.25%  |
---------+-----------+-----------+
OPP@max  |   40.02%  |   12.31%  |
---------+-----------+-----------+

Mid's Freq Residency:

         | baseline  |   patch   |
---------+-----------+-----------+
OPP@270  |   50.02%  |   77.53%  |
---------+-----------+-----------+
OPP@max  |   49.17%  |   22.46%  |
---------+-----------+-----------+

Big's Freq Residency:

         | baseline  |   patch   |
---------+-----------+-----------+
OPP@670  |   46.43%  |   54.44%  |
---------+-----------+-----------+
OPP@max  |   1.76%   |   4.57%   |
---------+-----------+-----------+

As you can see the residency at the capped frequency has increased considerably
for all clusters. The time spent running at max frequency is reduced
significantly for little and mid. For big there's a slight increase. Both
numbers are suspiciously low. With the busy loops in background; these cores
are more subject to throttling. So the higher number indicates we've been
throttled less.

---

Patch 1 clean ups the code that sends cpufreq_update_util() to be more
intentional and less noisy.

Patch 2 removes uclamp-max aggregation and implements sending
cpufreq_update_util() updates at context switch instead.

Patch 3 implements the logic to filter short running tasks compared to
rate_limit_us and add perf hint flag at task_tick_fair().

Patch 4 updates uclamp docs to reflect the new changes.

[1] https://lore.kernel.org/lkml/20231208002342.367117-1-qyousef@layalina.io/

Thanks!

--
Qais Yousef

Qais Yousef (4):
  sched/fair: Be less aggressive in calling cpufreq_update_util()
  sched/uclamp: Remove rq max aggregation
  sched/schedutil: Ignore update requests for short running tasks
  sched/documentation: Remove reference to max aggregation

 Documentation/scheduler/sched-util-clamp.rst | 239 ++---------
 include/linux/sched.h                        |  16 -
 include/linux/sched/cpufreq.h                |   3 +-
 init/Kconfig                                 |  31 --
 kernel/sched/core.c                          | 426 +++----------------
 kernel/sched/cpufreq_schedutil.c             |  61 ++-
 kernel/sched/fair.c                          | 157 ++-----
 kernel/sched/rt.c                            |   4 -
 kernel/sched/sched.h                         | 150 ++-----
 9 files changed, 244 insertions(+), 843 deletions(-)

-- 
2.34.1


