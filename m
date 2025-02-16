Return-Path: <linux-pm+bounces-22167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC3A37597
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 17:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51727A12D5
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A289199FA2;
	Sun, 16 Feb 2025 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="XRD2yXlq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B8199938
	for <linux-pm@vger.kernel.org>; Sun, 16 Feb 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722563; cv=none; b=SwjihFRCIQfh0YJbe0o4Akzc1tSQxYoPHL7+8BeAqRknuGonSihZ1UMFES9Hyx/wiBoImxkm7vnwOxj4QJSlvz06sklmbMWeemZ8KnFv3Y3qyfhSj1u7sD/RkO6SZ+c3rNnqVLq99vZj+tvLVVFvfutjjdwF7BDfjgriy09gKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722563; c=relaxed/simple;
	bh=I0HOQr1w/yIlAHliRsltz3Ea1r3xIe8AhmXPZZwW2xo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uQ6HsYV4vcna/XvsOhjMhcS0aB7qL2LCd3SSTDaobSrUbRBfMcxlYOPrTq9PMoHWLg8Dl+Lk2ZlCpZGM9n28APOulV+5QUAccZip5lRmvxuRF9+S2V0GnIuxVxR8re3w0sbfMHTTW4pBOp2lLocDebBYLQWX+DvqZgUmZ0SyZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=XRD2yXlq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc3fa00323so2770300a91.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Feb 2025 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1739722560; x=1740327360; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmnbpjavUk/CuVZT280ickKMyx5bB1TVQY2H0hWRlMs=;
        b=XRD2yXlqJdZ+9cezigjX3s51BcfbEb+XsfgBp72Huldh70vI1l7mgNn3ZXGBemR7ww
         bkKNTwnX2VYGKtNetHdVjnznsqtOGyLandEKNYY53bmQju5cDJukbp85RO6B1qpnFTKC
         8/Wqd40XNM8iMG5K/3UdPkwr9VXUtFt7ZfkzPnRecuyIilNAPxFn4rCetQAxZuvEbj0B
         /D1rApbgHE3WhB2gbiasoL7FrRQmjDc3OCelFv8EHSXIHcXe6tFJUftN4bKZIKxvpMIF
         C1BYvTTpx1TIV9T+F2iQZEzgYn/4PAKqE6ajqAKSGpS6bKF5rCSyfd9s+c3aZRb+46dP
         G6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722560; x=1740327360;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmnbpjavUk/CuVZT280ickKMyx5bB1TVQY2H0hWRlMs=;
        b=t3WSylQGKdN9gf+z8GfsjTApAHYpVGcub1oayF5ChcraNnLSESeEWcKTV2fWA3QJFG
         IFfruNToACjMtlGkSA6YiWR+L/9KAWGd6oQR8iIpHNRaiNJVkn3HGCAp3QHbmXFGkw/W
         NJ05cxrQmab3KlTKVs5pchbANrOaugRo7fKR0Lvh60usERfB23tiupkNGFcirbazLmIx
         S6xjNopVZsliOOWt6D7i5xgqqvMQlE+NfOVjA4LSEo5ScoZBPftPELWXVyQKFKZeWdyw
         VtWXAYTFqmeH2JmrR0jJ1IAlGBAipKtqNAk/HOoggsdPqnkAWgGNPnoC7wG9jHRZncVp
         1EaA==
X-Forwarded-Encrypted: i=1; AJvYcCXdzBxo/i31L+SbR5fudBRh6azYkI9KnVHOgJyHui8zkN2Lc2bn28cfcrSV1SRlU12h2yE8hhmfsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbK+ynkwDOgcbOnIQzpaeTZL3FJUVhCIQMhTldRoaDIT8ADFrA
	OaBvB38BwFK3TP8fzQtFSuZ0AcACcGEMYdSh+5KEzsxQWy74ivGAwJMf4KoQp2Q=
X-Gm-Gg: ASbGncthd7ov/ljQQq5TpPk+fe6tzudDxzaOtVCzVhmTZJNTACfLc5VV4/7e2n0hFh8
	YRJ5xUkMpSD+ehaixTa+S+yaTS5707ClCCHwoc8D1Ynq5H5kce4EKV1SET7ZBoMg1CWJs6n2hWZ
	bUiq5SzF3XMrLCAmOBf71lqQZeSqbHpEW7FHzXroxVMc9nYGk7Jz+9XEf6229YtD0NXelpzBXns
	FpnyaoRsK6GhAdfD0EHDe3MLnXWUlDlVzFMpnSNrEL7Y1ylDCqoPAQ6FFU7Fq2e4pKADFHbLlQR
	flxbzlAYToXoWYqV/XVXdE+G5rsa9pSfVFPHztPGIut9RLIMKyhtsqPi
X-Google-Smtp-Source: AGHT+IEdOmcNFFSWepKTEL+0HV0znddh17lC/WVDlF0Awl6+sOwLRdzFAF4sa3wzZcasgHMR4nRJng==
X-Received: by 2002:a05:6a21:7e83:b0:1ee:aa76:2325 with SMTP id adf61e73a8af0-1eeaa7624b5mr2089435637.13.1739722560213;
        Sun, 16 Feb 2025 08:16:00 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327667b1dfsm959387b3a.124.2025.02.16.08.15.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2025 08:15:59 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Aboorva Devarajan'" <aboorvad@linux.ibm.com>,
	"Doug Smythies" <dsmythies@telus.net>
References: <1916668.tdWV9SEqCh@rjwysocki.net> <003b01db7e99$34791c50$9d6b54f0$@telus.net> <CAJZ5v0jRctJV9eBZA=e737W0tot-4C+wrrQ2xUCVZDuYwym3=Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jRctJV9eBZA=e737W0tot-4C+wrrQ2xUCVZDuYwym3=Q@mail.gmail.com>
Subject: RE: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful information when processing recent idle intervals
Date: Sun, 16 Feb 2025 08:16:00 -0800
Message-ID: <002501db808e$1225a550$3670eff0$@telus.net>
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
Thread-Index: AQD+BgZZG1yDo2pCGl+Ay1eM9EzyOwJI88xZAclEgcy05HxoUA==
Content-Language: en-ca

On 2025.02.14 14:10 Rafael J. Wysocki wrote:
> On Fri, Feb 14, 2025 at 5:30=E2=80=AFAM Doug Smythies =
<dsmythies@telus.net> wrote:
>> On 2025.02.06 06:22 Rafael J. Wysocki wrote:
>>>
>>> This work had been triggered by a report that commit 0611a640e60a =
("eventpoll:
>>> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS =
metric of
>> ... deleted ...
>>
>> This is a long email. It contains test results for several recent =
idle governor patches:
>
> Thanks a lot for this data, it's really helpful!
>
>> cpuidle: teo: Cleanups and very frequent wakeups handling update
>> cpuidle: teo: Avoid selecting deepest idle state over-eagerly =
(Testing aborted, after the patch was dropped.)
>> cpuidle: menu: Avoid discarding useful information when processing =
recent idle intervals
>>
>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
>> Distro: Ubuntu 24.04.1, server, no desktop GUI.
>>
>> CPU frequency scaling driver: intel_pstate
>> HWP: disabled.
>> CPU frequency scaling governor: performance
>>
>> Ilde driver: intel_idle
>> Idle governor: as per individual test
>> Idle states: 4: name : description:
>>    state0/name:POLL             desc:CPUIDLE CORE POLL IDLE
>>    state1/name:C1_ACPI          desc:ACPI FFH MWAIT 0x0
>>    state2/name:C2_ACPI          desc:ACPI FFH MWAIT 0x30
>>    state3/name:C3_ACPI          desc:ACPI FFH MWAIT 0x60
>>
>> Legend:
>> teo-613: teo governor - Kernel 6.13: before "cpuidle: teo: Cleanups =
and very frequent wakeups handling update"
>> menu-613: menu governor - Kernel 6.13: before "cpuidle: teo: Cleanups =
and very frequent wakeups handling update"
>> teo-614: teo governor - Kernel 6.14-rc1: Includes cpuidle: teo: =
Cleanups and very frequent wakeups handling update
>> menu-614: menu governor - Kernel 6.14-rc1: Includes cpuidle: teo: =
Cleanups and very frequent wakeups handling update
>> teo-614-p: teo governor - Kernel 6.14-rc1-p: Includes "cpuidle: teo: =
Avoid selecting deepest idle state over-eagerly"
>> menu-614-p: menu governor - Kernel 6.14-rc1-p: Includes "cpuidle: =
menu: Avoid discarding useful information when processing recent idle =
intervals"
>>
>> I do a set of tests adopted over some years now.
>> Readers may recall that some of the tests search over a wide range of =
operating conditions looking for areas to focus on in more detail.
>> One interesting observation is that everything seems to run slower =
than the last time I did this, June 2024, Kernel 6.10-rc2,
>> which was also slower than the time before that, August 2023, Kernel =
6.5-rc4.
>> There are some repeatability issues with the tests.
>>
>> I was unable to get the "cpuidle: teo: Cleanups and very frequent =
wakeups handling update" patch set to apply to kernel 6.13, and so just =
used kernel 6.14-rc1, but that means that all the other commits
>> between the kernel versions are included. This could cast doubt on =
the test results, and indeed some differences in test results are =
observed with the menu idle governor, which did not change.
>>
>> Test 1: System Idle
>>
>> Purpose: Basic starting point test. To observe and check an idle =
system for excessive power consumption.
>>
>> teo-613: 1.752 watts (reference: 0.0%)
>> menu-613: 1.909 watts (+9.0%)
>> teo-614: 2.199 watts (+25.51%)   <<< Test flawed. Needs to be redone. =
Will be less.
>> teo-614-2: 2.112 watts (+17.05%) <<< Re-test of teo-614. (don't care =
about 0.4 watts)
>> menu-614: 1.873 watts (+6.91%)
>> teo-614-p: 9.401 watts (+436.6%)  <<< Very bad regression.
>
> Already noted.
>
> Since I've decided to withdraw this patch, I will not talk about it =
below.

Yes, just repeated here for completeness. And, I didn't reprocess work =
already done to delete teo-614-p results.
>
>> menu-614-p: 1.820 watts (+3.9%)
>
> And this is an improvement worth noting.
>
> Generally speaking, I'm mostly interested in the differences between
> teo-613 and teo-614 and between menu-6.14 and menu-614-p.
>
>> Further details:
>> http://smythies.com/~doug/linux/idle/teo-6.14/idle/perf/
>>
>> Test 2: 2 core ping pong sweep:
>>
>> Pass a token between 2 CPUs on 2 different cores.
>> Do a variable amount of work at each stop.
>> NOT a timer based test.
>>
>> Purpose: To utilize the shallowest idle states
>> and observe the transition from using more of 1
>> idle state to another.
>>
>> Results relative to teo-613 (negative is better):
>>         menu-613        teo-614         menu-614        menu-614-p
>> average -2.06%          -0.32%          -2.33%          -2.52%
>> max     9.42%           12.72%          8.29%           8.55%
>> min     -10.36%         -3.82%          -11.89%         -12.13%
>>
>> No significant issues here. There are differences on idle state =
preferences.
>>
>> Standard "fast" dwell test:
>>
>> teo-613: average 3.826 uSec/loop reference
>> menu-613: average 4.159 +8.70%
>> teo-614: average 3.751 -1.94%
>
> A small improvement.
>
>> menu-614: average 4.076 +6.54%
>> menu-614-p: average 4.178 +9.21%
>>
>> Interestingly, teo-614 also uses a little less power.
>> Note that there is an offsetting region for the menu governor where =
it performs better
>> than teo, but it was not extracted and done as a dwell test.
>>
>> Standard "medium dwell test:
>>
>> teo-613: 12.241 average uSec/loop reference
>> menu-613: 12.251 average +0.08%
>> teo-614: 12.121 average -0.98%
>
> Similarly here, but smaller.
>
>> menu-614: 12.123 average -0.96%
>> menu-614-p: 12.236 average -0.04%
>>
>> Standard "slow" dwell test: Not done.
>>
>> Further details:
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/loop-times.png=

>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/loop-times-rel=
ative.png
>> http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-2/perf/
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/many-0-400000000-2/perf/
>> http://smythies.com/~doug/linux/idle/teo-6.14/many-3000-100000000-2/
>>
>> Test 3: 6 core ping pong sweep:
>>
>> Pass a token between 6 CPUs on 6 different cores.
>> Do a variable amount of work at each stop.
>> NOT a timer based test.
>>
>> Purpose: To utilize the midrange idle states
>> and observe the transitions between use of
>> idle states.
>>
>> Note: This test has uncertainty in an area where the performance is =
bi-stable for all idle governors,
>> transitioning between much less power and slower performance and much =
more power and higher performance.
>> On either side of this area, the differences between all idle =
governors are small.
>> Only data from before this area (from results 1 to 95) was included =
in the below results.
>>
>> Results relative to teo-613 (negative is better):
>>         teo-614 menu-613        menu-614        menu-614-p
>> average 1.60%   0.18%           0.02%           0.02%
>> max     5.91%   0.97%           1.12%           0.85%
>> min     -1.79%  -1.11%          -1.88%          -1.52%
>>
>> A further dwell test was done in the area where teo-614 performed =
worse.
>> There was a slight regression in both performance and power:
>>
>> teo-613: average 21.34068 uSec per loop
>> teo-614: average 20.55809 usec per loop 3.67% regression
>
> As this is usec per loop, I'd think that smaller would be better?

Sorry, my mistake. That was written backwards, corrected below:

teo-613: average 20.55809 uSec per loop
teo-614: average 21.34068 usec per loop 3.67% regression
>
>> teo-613: average 37.17577 watts.
>> teo-614: average 38.06375 watts. 2.3% regression.
>
> Which would be consistent with this.

There was both a regression in performance and power at this operating =
point.

Another dwell test was done where menu-614-p did better than menu-614:
uSec per loop:

        menu-614        menu-614-p
average 807.896         772.376
max     962.265         946.880
min     798.375         755.430

        menu-614        menu-614-p
average 0.00%           -4.40%
max     19.11%          17.20%
min     -1.18%          -6.49%

menu-614: average 28.056 watts.
menu-614-p: average 28.863 watts. 2.88% more.
Note: to avoid inclusion of thermal stabilization times, only data from =
30 to 45 minutes into the test were included in the average power =
calculation.

>> Further details:
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times.png=

>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times-det=
ail-a.png
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/loop-times-det=
ail-b.png
>> http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/perf/
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/dwell/perf/
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/dwell-2/loop-t=
imes.png
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-6/dwell-2/perf/
>>
>> Test 4: 12 CPU ping pong sweep:
>>
>> Pass a token between all 12 CPUs.
>> Do a variable amount of work at each stop.
>> NOT a timer based test.
>>
>> Purpose: To utilize the deeper idle states
>> and observe the transitions between use of
>> idle states.
>>
>> This test was added last time at the request of Christian Loehle.
>>
>> Note: This test has uncertainty in an area where the performance is =
bi-stable for all idle governors,
>> transitioning between much less power and slower performance and much =
more power and higher performance.
>> On either side of this area, the differences between all idle =
governors are small.
>>
>> Only data from before this area (from results 1 to 60) was included =
in the below results:
>>
>> Results relative to teo-613 (negative is better):
>>         teo-614 menu-613        menu-614        teo-614-p       =
menu-614-p
>> ave     1.73%   0.97%           1.29%           1.70%           0.43%
>> max     16.79%  3.52%           3.95%           17.48%          4.98%
>> min     -0.35%  -0.35%          -0.18%          -0.40%          =
-0.54%
>>
>> Only data from after the uncertainty area (from results 170-300) was =
included in the below results:
>>
>>         teo-614 menu-613        menu-614        teo-614-p       =
menu-614-p
>> ave     1.65%   0.04%           0.98%           -0.56%          0.73%
>> max     5.04%   2.10%           4.58%           2.44%           3.82%
>> min     0.00%   -1.89%          -1.17%          -1.95%          =
-1.38%
>>
>> A further dwell test was done in the area where teo-614 performed =
worse and there is a 15.74%
>> throughput regression for teo-614 and a 5.4% regression in power.

My input is to consider this test further in the decision making.

>> Further details:
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-loop-ti=
mes.png
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-loop-ti=
mes-detail-a.png
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/sweep-relativ=
e-times.png
>> http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/perf/
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/dwell/times.t=
xt
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ping-sweep-12/dwell/perf/
>>
>> Test 5: sleeping ebizzy - 128 threads.
>>
>> Purpose: This test has given interesting results in the past.
>> The test varies the sleep interval between record lookups.
>> The result is varying usage of idle states.
>>
>> Results: Nothing significant to report just from the performance =
data.
>> However, there does seem to be power differences worth considering.
>>
>> A futher dwell test was done in a cherry picked spot.
>> It it is important to note that teo-614 removed a sawtooth =
performance
>> pattern that was present with teo-613. I.E. it is more stable. See:
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps-only-teo.p=
ng

While re-examining menu-614 and menu-614-p, and to reduce clutter, this =
graph was made:
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps-only-menu.=
png
menu-614: average 8722.787 records per second
menu-614-p: average 8683.387 records per second 0.45% regression (i.e. =
negligible)

>> Further details:
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/interval-sweep.png
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/relative-performance=
.png
>> http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/perf/
>> http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps.png
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/rps-relative.p=
ng
>> http://smythies.com/~doug/linux/idle/teo-6.14/ebizzy/dwell/perf/
>>
>> Test 6: adrestia wakeup latency tests. 500 threads.
>>
>> Purpose: The test was reported in 2023.09 by the kernel test robot =
and looked
>> both interesting and gave interesting results, so I added it to the =
tests I run.
>>
>> Results:
>> teo-613.txt:wakeup cost (periodic, 20us): 3331nSec reference
>> teo-614.txt:wakeup cost (periodic, 20us): 3375nSec +1.32%
>> menu-613.txt:wakeup cost (periodic, 20us): 3207nSec -3.72%
>> menu-614.txt:wakeup cost (periodic, 20us): 3315nSec -0.48%
>> menu-614-p.txt:wakeup cost (periodic, 20us): 3353nSec +0.66%
>>
>> Further details:
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/histogram=
.png
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/histogram=
-detail-a.png
>> http://smythies.com/~doug/linux/idle/teo-6.14/adrestia/periodic/perf/
>>
>> Test 7: consume: periodic workflow. Various work/sleep frequencies =
and loads.
>>
>> Purpose: To search for anomalies and hysteresis over all possible =
workloads at various work/sleep frequencies.
>> work/sleep frequencies tested: 73, 113, 211, 347, and 401 Hertz.
>> IS a timer based test.
>>
>> NOTE: Repeatability issues. More work needed.
>>
>> Tests show instability with teo-614, but a re-test was much less =
unstable and better power.
>> Idle statistics were collected for the re-test and does show teo-614 =
overly favoring idle state 1, with
>> "Idle state 1 was too shallow" of 70% verses 15% for teo-613.

I'll try to do some more experiments with these timer based periodic =
type workflows.

>> Further details:
>> http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf73/
>> http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf113/
>> http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf211/
>> http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf347/
>> http://smythies.com/~doug/linux/idle/teo-6.14/consume/pf401/
>> http://smythies.com/~doug/linux/idle/teo-6.14/consume/test/
>> http://smythies.com/~doug/linux/idle/teo-6.14/consume/test-idle/
>>
>> Test 8: shell-intensive serialized workloads.
>>
>> Variable: PIDs per second, amount of work each task does.
>> Note: Single threaded.
>>
>> Dountil the list of tasks is finished:
>>     Start the next task in the list of stuff to do (with a new PID).
>>     Wait for it to finish
>> Enduntil
>>
>> This workflow represents a challenge for CPU frequency scaling =
drivers,
>> schedulers, and therefore idle drivers.
>>
>> Also, the best performance is achieved by overriding
>> the scheduler and forcing CPU affinity. This "best" case is the
>> master reference, requiring additional legend definitions:
>> 1cpu-613: Kernel 6.13, execution forced onto CPU 3.
>> 1cpu-614: Kernel 6.14-rc1, execution forced onto CPU 3.
>>
>> Ideally the two 1cpu graphs would be identical, but they are not,
>> likely due to other changes between the two kernels.
>>
>> Results:
>> teo-614 is absolutely outstanding in this test.
>> Considerably better than any previous result over many years.
>
> Sounds good!

This improvement is significant.
I redid the teo-614 test to prove repeatability and dismiss operator =
error.
It was also good. I did not re-do the published graphs.

>> Further details:
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/times.pn=
g
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/times-lo=
g.png
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/relative=
.png
>> =
http://smythies.com/~doug/linux/idle/teo-6.14/pid-per-sec/perf-3/relative=
-log.png
>>
>> Test 9: Many threads, periodic workflow
>>
>> 500 threads of do a little work and then sleep a little.
>> IS a timer based test.
>>
>> Results:
>> Kernel 6.13 teo:    reference
>> Kernel 6.13 menu:   -0.06%
>> Kernel 6.14 teo:    -0.09%
>> Kernel 6.14 menu:   +0.49%
>> Kernel 6.14+p menu: +0.33%
>>
>> What is interesting is the significant differences in idle state =
selection.
>> Powers might be interesting, but much longer tests would be needed to =
achieve thermal equilibrium.
>>
... mess deleted ...
>
> What's the difference between this configuration and the one above?

So sorry, big big screwup in my composition of the original email.
The rest was copy of the above with the typos fixed.
Apologies.

... redundant stuff deleted ...

> Overall, having seen these results, I'm not worried about the change
> from teo-613 to teo-614.  The motivation for it was mostly code
> consistency and IMV the results indicate that it was worth doing.

Agree, with hesitation. There are both negative and positive results,
but overall okay.

> Also, if I'm not mistaken, the differences between menu-6.14 and
> menu-6.14-p in the majority of your tests are relatively small (if not
> in the noise) which, given that the latter is a major improvement for
> the SPECjbb workload as reported by Artem, makes me think that I
> should queue up menu-614-p for 6.15.

Agreed.

> Thanks!



