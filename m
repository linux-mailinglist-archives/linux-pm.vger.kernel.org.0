Return-Path: <linux-pm+bounces-37786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4729AC4D89E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 12:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C7354FF555
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28402FA0ED;
	Tue, 11 Nov 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0TfWkvH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB92D6624
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861736; cv=none; b=T2DtA5mjXfnEIZ7Ajgh5NdaHxmz56vjwt1q+yIDyW3QqQB+uGVrQYnF4BgcD4K2QLrY+VWuqzMxDlKHhrHpLxjoqLHcnrZOtsNxPnboVzofxMH5myMy3ItjvnZPvvKDAUlVI+sniTcmaPytzZ4FewRUkyT84Vkstg8f4fqZ7jHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861736; c=relaxed/simple;
	bh=pldYe+rsQ0BpIzLwaylofNhggcMdoz5m9YwE1fIVJ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU+JSJF5Ai4sfqYKVad+LQUdPxnH+DopfXatI6ybdSEQbBmBlPlZEZNqV5xerL0Fb48dJwchjm3V0WIkmbeSlyn2uX6uXesm0vE6ktDGMwKrIvc5ye9mqiKlSIY2J54om8RzXl5fBMEU2woXTeDXaUO7Ixz4v4tJGZy5VBAVDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0TfWkvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18673C2BC86
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861736;
	bh=pldYe+rsQ0BpIzLwaylofNhggcMdoz5m9YwE1fIVJ8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j0TfWkvHQEpAN9/dzZeQckYCXM2o+u+4wFr5tf5c1OnrxgYEzk1dugXpX+Fhek4Fc
	 4RW4J/fWa8cVo4FpGs2/T4yQ/ltWrVW1R58HT5H/8x1bL/lUJTnSuXqRzquTX89iIo
	 /qQbwJ98FOprnaRZK1SJxZJOS7SbgG48o0l2cqHrlXr11HAcv1XH4D7QcmGLqy7n6/
	 dFgYfFsbC7+fcE42J2/gwL/MsVg+/kYYfL21YnRussf+8qFB/UgABdCcd9hoIBQVuc
	 DzuLzjcWDBrqBGTyFau7j82ncB8iH625rmF+d0cQzBA3QXgr/vrccFCzc8FzvcNn3X
	 8ruh98LBjHrAw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-656f84c6b92so224207eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 03:48:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRziXY6InpeLvYNwF9sWnn358Aj3sWnGZwE+dd8g9QZ67we6upPA1iADu8yxJVvF5d5OkX6nn0kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZqI5kz6o0JR9EKSXTW9gj0/J7UiFkWXC/PWqrWn5MkWbH7Tk8
	Pjf6TL+R/hMy9aBIRYhZPXt1wu4/lzkqsbs1lKcz+0tfDjOktsLKIwB23rG25WZufR0aYxHaypz
	i1rCFvPPYZjI9VuyAsKXKRr9jK8+1eso=
X-Google-Smtp-Source: AGHT+IG1BbaZm4KXbf5BRI9e9ixlVdB0iZBHZl/awznkhLVMR1Zx0yAm0rZ8Glv6hZpC7uy0fmfmDKLuBe4aKrSGpDA=
X-Received: by 2002:a05:6808:220f:b0:44d:b018:7b8a with SMTP id
 5614622812f47-45060a8ad49mr1314173b6e.23.1762861735112; Tue, 11 Nov 2025
 03:48:55 -0800 (PST)
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
In-Reply-To: <a33965da-81d8-47c5-9fa0-434812f2bd72@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Nov 2025 12:48:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com>
X-Gm-Features: AWmQ_bml0i-YUGLbmqrF5FXa9xZmTxyY6qQbNyV07TSS2UIBSl4P5g4FkcRjtQw
Message-ID: <CAJZ5v0jjswmSsSRqfjrbDVD4rpYvp2qCdweYrK0JV0zUketczQ@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Christian Loehle <christian.loehle@arm.com>
Cc: Reka Norman <rekanorman@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/11/25 10:00, Christian Loehle wrote:
> > On 11/11/25 04:23, Reka Norman wrote:
> >> On Mon, Nov 10, 2025 at 11:06=E2=80=AFPM Christian Loehle
> >> <christian.loehle@arm.com> wrote:
> >>>
> >>> On 11/10/25 06:10, Reka Norman wrote:
> >>>> On Mon, Nov 10, 2025 at 7:35=E2=80=AFAM Christian Loehle
> >>>> <christian.loehle@arm.com> wrote:
> >>>>>
> >>>>> On 11/7/25 11:35, Rafael J. Wysocki wrote:
> >>>>>> On Fri, Nov 7, 2025 at 4:28=E2=80=AFAM Reka Norman <rekanorman@chr=
omium.org> wrote:
> >>>>>>>
> >>>>>>> On Fri, Nov 7, 2025 at 7:33=E2=80=AFAM Rafael J. Wysocki <rafael@=
kernel.org> wrote:
> >>>>>>>>
> >>>>>>>> On Thu, Nov 6, 2025 at 12:13=E2=80=AFPM Christian Loehle
> >>>>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 11/5/25 20:48, Rafael J. Wysocki wrote:
> >>>>>>>>>> On Wed, Nov 5, 2025 at 12:24=E2=80=AFAM Christian Loehle
> >>>>>>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On 11/4/25 09:03, Christian Loehle wrote:
> >>>>>>>>>>>> On 11/4/25 03:36, Reka Norman wrote:
> >>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I=E2=80=99m seeing a regression in the TEO governor between=
 6.6 and 6.12. At
> >>>>>>>>>>>>> 6.12, when the system is idle it=E2=80=99s spending almost =
100% of time in
> >>>>>>>>>>>>> WFI, compared to about 6% at 6.6. At mainline it has improv=
ed compared
> >>>>>>>>>>>>> to 6.12 but is still a lot worse than 6.6, spending about 5=
0% in WFI.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The system is a ChromeOS device with Mediatek MT8196.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Bisecting showed the specific commit which caused the regre=
ssion is:
> >>>>>>>>>>>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent inter=
cepts")
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I=E2=80=99ve attached sysfs dumps showing the issue. All we=
re taken a couple
> >>>>>>>>>>>>> of minutes after boot, with the device having been idle sin=
ce boot.
> >>>>>>>>>>>>> The cases tested are:
> >>>>>>>>>>>>> cpuidle_6_6.txt      =3D 6.6 kernel
> >>>>>>>>>>>>> cpuidle_6_12.txt     =3D 6.6 kernel with teo commits up to =
6.12
> >>>>>>>>>>>>> cpuidle_mainline.txt =3D 6.6 kernel with teo commits up to =
mainline
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Summary of the percentage time spent in each state (average=
d across CPUs):
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> |            |   6.6 |  6.12 | mainline |
> >>>>>>>>>>>>> |------------|------:|------:|---------:|
> >>>>>>>>>>>>> | WFI        |  6.02 | 99.94 |    56.84 |
> >>>>>>>>>>>>> | cpuoff     | 11.02 |     0 |     0.65 |
> >>>>>>>>>>>>> | clusteroff | 82.96 |  0.05 |    42.51 |
> >>>>>>>>>>>>> | s2idle     |     0 |     0 |        0 |
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Any help would be much appreciated. Let me know if there's =
any other
> >>>>>>>>>>>>> debugging information I should provide.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> That's not good.
> >>>>>>>>>>>> If the system is mostly idle (only boot activity but dumps a=
re taken after
> >>>>>>>>>>>> ~3mins?), what is causing the wakeups? Even in 6.6 There are=
 definitely more
> >>>>>>>>>>>> than I would've expected?
> >>>>>>>>>>>> I noticed that clusteroff and cpuoff have equal residency, w=
hich is
> >>>>>>>>>>>> obviously a bit awkward for cpuidle, but shouldn't be releva=
nt to your issue.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'm a bit puzzled by your bisect results.
> >>>>>>>>>>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent interc=
epts")
> >>>>>>>>>>>> made the intercept logic *less* prone to count (false) inter=
cepts, yet it
> >>>>>>>>>>>> seems to count more of them? (resulting in more WFI).
> >>>>>>>>>>>> I'll think about it some more, for now of course a trace wou=
ld be very
> >>>>>>>>>>>> helpful. (cpuidle events, ipi_raise, irqs?)
> >>>>>>>>>>>> Are there ever any latency constraints set?
> >>>>>>>>>>>>
> >>>>>>>>>>>> FWIW the mainline results look the most reasonable, from a 3=
0000 feet view
> >>>>>>>>>>>> anyway:
> >>>>>>>>>>>> Cluster       State           above   below   usage   above%=
  below%
> >>>>>>>>>>>> LITTLE        cpuoff-l        ~75     ~65     ~140    23%   =
  20%
> >>>>>>>>>>>> LITTLE        clusteroff-l    ~800    0       ~100    89%   =
  0%
> >>>>>>>>>>>> MID   cpuoff-m        ~3=E2=80=934    ~15     ~20     15%   =
  55%
> >>>>>>>>>>>> MID   clusteroff-m    ~1300   0       ~4000   24%     0%
> >>>>>>>>>>>> BIG   cpuoff-b        0       1       1       =E2=80=94     =
  =E2=80=94
> >>>>>>>>>>>> BIG   clusteroff-b    ~800    0       ~1900   30%     0%
> >>>>>>>>>>>>
> >>>>>>>>>>>> (WFI seems mostly the correct choice for little CPUs, that's=
 fine, the energy
> >>>>>>>>>>>> savings compared to cpuoff should be marginal anyway.)
> >>>>>>>>>>>>
> >>>>>>>>>>>> Do you mind trying:
> >>>>>>>>>>>> 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if =
wakeups are very frequent
> >>>>>>>>>>>> on 6.12?
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> So just thinking out loud, the only case I can actually thing=
 of to explain your
> >>>>>>>>>>> bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existe=
nt intercepts")
> >>>>>>>>>>> is that the workload essentially changed dramatically because=
 of our calls
> >>>>>>>>>>> to tick_nohz_get_sleep_length() now.
> >>>>>>>>>>> I'm not sure how likely I think that is, but I'm lacking imag=
ination for another
> >>>>>>>>>>> cause. That's why results with
> >>>>>>>>>>> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if=
 wakeups are very frequent")
> >>>>>>>>>>> would be interesting.
> >>>>>>>>>>
> >>>>>>>>>> My current theory is that this issue is related to the
> >>>>>>>>>> tick_nohz_get_sleep_length() overhead and the way "intercepts"=
 are
> >>>>>>>>>> distinguished from "hits" in teo.
> >>>>>>>>>>
> >>>>>>>>>> Namely, teo assumes that its own overhead is negligible and so=
 it
> >>>>>>>>>> counts a given event as an "intercept" if the measured time sp=
ent in
> >>>>>>>>>> the idle state (with the exit latency roughly taken into accou=
nt)
> >>>>>>>>>> falls into a different "state bin" than the sleep length (the =
expected
> >>>>>>>>>> time till the next timer).  However, the sleep length is compu=
ted as a
> >>>>>>>>>> difference between the upcoming timer wakeup event time and
> >>>>>>>>>> ts->idle_entrytime, so it actually includes the time taken by
> >>>>>>>>>> tick_nohz_next_event().  If the latter is significant, it may
> >>>>>>>>>> contribute to the difference seen by teo_update() and cause ex=
tra
> >>>>>>>>>> "intercepts" to appear.
> >>>>>>>>>
> >>>>>>>>> Right, additionally with psci pc-mode and the exposed clusterof=
f states we end
> >>>>>>>>> up vastly exaggerating the wakeup latency (i.e. underestimating=
 the actual idle time)
> >>>>>>>>> for three reasons:
> >>>>>>>>> - wakeup latency =3D entry+exit latency (worst case: pay full l=
atencies on both
> >>>>>>>>> even though for most cases we don't incur the entry latency)
> >>>>>>>>> - Wakeup latency is a worst-case and often is more like 2x-3x o=
f the average.
> >>>>>>>>> - We use the (higher) clusteroff values even though the cluster=
off state couldn't
> >>>>>>>>> possibly have been entered as not the entire cluster is idle.
> >>>>>>>>>
> >>>>>>>>> Nonetheless these are all just a "intercept counting is signifi=
cantly more likely"
> >>>>>>>>> while the results show not a single state >0 entered =3D> the i=
ntercept logic
> >>>>>>>>> probably triggers every cpuidle entry.
> >>>>>>>>
> >>>>>>>> It has to for this to happen, if timers are not frequent enough.
> >>>>>>>>
> >>>>>>>>> Feels like there should be an issue in the feedback loop.
> >>>>>>>>
> >>>>>>>> I'm wondering what the issue could be though.  The change in com=
mit
> >>>>>>>> 4b20b07ce72f only affects the cases when idle state 0 is about t=
o be
> >>>>>>>> selected and it only really changes the sleep length value from
> >>>>>>>> KTIME_MAX to something more realistic (but it still may be KTIME=
_MAX).
> >>>>>>>>
> >>>>>>>> It may turn an "intercept" into a "hit", but only if the CPU is =
not
> >>>>>>>> woken up by the tick because those cases had been already counte=
d as
> >>>>>>>> "hits" before commit 4b20b07ce72f.
> >>>>>>>>
> >>>>>>>> Now, if the majority of wakeups in the workload are tick wakeups=
, the
> >>>>>>>> only real difference appears to be the presence of
> >>>>>>>> tick_nohz_get_sleep_length() in that code path.
> >>>>>>>>
> >>>>>>>> Frankly, I would try to remove the update of cpu_data->sleep_len=
gth_ns
> >>>>>>>> right before the "goto out_tick" statement (in 6.12 that should =
be
> >>>>>>>> line 426) and see what happens.
> >>>>>>>
> >>>>>>> Just tried this quickly. Results attached. It goes back to behavi=
ng
> >>>>>>> the same as 6.6 - about 2% WFI.
> >>>>>>
> >>>>>> Thanks for checking this!  It means that the
> >>>>>> tick_nohz_get_sleep_length() overhead doesn't matter here that muc=
h.
> >>>>>>
> >>>>>> Instead of making the change above, can you please try the 6.12
> >>>>>> equivalent of the attached patch?
> >>>>>>
> >>>>>> Or alternatively, apply this one to the mainline and see if it cha=
nges
> >>>>>> the idle states selection proportions?
> >>>>
> >>>> It doesn't seem to have an effect. Results are attached for both 6.1=
2
> >>>> (6_12_teo_reflect) and mainline (mainline_teo_reflect). 6.12 is stil=
l
> >>>> 100% WFI and mainline is about 20% WFI on average, the same as befor=
e.
> >>>>
> >>>>>
> >>>>> I don't quite follow this.
> >>>>> While I don't really believe that the tick_nohz_get_sleep_length() =
overhead
> >>>>> plays a role here, how does removing that assignment prove it isn't=
?
> >>>>>
> >>>>> The below (if that's what you meant) might lead to the overhead bei=
ng optimized
> >>>>> out? [1]
> >>>>
> >>>> Oh true. I tried the diff below instead (which I think should avoid
> >>>> that?). This also behaves the same as 6.6. Results attached as
> >>>> 6_12_sleep_length2.
> >>>
> >>> Thanks for testing
> >>>
> >>>>
> >>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/gover=
nors/teo.c
> >>>> index 173ddcac540a..3c9595bc6c80 100644
> >>>> --- a/drivers/cpuidle/governors/teo.c
> >>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>> @@ -427,8 +427,7 @@ static int teo_select(struct cpuidle_driver *drv=
,
> >>>> struct cpuidle_device *dev,
> >>>>                  * We have to query the sleep length here otherwise =
we don't
> >>>>                  * know after wakeup if our guess was correct.
> >>>>                  */
> >>>> -               duration_ns =3D tick_nohz_get_sleep_length(&delta_ti=
ck);
> >>>> -               cpu_data->sleep_length_ns =3D duration_ns;
> >>>> +               volatile s64 __maybe_unused duration_volatile_ns =3D
> >>>> tick_nohz_get_sleep_length(&delta_tick);
> >>>>                 goto out_tick;
> >>>>         }
> >>>>
> >>>>> I'd be curious if [2] behaves like 6.12. So far I haven't been able=
 to
> >>>>> reproduce the issue Reka is seeing.
> >>>>
> >>>> Results with [2] attached as 6_12_sleep_length3. Yes, it behaves lik=
e 6.12.
> >>>>
> >>>
> >>> Hmm interesting.
> >>>
> >>>>> There's one oddity that immediately came to mind: state1 and state2=
 having
> >>>>> the same residency (slightly different latency though), but when I =
set these
> >>>>> as such teo works fine. So I don't think it is an issue here.
> >>>>>
> >>>>> If Rafael's patch fixes the issue I'd still be curious what the pre=
dicted sleep
> >>>>> length values are here (they must be <1ms, but do in fact never tri=
gger?).
> >>>>
> >>>> In case it's helpful, I've attached a trace (trace_duration.dat) whi=
ch
> >>>> includes a trace_printk of the duration_ns at this point (on top of
> >>>> unmodified 6.12).
> >>> While I was gonna ask for this anyway, it's not that useful (duration=
_ns is some
> >>> time in the far future, most wakeups are obviously ticks).
> >>> May I ask you to run the following hopefully one last time, just to c=
heck if we're
> >>> not missing something here:
> >>
> >> Trace attached.
> >>
> >
> > Thank you!
> > So the intercept bin counts themselves aren't the issue:
> >           <idle>-0     [007] d..1.  1097.218324: bprint:               =
teo_update: teo_update cpu=3D7 last_state_idx=3D0 state_count=3D4 total=3D7=
182 sleep_len_ns=3D62615312 last_residency_ns=3D997307 measured_ns=3D184467=
44073709551615 lat_ns=3D1000 idx_timer=3D2 idx_duration=3D2 tick_hits=3D0 |=
 bins: [0]h=3D7,i=3D7,tr=3D1000 [1]h=3D0,i=3D0,tr=3D2580000 [2]h=3D8192,i=
=3D0,tr=3D2580000 [3]h=3D0,i=3D0,tr=3D4294967295000
> >           <idle>-0     [007] d..1.  1097.218324: cpu_idle:             =
state=3D0 cpu_id=3D7
> >           <idle>-0     [007] d..1.  1097.219321: cpu_idle:             =
state=3D4294967295 cpu_id=3D7
> >           <idle>-0     [007] d.h1.  1097.219322: irq_handler_entry:    =
irq=3D19 name=3Darch_timer
> >           <idle>-0     [007] d.h1.  1097.219323: irq_handler_exit:     =
irq=3D19 ret=3Dhandled
> >           <idle>-0     [007] d..1.  1097.219324: bprint:               =
teo_update: teo_update cpu=3D7 last_state_idx=3D0 state_count=3D4 total=3D7=
182 sleep_len_ns=3D61615389 last_residency_ns=3D997538 measured_ns=3D184467=
44073709551615 lat_ns=3D1000 idx_timer=3D2 idx_duration=3D2 tick_hits=3D0 |=
 bins: [0]h=3D7,i=3D7,tr=3D1000 [1]h=3D0,i=3D0,tr=3D2580000 [2]h=3D8192,i=
=3D0,tr=3D2580000 [3]h=3D0,i=3D0,tr=3D4294967295000
> >           <idle>-0     [007] d..1.  1097.219324: cpu_idle:             =
state=3D0 cpu_id=3D7
> >           <idle>-0     [007] d..1.  1097.220321: cpu_idle:             =
state=3D4294967295 cpu_id=3D7
> >           <idle>-0     [007] d.h1.  1097.220322: irq_handler_entry:    =
irq=3D19 name=3Darch_timer
> >           <idle>-0     [007] d.h1.  1097.220323: irq_handler_exit:     =
irq=3D19 ret=3Dhandled
> >           <idle>-0     [007] d..1.  1097.220324: bprint:               =
teo_update: teo_update cpu=3D7 last_state_idx=3D0 state_count=3D4 total=3D7=
182 sleep_len_ns=3D60615312 last_residency_ns=3D997538 measured_ns=3D184467=
44073709551615 lat_ns=3D1000 idx_timer=3D2 idx_duration=3D2 tick_hits=3D0 |=
 bins: [0]h=3D7,i=3D7,tr=3D1000 [1]h=3D0,i=3D0,tr=3D2580000 [2]h=3D8192,i=
=3D0,tr=3D2580000 [3]h=3D0,i=3D0,tr=3D4294967295000
> >           <idle>-0     [007] d..1.  1097.220324: cpu_idle:             =
state=3D0 cpu_id=3D7
> >           <idle>-0     [007] d..1.  1097.221321: cpu_idle:             =
state=3D4294967295 cpu_id=3D7
> >           <idle>-0     [007] d.h1.  1097.221322: irq_handler_entry:    =
irq=3D19 name=3Darch_timer
> >           <idle>-0     [007] d.h1.  1097.221323: irq_handler_exit:     =
irq=3D19 ret=3Dhandled
> >           <idle>-0     [007] d..1.  1097.221324: bprint:               =
teo_update: teo_update cpu=3D7 last_state_idx=3D0 state_count=3D4 total=3D7=
182 sleep_len_ns=3D59615312 last_residency_ns=3D997538 measured_ns=3D184467=
44073709551615 lat_ns=3D1000 idx_timer=3D2 idx_duration=3D2 tick_hits=3D0 |=
 bins: [0]h=3D7,i=3D7,tr=3D1000 [1]h=3D0,i=3D0,tr=3D2580000 [2]h=3D8192,i=
=3D0,tr=3D2580000 [3]h=3D0,i=3D0,tr=3D4294967295000
> >
> >
> > 386         if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum)
> > will be 2*7 > 8206 - (7 + 8192) =3D> True
> > The intercept state selection will choose a state that covers at least =
half of the
> > intercepts, but only bin 0 has intercepts at all =3D> state0 selected.
> >
> > I see two issues:
> > 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess this would=
n't really be an issue without 2))

This shouldn't be a problem.

> > 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) isn't an =
appropriate check, it will
> > exclude the state if it its idx_hit_sum make up the vast majority of cp=
u_data->total (i.e. it would
> > have been a really good candidate actually).

Well, it would exclude the state if the sum of hits for the states
below it is large enough.  This is questionable (because why would
hits matter here), but I attempted to make the change below and
somebody reported a regression IIRC.

This check is related to the problem at hand though (see below).

> >
> > I lightly tested the below, it seems to be at least comparable to mainl=
ine teo.
> > (the documentation/comments would need adapting too, of course)
> >
> > -----8<-----
> >
> > diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governor=
s/teo.c
> > index bfa55c1eab5b..f8f76e3b8364 100644
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver *drv, s=
truct cpuidle_device *dev,
> >          * all of the deeper states, a shallower idle state is likely t=
o be a
> >          * better choice.
> >          */
> > -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
> > +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >                 int first_suitable_idx =3D idx;
> >
> >                 /*
> >
> >
>
> ... nevermind the patch, idx_hit_sum is of course the sum of 0...idx-1.
> Maybe something like this, again lightly tested:
>
> -----8<-----
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index 173ddcac540a..6bfb9cedb75e 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver *drv, s=
truct cpuidle_device *dev,
>                  * has been stopped already into account.
>                  */
>                 intercept_sum =3D 0;
> +               hit_sum =3D 0;
>
>                 for (i =3D idx - 1; i >=3D 0; i--) {
>                         struct teo_bin *bin =3D &cpu_data->state_bins[i];
>
>                         intercept_sum +=3D bin->intercepts;
> +                       hit_sum +=3D bin->hits;
>
> -                       if (2 * intercept_sum > idx_intercept_sum) {
> +                       if (2 * intercept_sum > cpu_data->total || 2 * hi=
t_sum > cpu_data->total) {
>                                 /*
>                                  * Use the current state unless it is too
>                                  * shallow or disabled, in which case tak=
e the

This will only matter after the deepest state has been rejected
already and on the system in question this means selecting state 0 no
matter what.

The pre-6.12 behavior can be explained if tick wakeups are taken into accou=
nt.

Namely, when state 0 is chosen (because of the check mentioned above),
the tick is not stopped and the sleep length is KTIME_MAX.  If the
subsequent wakeup is a tick one, it will be counted as a hit on the
deepest state (and it will contribute to the total sum in the check
mentioned above).  Then, at one point, cpu_data->total will be large
enough and the deepest state will become the candidate one.  If
tick_nohz_get_sleep_length() returns a large value at that point, the
tick will be stopped and the deepest state will be entered.  Nirvana
ensues.

The change in commit 4b20b07ce72f causes the sleep length to fall
below the deepest idle state target residency at least sometimes in
the scenario above, and if the subsequent wakeup is a tick one, it
doesn't matter how it is counted - it will contribute to selecting
idle state 0.

The mainline is affected to a lesser extent because it sometimes does
what pre-6.12 did.

IMV addressing this would require changing the check you've identified
as the culprit, but I'm not sure how to change it TBH.

