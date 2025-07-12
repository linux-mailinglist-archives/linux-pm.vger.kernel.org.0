Return-Path: <linux-pm+bounces-30723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE3B029CE
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314A33BF751
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0971F4261;
	Sat, 12 Jul 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEVjevaF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7237B1C695;
	Sat, 12 Jul 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306913; cv=none; b=Lq+5Ht6Mf2LBd7A3xyTymaLf126nE5ABqT6hpJYWT07q5dxKOENefZlaVdXOEm7gQcoIyfvhyLdgvjfgiLDdT5yAmu04MLPP84poA5Q5jpCxM4q24ugdZYYoILX7jYXHXoRo8EyLKN30QgPxGVOzvsxyA2ElYz+UfLtL5AbyA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306913; c=relaxed/simple;
	bh=/DLUm4QmpVMHTEAKReFFPRYlHIrgaRyhOJMFoYQYz4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVo3+3FKNLmRGh0SFUZ7D/mEI9TxvSsYDETHdLpWnHTqITMOByqRGxM1+ss5qqjFOSctYeAcJbMgxxPEFSeBamYaPIRLOxEkgUi5YL5j/Jz3SACbJQlLfG2cGA6pFDg3jjyeY09zCYTfFGi7bn0cluvSc8BLdwp7tNerivUd5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEVjevaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B01C4CEEF;
	Sat, 12 Jul 2025 07:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752306912;
	bh=/DLUm4QmpVMHTEAKReFFPRYlHIrgaRyhOJMFoYQYz4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEVjevaF9vqyjNJhMDdx7MIknGWoKOojcLXrqpn0G11T5xlQGdZHIJKY28uDhcBRl
	 KcXU5JG8ibFLxmpxmyJrU4lWfuz/5ABRpJe4e9IbnM5X0QpAL+emLQTMFSn9VplQLF
	 IBQKmgydPD3GW3MtQfQ940eeOoJgos7MdS6CgpDnoJfsgHtS7WFliMBKxVwUhSVvB3
	 iEPCCaaXGdPgbZsIrRbyxzeldIl+BfbNu3lnbqXM96/Dr/+42PxW/CMuas7v0SBGeU
	 QflEABHE/vA2Uj3C8RE0EIU7T0U5Z7HytoDbvxOqnXiWIA4s2xj1Gnh6/mbK+XZWKV
	 abJhahXdTFzEg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 Saravana Kannan <saravanak@google.com>,
 William McVicker <willmcvicker@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Subject:
 Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the parent
Date: Sat, 12 Jul 2025 09:54:58 +0200
Message-ID: <4677865.LvFx2qVVIh@rjwysocki.net>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
References:
 <10629535.nUPlyArG6x@rjwysocki.net>
 <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
 <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday, July 11, 2025 3:54:00 PM CEST Rafael J. Wysocki wrote:
> On Fri, Jul 11, 2025 at 3:38=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Jul 11, 2025 at 3:08=E2=80=AFPM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> > >
> > >
> > > Hi, Rafael,
> > >
> > > On 3/14/25 12:50 PM, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > According to [1], the handling of device suspend and resume, and
> > > > particularly the latter, involves unnecessary overhead related to
> > > > starting new async work items for devices that cannot make progress
> > > > right away because they have to wait for other devices.
> > > >
> > > > To reduce this problem in the resume path, use the observation that
> > > > starting the async resume of the children of a device after resuming
> > > > the parent is likely to produce less scheduling and memory manageme=
nt
> > > > noise than starting it upfront while at the same time it should not
> > > > increase the resume duration substantially.
> > > >
> > > > Accordingly, modify the code to start the async resume of the devic=
e's
> > > > children when the processing of the parent has been completed in ea=
ch
> > > > stage of device resume and only start async resume upfront for devi=
ces
> > > > without parents.
> > > >
> > > > Also make it check if a given device can be resumed asynchronously
> > > > before starting the synchronous resume of it in case it will have to
> > > > wait for another that is already resuming asynchronously.
> > > >
> > > > In addition to making the async resume of devices more friendly to
> > > > systems with relatively less computing resources, this change is al=
so
> > > > preliminary for analogous changes in the suspend path.
> > > >
> > > > On the systems where it has been tested, this change by itself does
> > > > not affect the overall system resume duration in a measurable way.
> > > >
> > > > Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-sar=
avanak@google.com/ [1]
> > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > I'd like to let you know of a suspend crash that I'm dealing with
> > > when using the OOT pixel6 drivers on top of v6.16-rc4.
> >
> > Well, thanks, but there's not much I can do about it.
> >
> > It is also better to start a new thread in such cases than to reply to
> > a patch submission.
> >
> > > Similar to what Jon reported, everything gets back to normal if
> > > I disable pm_async or if I revert the following patches:
> > > 443046d1ad66 PM: sleep: Make suspend of devices more asynchronous
> > > aa7a9275ab81 PM: sleep: Suspend async parents after suspending childr=
en
> > > 0cbef962ce1f PM: sleep: Resume children after resuming the parent
> > >
> > > I also reverted their fixes when testing:
> > > 8887abccf8aa PM: sleep: Add locking to dpm_async_resume_children()
> > > d46c4c839c20 PM: sleep: Fix power.is_suspended cleanup for direct-com=
plete devices
> > > 079e8889ad13 PM: sleep: Fix list splicing in device suspend error pat=
hs
> > >
> > > It seems that the hang happens in dpm_suspend() at
> > > async_synchronize_full() time after a driver fails to suspend.
> > > The phone then naturally resets with an APC watchdog.
> > >
> > > [  519.142279][ T7917] lwis lwis-eeprom-m24c64x: Can't suspend becaus=
e eeprom-m24c64x is in use!
> > > [  519.143556][ T7917] lwis-i2c eeprom@2: PM: dpm_run_callback(): pla=
tform_pm_suspend returns -16
> > > [  519.143872][ T7917] lwis-i2c eeprom@2: PM: platform_pm_suspend ret=
urned -16 after 1596 usecs
> > > [  519.144197][ T7917] lwis-i2c eeprom@2: PM: failed to suspend: erro=
r -16
> > > [  519.144448][ T7917] PM: tudor: dpm_suspend: after while loop, list=
_empty(&dpm_prepared_list)? 1
> > > [  519.144779][ T7917] PM: tudor: dpm_suspend: before async_synchroni=
ze_full
> > >
> > > The extra prints are because of:
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index d9d4fc58bc5a..3efe538c2ec2 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -1967,10 +1967,15 @@ int dpm_suspend(pm_message_t state)
> > >                         break;
> > >                 }
> > >         }
> > > +       pr_err("tudor: %s: after while loop, list_empty(&dpm_prepared=
_list)? %d\n",
> > > +              __func__, list_empty(&dpm_prepared_list));
> > >
> > >         mutex_unlock(&dpm_list_mtx);
> > >
> > > +       pr_err("tudor: %s: before async_synchronize_full\n", __func__=
);
> > >         async_synchronize_full();
> > > +       pr_err("tudor: %s: after async_synchronize_full();\n", __func=
__);
> > > +
> > >         if (!error)
> > >                 error =3D async_error;
> > >
> > > The synchronous suspend works because its strict, one-by-one ordering
> > > ensures that device dependencies are met and that no device is suspen=
ded
> > > while another is still using it. The asynchronous suspend fails becau=
se
> > > it creates a race condition where the lwis-eeprom-m24c64x is called f=
or
> > > suspension before the process using it has been suspended, leading to=
 a
> > > fatal "device busy" error. Should the failure of a device suspend be
> > > fatal?
> >
> > It shouldn't in principle, but it depends on what exactly is involved a=
nd how.
> >
> > It looks like something is blocking on power.completion somewhere.
> > I'll check the code, maybe a complete() is missing in an error path or
> > similar.
>=20
> It doesn't look like anything is missing in the core, so the suspend
> failure seems to be triggering a deadlock of some sort.

Well, I'm taking this back.

The following scenario definitely can happen:

1. Device A is async and it depends on device B that is sync.
2. Async suspend is scheduled for A before the processing of B is started.
3. A is waiting for B.
4. In the meantime, an unrelated device fails to suspend and returns an err=
or.
5. The processing of B doesn't start at all and its power.completion is not
   updated.
6. A is still waiting for B when async_synchronize_full() is called.
7. Deadlock ensues.

If this is what happens in your case, the (untested) patch below should help
(unless I messed it up, that is).

=2D--
 drivers/base/power/main.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

=2D-- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1323,6 +1323,22 @@
 	device_links_read_unlock(idx);
 }
=20
+static void dpm_async_suspend_complete_all(struct list_head *device_list)
+{
+	struct device *dev;
+
+	guard(mutex)(&async_wip_mtx);
+
+	list_for_each_entry_reverse(dev, device_list, power.entry) {
+		/*
+		 * In case the device is being waited for and async processing
+		 * has not started for it yet, let the waiters make progress.
+		 */
+		if (!dev->power.work_in_progress)
+			complete_all(&dev->power.completion);
+	}
+}
+
 /**
  * resume_event - Return a "resume" message for given "suspend" sleep stat=
e.
  * @sleep_state: PM message representing a sleep state.
@@ -1499,6 +1515,7 @@
 		mutex_lock(&dpm_list_mtx);
=20
 		if (error || async_error) {
+			dpm_async_suspend_complete_all(&dpm_late_early_list);
 			/*
 			 * Move all devices to the target list to resume them
 			 * properly.
@@ -1701,6 +1718,7 @@
 		mutex_lock(&dpm_list_mtx);
=20
 		if (error || async_error) {
+			dpm_async_suspend_complete_all(&dpm_suspended_list);
 			/*
 			 * Move all devices to the target list to resume them
 			 * properly.
@@ -1994,6 +2012,7 @@
 		mutex_lock(&dpm_list_mtx);
=20
 		if (error || async_error) {
+			dpm_async_suspend_complete_all(&dpm_prepared_list);
 			/*
 			 * Move all devices to the target list to resume them
 			 * properly.




