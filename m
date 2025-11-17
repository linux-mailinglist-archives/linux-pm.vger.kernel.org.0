Return-Path: <linux-pm+bounces-38108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A9C626EC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 06:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C403357262
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59230F7EE;
	Mon, 17 Nov 2025 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j8duK+GJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8471DF73A
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763358281; cv=none; b=ieosIk9FswUnK2n6cyFK73Db9EYFx5TXkiOQqZBciaONjCJCBJ/jvc1dDF3GjIT+3aIPghFk13h092ycWor9KqbATwR8tHykaDoqwG3WTqwP7l7epVhStrqVvV3aDfYFiXZaRWdfI8gmZNky0w68x8WLI/6YZ9YmacHn836LUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763358281; c=relaxed/simple;
	bh=Y43RGiOmDIMhJlbYEbMcnt/DiTUuG4AK/tYeZ/2z0Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1uPSXL1ywycAtFr1FCGhM21yEKN8yrPxCqBgGPhfTnyyWd5AqGgQtwOmh83VoGclFmK02A7lZjygyEM1FvlDj3yjoIB/WZTTvwSzQRYhpOCOwC7SiJ4D0GhvwYLDRsCYhFl41qC7fIkGVKpYj03cQd3QjLv2QQlkY0JKwgF8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j8duK+GJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b736ffc531fso405831166b.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 21:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763358278; x=1763963078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZStLYBQoBKBVX3jBIh82VJpVFa+oTLc4CDQAVUvxT8=;
        b=j8duK+GJmcgomOU0vtH9D99HCPor7IjIDLDEf+DhCwSY9GX1z5jgynOhCgBM4Ll84U
         gdX3aTu08H8vB0FE2BMVibvGqfpsWrrDm4ENhnyxFHZcckZKCH4bZUgSqjixLpluMcpY
         +zOi8bawe+nInR3pLd8KTb6lS9YmwtkBSdJZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763358278; x=1763963078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fZStLYBQoBKBVX3jBIh82VJpVFa+oTLc4CDQAVUvxT8=;
        b=n2+NMXsXM2kdu92OPHA6BegWyE3iSHlmlQ6tqi8JQDLq+1XmTyAwv8u0vdiRptzFtk
         NeQo1CIIUBQoTgBj8dzPwY323uj3vg0vnDWTrHLWTpfTqdEjPBZClYgXD/hhZaEv88xA
         XyrUbR7ZFvcxwh5MTF+pnpmtFhpAhbI2EdSY0gy0DJ2DBH1kuCzL6GHdje6fsib2z4c9
         ZBERoNANMC+P0qZwANyHZw5kB5dvfy5CFgDOtRKJU8gBOYWPY/6hmHiO6FDW3I1AM8EB
         xGIgngSYwLDmrzSeQAqqz32rJ5GdZS0UDX8ORrLtcP0vxdJ8IKerGbayLSczsnwuUvzS
         NpHg==
X-Forwarded-Encrypted: i=1; AJvYcCULH3aXZyFiP7hwkgTJeQ2ZdNPhCvAhlbaJzMCovDJobBx68GlllflXa5Oq0h1NtdVzufAh5xwcyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRSiLNOceIkm9PijNitWp+QX/nbgtZtqQmOpzMDlbcYsX0bp3
	SWTS78A9sT+SRmmnYI2I6s/UtteKrEA4xb4z3wkGNgsMrWoHTRQMzBp44VqpigNLgw4BnO1+CiC
	oRquMwHqH6MUlTISC4Nczy+NNsUfiLbuZi0JWDeNp
X-Gm-Gg: ASbGnctDqAbmyPe1p8DcefK9B1ijVj2sdBKuP6RJVpH4jDPoPyROiamzfpRGZ70krPA
	ljIp3grg5/BiY4QWL8O1mq6qnUkMAi3aBMMbS0SkO6N6/17+S1Ol3OvrA7BPgfgGJYfA7olGj0w
	Tsb323l3/jWPqwg4U+tTP/LKWAzF1YLgL/afjNVwHPPpy+xQ+6PEPEQPLxmiNVlBQTDUz9PGAq5
	YjLi92crZq979v16b0NDJk9qIieCtDKq8Lfe7tx6atWd8QcawfGp9TJnPJT8VCW3htJszBGAUAX
	BE3qm4zoVY219K2vpa9hVhUSwg==
X-Google-Smtp-Source: AGHT+IFz1jRChpTSf2+2XCD1wdN8ip+629Z7gRaPfmgl/9RjQrOTDsJxNB2vIwYuzLjAI/hlu667wJVCs+sNHOE3esg=
X-Received: by 2002:a17:907:60d4:b0:b47:2be3:bc75 with SMTP id
 a640c23a62f3a-b736796a625mr1072825966b.60.1763358278016; Sun, 16 Nov 2025
 21:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com> <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
 <6228387.lOV4Wx5bFT@rafael.j.wysocki> <CAEmPcwsVfcoFTyS-mHSkZTFmS8Y1vkFToYo1xcAH0522wyDawA@mail.gmail.com>
 <431db236-736d-4fc3-95c2-876bc767aa0c@arm.com> <CAJZ5v0huP6hjDzJ9HoAmUVaS1ss2g0baMROiAz9cqkgmOn1kHQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0huP6hjDzJ9HoAmUVaS1ss2g0baMROiAz9cqkgmOn1kHQ@mail.gmail.com>
From: Reka Norman <rekanorman@chromium.org>
Date: Mon, 17 Nov 2025 16:44:26 +1100
X-Gm-Features: AWmQ_blWrAX2N-GqiWukRzHg_9B18ahCLivnt7wzmvy-Dg-ZDEFXG9VEes8kBPM
Message-ID: <CAEmPcwtNu6w8L1+xa5+2zWx+Fk3cAZ_1PxOZVUf-ZXWht22cCA@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, daniel.lezcano@linaro.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 1:16=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Nov 14, 2025 at 9:33=E2=80=AFAM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 11/14/25 04:05, Reka Norman wrote:
> > > On Fri, Nov 14, 2025 at 3:56=E2=80=AFAM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > >>
> > >> On Thursday, November 13, 2025 4:43:18 PM CET Christian Loehle wrote=
:
> > >>> On 11/12/25 18:33, Christian Loehle wrote:
> > >>>> On 11/12/25 14:16, Rafael J. Wysocki wrote:
> > >>>>> On Wed, Nov 12, 2025 at 3:03=E2=80=AFPM Christian Loehle
> > >>>>> <christian.loehle@arm.com> wrote:
> > >>>>>>
> > >>>>>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
> > >>>>>>> On Tue, Nov 11, 2025 at 6:20=E2=80=AFPM Christian Loehle
> > >>>>>>> <christian.loehle@arm.com> wrote:
> > >>>>>>>>
> > >>>>>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
> > >>>>>>>>> On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> > >>>>>>>>> <christian.loehle@arm.com> wrote:
> > >>>>>>>>>>
> > >>>>>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
> > >>>>>>>
> > >>>>>>> [...]
> > >>>>>>>
> > >>>>>>>>>>> I see two issues:
> > >>>>>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I gues=
s this wouldn't really be an issue without 2))
> > >>>>>>>>>
> > >>>>>>>>> This shouldn't be a problem.
> > >>>>>>>>
> > >>>>>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't t=
he case $subject would've likely
> > >>>>>>>> never been an issue.
> > >>>>>>>
> > >>>>>>> Well, I think that the leftovers can be cleared when they becom=
e less than 8.
> > >>>>>>>
> > >>>>>>>>>
> > >>>>>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_su=
m) isn't an appropriate check, it will
> > >>>>>>>>>>> exclude the state if it its idx_hit_sum make up the vast ma=
jority of cpu_data->total (i.e. it would
> > >>>>>>>>>>> have been a really good candidate actually).
> > >>>>>>>>>
> > >>>>>>>>> Well, it would exclude the state if the sum of hits for the s=
tates
> > >>>>>>>>> below it is large enough.  This is questionable (because why =
would
> > >>>>>>>>> hits matter here), but I attempted to make the change below a=
nd
> > >>>>>>>>> somebody reported a regression IIRC.
> > >>>>>>>>>
> > >>>>>>>>> This check is related to the problem at hand though (see belo=
w).
> > >>>>>>>>>
> > >>>>>>>>>>>
> > >>>>>>>>>>> I lightly tested the below, it seems to be at least compara=
ble to mainline teo.
> > >>>>>>>>>>> (the documentation/comments would need adapting too, of cou=
rse)
> > >>>>>>>>>>>
> > >>>>>>>>>>> -----8<-----
> > >>>>>>>>>>>
> > >>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpui=
dle/governors/teo.c
> > >>>>>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
> > >>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> > >>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> > >>>>>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_dr=
iver *drv, struct cpuidle_device *dev,
> > >>>>>>>>>>>          * all of the deeper states, a shallower idle state=
 is likely to be a
> > >>>>>>>>>>>          * better choice.
> > >>>>>>>>>>>          */
> > >>>>>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_h=
it_sum) {
> > >>>>>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> > >>>>>>>>>>>                 int first_suitable_idx =3D idx;
> > >>>>>>>>>>>
> > >>>>>>>>>>>                 /*
> > >>>>>>>>>>>
> > >>>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of=
 0...idx-1.
> > >>>>>>>>>> Maybe something like this, again lightly tested:
> > >>>>>>>>>>
> > >>>>>>>>>> -----8<-----
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuid=
le/governors/teo.c
> > >>>>>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
> > >>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> > >>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> > >>>>>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_d=
river *drv, struct cpuidle_device *dev,
> > >>>>>>>>>>                  * has been stopped already into account.
> > >>>>>>>>>>                  */
> > >>>>>>>>>>                 intercept_sum =3D 0;
> > >>>>>>>>>> +               hit_sum =3D 0;
> > >>>>>>>>>>
> > >>>>>>>>>>                 for (i =3D idx - 1; i >=3D 0; i--) {
> > >>>>>>>>>>                         struct teo_bin *bin =3D &cpu_data->s=
tate_bins[i];
> > >>>>>>>>>>
> > >>>>>>>>>>                         intercept_sum +=3D bin->intercepts;
> > >>>>>>>>>> +                       hit_sum +=3D bin->hits;
> > >>>>>>>>>>
> > >>>>>>>>>> -                       if (2 * intercept_sum > idx_intercep=
t_sum) {
> > >>>>>>>>>> +                       if (2 * intercept_sum > cpu_data->to=
tal || 2 * hit_sum > cpu_data->total) {
> > >>>>>>>>>>                                 /*
> > >>>>>>>>>>                                  * Use the current state unl=
ess it is too
> > >>>>>>>>>>                                  * shallow or disabled, in w=
hich case take the
> > >>>>>>>>>
> > >>>>>>>>> This will only matter after the deepest state has been reject=
ed
> > >>>>>>>>> already and on the system in question this means selecting st=
ate 0 no
> > >>>>>>>>> matter what.
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> Ah, right!
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>> The pre-6.12 behavior can be explained if tick wakeups are ta=
ken into account.
> > >>>>>>>>>
> > >>>>>>>>> Namely, when state 0 is chosen (because of the check mentione=
d above),
> > >>>>>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  I=
f the
> > >>>>>>>>> subsequent wakeup is a tick one, it will be counted as a hit =
on the
> > >>>>>>>>> deepest state (and it will contribute to the total sum in the=
 check
> > >>>>>>>>> mentioned above).  Then, at one point, cpu_data->total will b=
e large
> > >>>>>>>>> enough and the deepest state will become the candidate one.  =
If
> > >>>>>>>>> tick_nohz_get_sleep_length() returns a large value at that po=
int, the
> > >>>>>>>>> tick will be stopped and the deepest state will be entered.  =
Nirvana
> > >>>>>>>>> ensues.
> > >>>>>>>>
> > >>>>>>>> So fundamentally we will have to count tick-wakeups as a) noth=
ing, which
> > >>>>>>>> doesn't allow us to ever break out of the intercept logic that=
 caused us
> > >>>>>>>> to leave the tick on b) intercepts, which is bonkers and doesn=
't allow us
> > >>>>>>>> to ever break out and c) hits =3D=3D sleep_length would've bee=
n accurate.
> > >>>>>>>> Of course counting a tick wakeup as a hit for sleep_length neg=
ates the
> > >>>>>>>> intercept logic.
> > >>>>>>>
> > >>>>>>> Not quite.  The intercept logic is there for wakeups other than=
 tick
> > >>>>>>> wakeups and timer wakeups.
> > >>>>>>>
> > >>>>>>> I actually think that tick wakeups can be counted as hits on th=
e
> > >>>>>>> deepest available state - maybe only when tick wakeups dominate=
 the
> > >>>>>>> wakeup pattern - but generally this is not unreasonable: When t=
he
> > >>>>>>> wakeup pattern is dominated by tick wakeups, this by itself is =
a good
> > >>>>>>> enough reason to stop the tick.
> > >>>>>>
> > >>>>>> (assuming HZ=3D1000 below but it doesn't matter)
> > >>>>>> That will exclude any 'intercept' logic from having much effect =
if the
> > >>>>>> avg idle duration is >TICK_NSEC/2, which is potentially still qu=
ite a bit
> > >>>>>> off from state1 residency, like in Reka's case here.
> > >>>>>> That's why I thought it would cause unreasonable regressions her=
e.
> > >>>>>> I'll give it a go as well though!
> > >>>>>
> > >>>>> Thanks!
> > >>>>>
> > >>>>> Note that I'd prefer to add a check if tick wakeups dominate the
> > >>>>> wakeup pattern before setting sleep_length_ns to KTIME_MAX though=
.
> > >>>>> I'd first like to know how the Reka's system reacts to the more
> > >>>>> drastic variant of this change.
> > >>>>
> > >>>> Below are my usual tests, it's definitely visible but the impact i=
s limited
> > >>>> on this platform anyway. I think if we gate the KTIME_MAX setting =
behind
> > >>>> the "tick wakeup dominate" it should be acceptable!
> > >>>> Let's see what Reka reports.
> > >>>>
> > >>> Forgot to post the full results, anyway as expected with mtdblock (=
a very slow
> > >>> / low frequent wakeup scenario) the impact becomes clearly visible.
> > >>> Still hopeful that the more conservative approach will be acceptabl=
e!
> > >>
> > >> Speaking of which, the patch to test is appended below, but it doesn=
't apply
> > >> directly on top of the mainline.  It is based on some other patches =
that have
> > >> been posted recently, so here's a git branch with all of the requisi=
te
> > >> material:
> > >>
> > >> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cp=
uidle-teo-testing
> > >>
> > >> Reka, please try this one and let us know how it goes.
> > >
> > > Results attached. The residencies are a bit less deep than before -
> > > about 4.5% in WFI vs 2% at 6.6 or with the more aggressive patch. But
> > > I=E2=80=99m guessing that=E2=80=99s expected.
> > >
> > > I also measured the power on a slightly different system where I firs=
t
> > > noticed this regression, and it=E2=80=99s indistinguishable from 6.6.=
 So from
> > > my side this looks great, thank you!
> >
> > Good news!
>
> So I'm going to queue this up for 6.19 along with the material it depends=
 on.
>
> I'd rather not rush it into 6.18-rc7 because it would not get
> meaningful exposure in linux-next before appearing in the mainline in
> that case.
>
> Reka, I'm going to add your Tested-by: to it, please let me know if
> there are any concerns regarding that.

No concerns, thank you.

And thanks a lot to both of you for the quick investigation and fix,
it=E2=80=99s really appreciated!

