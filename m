Return-Path: <linux-pm+bounces-37831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE32DC52BE2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 15:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0A250415C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB933343F;
	Wed, 12 Nov 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPRYvYDp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294C2900A8
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957443; cv=none; b=lALy6wCHXwF1I36sPP/pyLOZBeFkZXH1+FoIcIB7sv9TMeOh4YkmqynAMhlMtaE2pDZLqyDi0IS8/uyBHGxMdjsUD1JbyieZA+473jICa0jkserehndWYm/uGGIqyKkxGhqCqBQpiT9OGiUDDxaD7kJSGtiGVOMqYy5K0/pbmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957443; c=relaxed/simple;
	bh=brvLxqCTWTsAgpFF3pY7jqePREJtJW9N1OQ+yNuxzz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajKt1mp78xmqJ7KP7TKYBFfQ0O62eon8FHdj81Q5Bo02JP/rwxs7f5HblahrQa8XWmtLppRp/ysBxLMX3J+PHOfWdTlREHAWdK9B8bsyDNmRbLzWUPYoGRcPGq3EAWcK7NSczq1pmBSndXwbXKvFVQYmHqAeh8o5Xoi502QF8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPRYvYDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2646EC4CEF1
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957443;
	bh=brvLxqCTWTsAgpFF3pY7jqePREJtJW9N1OQ+yNuxzz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QPRYvYDpsdFZjs/fjgUDZ8dUH1rCm3PcW1UTpaz+s4zZPT1X/8jhfVJbQ0Me3xhTF
	 NuSK9pL/AwuaBam5fQMUGsc/gwC7QjyDWM8Xr17pxADBQ/RPkaS1Flm9aNGwtboAyT
	 uMvVuE8aZ7IwxPZtOdSxqi7eFa/Z8LFA2SQgthliQP8sNhYmSNHYtXmjCpSeB2ebA0
	 MJ44e4oobu6vrm34EFF2A9klKd8bNBLZnTG1eaNSIK2oGtumr4gf5heAv/YCd36jkr
	 kTDytsitxQLRYkXhyC4+DLtrQRvtt4COcTOk4p1+bcEvEvO63pZeJImwZUi1KPejy9
	 beqxnYb2Zt11w==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74526ca79beso646503a34.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 06:24:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWt+5ZvjgiW+9F3YFbjMwWGUI/s9UH+ik0on5V+2RiTJkvGo+4BKGR7ccT+DHu5cQMxltcJoJYK7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00jV4qsZILmZeow740SbzNab3Dx/6fX1nB2RQNWwkdDWLTzLZ
	oGINU2lnVLR/ICfYOFCKNjPkQjZwYKF47kSIxDd8wvX/grfYazGCLlViVsvqPKaZX82bECepOi7
	NqTaL3okTiOAClGwcwFs4xKOzSe4UxQw=
X-Google-Smtp-Source: AGHT+IF3twID3ZaFCIKsKnYgckAQyeGQ6mG/CP/99T7/bocUacuTXAslbNTZoCTZN+ukfwXHKnyOIzzRhn+H6pbtrSo=
X-Received: by 2002:a05:6808:181c:b0:44f:76aa:77d5 with SMTP id
 5614622812f47-45074427277mr1365638b6e.16.1762957442322; Wed, 12 Nov 2025
 06:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
 <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com> <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
 <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
 <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
 <f0a2492b-9cea-4450-88ca-be8f99f3e0fe@arm.com> <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
 <0c018867-c092-4f8e-8f7a-32bb02de3ad5@arm.com> <CAEmPcwuVPMONrDHcnxbWpoG5K5DFwf-u2i7wuOK4Q9HvF2uOhw@mail.gmail.com>
 <2a429c41-8624-408c-9db0-4450ab76e52f@arm.com> <a33965da-81d8-47c5-9fa0-434812f2bd72@arm.com>
 <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com>
 <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com> <bf42d9cf-9642-466e-9ac3-8396fd9b1942@arm.com>
 <CAJZ5v0gQSPqfuCz090bd0nT1G_+krsMOtfVAU3SENSm3NZp+qw@mail.gmail.com> <e57402db-e759-4ce6-a408-1d15fb5c1c05@arm.com>
In-Reply-To: <e57402db-e759-4ce6-a408-1d15fb5c1c05@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 15:23:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gaPKKaPh1gta4zuSmVVZk9Uzs3V-3jOEEo9-qu+Or5Zw@mail.gmail.com>
X-Gm-Features: AWmQ_bke-i4aPreLgU23PB91P2gWENNHCg1xRMxa26pJmfU0fQgM8omcYUsE6KA
Message-ID: <CAJZ5v0gaPKKaPh1gta4zuSmVVZk9Uzs3V-3jOEEo9-qu+Or5Zw@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Reka Norman <rekanorman@chromium.org>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:14=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/25 13:40, Rafael J. Wysocki wrote:
> > On Wed, Nov 12, 2025 at 10:51=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/11/25 17:20, Christian Loehle wrote:
> >>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
> >>>> On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> >>>> <christian.loehle@arm.com> wrote:
> >
> > [...]
> >
> >>>>>> I see two issues:
> >>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this =
wouldn't really be an issue without 2))
> >>>>
> >>>> This shouldn't be a problem.
> >>>
> >>> Agreed, it should be a non-issue. Nonetheless if this wasn't the case=
 $subject would've likely
> >>> never been an issue.
> >>>
> >>>>
> >>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn'=
t an appropriate check, it will
> >>>>>> exclude the state if it its idx_hit_sum make up the vast majority =
of cpu_data->total (i.e. it would
> >>>>>> have been a really good candidate actually).
> >>>>
> >>>> Well, it would exclude the state if the sum of hits for the states
> >>>> below it is large enough.  This is questionable (because why would
> >>>> hits matter here), but I attempted to make the change below and
> >>>> somebody reported a regression IIRC.
> >>>>
> >>>> This check is related to the problem at hand though (see below).
> >>>>
> >>>>>>
> >>>>>> I lightly tested the below, it seems to be at least comparable to =
mainline teo.
> >>>>>> (the documentation/comments would need adapting too, of course)
> >>>>>>
> >>>>>> -----8<-----
> >>>>>>
> >>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/gov=
ernors/teo.c
> >>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
> >>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *d=
rv, struct cpuidle_device *dev,
> >>>>>>          * all of the deeper states, a shallower idle state is lik=
ely to be a
> >>>>>>          * better choice.
> >>>>>>          */
> >>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum)=
 {
> >>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >>>>>>                 int first_suitable_idx =3D idx;
> >>>>>>
> >>>>>>                 /*
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...id=
x-1.
> >>>>> Maybe something like this, again lightly tested:
> >>>>>
> >>>>> -----8<-----
> >>>>>
> >>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/gove=
rnors/teo.c
> >>>>> index 173ddcac540a..6bfb9cedb75e 100644
> >>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *=
drv, struct cpuidle_device *dev,
> >>>>>                  * has been stopped already into account.
> >>>>>                  */
> >>>>>                 intercept_sum =3D 0;
> >>>>> +               hit_sum =3D 0;
> >>>>>
> >>>>>                 for (i =3D idx - 1; i >=3D 0; i--) {
> >>>>>                         struct teo_bin *bin =3D &cpu_data->state_bi=
ns[i];
> >>>>>
> >>>>>                         intercept_sum +=3D bin->intercepts;
> >>>>> +                       hit_sum +=3D bin->hits;
> >>>>>
> >>>>> -                       if (2 * intercept_sum > idx_intercept_sum) =
{
> >>>>> +                       if (2 * intercept_sum > cpu_data->total || =
2 * hit_sum > cpu_data->total) {
> >>>>>                                 /*
> >>>>>                                  * Use the current state unless it =
is too
> >>>>>                                  * shallow or disabled, in which ca=
se take the
> >>>>
> >>>> This will only matter after the deepest state has been rejected
> >>>> already and on the system in question this means selecting state 0 n=
o
> >>>> matter what.
> >>>>
> >>>
> >>> Ah, right!
> >>>
> >>>
> >>>> The pre-6.12 behavior can be explained if tick wakeups are taken int=
o account.
> >>>>
> >>>> Namely, when state 0 is chosen (because of the check mentioned above=
),
> >>>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
> >>>> subsequent wakeup is a tick one, it will be counted as a hit on the
> >>>> deepest state (and it will contribute to the total sum in the check
> >>>> mentioned above).  Then, at one point, cpu_data->total will be large
> >>>> enough and the deepest state will become the candidate one.  If
> >>>> tick_nohz_get_sleep_length() returns a large value at that point, th=
e
> >>>> tick will be stopped and the deepest state will be entered.  Nirvana
> >>>> ensues.
> >>>
> >>> So fundamentally we will have to count tick-wakeups as a) nothing, wh=
ich
> >>> doesn't allow us to ever break out of the intercept logic that caused=
 us
> >>> to leave the tick on b) intercepts, which is bonkers and doesn't allo=
w us
> >>> to ever break out and c) hits =3D=3D sleep_length would've been accur=
ate.
> >>> Of course counting a tick wakeup as a hit for sleep_length negates th=
e
> >>> intercept logic.
> >>>
> >>>>
> >>>> The change in commit 4b20b07ce72f causes the sleep length to fall
> >>>> below the deepest idle state target residency at least sometimes in
> >>>> the scenario above, and if the subsequent wakeup is a tick one, it
> >>>> doesn't matter how it is counted - it will contribute to selecting
> >>>> idle state 0.
> >>>>
> >>>> The mainline is affected to a lesser extent because it sometimes doe=
s
> >>>> what pre-6.12 did.
> >>>>
> >>>> IMV addressing this would require changing the check you've identifi=
ed
> >>>> as the culprit, but I'm not sure how to change it TBH.
> >>>
> >>> I guess we don't really have a choice but to have every 10th or so id=
le
> >>> during intercept try the sleep_length state with tick off (i.e. disre=
gard
> >>> intercept) and see if that's still the case? If the sleep length is n=
ow
> >>> accurate and we haven't been woken up then keep disregarding until it=
 does
> >>> again?
> >>> It's the smartest thing I can come up with for now, but I'll give it =
some
> >>> more thought!
> >>
> >> Alternatively we could have the above but have it depend on getting me=
asured_ns
> >> significantly below delta_tick, but that might be a bit risky, I'll se=
nd
> >> patches for both later with some preliminary results unless someone ob=
jects.
> >
> > teo_reflect() checks whether or not the tick has happened and it can
> > pass this information to teo_update().
> >
> >> For 6.12 specifically we also get away with for now with just backport=
ing (up to)
> >> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wakeups =
are very frequent").
> >> Obviously this doesn't fix the underlying problem, which menu can also=
 suffer
> >> from AFAICT.
> >
> > My understanding is that the mainline version of teo still selects WFI
> > (idle state 0) too often on the Reka's system, so backporting won't
> > get us back to the pre-6.12 situation there, will it?
>
> From what I can see 6.6 is a bit too aggressive in selecting deep states?

You can say so.  It depends a good deal on what the expectation is though.

I think that the mainline is almost there, but it still has the case
in which it doesn't matter how a tick wakeup is counted (at least on
the Reka's system) which is a bit concerning.

> It's certainly debatable, but here's the results again:
>
> Per-Cluster deltas: BIG
> +---------+-------+--------------+------------+---------+--------+-------=
-+---------+--------+---------+
> | cluster | state | name         | time=CE=94      | time%   | usage=CE=
=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | BIG     |     0 | WFI          | 376,034    |   1.17% | 1,368  | 0     =
 |   0.00% | 0      |   0.00% |
> | BIG     |     1 | cpuoff-b     | 2,679,129  |   8.33% | 82     | 42    =
 |  51.22% | 40     |  48.78% |
> | BIG     |     2 | clusteroff-b | 29,124,994 |  90.51% | 415    | 99    =
 |  23.86% | 0      |   0.00% |
> | BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0     =
 |   0.00% | 0      |   0.00% |
> | BIG     | TOTAL |              | 32,180,157 | 100.00% | 1,865  | 141   =
 |   7.56% | 40     |   2.14% |
> +---------+-------+--------------+------------+---------+--------+-------=
-+---------+--------+---------+
>
> Per-Cluster deltas: LITTLE
> +---------+-------+--------------+-------------+---------+--------+------=
--+---------+--------+---------+
> | cluster | state | name         | time=CE=94       | time%   | usage=CE=
=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | LITTLE  |     0 | WFI          | 3,902,851   |   3.04% | 10,026 | 0    =
  |   0.00% | 0      |   0.00% |
> | LITTLE  |     1 | cpuoff-l     | 11,604,484  |   9.05% | 715    | 383  =
  |  53.57% | 329    |  46.01% |
> | LITTLE  |     2 | clusteroff-l | 112,706,855 |  87.91% | 3,479  | 1,454=
  |  41.79% | 0      |   0.00% |
> | LITTLE  |     3 | s2idle       | 0           |   0.00% | 0      | 0    =
  |   0.00% | 0      |   0.00% |
> | LITTLE  | TOTAL |              | 128,214,190 | 100.00% | 14,220 | 1,837=
  |  12.92% | 329    |   2.31% |
> +---------+-------+--------------+-------------+---------+--------+------=
--+---------+--------+---------+
>
> Per-Cluster deltas: MID
> +---------+-------+--------------+------------+---------+--------+-------=
-+---------+--------+---------+
> | cluster | state | name         | time=CE=94      | time%   | usage=CE=
=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | MID     |     0 | WFI          | 865,879    |   0.90% | 3,683  | 0     =
 |   0.00% | 0      |   0.00% |
> | MID     |     1 | cpuoff-m     | 9,721,676  |  10.13% | 168    | 82    =
 |  48.81% | 84     |  50.00% |
> | MID     |     2 | clusteroff-m | 85,388,410 |  88.97% | 599    | 223   =
 |  37.23% | 0      |   0.00% |
> | MID     |     3 | s2idle       | 0          |   0.00% | 0      | 0     =
 |   0.00% | 0      |   0.00% |
> | MID     | TOTAL |              | 95,975,965 | 100.00% | 4,450  | 305   =
 |   6.85% | 84     |   1.89% |
> +---------+-------+--------------+------------+---------+--------+-------=
-+---------+--------+---------+
>
> The assumption of course that above misses hurt performance and power whi=
le below above 'only' wastes
> power and therefore you'd rather risk more belows than aboves.
> At least on arm64 the power savings of WFI compared to cpuoff isn't drast=
ic on the smaller cores, while
> the latency is definitely noticeable, but obviously the governor doesn't =
(and probably shouldn't) know
> that.

