Return-Path: <linux-pm+bounces-19539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79879F8581
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 21:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA017A2E41
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10619F13B;
	Thu, 19 Dec 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="VunvqF8Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC731A01B0
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639068; cv=none; b=G6lF7kxbBa70ffhjbdS37pz/M8vpjU3G9yVhV/hy3bm6ZQBrQxKIzXXc/tQe+QtltO3MlpQa6D9dqwsmFo9JXVdDmtjaXSGYvMGFDuqDA5WihnQrabPp76zBQW2nwlK/adOZ0Ia+4a35yP/fAhFNo4nsukLdp8rRGk5zUnF9jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639068; c=relaxed/simple;
	bh=hPIN03X0lI+0RP1jD/bsF2vmFLFyX+P5pepCStsVUf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nvo5NOFmosWA5l/FT4xkcjKx3bR8Djxaq1rESRL8KGDdilLi6luVQC0kA9KEi8e8ZTrnKWU73cOq4EPaYi9tFKTKK7KufaXHOP6O7NXJJNx03X+XhTxht3JxwaMM9Ilk7ItG9YZzQyPNYAHSKKxB4oQ8qKXOP89WEF4kUf1/nhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=VunvqF8Y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso838165a91.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 12:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1734639065; x=1735243865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kKEAHA+lY+PKUV/M7xzpqDmpvEGghMcILectHAvdKSQ=;
        b=VunvqF8YXKuuBYSpOHNqhP9pXMS1x5/pbXfQtkIgOFJ1RfqnBy/4bDV22YYFMiTZZV
         /DSNqGP59YI85DaZDa+n9L7hGECWdTex5PaQqso0tQzI146BnAD6EI0CQsvzo/gIBDoo
         cug23kpDG1WqxdIpOq7aXRcydKl57OpBWZwbdwa7HnGFQA/YKIUU/NQyg+ZC21Dt38jf
         AYpUb3E5yqmOXoBZT1ADs2fF5rs8sFMKgtXeMzJLBbpKhfW5XJGcX+BTi4nTx0OhjBsJ
         a5rz9oeXEFu4uPBt1s7zTwC8wc0VBqNKOkLt5tQVN6/kNwzDnjND/IjsVmofdtKvdu9q
         GrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734639065; x=1735243865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKEAHA+lY+PKUV/M7xzpqDmpvEGghMcILectHAvdKSQ=;
        b=bv3tmkH9rMJ/RW2y5lUIKnbkkEgX6bb2E4at7rjJf37MSQSajEqCLsxQx+qCa0xHyj
         FHywnoBhtjxqq4/6LSTmJh49f1goEx0rvOBAqp4/L3ub2G+mzU+B4c6dUSaFvCwk2oeD
         nqcL42ZYEaYfIN1QHsC1Ko0y2hGPDW8dXTwIia4/Sejippo5VEhyJR0l1TaDkbvtWL1L
         sKHJ66LLq0msjv/nwDOr6WYdlCbs5XRkmnq7BinfWR7jw1pt0dZY77NFGHRoNP8E5gij
         X9q1ALa32jNk1WrRYNvQF+un/L1oo5eYXJM3RKTv7mf0eZOujcLCaviRoIr8e5zw6d5Y
         Hrdw==
X-Forwarded-Encrypted: i=1; AJvYcCXm5hi0TYJuvAP91Q8JqsP7cv0hPGP4rifoqTUfWRaNhyZtQA/NFqLToOSoZG7ecfwzZv1ILH6Lpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YziGGVhnlJdohaZ8F4dZp5QDwYzLC5Tml7hw9NUG8YFbFxeRg8t
	+LiSkxAJGx5QQp6qGIIs8vxZAKTXZznyrJeLx8xWJnCxOZPrQNmV5N9vVDBiLq+jFeDc0gg0Xdm
	GGKs/TGYa0/kwd1/fraiyE31I+a1kW23iGAUD6g==
X-Gm-Gg: ASbGncutmHjWisNsk24moePpqrRlEk7uMMdmnaxLwQ68lio2jY++/IkYISuZMaeC/lO
	4+lN9eyU1J3p2T9ZS0GlVVTv97mnf6+tGJwuWNog=
X-Google-Smtp-Source: AGHT+IHdhtdhiqUMk/ed+xhHKEfzWEyramriL7T4MeeIMpvPo58tfY5NjzuXjK2WME5wR9D8pcfkBdZ8vOniGSHic4Q=
X-Received: by 2002:a17:90b:3cd0:b0:2ee:a76a:830 with SMTP id
 98e67ed59e1d1-2f452eb3279mr473500a91.24.1734639065377; Thu, 19 Dec 2024
 12:11:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219192144.2744863-1-naresh.solanki@9elements.com> <4239407f-2676-45c4-9730-70493e56e36c@amd.com>
In-Reply-To: <4239407f-2676-45c4-9730-70493e56e36c@amd.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 20 Dec 2024 01:40:54 +0530
Message-ID: <CABqG17hUvdo4ShQzWPWpfNqJFiDCDHmApPnHahtTt83B1Thg9Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Huang Rui <ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mario,

On Fri, 20 Dec 2024 at 01:02, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/19/2024 13:21, Naresh Solanki wrote:
> > The previous approach introduced roundoff errors during division when
> > calculating the boost ratio. This, in turn, affected the maximum
> > frequency calculation, often resulting in reporting lower frequency
> > values.
> >
> > For example, on the Glinda SoC based board with the following
> > parameters:
> >
> > max_perf = 208
> > nominal_perf = 100
> > nominal_freq = 2600 MHz
> >
> > The Linux kernel previously calculated the frequency as:
> > freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
> > freq = 5405 MHz  // Integer arithmetic.
> >
> > With the updated formula:
> > freq = (max_perf * nominal_freq) / nominal_perf
> > freq = 5408 MHz
> >
> > This change ensures more accurate frequency calculations by eliminating
> > unnecessary shifts and divisions, thereby improving precision.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>
> Thanks, this makes sense to me.
>
> But looking at it, we should have the same problem with lowest nonlinear
> freq as it goes through the same conversion process.  Would you mind
> fixing that one too?
Sure. Somehow my eyes missed that.
Also observed that current calculations yields zero for lowest_nonlinear_freq.
After fixing that, it reported frequency 2002 & 1404 depending on the core.

On a side note, I'm also observing that the highest_perf is set to 196 which
should not have been the case as I do have cores with value 208.
Seems like amd_get_boost_ratio_numerator needs some addressing for that.

Regards,
Naresh
>
> Gautham, Perry,
>
> Is there something non-obvious I'm missing about why it was done this
> way?  It looks like it's been there since the start.
>
> >
> > Changes in V2:
> > 1. Rebase on superm1.git/linux-next branch
> > ---
> >   drivers/cpufreq/amd-pstate.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index d7b1de97727a..02a851f93fd6 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> >   {
> >       int ret;
> >       u32 min_freq, max_freq;
> > -     u32 nominal_perf, nominal_freq;
> > +     u32 highest_perf, nominal_perf, nominal_freq;
> >       u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> > -     u32 boost_ratio, lowest_nonlinear_ratio;
> > +     u32 lowest_nonlinear_ratio;
> >       struct cppc_perf_caps cppc_perf;
> >
> >       ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
> >       else
> >               nominal_freq = cppc_perf.nominal_freq;
> >
> > +     highest_perf = READ_ONCE(cpudata->highest_perf);
> >       nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > -
> > -     boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
> > -     max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
> > +     max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
> >
> >       lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> >       lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>

