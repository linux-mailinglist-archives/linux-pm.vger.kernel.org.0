Return-Path: <linux-pm+bounces-20258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43BA09860
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D13997A02CE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391B12135CD;
	Fri, 10 Jan 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Z/wo0voD"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75221324F;
	Fri, 10 Jan 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529836; cv=none; b=A5a21RkoJDfFR5i1apr3AQWMpo8tqyCLdea0g9gjZoqgcOmmYeZPaWQhC9CNEVunikkQu7IE55WxIxL4zdqTn+jHu5Liqgw/2nuD+p8iYQaASJBUWVfcWtxTtp88S9c8Pq4+BYwwd0TEZyCHiC/SpgYbDyuJzfvvo/yaGFiyg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529836; c=relaxed/simple;
	bh=OwtLo1fnEpXHMZeau2qqyIh3vxEPVLyYOea5SHu+GY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxxQKZyzyprFdIJvR30VpnulGtKG9F3+8VJ4mYyaTEYjzKFXni8jvcNhfY1wFBi3tSUEzSAAagYT1HbF7la1/5cSHt1GXh7nDflMSL6oMb+D6D6F1GbGDLhnEx8N7NtrQL/LGxF+k23O6D4yuubMddAbZBee7zKRm2CKKJtyWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Z/wo0voD; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id a252305cb41d9fdd; Fri, 10 Jan 2025 18:23:50 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B970F8E05FC;
	Fri, 10 Jan 2025 18:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1736529830;
	bh=OwtLo1fnEpXHMZeau2qqyIh3vxEPVLyYOea5SHu+GY4=;
	h=From:Subject:Date;
	b=Z/wo0voDgsz7rqVPuzSK3Z2kY/iufTaEmKMgCwW3/wtIrPwVlnOBJMys0FHOWNdqa
	 cNIKq/Su5WWhUGgTSJ5xhnSD8AP9EiPlyvuDglVZJgje8RPpxCi2HJbUIKlN9XS184
	 K7SjH0SNDmwntOwI4+OQweFT/pbaHGNdpqRXiCWLhG0P+PhNdQKjbjlOt8jCxLXEk0
	 vemiQoQl4SZV+11NXVrbMLSrfrOCKz+du49NzI2XPDalVC82ma8+KaMDpi1dKXAxch
	 Y1YGAlhCh2FzNnmvo07gC3jnuGNN5WnVrgSoZ2pBbeqYoFM8qSPUSU/IYJB778gn+z
	 67RadtsU11a+A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 Re: [PATCH v1 1/4] cpuidle: teo: Add polling flag check to early return path
Date: Fri, 10 Jan 2025 18:23:49 +0100
Message-ID: <12587057.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <c976eae7-56f8-4b7b-821a-1ec4291b21dd@arm.com>
References:
 <4953183.GXAFRqVoOG@rjwysocki.net>
 <CAJZ5v0hKZP7b8G+FJrb2kTSo90YK75XUsukExPMGVqhoZsSU7A@mail.gmail.com>
 <c976eae7-56f8-4b7b-821a-1ec4291b21dd@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkeeileehffelfefggfdtjedvkeettdejfeevueegfedvhffgudeuteeigfeileetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdhlohgvhhhlvgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrsghoohhrvhgrugeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

On Friday, January 10, 2025 3:52:09 PM CET Christian Loehle wrote:
> On 1/10/25 13:34, Rafael J. Wysocki wrote:
> > On Fri, Jan 10, 2025 at 2:16=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 1/10/25 12:53, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> After commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_le=
ngth()
> >>> call in some cases") the teo governor behaves a bit differently on
> >>> systems where idle state 0 is a "polling" state (that is, it is not
> >>> really an idle state, but a loop continuously executed by the CPU).
> >>> Namely, on such systems it skips the tick_nohz_get_sleep_length() call
> >>> if the target residency of the current candidate idle state is small
> >>> enough.
> >>>
> >>> However, if state 0 itself was to be returned, it would be returned
> >>> right away without calling tick_nohz_get_sleep_length() even on syste=
ms
> >>> where it was not a "polling" state until commit 4b20b07ce72f ("cpuidl=
e:
> >>> teo: Don't count non-existent intercepts") that attempted to fix this
> >>> problem.
> >>>
> >>> Unfortunately, commit 4b20b07ce72f has made the governor always call
> >>> tick_nohz_get_sleep_length() when about to return state 0 early, even
> >>> if that state is a "polling" one, which is inconsistent and defeats
> >>> the purpose of commit 6da8f9ba5a87 in that case.
> >>>
> >>> Address this by adding a CPUIDLE_FLAG_POLLING check to the path where
> >>> state 0 is returned early to prevent tick_nohz_get_sleep_length() from
> >>> being called if it is a "polling" state.
> >>>
> >>> Fixes: 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercep=
ts")
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>  drivers/cpuidle/governors/teo.c |    3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> --- a/drivers/cpuidle/governors/teo.c
> >>> +++ b/drivers/cpuidle/governors/teo.c
> >>> @@ -422,7 +422,8 @@
> >>>                       first_suitable_idx =3D i;
> >>>               }
> >>>       }
> >>> -     if (!idx && prev_intercept_idx) {
> >>> +     if (!idx && prev_intercept_idx &&
> >>> +         !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
> >>>               /*
> >>>                * We have to query the sleep length here otherwise we =
don't
> >>>                * know after wakeup if our guess was correct.
> >>>
> >>>
> >>>
> >>
> >> But then you do run into the issue of intercepts not being detected if
> >> state0 is the right choice, don't you?
> >=20
> > That's true, but then on systems with a "polling" state 0 you still
> > have this problem if the state returned early is not state 0.  Say C1
> > on x86.>=20
> > The point here is that the behavior needs to be consistent, one way or =
another.
>=20
> Yes, gotcha. Why not be consistent 'in the other way' then?
>=20
> >=20
> > The exact point of commit 6da8f9ba5a87 was to avoid calling
> > tick_nohz_get_sleep_length() in some cases when the state to be
> > returned is shallow enough and obviously that includes a "polling"
> > state 0, possibly at the cost of being somewhat inaccurate in
> > prediction.
>=20
> Somewhat inaccurate meaning not making any prediction?
> cpu_data->sleep_length_ns =3D KTIME_MAX;
>=20
> How much is the harm for calling tick_nohz_get_sleep_length() when
> polling anyway?
> I know tick_nohz_get_sleep_length() is the majority of the usual
> cpuidle entry path, but for many scenarios where state0 is appropriate
> that should be pretty fast, no?
>=20
> >=20
> > Then you're seeing this intercept accumulation for state 0 when there
> > are only 2 states in the table (or all of the other states are much
> > higher target residency than state 0).
> >=20
> > Commit 4b20b07ce72f effectively caused tick_nohz_get_sleep_length() to
> > be called every time on systems without a "polling" state 0, which was
> > fair enough, but it also affected the other systems, which wasn't.
> >=20
> >> This would then enable intercept-detection only for <50% of the time,
> >> another option is to not allow intercepts selecting a polling state, b=
ut
> >> there were recent complaints about this exact behavior from Aboorva (+=
TO).
> >> They don't have a low-latency non-polling state.
> >>
> >> https://lore.kernel.org/lkml/20240809073120.250974-1-aboorvad@linux.ib=
m.com/
> >=20
> > If they don't have a "polling" state 0, they won't be affected by this
> > patch and after commit 4b20b07ce72f, they'll always call
> > tick_nohz_get_sleep_length(), so the current governor behavior is
> > generally unsuitable for them.
>=20
> They do though.
> commit 5ddcc03a07ae ("powerpc/cpuidle: Set CPUIDLE_FLAG_POLLING for snooz=
e state")
> So they have a polling 'snooze' and a relatively high latency (hundreds u=
secs)
> non-polling state and no deeper state.
> So if they don't query sleep length on snooze on a (1us)-interrupt-wakeup=
 heavy
> workload they will get 50% state0 and 50% state1 (because intercepts reco=
vered
> due to not querying sleep length).
>=20
> >=20
> > I have an idea how to change it to be more accurate in prediction, but
> > we'll see how it goes.  Stay tuned.
>=20
> I will.

So with the appended change applied, there is no difference between "hits" =
and
"intercepts" any more, they all are just "events" now, so the sleep length =
value
should not matter unless it is needed to refine the state selection.

Of course, the whole governor can be simplified significantly on top of it.

=2D--
 drivers/cpuidle/governors/teo.c |   98 +++++++++++++++++++----------------=
=2D----
 1 file changed, 48 insertions(+), 50 deletions(-)

=2D-- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -34,12 +34,17 @@
  *
  * The computations carried out by this governor are based on using bins w=
hose
  * boundaries are aligned with the target residency parameter values of th=
e CPU
=2D * idle states provided by the %CPUIdle driver in the ascending order.  =
That is,
=2D * the first bin spans from 0 up to, but not including, the target resid=
ency of
=2D * the second idle state (idle state 1), the second bin spans from the t=
arget
=2D * residency of idle state 1 up to, but not including, the target reside=
ncy of
=2D * idle state 2, the third bin spans from the target residency of idle s=
tate 2
=2D * up to, but not including, the target residency of idle state 3 and so=
 on.
+ * idle states provided by the %CPUIdle driver in ascending order, and a g=
iven
+ * bin is used for counting events for which the measured idle duration is
+ * between its boundaries.  Specifically, the first bin spans from 0 up to=
, but
+ * not including, the target residency of the second idle state (idle stat=
e 1),
+ * so it counts events for which the measured idle duration is greater tha=
n or
+ * equal to 0 and less than the target residency of state 1.  The second b=
in
+ * spans from the target residency of idle state 1 up to, but not includin=
g, the
+ * target residency of idle state 2, the third bin spans from the target
+ * residency of idle state 2 up to, but not including, the target residenc=
y of
+ * idle state 3 and so on.
+ *
  * The last bin spans from the target residency of the deepest idle state
  * supplied by the driver to the scheduler tick period length or to infini=
ty if
  * the tick period length is less than the targer residency of that state.=
  In
@@ -47,47 +52,31 @@
  * duration between the tick period length and the target residency of the
  * deepest idle state.
  *
=2D * Two metrics called "hits" and "intercepts" are associated with each b=
in.
=2D * They are updated every time before selecting an idle state for the gi=
ven CPU
=2D * in accordance with what happened last time.
=2D *
=2D * The "hits" metric reflects the relative frequency of situations in wh=
ich the
=2D * sleep length and the idle duration measured after CPU wakeup fall int=
o the
=2D * same bin (that is, the CPU appears to wake up "on time" relative to t=
he sleep
=2D * length).  In turn, the "intercepts" metric reflects the relative freq=
uency of
=2D * non-timer wakeup events for which the measured idle duration falls in=
to a bin
=2D * that corresponds to an idle state shallower than the one whose bin is=
 fallen
=2D * into by the sleep length (these events are also referred to as "inter=
cepts"
=2D * below).
=2D *
  * In order to select an idle state for a CPU, the governor takes the foll=
owing
  * steps (modulo the possible latency constraint that must be taken into a=
ccount
  * too):
  *
  * 1. Find the deepest enabled CPU idle state (the candidate idle state) a=
nd
=2D *    compute 2 sums as follows:
=2D *
=2D *    - The sum of the "hits" metric for all of the idle states shallowe=
r than
=2D *      the candidate one (it represents the cases in which the CPU was =
likely
=2D *      woken up by a timer).
=2D *
=2D *    - The sum of the "intercepts" metric for all of the idle states sh=
allower
=2D *      than the candidate one (it represents the cases in which the CPU=
 was
=2D *      likely woken up by a non-timer wakeup source).
=2D *
=2D * 2. If the second sum computed in step 1 is greater than a half of the=
 sum of
=2D *    both mertics for the candidate state bin and all subsequent bins(i=
f any),
=2D *    a shallower idle state is likely to be more suitable, so look for =
it.
+ *    compute a sum of events for all of the idle states shallower than the
+ *    candidate one (it represents the cases in which the candidate idle s=
tate
+ *    would have been to deep for the measured idle duration).
+ *
+ * 2. If the sum computed in step 1 is greater than 1/2 of the sum of all
+ *    events, the candidate state would have been too deep for the measure=
d idle
+ *    duration in over 1/2 of all cases, so look for a shallower idle stat=
e to
+ *    replace it.
  *
  *    - Traverse the enabled idle states shallower than the candidate one =
in the
  *      descending order.
  *
=2D *    - For each of them compute the sum of the "intercepts" metrics ove=
r all
=2D *      of the idle states between it and the candidate one (including t=
he
=2D *      former and excluding the latter).
=2D *
=2D *    - If this sum is greater than a half of the second sum computed in=
 step 1,
=2D *      use the given idle state as the new candidate one.
+ *    - In each step, compute the sum of events for the given state and al=
l of
+ *      the subsequent bins, including the events with the measured idle
+ *      duration between the tick period length and the target residency o=
f the
+ *      deepest idle state (if the former is less than the latter).
+ *
+ *    - If this sum is greater than 1/2 of the sum of all events. the given
+ *      state would have been shallow enough for the measured idle duratio=
n in
+ *      over 1/2 of all cases, so it can be used as the new candidate one.
  *
  * 3. If the current candidate state is state 0 or its target residency is=
 short
  *    enough, return it and prevent the scheduler tick from being stopped.
@@ -288,6 +277,7 @@
 	unsigned int tick_intercept_sum =3D 0;
 	unsigned int idx_intercept_sum =3D 0;
 	unsigned int intercept_sum =3D 0;
+	unsigned int idx_event_sum =3D 0;
 	unsigned int idx_hit_sum =3D 0;
 	unsigned int hit_sum =3D 0;
 	int constraint_idx =3D 0;
@@ -361,15 +351,18 @@
=20
 	tick_intercept_sum =3D intercept_sum +
 			cpu_data->state_bins[drv->state_count-1].intercepts;
=2D
 	/*
=2D	 * If the sum of the intercepts metric for all of the idle states
=2D	 * shallower than the current candidate one (idx) is greater than the
=2D	 * sum of the intercepts and hits metrics for the candidate state and
=2D	 * all of the deeper states, a shallower idle state is likely to be a
=2D	 * better choice.
+	 * Compute the sum of both event metrics for all idle states shallower
+	 * than the candidate one (idx).
+	 */
+	idx_event_sum =3D idx_intercept_sum + idx_hit_sum;
+	/*
+	 * If this sum is greater than 1/2 of total events, the current
+	 * candndate state would have been to deep for the measured idle
+	 * duration in over 50% of recent cases, so look for a shallower one.
 	 */
=2D	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
+	if (2 * idx_event_sum > cpu_data->total) {
+		unsigned int event_sum =3D cpu_data->total - idx_event_sum;
 		int first_suitable_idx =3D idx;
=20
 		/*
@@ -380,14 +373,19 @@
 		 * Take the possible duration limitation present if the tick
 		 * has been stopped already into account.
 		 */
=2D		intercept_sum =3D 0;
=2D
 		for (i =3D idx - 1; i >=3D 0; i--) {
 			struct teo_bin *bin =3D &cpu_data->state_bins[i];
=20
=2D			intercept_sum +=3D bin->intercepts;
=2D
=2D			if (2 * intercept_sum > idx_intercept_sum) {
+			/*
+			 * Add both metrics for this state to the total sum of
+			 * metrics for all of the subsequent bins.
+			 */
+			event_sum +=3D bin->intercepts + bin->hits;
+			/*
+			 * If this sum is greater than 1/2 of total events,
+			 * replace the previous candidate state with this one.
+			 */
+			if (2 * event_sum > cpu_data->total) {
 				/*
 				 * Use the current state unless it is too
 				 * shallow or disabled, in which case take the




