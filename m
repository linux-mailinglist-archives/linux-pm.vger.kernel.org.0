Return-Path: <linux-pm+bounces-38134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D9AC65327
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F3DD3683E2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780742D0C90;
	Mon, 17 Nov 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGtDb5vq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B132C21DF
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396956; cv=none; b=PpcGYxJq2BNzsFsReCzRtLvoyPaGslks+tMByOFfVU3FlyNtFZgkvr7fNYQt2ZyHtRbuzd+30USgbVI2c4XaKmPMDI0VahXPufDzjw74C2hl56MehTy891NU8mI6/UyW3954QJVddMObsLexuiJUYxpZyr+vISuFMWQMu0+NhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396956; c=relaxed/simple;
	bh=C9uyH1GiCfZa+nakR7SFqcAQzNiBodkHZ4HEVvp4pwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W24L1JYw30jx9NVzR7nWKQsB28YSNLSwe5F4SpMVkgIzppQkZbuz29OmuYeP6lvHx3gTl6ezvnKkTign1qozGfTVbtB6/cLdyJLfWJ+BubCDlSt33Ov7lYukkuDpLqUbVMM5AruwAA8Ao/Ch314YHlc15YaS/dusOGrjEuIeWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGtDb5vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7478C19423
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396955;
	bh=C9uyH1GiCfZa+nakR7SFqcAQzNiBodkHZ4HEVvp4pwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VGtDb5vqGeIzA7zRrgvAHnw9+V8AZDTtUoa17sW0IA/LvyAr+CqVah2DXrhdb41P/
	 LOzmfTmPfXy102xaD1cDUlcgd2IG4YdN+OTGt5OQxDWDrTGgO7qRpNmfyJxgQh6GJm
	 eP3i0AHOxgUcl6It6bGHQ+O2slhgEGQEpzkBy/TVDCZiftx5m6mILuY8EMRrCO34uf
	 I5sow8SUa9yIs+r9wp1dolLWD/lDRy/EkiytbsOJiS0H1TV1Qw+plagymYNGPN6hHv
	 bpFC6zW+ightVWRFIeQsiZMYjZWkBIBwl6skwXq7C1o/ADo2+7X4p90H0aM89ekDLx
	 oy5km+9Y3/1eg==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c7503c73b4so1184306a34.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 08:29:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQrZRgpF532ytd41UfjI8KjD5YcG7PcX/4oF4JW6BCPd3e3Cexsgav/XjUIv8/CEBqGxwLcHh/Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyA+EXB4wXNSe8P0EljcGV/JgubQ2Sw0ph6jb35/BPJNANHwTk
	7j7cdXUi2NwsjCfkUc2wDXURkckWfg7ogqWXpiJ+JG141WyJIbnr6JChzcf/601bdRc8D1CrObv
	iPgZ4S8lO/ZfASMO3FSXS9cLSEv0XbpQ=
X-Google-Smtp-Source: AGHT+IF7RStUfC32CUihSPvJn5TcnVixaAja7laN2bDo0l3Capm8BaNAmEyGSZzHUQ6jCB6qAVPdUPSpa6XoVjJD7L4=
X-Received: by 2002:a05:6808:c0d5:20b0:450:b7a0:41d3 with SMTP id
 5614622812f47-450b7a0502bmr2813430b6e.67.1763396954868; Mon, 17 Nov 2025
 08:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com> <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
 <6228387.lOV4Wx5bFT@rafael.j.wysocki> <CAEmPcwsVfcoFTyS-mHSkZTFmS8Y1vkFToYo1xcAH0522wyDawA@mail.gmail.com>
 <431db236-736d-4fc3-95c2-876bc767aa0c@arm.com> <CAEmPcwsQjHsqmvaWA_6ORCQnJdWutDmu=KZSrn=nKJhirX7H3Q@mail.gmail.com>
 <faa4e196-f8bf-4800-b755-a35e80d41b9f@arm.com>
In-Reply-To: <faa4e196-f8bf-4800-b755-a35e80d41b9f@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Nov 2025 17:29:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hrChRW84d+3vjuzQCASas1n3m5uQNLPf0yqH5ACfoNhQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmG5iF_PFy1DE5Su2UQMwIkx95qIhcTSXaJc3SEgpWd9oM6xuv_oufMiFE
Message-ID: <CAJZ5v0hrChRW84d+3vjuzQCASas1n3m5uQNLPf0yqH5ACfoNhQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
To: Christian Loehle <christian.loehle@arm.com>
Cc: Reka Norman <rekanorman@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:45=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/17/25 05:14, Reka Norman wrote:
> > On Fri, Nov 14, 2025 at 7:33=E2=80=AFPM Christian Loehle
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
> >> For completeness:
> >>
> >> Per-Cluster deltas: BIG
> >>
> >> +---------+-------+--------------+------------+---------+--------+----=
----+---------+--------+---------+
> >> | cluster | state | name         | time=CE=94      | time%   | usage=
=CE=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> >> | BIG     |     0 | WFI          | 957,853    |   2.99% | 2,537  | 0  =
    |   0.00% | 0      |   0.00% |
> >> | BIG     |     1 | cpuoff-b     | 163,636    |   0.51% | 21     | 18 =
    |  85.71% | 3      |  14.29% |
> >> | BIG     |     2 | clusteroff-b | 30,918,285 |  96.50% | 501    | 128=
    |  25.55% | 0      |   0.00% |
> >> | BIG     |     3 | s2idle       | 0          |   0.00% | 0      | 0  =
    |   0.00% | 0      |   0.00% |
> >> | BIG     | TOTAL |              | 32,039,774 | 100.00% | 3,059  | 146=
    |   4.77% | 3      |   0.10% |
> >> +---------+-------+--------------+------------+---------+--------+----=
----+---------+--------+---------+
> >>
> >> Per-Cluster deltas: LITTLE
> >>
> >> +---------+-------+--------------+-------------+---------+--------+---=
-----+---------+--------+---------+
> >> | cluster | state | name         | time=CE=94       | time%   | usage=
=CE=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> >> | LITTLE  |     0 | WFI          | 8,424,141   |   6.63% | 16,629 | 0 =
     |   0.00% | 0      |   0.00% |
> >> | LITTLE  |     1 | cpuoff-l     | 11,121,561  |   8.75% | 485    | 96=
     |  19.79% | 388    |  80.00% |
> >> | LITTLE  |     2 | clusteroff-l | 107,499,073 |  84.62% | 2,705  | 1,=
001  |  37.01% | 0      |   0.00% |
> >> | LITTLE  |     3 | s2idle       | 0           |   0.00% | 0      | 0 =
     |   0.00% | 0      |   0.00% |
> >> | LITTLE  | TOTAL |              | 127,044,775 | 100.00% | 19,819 | 1,=
097  |   5.54% | 388    |   1.96% |
> >> +---------+-------+--------------+-------------+---------+--------+---=
-----+---------+--------+---------+
> >>
> >> Per-Cluster deltas: MID
> >>
> >> +---------+-------+--------------+------------+---------+--------+----=
----+---------+--------+---------+
> >> | cluster | state | name         | time=CE=94      | time%   | usage=
=CE=94 | above=CE=94 | above%  | below=CE=94 | below%  |
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> >> | MID     |     0 | WFI          | 2,593,501  |   2.72% | 7,278  | 0  =
    |   0.00% | 0      |   0.00% |
> >> | MID     |     1 | cpuoff-m     | 188,793    |   0.20% | 51     | 48 =
    |  94.12% | 3      |   5.88% |
> >> | MID     |     2 | clusteroff-m | 92,616,252 |  97.08% | 605    | 257=
    |  42.48% | 0      |   0.00% |
> >> | MID     |     3 | s2idle       | 0          |   0.00% | 0      | 0  =
    |   0.00% | 0      |   0.00% |
> >> | MID     | TOTAL |              | 95,398,546 | 100.00% | 7,934  | 305=
    |   3.84% | 3      |   0.04% |
> >> +---------+-------+--------------+------------+---------+--------+----=
----+---------+--------+---------+
> >>
> >> Out of curiosity:
> >> Do you know if the platform respects cpuoff / clusteroff distinction
> >> properly? Is the power difference measurable?
> >
> > No, I=E2=80=99m not really familiar with the details myself. I=E2=80=99=
ll check if
> > others know more. I did a quick test with disabling cpuoff on all
> > cores, then disabling clusteroff on all cores. The power does seem to
> > be slightly higher with clusteroff disabled, but the difference is
> > barely above the noise level so I=E2=80=99m not certain.
> >
> >> There really is no reason for cpuidle to not autopromote them, if ther=
e's no latency
> >> requirement that would prevent that.
> >> Especially for the big cluster (just one CPU).
> >
> > For my understanding, could you explain a bit more what you mean? It=E2=
=80=99s
> > already spending a lot less time in cpuoff than clusteroff. Would you
> > expect to see even less time in cpuoff (and 0 for the big core)?
>
> So the clusteroff states for psci in PC mode are exposed per-CPU, like he=
re, but
> since it (usually) refers to powering down the voltage rail of that clust=
er it
> requires all CPUs of that cluster to be in the clusteroff state to actual=
ly be
> entered (kernel is unaware of what state actually happened, only which on=
e it requested).
> What's special about your platform though:
> The target residency (How long do I need to be in this state for the ente=
ring+exiting
> to pay off energy-wise) of cpuoff and clusteroff is equal. Therefore if y=
ou don't
> care about the wakeup latency, clusteroff should be the strictly better c=
hoice from a
> governor perspective (If a cluster can't be powered off because >=3D1 CPU=
s aren't in
> clusteroff, the clusteroff-selected CPUs will still go cpuoff).
> Additionally the big CPU is (I'm assuming) alone on a cluster, therefore =
if it doesn't
> need the latency requirement it should never go cpuoff, always (actual) c=
lusteroff.
>
> The fact that teo still selects cpuoff is due to much of the logic workin=
g on per-state
> bins. It's rather an artifact than intended behaviour.

I think what happens is that in teo_select(), the main check for the
deepest enabled state selection is false, but the tick has been
stopped, so the governor selects the previous deepest state that
happens to have the same target residency.

It looks like a check against the target residency of the deepest
state should be added there, but I'd prefer to do it on top of
https://lore.kernel.org/linux-pm/2418792.ElGaqSPkdT@rafael.j.wysocki/.

