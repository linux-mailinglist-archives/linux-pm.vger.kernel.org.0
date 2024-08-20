Return-Path: <linux-pm+bounces-12566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E88B3958C45
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B691F24A38
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2571750;
	Tue, 20 Aug 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="M5/weLpT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1FE191F89
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171722; cv=none; b=CnaFN4bxL4WkvxOMGNXeDnMXCNx/sLE+/VaGgcHyZ7ABSPFddmozGLec7AZ8CUeb+iABLAsv5FRm9yzc2r15hDypZFGtpmfRCiN+jmxrgu++OFyhtqluvbqBrfwwbue4iaTiG2cZffBS+i0rOQINKlt5pvQYYtVqmnUqvRV5Lt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171722; c=relaxed/simple;
	bh=QAJtjoQB+Ox8XgN940tMlQcJuNA80PnTeQtBlaBycAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nTw3I+TxbdpqXrZ3Vm9zPlGSwLCuu/FkJTzPOdMYIIxuxt9BQlUMDri9bb3PjFNG3wGgkWM7OQPqrC42cku8OHbbDXoeu2bTPEcX3j8amcTtAbvFff6GfWLIqdeFJajBapCYe45/u5JnOwQ88SrZO+WyqMYr8xW042zaxvGt9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=M5/weLpT; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533462b9428so615016e87.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171717; x=1724776517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MJn2fRuxiv0NL80F0iTtY2oclZQ7wnneix+wmp0jkI=;
        b=M5/weLpT5O/zVezwWwZdurbLkE/16lOnxyxpZhbHoJat3zx6+JcNqXkoYED3NCW5Lz
         luXnEbQboxUhmh29eirvoXp65B2quLgnvX3wfAYYsytqTWKhwBOSeh3NhlgwITCFsmQ9
         CQiirHfQYBio6UD5/mwDKWZTZIq14S3hOyO5CHGeI5GEWHr5I86k40/dmjHw5AQ9c4kh
         iLh/Oo1HLLhTEZUtl/dO1XJhBIG/1S2sbgbuikEXR3wACFSM4WYTK6x5Ab/N7wxM6daJ
         btVeVVlbQoBUdV1OuqUp82C+pH7Az0hsBbCqVvgAgCebe0Upfuo49I3O+X8qR1BNntOV
         XhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171717; x=1724776517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MJn2fRuxiv0NL80F0iTtY2oclZQ7wnneix+wmp0jkI=;
        b=b+4aLuMv5ZFb9KJDB2+o8ABJHAbwEC8iiIIb5oJM5Q0+yLDzyoVBWbgBrSNLXYC+vg
         XNJm4WHYJINwBY6n6pPHjjcNmIxlkbH4uIKBxH9qL6lLg8YQnVknzmDUITZdVPcAEFlR
         PLWs/or4QTKqNF9/QSipeSzt9yPSvtjVygCYD4x8fwRNIcfwE9T1cGEDFu7gA49dSaG+
         0GajzO/IumtiAS46b/GTHGAk44jKGKa7ZzC6RUVp4gZwmNu4SykBN+XIjBg4i6fj2wDs
         IhBFO/qe2dFdp91YUFs70mxEl2XoOU4acbrVCXsm7rLdEJo1zKn6p09icHnHfbYtignW
         1qmA==
X-Forwarded-Encrypted: i=1; AJvYcCUZQgGIRQw2vgURsOIHJma40CTNniKrVgNv/vDwS6reaikVu58saQ8us69+tgLRjDSZyuyuHwz3vlGFF7E2yVnI2CCg5cAUMS4=
X-Gm-Message-State: AOJu0Yw7ynneRj9xCqFCiw/uRawUb/kds+cz3I5P4C3lZWzNxEjmX4zy
	uP8eSewXxbGaTc1KtbQmDbV/KGvdAtJnAHZ+JNIUWP33NxWUBglw9ZWd9O651+I=
X-Google-Smtp-Source: AGHT+IHwvBoU+0N9gRVJ6qJL1feY0YzzmXMlqHwOk2VXMxlkdJXTqwvIgCE+hAp5T587dWcL8KGTPA==
X-Received: by 2002:a05:6512:4007:b0:530:ab68:25c5 with SMTP id 2adb3069b0e04-5331c691facmr13234608e87.2.1724171716765;
        Tue, 20 Aug 2024 09:35:16 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:16 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 00/16] sched/fair/schedutil: Better manage system response time
Date: Tue, 20 Aug 2024 17:34:56 +0100
Message-Id: <20240820163512.1096301-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series is a re-incarnation of Remove Hardcoded Margings posted a while ago

	https://lore.kernel.org/lkml/20231208002342.367117-1-qyousef@layalina.io/

The original series attempted to address response time related issues stemming
from hardcoding migration margin in fits_capacity() on HMP system, and DVFS
headroom which had a constant 25% boost that is bad for power and thermal on
powerful systems. Saving power was the main goal by reducing these values to
the smallest possible value automatically based on anticipated worst case
scenario.

A tricky point was uncovered and demonstrated in the migration margin table in
this posting

	https://lore.kernel.org/lkml/20240205223344.2280519-4-qyousef@layalina.io/

is that to make the system responsive to sudden changes, we actually need large
migration margin the smaller the core capacity is

	cap		threshold	%		threshold-tick	%
	0		0		0		0		0
	16		0		0		0		0
	32		1		3.12		0		0
	48		3		6.25		2		4.16
	64		4		6.25		2		3.12
	80		6		7.5		5		6.25
	96		10		10.41		8		8.33
	112		14		12.5		11		9.82
	128		18		14.06		16		12.5
	144		21		14.58		18		12.5
	160		26		16.25		23		14.37
	176		33		18.75		29		16.47
	192		39		20.31		35		18.22
	208		47		22.59		43		20.67
	224		55		24.55		50		22.32
	240		63		26.25		59		24.58
	256		73		28.51		68		26.56
	272		82		30.14		77		28.30
	288		93		32.29		87		30.20
	304		103		33.88		97		31.90
	320		114		35.62		108		33.75
	336		126		37.5		120		35.71
	352		138		39.20		132		37.5
	368		151		41.03		144		39.13
	384		163		42.44		157		40.88

The current 80% margin is valid for CPU with capacities in the 700-750 range,
which might have been true in the original generations of HMP systems.

	704		557		79.11		550		78.12
	720		578		80.27		572		79.44
	736		606		82.33		600		81.52
	752		633		84.17		627		83.37

This result contradicts the original goal of saving power as it indicates we
must be more aggressive with the margin, while the original observation was
that there are workloads with steady utilization that is hovering at a level
that is higher than this margin but lower than the capacity of the CPU (mid
CPUs particularly) and the aggressive upmigration is not desired, nor the
higher push to run at max freq where we could have run at a lower freq with no
impact on perf.

Further analysis using a simple rampup [1] test that spawns a busy task that
starts from util_avg/est = 0 and never goes to sleep. The purpose is to measure
the actual system response time for workloads that are bursty and need to
transition from lower to higher performance level quickly.

This lead to more surprising discovery due to utilization invariance, I call it
the black hole effect.

There's a black hole in the scheduler:
======================================

It is no surprise to anyone that DVFS and HMP system have a time stretching
effect where the same workload will take longer to do the same amount of work
the lower the frequency/capacity.

This is countered in the system via clock_pelt which is central for
implementing utilization invariance. This helps ensure that the utilization
signal still accurately represent the computation demand of sched_entities.

But this introduces this black hole effect of time dilation. The concept of
passage of time is now different from task's perspective compared to an
external observer. The task will think 1ms has passed, but depending on the
capacity or the freq, the time from external observer point of view has passed
for 25 or even 30ms in reality.

This has a terrible impact on utilization signal rise time. And since
utilization signal is central in making many scheduler decision like estimating
how loaded the CPU is, whether a task is misfit, and what freq to run at when
schedutil is being used, this leads to suboptimal decision being made and give
the external observer (userspace) that the system is not responsive or
reactive. This manifests as problems like:

	* My task is stuck on the little core for too long
	* My task is running at lower frequency causing missing important
	  deadlines although it has been running for the past 30ms

As a demonstration, running the rampup test on Mac mini with M1 SoC, 6.8 kernel
with 1ms TICK/HZ=1000.

	$ grep . /sys/devices/system/cpu/cpu*/cpu_capacity
	/sys/devices/system/cpu/cpu0/cpu_capacity:459
	/sys/devices/system/cpu/cpu1/cpu_capacity:459
	/sys/devices/system/cpu/cpu2/cpu_capacity:459
	/sys/devices/system/cpu/cpu3/cpu_capacity:459
	/sys/devices/system/cpu/cpu4/cpu_capacity:1024
	/sys/devices/system/cpu/cpu5/cpu_capacity:1024
	/sys/devices/system/cpu/cpu6/cpu_capacity:1024
	/sys/devices/system/cpu/cpu7/cpu_capacity:1024

Ideal response time running at max performance level
----------------------------------------------------

	$ uclampset -m 1024 rampup

                             rampup-5088 util_avg running
      ┌────────────────────────────────────────────────────────────────────────┐
1015.0┤                                                  ▄▄▄▄▄▄▄▄▄▟▀▀▀▀▀▀▀▀▀▀▀▀│
      │                                         ▗▄▄▄▛▀▀▀▀▘                     │
      │                                    ▗▄▟▀▀▀                              │
      │                                 ▄▟▀▀                                   │
 761.2┤                              ▄▟▀▘                                      │
      │                            ▗▛▘                                         │
      │                          ▗▟▀                                           │
 507.5┤                        ▗▟▀                                             │
      │                       ▗▛                                               │
      │                      ▄▛                                                │
      │                     ▟▘                                                 │
 253.8┤                    ▐▘                                                  │
      │                   ▟▀                                                   │
      │                  ▗▘                                                    │
      │                 ▗▛                                                     │
   0.0┤         ▗       ▛                                                      │
      └┬───────┬───────┬───────┬───────┬──────┬───────┬───────┬───────┬───────┬┘
     1.700   1.733   1.767   1.800   1.833  1.867   1.900   1.933   1.967 2.000

───────────────── rampup-5088 util_avg running residency (ms) ──────────────────
0.0    ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1.4000000000000001
26.0   ▇▇▇▇▇▇▇▇▇▇▇ 1.0
47.0   ▇▇▇▇▇▇▇▇▇▇▇ 1.0
67.0   ▇▇▇▇▇▇▇▇▇▇▇ 1.0
86.0   ▇▇▇▇▇▇▇▇▇▇▇ 1.0
105.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
124.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
143.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
161.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
178.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
196.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
213.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
229.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
245.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
277.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
292.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
307.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
322.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
336.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
350.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
364.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
378.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
391.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
404.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
416.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
429.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
441.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0
453.0  ▇▇▇▇▇▇▇▇▇▇▇ 1.0

Observations:
-------------

	* It takes ~233ms to go from 0 to ~1015
	* It takes ~167ms to go from 0 to ~1000
	* Utilization increases every tick or 1ms
	* It takes ~29.5ms to reach a util of ~450

Worst case scenario running at lowest performance level
-------------------------------------------------------

	$ uclampset -M 0 rampup

(Note the difference in the x-axis)

                            rampup-3740 util_avg running
     ┌─────────────────────────────────────────────────────────────────────────┐
989.0┤                                                        ▄▄▄▄▄▄▄▄▄▛▀▀▀▀▀▀▀│
     │                                            ▗▄▄▄▄▄▛▀▀▀▀▀▘                │
     │                                       ▄▄▛▀▀▀                            │
     │                                  ▄▄▟▀▀▘                                 │
741.8┤                              ▄▄▛▀▘                                      │
     │                          ▗▄▛▀▘                                          │
     │                        ▄▟▀                                              │
494.5┤                     ▗▟▀▘                                                │
     │                   ▄▛▀                                                   │
     │                 ▗▛▘                                                     │
     │               ▄▛▀                                                       │
247.2┤             ▗▟▘                                                         │
     │            ▗▛                                                           │
     │           ▟▀                                                            │
     │         ▗▟▘                                                             │
  0.0┤        ▗▟                                                               │
     └┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬┘
    0.60    0.76    0.91    1.07    1.22    1.38    1.53    1.69    1.84   2.00

───────────────── rampup-3740 util_avg running residency (ms) ──────────────────
0.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.6
10.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
30.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 9.0
54.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
75.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
95.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
115.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 6.3
133.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.7
151.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.0
172.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
190.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
207.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
225.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
242.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
258.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
274.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
290.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
306.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
321.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
336.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
351.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
365.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.9
381.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
394.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
407.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
420.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
433.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
446.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
458.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0

Observations:

	* It takes 1.350 seconds (!) to go from 0 to ~1000
	* Utilization updates every 8ms most of the time
	* It takes ~223ms to reach a util of ~450

Default response time with 10ms rate_limit_us
---------------------------------------------

	$ rampup

                            rampup-6338 util_avg running
     ┌─────────────────────────────────────────────────────────────────────────┐
986.0┤                                                               ▄▄▄▄▄▟▀▀▀▀│
     │                                                        ▗▄▄▟▀▀▀▘         │
     │                                                    ▗▄▟▀▀                │
     │                                                 ▄▟▀▀                    │
739.5┤                                              ▄▟▀▘                       │
     │                                           ▗▄▛▘                          │
     │                                         ▗▟▀                             │
493.0┤                                       ▗▛▀                               │
     │                                    ▗▄▛▀                                 │
     │                                  ▄▟▀                                    │
     │                                ▄▛▘                                      │
246.5┤                             ▗▟▀▘                                        │
     │                          ▄▟▀▀                                           │
     │                      ▗▄▄▛▘                                              │
     │                 ▗▄▄▄▟▀                                                  │
  0.0┤  ▗         ▗▄▄▟▀▀                                                       │
     └┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬───────┬┘
    1.700   1.733   1.767   1.800   1.833   1.867   1.900   1.933   1.967 2.000

───────────────── rampup-6338 util_avg running residency (ms) ──────────────────
0.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.5
15.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
36.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
57.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
78.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 7.9
98.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
117.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
137.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
156.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
176.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
191.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
211.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
230.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
248.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
266.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
277.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
294.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.6
311.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.4
327.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
340.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
358.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
371.0 ▇▇▇▇▇▇▇▇▇ 1.0
377.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
389.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
401.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
413.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
431.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
442.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
456.0 ▇▇▇▇▇▇▇▇▇ 1.0

───────────────────────── Sum Time Running on CPU (ms) ─────────────────────────
CPU0.0 ▇▇▇▇▇ 90.39
CPU4.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1156.93

                            6338 rampup CPU0.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
2.06┤                                ▛▀▀                                       │
    │                                ▌                                         │
    │                                ▌                                         │
    │                                ▌                                         │
1.70┤                             ▛▀▀▘                                         │
    │                             ▌                                            │
    │                             ▌                                            │
1.33┤                         ▗▄▄▄▌                                            │
    │                         ▐                                                │
    │                         ▐                                                │
    │                         ▐                                                │
0.97┤                     ▗▄▄▄▟                                                │
    │                     ▐                                                    │
    │                     ▐                                                    │
    │                     ▐                                                    │
0.60┤  ▗         ▗▄▄▄▄▄▄▄▄▟                                                    │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

                            6338 rampup CPU4.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
3.20┤                                                    ▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀│
    │                                                    ▐                     │
    │                                                  ▛▀▀                     │
    │                                                  ▌                       │
2.78┤                                               ▐▀▀▘                       │
    │                                             ▗▄▟                          │
    │                                             ▌                            │
2.35┤                                          ▗▄▄▌                            │
    │                                          ▐                               │
    │                                        ▄▄▟                               │
    │                                        ▌                                 │
1.93┤                                     ▗▄▄▌                                 │
    │                                     ▐                                    │
    │                                     ▐                                    │
    │                                     ▐                                    │
1.50┤                                  ▗▄▄▟                                    │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

───────────────── 6338 rampup CPU0.0 Frequency residency (ms) ──────────────────
0.6   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 37.300000000000004
0.972 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 15.0
1.332 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 15.0
1.704 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 11.0
2.064 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 12.1

───────────────── 6338 rampup CPU4.0 Frequency residency (ms) ──────────────────
1.5   ▇▇▇▇▇▇▇▇▇▇ 11.9
1.956 ▇▇▇▇▇▇▇▇ 10.0
2.184 ▇▇▇▇▇▇▇▇ 10.0
2.388 ▇▇▇▇▇▇▇▇▇ 11.0
2.592 ▇▇▇▇▇▇▇▇ 10.0
2.772 ▇▇▇▇▇▇▇▇ 10.0
2.988 ▇▇▇▇▇▇▇▇ 10.0
3.204 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 85.3

Observations:

	* It takes ~284ms to go from 0 to ~1000
	* Utilization ramps up initially every 8ms, then starts to speed up not
	  reaching 1ms until util ~450. It actually flips between 1ms and 2ms
	  for a while after this value.
	* It takes ~105ms to reach a util ~450
	* The task runs on little core for a whopping 90ms before it migrates
	  to the big core in spite of obviously an always running task. That is
	  with the current 80% migration margin.
	* when running on little CPU, it stays at lowest freq for a whopping
	  37ms. It takes that long for util to reach a value high enough to
	  move on to the next freq, that is with the 1.25 DVFS headroom.
	* Moving across frequencies remain slow afterward on little. On big, it
	  seems to be capped at 10ms due to the rate_limit_us which was
	  addressed already in [2].

Defeault response with 70us rate_limit_us
-----------------------------------------

                           rampup-6581 util_avg running
   ┌───────────────────────────────────────────────────────────────────────────┐
984┤                                                                 ▄▄▄▄▄▟▀▀▀▀│
   │                                                          ▗▄▄▛▀▀▀▘         │
   │                                                      ▗▄▞▀▀                │
   │                                                   ▄▄▛▀                    │
738┤                                                ▗▟▀▘                       │
   │                                              ▄▛▀                          │
   │                                           ▗▟▀▘                            │
492┤                                         ▄▟▀                               │
   │                                       ▄▛▘                                 │
   │                                    ▗▄▛▘                                   │
   │                                  ▄▟▀                                      │
246┤                               ▄▟▀▘                                        │
   │                            ▗▄▟▘                                           │
   │                         ▗▟▀▀                                              │
   │                   ▄▄▄▄▛▀▀                                                 │
  0┤    ▗         ▗▄▄▛▀▘                                                       │
   └┬───────┬───────┬────────┬───────┬───────┬───────┬────────┬───────┬───────┬┘
  1.700   1.733   1.767    1.800   1.833   1.867   1.900    1.933   1.967 2.000

───────────────── 6581 rampup CPU4.0 Frequency residency (ms) ──────────────────
1.5   ▇▇ 2.9
1.728 ▇▇▇▇▇▇▇ 8.0
1.956 ▇▇▇▇▇▇▇▇ 9.0
2.184 ▇▇▇▇▇▇▇▇ 9.0
2.388 ▇▇▇▇▇▇ 7.0
2.592 ▇▇▇▇▇▇▇ 8.0
2.772 ▇▇▇▇▇▇ 7.0
2.988 ▇▇▇▇▇▇▇▇ 10.0
3.096 ▇▇▇▇▇ 6.0
3.144 ▇▇▇ 3.0
3.204 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 82.4

Observations:
-------------

	* Results is more or less the same
	* It takes ~264ms to go from 0 to ~1000
	* With better rate limit we still see slow jumps in freqs on the big
	  core. Which demonstrates the bottleneck is in the utilization signal
	  rampup time

It gets worse on systems with smaller cores
-------------------------------------------

Mobile systems which commonly contain littles that have a capcity of ~200 and
sometimes less will suffer more from this bad impact. The smaller the core/freq,
the greater the gravitational pull!

It was measured to stay over 100ms stuck on the little core and being stuck for
longer at lowest frequencies to pick up from 0 util.

The solution:
j============

The proposal to remove the hardcoded DVFS headroom and migration margin in [3]
is still valid. And we build on top of it.

But to address the utilization invariance black hole problem, I add a number of
patches on top to extend util_est.

This black hole effect is only valid for tasks that are transitioning from one
steady state, to another steady state. Completely periodic tasks which the
system is traditionally built upon; the current utilization signal is a good
approximation of its _compute_ demand. But observers (userspace), care about
real time.

Computational domain vs Time domain:
------------------------------------

The util_avg is a good representation of compute demand of periodic tasks. And
should remain as such. But when they are no longer periodic, then looking at
computational domain doesn't make sense as we have no idea what's the actual
compute demand of the task, it's in transition. During this transition we need
to fallback to time domain based signal. Which is simply done by ignoring
invariance and let the util accumulate based on observer's time.

Coherent response time:
-----------------------

Moving transient tasks to be based on observer's time will create a coherent
and constant response time. Which is the time it takes util_avg to rampup from
0 to max on the biggest core running at max freq (or performance level
1024/max).

IOW, the rampup time of util signal should appear to be the same on all
capacities/frequencies as if we are running at the highest performance level
all the time. This will give the observer (userspace) the expected behavior of
things moving through the motions in a constant response time regardless of
initial conditions.

util_est extension:
-------------------

The extension is quite simple. util_est currently latches to util_avg at
enqueue/dequeue to act as a hold function for when busy tasks sleep for long
period and decay prematurely.

The extension is to account for RUNNING time of the task in util_est too, which
is currently ignored.

when a task is RUNNING, we accumulate delta_exec across context switches and
accumulate util_est as we're accumulating util_avg, but simply without any
invariance taken into account. This means when tasks are RUNNABLE, and continue
to run, util_est will act as our time based signal to help with the faster and
'constant' rampup response.

Periodic vs Transient tasks:
----------------------------

It is important to make a distinction now between tasks that are periodic and
their util_avg is a good faithful presentation of its compute demand. And
transient tasks that need help to move faster to their next steady state point.

In the code this distinction is made based on util_avg. In theory (I think we
have bugs, will send a separate report), util_avg should be near constant for
a periodic task. So simply transient tasks are ones that lead to util_avg being
higher across activations. And this is our trigger point to know whether we
need to accumulate variant (real time based) util_est.

Rampup multipliers and sched-qos:
---------------------------------

It turns out the slow rampup time is great for power. With the fix, many tasks
will start causing higher freqs.

Equally, the speed up will not be good enough for some workloads that need to
move even faster than default response time.

To cater for those, introduce per-task rampup multiplier. It can be set to
0 to keep tasks that don't care about performance from burning power. And it
can be set to higher than 1 to make tasks go even faster through the motions.

The multiplier is introduced as a first implementation of a generic sched-qos
framework. Based on various discussions in many threads there's a burning need
to provide more hints to enable smarter resource management based on userspace
choices/trade-offs. Hopefully this framework will make the job simpler from
both adding deprecatable kernel hints, and for userspace as there won't be
a need to continously extend sched_attr, but add a new enum and userspace
should be able to reuse the sched-qos wrappers when new hints are added to make
use of them more readily.

The patches:
==========i=

Patch 1 is a repost of an existing patch on the list but is a required for the
series.

Patches 2 and 3 add helper functions to accumulate util_avg and calculate the
rampup time from any point.

Patches 4 and 5 remove the hardcoded margins in favour of a more automatic and
'deterministic' behavior based on the worst case scenario for current
configuration (TICK mostly, but base_slice too).

Patch 6 adds a new tunable to schedutil to dictate the rampup response time. It
allows it to be sped up and slowed down. Since utilization signal has
a constant response time on *all* systems regardless of how powerful or weak
they are, this should allow userspace to control this more sensibly based on
their system and workload characteristics and their efficiency goals.

Patch 7 adds a multiplier to change PELT time constant. I am not sure if this
is necessary now after introducing per task rampup multipliers. The original
rationale was to help cater different hadware against the constant util_avg
response time. I might drop this in future postings. I haven't tested the
latest version which follows a new implementation suggested by Vincent.

Patches 8 and 9 implement util_est extensions to better handle periodic vs
transient tasks.

Patches 10 and 11 add sched-qos and implements SCHED_QOS_RAMPUP_MULTIPLIER.

Patches 12 and 13 further improve dvfs headroom definition by taking into
account waiting_avg. waiting_avg is a new signal that accumulates how long
a task is RUNNABLE && !RUNNING. This is an important source of latency and
perception of responsiveness. It decouples util_avg, which is a measure of
computational demand, and the requirement to run at specific freq to meet this
demand, and the fact that slower frequency could mean tasks end up waiting for
longer behind other tasks. If waiting time is long, it means the DVFS headroom
need to increase. So we add it to the list of items to take into account.
I tested to ensure the waiting_avg looks sane, but haven't done proper
verification on how it helps with contended situations for frequency selection.

Patch 14 implements an optimization to ignore DVFS headroom when the
utilization signal is falling. It indicates that we are already running faster
than we should, so we should be able to save power safely. This patch still
needs more verification to ensure it produces the desired impact.

Patch 15 uses rampup_multipier = 0 to disable util_est completely assuming
tasks that don't care about perf they are okay without util_est altogether.

Patch 16 implements another optimization to keep util_avg at 0 on fork given we
have enough means now for tasks to manage their perf requirements and we can
never crystal ball what the util_avg should be after fork. Be consistent and
start from the same lowest point preserving precious resources.

The series needs more polishing. But posting now to help discuss further during
LPC to ensure it is moving in the right direction.

Results:
========

Response time with rampup multiplier = 1
-----------------------------------------

                           rampup-2234 util_avg running
   ┌───────────────────────────────────────────────────────────────────────────┐
984┤                                                                ▗▄▄▄▄▄▛▀▀▀▀│
   │                                                          ▄▄▟▀▀▀▀          │
   │                                                     ▄▄▟▀▀                 │
   │                                                  ▄▟▀▘                     │
738┤                                               ▄▟▀▘                        │
   │                                            ▗▟▀▘                           │
   │                                          ▗▟▀                              │
492┤                                        ▗▟▀                                │
   │                                      ▗▟▀                                  │
   │                                     ▟▀                                    │
   │                                   ▄▛▘                                     │
246┤                                 ▗▟▘                                       │
   │                               ▗▟▀                                         │
   │                             ▗▟▀                                           │
   │                           ▗▟▀                                             │
  0┤                       ▄▄▄▛▀                                               │
   └┬───────┬───────┬────────┬───────┬───────┬───────┬────────┬───────┬───────┬┘
  1.700   1.733   1.767    1.800   1.833   1.867   1.900    1.933   1.967 2.000

───────────────── rampup-2234 util_avg running residency (ms) ──────────────────
0.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.6000000000000005
15.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 8.0
39.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.0
61.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
85.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
99.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
120.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
144.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
160.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
176.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
192.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
210.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
228.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
246.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
263.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
282.0 ▇▇▇▇▇▇▇ 1.0
291.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
309.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
327.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
344.0 ▇▇▇▇▇▇▇ 1.0
354.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
373.0 ▇▇▇▇▇▇▇ 1.0
382.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
400.0 ▇▇▇▇▇▇▇ 1.0
408.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
425.0 ▇▇▇▇▇▇▇ 1.0
434.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
452.0 ▇▇▇▇▇▇▇ 1.0

                            2234 rampup CPU1.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
2.06┤                             ▐▀                                           │
    │                             ▐                                            │
    │                             ▐                                            │
    │                             ▐                                            │
1.70┤                            ▛▀                                            │
    │                            ▌                                             │
    │                            ▌                                             │
1.33┤                           ▄▌                                             │
    │                           ▌                                              │
    │                           ▌                                              │
    │                           ▌                                              │
0.97┤                         ▗▄▌                                              │
    │                         ▐                                                │
    │                         ▐                                                │
    │                         ▐                                                │
0.60┤                      ▗▄▄▟                                                │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

                            2234 rampup CPU4.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
3.10┤                                                            ▐▀▀▀▀▀▀▀▀▀▀▀▀▀│
    │                                                 ▛▀▀▀▀▀▀▀▀▀▀▀             │
    │                                                 ▌                        │
    │                                            ▐▀▀▀▀▘                        │
2.70┤                                            ▐                             │
    │                                        ▐▀▀▀▀                             │
    │                                        ▐                                 │
2.30┤                                      ▛▀▀                                 │
    │                                      ▌                                   │
    │                                   ▐▀▀▘                                   │
    │                                   ▐                                      │
1.90┤                                 ▐▀▀                                      │
    │                                 ▐                                        │
    │                               ▗▄▟                                        │
    │                               ▐                                          │
1.50┤                              ▗▟                                          │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

───────────────────────── Sum Time Running on CPU (ms) ─────────────────────────
CPU1.0 ▇▇▇▇ 32.53
CPU4.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 540.3

───────────────── 2234 rampup CPU1.0 Frequency residency (ms) ──────────────────
0.6   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 12.1
0.972 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 6.5
1.332 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.7
1.704 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.5
2.064 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.8

───────────────── 2234 rampup CPU4.0 Frequency residency (ms) ──────────────────
1.5   ▇▇▇▇▇ 4.0
1.728 ▇▇▇▇▇▇▇▇▇▇ 8.0
1.956 ▇▇▇▇▇▇▇▇▇▇▇▇ 9.0
2.184 ▇▇▇▇▇▇▇▇▇▇▇▇ 9.0
2.388 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 11.0
2.592 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 16.0
2.772 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 18.0
2.988 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 47.0
3.096 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 53.4

Response time with rampup multiplier = 2
-----------------------------------------

                             rampup-2331 util_avg running
      ┌────────────────────────────────────────────────────────────────────────┐
1002.0┤                                                          ▄▄▄▄▄▄▄▛▀▀▀▀▀▀│
      │                                                  ▄▄▄▟▀▀▀▀▘             │
      │                                             ▗▄▟▀▀▘                     │
      │                                          ▗▄▛▀                          │
 751.5┤                                       ▗▄▛▀                             │
      │                                      ▟▀                                │
      │                                   ▗▟▀▘                                 │
 501.0┤                                  ▟▀                                    │
      │                                ▗▟▘                                     │
      │                               ▄▛                                       │
      │                              ▟▘                                        │
 250.5┤                            ▗▛▘                                         │
      │                           ▄▛                                           │
      │                          ▟▘                                            │
      │                        ▄▛▘                                             │
   0.0┤                     ▄▄▛                                                │
      └┬───────┬───────┬───────┬───────┬──────┬───────┬───────┬───────┬───────┬┘
     1.700   1.733   1.767   1.800   1.833  1.867   1.900   1.933   1.967 2.000

───────────────── rampup-2331 util_avg running residency (ms) ──────────────────
0.0    ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1.7
4.0    ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 6.0
26.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
52.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
67.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0
93.0   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1.9000000000000001
106.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
126.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
149.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
170.0  ▇▇▇▇▇▇▇▇▇ 1.0
182.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
206.0  ▇▇▇▇▇▇▇▇▇ 1.0
217.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
239.0  ▇▇▇▇▇▇▇▇▇ 1.0
251.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
275.0  ▇▇▇▇▇▇▇▇▇ 1.0
286.0  ▇▇▇▇▇▇▇▇▇ 1.0
299.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
322.0  ▇▇▇▇▇▇▇▇▇ 1.0
334.0  ▇▇▇▇▇▇▇▇▇ 1.0
345.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
368.0  ▇▇▇▇▇▇▇▇▇ 1.0
379.0  ▇▇▇▇▇▇▇▇▇ 1.0
391.0  ▇▇▇▇▇▇▇▇▇ 1.0
402.0  ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
424.0  ▇▇▇▇▇▇▇▇▇ 1.0
434.0  ▇▇▇▇▇▇▇▇▇ 1.0
445.0  ▇▇▇▇▇▇▇▇▇ 1.0
455.0  ▇▇▇▇▇▇▇▇▇ 1.0

───────────────────────── Sum Time Running on CPU (ms) ─────────────────────────
CPU0.0 ▇ 16.740000000000002
CPU4.0 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 726.91

                            2331 rampup CPU0.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
2.06┤                         ▛                                                │
    │                         ▌                                                │
    │                         ▌                                                │
    │                         ▌                                                │
1.70┤                        ▛▘                                                │
    │                        ▌                                                 │
    │                        ▌                                                 │
1.33┤                       ▗▌                                                 │
    │                       ▐                                                  │
    │                       ▐                                                  │
    │                       ▐                                                  │
0.97┤                       ▟                                                  │
    │                       ▌                                                  │
    │                       ▌                                                  │
    │                       ▌                                                  │
0.60┤                     ▗▄▌                                                  │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

                            2331 rampup CPU4.0 Frequency
    ┌──────────────────────────────────────────────────────────────────────────┐
3.14┤                                       ▄▄▄▄▄▟▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀│
    │                                  ▛▀▀▀▀▘                                  │
    │                                ▄▄▌                                       │
    │                              ▄▄▌                                         │
2.51┤                             ▄▌                                           │
    │                             ▌                                            │
    │                           ▐▀▘                                            │
1.87┤                          ▐▀                                              │
    │                         ▗▟                                               │
    │                          ▌                                               │
    │                          ▌                                               │
1.24┤                          ▌                                               │
    │                          ▌                                               │
    │                          ▌                                               │
    │                          ▌                                               │
0.60┤                          ▌                                               │
    └┬───────┬───────┬───────┬───────┬────────┬───────┬───────┬───────┬───────┬┘
   1.700   1.733   1.767   1.800   1.833    1.867   1.900   1.933   1.967 2.000

───────────────── 2331 rampup CPU0.0 Frequency residency (ms) ──────────────────
0.6   ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 5.7
0.972 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
1.332 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 2.0
1.704 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 4.0
2.064 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 3.0

───────────────── 2331 rampup CPU4.0 Frequency residency (ms) ──────────────────
0.6   ▇ 1.0
1.728 ▇▇ 2.9
1.956 ▇▇ 4.0
2.184 ▇▇▇ 6.0
2.388 ▇▇ 4.0
2.592 ▇▇▇▇ 7.0
2.772 ▇▇▇▇▇ 9.0
2.988 ▇▇▇▇▇▇▇▇▇▇▇ 20.0
3.096 ▇▇▇▇▇▇▇▇▇▇▇▇▇ 23.0
3.144 ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 118.3

Speedometer score:
------------------

With the fix [2] applied to keep rate_limit_us as small as possible

                      | score
----------------------+--------
default               |  352
rampup multiplier = 1 |  388
rampup multiplier = 2 |  427
rampup multiplier = 3 |  444
rampup multiplier = 4 |  456

[1] https://github.com/qais-yousef/rampup
[2] https://lore.kernel.org/lkml/20240728192659.58115-1-qyousef@layalina.io/
[3] https://lore.kernel.org/lkml/20231208002342.367117-1-qyousef@layalina.io/

Qais Yousef (16):
  sched: cpufreq: Rename map_util_perf to sugov_apply_dvfs_headroom
  sched/pelt: Add a new function to approximate the future util_avg
    value
  sched/pelt: Add a new function to approximate runtime to reach given
    util
  sched/fair: Remove magic hardcoded margin in fits_capacity()
  sched: cpufreq: Remove magic 1.25 headroom from
    sugov_apply_dvfs_headroom()
  sched/schedutil: Add a new tunable to dictate response time
  sched/pelt: Introduce PELT multiplier boot time parameter
  sched/fair: Extend util_est to improve rampup time
  sched/fair: util_est: Take into account periodic tasks
  sched/qos: Add a new sched-qos interface
  sched/qos: Add rampup multiplier QoS
  sched/pelt: Add new waiting_avg to record when runnable && !running
  sched/schedutil: Take into account waiting_avg in apply_dvfs_headroom
  sched/schedutil: Ignore dvfs headroom when util is decaying
  sched/fair: Enable disabling util_est via rampup_multiplier
  sched/fair: Don't mess with util_avg post init

 Documentation/admin-guide/pm/cpufreq.rst      |  17 +-
 Documentation/scheduler/index.rst             |   1 +
 Documentation/scheduler/sched-qos.rst         |  44 +++++
 drivers/cpufreq/cpufreq.c                     |   4 +-
 include/linux/cpufreq.h                       |   3 +
 include/linux/sched.h                         |  12 ++
 include/linux/sched/cpufreq.h                 |   5 -
 include/uapi/linux/sched.h                    |   6 +
 include/uapi/linux/sched/types.h              |  46 +++++
 kernel/sched/core.c                           |  71 +++++++
 kernel/sched/cpufreq_schedutil.c              | 174 +++++++++++++++++-
 kernel/sched/debug.c                          |   5 +
 kernel/sched/fair.c                           | 149 +++++++++++++--
 kernel/sched/pelt.c                           | 140 ++++++++++++--
 kernel/sched/sched.h                          |  12 ++
 kernel/sched/syscalls.c                       |  37 ++++
 .../trace/beauty/include/uapi/linux/sched.h   |   4 +
 17 files changed, 685 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/scheduler/sched-qos.rst

-- 
2.34.1


