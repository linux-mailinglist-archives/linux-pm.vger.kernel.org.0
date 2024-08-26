Return-Path: <linux-pm+bounces-12899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5404395F883
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CD328269C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AFC194AF9;
	Mon, 26 Aug 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0dlGfRc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3192A1D8;
	Mon, 26 Aug 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694496; cv=none; b=Zz7ZDW1H1w9XL5cak8FpbiXy9U5iwlbl9UuNDiUWy3DuGp2HM3agPGZpF5cLBrMlTrkk22DzvfXbnGo7FbpPcbXoiE3z9FMLu5Nmjp51CBreDwIfW5CtjGbYvA4Skv9uijDQD2n0CPcVk68E3CStydHuss8bRq3jP3Grw9Vdfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694496; c=relaxed/simple;
	bh=lL1iLa6DyWbdsTavsBbgs8XB7zP5FUPKKoc/0WvCFiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6s902KhlSRrguVdtyHfJfr9MV2iPDhStFveRdkYIxlt8yDVFf7h7JksUeVPFN1XwkdIykVCFdv0ihL43I5kZEBN1NoYe6TXyuD40Z3yqz3KLaJBWtRw3qGkkC5S8z0WX8JGi/PaZCyvjHZ6GjBMOPbWDfQufNkqKvGQmqqIjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0dlGfRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812FCC8B7A0;
	Mon, 26 Aug 2024 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724694495;
	bh=lL1iLa6DyWbdsTavsBbgs8XB7zP5FUPKKoc/0WvCFiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t0dlGfRc5rucYmtE1t/f6yeAg+T9mIbLqFgwyz8mMEvYhj8ArlEZftW5i4f/1rX3Z
	 2VJqbU67b/FXRkw5vMub9OEE1z7CmolTYwpQs2DCvoKX03It4XoU6ML0le7+NTuNwY
	 C2MESShzkUt8nrwlVVmM6oBsYDhw7U2WKYpl7ex1zGEjm9bf8Y/CNu0wFTDMvZJ1T1
	 FZ+H1EpPmzezU+SV+8gV60Zji8kMdvqYhu4ic03SivKRlv/wgXyPSP5iBVEbdvrAv9
	 NKyLGW/FVqcqlcT8RvLLz8a46hl/rQ0MS8RutUh456MFTqCuksRoU98OXszg84/AIo
	 Ws6wDwZUno4sQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-27018df4ff3so3616386fac.1;
        Mon, 26 Aug 2024 10:48:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFS1CNGkUorYPwI9F+lpKVaZn3Q2a25ngg4oHVwTum1EylO7loMQf5MtJX6Qm9wMqCHR7LYR1FRso=@vger.kernel.org, AJvYcCUpL7CUuIJZZKvm/5GLO05ekX2BYIfrmhcYdSg05S8v5m3yNAxdW4pzxOL/h1GiwYmI+WqpnY+2tbZEIzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoQiHIdZmGlKnvsbg+yQLDdwOmcX3pwZcGARk5DhZ/n00l61s
	tCgotfRIRkQc6C1uR0VrvjFA8dbuV+vPO9fPQdlT/FDhjWUjDavOC1eIa6HsqCeQM7mh0EG/R8A
	mfJZP0j1oOd2cPsviFQsBL7m5NSg=
X-Google-Smtp-Source: AGHT+IFAUgWN0c5wQiHY1OhEb9hh1CEwjtZReiR6Mc5xaRF91Jyp3e1eMol3rH60D2adzKsNqvOiusy6yV8plua3Zgo=
X-Received: by 2002:a05:6870:970a:b0:268:2efa:2de0 with SMTP id
 586e51a60fabf-273e6469d6dmr12934256fac.13.1724694494154; Mon, 26 Aug 2024
 10:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063321.629-1-pugaowei@oppo.com> <b07c39fab5ac0e32e7768ed3e8a799c8eb68802a.camel@linux.intel.com>
 <06ce2143-cc74-41e5-b39f-15053133b232@oppo.com>
In-Reply-To: <06ce2143-cc74-41e5-b39f-15053133b232@oppo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 19:48:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jno7jvzFY880wZi9ft6GsKXbrEintdCrP3sFuxuwJZUg@mail.gmail.com>
Message-ID: <CAJZ5v0jno7jvzFY880wZi9ft6GsKXbrEintdCrP3sFuxuwJZUg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: queue policy->update work to rt thread to reduce
 its schedule latency
To: Gaowei Pu <pugaowei@oppo.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 4:30=E2=80=AFAM Gaowei Pu <pugaowei@oppo.com> wrote=
:
>
> Hi Tim,
>
> On 2024/7/19 6:03, Tim Chen wrote:
> > On Wed, 2024-07-17 at 14:33 +0800, Gaowei Pu wrote:
> >> Currently we encountered a problem that the cpufreq boost latency
> >> is about 10 milliseconds or worse when we boost through cpufreq QOS re=
quest
> >> under high workload scenarios, while the boost latency mainly consumed=
 by
> >> schedule latency of policy->update work.
> >
> > What is the tail latency now after your change?
> >
> >>
> >> We should ensure the low schedule latency of cpu frequency limits work
> >> to meet performance and power demands. so queue the policy->update wor=
k
> >> to rt thread to reduce its schedule latency.
> >
> > If my understanding is correct, kthread has a default nice
> > value of 0 and is not a rt thread.
> >
> > I think the gain you see is
> > your patch created a dedicated kthread work queue on CPU 0.
> > The work from policy change no longer have to compete time with other
> > requests coming from schedule_work().
>
> It's not just other requests coming from schedule_work(), also some norma=
l
> cfs tasks running on the same cpu.

Do you have any data to support this statement?

> In order to not competing time with the above threads, i change the threa=
d
> policy to rt and prio set to 98 to reduce the schedule latency.

By how much?

> >
> > If the policy change really needs to get ahead
> > of other tasks, I think you need a dedicated
> > workqueue with alloc_workqueue() using WQ_HIGHPRI flag.
>
> I think the cpufreq boost or limit action should be trigger in time to me=
et
> performance and power demands. An dedicated workqueue with highpri will b=
e
> better but maybe not good enough because cfs pick or preempt policy is no=
t
> purely based on thread nice value. So i think the final solution is rt th=
read
> and the policy change work deserves it :)

The "I think" and "maybe" in the above paragraph are not particularly
convincing.

Switching it over to use a dedicated workqueue would be a no-brainer
as using dedicated workqueues is recommended anyway and if it
measurably improves performance, that's for the better.

However, making it use a worker thread the way this patch does
requires quite a clear demonstration that the above is not sufficient.

Thanks!

