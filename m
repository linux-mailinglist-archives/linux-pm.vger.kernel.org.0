Return-Path: <linux-pm+bounces-37362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A88EEC3148D
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 14:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A94EACDA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420CC328B58;
	Tue,  4 Nov 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9hwvzaw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FA2E9721
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263839; cv=none; b=AhNXBXvZImULIKiLosKs7sevngN8pNmL/GhvHKxbOXIxoCAe6ujTmpTCw2eBD6djev8QGNc6eOK64L109MUyzTRsOSKSq3FIYLTJu8UO4S9I4guWFU/zKjGFnNYppxBgI1svJvMvv9oddVVDPsKYwXcAUEAZhXxLhHQ0B/YDJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263839; c=relaxed/simple;
	bh=lFb4yPpZtK3Bwon0C6HzQEwc8sB9kXocdlaLUdamsf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTzn+TZ2pGZcRxXGNDLOBps6xv0LlTQjYcOlLgu9sNrTrbG8PRBR7kR6eUPL+rNv6njM2tilHL638/W9QS61a9MPRFvZroyL2VGk8x7umkUOBeDF5qVMk/zeKHAZp3vEsuEPXItpIZPRPUatkeLVD3Si1di0r1694sxFmcU1NGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9hwvzaw; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-786943affbaso10577437b3.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762263835; x=1762868635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjiVDEb6cm0IQNwx2lZ93BPJc14dj5R/bK/BpZzo6VU=;
        b=I9hwvzawBO4KDl6ZO6louKM+uvS6N6d4rzjhWMmpIhuMK2ZDivLApkeJnEO0fbpFnf
         B40OIoh//ioyAtiLwpv78oEn0oR1LQNdPY44fn1LBwyKVijDAyuLK0ERe87143zx9ybH
         /l5oxsXUA3lib1ijp43oXr4sc5yHStcZjWmMwqXYtrhzLd3KfjZ01j4s9Hd/vE7dfqF/
         +Vn9wL/EoD2qybmetygq1gIAHhLehjMXh5+mzgpiBMSoozrByM+7kxC7a4JLFZ8lEE4S
         UDmXngdwOCALajwBdmid0wQnmdNBEkqaT1YdzX72eX4wpFOxTK6NHfSRw0dB0owxEEfk
         58Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263835; x=1762868635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjiVDEb6cm0IQNwx2lZ93BPJc14dj5R/bK/BpZzo6VU=;
        b=WzHE39agKTYoKki+rwpbwGfLSzZJw9WMabPrOyS9sdvhydRyjeUGTW/DOVRvQ3cjuj
         IeWepBytuRhfw57FUXKXnLxMyxOy9um9eIys4npL1yGW/5SIDoALiOUJSq9vVFhNBrkS
         W0Ah+kbbNNKF8+w40o2VbT5klfxoU1XnmMB3kuZE2LoPiXFK2tEgC9OE9o5VfwuhL3++
         WrFQWQ93rTW/cqNU5jpXoMj5PMTHgg0t+KxnUoFwlRDuUWdNkBXGjawFD4ldP8BBFU5h
         tsq7gOvReaClr4bFZrAIR4LkflT4M2HkamNdPgQi8QuvZGi0Au+yfF/MK0sQB/JAvt24
         9n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKHWJ2oLlLcmjfzuqDpsCCyx2fMPvG7uR+RA1Wm/Lru6XGOgqnINIS5ozr3DG9f5diHm7HkaMQ0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xE6UeE1RFjrp/UgV7izcVbwL5LLnktZCmXT0kVzkIc5HKTqT
	8FgXTPEGiJizRdunY0NTpFyODE8/l7LKUH4Zg3bNVpSBxra09uzbjB/HhAG0924z+ljz2cdkSC8
	LmP5JESnxESoQyfOHHVM3mK8xHAkHIy8Ges8r/KSTbQ==
X-Gm-Gg: ASbGncuqHCRCbtNs/qwwpl05T5rj/MTtD7EH7PbuZ3rCt+XmHNGjySsXpdrQBfH7kyV
	65djYilDxNKGQvFi+qDCdV+FOohWcOnuQkwBdibwv9NNvPedDJq2rJVg6W6FVFhxbPmtHvXPg3r
	LUjHKzuZIfsncTlphyHshmP5K2hnydBrySL+QNjWXXN6J6VwmQarOvCFE7fJ2WoS9rXu4RZFC5t
	LL0/uFNwB2UlmdJBIeoI1F7oh5CPSdFto6yCRHXgk7KaVHnsBxLCQYYnfFcWA==
X-Google-Smtp-Source: AGHT+IH+xJM5OuT+ynGz/BcB2JMNDwt+HfQJxGitdqIPsmVDhekVmNUAamUG4n8DzrZpGoHggRFap3lMfbO2RdQhyHw=
X-Received: by 2002:a05:690c:708f:b0:781:212f:b508 with SMTP id
 00721157ae682-786485533d5mr151925497b3.63.1762263834960; Tue, 04 Nov 2025
 05:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-4-ulf.hansson@linaro.org> <20251031192322.kpsy5biokvuywzdj@lcpd911>
In-Reply-To: <20251031192322.kpsy5biokvuywzdj@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 14:43:19 +0100
X-Gm-Features: AWmQ_bn-zdaH9ELfagCV1hR3Eqqv5E86xcqWdZ7QiiQHIMqA2xOLmg6yZU16JBQ
Message-ID: <CAPDyKFp8DuNE-j6Fpejgbg3+HK00RiuvbtG+Ypud4uzFBRO99g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sched: idle: Respect the CPU system-wakeup QoS
 limit for s2idle
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 20:23, Dhruva Gole <d-gole@ti.com> wrote:
>
> On Oct 16, 2025 at 17:19:23 +0200, Ulf Hansson wrote:
> > A CPU system-wakeup QoS limit may have been requested by user-space. To
> > avoid breaking this constraint when entering a low-power state during
> > s2idle, let's start to take into account the QoS limit.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Rework the code to take into account the failure/error path, when we
> >       don't find a s2idle specific state.
> >
> > ---
> >  drivers/cpuidle/cpuidle.c | 12 +++++++-----
> >  include/linux/cpuidle.h   |  6 ++++--
> >  kernel/sched/idle.c       | 12 +++++++-----
> >  3 files changed, 18 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 56132e843c99..c7876e9e024f 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -184,20 +184,22 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
> >   * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
> >   * @drv: cpuidle driver for the given CPU.
> >   * @dev: cpuidle device for the given CPU.
> > + * @latency_limit_ns: Idle state exit latency limit
> >   *
> >   * If there are states with the ->enter_s2idle callback, find the deepest of
> >   * them and enter it with frozen tick.
> >   */
> > -int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> > +int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > +                      u64 latency_limit_ns)
> >  {
> >       int index;
> >
> >       /*
> > -      * Find the deepest state with ->enter_s2idle present, which guarantees
> > -      * that interrupts won't be enabled when it exits and allows the tick to
> > -      * be frozen safely.
> > +      * Find the deepest state with ->enter_s2idle present that meets the
> > +      * specified latency limit, which guarantees that interrupts won't be
> > +      * enabled when it exits and allows the tick to be frozen safely.
> >        */
> > -     index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> > +     index = find_deepest_state(drv, dev, latency_limit_ns, 0, true);
> >       if (index > 0) {
> >               enter_s2idle_proper(drv, dev, index);
> >               local_irq_enable();
> > diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> > index a9ee4fe55dcf..4073690504a7 100644
> > --- a/include/linux/cpuidle.h
> > +++ b/include/linux/cpuidle.h
> > @@ -248,7 +248,8 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> >                                     struct cpuidle_device *dev,
> >                                     u64 latency_limit_ns);
> >  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > -                             struct cpuidle_device *dev);
> > +                             struct cpuidle_device *dev,
> > +                             u64 latency_limit_ns);
> >  extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
> >  #else
> >  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> > @@ -256,7 +257,8 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> >                                            u64 latency_limit_ns)
> >  {return -ENODEV; }
> >  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
> > -                                    struct cpuidle_device *dev)
> > +                                    struct cpuidle_device *dev,
> > +                                    u64 latency_limit_ns)
> >  {return -ENODEV; }
> >  static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
> >  {
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index c39b089d4f09..c1c3d0166610 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -131,12 +131,13 @@ void __cpuidle default_idle_call(void)
> >  }
> >
> >  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> > -                            struct cpuidle_device *dev)
> > +                            struct cpuidle_device *dev,
> > +                            u64 max_latency_ns)
> >  {
> >       if (current_clr_polling_and_test())
> >               return -EBUSY;
> >
> > -     return cpuidle_enter_s2idle(drv, dev);
> > +     return cpuidle_enter_s2idle(drv, dev, max_latency_ns);
> >  }
> >
> >  static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > @@ -205,12 +206,13 @@ static void cpuidle_idle_call(void)
> >               u64 max_latency_ns;
> >
> >               if (idle_should_enter_s2idle()) {
> > +                     max_latency_ns = cpu_wakeup_latency_qos_limit() *
> > +                                      NSEC_PER_USEC;
>
> This is only taking into account the new API for the
> cpu_wakeup_latency_qos_limit, however what if someone has set
> cpu_latency_qos_limit, doesn't that need to be honoured?
> Just trying to understand the differences in both qos here and why one
> is chosen over the other.

cpu_latency_qos_limit is for runtime only, during regular cpuidle idle
state selection.

The new cpu_wakeup_latency_qos_limit is taken into account above for
s2idle, specifically.

That said, Rafael suggests that the new cpu_wakeup_latency_qos_limit
should be respected for runtime cpuidle state selection too, so I am
working on updating the series to take that into account.

>
> >
> > -                     entered_state = call_cpuidle_s2idle(drv, dev);
> > +                     entered_state = call_cpuidle_s2idle(drv, dev,
> > +                                                         max_latency_ns);
> >                       if (entered_state > 0)
> >                               goto exit_idle;
> > -
> > -                     max_latency_ns = U64_MAX;
> >               } else {
> >                       max_latency_ns = dev->forced_idle_latency_limit_ns;
> >               }
> > --
> > 2.43.0
> >
>

Kind regards
Uffe

