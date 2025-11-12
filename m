Return-Path: <linux-pm+bounces-37830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58026C52CB4
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 15:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD87425E45
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94228489E;
	Wed, 12 Nov 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZOm8Pe5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7900284883
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956991; cv=none; b=TvsPp8/fahY4jCyGh7Ofgp2LXeyZGo6Q4+daKMCoF7ysSxP8ahYzFL9BYE+nAnLzCo7jVvma2BB1RAKtYtJUmWBxeDK/5WxWoJ+EJH71M+FZ63sgCo5uWkwSkoAEX7DCbtVHsqNeUzgLjunjmo8yItTy5gcOUVKhV8mWD8AARtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956991; c=relaxed/simple;
	bh=Jq5om2texgD6Q5K0Ba0YBpYrOgJSj+vpghCpYm1PVa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEDp4b/u1slfVoIdv0I7QjZZgNXvcyvZbPd0Eo1LgDDvFYNQLkIw4lC71QZQleTqDkxP7fdIo612b510hy1tkQtKI7XacV3OHvrHpkJj2/lkRKGr7xl7appxLbcJ/PrDnS2yyzSVH/2dyJOfHg7krlyquibcM1G0Q6UnEzxXxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZOm8Pe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA36C4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762956991;
	bh=Jq5om2texgD6Q5K0Ba0YBpYrOgJSj+vpghCpYm1PVa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FZOm8Pe55U8OVe2tX3lk6edb6pc16T5kFNnRTkk/SCHFQviXCwEc2BteM6nPV9SbB
	 Y/T7pgqgsDZ0mQAPvKP0XAIxAcjMTmUjh5zJ1ixqnGTHW/nV8bpJsB4lOi8LGwPLNW
	 fEZj5HehuycCm1vUV83e3nM5OQYVRC8FzlAxJNOTsIY0+1a79mkb/NTGDgnTS9nH/Y
	 uTvGAn9hfxfyrJxOZtei2DD4VFkz2uxZs40AicHz26WWROixfWqZUO/R5e4dcn4qQq
	 WNFMIDv+RTtMl7N/7GLEEYwFLzYscqvWleDjsF+kqJweqT8ICE0V4LEDNptklX4/RC
	 rAoUFKQ0RBbgA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-656f5c55617so201111eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 06:16:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeMkvHqIMVnpENni4N1Xwrly2KRCuxyOgFsVDsS85xZ5VxRl7A9F5ZNxGmVZG+SpT6MmwccrxgRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97asmqTTTPCE762EIFEJEpCUxCgT/jEAsJhqcBbESn8ZUzg3K
	tt5gtEFysbnxd8SSNBvY7vONrS8GkC095YsVkflIYnpuw7q/1D0v5POU7tRM2uj0Qtw51aTALdb
	uREPVrG3KfVRVMor44YVoHbWfAtnBXi8=
X-Google-Smtp-Source: AGHT+IFLEW+cVfhVhz2nwYlPy17DpvXB30rk/AjfWefPq9lGjSa3BSdYZe313qDUmI61QBaIuOztnTzrXNCD5iHpRxw=
X-Received: by 2002:a05:6820:c08c:10b0:656:6bf4:9e9e with SMTP id
 006d021491bc7-65716356b3fmr1030574eaf.5.1762956990536; Wed, 12 Nov 2025
 06:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com> <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
 <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com> <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
 <CAEmPcws_pvYpzRMQfMyRPBw=7bUyYCcnP3BHN2H4wgUeLLszFg@mail.gmail.com>
 <CAJZ5v0i_ZUD1=3JDABJZ3fcdD7r8uMU36=mam8r2=1P02YksYw@mail.gmail.com>
 <f0a2492b-9cea-4450-88ca-be8f99f3e0fe@arm.com> <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
 <0c018867-c092-4f8e-8f7a-32bb02de3ad5@arm.com> <CAEmPcwuVPMONrDHcnxbWpoG5K5DFwf-u2i7wuOK4Q9HvF2uOhw@mail.gmail.com>
 <2a429c41-8624-408c-9db0-4450ab76e52f@arm.com> <a33965da-81d8-47c5-9fa0-434812f2bd72@arm.com>
 <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com>
 <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com> <CAJZ5v0ic0+sG7yp=wXAcsTBmHdXLe8gKLosFJj48AGuCQ=1beg@mail.gmail.com>
 <571fb9f4-56f5-4d75-a70e-d8741bd1fad2@arm.com>
In-Reply-To: <571fb9f4-56f5-4d75-a70e-d8741bd1fad2@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 15:16:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihcLwoMKcPe2RC16sjvf5acU0Y8vjccUu=fYgD+ux12A@mail.gmail.com>
X-Gm-Features: AWmQ_bnqsbmN5yTY2XYl-zUddhAPaib3-XffgBlTrgfaIGYSuPwmEEIg4BWjW8g
Message-ID: <CAJZ5v0ihcLwoMKcPe2RC16sjvf5acU0Y8vjccUu=fYgD+ux12A@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Reka Norman <rekanorman@chromium.org>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:03=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/25 13:32, Rafael J. Wysocki wrote:
> > On Tue, Nov 11, 2025 at 6:20=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/11/25 11:48, Rafael J. Wysocki wrote:
> >>> On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> >>> <christian.loehle@arm.com> wrote:
> >>>>
> >>>> On 11/11/25 10:00, Christian Loehle wrote:
> >
> > [...]
> >
> >>>>> I see two issues:
> >>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this w=
ouldn't really be an issue without 2))
> >>>
> >>> This shouldn't be a problem.
> >>
> >> Agreed, it should be a non-issue. Nonetheless if this wasn't the case =
$subject would've likely
> >> never been an issue.
> >
> > Well, I think that the leftovers can be cleared when they become less t=
han 8.
> >
> >>>
> >>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't=
 an appropriate check, it will
> >>>>> exclude the state if it its idx_hit_sum make up the vast majority o=
f cpu_data->total (i.e. it would
> >>>>> have been a really good candidate actually).
> >>>
> >>> Well, it would exclude the state if the sum of hits for the states
> >>> below it is large enough.  This is questionable (because why would
> >>> hits matter here), but I attempted to make the change below and
> >>> somebody reported a regression IIRC.
> >>>
> >>> This check is related to the problem at hand though (see below).
> >>>
> >>>>>
> >>>>> I lightly tested the below, it seems to be at least comparable to m=
ainline teo.
> >>>>> (the documentation/comments would need adapting too, of course)
> >>>>>
> >>>>> -----8<-----
> >>>>>
> >>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/gove=
rnors/teo.c
> >>>>> index bfa55c1eab5b..f8f76e3b8364 100644
> >>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *dr=
v, struct cpuidle_device *dev,
> >>>>>          * all of the deeper states, a shallower idle state is like=
ly to be a
> >>>>>          * better choice.
> >>>>>          */
> >>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) =
{
> >>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >>>>>                 int first_suitable_idx =3D idx;
> >>>>>
> >>>>>                 /*
> >>>>>
> >>>>>
> >>>>
> >>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx=
-1.
> >>>> Maybe something like this, again lightly tested:
> >>>>
> >>>> -----8<-----
> >>>>
> >>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/gover=
nors/teo.c
> >>>> index 173ddcac540a..6bfb9cedb75e 100644
> >>>> --- a/drivers/cpuidle/governors/teo.c
> >>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *d=
rv, struct cpuidle_device *dev,
> >>>>                  * has been stopped already into account.
> >>>>                  */
> >>>>                 intercept_sum =3D 0;
> >>>> +               hit_sum =3D 0;
> >>>>
> >>>>                 for (i =3D idx - 1; i >=3D 0; i--) {
> >>>>                         struct teo_bin *bin =3D &cpu_data->state_bin=
s[i];
> >>>>
> >>>>                         intercept_sum +=3D bin->intercepts;
> >>>> +                       hit_sum +=3D bin->hits;
> >>>>
> >>>> -                       if (2 * intercept_sum > idx_intercept_sum) {
> >>>> +                       if (2 * intercept_sum > cpu_data->total || 2=
 * hit_sum > cpu_data->total) {
> >>>>                                 /*
> >>>>                                  * Use the current state unless it i=
s too
> >>>>                                  * shallow or disabled, in which cas=
e take the
> >>>
> >>> This will only matter after the deepest state has been rejected
> >>> already and on the system in question this means selecting state 0 no
> >>> matter what.
> >>>
> >>
> >> Ah, right!
> >>
> >>
> >>> The pre-6.12 behavior can be explained if tick wakeups are taken into=
 account.
> >>>
> >>> Namely, when state 0 is chosen (because of the check mentioned above)=
,
> >>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
> >>> subsequent wakeup is a tick one, it will be counted as a hit on the
> >>> deepest state (and it will contribute to the total sum in the check
> >>> mentioned above).  Then, at one point, cpu_data->total will be large
> >>> enough and the deepest state will become the candidate one.  If
> >>> tick_nohz_get_sleep_length() returns a large value at that point, the
> >>> tick will be stopped and the deepest state will be entered.  Nirvana
> >>> ensues.
> >>
> >> So fundamentally we will have to count tick-wakeups as a) nothing, whi=
ch
> >> doesn't allow us to ever break out of the intercept logic that caused =
us
> >> to leave the tick on b) intercepts, which is bonkers and doesn't allow=
 us
> >> to ever break out and c) hits =3D=3D sleep_length would've been accura=
te.
> >> Of course counting a tick wakeup as a hit for sleep_length negates the
> >> intercept logic.
> >
> > Not quite.  The intercept logic is there for wakeups other than tick
> > wakeups and timer wakeups.
> >
> > I actually think that tick wakeups can be counted as hits on the
> > deepest available state - maybe only when tick wakeups dominate the
> > wakeup pattern - but generally this is not unreasonable: When the
> > wakeup pattern is dominated by tick wakeups, this by itself is a good
> > enough reason to stop the tick.
>
> (assuming HZ=3D1000 below but it doesn't matter)
> That will exclude any 'intercept' logic from having much effect if the
> avg idle duration is >TICK_NSEC/2, which is potentially still quite a bit
> off from state1 residency, like in Reka's case here.
> That's why I thought it would cause unreasonable regressions here.
> I'll give it a go as well though!

Thanks!

Note that I'd prefer to add a check if tick wakeups dominate the
wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
I'd first like to know how the Reka's system reacts to the more
drastic variant of this change.

