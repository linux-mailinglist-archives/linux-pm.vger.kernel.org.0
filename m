Return-Path: <linux-pm+bounces-37764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F32B5C494EE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 21:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63071886FF5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31A2D949F;
	Mon, 10 Nov 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV8trtEQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1A2ED17A
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807903; cv=none; b=O3GrmtG6iKRBBRMIfE1jrSS/FLFJNycS4PkRXKgJ/2nNAHhIx0ekNbQ7MFYEOME4/2+LjhEs5JT4IiUdziPIy+zB4gR1tTuyZ+0+1ssPvjtbwIB4RDeLT7AfyOf9+4053yjnpNrs9KPiNMryGvhiVW+XYQ3qI6MJwFDhCr7hvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807903; c=relaxed/simple;
	bh=YZukvOVhSbLX/CxGme7wIze2PIRMkciF6eEfuSXc01w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7FXjC1OUVNy83/bWGWXsbfylKCLFvKY0nmW60+w3WakQMFSQED8n/iTj0BtqAq9Ew3zSujaVku/gdgr7USN8XJ/dGF4113S1U0b2DL/yMvM4lMfTmtMtcdXw1Gpy+MjyNsljVn9EKOlrnSBYClgemLSVOIgbD0V2ha8/TK8fQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV8trtEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9274BC4CEFB
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762807902;
	bh=YZukvOVhSbLX/CxGme7wIze2PIRMkciF6eEfuSXc01w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nV8trtEQuS6C9Qh+TwXwn5EwdWX/or/oaqmJ6u1w4xZomLbBXzbQux4/5PczGxFgG
	 uEBQmaslFzg2RXn3R7X8VaWO+2m4NKCpx0NC6Xo+ZPgc89Andm1lxkmemxRzIpqlrH
	 fyLMNElneRjUH4N311aNhqZ1zkt1M4gCjV1Aw9NAl6SWPy4tlcZh/ytz/mJtvLZ1Y2
	 kaKNXPm+8A88fmltqpS9C5U5wv4GfT4vqvvjJ/eDkuVhGD59EmA3kbJcX+Frpru1wm
	 UissaVXX9AdIn3wt7SSID1dkz/wcU9NcfFe2sMbEw4c2rNYjdjclalGAtmQdJSGnPQ
	 rVcnTVQ83TCCg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4505b05e7b5so224653b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 12:51:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWM1tE+F6x4hS+Ax6CKO4tKfqiq/cj2Xs4EpSHlI4cGXhDr4QQ9nLtsfBsXsCtU8EUWpi4+lqUYcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlI1ysaYh9In+O83qJiTErQNK1qVi8VTfPeHETGPUf8jxCyyu
	lelFjd/7U32yXcO5s+9HjmzLIC3yXhj3DcFZr22/hiiFqJyYNv+JNvglkSG01w/ytapS6fNItNX
	z5LRsYnbqPI6wC978XBS10RmWQ0l1kM8=
X-Google-Smtp-Source: AGHT+IGRmx0CnLoML9ljfwrumtkNpoESU1U1ml9ihTnkqqBBi1B/PY6ov2T3iBZGU5Mn2ml5yay7n0zfbxeckUC1TCY=
X-Received: by 2002:a05:6808:178b:b0:44d:b72e:ec1a with SMTP id
 5614622812f47-4502a3a578cmr4975558b6e.45.1762807901813; Mon, 10 Nov 2025
 12:51:41 -0800 (PST)
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
In-Reply-To: <CAEmPcwvui5Cg5yoa9NEq5b3OZREb08tbmy4=f=adTLuLPBgGgw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Nov 2025 21:51:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_aLmUGS6obRd7ww5RWtZAh2hCshb3g4MH_hdsEjUojg@mail.gmail.com>
X-Gm-Features: AWmQ_bk8vcrkzHbMKdWTgZQ_DU9GrY-cdaAHwkkDsZbJBtUZt-IfCTC3p7PNmcs
Message-ID: <CAJZ5v0j_aLmUGS6obRd7ww5RWtZAh2hCshb3g4MH_hdsEjUojg@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Reka Norman <rekanorman@chromium.org>, Christian Loehle <christian.loehle@arm.com>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:11=E2=80=AFAM Reka Norman <rekanorman@chromium.or=
g> wrote:
>
> On Mon, Nov 10, 2025 at 7:35=E2=80=AFAM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 11/7/25 11:35, Rafael J. Wysocki wrote:
> > > On Fri, Nov 7, 2025 at 4:28=E2=80=AFAM Reka Norman <rekanorman@chromi=
um.org> wrote:
> > >>
> > >> On Fri, Nov 7, 2025 at 7:33=E2=80=AFAM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > >>>
> > >>> On Thu, Nov 6, 2025 at 12:13=E2=80=AFPM Christian Loehle
> > >>> <christian.loehle@arm.com> wrote:
> > >>>>
> > >>>> On 11/5/25 20:48, Rafael J. Wysocki wrote:
> > >>>>> On Wed, Nov 5, 2025 at 12:24=E2=80=AFAM Christian Loehle
> > >>>>> <christian.loehle@arm.com> wrote:
> > >>>>>>
> > >>>>>> On 11/4/25 09:03, Christian Loehle wrote:
> > >>>>>>> On 11/4/25 03:36, Reka Norman wrote:
> > >>>>>>>> Hi,
> > >>>>>>>>
> > >>>>>>>> I=E2=80=99m seeing a regression in the TEO governor between 6.=
6 and 6.12. At
> > >>>>>>>> 6.12, when the system is idle it=E2=80=99s spending almost 100=
% of time in
> > >>>>>>>> WFI, compared to about 6% at 6.6. At mainline it has improved =
compared
> > >>>>>>>> to 6.12 but is still a lot worse than 6.6, spending about 50% =
in WFI.
> > >>>>>>>>
> > >>>>>>>> The system is a ChromeOS device with Mediatek MT8196.
> > >>>>>>>>
> > >>>>>>>> Bisecting showed the specific commit which caused the regressi=
on is:
> > >>>>>>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercep=
ts")
> > >>>>>>>>
> > >>>>>>>> I=E2=80=99ve attached sysfs dumps showing the issue. All were =
taken a couple
> > >>>>>>>> of minutes after boot, with the device having been idle since =
boot.
> > >>>>>>>> The cases tested are:
> > >>>>>>>> cpuidle_6_6.txt      =3D 6.6 kernel
> > >>>>>>>> cpuidle_6_12.txt     =3D 6.6 kernel with teo commits up to 6.1=
2
> > >>>>>>>> cpuidle_mainline.txt =3D 6.6 kernel with teo commits up to mai=
nline
> > >>>>>>>>
> > >>>>>>>> Summary of the percentage time spent in each state (averaged a=
cross CPUs):
> > >>>>>>>>
> > >>>>>>>> |            |   6.6 |  6.12 | mainline |
> > >>>>>>>> |------------|------:|------:|---------:|
> > >>>>>>>> | WFI        |  6.02 | 99.94 |    56.84 |
> > >>>>>>>> | cpuoff     | 11.02 |     0 |     0.65 |
> > >>>>>>>> | clusteroff | 82.96 |  0.05 |    42.51 |
> > >>>>>>>> | s2idle     |     0 |     0 |        0 |
> > >>>>>>>>
> > >>>>>>>> Any help would be much appreciated. Let me know if there's any=
 other
> > >>>>>>>> debugging information I should provide.
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> That's not good.
> > >>>>>>> If the system is mostly idle (only boot activity but dumps are =
taken after
> > >>>>>>> ~3mins?), what is causing the wakeups? Even in 6.6 There are de=
finitely more
> > >>>>>>> than I would've expected?
> > >>>>>>> I noticed that clusteroff and cpuoff have equal residency, whic=
h is
> > >>>>>>> obviously a bit awkward for cpuidle, but shouldn't be relevant =
to your issue.
> > >>>>>>>
> > >>>>>>> I'm a bit puzzled by your bisect results.
> > >>>>>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercept=
s")
> > >>>>>>> made the intercept logic *less* prone to count (false) intercep=
ts, yet it
> > >>>>>>> seems to count more of them? (resulting in more WFI).
> > >>>>>>> I'll think about it some more, for now of course a trace would =
be very
> > >>>>>>> helpful. (cpuidle events, ipi_raise, irqs?)
> > >>>>>>> Are there ever any latency constraints set?
> > >>>>>>>
> > >>>>>>> FWIW the mainline results look the most reasonable, from a 3000=
0 feet view
> > >>>>>>> anyway:
> > >>>>>>> Cluster       State           above   below   usage   above%  b=
elow%
> > >>>>>>> LITTLE        cpuoff-l        ~75     ~65     ~140    23%     2=
0%
> > >>>>>>> LITTLE        clusteroff-l    ~800    0       ~100    89%     0=
%
> > >>>>>>> MID   cpuoff-m        ~3=E2=80=934    ~15     ~20     15%     5=
5%
> > >>>>>>> MID   clusteroff-m    ~1300   0       ~4000   24%     0%
> > >>>>>>> BIG   cpuoff-b        0       1       1       =E2=80=94       =
=E2=80=94
> > >>>>>>> BIG   clusteroff-b    ~800    0       ~1900   30%     0%
> > >>>>>>>
> > >>>>>>> (WFI seems mostly the correct choice for little CPUs, that's fi=
ne, the energy
> > >>>>>>> savings compared to cpuoff should be marginal anyway.)
> > >>>>>>>
> > >>>>>>> Do you mind trying:
> > >>>>>>> 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wak=
eups are very frequent
> > >>>>>>> on 6.12?
> > >>>>>>>
> > >>>>>>
> > >>>>>> So just thinking out loud, the only case I can actually thing of=
 to explain your
> > >>>>>> bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existent =
intercepts")
> > >>>>>> is that the workload essentially changed dramatically because of=
 our calls
> > >>>>>> to tick_nohz_get_sleep_length() now.
> > >>>>>> I'm not sure how likely I think that is, but I'm lacking imagina=
tion for another
> > >>>>>> cause. That's why results with
> > >>>>>> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wa=
keups are very frequent")
> > >>>>>> would be interesting.
> > >>>>>
> > >>>>> My current theory is that this issue is related to the
> > >>>>> tick_nohz_get_sleep_length() overhead and the way "intercepts" ar=
e
> > >>>>> distinguished from "hits" in teo.
> > >>>>>
> > >>>>> Namely, teo assumes that its own overhead is negligible and so it
> > >>>>> counts a given event as an "intercept" if the measured time spent=
 in
> > >>>>> the idle state (with the exit latency roughly taken into account)
> > >>>>> falls into a different "state bin" than the sleep length (the exp=
ected
> > >>>>> time till the next timer).  However, the sleep length is computed=
 as a
> > >>>>> difference between the upcoming timer wakeup event time and
> > >>>>> ts->idle_entrytime, so it actually includes the time taken by
> > >>>>> tick_nohz_next_event().  If the latter is significant, it may
> > >>>>> contribute to the difference seen by teo_update() and cause extra
> > >>>>> "intercepts" to appear.
> > >>>>
> > >>>> Right, additionally with psci pc-mode and the exposed clusteroff s=
tates we end
> > >>>> up vastly exaggerating the wakeup latency (i.e. underestimating th=
e actual idle time)
> > >>>> for three reasons:
> > >>>> - wakeup latency =3D entry+exit latency (worst case: pay full late=
ncies on both
> > >>>> even though for most cases we don't incur the entry latency)
> > >>>> - Wakeup latency is a worst-case and often is more like 2x-3x of t=
he average.
> > >>>> - We use the (higher) clusteroff values even though the clusteroff=
 state couldn't
> > >>>> possibly have been entered as not the entire cluster is idle.
> > >>>>
> > >>>> Nonetheless these are all just a "intercept counting is significan=
tly more likely"
> > >>>> while the results show not a single state >0 entered =3D> the inte=
rcept logic
> > >>>> probably triggers every cpuidle entry.
> > >>>
> > >>> It has to for this to happen, if timers are not frequent enough.
> > >>>
> > >>>> Feels like there should be an issue in the feedback loop.
> > >>>
> > >>> I'm wondering what the issue could be though.  The change in commit
> > >>> 4b20b07ce72f only affects the cases when idle state 0 is about to b=
e
> > >>> selected and it only really changes the sleep length value from
> > >>> KTIME_MAX to something more realistic (but it still may be KTIME_MA=
X).
> > >>>
> > >>> It may turn an "intercept" into a "hit", but only if the CPU is not
> > >>> woken up by the tick because those cases had been already counted a=
s
> > >>> "hits" before commit 4b20b07ce72f.
> > >>>
> > >>> Now, if the majority of wakeups in the workload are tick wakeups, t=
he
> > >>> only real difference appears to be the presence of
> > >>> tick_nohz_get_sleep_length() in that code path.
> > >>>
> > >>> Frankly, I would try to remove the update of cpu_data->sleep_length=
_ns
> > >>> right before the "goto out_tick" statement (in 6.12 that should be
> > >>> line 426) and see what happens.
> > >>
> > >> Just tried this quickly. Results attached. It goes back to behaving
> > >> the same as 6.6 - about 2% WFI.
> > >
> > > Thanks for checking this!  It means that the
> > > tick_nohz_get_sleep_length() overhead doesn't matter here that much.
> > >
> > > Instead of making the change above, can you please try the 6.12
> > > equivalent of the attached patch?
> > >
> > > Or alternatively, apply this one to the mainline and see if it change=
s
> > > the idle states selection proportions?
>
> It doesn't seem to have an effect. Results are attached for both 6.12
> (6_12_teo_reflect) and mainline (mainline_teo_reflect). 6.12 is still
> 100% WFI and mainline is about 20% WFI on average, the same as before.

This means that the issue is there regardless of how tick wakeups are count=
ed.

> >
> > I don't quite follow this.
> > While I don't really believe that the tick_nohz_get_sleep_length() over=
head
> > plays a role here, how does removing that assignment prove it isn't?
> >
> > The below (if that's what you meant) might lead to the overhead being o=
ptimized
> > out? [1]

It might, but I only wanted to say that the overhead of
tick_nohz_get_sleep_length() in the idx =3D=3D 0 path is most likely
irrelevant to the problem at hand.  Sorry for the confusion.

> Oh true. I tried the diff below instead (which I think should avoid
> that?). This also behaves the same as 6.6. Results attached as
> 6_12_sleep_length2.
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index 173ddcac540a..3c9595bc6c80 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -427,8 +427,7 @@ static int teo_select(struct cpuidle_driver *drv,
> struct cpuidle_device *dev,
>                  * We have to query the sleep length here otherwise we do=
n't
>                  * know after wakeup if our guess was correct.
>                  */
> -               duration_ns =3D tick_nohz_get_sleep_length(&delta_tick);
> -               cpu_data->sleep_length_ns =3D duration_ns;
> +               volatile s64 __maybe_unused duration_volatile_ns =3D
> tick_nohz_get_sleep_length(&delta_tick);
>                 goto out_tick;
>         }
>
> > I'd be curious if [2] behaves like 6.12. So far I haven't been able to
> > reproduce the issue Reka is seeing.
>
> Results with [2] attached as 6_12_sleep_length3. Yes, it behaves like 6.1=
2.

If the tick period is 10 ms, TICK_NSEC / 2 is well above the target
residency of the deepest idle state, so the only thing that can be
affected by [2] is the check in teo_reflect() and we have just
established that removing that check altogether doesn't make a
difference.

So this appears to be consistent with the observation that the check
in teo_reflect() is not related directly to the issue at hand.

> > There's one oddity that immediately came to mind: state1 and state2 hav=
ing
> > the same residency (slightly different latency though), but when I set =
these
> > as such teo works fine. So I don't think it is an issue here.

I agree.

With the tick period of 10 ms, the only case in which the tick can be
stopped is when the deepest idle state is selected, but that can only
happen if the pattern of wakeups is not dominated by intercepts.
That's why removing intercepts from the picture causes it to look
"better".

Evidently, intercepts are there both in 6.12 and in the mainline and
while we may be wondering whether or not they are real intercepts, I'm
not sure if this actually matters.

To me, the primary question is what had caused these intercepts to not
be there before 6.12 and quite frankly I'm not sure what it was ATM.

