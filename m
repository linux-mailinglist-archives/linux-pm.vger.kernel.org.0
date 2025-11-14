Return-Path: <linux-pm+bounces-38044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD3AC5DF01
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD7C425A97
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D1331A49;
	Fri, 14 Nov 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht/92Hla"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608023C8C7
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133217; cv=none; b=Wxh+483WsRHgY8WwESVyLbq1pvSEFx6kBahWeD3XicUDDboBxzlDceLB+pZUQp47hUt9WTdCMc1U8x1cRbTZZXAvAyGnhS23ojwNwj9ExijGn7rjZcNCdJ3Hu+iWHqjSpKq1TeJAkyVFZu2bGukAQ1euuDemWntB1c3uBPRWF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133217; c=relaxed/simple;
	bh=Li08MfgIjKFvUmYbJOVqxM1rh4Ut9J1nqL432iUdsfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvUWCj8FjxCcaBX4VruUd4e0znl7R46ZvBsHv8XU0wPKvSOgzMM02SvV2GxhYFLLKK9Lze3VPcrK5kfh2Zu3N9o8Qy+rKbpb8QmyRkSMoo8BtLSUD13fa+Moh1YKgOGUBnCRiEyxyKwWJe7AqQT3rcpKrd2EjrdpDVLQNXnYikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht/92Hla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725D2C116D0
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763133216;
	bh=Li08MfgIjKFvUmYbJOVqxM1rh4Ut9J1nqL432iUdsfc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ht/92HlaGNw5B5+9cww6zciMiqK+yCXbURfZHhqPSfib0hp/lLVX9N08jUJhEOVrj
	 9PoqPAAqfe1rpdhZVZxSJz8XPEWi6VZJ/yo+VwvmlLx5lieoOtO85k1Hy0lEPCOUJE
	 BxuNmA9NBKjkTkfL5gtaU7AxuNFBBAmizkOc+rXRggIq+KoQ5+Vl4pyKuHm3mULdKM
	 2XtREuTkr2mc6nNuzr9iUuXfnAVbmEc21ZP2DN0XSdpRVZGR/TMhGnw8O0gtbNv++k
	 XpZKExc0VBe8GHFrRNkMM82nxd80miIqyye8OFHV/YUr/vcFY1dXh3gGBNfcQT5UXT
	 s7CZgGpRmWi/Q==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4505ade79c2so993208b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 07:13:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxjCRLH4UsWTooNyNEv+/y7nmkwt115MP9TIzu1MM7ryb1kGYz6g6azjbRkGNRGG120kGDSg9tAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFyFxaSyVs+dCu5lKbTi2o65IwaySwWZcvIGEuVcBKss/zAxD
	OO42YUuYwd4PTOlSwY2oI9ZY9evIj7jQoCsu2yiPkJF7DkArZDx+LIlM5svSj8t4R/cDCQ3OJMh
	vcExz2j/qyGzA42WtTNayl/EAi20HSOE=
X-Google-Smtp-Source: AGHT+IElyoyLbRuD8qksN7R9FDcY0EJx0PdOJ4UM49iVx/gsAaqmZUAYvFWFNWgJvp9b75WMSU7f7J0LWnqx/MuLrr4=
X-Received: by 2002:a05:6808:4f62:b0:43f:77d6:aeca with SMTP id
 5614622812f47-4509751b020mr1650093b6e.38.1763133215703; Fri, 14 Nov 2025
 07:13:35 -0800 (PST)
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
 <af968cd5-8d93-4a3a-97c8-8618a641baea@arm.com>
In-Reply-To: <af968cd5-8d93-4a3a-97c8-8618a641baea@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 16:13:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h88MUR+wsuQVa11SjUV0sHmowQ0rcsDkBAmCiU3jXUjw@mail.gmail.com>
X-Gm-Features: AWmQ_bko6x-LOiMPw_gb9Nh6iNdQ44oR3lha4WwSaVLuKa9gv0hABOtRSeD2l3I
Message-ID: <CAJZ5v0h88MUR+wsuQVa11SjUV0sHmowQ0rcsDkBAmCiU3jXUjw@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Reka Norman <rekanorman@chromium.org>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 3:49=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/14/25 14:15, Rafael J. Wysocki wrote:
> > On Fri, Nov 14, 2025 at 9:33=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/14/25 04:05, Reka Norman wrote:
> >>> On Fri, Nov 14, 2025 at 3:56=E2=80=AFAM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> >>>>
> >>>> On Thursday, November 13, 2025 4:43:18 PM CET Christian Loehle wrote=
:
> >>>>> On 11/12/25 18:33, Christian Loehle wrote:
> >>>>>> On 11/12/25 14:16, Rafael J. Wysocki wrote:
> >>>>>>> On Wed, Nov 12, 2025 at 3:03=E2=80=AFPM Christian Loehle
> >>>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>>
> >>>>>>>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
> >>>>>>>>> On Tue, Nov 11, 2025 at 6:20=E2=80=AFPM Christian Loehle
> >>>>>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
> >>>>>>>>>>> On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> >>>>>>>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
> >>>>>>>>>
> >>>>>>>>> [...]
> >>>>>>>>>
> >>>>>>>>>>>>> I see two issues:
> >>>>>>>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I gues=
s this wouldn't really be an issue without 2))
> >>>>>>>>>>>
> >>>>>>>>>>> This shouldn't be a problem.
> >>>>>>>>>>
> >>>>>>>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't t=
he case $subject would've likely
> >>>>>>>>>> never been an issue.
> >>>>>>>>>
> >>>>>>>>> Well, I think that the leftovers can be cleared when they becom=
e less than 8.
> >>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_su=
m) isn't an appropriate check, it will
> >>>>>>>>>>>>> exclude the state if it its idx_hit_sum make up the vast ma=
jority of cpu_data->total (i.e. it would
> >>>>>>>>>>>>> have been a really good candidate actually).
> >>>>>>>>>>>
> >>>>>>>>>>> Well, it would exclude the state if the sum of hits for the s=
tates
> >>>>>>>>>>> below it is large enough.  This is questionable (because why =
would
> >>>>>>>>>>> hits matter here), but I attempted to make the change below a=
nd
> >>>>>>>>>>> somebody reported a regression IIRC.
> >>>>>>>>>>>
> >>>>>>>>>>> This check is related to the problem at hand though (see belo=
w).
> >>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I lightly tested the below, it seems to be at least compara=
ble to mainline teo.
> >>>>>>>>>>>>> (the documentation/comments would need adapting too, of cou=
rse)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> -----8<-----
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpui=
dle/governors/teo.c
> >>>>>>>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
> >>>>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>>>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_dr=
iver *drv, struct cpuidle_device *dev,
> >>>>>>>>>>>>>          * all of the deeper states, a shallower idle state=
 is likely to be a
> >>>>>>>>>>>>>          * better choice.
> >>>>>>>>>>>>>          */
> >>>>>>>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_h=
it_sum) {
> >>>>>>>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >>>>>>>>>>>>>                 int first_suitable_idx =3D idx;
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>                 /*
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of=
 0...idx-1.
> >>>>>>>>>>>> Maybe something like this, again lightly tested:
> >>>>>>>>>>>>
> >>>>>>>>>>>> -----8<-----
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuid=
le/governors/teo.c
> >>>>>>>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
> >>>>>>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>>>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_d=
river *drv, struct cpuidle_device *dev,
> >>>>>>>>>>>>                  * has been stopped already into account.
> >>>>>>>>>>>>                  */
> >>>>>>>>>>>>                 intercept_sum =3D 0;
> >>>>>>>>>>>> +               hit_sum =3D 0;
> >>>>>>>>>>>>
> >>>>>>>>>>>>                 for (i =3D idx - 1; i >=3D 0; i--) {
> >>>>>>>>>>>>                         struct teo_bin *bin =3D &cpu_data->s=
tate_bins[i];
> >>>>>>>>>>>>
> >>>>>>>>>>>>                         intercept_sum +=3D bin->intercepts;
> >>>>>>>>>>>> +                       hit_sum +=3D bin->hits;
> >>>>>>>>>>>>
> >>>>>>>>>>>> -                       if (2 * intercept_sum > idx_intercep=
t_sum) {
> >>>>>>>>>>>> +                       if (2 * intercept_sum > cpu_data->to=
tal || 2 * hit_sum > cpu_data->total) {
> >>>>>>>>>>>>                                 /*
> >>>>>>>>>>>>                                  * Use the current state unl=
ess it is too
> >>>>>>>>>>>>                                  * shallow or disabled, in w=
hich case take the
> >>>>>>>>>>>
> >>>>>>>>>>> This will only matter after the deepest state has been reject=
ed
> >>>>>>>>>>> already and on the system in question this means selecting st=
ate 0 no
> >>>>>>>>>>> matter what.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Ah, right!
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> The pre-6.12 behavior can be explained if tick wakeups are ta=
ken into account.
> >>>>>>>>>>>
> >>>>>>>>>>> Namely, when state 0 is chosen (because of the check mentione=
d above),
> >>>>>>>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  I=
f the
> >>>>>>>>>>> subsequent wakeup is a tick one, it will be counted as a hit =
on the
> >>>>>>>>>>> deepest state (and it will contribute to the total sum in the=
 check
> >>>>>>>>>>> mentioned above).  Then, at one point, cpu_data->total will b=
e large
> >>>>>>>>>>> enough and the deepest state will become the candidate one.  =
If
> >>>>>>>>>>> tick_nohz_get_sleep_length() returns a large value at that po=
int, the
> >>>>>>>>>>> tick will be stopped and the deepest state will be entered.  =
Nirvana
> >>>>>>>>>>> ensues.
> >>>>>>>>>>
> >>>>>>>>>> So fundamentally we will have to count tick-wakeups as a) noth=
ing, which
> >>>>>>>>>> doesn't allow us to ever break out of the intercept logic that=
 caused us
> >>>>>>>>>> to leave the tick on b) intercepts, which is bonkers and doesn=
't allow us
> >>>>>>>>>> to ever break out and c) hits =3D=3D sleep_length would've bee=
n accurate.
> >>>>>>>>>> Of course counting a tick wakeup as a hit for sleep_length neg=
ates the
> >>>>>>>>>> intercept logic.
> >>>>>>>>>
> >>>>>>>>> Not quite.  The intercept logic is there for wakeups other than=
 tick
> >>>>>>>>> wakeups and timer wakeups.
> >>>>>>>>>
> >>>>>>>>> I actually think that tick wakeups can be counted as hits on th=
e
> >>>>>>>>> deepest available state - maybe only when tick wakeups dominate=
 the
> >>>>>>>>> wakeup pattern - but generally this is not unreasonable: When t=
he
> >>>>>>>>> wakeup pattern is dominated by tick wakeups, this by itself is =
a good
> >>>>>>>>> enough reason to stop the tick.
> >>>>>>>>
> >>>>>>>> (assuming HZ=3D1000 below but it doesn't matter)
> >>>>>>>> That will exclude any 'intercept' logic from having much effect =
if the
> >>>>>>>> avg idle duration is >TICK_NSEC/2, which is potentially still qu=
ite a bit
> >>>>>>>> off from state1 residency, like in Reka's case here.
> >>>>>>>> That's why I thought it would cause unreasonable regressions her=
e.
> >>>>>>>> I'll give it a go as well though!
> >>>>>>>
> >>>>>>> Thanks!
> >>>>>>>
> >>>>>>> Note that I'd prefer to add a check if tick wakeups dominate the
> >>>>>>> wakeup pattern before setting sleep_length_ns to KTIME_MAX though=
.
> >>>>>>> I'd first like to know how the Reka's system reacts to the more
> >>>>>>> drastic variant of this change.
> >>>>>>
> >>>>>> Below are my usual tests, it's definitely visible but the impact i=
s limited
> >>>>>> on this platform anyway. I think if we gate the KTIME_MAX setting =
behind
> >>>>>> the "tick wakeup dominate" it should be acceptable!
> >>>>>> Let's see what Reka reports.
> >>>>>>
> >>>>> Forgot to post the full results, anyway as expected with mtdblock (=
a very slow
> >>>>> / low frequent wakeup scenario) the impact becomes clearly visible.
> >>>>> Still hopeful that the more conservative approach will be acceptabl=
e!
> >>>>
> >>>> Speaking of which, the patch to test is appended below, but it doesn=
't apply
> >>>> directly on top of the mainline.  It is based on some other patches =
that have
> >>>> been posted recently, so here's a git branch with all of the requisi=
te
> >>>> material:
> >>>>
> >>>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cp=
uidle-teo-testing
> >>>>
> >>>> Reka, please try this one and let us know how it goes.
> >>>
> >>> Results attached. The residencies are a bit less deep than before -
> >>> about 4.5% in WFI vs 2% at 6.6 or with the more aggressive patch. But
> >>> I=E2=80=99m guessing that=E2=80=99s expected.
> >>>
> >>> I also measured the power on a slightly different system where I firs=
t
> >>> noticed this regression, and it=E2=80=99s indistinguishable from 6.6.=
 So from
> >>> my side this looks great, thank you!
> >>
> >> Good news!
> >
> > So I'm going to queue this up for 6.19 along with the material it depen=
ds on.
> >
> > I'd rather not rush it into 6.18-rc7 because it would not get
> > meaningful exposure in linux-next before appearing in the mainline in
> > that case.
>
> Ack
>
> >
> > Reka, I'm going to add your Tested-by: to it, please let me know if
> > there are any concerns regarding that.
> >
> > Now, I think that it needs to go into -stable (6.12+ I suppose?) and
> > I'm going to instruct -stable to pick up the dependencies along with
> > it.
> >
>
> Would be nice to get teo slightly more aligned, agreed!
> As noted I don't think it's 6.12+ only but clearly that's where the
> impact of the issue is the highest.
> Thanks for fixing this!

Anytime!

