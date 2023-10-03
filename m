Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28C47B6EF0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 18:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbjJCQsq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 3 Oct 2023 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjJCQsq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 12:48:46 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDCA9E;
        Tue,  3 Oct 2023 09:48:39 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c61dd1c229so237969a34.0;
        Tue, 03 Oct 2023 09:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351718; x=1696956518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irb00cVove17+s3Tf7TW9K24fCe6oxVKboZAuQ072O0=;
        b=cxf2zSQum0DnoOQxgHN49ZCKzIf+ctiMSmqP5Zl3jwTYVTs3J2Q6TrRnXY1MN6f3NW
         x8iMsWHbtdD5joMcp47hoYOH/KU1H6O5vozgiER8W9y9122k7H7jNQwKEQOe7fLehdha
         Zo8V/ELzWZFyA4RO8v/4KqGufuqZ++7t6+nblWo0+5J9G047V32/F4IWZ0LLKKgTotMC
         fhrSBXnBRYcfQqeM6cCzmq7HDJSHaeefi9cReoumuYH2x83bv4ad4J1Mog6vJBzeTdiR
         W8l4iZyGUOvVENvhTtkUXmo9X0OZ7nO0p+7w4gJUM84BN4ovey8li0TIP5NceLfc5Q8+
         BBMA==
X-Gm-Message-State: AOJu0YxUP8mTMceiNBBuI9ZVrWtY8B3s+BOBS4yLhQU1DiV1svJcNjqQ
        ov2BUKx+MEOFx5TTXGgwvzlfTUz1wqAFeQktA+/rSg2X
X-Google-Smtp-Source: AGHT+IFQ+KqgeV7IQ9MDWiLEf0kK/iY0szcNCNKZ0GNhxgmiWKmgiNTw9y1PgT0RIhPSlFlqMvG6defNA1tpWcBpy3A=
X-Received: by 2002:a05:6808:1a27:b0:3a9:e40c:683c with SMTP id
 bk39-20020a0568081a2700b003a9e40c683cmr138131oib.1.1696351718442; Tue, 03 Oct
 2023 09:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230930122054.3cf727a4@meshulam> <20231003113135.38384a87@meshulam.tesarici.cz>
 <CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
 <20231003130240.0c64bc2e@meshulam.tesarici.cz> <CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
 <20231003144019.24566b05@meshulam.tesarici.cz> <CAJZ5v0jttFqKE_CLpF+-vJ_wDAuOo_BUS33htpFUs6idNMugKg@mail.gmail.com>
 <20231003145110.1f22adfb@meshulam.tesarici.cz> <CAJZ5v0jbT0DaDpFpLbzO46-Yg6QJ-MrcZAuP+c60q9KpFHAtpQ@mail.gmail.com>
 <20231003171710.2c6a913c@meshulam.tesarici.cz>
In-Reply-To: <20231003171710.2c6a913c@meshulam.tesarici.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 18:48:27 +0200
Message-ID: <CAJZ5v0hXZx3ghWrfcTmTzwDJzYqLpzeBhx+CqBjg65Dngc2eRg@mail.gmail.com>
Subject: Re: Thinkpad E595 system deadlock on resume from S3
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 3, 2023 at 5:18 PM Petr Tesařík <petr@tesarici.cz> wrote:
>
> On Tue, 3 Oct 2023 14:57:46 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Oct 3, 2023 at 2:51 PM Petr Tesařík <petr@tesarici.cz> wrote:
> > >
> > > On Tue, 3 Oct 2023 14:48:13 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > On Tue, Oct 3, 2023 at 2:40 PM Petr Tesařík <petr@tesarici.cz> wrote:
> > > > >
> > > > > On Tue, 3 Oct 2023 14:34:56 +0200
> > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > >
> > > > > > On Tue, Oct 3, 2023 at 1:02 PM Petr Tesařík <petr@tesarici.cz> wrote:
> > > > > > >
> > > > > > > On Tue, 3 Oct 2023 12:15:10 +0200
> > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > > On Tue, Oct 3, 2023 at 11:31 AM Petr Tesařík <petr@tesarici.cz> wrote:
> > > > > > > > >
> > > > > > > > > Hi again (adding more recipients),
> > > > > > > > >
> > > > > > > > > On Sat, 30 Sep 2023 12:20:54 +0200
> > > > > > > > > Petr Tesařík <petr@tesarici.cz> wrote:
> > > > > > > > >
> > > > > > > > > > Hi all,
> > > > > > > > > >
> > > > > > > > > > this time no patch (yet). In short, my Thinkpad running v6.6-rc3 fails
> > > > > > > > > > to resume from S3. It also fails the same way with Tumbleweed v6.5
> > > > > > > > > > kernel. I was able to capture a crash dump of the v6.5 kernel, and
> > > > > > > > > > here's my analysis:
> > > > > > > > > >
> > > > > > > > > > The system never gets to waking up my SATA SSD disk:
> > > > > > > > > >
> > > > > > > > > > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda
> > > > > > > > > >
> > > > > > > > > > There is a pending resume work for kworker/u32:12 (PID 11032), but this
> > > > > > > > > > worker is stuck in 'D' state:
> > > > > > > > > >
> > > > > > > > > > >>> prog.stack_trace(11032)
> > > > > > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > > > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > > > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > > > > > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > > > > > > > > > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> > > > > > > > > > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > > > > > > > > > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > > > > > > > > > #10 kthread (../kernel/kthread.c:389:9)
> > > > > > > > > > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > > > > > > > > > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)
> > > > > > > > > >
> > > > > > > > > > acpi_device_hotplug() tries to acquire acpi_scan_lock, which is held by
> > > > > > > > > > systemd-sleep (PID 11002). This task is also in 'D' state:
> > > > > > > > > >
> > > > > > > > > > >>> prog.stack_trace(11002)
> > > > > > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > > > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > > > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > > > > > #6  device_lock (../include/linux/device.h:958:2)
> > > > > > > > > > #7  device_complete (../drivers/base/power/main.c:1063:2)
> > > > > > > > > > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > > > > > > > > > #9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2)
> > > > > > > > >
> > > > > > > > > I believe the issue must be somewhere here. The whole suspend and
> > > > > > > > > resume logic in suspend_devices_and_enter() is framed by
> > > > > > > > > platform_suspend_begin() and platform_resume_end().
> > > > > > > > >
> > > > > > > > > My system is an ACPI system, so suspend_ops contains:
> > > > > > > > >
> > > > > > > > >         .begin = acpi_suspend_begin,
> > > > > > > > >         .end = acpi_pm_end,
> > > > > > > > >
> > > > > > > > > Now, acpi_suspend_begin() acquires acpi_scan_lock through
> > > > > > > > > acpi_pm_start(), and the lock is not released until acpi_pm_end().
> > > > > > > > > Since dpm_complete() waits for the completion of a work that tries to
> > > > > > > > > acquire acpi_scan_lock, the system will deadlock.
> > > > > > > >
> > > > > > > > So holding acpi_scan_lock across suspend-resume is basically to
> > > > > > > > prevent the hotplug from taking place then IIRC.
> > > > > > > >
> > > > > > > > > AFAICS either:
> > > > > > > > >
> > > > > > > > > a. the ACPI lock cannot be held while dpm_complete() runs, or
> > > > > > > > > b. ata_scsi_dev_rescan() must not be scheduled before the system is
> > > > > > > > > resumed, or
> > > > > > > > > c. acpi_device_hotplug() must be implemented without taking dev->mutex.
> > > > > > > > >
> > > > > > > > > My gut feeling is that b. is the right answer.
> > > > > > > >
> > > > > > > > It's been a while since I looked at that code last time, but then it
> > > > > > > > has not changed for quite some time too.
> > > > > > > >
> > > > > > > > It looks like the acpi_device_hotplug() path attempts to acquire
> > > > > > > > acpi_scan_lock() while holding dev->mutex which is kind of silly.  I
> > > > > > > > need to check that, though.
> > > > > > >
> > > > > > > Thanks for your willingness. Well, it's not quite what you describe. If
> > > > > > > it was a simple ABBA deadlock, then it would be reported by lockdep.
> > > > > > > No, it's more complicated:
> > > > > > >
> > > > > > > 1. suspend_devices_and_enter() holds acpi_scan_lock,
> > > > > > > 2. an ACPI hotplug work runs, but acpi_device_hotplug() goes to sleep
> > > > > > >    when it gets to acquiring acpi_scan_lock,
> > > > > > > 3. ata_scsi_dev_rescan() submits a SCSI command and waits for its
> > > > > > >    completion while holding dev->mutex,
> > > > > > > 4. the SCSI completion work happens to be put on the same workqueue as
> > > > > > >    the ACPI hotplug work in step 2,
> > > > > > >    ^^^--- THIS is how the two events are serialized!
> > > > > >
> > > > > > Which is unexpected.
> > > > > >
> > > > > > And quite honestly I'm not sure how this can happen, because
> > > > > > acpi_hotplug_schedule() uses a dedicated workqueue and it is called
> > > > > > from (a) the "eject" sysfs attribute (which cannot happen while system
> > > > > > suspend-resume is in progress) and (b) acpi_bus_notify() which has
> > > > > > nothing to do with SCSI.
> > > > >
> > > > > Oh, you're right, and I was too quick. They cannot be on the same
> > > > > queue...
> > > > >
> > > > > > Maybe the workqueue used for the SCSI completion is freezable?
> > > > >
> > > > > Yes, that's it:
> > > > >
> > > > > *(struct workqueue_struct *)0xffff97d240b2fe00 = {
> > > > > /* ... */
> > > > >         .flags = (unsigned int)4,
> > > > > /* WQ_FREEZABLE            = 1 << 2 */
> > > > >
> > > > > Good. But if this workqueue is frozen, the system still cannot make
> > > > > progress.
> > > >
> > > > The problem seems to be that dev->mutex is held while the work item
> > > > goes to a freezable workqueue and is waited for, which is an almost
> > > > guaranteed deadlock scenario.
> > >
> > > Ah. Thanks for explanation and direction! I'm going to dive into the
> > > block layer and/or SCSI code and bug other people with my findings.
> >
> > Please feel free to CC me on that in case I can help.
>
> And here I am again... The frozen workqueue is in fact pm_wq, and the
> work item that is waited for is pm_runtime_work. The block layer calls
> pm_request_resume() on the device to resume the queue.

If it called pm_runtime_resume() instead, this might work.

> I bet the queue should not be resumed this early. In fact, it seems
> that this is somewhat known to the ATA developers, because
> ata_scsi_dev_rescan() contains this beautiful comment and code:
>
>                         /*
>                          * If the rescan work was scheduled because of a resume
>                          * event, the port is already fully resumed, but the
>                          * SCSI device may not yet be fully resumed. In such
>                          * case, executing scsi_rescan_device() may cause a
>                          * deadlock with the PM code on device_lock(). Prevent
>                          * this by giving up and retrying rescan after a short
>                          * delay.
>                          */
>                         delay_rescan = sdev->sdev_gendev.power.is_suspended;
>                         if (delay_rescan) {
>                                 scsi_device_put(sdev);
>                                 break;
>                         }
>
> It just doesn't seem to work as expected, at least not in my case.

Well, calling pm_request_resume() and waiting for the resume to
actually happen is problematic regardless.  It is just better to call
pm_runtime_resume() to synchronously resume the device instead.
