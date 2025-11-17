Return-Path: <linux-pm+bounces-38104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD5C62600
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 06:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1044D24132
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 05:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4930E0F4;
	Mon, 17 Nov 2025 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cjamOM8N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED030E84A
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763356512; cv=none; b=qtR/BYmnCfAsRRzBNXPiB2K22fk9IlLQ8sCbJ5OUD/IAiSvhATCHSzulZyQ/fgCfLeO2Vz7sJkbVuTpja2CB+LxLORhklPhKcHTS9beKVBScfR1yqdYqtJczn2q0dcTxvuDwq4Uygw5C55cCm19olj5gKVoAeLq2jT/nPoVcHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763356512; c=relaxed/simple;
	bh=pErQ4ukqR9I38weKlmWW7wLSLeQs0OJiDOZFRRHRi7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJKFfGkr0jpNGWUgQgvPwq45QnRMEkY54ZcUU9+TBmCiC+gIhUd/roj9RptrwyOL0811mHuhC/AqA5zMjgEGjZXrW62JArbAwuXLIwHealrGCpgYWdb3NA9Q3NvQoFMVRJGu73NNLPZpd0Cjq3+S2Vi9dZwrIZ55VhQlDyMl2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cjamOM8N; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7291af7190so553826266b.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 21:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763356507; x=1763961307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AH6I7AqXCYiAtv3G9DF93VFse56LmS/de8Qvwj2YV0=;
        b=cjamOM8NJtzJqyxpRfeeLUi3cGPP8ax7ctZDlwBol+dwG9U5eP86ouX6oLkGahJ5O/
         Iu5bn6pA86hfsjT5n7uFSGo0mGu+AvuqCXbUMFzq18/lbG3PQItggNCBPgx34+o+ILr3
         /8ujxjje2hkR5MYhW9cW9dB6nzpKJ1bijlZrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763356507; x=1763961307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5AH6I7AqXCYiAtv3G9DF93VFse56LmS/de8Qvwj2YV0=;
        b=k+UHgE/4F1LPjD5Ipofr4dWQ/PbAqLaB6BnmoSnnx48BuBgcXv8Sln4tk22ZRY8u6g
         K3KFm9Bh+m8vIOcEGs8iBPOGvrV5gXylK0ppo3dcF5uJla/5SuFAjPh03M+LWSTKaCsT
         WEE7mteIv6NCC2ZfKitJcc17AKvI/tlcs+8MQ9AtnmKHmRbw/BJd0cSY3wjUwa+PBODw
         SzACPyzhBS8/+VfAWNIB5TzQggo/OQB2mCpyT2hCGvmObTrPmsXmD+n1f/hMXbiCZPPd
         6SrP/8vZYmUbUBkPIqAaFOUURVh0P6Rw4CbgWkb48mEn9Z4QW1dmpBg3z1mWwA+9Y4sy
         wnOw==
X-Forwarded-Encrypted: i=1; AJvYcCWyGs9qL5L9VNXJSEYR0zegTls4ddna8urLP4t4mZnAe52VbhTKCgYNlhdsrwk1Wl7Zi7ExwuNj7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuWKihNY+LY0CgiPjHaFoUZsUvU00QBPPZr7kUewiK88IpIFC
	OyC8w22SBA6OWMGnyjmP2hK1fQoU/Sl9HUcGATJaBmP6VRxMMiXmh5eZaqE41n9E62AhIzTn9sN
	ujIDNmEvBxWcAuR8jmWnR6wZL6EXLcwJOW0fB9VyM9wXh5BJFfdCMDHaW
X-Gm-Gg: ASbGncton5yma7lAR3UN0Tv8WrmMua/NrQgB+JrDykGjRQv5NZ2MMYos2oHCkX+iSpJ
	fyX/SEvzOAtEyTq2IfVbSe4apZHhnH6V8LcVAEkTdDUhPaExIGa0EwjctKwv+a246cHoTDkF0TC
	+8AA8YTVwgI0KpgjhQzXjGRqFNnBXK11XVmYC23Peqa6DjHEPw0cjHZf1Z+1MKl4qZ+KDqa6xSx
	I3HmReF6wEPlxSXGLJcB/o+r/qTGMnWb+XCnlh8j8xsy6o0Rh6S3OYWb9zweuSyiijsPNCZiir4
	5BYWwovPe+tuDZY7IzGymyQmXth4XmaXVy/watbcG+U+ayM=
X-Google-Smtp-Source: AGHT+IGJL+rY/AuKcEmcooy7I0wLJJ2vdXADGE77+ubUMvYrGkjYRJoNczpIFz+cEjFQc6CsRJNmx11+iCamKpdi5wk=
X-Received: by 2002:a17:906:ee89:b0:b43:b7ec:b8a1 with SMTP id
 a640c23a62f3a-b736780de83mr1136738166b.24.1763356507000; Sun, 16 Nov 2025
 21:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com> <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
 <6228387.lOV4Wx5bFT@rafael.j.wysocki> <CAEmPcwsVfcoFTyS-mHSkZTFmS8Y1vkFToYo1xcAH0522wyDawA@mail.gmail.com>
 <431db236-736d-4fc3-95c2-876bc767aa0c@arm.com>
In-Reply-To: <431db236-736d-4fc3-95c2-876bc767aa0c@arm.com>
From: Reka Norman <rekanorman@chromium.org>
Date: Mon, 17 Nov 2025 16:14:55 +1100
X-Gm-Features: AWmQ_bkIhYtdwC3e6x43aQ-_Nwent2Gf-6HGPcqjn3oSckAZ5RGLkZdDYNo8VHA
Message-ID: <CAEmPcwsQjHsqmvaWA_6ORCQnJdWutDmu=KZSrn=nKJhirX7H3Q@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 7:33=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/14/25 04:05, Reka Norman wrote:
> > On Fri, Nov 14, 2025 at 3:56=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >>
> >> On Thursday, November 13, 2025 4:43:18 PM CET Christian Loehle wrote:
> >>> On 11/12/25 18:33, Christian Loehle wrote:
> >>>> On 11/12/25 14:16, Rafael J. Wysocki wrote:
> >>>>> On Wed, Nov 12, 2025 at 3:03=E2=80=AFPM Christian Loehle
> >>>>> <christian.loehle@arm.com> wrote:
> >>>>>>
> >>>>>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
> >>>>>>> On Tue, Nov 11, 2025 at 6:20=E2=80=AFPM Christian Loehle
> >>>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>>
> >>>>>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
> >>>>>>>>> On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> >>>>>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>>>>>> I see two issues:
> >>>>>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess =
this wouldn't really be an issue without 2))
> >>>>>>>>>
> >>>>>>>>> This shouldn't be a problem.
> >>>>>>>>
> >>>>>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't the=
 case $subject would've likely
> >>>>>>>> never been an issue.
> >>>>>>>
> >>>>>>> Well, I think that the leftovers can be cleared when they become =
less than 8.
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum)=
 isn't an appropriate check, it will
> >>>>>>>>>>> exclude the state if it its idx_hit_sum make up the vast majo=
rity of cpu_data->total (i.e. it would
> >>>>>>>>>>> have been a really good candidate actually).
> >>>>>>>>>
> >>>>>>>>> Well, it would exclude the state if the sum of hits for the sta=
tes
> >>>>>>>>> below it is large enough.  This is questionable (because why wo=
uld
> >>>>>>>>> hits matter here), but I attempted to make the change below and
> >>>>>>>>> somebody reported a regression IIRC.
> >>>>>>>>>
> >>>>>>>>> This check is related to the problem at hand though (see below)=
.
> >>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> I lightly tested the below, it seems to be at least comparabl=
e to mainline teo.
> >>>>>>>>>>> (the documentation/comments would need adapting too, of cours=
e)
> >>>>>>>>>>>
> >>>>>>>>>>> -----8<-----
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidl=
e/governors/teo.c
> >>>>>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
> >>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driv=
er *drv, struct cpuidle_device *dev,
> >>>>>>>>>>>          * all of the deeper states, a shallower idle state i=
s likely to be a
> >>>>>>>>>>>          * better choice.
> >>>>>>>>>>>          */
> >>>>>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit=
_sum) {
> >>>>>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >>>>>>>>>>>                 int first_suitable_idx =3D idx;
> >>>>>>>>>>>
> >>>>>>>>>>>                 /*
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0=
...idx-1.
> >>>>>>>>>> Maybe something like this, again lightly tested:
> >>>>>>>>>>
> >>>>>>>>>> -----8<-----
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle=
/governors/teo.c
> >>>>>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
> >>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_dri=
ver *drv, struct cpuidle_device *dev,
> >>>>>>>>>>                  * has been stopped already into account.
> >>>>>>>>>>                  */
> >>>>>>>>>>                 intercept_sum =3D 0;
> >>>>>>>>>> +               hit_sum =3D 0;
> >>>>>>>>>>
> >>>>>>>>>>                 for (i =3D idx - 1; i >=3D 0; i--) {
> >>>>>>>>>>                         struct teo_bin *bin =3D &cpu_data->sta=
te_bins[i];
> >>>>>>>>>>
> >>>>>>>>>>                         intercept_sum +=3D bin->intercepts;
> >>>>>>>>>> +                       hit_sum +=3D bin->hits;
> >>>>>>>>>>
> >>>>>>>>>> -                       if (2 * intercept_sum > idx_intercept_=
sum) {
> >>>>>>>>>> +                       if (2 * intercept_sum > cpu_data->tota=
l || 2 * hit_sum > cpu_data->total) {
> >>>>>>>>>>                                 /*
> >>>>>>>>>>                                  * Use the current state unles=
s it is too
> >>>>>>>>>>                                  * shallow or disabled, in whi=
ch case take the
> >>>>>>>>>
> >>>>>>>>> This will only matter after the deepest state has been rejected
> >>>>>>>>> already and on the system in question this means selecting stat=
e 0 no
> >>>>>>>>> matter what.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Ah, right!
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> The pre-6.12 behavior can be explained if tick wakeups are take=
n into account.
> >>>>>>>>>
> >>>>>>>>> Namely, when state 0 is chosen (because of the check mentioned =
above),
> >>>>>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  If =
the
> >>>>>>>>> subsequent wakeup is a tick one, it will be counted as a hit on=
 the
> >>>>>>>>> deepest state (and it will contribute to the total sum in the c=
heck
> >>>>>>>>> mentioned above).  Then, at one point, cpu_data->total will be =
large
> >>>>>>>>> enough and the deepest state will become the candidate one.  If
> >>>>>>>>> tick_nohz_get_sleep_length() returns a large value at that poin=
t, the
> >>>>>>>>> tick will be stopped and the deepest state will be entered.  Ni=
rvana
> >>>>>>>>> ensues.
> >>>>>>>>
> >>>>>>>> So fundamentally we will have to count tick-wakeups as a) nothin=
g, which
> >>>>>>>> doesn't allow us to ever break out of the intercept logic that c=
aused us
> >>>>>>>> to leave the tick on b) intercepts, which is bonkers and doesn't=
 allow us
> >>>>>>>> to ever break out and c) hits =3D=3D sleep_length would've been =
accurate.
> >>>>>>>> Of course counting a tick wakeup as a hit for sleep_length negat=
es the
> >>>>>>>> intercept logic.
> >>>>>>>
> >>>>>>> Not quite.  The intercept logic is there for wakeups other than t=
ick
> >>>>>>> wakeups and timer wakeups.
> >>>>>>>
> >>>>>>> I actually think that tick wakeups can be counted as hits on the
> >>>>>>> deepest available state - maybe only when tick wakeups dominate t=
he
> >>>>>>> wakeup pattern - but generally this is not unreasonable: When the
> >>>>>>> wakeup pattern is dominated by tick wakeups, this by itself is a =
good
> >>>>>>> enough reason to stop the tick.
> >>>>>>
> >>>>>> (assuming HZ=3D1000 below but it doesn't matter)
> >>>>>> That will exclude any 'intercept' logic from having much effect if=
 the
> >>>>>> avg idle duration is >TICK_NSEC/2, which is potentially still quit=
e a bit
> >>>>>> off from state1 residency, like in Reka's case here.
> >>>>>> That's why I thought it would cause unreasonable regressions here.
> >>>>>> I'll give it a go as well though!
> >>>>>
> >>>>> Thanks!
> >>>>>
> >>>>> Note that I'd prefer to add a check if tick wakeups dominate the
> >>>>> wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
> >>>>> I'd first like to know how the Reka's system reacts to the more
> >>>>> drastic variant of this change.
> >>>>
> >>>> Below are my usual tests, it's definitely visible but the impact is =
limited
> >>>> on this platform anyway. I think if we gate the KTIME_MAX setting be=
hind
> >>>> the "tick wakeup dominate" it should be acceptable!
> >>>> Let's see what Reka reports.
> >>>>
> >>> Forgot to post the full results, anyway as expected with mtdblock (a =
very slow
> >>> / low frequent wakeup scenario) the impact becomes clearly visible.
> >>> Still hopeful that the more conservative approach will be acceptable!
> >>
> >> Speaking of which, the patch to test is appended below, but it doesn't=
 apply
> >> directly on top of the mainline.  It is based on some other patches th=
at have
> >> been posted recently, so here's a git branch with all of the requisite
> >> material:
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpui=
dle-teo-testing
> >>
> >> Reka, please try this one and let us know how it goes.
> >
> > Results attached. The residencies are a bit less deep than before -
> > about 4.5% in WFI vs 2% at 6.6 or with the more aggressive patch. But
> > I=E2=80=99m guessing that=E2=80=99s expected.
> >
> > I also measured the power on a slightly different system where I first
> > noticed this regression, and it=E2=80=99s indistinguishable from 6.6. S=
o from
> > my side this looks great, thank you!
>
> Good news!
> For completeness:
>
> Per-Cluster deltas: BIG
>
> +---------+-------+--------------+------------+---------+--------+-------=
-+---------+--------+---------+
> | cluster | state | name         | time=CE=94      | time%   | usage=CE=
=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | BIG     |     0 | WFI          | 957,853    |   2.99% | 2,537  | 0     =
 |   0.00% | 0      |   0.00% |
> | BIG     |     1 | cpuoff-b     | 163,636    |   0.51% | 21     | 18    =
 |  85.71% | 3      |  14.29% |
> | BIG     |     2 | clusteroff-b | 30,918,285 |  96.50% | 501    | 128   =
 |  25.55% | 0      |   0.00% |
> | BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0     =
 |   0.00% | 0      |   0.00% |
> | BIG     | TOTAL |              | 32,039,774 | 100.00% | 3,059  | 146   =
 |   4.77% | 3      |   0.10% |
> +---------+-------+--------------+------------+---------+--------+-------=
-+---------+--------+---------+
>
> Per-Cluster deltas: LITTLE
>
> +---------+-------+--------------+-------------+---------+--------+------=
--+---------+--------+---------+
> | cluster | state | name         | time=CE=94       | time%   | usage=CE=
=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | LITTLE  |     0 | WFI          | 8,424,141   |   6.63% | 16,629 | 0    =
  |   0.00% | 0      |   0.00% |
> | LITTLE  |     1 | cpuoff-l     | 11,121,561  |   8.75% | 485    | 96   =
  |  19.79% | 388    |  80.00% |
> | LITTLE  |     2 | clusteroff-l | 107,499,073 |  84.62% | 2,705  | 1,001=
  |  37.01% | 0      |   0.00% |
> | LITTLE  |     3 | s2idle       | 0           |   0.00% | 0      | 0    =
  |   0.00% | 0      |   0.00% |
> | LITTLE  | TOTAL |              | 127,044,775 | 100.00% | 19,819 | 1,097=
  |   5.54% | 388    |   1.96% |
> +---------+-------+--------------+-------------+---------+--------+------=
--+---------+--------+---------+
>
> Per-Cluster deltas: MID
>
> +---------+-------+--------------+------------+---------+--------+-------=
-+---------+--------+---------+
> | cluster | state | name         | time=CE=94      | time%   | usage=CE=
=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | MID     |     0 | WFI          | 2,593,501  |   2.72% | 7,278  | 0     =
 |   0.00% | 0      |   0.00% |
> | MID     |     1 | cpuoff-m     | 188,793    |   0.20% | 51     | 48    =
 |  94.12% | 3      |   5.88% |
> | MID     |     2 | clusteroff-m | 92,616,252 |  97.08% | 605    | 257   =
 |  42.48% | 0      |   0.00% |
> | MID     |     3 | s2idle       | 0          |   0.00% | 0      | 0     =
 |   0.00% | 0      |   0.00% |
> | MID     | TOTAL |              | 95,398,546 | 100.00% | 7,934  | 305   =
 |   3.84% | 3      |   0.04% |
> +---------+-------+--------------+------------+---------+--------+-------=
-+---------+--------+---------+
>
> Out of curiosity:
> Do you know if the platform respects cpuoff / clusteroff distinction
> properly? Is the power difference measurable?

No, I=E2=80=99m not really familiar with the details myself. I=E2=80=99ll c=
heck if
others know more. I did a quick test with disabling cpuoff on all
cores, then disabling clusteroff on all cores. The power does seem to
be slightly higher with clusteroff disabled, but the difference is
barely above the noise level so I=E2=80=99m not certain.

> There really is no reason for cpuidle to not autopromote them, if there's=
 no latency
> requirement that would prevent that.
> Especially for the big cluster (just one CPU).

For my understanding, could you explain a bit more what you mean? It=E2=80=
=99s
already spending a lot less time in cpuoff than clusteroff. Would you
expect to see even less time in cpuoff (and 0 for the big core)?

