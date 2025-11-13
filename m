Return-Path: <linux-pm+bounces-37936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267BC57084
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC14E71FB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F2331A6D;
	Thu, 13 Nov 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLUREIoi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60502D979C
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031145; cv=none; b=kPoFp6ykAblV3N6VbwKAhX+XuJjVQGqQmT95AR0pVRUWL6H8Uq+4/gWcW8u1lPxc3oHnf7CDpQ3S7q/LtRtq4ZgXzr2yvbd5G/b/WdveIt5TNxFCC64zhhhI+s5nGefOpH88BTO6LIkLxb0rsLcW2z7OhhuvI2WH6sAQermcunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031145; c=relaxed/simple;
	bh=HTDzFDH2KlbyzHRy7okEnsHyo8apnYL8zpMTflTcReI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gga8Yhca6SYszgBGqLxVrJQuizm0lAqY3v+bstqAzgvGPkGSqEBURO+U7LBIGMHhLCrDAvQy6PT2u66CDLO+t5YgXH8pAsGUxunZL5vs+gCxVeKEYtAV816YaG/ZQZ1+C/AQKCaZd2HEF8blJ1r8CsDTczQa6eIsuNsZckaemes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLUREIoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A293C4CEF5
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031145;
	bh=HTDzFDH2KlbyzHRy7okEnsHyo8apnYL8zpMTflTcReI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LLUREIoiZQJ0lp0YxsfZ0/nRtBNtfJUb4VquPq+QHdI8qszWnGJF3/XAeb96EJjOh
	 f7bxXQkTnXTvVkedAAJH+u9O1eAOMSiWVDffrBFsF3Yi/SySmHzKMhlJXNyVIyhhSP
	 caa2JWg0hKNiRBcGBaERHGcFJlV/u2hFmBQsDHuRymbLlWuNulOYlvMdAsA60LBh9I
	 gxDG3afHdvNp4P9IXEruPYppgUUhHr67joOV7x+Unoy/UYQFHFVXE8LvSB/R7vvSF4
	 pk3jGDc6EEDSBPYrukia5ufpfsbemDBtZyqZb8i3q5VaU4udFjDZ2zLWUNW12wg1O3
	 Tmuptvskhh6XQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c284d4867eso202016a34.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 02:52:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3ZETjKGo2hX60olbaTym8CDkJSgrflbgZGF95NsWOk841dM/iZ/g7GnjlHiDNACf5ijfNEMgoJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzynq1mVk0PPlxTRMWqiOyw1+zIMrWIavHFqdcCD/9YBE+IT5qd
	5i9obHgRID8ootw/E3oYsyu1wJ7hu+/6y3bV5AKJrRODKQR8q0fXH0KyRj0Rb7IOBECTGB+z3H9
	x1mHp1ucIe8BPTYcHTJyLqTBKiR/PP8M=
X-Google-Smtp-Source: AGHT+IHAeCzSlmNu4YutjkUDC+EbbrskEe7Qs7neEU6ch7fvTMdGa+HCM48mvu967NMpM75F3yv1NNVu0T1jkJ6/Q/Y=
X-Received: by 2002:a05:6808:18a4:b0:44f:6dcf:1158 with SMTP id
 5614622812f47-450745e3d2dmr3074384b6e.65.1763031144638; Thu, 13 Nov 2025
 02:52:24 -0800 (PST)
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
 <939deff8-7856-4d9b-be91-eda06fac21d0@arm.com> <CAJZ5v0ic0+sG7yp=wXAcsTBmHdXLe8gKLosFJj48AGuCQ=1beg@mail.gmail.com>
 <CAEmPcwvVZwyyiQYLt+H_x9VZYMn9VftiwBNVYev0DM55k5qVgA@mail.gmail.com>
In-Reply-To: <CAEmPcwvVZwyyiQYLt+H_x9VZYMn9VftiwBNVYev0DM55k5qVgA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 11:52:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gB1iF1bFnDsftGOM=VR6nge=8DBO=HmKJGS=J-4qZCSg@mail.gmail.com>
X-Gm-Features: AWmQ_bn9cLS2lI_cMoQfqeAFMA2GifBswwpSbZJzjovgkj_ibM-KU3assAl8ESk
Message-ID: <CAJZ5v0gB1iF1bFnDsftGOM=VR6nge=8DBO=HmKJGS=J-4qZCSg@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Reka Norman <rekanorman@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 6:13=E2=80=AFAM Reka Norman <rekanorman@chromium.or=
g> wrote:
>
> On Thu, Nov 13, 2025 at 12:32=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Tue, Nov 11, 2025 at 6:20=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> > >
> > > On 11/11/25 11:48, Rafael J. Wysocki wrote:
> > > > On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> > > > <christian.loehle@arm.com> wrote:
> > > >>
> > > >> On 11/11/25 10:00, Christian Loehle wrote:
> >
> > [...]
> >
> > > >>> I see two issues:
> > > >>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this=
 wouldn't really be an issue without 2))
> > > >
> > > > This shouldn't be a problem.
> > >
> > > Agreed, it should be a non-issue. Nonetheless if this wasn't the case=
 $subject would've likely
> > > never been an issue.
> >
> > Well, I think that the leftovers can be cleared when they become less t=
han 8.
> >
> > > >
> > > >>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn=
't an appropriate check, it will
> > > >>> exclude the state if it its idx_hit_sum make up the vast majority=
 of cpu_data->total (i.e. it would
> > > >>> have been a really good candidate actually).
> > > >
> > > > Well, it would exclude the state if the sum of hits for the states
> > > > below it is large enough.  This is questionable (because why would
> > > > hits matter here), but I attempted to make the change below and
> > > > somebody reported a regression IIRC.
> > > >
> > > > This check is related to the problem at hand though (see below).
> > > >
> > > >>>
> > > >>> I lightly tested the below, it seems to be at least comparable to=
 mainline teo.
> > > >>> (the documentation/comments would need adapting too, of course)
> > > >>>
> > > >>> -----8<-----
> > > >>>
> > > >>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/go=
vernors/teo.c
> > > >>> index bfa55c1eab5b..f8f76e3b8364 100644
> > > >>> --- a/drivers/cpuidle/governors/teo.c
> > > >>> +++ b/drivers/cpuidle/governors/teo.c
> > > >>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *=
drv, struct cpuidle_device *dev,
> > > >>>          * all of the deeper states, a shallower idle state is li=
kely to be a
> > > >>>          * better choice.
> > > >>>          */
> > > >>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum=
) {
> > > >>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> > > >>>                 int first_suitable_idx =3D idx;
> > > >>>
> > > >>>                 /*
> > > >>>
> > > >>>
> > > >>
> > > >> ... nevermind the patch, idx_hit_sum is of course the sum of 0...i=
dx-1.
> > > >> Maybe something like this, again lightly tested:
> > > >>
> > > >> -----8<-----
> > > >>
> > > >> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/gov=
ernors/teo.c
> > > >> index 173ddcac540a..6bfb9cedb75e 100644
> > > >> --- a/drivers/cpuidle/governors/teo.c
> > > >> +++ b/drivers/cpuidle/governors/teo.c
> > > >> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver =
*drv, struct cpuidle_device *dev,
> > > >>                  * has been stopped already into account.
> > > >>                  */
> > > >>                 intercept_sum =3D 0;
> > > >> +               hit_sum =3D 0;
> > > >>
> > > >>                 for (i =3D idx - 1; i >=3D 0; i--) {
> > > >>                         struct teo_bin *bin =3D &cpu_data->state_b=
ins[i];
> > > >>
> > > >>                         intercept_sum +=3D bin->intercepts;
> > > >> +                       hit_sum +=3D bin->hits;
> > > >>
> > > >> -                       if (2 * intercept_sum > idx_intercept_sum)=
 {
> > > >> +                       if (2 * intercept_sum > cpu_data->total ||=
 2 * hit_sum > cpu_data->total) {
> > > >>                                 /*
> > > >>                                  * Use the current state unless it=
 is too
> > > >>                                  * shallow or disabled, in which c=
ase take the
> > > >
> > > > This will only matter after the deepest state has been rejected
> > > > already and on the system in question this means selecting state 0 =
no
> > > > matter what.
> > > >
> > >
> > > Ah, right!
> > >
> > >
> > > > The pre-6.12 behavior can be explained if tick wakeups are taken in=
to account.
> > > >
> > > > Namely, when state 0 is chosen (because of the check mentioned abov=
e),
> > > > the tick is not stopped and the sleep length is KTIME_MAX.  If the
> > > > subsequent wakeup is a tick one, it will be counted as a hit on the
> > > > deepest state (and it will contribute to the total sum in the check
> > > > mentioned above).  Then, at one point, cpu_data->total will be larg=
e
> > > > enough and the deepest state will become the candidate one.  If
> > > > tick_nohz_get_sleep_length() returns a large value at that point, t=
he
> > > > tick will be stopped and the deepest state will be entered.  Nirvan=
a
> > > > ensues.
> > >
> > > So fundamentally we will have to count tick-wakeups as a) nothing, wh=
ich
> > > doesn't allow us to ever break out of the intercept logic that caused=
 us
> > > to leave the tick on b) intercepts, which is bonkers and doesn't allo=
w us
> > > to ever break out and c) hits =3D=3D sleep_length would've been accur=
ate.
> > > Of course counting a tick wakeup as a hit for sleep_length negates th=
e
> > > intercept logic.
> >
> > Not quite.  The intercept logic is there for wakeups other than tick
> > wakeups and timer wakeups.
> >
> > I actually think that tick wakeups can be counted as hits on the
> > deepest available state - maybe only when tick wakeups dominate the
> > wakeup pattern - but generally this is not unreasonable: When the
> > wakeup pattern is dominated by tick wakeups, this by itself is a good
> > enough reason to stop the tick.
> >
> > The attached patch tests the theory above, let's see how far it gets
> > us.  Reka, can you please test this one on top of the mainline and see
> > if it gets you more deep idle state residency?
>
> Yes, that definitely makes a difference! Results attached. They're
> pretty comparable to 6.6 - about 2% WFI on average across CPUs.

Cool, thanks!

We seem to be on the right track.

This version of the patch is overly aggressive and I'm going to send
an adulterated version of it later today.

