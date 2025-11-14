Return-Path: <linux-pm+bounces-38040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370AC5D8AA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 15:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D93C44F2809
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D9030B50A;
	Fri, 14 Nov 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD5h+ifW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E535CBD3
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129772; cv=none; b=qjl+0halZordV1YBaWzoIm+3ihK1DPa6obmEqrrX6U4ByK7vqHMuXCVrL91PopFH1ObJMjv7meYHugTBUXxaqJ12rVcNS1jq94VYiw1vZkm3sK9YtLxMOgNIKk6lmqOTZDMJrGSHBbrRMl8APnApKbczfCkv5HT8ATD6F6de6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129772; c=relaxed/simple;
	bh=CY/43TKGyTJGl+lStS+Y2MgI5etM774AT71I4+JrUcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqwpjLgbSMrWdVGntv+aSXLynturYFrgpQZh5zKpMgo57KR8F7yvH6jXE7j/40JmtQ3G/M0avsDZwcumjHcWNQGfaesqo1mJRd0mRSrbyMAblDyMjylZDod6G/aC0w4vXGPDYTTHLlCjIgPbw8jPtx1K8D0ajejtVOmXvugz2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD5h+ifW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646FEC4CEF1
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763129771;
	bh=CY/43TKGyTJGl+lStS+Y2MgI5etM774AT71I4+JrUcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QD5h+ifWs2FhRJgxlIs9P4xm1EFbhXR9AiUWuAo5i0WJnNCqR08S0jSJ6c6NMop79
	 C07PSZMPMLJDBDQXCDhUem2FqHTM+4hWsRmulej+JSXi/s5HXF0s9H0zCo4pwuU0RQ
	 vHBiyeMF2h3S1ewVgp2DoJRtcf+Dxoaqm+4wsRAFYcDFElnawxzHkjTsmS6M7ShNcQ
	 P2BrtOaIkQKfMhQUWH87wbYAyuuWiGcVFoSS84FBmtnNLmdfwLMrMxT31saXtpnd1n
	 zgU/A4MFaHNNaUjmHNOETnSVJbpCXKaInscL1huv8vsU+WzTVz0br66Xg5EtaXEdNI
	 rgfW3BYY8gCAQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-656b7f02b56so862189eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 06:16:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvI47HU3dzuu4mzZZj4IezGXzIQmIPt1jHG5PtiaAwbIMPZXl9cES1JP7qCLIxYILzDSYqoKwKcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdbEiL8IJONweQ9VFrsEPXigOXikzrtCU5c7K7aQ/o4+jLILd
	pBd4adAOZJxviob1xQ9SlPxnU6fgxoqEHOHNAXeKYkezwUEz+Mnt9ko04dHKQZo3iiRXuianZxh
	R9HiAFvzZ42/+atd7TnJ/hqkg1SMsfv4=
X-Google-Smtp-Source: AGHT+IHFng1++n6E0/dxwv86kGr1OS8kgzH4eMy45CGHgGUX4PL8LF5jfGbJHYq6pOYvn/d3ytG71AsAiBIWv0375o4=
X-Received: by 2002:a05:6820:c084:b0:651:c2cf:8c8c with SMTP id
 006d021491bc7-657232439dcmr2294898eaf.0.1763129770683; Fri, 14 Nov 2025
 06:16:10 -0800 (PST)
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
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 15:15:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0huP6hjDzJ9HoAmUVaS1ss2g0baMROiAz9cqkgmOn1kHQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl-7ELt7drLwyrbbWe4YyfyJGHTCvkPBYLWf6QowBml1SQJp9sv8wAyGq0
Message-ID: <CAJZ5v0huP6hjDzJ9HoAmUVaS1ss2g0baMROiAz9cqkgmOn1kHQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
To: Christian Loehle <christian.loehle@arm.com>, Reka Norman <rekanorman@chromium.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 9:33=E2=80=AFAM Christian Loehle
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

So I'm going to queue this up for 6.19 along with the material it depends o=
n.

I'd rather not rush it into 6.18-rc7 because it would not get
meaningful exposure in linux-next before appearing in the mainline in
that case.

Reka, I'm going to add your Tested-by: to it, please let me know if
there are any concerns regarding that.

Now, I think that it needs to go into -stable (6.12+ I suppose?) and
I'm going to instruct -stable to pick up the dependencies along with
it.

Thanks!

