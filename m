Return-Path: <linux-pm+bounces-37969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE05EC592D2
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 18:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0E085024EA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 17:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F713043B8;
	Thu, 13 Nov 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd/yFXnY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A228725B
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052991; cv=none; b=KQ7XmTvoiK9Csn+mXBOTtWVsxMIfunZccMh8fnukhvAf6gUEZhiKAFhD908W98nObYVALvf1Mc5tqYdTWnqDff43wNoEaSSa2lUb/N2cESD5ZqxGhmsWogTbdi8XLa8B8sGjTII2csCVpJtlVNSEhxvqV1AzQz5xq1B2e21756U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052991; c=relaxed/simple;
	bh=q4GWhGBktmPptEW6FD4WlWJw4Rp4NHmqO8xVCAVzx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNKCHMQqrGimclsu2HsGDYfBC29DTLlW5IQzXPGUqv19zm1QU+Hza5sbwLgV5jwW8lC0YUgOVKbGJsGj8Di+hGffglUXxjyXyk59yFMTlqmwMYkRSGr31hbDAoG+G44VsWp7QmxqkAt4125Ps/2DYeOUSbEshsdOB3235BMsfSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd/yFXnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C2EC4CEF8;
	Thu, 13 Nov 2025 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052991;
	bh=q4GWhGBktmPptEW6FD4WlWJw4Rp4NHmqO8xVCAVzx7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kd/yFXnYem8cTGLXEzMY14QnWXQn76UUCrl3ZA/eFiP8uOFEwkkbyAxntzodKVJ+6
	 NjlKmaFzs33RPyyqZpdBH5ohBu0uJXPTj39fr2aCwRco6B0dQzQklqXQSBmT4/n0YO
	 ojAkUSUIKBhBoVeXPs7U1POF1BdEPmoJ1nmfP96Rh9AgR5OlRxjMBkPcxFeoPzX9iD
	 vdVzEYQ935M1f64VxU/RU02F3d2T38Qw82sXhn355B522vZ4s4JpPXu6hJ56nkyE5i
	 ysiHrQjdnS4/1f3jkom2MyJtuRKcNrITCDnHL0WLSi/KRtUh3Q3w9E1PJTIZAHjYJV
	 BWFqyHBVHDxNQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>,
 Reka Norman <rekanorman@chromium.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject:
 [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wakeups
Date: Thu, 13 Nov 2025 17:56:27 +0100
Message-ID: <6228387.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
References:
 <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <00928b9d-7189-4929-afc9-7684fc5ef531@arm.com>
 <ca45366d-4c85-4802-8a35-886a6f69d10d@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, November 13, 2025 4:43:18 PM CET Christian Loehle wrote:
> On 11/12/25 18:33, Christian Loehle wrote:
> > On 11/12/25 14:16, Rafael J. Wysocki wrote:
> >> On Wed, Nov 12, 2025 at 3:03=E2=80=AFPM Christian Loehle
> >> <christian.loehle@arm.com> wrote:
> >>>
> >>> On 11/12/25 13:32, Rafael J. Wysocki wrote:
> >>>> On Tue, Nov 11, 2025 at 6:20=E2=80=AFPM Christian Loehle
> >>>> <christian.loehle@arm.com> wrote:
> >>>>>
> >>>>> On 11/11/25 11:48, Rafael J. Wysocki wrote:
> >>>>>> On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Christian Loehle
> >>>>>> <christian.loehle@arm.com> wrote:
> >>>>>>>
> >>>>>>> On 11/11/25 10:00, Christian Loehle wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>>>> I see two issues:
> >>>>>>>> 1) Because of DECAY_SHIFT 3 values < 8 cannot decay (I guess thi=
s wouldn't really be an issue without 2))
> >>>>>>
> >>>>>> This shouldn't be a problem.
> >>>>>
> >>>>> Agreed, it should be a non-issue. Nonetheless if this wasn't the ca=
se $subject would've likely
> >>>>> never been an issue.
> >>>>
> >>>> Well, I think that the leftovers can be cleared when they become les=
s than 8.
> >>>>
> >>>>>>
> >>>>>>>> 2) if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) is=
n't an appropriate check, it will
> >>>>>>>> exclude the state if it its idx_hit_sum make up the vast majorit=
y of cpu_data->total (i.e. it would
> >>>>>>>> have been a really good candidate actually).
> >>>>>>
> >>>>>> Well, it would exclude the state if the sum of hits for the states
> >>>>>> below it is large enough.  This is questionable (because why would
> >>>>>> hits matter here), but I attempted to make the change below and
> >>>>>> somebody reported a regression IIRC.
> >>>>>>
> >>>>>> This check is related to the problem at hand though (see below).
> >>>>>>
> >>>>>>>>
> >>>>>>>> I lightly tested the below, it seems to be at least comparable t=
o mainline teo.
> >>>>>>>> (the documentation/comments would need adapting too, of course)
> >>>>>>>>
> >>>>>>>> -----8<-----
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/g=
overnors/teo.c
> >>>>>>>> index bfa55c1eab5b..f8f76e3b8364 100644
> >>>>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>>>> @@ -355,7 +355,7 @@ static int teo_select(struct cpuidle_driver =
*drv, struct cpuidle_device *dev,
> >>>>>>>>          * all of the deeper states, a shallower idle state is l=
ikely to be a
> >>>>>>>>          * better choice.
> >>>>>>>>          */
> >>>>>>>> -       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_su=
m) {
> >>>>>>>> +       if (2 * idx_intercept_sum > idx_hit_sum) {
> >>>>>>>>                 int first_suitable_idx =3D idx;
> >>>>>>>>
> >>>>>>>>                 /*
> >>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>> ... nevermind the patch, idx_hit_sum is of course the sum of 0...=
idx-1.
> >>>>>>> Maybe something like this, again lightly tested:
> >>>>>>>
> >>>>>>> -----8<-----
> >>>>>>>
> >>>>>>> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/go=
vernors/teo.c
> >>>>>>> index 173ddcac540a..6bfb9cedb75e 100644
> >>>>>>> --- a/drivers/cpuidle/governors/teo.c
> >>>>>>> +++ b/drivers/cpuidle/governors/teo.c
> >>>>>>> @@ -383,13 +395,15 @@ static int teo_select(struct cpuidle_driver=
 *drv, struct cpuidle_device *dev,
> >>>>>>>                  * has been stopped already into account.
> >>>>>>>                  */
> >>>>>>>                 intercept_sum =3D 0;
> >>>>>>> +               hit_sum =3D 0;
> >>>>>>>
> >>>>>>>                 for (i =3D idx - 1; i >=3D 0; i--) {
> >>>>>>>                         struct teo_bin *bin =3D &cpu_data->state_=
bins[i];
> >>>>>>>
> >>>>>>>                         intercept_sum +=3D bin->intercepts;
> >>>>>>> +                       hit_sum +=3D bin->hits;
> >>>>>>>
> >>>>>>> -                       if (2 * intercept_sum > idx_intercept_sum=
) {
> >>>>>>> +                       if (2 * intercept_sum > cpu_data->total |=
| 2 * hit_sum > cpu_data->total) {
> >>>>>>>                                 /*
> >>>>>>>                                  * Use the current state unless i=
t is too
> >>>>>>>                                  * shallow or disabled, in which =
case take the
> >>>>>>
> >>>>>> This will only matter after the deepest state has been rejected
> >>>>>> already and on the system in question this means selecting state 0=
 no
> >>>>>> matter what.
> >>>>>>
> >>>>>
> >>>>> Ah, right!
> >>>>>
> >>>>>
> >>>>>> The pre-6.12 behavior can be explained if tick wakeups are taken i=
nto account.
> >>>>>>
> >>>>>> Namely, when state 0 is chosen (because of the check mentioned abo=
ve),
> >>>>>> the tick is not stopped and the sleep length is KTIME_MAX.  If the
> >>>>>> subsequent wakeup is a tick one, it will be counted as a hit on the
> >>>>>> deepest state (and it will contribute to the total sum in the check
> >>>>>> mentioned above).  Then, at one point, cpu_data->total will be lar=
ge
> >>>>>> enough and the deepest state will become the candidate one.  If
> >>>>>> tick_nohz_get_sleep_length() returns a large value at that point, =
the
> >>>>>> tick will be stopped and the deepest state will be entered.  Nirva=
na
> >>>>>> ensues.
> >>>>>
> >>>>> So fundamentally we will have to count tick-wakeups as a) nothing, =
which
> >>>>> doesn't allow us to ever break out of the intercept logic that caus=
ed us
> >>>>> to leave the tick on b) intercepts, which is bonkers and doesn't al=
low us
> >>>>> to ever break out and c) hits =3D=3D sleep_length would've been acc=
urate.
> >>>>> Of course counting a tick wakeup as a hit for sleep_length negates =
the
> >>>>> intercept logic.
> >>>>
> >>>> Not quite.  The intercept logic is there for wakeups other than tick
> >>>> wakeups and timer wakeups.
> >>>>
> >>>> I actually think that tick wakeups can be counted as hits on the
> >>>> deepest available state - maybe only when tick wakeups dominate the
> >>>> wakeup pattern - but generally this is not unreasonable: When the
> >>>> wakeup pattern is dominated by tick wakeups, this by itself is a good
> >>>> enough reason to stop the tick.
> >>>
> >>> (assuming HZ=3D1000 below but it doesn't matter)
> >>> That will exclude any 'intercept' logic from having much effect if the
> >>> avg idle duration is >TICK_NSEC/2, which is potentially still quite a=
 bit
> >>> off from state1 residency, like in Reka's case here.
> >>> That's why I thought it would cause unreasonable regressions here.
> >>> I'll give it a go as well though!
> >>
> >> Thanks!
> >>
> >> Note that I'd prefer to add a check if tick wakeups dominate the
> >> wakeup pattern before setting sleep_length_ns to KTIME_MAX though.
> >> I'd first like to know how the Reka's system reacts to the more
> >> drastic variant of this change.
> >=20
> > Below are my usual tests, it's definitely visible but the impact is lim=
ited
> > on this platform anyway. I think if we gate the KTIME_MAX setting behind
> > the "tick wakeup dominate" it should be acceptable!
> > Let's see what Reka reports.
> >=20
> Forgot to post the full results, anyway as expected with mtdblock (a very=
 slow
> / low frequent wakeup scenario) the impact becomes clearly visible.
> Still hopeful that the more conservative approach will be acceptable!

Speaking of which, the patch to test is appended below, but it doesn't apply
directly on top of the mainline.  It is based on some other patches that ha=
ve
been posted recently, so here's a git branch with all of the requisite
material:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpuidle-t=
eo-testing

Reka, please try this one and let us know how it goes.

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] cpuidle: governors: teo: Rework the handling of tick wa=
keups

If the wakeup pattern is clearly dominated by tick wakeups, count those
wakeups as hits on the deepest available idle state to increase the
likelihood of stopping the tick, especially on systems where there are
only 2 usable idle states and the tick can only be stopped when the
deeper state is selected.

This change is expected to reduce power on some systems where state 0 is
selected relatively often even though they are almost idle.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/cpuidle/governors/teo.c |   39 ++++++++++++++++++++++++-----------=
=2D---
 1 file changed, 24 insertions(+), 15 deletions(-)

=2D-- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -133,17 +133,19 @@ struct teo_bin {
  * @sleep_length_ns: Time till the closest timer event (at the selection t=
ime).
  * @state_bins: Idle state data bins for this CPU.
  * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
+ * @total_tick: Wakeups by the scheduler tick.
  * @tick_intercepts: "Intercepts" before TICK_NSEC.
  * @short_idles: Wakeups after short idle periods.
=2D * @artificial_wakeup: Set if the wakeup has been triggered by a safety =
net.
+ * @tick_wakeup: Set if the last wakeup was by the scheduler tick.
  */
 struct teo_cpu {
 	s64 sleep_length_ns;
 	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
 	unsigned int total;
+	unsigned int total_tick;
 	unsigned int tick_intercepts;
 	unsigned int short_idles;
=2D	bool artificial_wakeup;
+	bool tick_wakeup;
 };
=20
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -172,9 +174,10 @@ static void teo_update(struct cpuidle_dr
=20
 	teo_decay(&cpu_data->short_idles);
=20
=2D	if (cpu_data->artificial_wakeup) {
+	if (dev->poll_time_limit) {
+		dev->poll_time_limit =3D false;
 		/*
=2D		 * If one of the safety nets has triggered, assume that this
+		 * Polling state timeout has triggered, so assume that this
 		 * might have been a long sleep.
 		 */
 		measured_ns =3D S64_MAX;
@@ -223,6 +226,21 @@ static void teo_update(struct cpuidle_dr
 	cpu_data->total =3D total + PULSE;
=20
 	teo_decay(&cpu_data->tick_intercepts);
+
+	teo_decay(&cpu_data->total_tick);
+	if (cpu_data->tick_wakeup) {
+		cpu_data->total_tick +=3D PULSE;
+		/*
+		 * If tick wakeups dominate the wakeup pattern, count this one
+		 * as a hit on the deepest available idle state to increase the
+		 * likelihood of stopping the tick.
+		 */
+		if (3 * cpu_data->total_tick > 2 * cpu_data->total) {
+			cpu_data->state_bins[drv->state_count-1].hits +=3D PULSE;
+			return;
+		}
+	}
+
 	/*
 	 * If the measured idle duration falls into the same bin as the sleep
 	 * length, this is a "hit", so update the "hits" metric for that bin.
@@ -512,18 +530,9 @@ static void teo_reflect(struct cpuidle_d
 {
 	struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
=20
+	cpu_data->tick_wakeup =3D tick_nohz_idle_got_tick();
+
 	dev->last_state_idx =3D state;
=2D	if (dev->poll_time_limit ||
=2D	    (tick_nohz_idle_got_tick() && cpu_data->sleep_length_ns > TICK_NSEC=
)) {
=2D		/*
=2D		 * The wakeup was not "genuine", but triggered by one of the
=2D		 * safety nets.
=2D		 */
=2D		dev->poll_time_limit =3D false;
=2D		cpu_data->artificial_wakeup =3D true;
=2D	} else {
=2D		cpu_data->artificial_wakeup =3D false;
=2D	}
 }
=20
 /**




