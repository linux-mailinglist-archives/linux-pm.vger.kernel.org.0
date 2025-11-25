Return-Path: <linux-pm+bounces-38631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB0C85F5B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6296F34CABB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45EC23B63E;
	Tue, 25 Nov 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmalkPb8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C21E9B35;
	Tue, 25 Nov 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087797; cv=none; b=FMLu95bEHCH3TREwOmuEYIskqwFzxipdqcj4iUC+H16+15IY6txhNUEsgZU6KH1GKnZ2Tg4ORBZnTYUXLtVNHXEWZtUE7H9RhPMvUVFmXP8F0M27uigZoV+K6R6gMd8mLqienU133lMcM0eXgQnmDMlwbRzV3Cou8+NPt96uDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087797; c=relaxed/simple;
	bh=PcLADs44vvxztti6xA2k6nYOIqCl+7fL8uUhpgP/J9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaTaLSHjugJggzbc3xrF633kkJUDt4LhJz4ZxWBExn6mxMYRDr2/zvYCfPg4toTdwkyhe4YkDmYipVh2/L3ziYpvXkex4hXOmsF64vlyVhiQzfWKsAEr8mW5CPKHDXE2lAmu6Pf0pfLpmjigetIDvbQPGAdiOo3v341w758xaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmalkPb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B29FC4CEF1;
	Tue, 25 Nov 2025 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764087797;
	bh=PcLADs44vvxztti6xA2k6nYOIqCl+7fL8uUhpgP/J9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmalkPb8fVz7b5+GlztZ5+HHHOuzrOl0RtAT8gFgVDBR/DLjIoQ2dcz3+1tKdVuVD
	 mqonXjkH0+ePWquB4TxGAnDv6nsCqDb4FwCl5a2geimEsyf5sWycoW0YOlitcd7x8Z
	 HQRFHr/okwp7v95ucCfUDrsdrh6Ji39Vz74W1mg+cbrFa5HY1Fyyk1B9EbaZ224ZJT
	 HCg5n6HBradD9l6Qh7wcO9ViElqp2j0WtU6jlkQJfkX9xBbog8jDnBNT1DuGLAC5ye
	 H6GAjD+6XbxDQlEJiBs5CTkUPiCxP/KqTWHrRpejVAlMziiJwdKjCZKIem4PwkBGLW
	 KcnsMhBp+nNlg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH v1] cpuidle: Warn instead of bailing out if target residency check
 fails
Date: Tue, 25 Nov 2025 17:23:12 +0100
Message-ID: <2808566.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0h1VTozCKweKvma3dQiUCz8KkR88Hue1cL_jDaKiP+BEw@mail.gmail.com>
References:
 <20251121010756.6687-1-val@packett.cool>
 <CAJZ5v0h1VTozCKweKvma3dQiUCz8KkR88Hue1cL_jDaKiP+BEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday, November 21, 2025 2:10:57 PM CET Rafael J. Wysocki wrote:
> On Fri, Nov 21, 2025 at 2:08=E2=80=AFAM Val Packett <val@packett.cool> wr=
ote:
> >
> > On Device Tree platforms, the latency and target residency values come
> > directly from device trees, which are numerous and weren't all written
> > with cpuidle invariants in mind. For example, qcom/hamoa.dtsi currently
> > trips this check: exit latency 680000 > residency 600000.
>=20
> So this breaks cpuidle expectations and it doesn't work correctly on
> the affected platforms.
>=20
> > Instead of harshly rejecting the entire cpuidle driver with a mysterious
> > error message, print a warning and set the target residency value to be
> > equal to the exit latency.
>=20
> This generally doesn't work because the new target residency may be
> greater than the target residency of the next state.
>=20
> > Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and ta=
rget residency")
> > Signed-off-by: Val Packett <val@packett.cool>
> > ---
> >  drivers/cpuidle/driver.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> > index 1c295a93d582..06aeb59c1017 100644
> > --- a/drivers/cpuidle/driver.c
> > +++ b/drivers/cpuidle/driver.c
> > @@ -199,8 +199,11 @@ static int __cpuidle_driver_init(struct cpuidle_dr=
iver *drv)
> >                  * exceed its target residency which is assumed in cpui=
dle in
> >                  * multiple places.
> >                  */
> > -               if (s->exit_latency_ns > s->target_residency_ns)
> > -                       return -EINVAL;
> > +               if (s->exit_latency_ns > s->target_residency_ns) {
> > +                       pr_warn("cpuidle: state %d: exit latency %lld >=
 residency %lld (fixing)\n",
> > +                               i, s->exit_latency_ns, s->target_reside=
ncy_ns);
> > +                       s->target_residency_ns =3D s->exit_latency_ns;
>=20
> And you also need to update s->target_residency.
>=20
> Moreover, that needs to be done when all of the target residency and
> exit latency values have been computed and full sanitization of all
> the states would need to be done (including the ordering checks), but
> the kernel has insufficient information to do that (for instance, if
> the ordering is not as expected, it is not clear how to fix it up).
> Even the above sanitization is unlikely to result in the intended
> behavior.
>=20
> So if returning the error code doesn't work, printing a warning is as
> much as can be done, like in the attached patch.
>=20
> If this works for you, I'll submit it properly later.
>=20

No response, so I assume no objections.

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It turns out that the change in commit 76934e495cdc ("cpuidle: Add
sanity check for exit latency and target residency") goes too far
because there are systems in the field on which the check introduced
by that commit does not pass.

=46or this reason, change __cpuidle_driver_init() return type back to void
and make it print a warning when the check mentioned above does not
pass.

=46ixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and targ=
et residency")
Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/linux-pm/20251121010756.6687-1-val@packett.=
cool/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/cpuidle/driver.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

=2D-- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -8,6 +8,8 @@
  * This code is licenced under the GPL.
  */
=20
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -152,7 +154,7 @@ static void cpuidle_setup_broadcast_time
  * __cpuidle_driver_init - initialize the driver's internal data
  * @drv: a valid pointer to a struct cpuidle_driver
  */
=2Dstatic int __cpuidle_driver_init(struct cpuidle_driver *drv)
+static void __cpuidle_driver_init(struct cpuidle_driver *drv)
 {
 	int i;
=20
@@ -195,15 +197,13 @@ static int __cpuidle_driver_init(struct
 			s->exit_latency =3D div_u64(s->exit_latency_ns, NSEC_PER_USEC);
=20
 		/*
=2D		 * Ensure that the exit latency of a CPU idle state does not
=2D		 * exceed its target residency which is assumed in cpuidle in
=2D		 * multiple places.
+		 * Warn if the exit latency of a CPU idle state exceeds its
+		 * target residency which is assumed to never happen in cpuidle
+		 * in multiple places.
 		 */
 		if (s->exit_latency_ns > s->target_residency_ns)
=2D			return -EINVAL;
+			pr_warn("Idle state %d target residency too low\n", i);
 	}
=2D
=2D	return 0;
 }
=20
 /**
@@ -233,9 +233,7 @@ static int __cpuidle_register_driver(str
 	if (cpuidle_disabled())
 		return -ENODEV;
=20
=2D	ret =3D __cpuidle_driver_init(drv);
=2D	if (ret)
=2D		return ret;
+	__cpuidle_driver_init(drv);
=20
 	ret =3D __cpuidle_set_driver(drv);
 	if (ret)





