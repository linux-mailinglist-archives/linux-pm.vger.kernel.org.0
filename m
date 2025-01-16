Return-Path: <linux-pm+bounces-20538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA70A139DB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573A7163F45
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD81DE4DD;
	Thu, 16 Jan 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FOC+t+Wt"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259C24A7E7;
	Thu, 16 Jan 2025 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030171; cv=none; b=WMKwhSt1LlflzOBJy8sWtvjIL1KfRm4AtwggmFrqFT0oGaW+ng01pj2i6aXkkIlYGCtV5jTvKUvtxufTPPL+ku43D1ebCmgIBED0HYAkEh+zVT5ziodiiReG7SMcKcLo1h9sdkBoZnuNMy0Bs3ro1liPfb9DNfgy0umSqK8wkt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030171; c=relaxed/simple;
	bh=/YbBRTytvR1JREEqgrc+7rPx2GBZhsQVFOi+CTtEGyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqipwWa7ADNKc4Pt1w3uY7hYbC71G7a6/AqwaY0r6zQtrNi+Q8gcT0iADUS3q+2T/euZVbtvgBKXGPO0IvbadI8TJE0ZvJqUctIxhXYqH58+PYK6gxqfV+Uk2+B/irZ2QKdo44kJ6CzXtPCeMrl1qyZIi6GeJFZKfAck83NJS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FOC+t+Wt; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 29e3a80c989a39bd; Thu, 16 Jan 2025 13:22:40 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A7F398E0B66;
	Thu, 16 Jan 2025 13:22:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737030160;
	bh=/YbBRTytvR1JREEqgrc+7rPx2GBZhsQVFOi+CTtEGyg=;
	h=From:Subject:Date;
	b=FOC+t+WtO/TBu97dNhQjyV7bDW3ncgNEmddequLo4XBVabS/vfO8dIbjceklFpOex
	 1gR+JTJp8QSdam/s3lfew1oKnzOkFyl941BD4Tp0YGSZJwrwoz7iF1hbRImx4UZDhK
	 pKtRLpGVmMCS+A+/2TyrzWt3HUR3z5Bk//pUAkpGv2EDG0qGLX4OuLpIdFW03ifHKK
	 VBtmoQvmprSytXaEk48iscxTJn1noo/vnSobW9CvH4akJmPizOOVpAPmzq8Eag4sWg
	 QDIUvfPkZySaDp/Hq0KO9M+Iz2XbfW4KKgDuGjoinwA9n3aZBHiBdLhBEpAezYRNb6
	 1V3vk3v5VvFsA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Christian Loehle <christian.loehle@arm.com>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
Date: Thu, 16 Jan 2025 13:22:39 +0100
Message-ID: <6122398.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To:
 <CAJZ5v0gr5CTM+p4dvAywuNyxLfE6MW7WWFu7wajCazMPodEvvg@mail.gmail.com>
References:
 <6116275.lOV4Wx5bFT@rjwysocki.net>
 <CAJZ5v0g2CxmFB3Js09jKk=ym26oEGVUsr5tM2p2vpPU_bczjmA@mail.gmail.com>
 <CAJZ5v0gr5CTM+p4dvAywuNyxLfE6MW7WWFu7wajCazMPodEvvg@mail.gmail.com>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepkeeileehffelfefggfdtjedvkeettdejfeevueegfedvhffgudeuteeigfeileetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheptghhrhhishhtihgrnhdrlhhovghhlhgvsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopeg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

On Wednesday, January 15, 2025 10:10:11 PM CET Rafael J. Wysocki wrote:
> On Wed, Jan 15, 2025 at 9:48=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Jan 15, 2025 at 8:20=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> > >
> > > On 1/15/25 15:54, Rafael J. Wysocki wrote:
> > > > On Wed, Jan 15, 2025 at 3:46=E2=80=AFPM Christian Loehle
> > > > <christian.loehle@arm.com> wrote:
> > > >>
> > > >> On 1/13/25 18:36, Rafael J. Wysocki wrote:
> > > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >>>
> > > >>> Since constraint_idx may be 0, the candidate state index may chan=
ge to 0
> > > >>> after assigning constraint_idx to it, so first check if it is gre=
ater
> > > >>> than constraint_idx (and update it if so) and then check it again=
st 0.
> > > >>
> > > >> So the reason I've left this where it was is because the prev_inte=
rcept_idx
> > > >> was supposed to query the sleep length if we're in an majority-int=
ercept
> > > >> period and then it makes sense to query the sleep length (to detec=
t such
> > > >> a period being over).
> > > >> A constraint_idx =3D=3D 0 scenario doesn't need the intercept-mach=
inery to
> > > >> work at all, why are we querying the sleep length then?
> > > >
> > > > In case the constraint is different next time and it's better to kn=
ow
> > > > the sleep length to properly classify the wakeup.
> > >
> > > I would hope constraints change nowhere near as frequently as
> > > idle entry / exit happen, is your experience different?
> >
> > They don't, but they may change at any time and it is kind of good to
> > have history in case this happens.
> >
> > > >
> > > >>>
> > > >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >>> ---
> > > >>>
> > > >>> This is a rebased variant of
> > > >>>
> > > >>> https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/
> > > >>>
> > > >>> ---
> > > >>>  drivers/cpuidle/governors/teo.c |   15 ++++++++-------
> > > >>>  1 file changed, 8 insertions(+), 7 deletions(-)
> > > >>>
> > > >>> --- a/drivers/cpuidle/governors/teo.c
> > > >>> +++ b/drivers/cpuidle/governors/teo.c
> > > >>> @@ -428,6 +428,14 @@
> > > >>>                               break;
> > > >>>               }
> > > >>>       }
> > > >>> +
> > > >>> +     /*
> > > >>> +      * If there is a latency constraint, it may be necessary to=
 select an
> > > >>> +      * idle state shallower than the current candidate one.
> > > >>> +      */
> > > >>> +     if (idx > constraint_idx)
> > > >>> +             idx =3D constraint_idx;
> > > >>> +
> > > >>>       if (!idx && prev_intercept_idx) {
> > > >>>               /*
> > > >>>                * We have to query the sleep length here otherwise=
 we don't
> > > >>> @@ -439,13 +447,6 @@
> > > >>>       }
> > > >>>
> > > >>>       /*
> > > >>> -      * If there is a latency constraint, it may be necessary to=
 select an
> > > >>> -      * idle state shallower than the current candidate one.
> > > >>> -      */
> > > >>> -     if (idx > constraint_idx)
> > > >>> -             idx =3D constraint_idx;
> > > >>> -
> > > >>> -     /*
> > > >>
> > > >> We could leave this here and just do goto end;?
> > > >
> > > > Why would this be better?
> > >
> > > Saves querying the sleep length in case of constraint_idx =3D=3D 0, i=
=2Ee.
> > > qos request to be very latency-sensitive and us actually adding laten=
cy
> > > here.
> >
> > Fair enough, but before patch [7/9] leaving it where it is doesn't
> > really cause it to skip the sleep length check unless state 0 is
> > "polling".
> >
> > After patch [7/9] it is possible to add a constraint_idx check against
> > 0 to the "goto out_tick" condition before the
> > tick_nohz_get_sleep_length() call, that is
> >
> > if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD=
_NS) &&
> >     (2 * cpu_data->short_idle >=3D cpu_data->total || !constraint_idx))
> >         goto out_tick;
>=20
> Or even
>=20
> if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_N=
S) &&
>     (2 * cpu_data->short_idle >=3D cpu_data->total || latency_req <
> A_SMALL_VALUE))
>         goto out_tick;
>=20
> for that matter.
>=20
> > but that would be a separate patch if you will.

So for completeness, it would be a patch like the one below, on top of the =
[7/9].

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] cpuidle: teo: Skip sleep length computation for low lat=
ency constraints

If the idle state exit latency constraint is sufficiently low, it
is better to avoid the additional latency related to calling
tick_nohz_get_sleep_length().  It is also not necessary to compute
the sleep length in that case because shallow idle state selection
will be forced then regardless of the recent wakeup history.

Accordingly, skip the sleep length computation and subsequent
checks of the exit latency constraint is low enough.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/cpuidle/governors/teo.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

=2D-- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -106,6 +106,12 @@
 #include "gov.h"
=20
 /*
+ * Idle state exit latency threshold used for deciding whether or not to c=
heck
+ * the time till the closest expected timer event.
+ */
+#define LATENCY_THRESHOLD_NS	(RESIDENCY_THRESHOLD_NS / 2)
+
+/*
  * The PULSE value is added to metrics when they grow and the DECAY_SHIFT =
value
  * is used for decreasing metrics on a regular basis.
  */
@@ -432,9 +438,14 @@
 	 * duration falls into that range in the majority of cases, assume
 	 * non-timer wakeups to be dominant and skip updating the sleep length
 	 * to reduce latency.
+	 *
+	 * Also, if the latency constraint is sufficiently low, it will force
+	 * shallow idle states regardless of the wakeup type, so the sleep
+	 * length need not be known in that case.
 	 */
 	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_N=
S) &&
=2D	    2 * cpu_data->short_idle >=3D cpu_data->total)
+	    (2 * cpu_data->short_idle >=3D cpu_data->total ||
+	     latency_req < LATENCY_THRESHOLD_NS))
 		goto out_tick;
=20
 	duration_ns =3D tick_nohz_get_sleep_length(&delta_tick);





