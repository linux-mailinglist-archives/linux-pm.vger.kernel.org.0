Return-Path: <linux-pm+bounces-13557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8B96BAB5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 13:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3F01C21033
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471B1D04AA;
	Wed,  4 Sep 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuOR3rqP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EDF1CCB43;
	Wed,  4 Sep 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449433; cv=none; b=pFaAxYpEBXGBgkbp8WuCjRstk1y31WADbHUxYnvGAyzgWMUpY/WThRAcp1lAEZA0D2QCUrDkNq36if6LKk+wXOuvTJ4CLWnFPEzc0C7XJgCVPaUtbrYRMWyg91gLuNxWbcW2D6Jx3gGrjnysL9s3fsTI4TgpBnugxdPIeDZv9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449433; c=relaxed/simple;
	bh=itUGG95aN10wugANZlkU+uGqNckP3W7TN0vexPcZYYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmp8rIY+2nQkyBSxfCPUFEyNvmtGR0yOh3wvC2ta3Lmdh5zxRaAtqJ1SZbhapuKvzeeFaMmIgH8CwmQeyrCca53JfKvhWS/jetGjVTW5+Y9Nmj7h92LPQhuZ1hwcZwT0mUsa/QDhTqhRwmIf3+uZNeizQnObfKNvY4F314liDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuOR3rqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E768C4CECC;
	Wed,  4 Sep 2024 11:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725449433;
	bh=itUGG95aN10wugANZlkU+uGqNckP3W7TN0vexPcZYYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cuOR3rqPx0VQg7p2/Uu4fLlFbaorTBnep8Sf+nDG7MPXSUKfGfD8Dbx5DgAJTA/Ke
	 N/RNx1/4EuLGZ24i+WHLJaXkmSFlUv6RldFX8d0tkWvxblSq2+tFQNrZRboe3jUo24
	 tdHgz5dBCSTdtNy1yyu0EvKdZseT9AyrSNCAclvqTHp+ldIwIWky5dpT94xcobLrqY
	 6QL4syBj6BC7g2B14DS2d/QrXJTDFEza2/UhPcBEMMc6JYfPKMWBD77FEiys1t2SVr
	 7VdbqoWXp8TfYKeSpc30CiP7imQhvDl62BaH6KqSLHtKU6l+NQwrzKY6LdRDaGgJrJ
	 3RY+WAh6Tqkhw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-277dd761926so2017096fac.2;
        Wed, 04 Sep 2024 04:30:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtdJ82lYrfzPIwIX7y3W5IAMVfvrcMo64JNyxwJnJp/xX/mne4Pnqxt3E36FAYY/WoMe4zK14I8UW7z9k=@vger.kernel.org, AJvYcCXtX+/87RXuD1we2BmAVRJ+Piop/Qbrx0u7zqocdo72eoVoRYTVSlJpp3AH1Vt/I+GgKoHRPY4ZCU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKMtIfsRgh2Jx9vkhpZKBq+3GsiY1Wcz8vLm4X2zkkaJxKZbx
	rkb15IPNfYm287RYIxTK8tHoKQrGN4Ed9BLlfgPkjMwGx9SoazY1RAHP+yl4IwWNRaeuyT1HIcX
	Qt94JulGq4/h8tjZ+y2artFJc60w=
X-Google-Smtp-Source: AGHT+IFKQanbSbooGfnlwSfSEyVI63MtGmis2Mavrf/1tvOwEIAEhes8TZJBPXiaMPlbMXm8kuQCtVJueQf5xrvLm6s=
X-Received: by 2002:a05:6870:b491:b0:260:eb3a:1b2 with SMTP id
 586e51a60fabf-277d032ef4dmr14329296fac.7.1725449432782; Wed, 04 Sep 2024
 04:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3310447.aeNJFYEL58@rjwysocki.net> <20240904072521.GA3757@ranerica-svr.sc.intel.com>
In-Reply-To: <20240904072521.GA3757@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 13:30:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iX6cGhzoOUK6A0nv7z5uHWkfqtzGE6xhKtKKpZbSUk_g@mail.gmail.com>
Message-ID: <CAJZ5v0iX6cGhzoOUK6A0nv7z5uHWkfqtzGE6xhKtKKpZbSUk_g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] x86 / intel_pstate: Set asymmetric CPU capacity on
 hybrid systems
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:19=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Aug 28, 2024 at 01:45:00PM +0200, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This is an update of
> >
> > https://lore.kernel.org/linux-pm/4941491.31r3eYUQgx@rjwysocki.net/
> >
> > which was an update of
> >
> > https://lore.kernel.org/linux-pm/4908113.GXAFRqVoOG@rjwysocki.net/
> >
> > It addresses Ricardo's review comments and fixes an issue with intel_ps=
tate
> > operation mode changes that would cause it to attempt to enable hybrid =
CPU
> > capacity scaling after it has been already enabled during initializatio=
n.
> >
> > The most visible difference with respect to the previous version is tha=
t
> > patch [1/3] has been dropped because it is not needed any more after us=
ing
> > the observation that sched_clear_itmt_support() would cause sched domai=
ns
> > to be rebuilt.
> >
> > Other than this, there are cosmetic differences in patch [1/2] (previou=
sly [2/3])
> > and the new code in intel_pstate_register_driver() in patch [2/2] (prev=
iously [3/3])
> > has been squashed into hybrid_init_cpu_scaling() which now checks wheth=
er or
> > not to enable hybrid CPU capacity scaling (as it may have been enabled =
already).
> >
> > This series is available from the following git branch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dintel_pstate-testing
> >
> > (with an extra debug commit on top).
> >
> > The original cover letter quoted below still applies:
> >
> > The purpose of this series is to provide the scheduler with asymmetric =
CPU
> > capacity information on x86 hybrid systems based on Intel hardware.
> >
> > The asymmetric CPU capacity information is important on hybrid systems =
as it
> > allows utilization to be computed for tasks in a consistent way across =
all
> > CPUs in the system, regardless of their capacity.  This, in turn, allow=
s
> > the schedutil cpufreq governor to set CPU performance levels consistent=
ly
> > in the cases when tasks migrate between CPUs of different capacities.  =
It
> > should also help to improve task placement and load balancing decisions=
 on
> > hybrid systems and it is key for anything along the lines of EAS.
> >
> > The information in question comes from the MSR_HWP_CAPABILITIES registe=
r and
> > is provided to the scheduler by the intel_pstate driver, as per the cha=
ngelog
> > of patch [3/3].  Patch [2/3] introduces the arch infrastructure needed =
for
> > that (in the form of a per-CPU capacity variable) and patch [1/3] is a
> > preliminary code adjustment.
> >
> > This is based on an RFC posted previously
> >
> > https://lore.kernel.org/linux-pm/7663799.EvYhyI6sBW@kreacher/
> >
> > but differs from it quite a bit (except for the first patch).  The most
> > significant difference is based on the observation that frequency-
> > invariance needs to adjusted to the capacity scaling on hybrid systems
> > for the complete scale-invariance to work as expected.
> >
> > Thank you!
>
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> # scale i=
nvariance
>
> You can look at the scaling invariance these patches achieve here
>
> https://pasteboard.co/dhBAUjfr36Tx.png
>
> I tested these patches on an Meteor Lake system. It has CPUs with three
> levels of capacity (Pcore, Ecore, and Lcore)
>
> The "Requested work" plot shows a sawtooth pattern of the amount of work
> requested as a percentage of the maximum amount of work that can be
> obtained from the biggest CPU running at its maximum frequency. The work
> is continuously calling getcpu() in a time window of constant duration
> with varying percentages of work.
>
> The "Achieved work" plot shows that the Ecore and Lcore cannot complete
> as much work as the PCore even when fully busy (see the "Busy %" plot).
> Also, bigger CPUs have more idle time.
>
> The "Scale freq capacity" plot shows the current frequency of each CPU
> is now scaled to 1024 by their respective max frequencies. It no longer
> uses the single arch_max_freq_ratio value. Capacity now scales correctly:
> when running at its maximum frequency, the current capacity (see
> "Current capacity" plot and refer to cap_scale()) now matches the value
> from arch_scale_cpu_capacity() (see "CPU capacity" plot).
>
> The "Task utilization" plot shows that task->util_avg is now invariant
> across CPUs.

Thank you!

