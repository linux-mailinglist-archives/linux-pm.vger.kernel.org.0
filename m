Return-Path: <linux-pm+bounces-43908-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD40BZdRrGnDogEAu9opvQ
	(envelope-from <linux-pm+bounces-43908-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 17:25:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1922CAB3
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 17:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91297302A04F
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA52BEFED;
	Sat,  7 Mar 2026 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLqwp2ZE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394419AD8B;
	Sat,  7 Mar 2026 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772900755; cv=none; b=Cab5VmpRtO5FFlZE220gKUXOaZoAqRBAALgL3QKc1382T4IAuuhJwuy38jRIpzz+tAMa1lKI3YsM/Gp2VHHPt2AOsMhfjiKUGSydVXDJ3lSM7b5sVQ51cqB69k4Oa5zvWrAOHLn63eUD0mvVfyaR4B4jPKHlcAxb2JYtrMis6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772900755; c=relaxed/simple;
	bh=DEPxnXVH4WZtKYE7uINGmeZxntzUeUcbFx5qO3vCxuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjXov2AkfbYm0yUvH51sW/YSVVZNRwRNriONDLCRH/RugVxxloRU3ONM85j33n8JDS+pomUy5BtM8dwiqZ9mgh5zakI6otWRfJTcyOe5j02QP/kuTrYor0ow/lUUtEeb7POe0VF9yfHcPOA5PPufEId24dyyor3Uhd2+90LvW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLqwp2ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0165C19422;
	Sat,  7 Mar 2026 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772900754;
	bh=DEPxnXVH4WZtKYE7uINGmeZxntzUeUcbFx5qO3vCxuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLqwp2ZEAlzRDvf79AyZBRDDH+1zlo+AtZseJJMBpcr8VaohA7WdgqDA3UArstuPl
	 nVbw5jY3TZvXy2izpCTgf8mJnLsRlY0mDQBF1JaMYcovZePZKn8hy7tmbanEKYuCew
	 H6J3ilcQJtuPGV41nk+/vxLtl5V9+B8woA7CBhsJfjCSz0o4Ki4IMEDf1RSu3H4bSC
	 T1Vdh1tFOoymQ/WcBglk4fDrIa2S9/RjZ2AErMbdIqDDsqINZRztFQ+AWtI9ZOvc0E
	 BqinRC6czumOXp/BJhCIKKnwkGXFk6lqZOL/qLioEvnUf+yD4v5rRW6GianbiHAWcX
	 +uzhGdSfsJcew==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [patch 2/2] sched/idle: Make default_idle_call() NOHZ aware
Date: Sat, 07 Mar 2026 17:25:50 +0100
Message-ID: <2409653.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
References:
 <20260301191959.406218221@kernel.org> <6250711.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5BC1922CAB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-43908-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Friday, March 6, 2026 10:31:49 PM CET Rafael J. Wysocki wrote:
> On Fri, Mar 6, 2026 at 10:21=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > On Wednesday, March 4, 2026 4:03:06 AM CET Qais Yousef wrote:
> > > On 03/02/26 22:25, Rafael J. Wysocki wrote:
> > > > On Mon, Mar 2, 2026 at 12:04=E2=80=AFPM Christian Loehle

[cut]

> > > > >
> > > > > Why don't we just require one or two consecutive tick wakeups bef=
ore stopping?
> > > >
> > > > Exactly my thought and I think one should be sufficient.
> > >
> > > I concur. From our experience with TEO util threshold these averages =
can
> > > backfire. I think one tick is sufficient delay to not be obviously br=
oken.
> >
> > So if I'm not mistaken, it would be something like the appended prototy=
pe
> > (completely untested, but it builds for me).
> >
> > ---
> >  drivers/cpuidle/cpuidle.c |   10 ----------
> >  kernel/sched/idle.c       |   32 ++++++++++++++++++++++++--------
> >  2 files changed, 24 insertions(+), 18 deletions(-)
> >
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -359,16 +359,6 @@ noinstr int cpuidle_enter_state(struct c
> >  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *=
dev,
> >                    bool *stop_tick)
> >  {
> > -       /*
> > -        * If there is only a single idle state (or none), there is not=
hing
> > -        * meaningful for the governor to choose. Skip the governor and
> > -        * always use state 0 with the tick running.
> > -        */
> > -       if (drv->state_count <=3D 1) {
> > -               *stop_tick =3D false;
> > -               return 0;
> > -       }
> > -
> >         return cpuidle_curr_governor->select(drv, dev, stop_tick);
> >  }
> >
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
> >         return cpuidle_enter(drv, dev, next_state);
> >  }
> >
> > +static void idle_call_stop_or_retain_tick(bool stop_tick)
> > +{
> > +       if (stop_tick || tick_nohz_tick_stopped())
> > +               tick_nohz_idle_stop_tick();
> > +       else
> > +               tick_nohz_idle_retain_tick();
> > +}
> > +
> >  /**
> >   * cpuidle_idle_call - the main idle function
> >   *
> > @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
> >   * set, and it returns with polling set.  If it ever stops polling, it
> >   * must clear the polling bit.
> >   */
> > -static void cpuidle_idle_call(void)
> > +static void cpuidle_idle_call(bool got_tick)
> >  {
> >         struct cpuidle_device *dev =3D cpuidle_get_device();
> >         struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> > @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
> >         }
> >
> >         if (cpuidle_not_available(drv, dev)) {
> > -               tick_nohz_idle_stop_tick();
> > +               idle_call_stop_or_retain_tick(!got_tick);
>=20
> Oh, I got this backwards (here and below).
>=20
> The tick should be stopped if we've got the tick previously, but you
> get the idea.

In the meantime I realized that if the .select() governor
callback is skipped, its .reflect() callback should be skipped
either, so I've posted this:

https://lkml.org/lkml/2026/3/7/569

and here's a fixed version of the last patch on top of the above (for
completeness):

=2D--
 kernel/sched/idle.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

=2D-- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
 	return cpuidle_enter(drv, dev, next_state);
 }
=20
+static void idle_call_stop_or_retain_tick(bool stop_tick)
+{
+	if (stop_tick || tick_nohz_tick_stopped())
+		tick_nohz_idle_stop_tick();
+	else
+		tick_nohz_idle_retain_tick();
+}
+
 /**
  * cpuidle_idle_call - the main idle function
  *
@@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
  * set, and it returns with polling set.  If it ever stops polling, it
  * must clear the polling bit.
  */
=2Dstatic void cpuidle_idle_call(void)
+static void cpuidle_idle_call(bool stop_tick)
 {
 	struct cpuidle_device *dev =3D cpuidle_get_device();
 	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
@@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
 	}
=20
 	if (cpuidle_not_available(drv, dev)) {
=2D		tick_nohz_idle_stop_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
=20
 		default_idle_call();
 		goto exit_idle;
@@ -222,17 +230,14 @@ static void cpuidle_idle_call(void)
 		next_state =3D cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
 	} else if (drv->state_count > 1) {
=2D		bool stop_tick =3D true;
+		stop_tick =3D true;
=20
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
 		next_state =3D cpuidle_select(drv, dev, &stop_tick);
=20
=2D		if (stop_tick || tick_nohz_tick_stopped())
=2D			tick_nohz_idle_stop_tick();
=2D		else
=2D			tick_nohz_idle_retain_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
=20
 		entered_state =3D call_cpuidle(drv, dev, next_state);
 		/*
@@ -240,7 +245,7 @@ static void cpuidle_idle_call(void)
 		 */
 		cpuidle_reflect(dev, entered_state);
 	} else {
=2D		tick_nohz_idle_retain_tick();
+		idle_call_stop_or_retain_tick(stop_tick);
=20
 		/*
 		 * If there is only a single idle state (or none), there is
@@ -268,6 +273,7 @@ exit_idle:
 static void do_idle(void)
 {
 	int cpu =3D smp_processor_id();
+	bool got_tick =3D false;
=20
 	/*
 	 * Check if we need to update blocked load
@@ -338,8 +344,9 @@ static void do_idle(void)
 			tick_nohz_idle_restart_tick();
 			cpu_idle_poll();
 		} else {
=2D			cpuidle_idle_call();
+			cpuidle_idle_call(got_tick);
 		}
+		got_tick =3D tick_nohz_idle_got_tick();
 		arch_cpu_idle_exit();
 	}
=20




