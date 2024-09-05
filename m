Return-Path: <linux-pm+bounces-13677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E096D648
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C2AB218BD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A546F19882C;
	Thu,  5 Sep 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJMWl+38"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB79155730;
	Thu,  5 Sep 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532831; cv=none; b=pPEsGKVKRMtP+T1NKrvWJjkZveCtyUX7BW3+ltHQ4TjwHaWIjLEfY4ZniVs668+mlNKrbC4Rrv2IdFo6uZkgFkWm+yL4kkWZ6Fw8j1sCfeF9bC3KrtQU9Fr+RWSNj8UZanPTnS+hZC9T0HAqzx8pKJM+VeJtpmbzFHHzVC67svE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532831; c=relaxed/simple;
	bh=vYakvufT4aNJnUe6D0Gqkc+bmULuI+Q45BIR6PeNra8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HREZamoeb1bp2Ovo6bsfnTcHRJgLMDdgaP0Rn9GhC2I8UU28A+7xTVfwAQArFYd8Z0FwgwM5zVOYWE8+H/4mM23+vMQmg2V0nUrH66bD819iVvmAITB0tHy2r83a0RhSAu7yLNOI15KdXyWz6wNkgWfZhOfYoYoAMdtqmTxGu4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJMWl+38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089D2C4CEC7;
	Thu,  5 Sep 2024 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725532831;
	bh=vYakvufT4aNJnUe6D0Gqkc+bmULuI+Q45BIR6PeNra8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DJMWl+38lEAVgkt6XXTANQ+5mPEORW5+R+YxT/iAZdz9977EM3t8h9LuC5mDGQK0+
	 iKZtFakct6pTFNUoEjMnP1eHtTH6ENN9JS6vhW5vI3wfdL1Qw8KIGIz1iAiqxa7Xjd
	 qYwEbopZOP/4h71SSd2oQLPTuW5R3DVCTVy22uplBarpbGkfwVUHNAPUPDEMTSrXlo
	 5+PoIgoRE8uUZ9tWNcUGohmaJnVIG9I1XoTL/2BtLgOIIRsIeH7s/ngntqO28zwtW4
	 g2osTpOoHflPEa5jLhEyM5VhhY+Vj3hNSBnCE0oLx4vyGWtA439qIWlqQdQvrKr20O
	 P9VY41iKA5Rkw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5da686531d3so375582eaf.3;
        Thu, 05 Sep 2024 03:40:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8KUb2gMj75FAj5EnCTimjDp/mGUW9yp+9rCNm4NTZsmEZOKmKgfZQ/QBDpulpK/0k/dnwzNtQihg=@vger.kernel.org, AJvYcCXBkvm0uoyndmwHhZg2nLkAkTsxs4JBSy9hcG+eE5aPvePCLEuauPrx2Tz7duLmJOoY+sGUhTPLoj0AtF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ipJ6hwfqsKyjy0NWizKw/0HDqMmGCAyHrVOe/HzgWqkwkAZU
	NJM15noY73pyY6bXfXZY/KUfDsAfB/6V0AZPLbVzdgqvaxk34cv7mhkUaM47bsc+ajT4baJib6r
	L/4DMpnuVoRLbwYxRGRM2y02xLi4=
X-Google-Smtp-Source: AGHT+IHyw57L92V2eyHjVvhlY0AKXh5wfMRHz7eeJt99hsvIrMZ6VrRjCY/0EQMQXJkfiFIBdNzouG5Q5lL5oWEYDjM=
X-Received: by 2002:a05:6820:1ca4:b0:5da:a26b:ce6e with SMTP id
 006d021491bc7-5dfacf20303mr21434605eaf.3.1725532830320; Thu, 05 Sep 2024
 03:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819154259.215504-1-axboe@kernel.dk> <20240904142841.GL4723@noisy.programming.kicks-ass.net>
 <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
 <CAJZ5v0hVghgKgv0zqabL1m2FT6wou8-tW_9Mm-_9=0-3yhMb3A@mail.gmail.com> <0e37c349-7076-4a02-bfbc-577e50090172@arm.com>
In-Reply-To: <0e37c349-7076-4a02-bfbc-577e50090172@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Sep 2024 12:40:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ga0FJtgQhEWzq6qYDjDz=TjiAzr4ApPAT7U_GosG3m9w@mail.gmail.com>
Message-ID: <CAJZ5v0ga0FJtgQhEWzq6qYDjDz=TjiAzr4ApPAT7U_GosG3m9w@mail.gmail.com>
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:29=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/4/24 16:18, Rafael J. Wysocki wrote:
> > On Wed, Sep 4, 2024 at 4:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >>
> >> On Wed, Sep 4, 2024 at 4:28=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >>>
> >>> On Mon, Aug 19, 2024 at 09:39:45AM -0600, Jens Axboe wrote:
> >>>> Hi,
> >>>>
> >>>> This is v6 of the patchset where the current in_iowait state is spli=
t
> >>>> into two parts:
> >>>>
> >>>> 1) The "task is sleeping waiting on IO", and would like cpufreq good=
ness
> >>>>    in terms of sleep and wakeup latencies.
> >>>> 2) The above, and also accounted as such in the iowait stats.
> >>>>
> >>>> The current ->in_iowait covers both, this series splits it into two =
types
> >>>> of state so that each can be controlled seperately.
> >>>
> >>> Yeah, but *WHY* !?!? I have some vague memories from last time around=
,
> >>> but patches should really keep this information.
> >>>
> >>>> Patches 1..3 are prep patches, changing the type of
> >>>> task_struct->nr_iowait and adding helpers to manipulate the iowait c=
ounts.
> >>>>
> >>>> Patch 4 does the actual splitting.
> >>>>
> >>>> This has been sitting for a while, would be nice to get this queued =
up
> >>>> for 6.12. Comments welcome!
> >>>
> >>> Ufff, and all this because menu-governor does something insane :-(
> >>>
> >>> Rafael, why can't we simply remove this from menu?
> >>
> >> Same reason as before: people use it and refuse to stop.
> >>
> >> But this is mostly about the schedutil cpufreq governor that uses
> >> iowait boosting.
> >
> > To be more precise, there are two different uses of "iowait" in PM.
> >
> > One is the nr_iowait_cpu() call in menu_select() and the result of it
> > is used for two purposes: (1) select different sets of statistics
> > depending on whether or not this number is zero and (2) set a limit
> > for the idle state's exit latency that depends on this number (but
> > note that it only takes effect when the "iowait" statistics are used
> > in the first place).  Both of these are arguably questionable and it
> > is unclear to me whether or not they actually help and how much.
>
> So from my perspective it doesn't, not significantly to justify it's
> existence anyway. Either it doesn't actually matter for menu, or teo
> is able to compete / outperform without relying on it.

Thanks for this feedback!

I'm actually going to try to remove that stuff from menu and see if
anyone cries bloody murder.

> Some caution is advised though this really depends on:
> - Which idle states are available for the kernel to select.
> - How accurate the kernel's view of the idle states is.
>
> Both varies wildly.

True, but let's see what the feedback is.

> > The other use is boosting CPU frequency in schedutil and intel_pstate
> > if SCHED_CPUFREQ_IOWAIT is passed to them which in turn depends on the
> > p->in_iowait value in enqueue_task_fair().
> >
> > AFAICS, the latter makes a major difference.
>
>
> Indeed, fortunately the impact is quite limited here.
> But please, Rafael, Jens and Peter, feel free to share your comments
> over here too:
>
> https://lore.kernel.org/lkml/20240905092645.2885200-1-christian.loehle@ar=
m.com/

I will.

Thanks!

