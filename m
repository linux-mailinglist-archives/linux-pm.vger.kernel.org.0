Return-Path: <linux-pm+bounces-22059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C62A355C5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 05:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3F93AD91E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 04:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F76F099;
	Fri, 14 Feb 2025 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="f0YQLu63"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E982753E8
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507441; cv=none; b=ZBPkzBW2OcZNz9fs6weJEwGLuuCwA0Z8tOIgPB5DfzLQq/2Czu+wftOgi1Fit4cTp7Uuiqnb+Tv9u2gUr3EXi927s5gEJoiyQStlxTsBc0eATahExkoeit4Azs9FUW0zj/fokxpnjSEg/TT4M77UHVFVYfeKrpzWzOLGydJfNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507441; c=relaxed/simple;
	bh=hy1X58FkgRVoWxDZ6ASLhMm6doK7oWaa2Wg/fPypQJQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WjvaclWgCGJpm5fSbCQrkWTf4MCdZv57pf5k7e3Uh8t2w2Ejr2eWFca5MuISilX++eRxX5/juTeBLusAOyqIUsdSw/fLRp2dXqDysJW8PziZPog9zOjcG4YKZrmPV+eSuDr2Q7OiEwm+zstU1YIiogC0/g0Xw6GGroWi90SnaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=f0YQLu63; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso2635146a91.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 20:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1739507438; x=1740112238; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu2gq6TNnoi9/irMHl5bO+lDk+CqNPAGsiveEaM2C0U=;
        b=f0YQLu63dSQx73evT/200mIh3NsroH2ALzjrKnuN+Wcdo6o+JpSO2Z19vV4+FF9Wcz
         L4YiiO9Ald52IBBFMDspOJnQHkgZJSd/YJN67fLKxf6sXDcXM/blYfGHg2zUwP9wvbkn
         /vDMwAcOiMjPQQ5RrUY2L7R9A07LqEGoUOmAq5zssrO++w84e+jnb6x4tCh/Jvhmzfqv
         dO9iNvi/YY7cMqg0gDmg47Vd6MWHeKKHFVScD/lx7Cm9zPquntbP+6mhM8f7M/zp98ev
         nt1Nhma/7aNdjgxHCs1gIrpBS+WpQ/AtEukZ5C2EJqvwsXPd3iEThcNgz+6EXuC9MVEQ
         bcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739507438; x=1740112238;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu2gq6TNnoi9/irMHl5bO+lDk+CqNPAGsiveEaM2C0U=;
        b=uPEvRyO5+2dKM0IizrzKnUboiwSmbRVaATBQUHdhXB7ZZUSq4ovX3+0qfXtK0SDcc6
         u+L8BNNCE3daP90lVenaNIgSs+cP3ofno4iyzUP2A+YbKeumexsyN3ReDzIG9oK42fgK
         qZhKOS2RblOTBYwpjBIKd7Q6Pct2n7hUF/xWc8eLhYobO2Gp/yRz8kxgPlZ5lmbB0VXy
         BmblEVJRw+2zRN/PH2V5GOhRGRwD+vCk9NeUSYmwsEjJzvz+OLNc85ybL0oPcRE7S7h4
         hRHJMsU9YCK8625f+ct96IibD2U3x026g4FTbTW5jTxTaqtrRKvooCKY8m57FP1BOmfH
         aYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1GHcZ886i8+n+Y1bGQw3Og0bAxknUnBKCGEUBhGWq85HdV9MHU43OALSslPFss5i2aHVPf/vCIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT/J9Wtsq9P5i6Eqk5iKtsD6xtCVlAGzGj3BzpEG5q3NM0XFK3
	5Zw0yQ1CCoCO66QC9HQTDmeAwjqhtkFlJfac+5U0GAWpWSrkLstUuV/TwQYCzak=
X-Gm-Gg: ASbGncsPDDjgyRsCg1X1MLi/sPfr90AZQf4ceCT/ohi6ax119WZCMd9LZatkrXGFZbW
	Ae3Zn4K2bXZ2eLtKmWwR8mLImKHo8v19bJ365o0y3D2EPNQuSTyqB1diRuL0JX2Imvx4f8+DKwI
	7091PQ3VFphOhWwMzYlo/Gq2nmORSB/czy20poQoCA5/LZork/2dnUBa9P4Uue5UPnIIdTVxxho
	ixy7iiRmJXyuEAUPBJVPw91Buni0I7Hbw9h1wXH34GyzCNXOcY496giNIA0Lg2mbmAWL74zhsdw
	tyu5ZhFDwInJ0g2AMrlVzOsdOXKzJrinIo52TcetcnN27btpVVelcDbm
X-Google-Smtp-Source: AGHT+IHsuK0nVvdalVRoWsZ2wiGKo0LZ440DAyXj3i8Z6FVDr1zv8PWsixQQaWTbAK0fa32OdRCDnA==
X-Received: by 2002:a17:90b:2810:b0:2ee:b2fe:eeeb with SMTP id 98e67ed59e1d1-2fbf5c57bdfmr12581779a91.22.1739507437595;
        Thu, 13 Feb 2025 20:30:37 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad2f20sm2134931a91.23.2025.02.13.20.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:30:36 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
	"'Linux PM'" <linux-pm@vger.kernel.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Aboorva Devarajan'" <aboorvad@linux.ibm.com>,
	"Doug Smythies" <dsmythies@telus.net>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <1916668.tdWV9SEqCh@rjwysocki.net>
Subject: RE: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful information when processing recent idle intervals
Date: Thu, 13 Feb 2025 20:30:40 -0800
Message-ID: <003b01db7e99$34791c50$9d6b54f0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD+BgZZG1yDo2pCGl+Ay1eM9EzyO7UBJVcQ

On 2025.02.06 06:22 Rafael J. Wysocki wrote:

> Hi Everyone,

Hi Rafael,

>
> This work had been triggered by a report that commit 0611a640e60a =
("eventpoll:
> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS =
metric of
... deleted ...

This is a long email. It contains test results for several recent idle =
governor patches:

cpuidle: teo: Cleanups and very frequent wakeups handling update
cpuidle: teo: Avoid selecting deepest idle state over-eagerly (Testing =
aborted, after the patch was dropped.)
cpuidle: menu: Avoid discarding useful information when processing =
recent idle intervals

Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
Distro: Ubuntu 24.04.1, server, no desktop GUI.

CPU frequency scaling driver: intel_pstate
HWP: disabled.
CPU frequency scaling governor: performance

Ilde driver: intel_idle
Idle governor: as per individual test
Idle states: 4: name : description:
   state0/name:POLL             desc:CPUIDLE CORE POLL IDLE
   state1/name:C1_ACPI          desc:ACPI FFH MWAIT 0x0
   state2/name:C2_ACPI          desc:ACPI FFH MWAIT 0x30
   state3/name:C3_ACPI          desc:ACPI FFH MWAIT 0x60

Legend:
teo-613: teo governor - Kernel 6.13: before "cpuidle: teo: Cleanups and =
very frequent wakeups handling update"
menu-613: menu governor - Kernel 6.13: before "cpuidle: teo: Cleanups =
and very frequent wakeups handling update"
teo-614: teo governor - Kernel 6.14-rc1: Includes cpuidle: teo: Cleanups =
and very frequent wakeups handling update
menu-614: menu governor - Kernel 6.14-rc1: Includes cpuidle: teo: =
Cleanups and very frequent wakeups handling update
teo-614-p: teo governor - Kernel 6.14-rc1-p: Includes "cpuidle: teo: =
Avoid selecting deepest idle state over-eagerly"
menu-614-p: menu governor - Kernel 6.14-rc1-p: Includes "cpuidle: menu: =
Avoid discarding useful information when processing recent idle =
intervals"

I do a set of tests adopted over some years now.
Readers may recall that some of the tests search over a wide range of =
operating conditions looking for areas to focus on in more detail.
One interesting observation is that everything seems to run slower than =
the last time I did this, June 2024, Kernel 6.10-rc2,
which was also slower than the time before that, August 2023, Kernel =
6.5-rc4.
There are some repatabilty issues with the tests.

I was unable to get the "cpuidle: teo: Cleanups and very frequent =
wakeups handling update" patch set to apply to kernel 6.13, and so just =
used kernel 6.14-rc1, but that means that all the other commits
between the kernel versions are included. This could cast doubt on the =
test results, and indeed some differences in test results are observed =
with the menu idle governor, which did not change.

Test 1: System Idle

Purpose: Basic starting point test. To observee and check an idle system =
for excessive power consumption.

teo-613: 1.752 watts (reference: 0.0%)
menu-613: 1.909 watts (+9.0%)
teo-614: 2.199 watts (+25.51%)   <<< Test flawed. Needs to be redone. =
Will be less.
teo-614-2: 2.112 watts (+17.05%) <<< Re-test of teo-614. (don't care =
about 0.4 watts)
menu-614: 1.873 watts (+6.91%)
teo-614-p: 9.401 watts (+436.6%)  <<< Very bad regression.
menu-614-p: 1.820 watts (+3.9%)

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/idle/perf/

Test 2: 2 core ping pong sweep:

Pass a token between 2 CPUs on 2 different cores.
Do a variable amount of work at each stop.
NOT a timer based test.

Purpose: To utilize the shallowest idle states
and observe the transition from using more of 1
idle state to another.

Results relative to teo-613 (negative is better):
        menu-613        teo-614         menu-614        menu-614-p
average -2.06%          -0.32%          -2.33%          -2.52%
max     9.42%           12.72%          8.29%           8.55%
min     -10.36%         -3.82%          -11.89%         -12.13%

No significant issues here. There are differences on idle state =
preferences.

Standard "fast" dwell test:

teo-613: average 3.826 uSec/loop reference
menu-613: average 4.159 +8.70%
teo-614: average 3.751 -1.94%
menu-614: average 4.076 +6.54%
menu-614-p: average 4.178 +9.21%

Intrestingly, teo-614 also uses a little less power.
Note that there is an offsetting region for the menu governor where it =
performs better
than teo, but it was not extracted and done as a dwell test.

Standard "medium dwell test:

teo-613: 12.241 average uSec/loop reference
menu-613: 12.251 average +0.08%
teo-614: 12.121 average -0.98%
menu-614: 12.123 average -0.96%
menu-614-p: 12.236 average -0.04%

Standard "slow" dwell test: Not done.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/loop-times.png=

http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/loop-times-rel=
ative.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/many-0-400000000-2/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/many-3000-100000000-2/

Test 3: 6 core ping pong sweep:

Pass a token between 6 CPUs on 6 different cores.
Do a variable amount of work at each stop.
NOT a timer based test.

Purpose: To utilize the midrange idle states
and observe the transitions between use of
idle states.

Note: This test has uncertainty in an area where the performance is =
bi-stable for all idle governors,
transitioning between much less power and slower performance and much =
more power and higher performance.
On either side of this area, the differences between all idle governors =
are small.
Only data from before this area (from results 1 to 95) was included in =
the below results.

Results relative to teo-613 (negative is better):
        teo-614 menu-613        menu-614        menu-614-p
average 1.60%   0.18%           0.02%           0.02%
max     5.91%   0.97%           1.12%           0.85%
min     -1.79%  -1.11%          -1.88%          -1.52%

A further dwell test was done in the area where teo-614 performed worse.
There was a slight regression in both performance and power:

teo-613: average 21.34068 uSec per loop
teo-614: average 20.55809 usec per loop 3.67% regression

teo-613: average 37.17577 watts.
teo-614: average 38.06375 watts. 2.3% regression.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times.png=

http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times-det=
ail-a.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times-det=
ail-b.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/dwell/perf/

Test 4: 12 CPU ping pong sweep:

Pass a token between all 12 CPUs.
Do a variable amount of work at each stop.
NOT a timer based test.

Purpose: To utilize the deeper idle states
and observe the transitions between use of
idle states.

This test was added last time at the request of Christian Loehle.

Note: This test has uncertainty in an area where the performance is =
bi-stable for all idle governors,
transitioning between much less power and slower performance and much =
more power and higher performance.
On either side of this area, the differences between all idle governors =
are small.

Only data from before this area (from results 1 to 60) was included in =
the below results:

Results relative to teo-613 (negative is better):
        teo-614 menu-613        menu-614        teo-614-p       =
menu-614-p
ave     1.73%   0.97%           1.29%           1.70%           0.43%
max     16.79%  3.52%           3.95%           17.48%          4.98%
min     -0.35%  -0.35%          -0.18%          -0.40%          -0.54%

Only data from after the uncertainty area (from results 170-300) was =
included in the below results:

        teo-614 menu-613        menu-614        teo-614-p       =
menu-614-p
ave     1.65%   0.04%           0.98%           -0.56%          0.73%
max     5.04%   2.10%           4.58%           2.44%           3.82%
min     0.00%   -1.89%          -1.17%          -1.95%          -1.38%

A further dwell test was done in the area where teo-614 performed worse =
and there is a 15.74%
throughput regression for teo-614 and a 5.4% regression in power.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-loop-ti=
mes.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-loop-ti=
mes-detail-a.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-relativ=
e-times.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/dwell/times.t=
xt
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/dwell/perf/

Test 5: sleeping ebizzy - 128 threads.

Purpose: This test has given interesting results in the past.
The test varies the sleep interval between record lookups.
The result is varying usage of idle states.

Results: Nothing significant to report just from the performance data.
However, there does seem to be power differences worth considering.

A futher dwell test was done in a cherry picked spot.
It it is important to note that teo-614 removed a sawtooth performance
pattern that was present with teo-613. I.E. it is more stable. See:
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps-only-teo.p=
ng

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/interval-sweep.png
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/relative-performance=
.png
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps.png
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps-relative.p=
ng
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/perf/

Test 6: adrestia wakeup latency tests. 500 threads.

Purpose: The test was reported in 2023.09 by the kernel test robot and =
looked
both interesting and gave interesting results, so I added it to the =
tests I run.

Results:
teo-613.txt:wakeup cost (periodic, 20us): 3331nSec reference
teo-614.txt:wakeup cost (periodic, 20us): 3375nSec +1.32%
menu-613.txt:wakeup cost (periodic, 20us): 3207nSec -3.72%
menu-614.txt:wakeup cost (periodic, 20us): 3315nSec -0.48%
menu-614-p.txt:wakeup cost (periodic, 20us): 3353nSec +0.66%

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/histogram=
.png
http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/histogram=
-detail-a.png
http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/perf/


Test 7: consume: periodic workflow. Various work/sleep frequencies and =
loads.

Purpose: To search for anomalies and hysteresis over all possible =
workloads at various work/sleep frequencies.
work/sleep frequencies tested: 73, 113, 211, 347, and 401 Hertz.
IS a timer based test.

NOTE: Repeatability issues. More work needed.

Tests show instability with teo-614, but a re-test was much less =
unstable and better power.
Idle statistics were collected for the re-test and does show teo-614 =
overly favoring idle state 1, with
"Idle state 1 was too shallow" of 70% verses 15% for teo-613.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf73/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf113/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf211/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf347/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf401/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/test/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/test-idle/

Test 8: shell-intensive serialized workloads.

Variable: PIDs per second, amount of work each task does.
Note: Single threaded.

Dountil the list of tasks is finished:
    Start the next task in the list of stuff to do (with a new PID).
    Wait for it to finish
Enduntil

This workflow represents a challenge for CPU frequency scaling drivers,
schedulers, and therefore idle drivers.

Also, the best performance is achieved by overriding
the scheduler and forcing CPU affinity. This "best" case is the
master reference, requiring additional legend definitions:
1cpu-613: Kernel 6.13, execution forced onto CPU 3.
1cpu-614: Kernel 6.14-rc1, execution forced onto CPU 3.

Ideally the two 1cpu graphs would be identical, but they are not,
likely due to other changes betwwen the two kernels.

Results:
teo-614 is abaolutely outstanding in this test.
Considerably better than any previous result over many years.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/times.pn=
g
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/times-lo=
g.png
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/relative=
.png
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/relative=
-log.png

Test 9: Many threads, periodic workflow

500 threads of do a little work and then sleep a little.
IS a timer based test.

Results:
Kernel 6.13 teo:    reference
Kernel 6.13 menu:   -0.06%
Kernel 6.14 teo:    -0.09%
Kernel 6.14 menu:   +0.49%
Kernel 6.14+p menu: +0.33%

What is interesting is the significant differences in idle state =
selection.
Powers might be interesting, but much longer tests would be needed to =
acheive thermal equalibrium.

doug@s19:~/idle/teo/6.14$ nano README.txt
doug@s19:~/idle/teo/6.14$ rsync --archive --delete --verbose ./ =
doug@s15.smythies.com:/home/doug/public_html/linux/idle/teo-6.14
doug@s15.smythies.com's password:
sending incremental file list
./
README.txt
idle/
idle/teo-614-2.xlsx

sent 61,869 bytes  received 214 bytes  13,796.22 bytes/sec
total size is 20,642,833  speedup is 332.50
doug@s19:~/idle/teo/6.14$ uname -a
Linux s19 6.14.0-rc1-stock #1339 SMP PREEMPT_DYNAMIC Sun Feb  2 16:45:39 =
PST 2025 x86_64 x86_64 x86_64 GNU/Linux
doug@s19:~/idle/teo/6.14$ uname -a
Linux s19 6.14.0-rc1-stock #1339 SMP PREEMPT_DYNAMIC Sun Feb  2 16:45:39 =
PST 2025 x86_64 x86_64 x86_64 GNU/Linux
doug@s19:~/idle/teo/6.14$
doug@s19:~/idle/teo/6.14$
doug@s19:~/idle/teo/6.14$
doug@s19:~/idle/teo/6.14$ cat READEME.txt
cat: READEME.txt: No such file or directory
doug@s19:~/idle/teo/6.14$ cat README.txt
2025.02.13 Notes on this round of idle governors testing:

Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
Distro: Ubuntu 24.04.1, server, no desktop GUI.

CPU frequency scaling driver: intel_pstate
HWP: disabled.
CPU frequency scaling governor: performance

Ilde driver: intel_idle
Idle governor: as per individual test
Idle states: 4: name : description:
   state0/name:POLL             desc:CPUIDLE CORE POLL IDLE
   state1/name:C1_ACPI          desc:ACPI FFH MWAIT 0x0
   state2/name:C2_ACPI          desc:ACPI FFH MWAIT 0x30
   state3/name:C3_ACPI          desc:ACPI FFH MWAIT 0x60

Legend:
teo-613: teo governor - Kernel 6.13: before "cpuidle: teo: Cleanups and =
very frequent wakeups handling update"
menu-613: menu governor - Kernel 6.13: before "cpuidle: teo: Cleanups =
and very frequent wakeups handling update"
teo-614: teo governor - Kernel 6.14-rc1: Includes cpuidle: teo: Cleanups =
and very frequent wakeups handling update
menu-614: menu governor - Kernel 6.14-rc1: Includes cpuidle: teo: =
Cleanups and very frequent wakeups handling update
teo-614-p: teo governor - Kernel 6.14-rc1-p: Includes "cpuidle: teo: =
Avoid selecting deepest idle state over-eagerly"
menu-614-p: menu governor - Kernel 6.14-rc1-p: Includes "cpuidle: menu: =
Avoid discarding useful information when processing recent idle =
intervals"

I do a set of tests adopted over some years now.
Readers may recall that some of the tests search over a wide range of =
operating conditions looking for areas to focus on in more detail.
One interesting observation is that everything seems to run slower than =
the last time I did this, June 2024, Kernel 6.10-rc2,
which was also slower than the time before that, August 2023, Kernel =
6.5-rc4.
There are some repeatability issues with the tests.

I was unable to get the "cpuidle: teo: Cleanups and very frequent =
wakeups handling update"
patch set to apply to kernel 6.13, and so just used kernel 6.14-rc1, but =
that means that
all the other commits between the kernel versions are included. This =
could cast doubt on
the test results, and indeed some differences in test results are =
observed with the menu
idle governor, which did not change.

Test 1: System Idle

Purpose: Basic starting point test. To observe and check an idle system =
for excessive power consumption.

teo-613: 1.752 watts (reference: 0.0%)
menu-613: 1.909 watts (+9.0%)
teo-614: 2.199 watts (+25.51%)   <<< Test flawed. Needs to be redone. =
Will be less.
teo-614-2: 2.112 watts (+17.05%) <<< Re-test of teo-614. (don't care =
about 0.4 watts)
menu-614: 1.873 watts (+6.91%)
teo-614-p: 9.401 watts (+436.6%)  <<< Very bad regression.
menu-614-p: 1.820 watts (+3.9%)

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/idle/perf/

Test 2: 2 core ping pong sweep:

Pass a token between 2 CPUs on 2 different cores.
Do a variable amount of work at each stop.
NOT a timer based test.

Purpose: To utilize the shallowest idle states
and observe the transition from using more of 1
idle state to another.

Results relative to teo-613 (negative is better):
        menu-613        teo-614         menu-614        menu-614-p
average -2.06%          -0.32%          -2.33%          -2.52%
max     9.42%           12.72%          8.29%           8.55%
min     -10.36%         -3.82%          -11.89%         -12.13%

No significant issues here. There are differences on idle state =
preferences.

Standard "fast" dwell test:

teo-613: average 3.826 uSec/loop reference
menu-613: average 4.159 +8.70%
teo-614: average 3.751 -1.94%
menu-614: average 4.076 +6.54%
menu-614-p: average 4.178 +9.21%

Interestingly, teo-614 also uses a little less power.
Note that there is an offsetting region for the menu governor where it =
performs better
than teo, but it was not extracted and done as a dwell test.

Standard "medium dwell test:

teo-613: 12.241 average uSec/loop reference
menu-613: 12.251 average +0.08%
teo-614: 12.121 average -0.98%
menu-614: 12.123 average -0.96%
menu-614-p: 12.236 average -0.04%

Standard "slow" dwell test: Not done.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/loop-times.png=

http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/loop-times-rel=
ative.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/many-0-400000000-2/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/many-3000-100000000-2/

Test 3: 6 core ping pong sweep:

Pass a token between 6 CPUs on 6 different cores.
Do a variable amount of work at each stop.
NOT a timer based test.

Purpose: To utilize the midrange idle states
and observe the transitions between use of
idle states.

Note: This test has uncertainty in an area where the performance is =
bi-stable for all idle governors,
transitioning between much less power and slower performance and much =
more power and higher performance.
On either side of this area, the differences between all idle governors =
are small.
Only data from before this area (from results 1 to 95) was included in =
the below results.

Results relative to teo-613 (negative is better):
        teo-614 menu-613        menu-614        menu-614-p
average 1.60%   0.18%           0.02%           0.02%
max     5.91%   0.97%           1.12%           0.85%
min     -1.79%  -1.11%          -1.88%          -1.52%

A further dwell test was done in the area where teo-614 performed worse.
There was a slight regression in both performance and power:

teo-613: average 21.34068 uSec per loop
teo-614: average 20.55809 usec per loop 3.67% regression

teo-613: average 37.17577 watts.
teo-614: average 38.06375 watts. 2.3% regression.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times.png=

http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times-det=
ail-a.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times-det=
ail-b.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/dwell/perf/

Test 4: 12 CPU ping pong sweep:

Pass a token between all 12 CPUs.
Do a variable amount of work at each stop.
NOT a timer based test.

Purpose: To utilize the deeper idle states
and observe the transitions between use of
idle states.

This test was added last time at the request of Christian Loehle.

Note: This test has uncertainty in an area where the performance is =
bi-stable for all idle governors,
transitioning between much less power and slower performance and much =
more power and higher performance.
On either side of this area, the differences between all idle governors =
are small.

Only data from before this area (from results 1 to 60) was included in =
the below results:

Results relative to teo-613 (negative is better):
        teo-614 menu-613        menu-614        teo-614-p       =
menu-614-p
ave     1.73%   0.97%           1.29%           1.70%           0.43%
max     16.79%  3.52%           3.95%           17.48%          4.98%
min     -0.35%  -0.35%          -0.18%          -0.40%          -0.54%

Only data from after the uncertainty area (from results 170-300) was =
included in the below results:

        teo-614 menu-613        menu-614        teo-614-p       =
menu-614-p
ave     1.65%   0.04%           0.98%           -0.56%          0.73%
max     5.04%   2.10%           4.58%           2.44%           3.82%
min     0.00%   -1.89%          -1.17%          -1.95%          -1.38%

A further dwell test was done in the area where teo-614 performed worse =
and there is a 15.74%
throughput regression for teo-614 and a 5.4% regression in power.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-loop-ti=
mes.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-loop-ti=
mes-detail-a.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-relativ=
e-times.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/dwell/times.t=
xt
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/dwell/perf/

Test 5: sleeping ebizzy - 128 threads.

Purpose: This test has given interesting results in the past.
The test varies the sleep interval between record lookups.
The result is varying usage of idle states.

Results: Nothing significant to report just from the performance data.
However, there does seem to be power differences worth considering.

A further dwell test was done on a cherry-picked spot.
It it is important to note that teo-614 removed a sawtooth performance
pattern that was present with teo-613. I.E. it is more stable. See:
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps-only-teo.p=
ng

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/interval-sweep.png
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/relative-performance=
.png
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps.png
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps-relative.p=
ng
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/perf/

Test 6: adrestia wakeup latency tests. 500 threads.

Purpose: The test was reported in 2023.09 by the kernel test robot and =
looked
both interesting and gave interesting results, so I added it to the =
tests I run.

Results:
teo-613.txt:wakeup cost (periodic, 20us): 3331nSec reference
teo-614.txt:wakeup cost (periodic, 20us): 3375nSec +1.32%
menu-613.txt:wakeup cost (periodic, 20us): 3207nSec -3.72%
menu-614.txt:wakeup cost (periodic, 20us): 3315nSec -0.48%
menu-614-p.txt:wakeup cost (periodic, 20us): 3353nSec +0.66%

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/histogram=
.png
http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/histogram=
-detail-a.png
http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/perf/


Test 7: consume: periodic workflow. Various work/sleep frequencies and =
loads.

Purpose: To search for anomalies and hysteresis over all possible =
workloads at various work/sleep frequencies.
work/sleep frequencies tested: 73, 113, 211, 347, and 401 Hertz.
IS a timer based test.

NOTE: Repeatability issues. More work needed.

Tests show instability with teo-614, but a re-test was much less =
unstable and better power.
Idle statistics were collected for the re-test and does show teo-614 =
overly favoring idle state 1, with
"Idle state 1 was too shallow" of 70% verses 15% for teo-613.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf73/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf113/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf211/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf347/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf401/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/test/
http://smythies.com/~doug/linux/idle/teo-6.14/consume/test-idle/

Test 8: shell-intensive serialized workloads.

Variable: PIDs per second, amount of work each task does.
Note: Single threaded.

Dountil the list of tasks is finished:
    Start the next task in the list of stuff to do (with a new PID).
    Wait for it to finish
Enduntil

This workflow represents a challenge for CPU frequency scaling drivers,
schedulers, and therefore idle drivers.

Also, the best performance is achieved by overriding
the scheduler and forcing CPU affinity. This "best" case is the
master reference, requiring additional legend definitions:
1cpu-613: Kernel 6.13, execution forced onto CPU 3.
1cpu-614: Kernel 6.14-rc1, execution forced onto CPU 3.

Ideally the two 1cpu graphs would be identical, but they are not,
likely due to other changes between the two kernels.

Results:
teo-614 is absolutely outstanding in this test.
Considerably better than any previous result over many years.

Further details:
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/times.pn=
g
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/times-lo=
g.png
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/relative=
.png
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/relative=
-log.png

Test 9: Many threads, periodic workflow

500 threads of do a little work and then sleep a little.
IS a timer based test.

Results:
Kernel 6.13 teo:    reference
Kernel 6.13 menu:   -0.06%
Kernel 6.14 teo:    -0.09%
Kernel 6.14 menu:   +0.49%
Kernel 6.14+p menu: +0.33%

What is interesting is the significant differences in idle state =
selection.
Powers might be interesting, but much longer tests would be needed to =
achieve thermal equilibrium.


