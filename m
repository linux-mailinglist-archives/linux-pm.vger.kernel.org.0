Return-Path: <linux-pm+bounces-37827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B769CC528E4
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 14:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27003BF138
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7333555E;
	Wed, 12 Nov 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+6erbY4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2ED219A8E
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954821; cv=none; b=pqxxYT3OpfeGcdCVHBe6shfzlh4fZLDZYIws/O86DNh0gukeDBlJ5SIBDZ7lH4OZ2hV3/9NruzC1oAvwUbhxxEFOw7PjWPJz1C4+VgpFdXrX+lH1UvoE1uNJW5J40OUVHdmVdvn9Lr+ASXkeuaQHet8VPS9iSw98m1l+jRARVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954821; c=relaxed/simple;
	bh=tbMbEN9I77I5JE3L1ihvOuGW3tiwt7h4+h0kXYEgwdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOsAU0D4o3ktVh9AjduRc5ZwlFFyHLGTe5gmvShFROmReJSiuMURULvot3KJ+/Si8tNOuX9TB21A7T4oJwUE7Z7fHNGXbJBGaZKn5++r/pHLZytTIJrKojJmLPwEilhu/lqVvaONRNcc9ak3igEM2/6bwRoJBtswmxDAx+gSJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+6erbY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E9C2BC87
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954820;
	bh=tbMbEN9I77I5JE3L1ihvOuGW3tiwt7h4+h0kXYEgwdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S+6erbY4DH+Gu6QDhJL17Gi2DXHn2VQwbLO5ca+OCa75w/1JIg7s1LF6DdMrPSO3e
	 LzVCVMOfDnDiISvWMBiQBjNZd4kZARKdcjGGA9Qo9zIkektlmfoBT6KmwL4pT+kZcS
	 x/9yS7bTj0ZILDZ0Yo3YSBq8Kaw1NsLcWB+CtC+VP6jqIU4qV1CStxx1fLzAXWUt+g
	 ataLDqDRjU7esVjyvSPx2KTsg7t5WWSMrTsNQjaGDMY7ET7OKXYoTDFIu8wBeJDtp5
	 O2mXCX0qOngemmYlZlKgAYOK2oD1rdBDnTSenO7Ghvp/8/QkNDh+tHQMFTmHf0t92d
	 LXHYRbAuNgrWg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3c96de7fe7eso463581fac.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 05:40:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzbjxAUb2h5avJgOWaP8RDDXqGzN7k/Y10/6TqUZ0LubN8m+C/TdkLwpyfi4YfLqJw8GUZ8jf5dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/2chygVOtY2QGNclZxymZsP+ATjTdfFrA8s45gOUIuGkUTnM
	Na6zxIR9OFVS839Xo3Tqefp/WgW6Loknat2ihH3KJxADATwPkKJ3Jd9A9F2Aar2Uvkgn2aRdZta
	T1zDGLDQ9yPEtzFAU3BforTujC5Iw0PU=
X-Google-Smtp-Source: AGHT+IERlUDPyo725SKtrcve2jIo17Ay5DA7dEINx1n1leHX78cBJ4g+EeyPktfyMSE7XUT2Hk9hKrtt39WmQaDfI1w=
X-Received: by 2002:a05:6808:1649:b0:44d:baaa:c53e with SMTP id
 5614622812f47-450744e14d9mr1539443b6e.25.1762954819580; Wed, 12 Nov 2025
 05:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com> <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
 <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
 <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com> <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
 <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
 <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
 <f0a2492b-9cea-4450-88ca-be8f99f3e0fe@arm.com> <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
 <0c018867-c092-4f8e-8f7a-32bb02de3ad5@arm.com> <CAEmPcwuVPMONrDHcnxbWpoG5K5DFwf-u2i7wuOK4Q9HvF2uOhw@mail.gmail.com>
 <2a429c41-8624-408c-9db0-4450ab76e52f@arm.com> <a33965da-81d8-47c5-9fa0-434812f2bd72@arm.com>
 <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com>
 <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com> <bf42d9cf-9642-466e-9ac3-8396fd9b1942@arm.com>
In-Reply-To: <bf42d9cf-9642-466e-9ac3-8396fd9b1942@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 14:40:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gQSPqfuCz090bd0nT1G_+krsMOtfVAU3SENSm3NZp+qw@mail.gmail.com>
X-Gm-Features: AWmQ_bm3qyS_Wnq0hF6xIyLx5sSVSLJ4HPa98rmNRnIjRFPsZ-bs9ZE_nJ6p8l8
Message-ID: <CAJZ5v0gQSPqfuCz090bd0nT1G_+krsMOtfVAU3SENSm3NZp+qw@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Reka Norman <rekanorman@chromium.org>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:51=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/11/25 17:20, Christian Loehle wrote:
> > On 11/11/25 11:48, Rafael J. Wysocki wrote:
> >> On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> >> <christian.loehle@arm.com> wrote:

[...]

> >>>> I see two issues:
> >>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this wo=
uldn't really be an issue without 2))
> >>
> >> This shouldn't be a problem.
> >
> > Agreed, it should be a non-issue. Nonetheless if this wasn't the case $=
subject would've likely
> > never been an issue.
> >
> >>
> >>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't =
an appropriate check, it will
> >>>> exclude the state if it its idx_hit_sum make up the vast majority of=
 cpu_data->total (i.e. it would
> >>>> have been a really good candidate actually).
> >>
> >> Well, it would exclude the state if the sum of hits for the states
> >> below it is large enough.  This is questionable (because why would
> >> hits matter here), but I attempted to make the change below and
> >> somebody reported a regression IIRC.
> >>
> >> This check is related to the problem at hand though (see below).
> >>
> >>>>
> >>>> I lightly tested the below, it seems to be at least comparable to ma=
inline teo.
> >>>> (the documentation/comments would need adapting too, of course)
> >>>>
> >>>> -----8<-----
> >>>>
> >>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/gover=
nors/teo.c
> >>>> index bfa55c1eab5b..f8f76e3b8364 100644
> >>>> --- a/drivers/cpuidle/governors/teo.c
> >>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv=
, struct cpuidle_device *dev,
> >>>>          * all of the deeper states, a shallower idle state is likel=
y to be a
> >>>>          * better choice.
> >>>>          */
> >>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> >>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >>>>                 int first_suitable_idx =3D idx;
> >>>>
> >>>>                 /*
> >>>>
> >>>>
> >>>
> >>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-=
1.
> >>> Maybe something like this, again lightly tested:
> >>>
> >>> -----8<-----
> >>>
> >>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/govern=
ors/teo.c
> >>> index 173ddcac540a..6bfb9cedb75e 100644
> >>> --- a/drivers/cpuidle/governors/teo.c
> >>> +++ b/drivers/cpuidle/governors/teo.c
> >>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *dr=
v, struct cpuidle_device *dev,
> >>>                  * has been stopped already into account.
> >>>                  */
> >>>                 intercept_sum =3D 0;
> >>> +               hit_sum =3D 0;
> >>>
> >>>                 for (i =3D idx - 1; i >=3D 0; i--) {
> >>>                         struct teo_bin *bin =3D &cpu_data->state_bins=
[i];
> >>>
> >>>                         intercept_sum +=3D bin->intercepts;
> >>> +                       hit_sum +=3D bin->hits;
> >>>
> >>> -                       if (2 * intercept_sum > idx_intercept_sum) {
> >>> +                       if (2 * intercept_sum > cpu_data->total || 2 =
* hit_sum > cpu_data->total) {
> >>>                                 /*
> >>>                                  * Use the current state unless it is=
 too
> >>>                                  * shallow or disabled, in which case=
 take the
> >>
> >> This will only matter after the deepest state has been rejected
> >> already and on the system in question this means selecting state 0 no
> >> matter what.
> >>
> >
> > Ah, right!
> >
> >
> >> The pre-6.12 behavior can be explained if tick wakeups are taken into =
account.
> >>
> >> Namely, when state 0 is chosen (because of the check mentioned above),
> >> the tick is not stopped and the sleep length is KTIME_MAX.  If the
> >> subsequent wakeup is a tick one, it will be counted as a hit on the
> >> deepest state (and it will contribute to the total sum in the check
> >> mentioned above).  Then, at one point, cpu_data->total will be large
> >> enough and the deepest state will become the candidate one.  If
> >> tick_nohz_get_sleep_length() returns a large value at that point, the
> >> tick will be stopped and the deepest state will be entered.  Nirvana
> >> ensues.
> >
> > So fundamentally we will have to count tick-wakeups as a) nothing, whic=
h
> > doesn't allow us to ever break out of the intercept logic that caused u=
s
> > to leave the tick on b) intercepts, which is bonkers and doesn't allow =
us
> > to ever break out and c) hits =3D=3D sleep_length would've been accurat=
e.
> > Of course counting a tick wakeup as a hit for sleep_length negates the
> > intercept logic.
> >
> >>
> >> The change in commit 4b20b07ce72f causes the sleep length to fall
> >> below the deepest idle state target residency at least sometimes in
> >> the scenario above, and if the subsequent wakeup is a tick one, it
> >> doesn't matter how it is counted - it will contribute to selecting
> >> idle state 0.
> >>
> >> The mainline is affected to a lesser extent because it sometimes does
> >> what pre-6.12 did.
> >>
> >> IMV addressing this would require changing the check you've identified
> >> as the culprit, but I'm not sure how to change it TBH.
> >
> > I guess we don't really have a choice but to have every 10th or so idle
> > during intercept try the sleep_length state with tick off (i.e. disrega=
rd
> > intercept) and see if that's still the case? If the sleep length is now
> > accurate and we haven't been woken up then keep disregarding until it d=
oes
> > again?
> > It's the smartest thing I can come up with for now, but I'll give it so=
me
> > more thought!
>
> Alternatively we could have the above but have it depend on getting measu=
red_ns
> significantly below delta_tick, but that might be a bit risky, I'll send
> patches for both later with some preliminary results unless someone objec=
ts.

teo_reflect() checks whether or not the tick has happened and it can
pass this information to teo_update().

> For 6.12 specifically we also get away with for now with just backporting=
 (up to)
> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wakeups are=
 very frequent").
> Obviously this doesn't fix the underlying problem, which menu can also su=
ffer
> from AFAICT.

My understanding is that the mainline version of teo still selects WFI
(idle state 0) too often on the Reka's system, so backporting won't
get us back to the pre-6.12 situation there, will it?

