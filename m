Return-Path: <linux-pm+bounces-15430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323AF997C99
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 07:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0BB1F22A4E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 05:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DDC192D8C;
	Thu, 10 Oct 2024 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2iOjqN/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292B178372
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539122; cv=none; b=tgPkgTuu2YrI2NGsagL6NEqprAepOWgc8YsSdhp0j/5z9BIiskm0D5UenbybmkDjMUk+JcS7HMWryPQOAdPNVmyhKYq23+7I5FJGzPAsa3ICBDtk5W8gWvMqOwZF8XzVbWc9FnnT5bAMMaRAUpf5k/aiT+AjqWDyTiXd3Qljod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539122; c=relaxed/simple;
	bh=LgSiGL5ON5hpc3TnMQRlN3g1FiAcdrazdqntMBAuWoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/A4YOm95eJGPMORSmyg4CreZCnRiIwGfAs4r1McWjaXhXpyLGBgk3j2h/4uGefgM3lccWD/rXOuhvHcxB8FSsLP/z41g4FaYxtyxJoYQYHAg42ob762Y7+OIyhVKrY9al4KJ8yTAY/SSnPWgrGDcLjcygBG814chq5ScQMopyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2iOjqN/b; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so479592a91.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 22:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728539120; x=1729143920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUV1YOwrxrqqRTKPqW+ANuVKRyCIqoxVlXMvdvI+O6o=;
        b=2iOjqN/bVFL+cgHmsXsK4AhINhr8QxARoKzQC8w53MKq5SD37IJeaC6coJTvlS90xr
         Yuxe1CQXJVAH0dm2R4A8MB2r4I85Aq42uxLWDY60ixkb+VOtzf34J/FfD1F0E51aYa7s
         aCwd29MqCebsx7RBVBRPw61Z8v+zo28j5SgPfXxKQAzzrOyvhUu2lESAuV+mHUEwRFNS
         cBa81PvrGreM4+HsyD3IjP71JU+X3z2DKjErT4jXcpxnFcv5p5eTcPof9fG0mouTC9Vx
         lN/9TjGzjTmOLh0toVzJXZgKrs2VpE4NM0K/kxYqpSN8ToHWU4Mfy/boBK9RhATeqD+C
         YCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728539120; x=1729143920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUV1YOwrxrqqRTKPqW+ANuVKRyCIqoxVlXMvdvI+O6o=;
        b=b/SROORwK4DmKVhxFxCq+y2iB7IvrfLZDzkquFPHaJRlb1K5BgeMKh9XQfu57hk0p2
         p+/RmRNWkD+z/Jl3VcMUh8oi9X6ZrHgL25hbkORG1l5L0S13bPgV9AUNYDZIozfTS2rP
         4uuwnDB6fHUUXS06/cQupgK7lmKng6PlgqYw+MJCggIYmDuBZbW4HPMAxkJ1MS8SbVkI
         ceXnFQwmjQh6y+Xqu0raPriAMa1hedXPGH35tYHPgUp3yRjFPOxFuAuJhHWG4ZOjWWce
         1awbsEqmbyW0JxohOy42e+TBoTLtZ+une3D4lSy6YnV5sLhkALX24xPoJoD/Ps2gE85c
         q5NA==
X-Forwarded-Encrypted: i=1; AJvYcCX/EOSDtDNPNqDbgeLEVqyoGxMrUsfPT0+QtDvcQxu28S7xbi0gmM6h+QuVz8HAYU+LjAhgIJOufw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLp+hx2SkM8YxYeUzd5blFde+m5A41PhZ/JSsJBpLxmiWisL1Q
	iDt1oMq0ownfzgYRUey6iV6uqR3zZVa/N87gVD/UMAX5B/M/u91m1P2QAl30pU1CDluB0qORH6I
	JCrNq4wi53EktWaSXOVOI95mLRg+2x4LTd5x6
X-Google-Smtp-Source: AGHT+IGQkN0MJOiozBIUIBK3Vn9SUJhpVL1t27GV3E3Z5FyTYuXiLrI0w8pgx5kFGpujAlYsA8muIqbrXclFRjZxdCc=
X-Received: by 2002:a17:90a:bb94:b0:2e2:b6ef:1611 with SMTP id
 98e67ed59e1d1-2e2b6ef16cemr3703604a91.18.1728539119717; Wed, 09 Oct 2024
 22:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ho73shkrw.fsf@baylibre.com>
In-Reply-To: <7ho73shkrw.fsf@baylibre.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 9 Oct 2024 22:44:40 -0700
Message-ID: <CAGETcx8NzEF5UQMRLvdFY41OROxR3zaM1i_fHDA1DjkyogKbmg@mail.gmail.com>
Subject: Re: arm64 s2idle vs. workqueues
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All I know is that shouldn't be happening. Not because I know the
code, but the Pixel Watch 2 uses s2idle and it stays fully suspended
perfectly well.

-Saravana

On Wed, Oct 9, 2024 at 5:19=E2=80=AFPM Kevin Hilman <khilman@baylibre.com> =
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
>
> Thanks,
>
> Kevin
>
>
> [1]
> function, workqueue name
> ------------------------
> - page_pool_release_retry(), "events"
> - vmstat_shepherd(), "events"
> - vmstat_update(), "mm_percpu_wq"
> - crng_reseed(), "events_unbound"
> - kfree_rcu_monitor(), "events"
> - flush_memcg_stats_dwork(), "events_unbound"
> - neigh_managed_work(), "events_power_efficient"
> - async_run_entry_fn(), "async"
> - deferred_probe_work_func(), "events"
> - tcp_orphan_update(), timer expiry
>
> [2] https://drive.google.com/file/d/1U51eTTeb4_13-CZWa2llHXTh9DfZ_4sF/vie=
w?usp=3Dsharing

