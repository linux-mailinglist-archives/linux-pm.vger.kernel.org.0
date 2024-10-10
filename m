Return-Path: <linux-pm+bounces-15443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 155A699837B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDED1F21EEE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D9D1C3310;
	Thu, 10 Oct 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfJyOzjM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFFF1C330D
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555818; cv=none; b=ByQLC97rAIYC9+cxMilY/2bZX97hzdRFaGnKFQCT46jZF339YCrtv2uS6wpfHdUK+jJXMS4lEj8pZKmXwaQHtIGPU0JJN7ZzGGytpYuuJFx8AIRIYYkE7nqPRUQgryQa5oI/rPKwW7I01M54qRvyMekVXOIYAx9D/09Eg7J7LPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555818; c=relaxed/simple;
	bh=0hrVofwW7gTKsJRwBGZiOKmPkZ0PTwkXfHn2RNLHsk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JO8GbYcDv7b4hUdas+W6loBTYi9pHUf7B/fk+p0/URTtFf1JTSVqraFThA350qHY+QcdvUW3QQ+3sXU1Bxp7Pzx6IHD4XYzRfWmj6PbQxiyZjsecjNB9CfKFA0Qw4ovx8jPh2m6vYZuhpip14dicnRqDczLuYbybtUlqNuVVuUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfJyOzjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BA2C4CEC6
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728555817;
	bh=0hrVofwW7gTKsJRwBGZiOKmPkZ0PTwkXfHn2RNLHsk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RfJyOzjMxjoPbHEBLhpt6gENfX/jkF+nU1ZULxIRv8Jj+gKTEZ67fxfI80uNjTdK9
	 6Vmya+FzyVK8EoBTG9PMyYz3i0mQDozlpYLURVwOcusWH5DkDnP+GZxNGNqgO4jke2
	 /Vi+7FPoKYecCYNOXr7lj8aP9UlmiAWROYdiGlKsJnFlT6qDz+xsyYUI89XRx7bO0Y
	 3V4Q9eqANG8h8/GGGy7AkvMsDyRL+bwS1yvxEpPoiZQB3O+07fThFiRiPGKaq+RMN0
	 IKHKYBWtIa80xnzLsMG7lSCifAabKql2exwPBgtn30ecqSOVoPtmnZGzkt+Lqn1dDT
	 Lba8bZOfch16Q==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e4d53fbe0dso495159b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 03:23:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVi/g5VNf27MMKasopIgEGiwta+31j8CuKj65gBAJxeUQP71XrLc0dRVVksl5f9/I5ZSXGlJpi2Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLHY9hig0236V3tIsvIciPDExKoolZ2pio7ocaym2Q/aZd3FJ
	xOcnzu19azz0taYZb6gg3Zk8+Y5tSdVUqdYmXZtIGXBhWC5W9+aEQ0FmuH8Xu1OBBwOcRHKQ1RY
	MzBC5AYD3BJynwRNiO2jnQ7cFrKg=
X-Google-Smtp-Source: AGHT+IE8NPBlmbjbsFtiowaqyENSFSW95b2GD5dfFgIfci4dTYGEmafc9WwK1kZS4F5TqyvkOPii/ZgXZvciHBQ6ZZk=
X-Received: by 2002:a05:6808:238e:b0:3e3:a90b:2340 with SMTP id
 5614622812f47-3e3e66aaf5fmr3877265b6e.0.1728555816891; Thu, 10 Oct 2024
 03:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ho73shkrw.fsf@baylibre.com>
In-Reply-To: <7ho73shkrw.fsf@baylibre.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Oct 2024 12:23:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
Message-ID: <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
Subject: Re: arm64 s2idle vs. workqueues
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Thu, Oct 10, 2024 at 2:19=E2=80=AFAM Kevin Hilman <khilman@baylibre.com>=
 wrote:
>
> Hello,
>
> Looking for some pointers/tips on debugging s2idle, and in particular
> why it is not staying in an idle state as long as expected.
>
> I'm attempting to use s2idle on a 4-core, single cluster ARM64 SoC (TI
> AM62x), which doesn't (yet) have any DT defined idle-states, so is just
> doing a WFI when idle.
>
> I'm doing an 8-second s2idle with RTC wakeup by using:
>
>   rtcwake -m freeze -s8
>
> and what I see is that 3 of the CPUs stay in their idle state for the
> full 8 seconds, but one of them keeps waking due to the A53
> arm_arch_timer firing, and processing misc. workqueue related activity
> (example work listed below[1].)
>
> I realize that these workqueues are not WQ_FREEZABLE, so I don't expect
> the freezer part of suspend to stop/freeze them.  However, I am a bit
> surprised to see this non-frozen workqueue activity happening often
> enough (few times per second) to prevent all 4 CPUs from being idle for
> long periods at the same time, thus preventing a deeper cluster-idle
> state.
>
> Is there something else I'm missing that is needed to keep these
> workqueues quiet for longer?  I had assumed that most of this workqueue
> work would be deferred, and shouldn't need to wakeup a CPU just to run.
>
> In case it's helpful I have published a trace.dat from trace-cmd which
> captures power, sched, irq, timer and workqueue events.  With
> kernelshark, it's pretty obvious to visualize what's happening: CPU0,1,3
> are all nicely idle for 8 sec while CPU2 is waking due to the timer and
> workqueue activity.
>
> Any pointers to how to improve this situation, or what else needs to be
> tweaked here would be greatly appreciated,

It looks like tick_freeze() is not called, which only happens in
enter_s2idle_proper() that is called from cpuidle_enter_s2idle() if
there are any idle states with an .enter_s2idle() callback.

So does the cpuidle driver for this platform provide .enter_s2idle()
callbacks for any of its idle states?

Cheers, Rafael

