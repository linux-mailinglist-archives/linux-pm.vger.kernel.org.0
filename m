Return-Path: <linux-pm+bounces-37360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F309BC313A7
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 14:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857463B84AD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8A320CD9;
	Tue,  4 Nov 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C76AKnm9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561E2D9EC4
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262872; cv=none; b=uE5f6IeBPX6vPriGbix+rXcf9MN2e5ujschTU2QeIBfCeL4hj/XV+w7oFwnws5LGdsUziVaKBjB/AP9VZ0l38cYl9/0ltVdaT4knUyIDTPgKPZusQmM8ZFyg3a3CbpygWDEQbPPT2rwK8azaJRYEV0JWrORfDXXWUyU3m47ehoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262872; c=relaxed/simple;
	bh=xYFy9FvuPfNQPztS84ipLwgad6MW8ZjCqUyalulzpdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWoe2yhVz2DHLOLmoRjKNgN0JFxHnHoQ4f4WBPHxOgu3+UQC9C68oEOrtmnEEOK4mk8jZ81HyB1sDZmJkyq8So1ZEfVhnooyWm4drbv08S227bDYu6+qnBZnVQYAi+1/j7qxNL4+2oLDPGbQ1bk4hfsqPlYtKxupc7MM2Wsbr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C76AKnm9; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78682bab930so26379157b3.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 05:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762262869; x=1762867669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s9K6kgfVqBppsAmCOCyx1kErguRE3B1GwWQGCap1HUE=;
        b=C76AKnm9F392/QLM1fOKtR7YaKjA8bDZ282OXtGHFtA8wmg7XsZE5OMn+f0CR+bjTE
         y1JuivN3L3d7lAFpjlsHcHyRtSmTKeU8Gt3pYgfNaK8+GufUtAX9XUk5Q8Ad7m4S4hQ1
         DNMXOZuHnktKvqRZhd0/GtNzNbqNB0fOHAOcDARQaftYgoqQvQRLJ9Q4xMz9Qsf9bP+4
         NDhVAcYSxzaWskpVcynVxMNW8ECkVG0wepYhULK1z9MSZZYA4sJGysX2L3cR+EaKr/sy
         3wzYPcoM26puimX8oGAznyEnYLKlQJxMk2OZaMhbe3aw/2ld0o6MZ1c89J7VAcKvWOwW
         D1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262869; x=1762867669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9K6kgfVqBppsAmCOCyx1kErguRE3B1GwWQGCap1HUE=;
        b=TNE4FSF4eJF6wnxtd0va85zUL/jaN8u34OKlOQpPo6YUv0+Gj8zz7LqXYB9eMu1Vwy
         /Vtvm/1xj930ms9sTAgyl9+THXSKdSiAIg3dgHmobpJzLSiMKtARRPPTYr34uqIc2qol
         /hiqaYskvxPnmG+iHEtNfwmqiH1mRBhlA1GPOSrqqjdeOvdMYA6cWREhwGmh1TujGn0x
         w+hCyjCElxwHFpW2k9fvo4P+UQ6MfmRDgOAkXmTmvKzocw3Pav+AE/s44TbRuqzQt9tU
         102gEd3GV8uzqwgsC4sBoGtkoTq+zXsfWeJYcfIhHr9IJev6OkH2yauV6zT/4kMhVRlQ
         g3eg==
X-Forwarded-Encrypted: i=1; AJvYcCX85QNXLr9MJyn7/Y7vWaGao25a5FhWiIQWkBzlMfWL9Ejqzdfy5rPiSn3JCiXTt8fRxSBlwhaxpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgOdLbBFTwtC4PQiOUT8tCzMcBcWFz3R/stO1y53WMUell5RCR
	EmJczBhGArODJQfkjxSPWCXjd6G+Xo8w+2JO0pEVoCp1U874EYP3zfGlnS/K5hRQ3Q6c0lDUrWH
	xc87sRlabyw41nrTVEgZOhzo8lxJLhXsqhobErV/FwQ==
X-Gm-Gg: ASbGncsaaFtSwRNJNGcfXEvjmx37c7FFmMM1SdUFgiKoVrr9/jbBGOMkWlOS7dcbju7
	c9dtKoxLhiZHLlexCSl4q3h7AU6UTVck457XduY2PeXpaLwih2iF15nQ6YH6Ufv6gmLXlycQtEg
	0VbIlLOLIBFVv0LlJGBi/8EzUGAPbtRle9ObQgb8n9LCvSJGfLkZj2UvZcrbBDpkKQ0LnRmqelP
	qy8Uy6hJ3KEQw1EfEWYC3xGQceAWEU2EbphqgQ8irSf1BQD2wg/3itskBXgxT2Re5PRtKzM
X-Google-Smtp-Source: AGHT+IFzUemwxrYRkIidNJk8Gu5NYrvaF6biCWhPxX1iUkfnGLHCgGf3jtLrSqkXnA51haW816YZzBSUheLb33VKrO8=
X-Received: by 2002:a05:690c:5507:b0:786:8abd:bbcf with SMTP id
 00721157ae682-786951653bfmr24861227b3.31.1762262869125; Tue, 04 Nov 2025
 05:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-2-ulf.hansson@linaro.org> <20251029081014.443psmqznd2pqm4i@lcpd911>
 <CAJZ5v0gcRQgj-3Yve_3OMsRJppdVmtWpBq51H5dk3JgTvSGLZw@mail.gmail.com>
 <20251030164542.atnhs4wgk6ggmmly@lcpd911> <CAPDyKFqTS6-69QfqdPtRrbkSqwxEnO1CPXLnRvM6WsOKNZgyQQ@mail.gmail.com>
 <20251031183724.2opdnjya7gu6fx6v@lcpd911>
In-Reply-To: <20251031183724.2opdnjya7gu6fx6v@lcpd911>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 14:27:13 +0100
X-Gm-Features: AWmQ_blLizT1f9WrbeiHr43xiYViNgQnDVhrGGdghJQaJwQNmb9X1hfQr-6XS_I
Message-ID: <CAPDyKFqyQuGC=ByxbDfJfFK_VRkwjTEQDXj1ket-51u+4_FYpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 19:37, Dhruva Gole <d-gole@ti.com> wrote:
>
> On Oct 31, 2025 at 14:47:29 +0100, Ulf Hansson wrote:
> > [...]
> >
> > > >
> > > > > It seems an overkill to me that a userspace program be required to hold
> > > > > open this file just to make sure the constraints are honoured for the
> > > > > lifetime of the device. We should definitely give the freedom to just be
> > > > > able to echo and also be able to cat and read back from the same place
> > > > > about the latency constraint being set.
> > > >
> > > > So you'd want a sysfs attribute here, but that has its own issues (the
> > > > last writer "wins", so if there are multiple users of it with
> > > > different needs in user space, things get tricky).
> > >
> > > sysfs makes sense, then would it make sense to have something like a
> > > /sys/devices/system/cpu/cpu0/power/cpu_wakeup_latency entry?
> > >
> > > IMHO userspace should decide accordingly to manage it's users and how/whom to allow to
> > > set the latency constraint.
> > > We already have CPU latency QoS entry for example which is sysfs too.
> > >
> > > >
> > > > > One other thing on my mind is - and probably unrelated to this specific
> > > > > series, but I think we must have some sysfs entry either appear in
> > > > > /sys/.../cpu0/cpuidle or s2idle/ where we can show next feesible s2idle
> > > > > state that the governor has chosen to enter based on the value set in
> > > > > cpu_wakeup_latency.
> > > >
> > > > Exit latency values for all states are exposed via sysfs.  Since
> > > > s2idle always uses the deepest state it can use, it is quite
> > > > straightforward to figure out which of them will be used going
> > > > forward, given a specific latency constraint.
> > >
> > > I disagree regarding the straightforward part. There could be
> > > multiple domain heirarchy in a system for eg. and all these multiple
> > > domains would have their own set of domain-idle-states. All of them having their own
> > > entry, exit, and residency latencies. I myself while testing this series
> > > have been thoroughly confused at times what idle-state did the kernel
> > > actually pick this time, and had to add prints just to figure that out.
> >
> > If I understand correctly, most of that confusion is because of the
> > misunderstanding of including the residency in the state selection in
> > regards to QoS.
> >
> > Residency should not be accounted for, but only enter+exit latencies.
>
> Understood your point on the latencies, however the point remains that
> in a multi domain , multi idle-states case, do we really have an easy way to
> determine what the next choice of idle-state the governor is going to
> make? We don't even expose the entry exit latencies in sysfs btw...

I agree, we should extend the sysfs/debugfs information about the
domain-idle-states with this too. Especially since we already have it
for the regular idle states that are managed by cpuidle.

>
> >
> > >
> > > When implementing these things for the first
> > > time, especially when one has complex and many a domain idle-states it
> > > would indeed help alot if the kernel could just advertise somewhere what
> > > the governor is going to pick as the next s2idle state.
> >
> > The problem with advertising upfront is that the state selection is
> > done dynamically. It simply can't work.
>
> I understand it might be done dynamically, but as IIUC the only
> constraint being taken into account is really coming from userspace. I
> don't think this series is taking into account or even exposing any API
> to kernel world to modify the cpu wakeup latency (which I think you
> should, but that's an entirely orthogonal discussion, don't want to mix
> it here). So as far as "dynamic" is concerned I feel if the userspace is
> having control of which processes are setting the cpu wakeup constraints
> then it's entirely okay for kernel to tell userspace that at any given
> moment "this" is the next s2idle state I am going to pick if you do a
> system s2idle right now.
>
> >
> > >
> > > Also, I am not quite sure if these latencies are exposed in the
> > > domain-idle-states scenario ...
> > > I tried checking in /sys/kernel/debug/pm_genpd/XXX/ but I only see
> > > these:
> > > active_time  current_state  devices  idle_states  sub_domains  total_idle_time
> > >
> > > Maybe an additional s2idle_state or something appearing here is what I
> > > was inclined toward.
> >
> > That sounds like an idea that is worth exploring, if what you are
> > suggesting is to extend the idle state statistics. In principle we
> > want a new counter per idle state that indicates the number of times
> > we entered this state in s2idle, right?
>
> Absolutely, having a "global" kind of a place to find out the s2idle
> stats would really be useful.

For regular idle states that are managed by cpuidle, those have a
per-state directory called s2idle (if the state is supported for
s2idle), with usage/time counters.

That said, I agree, it's a good idea to add something similar for the
domain-idle-states that are managed by genpd.

Let me think about it and I will post a couple of patches that add
this information about the domain-idle-states.

Kind regards
Uffe

