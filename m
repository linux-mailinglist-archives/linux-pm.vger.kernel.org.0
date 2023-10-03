Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D557B7250
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 22:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjJCUHx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Oct 2023 16:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjJCUHw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 16:07:52 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7773CA1;
        Tue,  3 Oct 2023 13:07:47 -0700 (PDT)
Received: from meshulam.tesarici.cz (unknown [109.164.104.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 87EA918ECBB;
        Tue,  3 Oct 2023 22:07:45 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1696363665; bh=rZlouTsnjUHQMY+a8lwOjOeiNJ4qklCwQb2tkxlz7/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2ufS/vVpp8cBApkSI5y7fNvAur33zjVKybdaug257xDXTEhn6W5H1bTJ01riqNvLC
         hSzbUsgc3/PRbeEATmbHSmnx/CXqPEe3z659RCN0INhHnFoFlVSXO1MRJdY/Zorzjf
         gOXK1VuCtC8vuf8TchJ4Ghr/mdPjJWEw8krxYMngXgglhphaZJW0uWA7eg6lMoSEOU
         5UrZYuL12kHpaT81oKPblRHRB/W0MQ6kKJqceQBqCggs+jQmkAW+EW0jcYZ49dqwjk
         imqvBIegSTeQ4NaIfJiH2Z7n7u3PQ0TOZbvHusOv/NtXDcd2OgPeLgPOCDdAkBF4nv
         7SSlq488G58dA==
Date:   Tue, 3 Oct 2023 22:07:44 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-pm@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: Thinkpad E595 system deadlock on resume from S3
Message-ID: <20231003220744.07c4fa0a@meshulam.tesarici.cz>
In-Reply-To: <CAJZ5v0hXZx3ghWrfcTmTzwDJzYqLpzeBhx+CqBjg65Dngc2eRg@mail.gmail.com>
References: <20230930122054.3cf727a4@meshulam>
        <20231003113135.38384a87@meshulam.tesarici.cz>
        <CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
        <20231003130240.0c64bc2e@meshulam.tesarici.cz>
        <CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
        <20231003144019.24566b05@meshulam.tesarici.cz>
        <CAJZ5v0jttFqKE_CLpF+-vJ_wDAuOo_BUS33htpFUs6idNMugKg@mail.gmail.com>
        <20231003145110.1f22adfb@meshulam.tesarici.cz>
        <CAJZ5v0jbT0DaDpFpLbzO46-Yg6QJ-MrcZAuP+c60q9KpFHAtpQ@mail.gmail.com>
        <20231003171710.2c6a913c@meshulam.tesarici.cz>
        <CAJZ5v0hXZx3ghWrfcTmTzwDJzYqLpzeBhx+CqBjg65Dngc2eRg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Oct 2023 18:48:27 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Oct 3, 2023 at 5:18=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesar=
ici.cz> wrote:
> >
> > On Tue, 3 Oct 2023 14:57:46 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > =20
> > > On Tue, Oct 3, 2023 at 2:51=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@t=
esarici.cz> wrote: =20
> > > >
> > > > On Tue, 3 Oct 2023 14:48:13 +0200
> > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > =20
> > > > > On Tue, Oct 3, 2023 at 2:40=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <pe=
tr@tesarici.cz> wrote: =20
> > > > > >
> > > > > > On Tue, 3 Oct 2023 14:34:56 +0200
> > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > =20
> > > > > > > On Tue, Oct 3, 2023 at 1:02=E2=80=AFPM Petr Tesa=C5=99=C3=ADk=
 <petr@tesarici.cz> wrote: =20
> > > > > > > >
> > > > > > > > On Tue, 3 Oct 2023 12:15:10 +0200
> > > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > > > =20
> > > > > > > > > On Tue, Oct 3, 2023 at 11:31=E2=80=AFAM Petr Tesa=C5=99=
=C3=ADk <petr@tesarici.cz> wrote: =20
> > > > > > > > > >
> > > > > > > > > > Hi again (adding more recipients),
> > > > > > > > > >
> > > > > > > > > > On Sat, 30 Sep 2023 12:20:54 +0200
> > > > > > > > > > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> > > > > > > > > > =20
> > > > > > > > > > > Hi all,
> > > > > > > > > > >
> > > > > > > > > > > this time no patch (yet). In short, my Thinkpad runni=
ng v6.6-rc3 fails
> > > > > > > > > > > to resume from S3. It also fails the same way with Tu=
mbleweed v6.5
> > > > > > > > > > > kernel. I was able to capture a crash dump of the v6.=
5 kernel, and
> > > > > > > > > > > here's my analysis:
> > > > > > > > > > >
> > > > > > > > > > > The system never gets to waking up my SATA SSD disk:
> > > > > > > > > > >
> > > > > > > > > > > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  =
/dev/sda
> > > > > > > > > > >
> > > > > > > > > > > There is a pending resume work for kworker/u32:12 (PI=
D 11032), but this
> > > > > > > > > > > worker is stuck in 'D' state:
> > > > > > > > > > > =20
> > > > > > > > > > > >>> prog.stack_trace(11032) =20
> > > > > > > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c=
:6845:2)
> > > > > > > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:67=
9:3)
> > > > > > > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > > > > > > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > > > > > > > > > > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:=
2)
> > > > > > > > > > > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > > > > > > > > > > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > > > > > > > > > > #10 kthread (../kernel/kthread.c:389:9)
> > > > > > > > > > > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > > > > > > > > > > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/en=
try_64.S:304)
> > > > > > > > > > >
> > > > > > > > > > > acpi_device_hotplug() tries to acquire acpi_scan_lock=
, which is held by
> > > > > > > > > > > systemd-sleep (PID 11002). This task is also in 'D' s=
tate:
> > > > > > > > > > > =20
> > > > > > > > > > > >>> prog.stack_trace(11002) =20
> > > > > > > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c=
:6845:2)
> > > > > > > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:67=
9:3)
> > > > > > > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > > > > > > #6  device_lock (../include/linux/device.h:958:2)
> > > > > > > > > > > #7  device_complete (../drivers/base/power/main.c:106=
3:2)
> > > > > > > > > > > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > > > > > > > > > > #9  suspend_devices_and_enter (../kernel/power/suspen=
d.c:516:2) =20
> > > > > > > > > >
> > > > > > > > > > I believe the issue must be somewhere here. The whole s=
uspend and
> > > > > > > > > > resume logic in suspend_devices_and_enter() is framed by
> > > > > > > > > > platform_suspend_begin() and platform_resume_end().
> > > > > > > > > >
> > > > > > > > > > My system is an ACPI system, so suspend_ops contains:
> > > > > > > > > >
> > > > > > > > > >         .begin =3D acpi_suspend_begin,
> > > > > > > > > >         .end =3D acpi_pm_end,
> > > > > > > > > >
> > > > > > > > > > Now, acpi_suspend_begin() acquires acpi_scan_lock throu=
gh
> > > > > > > > > > acpi_pm_start(), and the lock is not released until acp=
i_pm_end().
> > > > > > > > > > Since dpm_complete() waits for the completion of a work=
 that tries to
> > > > > > > > > > acquire acpi_scan_lock, the system will deadlock. =20
> > > > > > > > >
> > > > > > > > > So holding acpi_scan_lock across suspend-resume is basica=
lly to
> > > > > > > > > prevent the hotplug from taking place then IIRC.
> > > > > > > > > =20
> > > > > > > > > > AFAICS either:
> > > > > > > > > >
> > > > > > > > > > a. the ACPI lock cannot be held while dpm_complete() ru=
ns, or
> > > > > > > > > > b. ata_scsi_dev_rescan() must not be scheduled before t=
he system is
> > > > > > > > > > resumed, or
> > > > > > > > > > c. acpi_device_hotplug() must be implemented without ta=
king dev->mutex.
> > > > > > > > > >
> > > > > > > > > > My gut feeling is that b. is the right answer. =20
> > > > > > > > >
> > > > > > > > > It's been a while since I looked at that code last time, =
but then it
> > > > > > > > > has not changed for quite some time too.
> > > > > > > > >
> > > > > > > > > It looks like the acpi_device_hotplug() path attempts to =
acquire
> > > > > > > > > acpi_scan_lock() while holding dev->mutex which is kind o=
f silly.  I
> > > > > > > > > need to check that, though. =20
> > > > > > > >
> > > > > > > > Thanks for your willingness. Well, it's not quite what you =
describe. If
> > > > > > > > it was a simple ABBA deadlock, then it would be reported by=
 lockdep.
> > > > > > > > No, it's more complicated:
> > > > > > > >
> > > > > > > > 1. suspend_devices_and_enter() holds acpi_scan_lock,
> > > > > > > > 2. an ACPI hotplug work runs, but acpi_device_hotplug() goe=
s to sleep
> > > > > > > >    when it gets to acquiring acpi_scan_lock,
> > > > > > > > 3. ata_scsi_dev_rescan() submits a SCSI command and waits f=
or its
> > > > > > > >    completion while holding dev->mutex,
> > > > > > > > 4. the SCSI completion work happens to be put on the same w=
orkqueue as
> > > > > > > >    the ACPI hotplug work in step 2,
> > > > > > > >    ^^^--- THIS is how the two events are serialized! =20
> > > > > > >
> > > > > > > Which is unexpected.
> > > > > > >
> > > > > > > And quite honestly I'm not sure how this can happen, because
> > > > > > > acpi_hotplug_schedule() uses a dedicated workqueue and it is =
called
> > > > > > > from (a) the "eject" sysfs attribute (which cannot happen whi=
le system
> > > > > > > suspend-resume is in progress) and (b) acpi_bus_notify() whic=
h has
> > > > > > > nothing to do with SCSI. =20
> > > > > >
> > > > > > Oh, you're right, and I was too quick. They cannot be on the sa=
me
> > > > > > queue...
> > > > > > =20
> > > > > > > Maybe the workqueue used for the SCSI completion is freezable=
? =20
> > > > > >
> > > > > > Yes, that's it:
> > > > > >
> > > > > > *(struct workqueue_struct *)0xffff97d240b2fe00 =3D {
> > > > > > /* ... */
> > > > > >         .flags =3D (unsigned int)4,
> > > > > > /* WQ_FREEZABLE            =3D 1 << 2 */
> > > > > >
> > > > > > Good. But if this workqueue is frozen, the system still cannot =
make
> > > > > > progress. =20
> > > > >
> > > > > The problem seems to be that dev->mutex is held while the work it=
em
> > > > > goes to a freezable workqueue and is waited for, which is an almo=
st
> > > > > guaranteed deadlock scenario. =20
> > > >
> > > > Ah. Thanks for explanation and direction! I'm going to dive into the
> > > > block layer and/or SCSI code and bug other people with my findings.=
 =20
> > >
> > > Please feel free to CC me on that in case I can help. =20
> >
> > And here I am again... The frozen workqueue is in fact pm_wq, and the
> > work item that is waited for is pm_runtime_work. The block layer calls
> > pm_request_resume() on the device to resume the queue. =20
>=20
> If it called pm_runtime_resume() instead, this might work.
>=20
> > I bet the queue should not be resumed this early. In fact, it seems
> > that this is somewhat known to the ATA developers, because
> > ata_scsi_dev_rescan() contains this beautiful comment and code:
> >
> >                         /*
> >                          * If the rescan work was scheduled because of =
a resume
> >                          * event, the port is already fully resumed, bu=
t the
> >                          * SCSI device may not yet be fully resumed. In=
 such
> >                          * case, executing scsi_rescan_device() may cau=
se a
> >                          * deadlock with the PM code on device_lock(). =
Prevent
> >                          * this by giving up and retrying rescan after =
a short
> >                          * delay.
> >                          */
> >                         delay_rescan =3D sdev->sdev_gendev.power.is_sus=
pended;
> >                         if (delay_rescan) {
> >                                 scsi_device_put(sdev);
> >                                 break;
> >                         }
> >
> > It just doesn't seem to work as expected, at least not in my case. =20
>=20
> Well, calling pm_request_resume() and waiting for the resume to
> actually happen is problematic regardless.  It is just better to call
> pm_runtime_resume() to synchronously resume the device instead.

I just want to confirm that my understanding of the issue is correct
now. After applying the patch below, my laptop has just survived half a
dozen suspend/resume cycles with autosuspend enabled for the SATA SSD
disk. Without the patch, it usually freezes on first attempt.

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a371b497035e..87000f89319e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4768,6 +4768,14 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 		ata_for_each_dev(dev, link, ENABLED) {
 			struct scsi_device *sdev =3D dev->sdev;
=20
+			/*
+			 * If the queue accepts only PM, bail out.
+			 */
+			if (blk_queue_pm_only(sdev->request_queue)) {
+				ret =3D -EAGAIN;
+				goto unlock;
+			}
+
 			/*
 			 * If the port was suspended before this was scheduled,
 			 * bail out.

Petr T
