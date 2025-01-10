Return-Path: <linux-pm+bounces-20238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E6A0943E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB973188DF6D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20063211A24;
	Fri, 10 Jan 2025 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJYYyazx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B22211A05;
	Fri, 10 Jan 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520408; cv=none; b=u0piJlPGl6qlQfqWQpXLyvaN8xTle716cbJegA1vn6NYaSkH0Vzn8ebLIKGtcb0lLgseA19Rbj/pgDnbBl/8l7qJ//6lXlFi30Bu/EpT2HU3cNpc8VaB0wjNSGqeTuUr6yGvk0d8us5TBv8dbNm/rhxfBAviLymoMA0ADO50IC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520408; c=relaxed/simple;
	bh=511R0WplqvB9sjE9096u7/czuaXzMUVga8oQksURydU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsrADlNd1f96gLCfweDWgAmvnNxmEqySQylm/Ana4+3gwd79S3v7TAKtqyMSiCuP30dG7C/aTNdJOncwB3FRdUNpahpMGodaQk5q44MZkuSuUs0B9uyCC4YUZy136IFUQgGscCcoW+aHXaaj8pU94zvGwQ6K3/KjvOsQzaELcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJYYyazx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E344C4CEE3;
	Fri, 10 Jan 2025 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736520407;
	bh=511R0WplqvB9sjE9096u7/czuaXzMUVga8oQksURydU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FJYYyazxiUg468KciTr+JJKVouB08PIYhKwJoMR23/ZEFS9wSGye8EMvJW8DukCFZ
	 iFG66LTb69wkKemMBwrLDq2l3lVh9FaMgjR8MEGW685r62qFbIw7yjuwKChqV60LCh
	 iSplYCb9v1XhZeq6qlgYRkH7zfCPGEFlRY9bwsdWiN+zyI34JhOm2SgOeGPwoW+fOK
	 HQ2M30ydeH9rMXEp3UMVbM+mLg5EwopZSWyw/GT04yeZiUZce/dBiO7L2ALFHmFlYw
	 ijlxT/+gX2ErkC2oscL1fJ903uve4PijyNcjnLNlacjfadnu7s/etnG2bVYnA5KpAB
	 yyin+9/L658+A==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f4ce54feb8so994436eaf.3;
        Fri, 10 Jan 2025 06:46:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbU0hW7oEni3hwHfY1CBNqs2xP61esFbIahFy38yeiboFNHyYldg0+FfOCn0v4hA6/m2Xvyra4tX4=@vger.kernel.org, AJvYcCVCzYSkdEAO018IPk7CaIgUyCJ19FhV4ptUsSAd10VzB44g+gYvMRGBicQalMp6LoTfx1hVcO+lL1KT518=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0Hs6uZjJVEyUrMe5n4w/jcuZJo82IN4zDR/3jiUG3uy/TGLT
	lAgWd8WOn1xv1Szi9f2erDNNjKqpZcMrpu5usnD4MnNG5dHr4nl9P7t5VeF1cKGPvpTg9sLj9zt
	KwctDjCJ7HVyffoouDRgC7rqywFI=
X-Google-Smtp-Source: AGHT+IFuMXrGpWY0OXwPUh0mC6YMfbi5yB81Kv5EjpPl4PmGWgKY0d/egDng+YtpQVt3HFr7w6RSHCLDJ1ONtTr4e7I=
X-Received: by 2002:a05:6870:1594:b0:296:7b65:2fac with SMTP id
 586e51a60fabf-2aa06524095mr5319673fac.3.1736520406599; Fri, 10 Jan 2025
 06:46:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6120335.lOV4Wx5bFT@rjwysocki.net> <658fc3b6-2e8f-47b4-a5c2-bd1b72b54a15@arm.com>
In-Reply-To: <658fc3b6-2e8f-47b4-a5c2-bd1b72b54a15@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Jan 2025 15:46:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hpaNW8ms9Yi06+JoA7Xp-0yyLOKv3r-HnQ5-keido7dQ@mail.gmail.com>
X-Gm-Features: AbW1kvbvBm1ww6SFKDNAnQujT7lBjxJKNtWpid56U_d1-pHbBxVZLbSOiO_55NY
Message-ID: <CAJZ5v0hpaNW8ms9Yi06+JoA7Xp-0yyLOKv3r-HnQ5-keido7dQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: teo: Update documentation after previous changes
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:09=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/10/25 12:48, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After previous changes, the description of the teo governor in the
> > documentation comment does not match the code any more, so update it
> > as appropriate.
> >
> > Fixes: 449914398083 ("cpuidle: teo: Remove recent intercepts metric")
> > Fixes: 2662342079f5 ("cpuidle: teo: Gather statistics regarding whether=
 or not to stop the tick")
> > Fixes: 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length() c=
all in some cases")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   99 +++++++++++++++++++++----------=
---------
> >  1 file changed, 52 insertions(+), 47 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -10,25 +10,27 @@
> >   * DOC: teo-description
> >   *
> >   * The idea of this governor is based on the observation that on many =
systems
> > - * timer events are two or more orders of magnitude more frequent than=
 any
> > - * other interrupts, so they are likely to be the most significant cau=
se of CPU
> > - * wakeups from idle states.  Moreover, information about what happene=
d in the
> > - * (relatively recent) past can be used to estimate whether or not the=
 deepest
> > - * idle state with target residency within the (known) time till the c=
losest
> > - * timer event, referred to as the sleep length, is likely to be suita=
ble for
> > - * the upcoming CPU idle period and, if not, then which of the shallow=
er idle
> > - * states to choose instead of it.
> > - *
> > - * Of course, non-timer wakeup sources are more important in some use =
cases
> > - * which can be covered by taking a few most recent idle time interval=
s of the
> > - * CPU into account.  However, even in that context it is not necessar=
y to
> > - * consider idle duration values greater than the sleep length, becaus=
e the
> > - * closest timer will ultimately wake up the CPU anyway unless it is w=
oken up
> > - * earlier.
> > - *
> > - * Thus this governor estimates whether or not the prospective idle du=
ration of
> > - * a CPU is likely to be significantly shorter than the sleep length a=
nd selects
> > - * an idle state for it accordingly.
> > + * timer interrupts are two or more orders of magnitude more frequent =
than any
> > + * other interrupt types, so they are likely to dominate CPU wakeup pa=
tterns.
> > + * Moreover, in principle, the time when the next timer event is going=
 to occur
> > + * can be determined at the idle state selection time, although doing =
that may
> > + * be costly, so it can be regarded as the most reliable source of inf=
ormation
> > + * for idle state selection.
> > + *
> > + * Of course, non-timer wakeup sources are more important in some use =
cases,
> > + * but even then it is generally unnecessary to consider idle duration=
 values
> > + * greater than the time time till the next timer event, referred as t=
he sleep
> > + * length in what follows, because the closest timer will ultimately w=
ake up the
> > + * CPU anyway unless it is woken up earlier.
> > + *
> > + * However, since obtaining the sleep length may be costly, the govern=
or first
> > + * checks if it can select a shallow idle state using wakeup pattern i=
nformation
> > + * from recent times, in which case it can do without knowing the slee=
p length
> > + * at all.  For this purpose, it counts CPU wakeup events and looks fo=
r an idle
> > + * state whose terget residency has not exceeded the idle duration (me=
asured
>
> s/terget/target
>
> > + * after wakeup) in the majority of relevant recent cases.  If the tar=
get
> > + * residency of that state is small enough, it may be used right away =
and the
> > + * sleep length need not be determined.
> >   *
> >   * The computations carried out by this governor are based on using bi=
ns whose
> >   * boundaries are aligned with the target residency parameter values o=
f the CPU
> > @@ -39,7 +41,11 @@
> >   * idle state 2, the third bin spans from the target residency of idle=
 state 2
> >   * up to, but not including, the target residency of idle state 3 and =
so on.
> >   * The last bin spans from the target residency of the deepest idle st=
ate
> > - * supplied by the driver to infinity.
> > + * supplied by the driver to the scheduler tick period length or to in=
finity if
> > + * the tick period length is less than the targer residency of that st=
ate.  In
>
> s/targer/target

Will fix it when applying.

> > + * the latter case, the governor also counts events with the measured =
idle
> > + * duration between the tick period length and the target residency of=
 the
> > + * deepest idle state.
> >   *
> >   * Two metrics called "hits" and "intercepts" are associated with each=
 bin.
> >   * They are updated every time before selecting an idle state for the =
given CPU
> > @@ -49,47 +55,46 @@
> >   * sleep length and the idle duration measured after CPU wakeup fall i=
nto the
> >   * same bin (that is, the CPU appears to wake up "on time" relative to=
 the sleep
> >   * length).  In turn, the "intercepts" metric reflects the relative fr=
equency of
> > - * situations in which the measured idle duration is so much shorter t=
han the
> > - * sleep length that the bin it falls into corresponds to an idle stat=
e
> > - * shallower than the one whose bin is fallen into by the sleep length=
 (these
> > - * situations are referred to as "intercepts" below).
> > + * non-timer wakeup events for which the measured idle duration falls =
into a bin
> > + * that corresponds to an idle state shallower than the one whose bin =
is fallen
> > + * into by the sleep length (these events are also referred to as "int=
ercepts"
> > + * below).
> >   *
> >   * In order to select an idle state for a CPU, the governor takes the =
following
> >   * steps (modulo the possible latency constraint that must be taken in=
to account
> >   * too):
> >   *
> > - * 1. Find the deepest CPU idle state whose target residency does not =
exceed
> > - *    the current sleep length (the candidate idle state) and compute =
2 sums as
> > - *    follows:
> > - *
> > - *    - The sum of the "hits" and "intercepts" metrics for the candida=
te state
> > - *      and all of the deeper idle states (it represents the cases in =
which the
> > - *      CPU was idle long enough to avoid being intercepted if the sle=
ep length
> > - *      had been equal to the current one).
> > - *
> > - *    - The sum of the "intercepts" metrics for all of the idle states=
 shallower
> > - *      than the candidate one (it represents the cases in which the C=
PU was not
> > - *      idle long enough to avoid being intercepted if the sleep lengt=
h had been
> > - *      equal to the current one).
> > + * 1. Find the deepest enabled CPU idle state (the candidate idle stat=
e) and
> > + *    compute 2 sums as follows:
> >   *
> > - * 2. If the second sum is greater than the first one the CPU is likel=
y to wake
> > - *    up early, so look for an alternative idle state to select.
> > + *    - The sum of the "hits" metric for all of the idle states shallo=
wer than
> > + *      the candidate one (it represents the cases in which the CPU wa=
s likely
> > + *      woken up by a timer).
> > + *
> > + *    - The sum of the "intercepts" metric for all of the idle states =
shallower
> > + *      than the candidate one (it represents the cases in which the C=
PU was
> > + *      likely woken up by a non-timer wakeup source).
> > + *
> > + * 2. If the second sum computed in step 1 is greater than a half of t=
he sum of
> > + *    both mertics for the candidate state bin and all subsequent bins=
(if any),
>
> s/mertics/metrics

Ditto.

> > + *    a shallower idle state is likely to be more suitable, so look fo=
r it.
> >   *
> > - *    - Traverse the idle states shallower than the candidate one in t=
he
> > + *    - Traverse the enabled idle states shallower than the candidate =
one in the
> >   *      descending order.
> >   *
> >   *    - For each of them compute the sum of the "intercepts" metrics o=
ver all
> >   *      of the idle states between it and the candidate one (including=
 the
> >   *      former and excluding the latter).
> >   *
> > - *    - If each of these sums that needs to be taken into account (bec=
ause the
> > - *      check related to it has indicated that the CPU is likely to wa=
ke up
> > - *      early) is greater than a half of the corresponding sum compute=
d in step
> > - *      1 (which means that the target residency of the state in quest=
ion had
> > - *      not exceeded the idle duration in over a half of the relevant =
cases),
> > - *      select the given idle state instead of the candidate one.
> > + *    - If this sum is greater than a half of the second sum computed =
in step 1,
> > + *      use the given idle state as the new candidate one.
> >   *
> > - * 3. By default, select the candidate state.
> > + * 3. If the current candidate state is state 0 or its target residenc=
y is short
> > + *    enough, return it and prevent the scheduler tick from being stop=
ped.
> > + *
> > + * 4. Obtain the sleep length value and check if it is below the targe=
t
> > + *    residency of the current candidate state, in which case a new sh=
allower
> > + *    candidate state needs to be found, so look for it.
> >   */
>
> Description seems to parse in my brain FWIW.
> Thanks for cleaning that up, clearly I've overlooked that doc.
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks!

