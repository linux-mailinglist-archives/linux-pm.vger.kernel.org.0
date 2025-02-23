Return-Path: <linux-pm+bounces-22755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE073A41230
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 00:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A993ADA5A
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188C18952C;
	Sun, 23 Feb 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="IXW6EXud"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408D155A2F
	for <linux-pm@vger.kernel.org>; Sun, 23 Feb 2025 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740352688; cv=none; b=INViHOfZXr03QErsZj70gFV+QBav9nFNQ0DKWrdy/ZY497230GoPJm353O2APylGfds0HTg+Bjvmxuif16BaDUOv9h+nOKVFCAGA/OJMkm8KymO+2pjrUhLlyEKhUiwD736tcPzV7WZ/uI+mUXyeo8/QVJJ4VMSrUsEysi96eo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740352688; c=relaxed/simple;
	bh=cFFX7jUM8J/4t6YEHhaoM/k7+sAm18ObHvklbBEGeZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4wF7Wm5B/fOG74KkmSbZyLNERxCqzJyGE6+tve/T4eksukEWLe6XXrhmyZHMePj/NljWK4Zi6iOUYPJazBQ6hVCTxqiZexN+RQQ+R0xnRf75YoD9r6WI47kXqwATtxzgDDR/ZJq6kbMWZSuM45cZB9g4L++OIjMFooAfq+rLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=IXW6EXud; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb8d63b447so487283466b.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Feb 2025 15:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740352681; x=1740957481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSimLknfgUjKmaAI/UHJQXeFa3D9r38TQ7MMLTUXGQM=;
        b=IXW6EXudtoOfFmlfIeIWf0EreQ8BRnH3mFvICZI4/LF5zWhX4yf2xiix1clJq/cp2u
         VqUIut3Zaptpny14I6asF4GdqHjhdroL6ZQh3Mk1N/u1+DhqqenPUFRt76u9Zt8/cB/S
         /NnBd611G3CbmhkRjFQW7vzPaY3+WU05M8FGTzISfB+dW30i0WrSKRwFhO2wnqXhMldh
         K6uvXwRhq/VMcAssfAmxMElx1OQU6Krc4ZX9hVmutaoo2b3pKJFP/90NlHGW5hj2aM+8
         7NZSoQcSNbqpzb14gSETyYvAFQCtHfVvkSS2vvzWgu/0+/a24wJo+oAMhPfNhWMgwIGg
         YIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740352681; x=1740957481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSimLknfgUjKmaAI/UHJQXeFa3D9r38TQ7MMLTUXGQM=;
        b=by4z2gFo0293bFc2S6LTiVvVSAbpzEOb+a0Oc0pnEY3v5zNIXhcaBfMsM7TIRmqC6f
         /RYaBAQa6aH+sCZ35FEnA8LEdgqpfb+6TVAeBHosdylYj0QbXlvwZDdwnwm2U4gaw15U
         33+5/xXiYNAMLOPXwHViwDQv0l4ewvZ5/yFh4vo/RMC0eTxJ5Yfe9qDvU0TOd3zrDmJB
         gG2JMSGsvJGDgtnGPVeg+6MW39x0A54HjrlEK0G6nWTweQ4grSwrLEP68/6HdgkvrKRF
         2TndwDNxk9otfIGlWNC6LoSn7lhNq0s//XMMPeV51ozMeNvYehX53eXasRh3CB0lUAsd
         DAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgB0mbBCJyHYPyUfn/WshZ/eEZ26gcLEfb85XUkYNNUPGGZkQ8NDg7JjuVbKA6uQsy2pDO292oCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyborsy3AHIyf37tqBbq6dv5/iCVsLtGcv6qnRRIeZVB0qk2fs
	S5qVvC5CcjZAhZUcObAeUXL55QaId6bhDpfWlcOrN8Gy97FhkNrQO6pR5phmDDo2lCLosF3aLIq
	yLeQ=
X-Gm-Gg: ASbGnctevJ2DaPEkSMEp+EXJUQJAsA8gFIsVL4V1l3gYsr3W6lBcZsBEVvuML1nYWCZ
	vyU98FxwNox19rS/NfTg2N/JDag6e+Z5o69V4iRAZBbNfHVdi0Uev5suE6Hh9vLZmz0G8U0/jtA
	3SdSxB2Y5EhipSObGGo7IT/IiffynAgku25cKfbrHVRdZ6RdOh+aT9OWUsY9ff4/GKWeP5B0XBW
	67MNZpKvj2K8iq1wBt4V+B6ZaiJ1Mj6OqFbTRIvb21PRJFhYsqLDnyJURXSEHvKhBAsMuJBXoFQ
	+lQlpJEJieudG/zVrlvh
X-Google-Smtp-Source: AGHT+IFQbcUcUm8qND6Ggzt1mXEc20aMsEosikmGs9AgHTZiF94Y9wYEh3X6GFkaEOaNTWzptnsJXA==
X-Received: by 2002:a17:906:c243:b0:abc:269c:56d5 with SMTP id a640c23a62f3a-abc269c571emr698187166b.40.1740352681226;
        Sun, 23 Feb 2025 15:18:01 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbd5502c53sm975083966b.159.2025.02.23.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 15:18:00 -0800 (PST)
Date: Sun, 23 Feb 2025 23:17:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, Anjali K <anjalik@linux.ibm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] sched: Consolidate cpufreq updates
Message-ID: <20250223231755.cvjcsl3jedkgpohc@airbuntu>
References: <20250209235204.110989-1-qyousef@layalina.io>
 <Z7igK4w4PW1T_PCw@gmail.com>
 <20250223000351.xg53osxswsxxohye@airbuntu>
 <Z7rm2XRqhCM8m9IU@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7rm2XRqhCM8m9IU@gmail.com>

On 02/23/25 10:14, Ingo Molnar wrote:
> 
> * Qais Yousef <qyousef@layalina.io> wrote:
> 
> > On 02/21/25 16:47, Ingo Molnar wrote:
> > > 
> > > * Qais Yousef <qyousef@layalina.io> wrote:
> > > 
> > > > ---
> > > >  include/linux/sched/cpufreq.h    |   4 +-
> > > >  kernel/sched/core.c              | 116 +++++++++++++++++++++++++++--
> > > >  kernel/sched/cpufreq_schedutil.c | 122 +++++++++++++++++++------------
> > > >  kernel/sched/deadline.c          |  10 ++-
> > > >  kernel/sched/fair.c              |  84 +++++++++------------
> > > >  kernel/sched/rt.c                |   8 +-
> > > >  kernel/sched/sched.h             |   9 ++-
> > > >  kernel/sched/syscalls.c          |  30 ++++++--
> > > >  8 files changed, 266 insertions(+), 117 deletions(-)
> > > 
> > > The changelog is rather long, and the diffstat is non-trivial.
> > > 
> > > Could you please split this up into multiple patches?
> > 
> > Sure. I did consider that but what stopped me is that I couldn't see 
> > how I could break them into independent patches. A lot of corner 
> > cases needed to be addressed and if I moved them to their own patches 
> > I'd potentially break bisectability of this code. If this is not a 
> > problem then I can see how I can do a better split. If it is a 
> > problem, I'll still try to think it over but it might require a bit 
> > of stretching. But I admit I didn't try to think it over that hard.
> 
> Yeah, so bisectability should definitely be preserved.
> 
> I had a quick look, and these changes look fairly easy to split up to 
> reduce size/complexity of individual patches. The following split looks 
> pretty natural:
> 
>  # ============{ Preparatory changes with no change in functionality: }=========>
> 
>  [PATCH 1/9] Extend check_class_changed() with the 'class_changed' return bool
>              # But don't use it at call sites yet
> 
>  [PATCH 2/9] Introduce and maintain the sugov_cpu::last_iowait_update metric
>              # But don't use it yet
> 
>  [PATCH 3/9] Extend sugov_iowait_apply() with a 'flags' parameter
>              # But don't use it yet internally
> 
>  [PATCH 4/9] Extend sugov_next_freq_shared() with the 'flags' parameter
>              # But don't use it yet internally
> 
>  [PATCH 5/9] Clean up the enqueue_task_fair() control flow to make it easier to extend
>              # This adds the goto restructuring but doesn't change functionality
> 
>  [PATCH 6/9] Introduce and maintain the cfs_rq::decayed flag
>              # But don't use it yet
> 
>  [PATCH 7/8] Extend __setscheduler_uclamp() with the 'update_cpufreq' return bool
>              # But don't use it yet
> 
>  # ============{ Behavioral changes: }==========>
> 
>  [PATCH 8/9] Change sugov_iowait_apply() behavior
>  [PATCH 9/9] Change sugov_next_freq_shared() bahavior
> 
>  ... etc.
> 
> This is only a quick stab at the most trivial split-ups, it's not a 
> complete list, and I saw other opportunities for split-up too. Please 
> make these changes as finegrained as possible, as it changes behavior 
> and there is a fair chance of behavioral regressions down the road - 
> especially as the patch itself notes that even the new logic isn't 
> perfect yet.
> 
> If the behavioral changes can be split into further steps, that would 
> be preferable too.

Okay. I was focused on the functionality changes. Let me re-order and do more
preparatory work without introducing problems that I know will affect
performance bisectability. Thanks for helping to shift focus, I admit I had
a mental block on breaking this down to smaller pieces.

> 
> Also:
> 
>  - Please make the rq->cfs.decayed logic unconditional on UP too, even 
>    if it's not used. This reduces some of the ugly #ifdeffery AFAICS.
> 
>  - Please don't add prototypes for internal static functions like 
>    __update_cpufreq_ctx_switch(), define the functions in the right 
>    order instead.
> 
>  - Also, please read your comments and fix typos:
> 
> +                * This logic relied on PELT signal decays happening once every
> +                * 1ms. But due to changes to how updates are done now, we can
> +                * end up with more request coming up leading to iowait boost
> +                * to be prematurely reduced. Make the assumption explicit
> +                * until we improve the iowait boost logic to be better in
> +                * general as it is due for an overhaul.
> 
>   s/request
>    /requests
> 
> +        * We want to update cpufreq at context switch, but on systems with
> +        * long TICK values, this can happen after a long time while more tasks
> +        * would have been added meanwhile leaving us potentially running at
> +        * inadequate frequency for extended period of time.
> 
>   Either 'an inadequate frequency' or 'inadequate frequencies'.
> 
> +        * This logic should only apply when new fair task was added to the
> +        * CPU, we'd want to defer to context switch as much as possible, but
> +        * to avoid the potential delays mentioned above, let's check if this
> +        * additional tasks warrants sending an update sooner.
> 
>   s/when new fair task
>    /when a new fair task
> 
>   s/this additional tasks
>    /this additional task
> 
> (I haven't checked the spelling exhaustively, there might be more.)

Will do.

Thanks!

--
Qais Yousef

