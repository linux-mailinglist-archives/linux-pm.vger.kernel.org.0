Return-Path: <linux-pm+bounces-38086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3EFC60979
	for <lists+linux-pm@lfdr.de>; Sat, 15 Nov 2025 18:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BB974E1021
	for <lists+linux-pm@lfdr.de>; Sat, 15 Nov 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC593019A6;
	Sat, 15 Nov 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHbWguV7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4E1DF985;
	Sat, 15 Nov 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763228124; cv=none; b=RUznHGhq5HrzpK0+sk+RkyqnPAp2alCCyn9I3L+YHi0nvDXG4XG1KiOFxhf9Z1ERFogWl6G7KSO2Ozls2ZrRg5YAVwVznpXDc4WJfyZ024Si4yxhWRHqp0o08LVdeQoncuLWJEKTzSAw1LL2SRw/T4RjRRM3taIIIsuAfyCtYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763228124; c=relaxed/simple;
	bh=9XYZ8REMf6ElJsxVVAXhUUsVD1FBvFTAjc2Kx3Bvz1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7uwdqkk0jX0xBUAYct5FF+k8SYK8VmSpK24l5WY8KidnlY26eu9SvzYoG8kS4+EqD52BszDle25BRYUGhKgohBcy48aAvPqbbcgTYY6eTNhmcLvI4vUL+3kpgapwImum1WGnBKii7GsNEMbpxoqyza2ihdVTWK8msh+5zjaxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHbWguV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CCFC116B1;
	Sat, 15 Nov 2025 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763228124;
	bh=9XYZ8REMf6ElJsxVVAXhUUsVD1FBvFTAjc2Kx3Bvz1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHbWguV7R7MkhOucAhu16rZ4k1JiZuF4eBlQBbFZ3xGLgcmgx62wk+eYpgTuP2SnS
	 SH0Vh+DziXoC3j7s15UFZhiSUr//ksytM07GISXAshk2D8R4hqaKNaz2j+doGv/LNs
	 F4VS+W0m6wTPJtd8jA8b/VKNlOxewCIYMGR8AYj8NO7ml3Ur51et9asmZdmGhAbx12
	 QUigG9vdajVhJd6mQkL0kCuyDNgQ0KobcqtY3+GIObD1IzSs6xXAwE7rVKNoReoKaK
	 bDBImFXkToFN9fZis63pkE9QNv5YWfDcg6h2+Oy79xtpjNhfa4eztezKBVCCeSvu6e
	 P2oq7etFR+VqA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Samuel Wu <wusamuel@google.com>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com,
 Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] PM: Support aborting sleep during filesystem sync
Date: Sat, 15 Nov 2025 18:35:18 +0100
Message-ID: <2416681.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAG2KctpoabtE8L=3PqhuBVr6QCc1p17F1kE88=t4aOOfGpzaxw@mail.gmail.com>
References:
 <20251030210110.298612-1-wusamuel@google.com>
 <CAJZ5v0iuRkf+xDHSiioZV=4-8PLx1eOz3bzojvuuC_Y1ZP1-VA@mail.gmail.com>
 <CAG2KctpoabtE8L=3PqhuBVr6QCc1p17F1kE88=t4aOOfGpzaxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, November 12, 2025 8:38:45 PM CET Samuel Wu wrote:
> On Fri, Nov 7, 2025 at 1:15=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Fri, Nov 7, 2025 at 9:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
=2Eorg> wrote:
> > >
> > > On Wed, Nov 5, 2025 at 2:20=E2=80=AFAM Samuel Wu <wusamuel@google.com=
> wrote:
> > > >
> > > > On Tue, Nov 4, 2025 at 10:52=E2=80=AFAM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 10:01=E2=80=AFPM Samuel Wu <wusamuel@goog=
le.com> wrote:
> > > > > >
> > > > > > At the start of suspend and hibernate, filesystems will sync to=
 save the
> > > > > > current state of the device. However, the long tail of the file=
system
> > > > > > sync can take upwards of 25 seconds. If during this filesystem =
sync
> > > > > > there is some wakeup or abort signal, it will not be processed =
until the
> > > > > > sync is complete; from a user's perspective, this looks like th=
e device
> > > > > > is unresponsive to any form of input.
> > > > > >
> > > > > > This patch adds functionality to handle a sleep abort signal wh=
en in
> > > > > > the filesystem sync phase of suspend or hibernate. This topic w=
as first
> > > > > > discussed by Saravana Kannan at LPC 2024 [1], where the general
> > > > > > consensus was to allow filesystem sync on a parallel thread. In=
 case of
> > > > > > abort, the suspend process will stop waiting on an in-progress
> > > > > > filesystem sync, and continue by aborting suspend before the fi=
lesystem
> > > > > > sync is complete.
> > > > > >
> > > > > > Additionally, there is extra care needed to account for back-to=
=2Dback
> > > > > > sleeps while maintaining functionality to immediately abort dur=
ing the
> > > > > > filesystem sync stage. Furthermore, in the case of the back-to-=
back
> > > > > > sleeps, a subsequent filesystem sync is needed to ensure the la=
test
> > > > > > files are synced right before sleep. If necessary, a subsequent=
 sleep's
> > > > > > filesystem sync will be queued, and will only start when the pr=
evious
> > > > > > sleep's filesystem sync has finished. While waiting for the pre=
vious
> > > > > > sleep's filesystem sync to finish, the subsequent sleep will st=
ill abort
> > > > > > early if a wakeup event is triggered, solving the original issu=
e of
> > > > > > filesystem sync blocking abort.
> > > > > >
> > > > > > [1]: https://lpc.events/event/18/contributions/1845/
> > > > > >
> > > > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > > > > > ---
> > > > > > Changes in v6:
> > > > > > - Use spin_lock_irq() in thread context
> > > > > > - Use dedicated ordered workqueue for sync work items
> > > > > > - Use a counter instead of two bools for synchronization
> > > > > > - Queue fs_sync if it's not already pending on workqueue
> > > > > > - pm_wakeup_clear(0) is prequisite to this feature, so move it =
within function
> > > > > > - Updated commit text for motive of back-to-back fs syncs
> > > > > > - Tighter lock/unlock around setup, checks, and loop
> > > > > > - Fix function definitions for CONFIG_PM_SLEEP=3Dn
> > > > > > - v5 link: https://lore.kernel.org/all/20251017233907.2305303-1=
=2Dwusamuel@google.com/
> > > > > >
> > > > > > Changes in v5:
> > > > > > - Update spin_lock() to spin_lock_irqsave() since abort can be =
in IRQ context
> > > > > > - Updated changelog description to be more precise regarding co=
ntinuing abort
> > > > > >   sleep before fs_sync() is complete
> > > > > > - Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs=
_sync()
> > > > > > - Simplify from a goto to do-while in pm_sleep_fs_sync()
> > > > > > - v4 link: https://lore.kernel.org/all/20250911185314.2377124-1=
=2Dwusamuel@google.com
> > > > > >
> > > > > > Changes in v4:
> > > > > > - Removed patch 1/3 of v3 as it is already picked up on linux-pm
> > > > > > - Squashed patches 2/3 and 3/3 from v3 into this single patch
> > > > > > - Added abort during fs_sync functionality to hibernate in addi=
tion to suspend
> > > > > > - Moved variables and functions for abort from power/suspend.c =
to power/main.c
> > > > > > - Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
> > > > > > - Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync=
()
> > > > > > - v3 link: https://lore.kernel.org/all/20250821004237.2712312-1=
=2Dwusamuel@google.com/
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Split v2 patch into 3 patches
> > > > > > - Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled=
) condition
> > > > > > - Updated documentation and comments within kernel/power/suspen=
d.c
> > > > > > - v2 link: https://lore.kernel.org/all/20250812232126.1814253-1=
=2Dwusamuel@google.com/
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Added documentation for suspend_abort_fs_sync()
> > > > > > - Made suspend_fs_sync_lock and suspend_fs_sync_complete declar=
ation static
> > > > > > - v1 link: https://lore.kernel.org/all/20250815004635.3684650-1=
=2Dwusamuel@google.com
> > > > > >
> > > > > >  drivers/base/power/wakeup.c |  8 ++++
> > > > > >  include/linux/suspend.h     |  4 ++
> > > > > >  kernel/power/hibernate.c    |  5 ++-
> > > > > >  kernel/power/main.c         | 81 +++++++++++++++++++++++++++++=
++++++++
> > > > > >  kernel/power/suspend.c      |  4 +-
> > > > > >  5 files changed, 100 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/w=
akeup.c
> > > > > > index d1283ff1080b..689c16b08b38 100644
> > > > > > --- a/drivers/base/power/wakeup.c
> > > > > > +++ b/drivers/base/power/wakeup.c
> > > > > > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct =
wakeup_source *ws)
> > > > > >
> > > > > >         /* Increment the counter of events in progress. */
> > > > > >         cec =3D atomic_inc_return(&combined_event_count);
> > > > > > +       /*
> > > > > > +        * wakeup_source_activate() aborts sleep only if events=
_check_enabled
> > > > > > +        * is set (see pm_wakeup_pending()). Similarly, abort s=
leep during
> > > > > > +        * fs_sync only if events_check_enabled is set.
> > > > > > +        */
> > > > > > +       if (events_check_enabled)
> > > > > > +               pm_stop_waiting_for_fs_sync();
> > > > > >
> > > > > >         trace_wakeup_source_activate(ws->name, cec);
> > > > > >  }
> > > > > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > > > > >  void pm_system_wakeup(void)
> > > > > >  {
> > > > > >         atomic_inc(&pm_abort_suspend);
> > > > > > +       pm_stop_waiting_for_fs_sync();
> > > > > >         s2idle_wake();
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > > > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > > > > index b02876f1ae38..4795f55f9cbe 100644
> > > > > > --- a/include/linux/suspend.h
> > > > > > +++ b/include/linux/suspend.h
> > > > > > @@ -450,6 +450,8 @@ void restore_processor_state(void);
> > > > > >  extern int register_pm_notifier(struct notifier_block *nb);
> > > > > >  extern int unregister_pm_notifier(struct notifier_block *nb);
> > > > > >  extern void ksys_sync_helper(void);
> > > > > > +extern void pm_stop_waiting_for_fs_sync(void);
> > > > > > +extern int pm_sleep_fs_sync(void);
> > > > > >  extern void pm_report_hw_sleep_time(u64 t);
> > > > > >  extern void pm_report_max_hw_sleep(u64 t);
> > > > > >  void pm_restrict_gfp_mask(void);
> > > > > > @@ -505,6 +507,8 @@ static inline void pm_restrict_gfp_mask(voi=
d) {}
> > > > > >  static inline void pm_restore_gfp_mask(void) {}
> > > > > >
> > > > > >  static inline void ksys_sync_helper(void) {}
> > > > > > +static inline void pm_stop_waiting_for_fs_sync(void) {}
> > > > > > +static inline int pm_sleep_fs_sync(void) { return 0; }
> > > > > >
> > > > > >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> > > > > >
> > > > > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > > > > index 53166ef86ba4..1874fde4b4f3 100644
> > > > > > --- a/kernel/power/hibernate.c
> > > > > > +++ b/kernel/power/hibernate.c
> > > > > > @@ -820,7 +820,10 @@ int hibernate(void)
> > > > > >         if (error)
> > > > > >                 goto Restore;
> > > > > >
> > > > > > -       ksys_sync_helper();
> > > > > > +       error =3D pm_sleep_fs_sync();
> > > > > > +       if (error)
> > > > > > +               goto Restore;
> > > > > > +
> > > > > >         if (filesystem_freeze_enabled)
> > > > > >                 filesystems_freeze();
> > > > > >
> > > > > > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > > > > > index a6cbc3f4347a..23ca87a172a4 100644
> > > > > > --- a/kernel/power/main.c
> > > > > > +++ b/kernel/power/main.c
> > > > > > @@ -582,6 +582,84 @@ bool pm_sleep_transition_in_progress(void)
> > > > > >  {
> > > > > >         return pm_suspend_in_progress() || hibernation_in_progr=
ess();
> > > > > >  }
> > > > > > +
> > > > > > +static int pm_sleep_fs_syncs_queued;
> > > > > > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > > > > > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > > > > > +static struct workqueue_struct *pm_fs_sync_wq;
> > > > > > +
> > > > > > +static int __init pm_start_fs_sync_workqueue(void)
> > > > > > +{
> > > > > > +       pm_fs_sync_wq =3D alloc_ordered_workqueue("pm_fs_sync_w=
q", 0);
> > > > > > +
> > > > > > +       return pm_fs_sync_wq ? 0 : -ENOMEM;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * pm_stop_waiting_for_fs_sync - Abort fs_sync to abort sleep =
early
> > > > > > + *
> > > > > > + * This function causes the suspend process to stop waiting on=
 an in-progress
> > > > > > + * filesystem sync, such that the suspend process can be abort=
ed before the
> > > > > > + * filesystem sync is complete.
> > > > > > + */
> > > > > > +void pm_stop_waiting_for_fs_sync(void)
> > > > > > +{
> > > > > > +       unsigned long flags;
> > > > > > +
> > > > > > +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > > > > > +       complete(&pm_sleep_fs_sync_complete);
> > > > > > +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > > > > > +}
> > > > >
> > > > > Apart from the kernel test robot reports,
> > > >
> > > > Of course, I'll fix this in v7.
> > > >
> > > > > pm_stop_waiting_for_fs_sync() has become slightly too heavy for
> > > > > calling it from wakeup_source_activate().
> > > >
> > > > Trying to understand- are you saying spin_lock_irqsave() makes
> > > > pm_stop_waiting_for_fs_sync() too slow?
> > >
> > > Spin lock and the completion handling.
> > >
> > > This function has been designed to be as lightweight as reasonably
> > > possible and the $subject patch is adding a branch and a global
> > > spinlock locking to it.
> > >
> > > > > Waking up the suspend process from there should be sufficient.  T=
he
> > > > > completion is not necessary for that in principle.
> > > >
> > > > Can you elaborate more on what "there" means and why completion isn=
't
> > > > necessary? From what I can see, the only way to abort the suspend
> > > > _early_ is with the completion.
> > >
> > > Well, there are wait queues.
> > >
> > > In the first place though, do you really need to stop the suspend
> > > process immediately after a wakeup event?
>=20
> Yes, we would like to stop suspend as soon as a wakeup event occurs. A
> delay in processing the wakeup event manifests as an unresponsive
> device; for example, it is a poor user experience when pressing the
> lock button lags on the order of seconds.
>=20
> > > This generally does not happen and wakeup sources are designed with
> > > the assumption that it need not happen: The suspend process will check
> > > if there is a pending wakeup at some places and wakeup sources just
> > > need to update the counters.
>=20
> Agree, generally this isn't a concern but even 1% of cases means over
> a million devices are affected. Coming back to the original premise,
> the checks at discrete points are not sufficient since they don't
> handle the cases when fs_sync takes 20+ seconds.

Well, I'm not talking about this.

Appended is my version of the change in question (compiled, but not tested),
which admittedly should be split into two patches.

Now, tell my why exactly the value of 5 for PM_FS_SYNC_WAKEUP_RESOLUTION is
inadequate because that's effectively what you're saying here.

> > > Quite frankly, I don't see why the filesystem sync period needs to be
> > > special in that respect.  And if it need not be special, nothing needs
> > > to be added to wakeup_source_activate().
>=20
> fs_sync is special because it's been empirically identified as a phase
> of suspend which causes suspend to be more than 100x slower.
>=20
> > In case it is unclear where I'm going with this, the suspend process
> > can be made use wait_event_timeout() with a timeout of, say, 20 ms to
> > wait for pm_sleep_fs_syncs_queued to drop down to 0 in a loop and
> > check pm_wakeup_pending() in every iteration.
>=20
> Understood, this sounds similar to the polling idea in that of
> try_to_freeze_tasks(). However, there have been efforts just to save
> even <10ms in the suspend timeline, so the event driven approach would
> be more performant than polling; also especially since we've been
> refining the event driven approach in this patch for the past 6
> versions.

Which doesn't mean that it is the best approach.

The event driver approach adds overhead elsewhere because wakeup_source_act=
ivate()
is mostly used outside system suspend/resume paths and in some latency-sens=
itive
places.

> Appreciate the feedback and discussion, please let me know what you
> think. Thanks!

So unless I'm convinced that the patch below is insufficient, I'll be reluc=
tant
to apply anything more complicated.

=2D--
 kernel/power/hibernate.c |    6 +++
 kernel/power/main.c      |   75 ++++++++++++++++++++++++++++++++++++++++++=
+----
 kernel/power/power.h     |    1=20
 kernel/power/suspend.c   |    6 +++
 kernel/power/user.c      |    4 +-
 5 files changed, 83 insertions(+), 9 deletions(-)

=2D-- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -820,7 +820,10 @@ int hibernate(void)
 	if (error)
 		goto Restore;
=20
=2D	ksys_sync_helper();
+	error =3D pm_sleep_fs_sync();
+	if (error)
+		goto Notify;
+
 	if (filesystem_freeze_enabled)
 		filesystems_freeze();
=20
@@ -892,6 +895,7 @@ int hibernate(void)
 	freezer_test_done =3D false;
  Exit:
 	filesystems_thaw();
+ Notify:
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
  Restore:
 	pm_restore_console();
=2D-- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -92,6 +92,61 @@ void ksys_sync_helper(void)
 }
 EXPORT_SYMBOL_GPL(ksys_sync_helper);
=20
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+/* Wakeup events handling resolution while syncing file systems in jiffies=
 */
+#define PM_FS_SYNC_WAKEUP_RESOLUTION	5
+
+static atomic_t pm_fs_sync_count =3D ATOMIC_INIT(0);
+static struct workqueue_struct *pm_fs_sync_wq;
+static DECLARE_WAIT_QUEUE_HEAD(pm_fs_sync_wait);
+
+static bool pm_fs_sync_completed(void)
+{
+	return atomic_read(&pm_fs_sync_count) =3D=3D 0;
+}
+
+static void pm_fs_sync_work_fn(struct work_struct *work)
+{
+	ksys_sync_helper();
+
+	if (atomic_add_return(-1, &pm_fs_sync_count) =3D=3D 0)
+		wake_up(&pm_fs_sync_wait);
+}
+static DECLARE_WORK(pm_fs_sync_work, pm_fs_sync_work_fn);
+
+/**
+ * pm_sleep_fs_sync() - Sync file systems in an interruptible way
+ *
+ * Return 0 on successful file system sync, or return -EBUSY if the file
+ * system sync was aborted.
+ */
+int pm_sleep_fs_sync(void)
+{
+	pm_wakeup_clear(0);
+
+	/*
+	 * Take back-to-back sleeps into account by queuing a subsequent fs sync
+	 * only if the previous fs sync is running or is not queued. Multiple fs
+	 * syncs increase the likelihood of saving the latest files immediately
+	 * before sleep.
+	 */
+	if (!work_pending(&pm_fs_sync_work)) {
+		atomic_inc(&pm_fs_sync_count);
+		queue_work(pm_fs_sync_wq, &pm_fs_sync_work);
+	}
+
+	while (!pm_fs_sync_completed()) {
+		if (pm_wakeup_pending())
+			return -EBUSY;
+
+		wait_event_timeout(pm_fs_sync_wait, pm_fs_sync_completed(),
+				   PM_FS_SYNC_WAKEUP_RESOLUTION);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATION */
+
 /* Routines for PM-transition notifications */
=20
 static BLOCKING_NOTIFIER_HEAD(pm_chain_head);
@@ -231,10 +286,10 @@ static ssize_t mem_sleep_store(struct ko
 power_attr(mem_sleep);
=20
 /*
=2D * sync_on_suspend: invoke ksys_sync_helper() before suspend.
+ * sync_on_suspend: Sync file systems before suspend.
  *
=2D * show() returns whether ksys_sync_helper() is invoked before suspend.
=2D * store() accepts 0 or 1.  0 disables ksys_sync_helper() and 1 enables =
it.
+ * show() returns whether file systems sync before suspend is enabled.
+ * store() accepts 0 or 1.  0 disables file systems sync and 1 enables it.
  */
 bool sync_on_suspend_enabled =3D !IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC);
=20
@@ -1066,16 +1121,24 @@ static const struct attribute_group *att
 struct workqueue_struct *pm_wq;
 EXPORT_SYMBOL_GPL(pm_wq);
=20
=2Dstatic int __init pm_start_workqueue(void)
+static int __init pm_start_workqueues(void)
 {
 	pm_wq =3D alloc_workqueue("pm", WQ_FREEZABLE | WQ_UNBOUND, 0);
+	if (!pm_wq)
+		return -ENOMEM;
+
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+	pm_fs_sync_wq =3D alloc_ordered_workqueue("pm_fs_sync", 0);
+	if (!pm_fs_sync_wq)
+		return -ENOMEM;
+#endif
=20
=2D	return pm_wq ? 0 : -ENOMEM;
+	return 0;
 }
=20
 static int __init pm_init(void)
 {
=2D	int error =3D pm_start_workqueue();
+	int error =3D pm_start_workqueues();
 	if (error)
 		return error;
 	hibernate_image_size_init();
=2D-- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -19,6 +19,7 @@ struct swsusp_info {
 } __aligned(PAGE_SIZE);
=20
 #if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+extern int pm_sleep_fs_sync(void);
 extern bool filesystem_freeze_enabled;
 #endif
=20
=2D-- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -590,7 +590,11 @@ static int enter_state(suspend_state_t s
=20
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
=2D		ksys_sync_helper();
+
+		error =3D pm_sleep_fs_sync();
+		if (error)
+			goto Unlock;
+
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 	}
=20
=2D-- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -278,7 +278,9 @@ static long snapshot_ioctl(struct file *
 		if (data->frozen)
 			break;
=20
=2D		ksys_sync_helper();
+		error =3D pm_sleep_fs_sync();
+		if (error)
+			break;
=20
 		error =3D freeze_processes();
 		if (error)




