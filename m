Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE387B6E2C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 18:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJCQQe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Oct 2023 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJCQQd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 12:16:33 -0400
X-Greylist: delayed 3473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 09:16:29 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B59E;
        Tue,  3 Oct 2023 09:16:29 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id DDB0F18E89A;
        Tue,  3 Oct 2023 18:16:27 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1696349788; bh=1DdCGfBJU7Xq4ub9ZwFDB6KZyoh9cjOP/C0Nq+W8fl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=5dyt3Rl32U5RO6fENme7I8JKvAfxrckQKWkEdRepmpjimODH9YP9+8s0QYtTU8Lor
         ntPs6lnZXrFTRdeiyJShQF3iW6hp2CuF7jrnexOzIBnHrqGzGcQ/frtYXuOVn6VbUT
         SU1LYZPaCxDtdz3UfPuNeeMuden+QHdSUBZk9i3kvpMXBIar1GrY9mF4MN6XVnJ0a5
         jpeKFs8xOnZLPnU+kKRHpSeL2Qc4+Pw9di4VdB3XgCJD2cw1oPVLct7VNwsxHxmwQu
         y8i7KvGdArcMNUM8UQigkifm9sLhXhBK/DlM61UPTmxmcbJIshYEgK4tlNE3LSXIXp
         oPoSquH2xidtw==
Date:   Tue, 3 Oct 2023 18:16:21 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Thinkpad E595 system deadlock on resume from S3
Message-ID: <20231003181621.053fc01b@meshulam.tesarici.cz>
In-Reply-To: <20231003171710.2c6a913c@meshulam.tesarici.cz>
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
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Oct 2023 17:18:24 +0200
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> On Tue, 3 Oct 2023 14:57:46 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>=20
> > On Tue, Oct 3, 2023 at 2:51=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tes=
arici.cz> wrote: =20
> > >
> > > On Tue, 3 Oct 2023 14:48:13 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >   =20
> > > > On Tue, Oct 3, 2023 at 2:40=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr=
@tesarici.cz> wrote:   =20
> > > > >
> > > > > On Tue, 3 Oct 2023 14:34:56 +0200
> > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > >   =20
> > > > > > On Tue, Oct 3, 2023 at 1:02=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <=
petr@tesarici.cz> wrote:   =20
> > > > > > >
> > > > > > > On Tue, 3 Oct 2023 12:15:10 +0200
> > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > >   =20
> > > > > > > > On Tue, Oct 3, 2023 at 11:31=E2=80=AFAM Petr Tesa=C5=99=C3=
=ADk <petr@tesarici.cz> wrote:   =20
> > > > > > > > >
> > > > > > > > > Hi again (adding more recipients),
> > > > > > > > >
> > > > > > > > > On Sat, 30 Sep 2023 12:20:54 +0200
> > > > > > > > > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> > > > > > > > >   =20
> > > > > > > > > > Hi all,
> > > > > > > > > >
> > > > > > > > > > this time no patch (yet). In short, my Thinkpad running=
 v6.6-rc3 fails
> > > > > > > > > > to resume from S3. It also fails the same way with Tumb=
leweed v6.5
> > > > > > > > > > kernel. I was able to capture a crash dump of the v6.5 =
kernel, and
> > > > > > > > > > here's my analysis:
> > > > > > > > > >
> > > > > > > > > > The system never gets to waking up my SATA SSD disk:
> > > > > > > > > >
> > > > > > > > > > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /d=
ev/sda
> > > > > > > > > >
> > > > > > > > > > There is a pending resume work for kworker/u32:12 (PID =
11032), but this
> > > > > > > > > > worker is stuck in 'D' state:
> > > > > > > > > >   =20
> > > > > > > > > > >>> prog.stack_trace(11032)   =20
> > > > > > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6=
845:2)
> > > > > > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:=
3)
> > > > > > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > > > > > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > > > > > > > > > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> > > > > > > > > > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > > > > > > > > > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > > > > > > > > > #10 kthread (../kernel/kthread.c:389:9)
> > > > > > > > > > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > > > > > > > > > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entr=
y_64.S:304)
> > > > > > > > > >
> > > > > > > > > > acpi_device_hotplug() tries to acquire acpi_scan_lock, =
which is held by
> > > > > > > > > > systemd-sleep (PID 11002). This task is also in 'D' sta=
te:
> > > > > > > > > >   =20
> > > > > > > > > > >>> prog.stack_trace(11002)   =20
> > > > > > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6=
845:2)
> > > > > > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:=
3)
> > > > > > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > > > > > #6  device_lock (../include/linux/device.h:958:2)
> > > > > > > > > > #7  device_complete (../drivers/base/power/main.c:1063:=
2)
> > > > > > > > > > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > > > > > > > > > #9  suspend_devices_and_enter (../kernel/power/suspend.=
c:516:2)   =20
> > > > > > > > >
> > > > > > > > > I believe the issue must be somewhere here. The whole sus=
pend and
> > > > > > > > > resume logic in suspend_devices_and_enter() is framed by
> > > > > > > > > platform_suspend_begin() and platform_resume_end().
> > > > > > > > >
> > > > > > > > > My system is an ACPI system, so suspend_ops contains:
> > > > > > > > >
> > > > > > > > >         .begin =3D acpi_suspend_begin,
> > > > > > > > >         .end =3D acpi_pm_end,
> > > > > > > > >
> > > > > > > > > Now, acpi_suspend_begin() acquires acpi_scan_lock through
> > > > > > > > > acpi_pm_start(), and the lock is not released until acpi_=
pm_end().
> > > > > > > > > Since dpm_complete() waits for the completion of a work t=
hat tries to
> > > > > > > > > acquire acpi_scan_lock, the system will deadlock.   =20
> > > > > > > >
> > > > > > > > So holding acpi_scan_lock across suspend-resume is basicall=
y to
> > > > > > > > prevent the hotplug from taking place then IIRC.
> > > > > > > >   =20
> > > > > > > > > AFAICS either:
> > > > > > > > >
> > > > > > > > > a. the ACPI lock cannot be held while dpm_complete() runs=
, or
> > > > > > > > > b. ata_scsi_dev_rescan() must not be scheduled before the=
 system is
> > > > > > > > > resumed, or
> > > > > > > > > c. acpi_device_hotplug() must be implemented without taki=
ng dev->mutex.
> > > > > > > > >
> > > > > > > > > My gut feeling is that b. is the right answer.   =20
> > > > > > > >
> > > > > > > > It's been a while since I looked at that code last time, bu=
t then it
> > > > > > > > has not changed for quite some time too.
> > > > > > > >
> > > > > > > > It looks like the acpi_device_hotplug() path attempts to ac=
quire
> > > > > > > > acpi_scan_lock() while holding dev->mutex which is kind of =
silly.  I
> > > > > > > > need to check that, though.   =20
> > > > > > >
> > > > > > > Thanks for your willingness. Well, it's not quite what you de=
scribe. If
> > > > > > > it was a simple ABBA deadlock, then it would be reported by l=
ockdep.
> > > > > > > No, it's more complicated:
> > > > > > >
> > > > > > > 1. suspend_devices_and_enter() holds acpi_scan_lock,
> > > > > > > 2. an ACPI hotplug work runs, but acpi_device_hotplug() goes =
to sleep
> > > > > > >    when it gets to acquiring acpi_scan_lock,
> > > > > > > 3. ata_scsi_dev_rescan() submits a SCSI command and waits for=
 its
> > > > > > >    completion while holding dev->mutex,
> > > > > > > 4. the SCSI completion work happens to be put on the same wor=
kqueue as
> > > > > > >    the ACPI hotplug work in step 2,
> > > > > > >    ^^^--- THIS is how the two events are serialized!   =20
> > > > > >
> > > > > > Which is unexpected.
> > > > > >
> > > > > > And quite honestly I'm not sure how this can happen, because
> > > > > > acpi_hotplug_schedule() uses a dedicated workqueue and it is ca=
lled
> > > > > > from (a) the "eject" sysfs attribute (which cannot happen while=
 system
> > > > > > suspend-resume is in progress) and (b) acpi_bus_notify() which =
has
> > > > > > nothing to do with SCSI.   =20
> > > > >
> > > > > Oh, you're right, and I was too quick. They cannot be on the same
> > > > > queue...
> > > > >   =20
> > > > > > Maybe the workqueue used for the SCSI completion is freezable? =
  =20
> > > > >
> > > > > Yes, that's it:
> > > > >
> > > > > *(struct workqueue_struct *)0xffff97d240b2fe00 =3D {
> > > > > /* ... */
> > > > >         .flags =3D (unsigned int)4,
> > > > > /* WQ_FREEZABLE            =3D 1 << 2 */
> > > > >
> > > > > Good. But if this workqueue is frozen, the system still cannot ma=
ke
> > > > > progress.   =20
> > > >
> > > > The problem seems to be that dev->mutex is held while the work item
> > > > goes to a freezable workqueue and is waited for, which is an almost
> > > > guaranteed deadlock scenario.   =20
> > >
> > > Ah. Thanks for explanation and direction! I'm going to dive into the
> > > block layer and/or SCSI code and bug other people with my findings.  =
 =20
> >=20
> > Please feel free to CC me on that in case I can help. =20
>=20
> And here I am again... The frozen workqueue is in fact pm_wq, and the
> work item that is waited for is pm_runtime_work. The block layer calls
> pm_request_resume() on the device to resume the queue.
>=20
> I bet the queue should not be resumed this early. In fact, it seems
> that this is somewhat known to the ATA developers, because
> ata_scsi_dev_rescan() contains this beautiful comment and code:
>=20
> 			/*
> 			 * If the rescan work was scheduled because of a resume
> 			 * event, the port is already fully resumed, but the
> 			 * SCSI device may not yet be fully resumed. In such
> 			 * case, executing scsi_rescan_device() may cause a
> 			 * deadlock with the PM code on device_lock(). Prevent
> 			 * this by giving up and retrying rescan after a short
> 			 * delay.
> 			 */
> 			delay_rescan =3D sdev->sdev_gendev.power.is_suspended;
> 			if (delay_rescan) {
> 				scsi_device_put(sdev);
> 				break;
> 			}
>=20
> It just doesn't seem to work as expected, at least not in my case.

Erm. This was v6.5.2, where I originally encountered the issue. I can
see that this snippet has just been changed by commit 8b4d9469d0b0.

@Daniel: I can still reproduce a deadlock on resume with v6.6-rc4.

Petr T
