Return-Path: <linux-pm+bounces-26745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C7AACE59
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 21:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E5B1C20EAC
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5891DED60;
	Tue,  6 May 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWWSZcFb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDF1DE3BB;
	Tue,  6 May 2025 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560798; cv=none; b=PRVegGy7okUaRHBkFMNRwbZyOyV9r54yFTGgLRNh+BIclKDSB8eh4886DjTli3sDm9dRH/u4M7om+jm7EkZAAjkZiKYMmxUUEqYmBLZcHBGaptqPvCmy+td9Ypf4MxhdURAMmrZCbEG8+YUaCcrHfR3vypIPV0guyD9bonz+7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560798; c=relaxed/simple;
	bh=D5/4BigWPz9BglOJiAiQj7LfSv7VYWCIRc4N44WMdJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE1GGUGTh+ZqlGTxDZZwaKq/4eNWd+yHr/lBUgBQ2mtw+KDVlHHSxCOgzQNeLH9kGl2pb71EjYXWDqI68RLnBpjRMng+aBySAe/pQuxR4ycivYjKIJaFi/TaMvW0rwlGuf/fTkDXt/F+rdeyvN3Mgg6MiCMTN/VBbM2LM1YzbV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWWSZcFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B283BC4CEF3;
	Tue,  6 May 2025 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746560797;
	bh=D5/4BigWPz9BglOJiAiQj7LfSv7VYWCIRc4N44WMdJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iWWSZcFbriF1s8UD5jPepUW5jD16vLwS6wybMCk1r03dh1eY7vkqeBYbpWTHmZ13V
	 mvB5TZchhLf0zvEEzS/EI2xO1RTTzHLWU/e3HeIO4D6/c1n42HNvQYf5ETIj1lj1ir
	 RmA1zvIyBOwCatk44nZ28oDm5Ysh36J+AE/LbE54aRgNEdq+kSEc7XWjZShSBE2NVT
	 7Hh8LB6tlQrmoRcubK3Wb1E5va3ZKUuFcfQ+iD5HRT00E3K30XKzhJRJ/xPMdCL8R/
	 LrS+cTciwjvz3PbEyECvi9LhZ9o6+X7fINJZuX5wwqeW9JpHnMaOMRH4Dkj6KvaytT
	 aS4fzqVKHpgkw==
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376e311086so8764737b3a.3;
        Tue, 06 May 2025 12:46:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGb0+ADaeSr2Wpn51D8Bg9KvcvX28QmG64LF6ZJdOPPjLxLgIYqlSZbW8eTFO+pcsjN6A1+f93alg=@vger.kernel.org, AJvYcCUnM6nlIPJWSRVucw2YmjD+nTu9r09XEmMgvF1V5EMG+jCYKascBUKODzqzl9nm33z/MdOMJGB6x1y7Khs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/FmTd28zyUdKW7mfHzSJ03jnWO0Jg7S/akwsG5ewrXQNag27
	QNAXCPAgwHi5DnVvdEly/Snm71CquROGlXJBaqBpw3+ByaimOhg6ceySgeBfnIN3DofLIdwjJ75
	cL+AKRgNYsH3/0PrAcN08rdd6i4g=
X-Google-Smtp-Source: AGHT+IEMrGifCd6r/lmGcJKGIUFBrAJcb296B/ZNI+T9laifC7QMV3tnRRZKDPMYfPY/mmULzzuBQtAozE6A1YEXsCg=
X-Received: by 2002:a05:6870:4593:b0:2c1:6948:d57c with SMTP id
 586e51a60fabf-2db5c0d1fc8mr339058fac.28.1746560786792; Tue, 06 May 2025
 12:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3344336.aeNJFYEL58@rjwysocki.net> <2649447.Lt9SDvczpP@rjwysocki.net>
 <61cd69f5-6790-4480-8fe7-77ef763ed82b@arm.com> <CAJZ5v0h=wR464YqDEesnm3QscJ4UBy8CX0ixZV6QsY0DS22E8A@mail.gmail.com>
 <c3eda6eb-3e01-4d9c-bcbc-348e5f5552cc@arm.com>
In-Reply-To: <c3eda6eb-3e01-4d9c-bcbc-348e5f5552cc@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 May 2025 21:46:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jrnF+k81nCHEKvHa-SQp8J_iUkvW+jFo8ZHsj3AcG2vg@mail.gmail.com>
X-Gm-Features: ATxdqUFmcDfm9yUUGIkJvLiYZlbrTCfYu0uJYy7InsgHXE4HR3wSXeok4L_zM18
Message-ID: <CAJZ5v0jrnF+k81nCHEKvHa-SQp8J_iUkvW+jFo8ZHsj3AcG2vg@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 5/8] PM: EM: Introduce em_adjust_cpu_capacity()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 2:30=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 30/04/2025 21:23, Rafael J. Wysocki wrote:
> > On Sun, Apr 27, 2025 at 4:07=E2=80=AFPM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 16/04/2025 20:06, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> [...]
>
> >>> +     if (!(pd->flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
> >>
> >> This looks weird to me. How can an artificial EM ever have a non-ZERO
> >> em_data_callback here?
> >>
> >> There is already EM_PERF_DOMAIN_ARTIFICIAL specific handling in
> >> em_compute_costs(). Which probably works well for the
> >> em_create_perf_table() call-site.
> >
> > Yes, but that one doesn't pass a NULL cb pointer to it.
> >
> >> Will there be cases for Hybrid CPU EM's in which 'em_max_perf !=3D
> >> cpu_capacity':
> >
> > When the capacity is updated, the EM needs to be updated accordingly,
> > which is why the new function is being added.
> >
> >> em_adjust_new_capacity()
> >>
> >>   if (em_max_perf =3D=3D cpu_capacity)
> >>     return
> >>
> >>   em_recalc_and_update()
> >>     em_compute_costs()
> >>
> >> so that em_compute_costs() might be called?
> >>
> >> Maybe:
> >>
> >> @@ -233,11 +237,17 @@ static int em_compute_costs(struct device *dev,
> >> struct em_perf_state *table,
> >>         unsigned long prev_cost =3D ULONG_MAX;
> >>         int i, ret;
> >>
> >> +       if (!cb && (flags & EM_PERF_DOMAIN_ARTIFICIAL))
> >> +               return 0;
> >>
> >> is somehow clearer in this case?
> >
> > This would work, but I prefer my version because it does one check
> > less and it does the check directly in em_recalc_and_update(), so it
> > is clear that this doesn't call em_compute_costs() for artificial PDs
> > at all.
>
> OK, but checking it inside em_compute_costs() would also avoid this 'cb
> =3D NULL' crash for an artificial EM in:
>
> int em_dev_compute_costs(struct device *dev, struct em_perf_state
>                          *table, int nr_states)
> {
>         return em_compute_costs(dev, table, NULL, nr_states, 0);
> }

This is unused currently, so no worries, but you have a point.  It
should return -EINVAL for artificial perf domains.

>
> BTW, there is this:
>
> #define em_is_artificial(em) ((em)->flags & EM_PERF_DOMAIN_ARTIFICIAL)
>
> (I guess s/em/pd ?) which lets you check this when you have the perf
> domain. So far it's used in dtpm, cpu- and devfreq cooling.

Thanks for letting me know about it, I'll use it in that check.

> Anyway, you can add my:
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> for the entire set.

Thank you!

