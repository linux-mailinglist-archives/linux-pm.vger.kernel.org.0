Return-Path: <linux-pm+bounces-3920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F61855004
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 18:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFC128F0BC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD23F84FC0;
	Wed, 14 Feb 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GI5OsJ1w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1760864
	for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931204; cv=none; b=T5qZhHpYP5ymxucqPZFMmIncNLfTqPLuc8wJH8jqhZBkG25ATsagaGcX+aL714S1sDEtbn9lRhUnJMZLoU1tLqvQrOKAQW6hl/yhTZ2VX4QEhE7bygRCrPzQthEbVXebSN1D1dUKPOLapfyr2BdEfRVgUjnuABd21jNLugjkdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931204; c=relaxed/simple;
	bh=zJ9UnsbBVQk+7CK64IucZXo37BDgEgF/64+egIlJnYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tg/dX7BKg74TteCkgTpYxrVVVIztWcX0hi5b6QPP4uodQ3gDBeLxWD+ZKcoilpWPRld/O4fGnJ9pDGxCW5/VtwMu1dewur6wo/BbLFUlRj9XW19B9cS9A1g/A2jstIqZWMryEYRevmaRk9zrZ80eIX7nx2vaCdGBvO4GYrMfX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GI5OsJ1w; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so1966824a12.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707931200; x=1708536000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=236lqzUHLILRkjMonxzcy3On2gm7C9J5rPgBDfLu9uc=;
        b=GI5OsJ1wz5H57Sg4mAXsqobe1T4cnGXVVvPIZYy9/pYyPNM7H7qlJanQEFrYmi6fw0
         5AunEgggKy9cS5hSKY5UfCfii2Sw2D1XK+mC6FBEuZ1c3KrX7G+6O/OGKMvZPYjNoSwK
         sUt+1NPmOynEM9Mc6gCnvzntgqXkRcHQGhm4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931200; x=1708536000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=236lqzUHLILRkjMonxzcy3On2gm7C9J5rPgBDfLu9uc=;
        b=chEirzgLP2DTYQTkLR2w+j9EeqfHMAlvzHW4i3q8bwO1TqTo0m1tpzx0H3bkiGfN3h
         cfU6jSKv44Xm4umM9e8CXkwdyfIUAhnkAXeBD86qoR+WEbDPG3k+FpRUv6HXp++qmoDD
         NaB6XyeWaGXxpfKcu6r2yjzHibY/NjydoUv5blRFgjg1bgV/ml4DEBoOn+tNL8SC2XNS
         LDZXSMYyDtFF0AXlKlAP5jaPs5bfAX7+q6LoJpjXPtT50JYLR3k0C7B/15pp5QoaeXfU
         Oe70W/cjplzojPZQ8E3MpEXPvnFqud9KWIFjn3ACNso7m5G8iyPtFmloDol4/HccKEak
         BYMA==
X-Forwarded-Encrypted: i=1; AJvYcCUd7ADmntVGxR0e11SGn9wNDDOlnWSp2ET6DMG8PAwRkO/NMwQbbvHeIITcjl14BJrUcseWp4Vd4W3Z331VBSFubeuu0na4NWk=
X-Gm-Message-State: AOJu0YzcTVsK9EFmRs6qQruds3vas/idwVE/kaR3bPAEC3h1ainPWbQV
	FQvRwjIz0g5RPZpyBfe3Dt/r/7sGflT7DUpvPbiOt+ntH2QJ+lat8X86Zkt+Oonny5RrL1ocgDS
	MJLU=
X-Google-Smtp-Source: AGHT+IGC9SnnHx/yLkWth0Xn3XLnfYfP+Sma7lmSJfBawmpA51f2Hne+5HbqMub6RbAsywXtQI6wsA==
X-Received: by 2002:a05:6402:1cc4:b0:561:7832:d35 with SMTP id ds4-20020a0564021cc400b0056178320d35mr2802040edb.15.1707931200252;
        Wed, 14 Feb 2024 09:20:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYuP6AIoIhosm9hS8HWJYljoJEHezHJ/Pk1yy2SmAVuczMLSVI5lRXkBGYbJj7PMAHcLLBLWVmJjMrDALplPu38zvfkRgUyzQ=
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id er13-20020a056402448d00b005607825b11bsm4803048edb.12.2024.02.14.09.19.59
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 09:19:59 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5638ae09ec1so11457a12.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 09:19:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdxk/D/pKWzpdk5zApDSIAPGmwHO4pOMn3FXZs+WQYiETpEQ1iED2BnOnXTK1hJ66CA7efswYKYcVdIgZ0izhJ79fY17RPMCc=
X-Received: by 2002:a05:6402:5410:b0:561:5e21:8b89 with SMTP id
 ev16-20020a056402541000b005615e218b89mr2620799edb.13.1707931198880; Wed, 14
 Feb 2024 09:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240114183600.135316-1-vincent.guittot@linaro.org> <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
In-Reply-To: <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2024 09:19:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
Message-ID: <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant case
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	wkarny@gmail.com, qyousef@layalina.io, tglx@linutronix.de, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, 
	Sasha Levin <sashal@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Shardar Mohammed <smohammed@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 09:12, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> We have also observed a performance degradation on our Tegra platforms
> with v6.8-rc1. Unfortunately, the above change does not fix the problem
> for us and we are still seeing a performance issue with v6.8-rc4. For
> example, running Dhrystone on Tegra234 I am seeing the following ...
>
> Linux v6.7:
> [ 2216.301949] CPU0: Dhrystones per Second: 31976326 (18199 DMIPS)
> [ 2220.993877] CPU1: Dhrystones per Second: 49568123 (28211 DMIPS)
> [ 2225.685280] CPU2: Dhrystones per Second: 49568123 (28211 DMIPS)
> [ 2230.364423] CPU3: Dhrystones per Second: 49632220 (28248 DMIPS)
>
> Linux v6.8-rc4:
> [   44.661686] CPU0: Dhrystones per Second: 16068483 (9145 DMIPS)
> [   51.895107] CPU1: Dhrystones per Second: 16077457 (9150 DMIPS)
> [   59.105410] CPU2: Dhrystones per Second: 16095436 (9160 DMIPS)
> [   66.333297] CPU3: Dhrystones per Second: 16064000 (9142 DMIPS)
>
> If I revert this change and the following ...
>
>   b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
>   f12560779f9d ("sched/cpufreq: Rework iowait boost")
>   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
>
> ... then the perf is similar to where it was ...

Ok, guys, this whole scheduler / cpufreq rewrite seems to have been
completely buggered.

Please tell me why we shouldn't just revert things as per above?

Sure, the problem _I_ experienced is fixed, but apparently there are
others just lurking, and they are even bigger degradations than the
one I saw.

We're now at rc4, we're not releasing a 6.8 with the above kinds of
numbers. So either there's another obvious one-liner fix, or we need
to revert this whole thing.

Yes, dhrystones is a truly crappy benchmark, but partly _because_ it's
such a horribly bad benchmark it's also a very simple case. It's pure
CPU load with absolutely nothing interesting going on. Regressing on
that by a factor of three is a sign of complete failure.

                  Linus

