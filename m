Return-Path: <linux-pm+bounces-9268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97AE90A0E7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 02:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03742B2136F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 00:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E71FB2;
	Mon, 17 Jun 2024 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="NCBSrSCF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A717F5
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718583643; cv=none; b=Iq4DTarvoK4xRE6c/jK076hAhDuAkvxzK/kJR1fz0XryB8EwhBPXqqlWjJk5x26dklJEvup5jIIhlTeZ735Q4KL7e0ATf3Nn5fNs/sgV+/WhqWHCa+FUKj3S2gIKmFdAHAe894lOjcnHtJaQSQBuqsCp9ffcgG89HFzQAbxRgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718583643; c=relaxed/simple;
	bh=ElGcE93YPNO6+VXOMNHd+8lGckGOEQ+jLeA+6EHVD+U=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6/aptPLJhEiBRiI6HYKQiwHxI6TtPmf+elhGgFgBl8KsNQMzfyLRASFbHdyCgjxdprsfLcVLze7qhcdEg42QEUW1l3q8/SfitSrp8PvWXkBLNV1/fmSuFeiEmmCMLgfGj5sopupaM4WumiZsRL2WN+J/T7rPLLUlMmyJ7gy3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=NCBSrSCF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70413de08c7so2743743b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1718583641; x=1719188441; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=91YtqfEB2yGHwH8Rhem+uFZ4ogM7NT/580ia4kMPl3E=;
        b=NCBSrSCFvEYxmWGqQg1uo5AX+i5QcALYBk5CZ9w11fB1NdStWGGg1S09znbBihpXys
         W0yByu+YJ9673Ihzoi2BfKh0lFd1O1ledcFD7H4ZmwnVnN4CiRlg6r9ddZns/K/mpmaC
         n9s+aUABwQT8CaOR3qQ2x6GmW2lnuKCMQl/lPDwH+K1885ncRfkiEBnR3b4AlgMqk1Ct
         MEAn5ljqc0VvIDGnBhtAgL26dFKmGLLEL4JDP+ucnwi30fns4t0Q48jjtUFbS/SOoDCO
         t5Fe30Ap7HfoxTa+8Q2GForJKyf7PlF5agppjqx/Ah+GXXRPPDIbxzSBOFmaPYM5rgnO
         eI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718583641; x=1719188441;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91YtqfEB2yGHwH8Rhem+uFZ4ogM7NT/580ia4kMPl3E=;
        b=iBUhF8i49XH1gdmBGPC3j60h6XKdbKrHkuDa0mZC+cdupNzNgoNHDyVkc9qnVr2t3z
         zb3m88ZzUCrNSpldoOuOMiB2152ZEQWEU6RqLAdhLU7033912LuReKLQBD++vgdQLkX9
         IlOcBLxWBjTphSIzGvpnXmZeQraUBYvIhQhl3czJMwjVAhQ1FH9agoakPt4uHc9JeEl8
         3j7XudVmRBEz4AXX+ZPOmGsWGzxded8Qyms1Np+8Fcon1xbonEIJznGU8cCHDb+C+Mkf
         EgeuaNY3EhdVgvOt8pJ/mi3bxVKd0HPSjF3819KdVh1xue9AenQuvrpfua8HUptCsSWv
         mIug==
X-Forwarded-Encrypted: i=1; AJvYcCXvPnoevjWsLrqRiP7sAo3OChQrWVJXkUiCvhToKOi4cDIdQvf1kQ42HPESIdiHoPiiDOlZ1SfHK0q1pSR+qUfNqdxSKO+GpDg=
X-Gm-Message-State: AOJu0YwNNif0Ley6bMfe2LiTda6BEjsBkMiV7BVEZFhrOx5mfYHba3lv
	xM2f/mkV3rYBeOJWSVFK+aqQ6pQHPhJWtpdf6JqQC5GMq/b2WMia+mLeKNRSsoA=
X-Google-Smtp-Source: AGHT+IEWad3GVlaqCppoLGsu5NX/4C4FRSP893Bd6cawh9xwCIh7hhcKHHGuMcIDuYBcBPa68tgufw==
X-Received: by 2002:a05:6a00:26cb:b0:705:d755:69b0 with SMTP id d2e1a72fcca58-70603623c99mr1253331b3a.6.1718583640993;
        Sun, 16 Jun 2024 17:20:40 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb85490sm6427210b3a.183.2024.06.16.17.20.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2024 17:20:40 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Christian Loehle'" <christian.loehle@arm.com>,
	<rafael@kernel.org>
Cc: <vincent.guittot@linaro.org>,
	<qyousef@layalina.io>,
	<peterz@infradead.org>,
	<daniel.lezcano@linaro.org>,
	<ulf.hansson@linaro.org>,
	<anna-maria@linutronix.de>,
	<kajetan.puchalski@arm.com>,
	<lukasz.luba@arm.com>,
	<dietmar.eggemann@arm.com>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20240611112413.1241352-1-christian.loehle@arm.com>
In-Reply-To: <20240611112413.1241352-1-christian.loehle@arm.com>
Subject: RE: [PATCHv2 0/3] cpuidle: teo: Fixing utilization and intercept logic
Date: Sun, 16 Jun 2024 17:20:43 -0700
Message-ID: <004a01dac04c$314c4360$93e4ca20$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHzep4n7RUpOXZFjs7PHwMj2t6TVLGY73sg

On 2024.06.11 04:24 Christian Loehle wrote:

...
> Happy for anyone to take a look and test as well.
...

I tested the patch set.
I do a set of tests adopted over some years now.
Readers may recall that some of the tests search over a wide range of =
operating conditions looking for areas to focus on in more detail.
One interesting observation is that everything seems to run much slower =
than the last time I did this, last August, Kernel 6.5-rc4.

Test system:
Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz (6 cores, 2 thread =
per core, 12 CPUs)
CPU Frequency scaling driver: intel_pstate
HWP (HardWare Pstate) control: Disabled
CPU frequency scaling governor: Performance
Idle states: 4: name : description:
   state0/name:POLL		desc:CPUIDLE CORE POLL IDLE
   state1/name:C1_ACPI		desc:ACPI FFH MWAIT 0x0
   state2/name:C2_ACPI		desc:ACPI FFH MWAIT 0x30
   state3/name:C3_ACPI		desc:ACPI FFH MWAIT 0x60
Ilde driver: intel_idle
Idle governor: as per individual test
Kernel: 6.10-rc2 and with V1 and V2 patch sets (1000 Hz tick rate)
Legend:
   teo: unmodified 6.10-rc2
   menu:=20
   ladder:
   cl: Kernel 6.10-rc2 + Christian Loehle patch set V1
   clv2: Kernel 6.10-rc2 + Christian Loehle patch set V2
System is extremely idle, other than the test work.

Test 1: 2 core ping pong sweep:

Pass a token between 2 CPUs on 2 different cores.
Do a variable amount of work at each stop.

Purpose: To utilize the shallowest idle states
and observe the transition from using more of 1
idle state to another.

Results relative to teo (negative is better):
		menu		ladder		clv2		cl
average		-2.09%		11.11%		2.88%		1.81%
max		10.63%		33.83%		9.45%		10.13%
min		-11.58%	6.25%		-3.61%		-3.34%

While there are a few operating conditions where clv2 performs better =
than teo, overall it is worse.

Further details:
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/2-core-pp-r=
elative.png
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/2-core-pp-d=
ata.png
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/2-1/perf/

Test 2: 6 core ping pong sweep:

Pass a token between 6 CPUs on 6 different cores.
Do a variable amount of work at each stop.

Purpose: To utilize the midrange idle states
and observe the transitions between use of
idle states.

Note: This test has uncertainty in an area where the performance is =
bi-stable for all idle governors,
transitioning between much less power and slower performance and much =
more power and higher performance.
On either side of this area, the differences between all idle governors =
are negligible.
Only data from before this area (from results 1 t0 95) was included in =
the below results.

Results relative to teo (negative is better):
		menu	ladder	cl	clv2
average		0.16%	4.32%	2.54%	2.64%
max		0.92%	14.32%	8.78%	8.50%
min		-0.44%	0.27%	0.09%	0.05%

One large clv2 difference seems to be excessive use of the deepest idle =
state,
with corresponding 100% hit rate on the "Idle State 3 was to deep" =
metric.
Example (20 second sample time):

teo: Idle state 3 entries: 600, 74.33% were to deep or 451. Processor =
power was 38.0 watts.
clv2: Idle state 3 entries: 4,375,243, 100.00% were to deep or =
4,375,243. Processor power was 40.6 watts.
clv2 loop times were about 8% worse than teo.

Further details:
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-d=
ata-detail-a.png
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-d=
ata-detail-b.png
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/6-core-pp-d=
ata.png
http://smythies.com/~doug/linux/idle/teo-util3/ping-sweep/6-1/perf/

Test 3: sleeping ebizzy - 128 threads.

Purpose: This test has given interesting results in the past.
The test varies the sleep interval between record lookups.
The result is varying usage of idle states.

Results: relative to teo (negative is better):
		menu	clv2	ladder	cl
average		0.06%	0.38%	0.81%	0.35%
max		2.53%	3.20%	5.00%	2.87%
min		-2.13%	-1.66%	-3.30%	-2.13%

No strong conclusion here, from just the data.
However, clv2 seems to use a bit more processor power, on average.

Further details:

Test4: adrestia wakeup latency tests. 500 threads.

Purpose: The test was reported in 2023.09 by the kernel test robot and =
looked
both interesting and gave interesting results, so I added it to the =
tests I run.

Results:
teo:wakeup cost (periodic, 20us): 3130nSec reference
clv2:wakeup cost (periodic, 20us): 3179nSec +1.57%
cl:wakeup cost (periodic, 20us): 3206nSec +2.43%
menu:wakeup cost (periodic, 20us): 2933nSec -6.29%
ladder:wakeup cost (periodic, 20us): 3530nSec +12.78%

No strong conclusion here, from just the data.
However, clv2 seems to use a bit more processor power, on average.
teo: 69.72 watts
clv2: 72.91 watts +4.6%
Note 1: The first 5 minutes of the test powers were discarded to allow =
for thermal stabilization.
Note 2: More work is required for this test, because the teo one =
actually took longer to execute, due to more outlier results than the =
other tests.

There were several other tests run but are not written up herein.





