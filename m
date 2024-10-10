Return-Path: <linux-pm+bounces-15494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10742999371
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DD31F24DE4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E41D31BB;
	Thu, 10 Oct 2024 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sX41yqi7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF91D04B9
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591088; cv=none; b=LtnOuZeGrxYTmHloZf9f5/q40Ms1baDW5FyWUt24V0PkFjk58niQq3zd/VIE8O4HkLxi/7OfaD8q6oJEWjqZi3HEDKaU09A90p/wyVHSeRblWNGvynXgVVHHXATEhhxzmOjFXthQQW11pBpg7TbmKpGL/a32QM8rsqn3+JgdKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591088; c=relaxed/simple;
	bh=Idjf9j2GpfBNRTdrVsLP07ri3rOscqHpjdrY4UFQ6ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id5nztTkeyksVWb5x6BUyRmB/ooAEZ6/3Lj7Yd4OXOvPn7Trfrhfm4Fbd1Jy7T4ae3tELYz1IOg4QiE1BYFu+jSmUCK35cmifHnHjYmCysm064yJXkNweJJVJ7No3wuabPewyNEKRnNN0m9WLjaVlZN0o7YNMHfnNpODyOc0k14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sX41yqi7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso1156616a91.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728591086; x=1729195886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isbhnlnYjDbxJL0QtsFO8LYkHr6huIwURaxSzZxcRWY=;
        b=sX41yqi77/mt2mOpe4F1Ax3w+G3KtN50396qM9zZWg74j5ZQzoE3mKvxyUgg8huSiC
         gOCpkw6NgbUPW+LXCjyhr37/ckbm3aEHAgxTnzrmcrjQdA9nAbec8kxu3Ww8JKhAgIjv
         s4m/FvCA5uDBjhHPjHkVQNkimQs/TfJ4dNZlyy8+lHwm4/atIFnnnzV7Fa+22q8K0P6e
         WfcX1h9XHVi/0HhMg07chWbDpUKIOL6VzZVQghXl+h1OPQ1xSkP3wF2Ioh+atGz8KQdI
         0Q745ow+vVuR0t1wwj+8Uw/YmJMPtCvbnBiFGOkjlYf698pp9q8p0dXtZs/cxkKA0UcS
         3NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728591086; x=1729195886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isbhnlnYjDbxJL0QtsFO8LYkHr6huIwURaxSzZxcRWY=;
        b=a+hXTCugbByGusiwUDYQnCX18Jq++OeTWexRf5UCRO/YnS5IwXNbaI8LvrAPqZHlh+
         U8JVQIOJeCez1yh4iYjrStzeh3JinJQbN2+1g9KUM4RJs/dbPnVUWHAssNBOcPBLV53n
         4qEtO4dgxhlfU7X7RehpARZZ7y37msMqJbbAm4nhlR1YCLZw0QZdapCmjoyGxEEGlOEZ
         7eQPBNjoxc+vk39ULB5+ZjmWEBDz1RpcY6AGBZyb9Zt1US2YfFUJI6NWVYeMcPf1AVlM
         64lwvPZNU2egLaQWwB+oqqeD6surZ/nVggTHXCVy64QUGUeOsXESBSyd+KMmAIUrj5DA
         E9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdehqZ5HSdLp01IuSsJbH6OVQr7KLB8bgTbOShEYypk9rkv+qompAphNS5w9v8CXIP52zlcA1/Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3feQv/p4uBcr4qzI/frjfVA1U8jnroXQGUpTUuUSF/bolFU1+
	BRDL7OxWRt2sqYGmZPMGCvVs6oxvUhUNdS/SE4tAjmoY/MGmDyN8wfFisTeMp8XwAr7J5M1IfbR
	4sIoqQsjT+61low0zZcsKP5CV1zfSO+r3LHcP
X-Google-Smtp-Source: AGHT+IEJn6j/SNCjwA03MHmP2UIfCIQUKdMslhxdgxi/rC7ZgmclKOvxmm80gMLMZu6xO/lwjT1+HEPZp+d9lyxjCj4=
X-Received: by 2002:a17:90a:1f4f:b0:2d3:c638:ec67 with SMTP id
 98e67ed59e1d1-2e2f0825fc1mr467917a91.0.1728591085234; Thu, 10 Oct 2024
 13:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ho73shkrw.fsf@baylibre.com> <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
 <7e22ed71-4e61-4250-a81d-eda4f4647b8b@arm.com> <7hjzefydcc.fsf@baylibre.com>
In-Reply-To: <7hjzefydcc.fsf@baylibre.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 10 Oct 2024 13:10:46 -0700
Message-ID: <CAGETcx9xFtxj2XZSvUg1_6-RaeHPyc3gedxfb77QK3OAnFkXqw@mail.gmail.com>
Subject: Re: arm64 s2idle vs. workqueues
To: Kevin Hilman <khilman@baylibre.com>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If you have some lessons learned from this and present at the next
LPC, that'd be awesome! Or some LWN writeup, etc.

One of the issues you might hit... drivers doing stuff in hotplug
notifiers that are per CPU. We need a better solution for that.

-Saravana

On Thu, Oct 10, 2024 at 12:20=E2=80=AFPM Kevin Hilman <khilman@baylibre.com=
> wrote:
>
> Christian Loehle <christian.loehle@arm.com> writes:
>
> > On 10/10/24 11:23, Rafael J. Wysocki wrote:
> >> Hi Kevin,
> >>
> >> On Thu, Oct 10, 2024 at 2:19=E2=80=AFAM Kevin Hilman <khilman@baylibre=
.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> Looking for some pointers/tips on debugging s2idle, and in particular
> >>> why it is not staying in an idle state as long as expected.
> >>>
> >>> I'm attempting to use s2idle on a 4-core, single cluster ARM64 SoC (T=
I
> >>> AM62x), which doesn't (yet) have any DT defined idle-states, so is ju=
st
> >>> doing a WFI when idle.
> >>>
> >>> I'm doing an 8-second s2idle with RTC wakeup by using:
> >>>
> >>>   rtcwake -m freeze -s8
> >>>
> >>> and what I see is that 3 of the CPUs stay in their idle state for the
> >>> full 8 seconds, but one of them keeps waking due to the A53
> >>> arm_arch_timer firing, and processing misc. workqueue related activit=
y
> >>> (example work listed below[1].)
> >>>
> >>> I realize that these workqueues are not WQ_FREEZABLE, so I don't expe=
ct
> >>> the freezer part of suspend to stop/freeze them.  However, I am a bit
> >>> surprised to see this non-frozen workqueue activity happening often
> >>> enough (few times per second) to prevent all 4 CPUs from being idle f=
or
> >>> long periods at the same time, thus preventing a deeper cluster-idle
> >>> state.
> >>>
> >>> Is there something else I'm missing that is needed to keep these
> >>> workqueues quiet for longer?  I had assumed that most of this workque=
ue
> >>> work would be deferred, and shouldn't need to wakeup a CPU just to ru=
n.
> >>>
> >>> In case it's helpful I have published a trace.dat from trace-cmd whic=
h
> >>> captures power, sched, irq, timer and workqueue events.  With
> >>> kernelshark, it's pretty obvious to visualize what's happening: CPU0,=
1,3
> >>> are all nicely idle for 8 sec while CPU2 is waking due to the timer a=
nd
> >>> workqueue activity.
> >>>
> >>> Any pointers to how to improve this situation, or what else needs to =
be
> >>> tweaked here would be greatly appreciated,
> >>
> >> It looks like tick_freeze() is not called, which only happens in
> >> enter_s2idle_proper() that is called from cpuidle_enter_s2idle() if
> >> there are any idle states with an .enter_s2idle() callback.
> >>
> >> So does the cpuidle driver for this platform provide .enter_s2idle()
> >> callbacks for any of its idle states?
> >
> > AFAICT there shouldn't be a cpuidle driver that initialized and WFI is
> > entered through arch code. The trace.dat indicates that, too.
>
> That's correct.
>
> > @Kevin
> > I assume you can add a state in the DT, disable it and everything works
> > as expected?
>
> Thanks for the suggestion.  I tried that quickly, but ran into a couple
> problems:
>
> 1) If the state is added, but disabled, that leaves only a WFI state,
>    and the current PSCI CPUidle driver fails out and defers to arch idle
>    if there's only the 1 WFI state[1]
>
> 2) The PSCI implementation on this SoC does not implement OSI mode, and
>    the PSCI CPUidle driver also doesn't setup the s2idle callbacks
>    unless OSI is supported[2]
>
> I'm going to hack a bit around these limitations just to see if I can
> get fully idle, but long term, it looks like I have some TF-A work to do
> for the PSCI implementation on this SoC.  But at least now I understand
> the s2idle callbacks and the missing tick_freeze() path, so it makes
> sense why my platform is not fully idle/suspended.  And the good news is
> that the TF-A implementation for these TI SoCs is fully upstream, and I
> can build & use my own version, so that will be the next step.
>
> Thanks for the pointers!
>
> Kevin
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/cpuidle/cpuidle-psci.c?h=3Dv6.11#n361
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/cpuidle/cpuidle-psci.c?h=3Dv6.11#n221

