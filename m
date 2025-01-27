Return-Path: <linux-pm+bounces-20976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85413A1D7A0
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 14:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789DC7A1464
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32E1FFC40;
	Mon, 27 Jan 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbiItWy1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235241FF613;
	Mon, 27 Jan 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986286; cv=none; b=Ix/re+krGoa/hePikLS3gHAGYozIcHagidC2RdmrwE5RzLb+63kkb0OHacMICAaN+EkWo58UGdMfBjBx9fz74+x0Txe5/J3POOXNWEzbWqjuNqz9mJJ30jZeEHARlX6Bnfect59WUyRL7SfujR3sb6iQJcrPAMIXDgeqe80crxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986286; c=relaxed/simple;
	bh=+/oKgNAb4I3EJgzTBAFHc1nM+oFz6naufEDU5jCdccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5WToIL0XStT3okTXgqZRaVodzf1/quMWeSp+rl0Q/mZ8nXTWZDzvd42n45hLcTfmKj0XwnHiNvB8t61X4qtFmE1UL4fYpSNRnsv1niRDHWLH9YJTD7yiWV32GfwIfSi0y+hxWT5A4GBSdLJCS7ApWydC5PI/XGcdPDtvOv/gjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbiItWy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B07C4CEE7;
	Mon, 27 Jan 2025 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737986285;
	bh=+/oKgNAb4I3EJgzTBAFHc1nM+oFz6naufEDU5jCdccI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YbiItWy1jaykrZXmTNksRXPfGvlzLWE+S64f+mvv7Kd5CPB+iWSMpUFooZ3eCozB3
	 SU59EiNnFNTD6lHTBb1tj3gFvtqjVlKm6SgBjh6D4oCxJHx1l3RinXTe8AViBIWyfh
	 H/rFDLIT0Zm8z+k6R34cDxlPM0cNbJWrwRqEl2tPQXKEwv2IgYzZlASbx7915y274Y
	 7XYWjpaAnbKT3h1VP4qjzzvZBe2IUaYVzDYbKvMPYcWA7ZA/1uk5z/qTvMSw99qdQh
	 ScFOIhL4ABUtEDDMlsREVgaWxDqRRobdcsWEC/NfoF1hHnjRa0wCPbTWhU7uYs9Hs2
	 IWjVmBswhYcPw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f89aa7a101so1702737eaf.2;
        Mon, 27 Jan 2025 05:58:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRDaClVZU5VCDPvbq7mdT2YC4ZxBKEJRAtUghEAEJTsaQrFTFeS5a3ih5NEUlGR4sNBmlBQMqnFms=@vger.kernel.org, AJvYcCXKBCh7Z7v/UuH5bf3IpUsQnfu0wWFcio7mrH5S02JYuvmGX0ZjYpQIH90XtchtTw8lSTikf65By4+DEKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4gxGd2HGdbnzLCJbL9sPXFof+u6ZW5kUhU919C1bTgZO9/an
	VuaiAdZx6D4PQ/TOAFELBpjSBiOw48THEMhTnx8f5lkBm19HmhAn/+0CxUHXz5w8arZD3BvIQvx
	M1Z42SiSfzwX6qPGHofu1OkPKePw=
X-Google-Smtp-Source: AGHT+IGQussZz+Y9jtLhVHePIJ0dwV+aHBb3QPKhHKqWJXR2L81t3bmomHwk2K0bBs5KHJEKyesJk4OC1hAOcDZyF8Y=
X-Received: by 2002:a05:6820:1c81:b0:5f8:9f57:4c64 with SMTP id
 006d021491bc7-5fa38877a9cmr23648686eaf.6.1737986284893; Mon, 27 Jan 2025
 05:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <be830a7a-410e-4864-adaf-0c68bb1135f1@arm.com>
In-Reply-To: <be830a7a-410e-4864-adaf-0c68bb1135f1@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Jan 2025 14:57:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hHc5y6LhVRRePr2n2nu=C4XE+Xi-A+D=uxDcsFZDjOJg@mail.gmail.com>
X-Gm-Features: AWEUYZnf9KPWD6OO7OqFxqBwaQWh6Zewq96f2cMgeXz0YBp4Sku8x2j3QqMAMfo
Message-ID: <CAJZ5v0hHc5y6LhVRRePr2n2nu=C4XE+Xi-A+D=uxDcsFZDjOJg@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 0/9] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 12:18=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 29/11/2024 16:55, Rafael J. Wysocki wrote:
>
> [...]
>
> > For easier access, the series is available on the experimental/intel_os=
tate
> > branch in linux-pm.git:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dexperimental/intel_pstate
>
> I was wondering how we can test the EAS behaviour (power/perf) on Intel
> hybrid machines.

Thanks a lot for looking into this, much appreciated!

> I have system-wide RAPL 'power/energy-{cores,pkg}' events for power
> (energy) on my i7-13700K (nosmt) so I can run an rt-app workload
> (e.g. 30 5% tasks (0.8ms/16ms)) with:
>
> perf stat -e power/energy-cores/,power/energy-pkg/ --repeat 10 ./rt-app.s=
h
>
> Plus I can check for negative slack for those rt-app-test tasks (perf)
> and do ftrace-based task placement evaluation.
>
> base:
>
>  Performance counter stats for 'system wide' (10 runs):
>
>        52.67 Joules power/energy-cores/       ( +-  1.24% )
>        85.09 Joules power/energy-pkg/         ( +-  0.83% )
>
>    34.922801 +- 0.000736 seconds time elapsed ( +-  0.00% )
>
>
> EAS:
>
>  Performance counter stats for 'system wide' (10 runs):
>
>        45.55 Joules power/energy-cores/       ( +-  1.07% )
>        75.73 Joules power/energy-pkg/         ( +-  0.67% )
>
>    34.93183 +- 0.00514 seconds time elapsed  ( +-  0.01% )
>
> Do you have another (maybe more sophisticated) test methodology?

Not really more sophisticated, but we cast a wider net, so to speak.

For taks placement testing we use an internal utility that can create
arbitrary synthetic workloads and plot CPU utilization (and other
things) while they are running.  It is kind of similar to rt-app
AFAICS.

We also run various benchmarks and measure energy usage during these
runs, first in order to check if EAS helps in the cases when it is
expected to help, but also to see how it affects the benchmark scores
in general (because we don't want it to make too much of a "negative"
difference for "performance" workloads).

The above results are basically in-line with what we are observing,
but we often see less of a difference in terms of energy usage between
the baseline and EAS enabled.

We also see a lot of task migrations between CPUs in the "low-cost"
PD, mostly in the utilization range where we would expect EAS to make
a difference.  Those migrations are a bit of a concern although they
don't seem to affect benchmark scores.

We think that those migrations are related to the preference of CPUs
with the largest spare capacity, so I'm working on an alternative
approach to enabling EAS that will use per-CPU PDs to see if the
migrations can be reduced this way.

