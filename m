Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCE47B699C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjJCM6B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 3 Oct 2023 08:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJCM6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 08:58:01 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108EF9E;
        Tue,  3 Oct 2023 05:57:58 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3af59a017a5so140467b6e.1;
        Tue, 03 Oct 2023 05:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337877; x=1696942677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNzBR5C6zxcLnUmxRZlDwYdKOrbnLcyAQ8EH1jGpZNQ=;
        b=hYtsl9FHUUUS6R8RMQrgYS/qgw2fcA7yBckdCTJRmMBfuiO1kKCyEbgG8TuFfviARc
         Mqclln6O50pJW/mku6/oBCKSMBjPiiZ52+NWAKe0B6bVJiMKw1SMiYT4XKTIwQtWGYO+
         x9YtpA6wrlEtg8yqQDDUPL5BYPskcifLE0AfcVojRnUtS8/xKxCZHsx6fEUsYD72C+Sc
         2xbxfme/FuxXhf88qCcBgX3bGCj7mY+SL8A937rbRgV8eQ6Dx4oJLP3xkzyGeM+eU0az
         l3rFnvwKPdKGmA6Te1+hOR903XlKQ/gDsplHLZBRIe7QL0Mv8eoSJ0HiUZf9E8hDynby
         RK0A==
X-Gm-Message-State: AOJu0Yw5/ITZJclsthXj2UXugEmL4YI9tngU8GSHg7oiAUIE/Qo1arid
        pW0EHNtGALGVKpAJeAKXgWodVrtYdfa/vDq0nwtgqp3y
X-Google-Smtp-Source: AGHT+IEi/lF+fwKgLXsPozRNl/kC1OtXf2xOI1SqHgAFn2jVDjtLudnU+S8pUpyn9iIk16HH1cbtFva9oAbc1trXyMA=
X-Received: by 2002:a05:6808:2013:b0:3ad:ae0d:f845 with SMTP id
 q19-20020a056808201300b003adae0df845mr16563837oiw.5.1696337877119; Tue, 03
 Oct 2023 05:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230930122054.3cf727a4@meshulam> <20231003113135.38384a87@meshulam.tesarici.cz>
 <CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
 <20231003130240.0c64bc2e@meshulam.tesarici.cz> <CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
 <20231003144019.24566b05@meshulam.tesarici.cz> <CAJZ5v0jttFqKE_CLpF+-vJ_wDAuOo_BUS33htpFUs6idNMugKg@mail.gmail.com>
 <20231003145110.1f22adfb@meshulam.tesarici.cz>
In-Reply-To: <20231003145110.1f22adfb@meshulam.tesarici.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 14:57:46 +0200
Message-ID: <CAJZ5v0jbT0DaDpFpLbzO46-Yg6QJ-MrcZAuP+c60q9KpFHAtpQ@mail.gmail.com>
Subject: Re: Thinkpad E595 system deadlock on resume from S3
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 3, 2023 at 2:51 PM Petr Tesařík <petr@tesarici.cz> wrote:
>
> On Tue, 3 Oct 2023 14:48:13 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Oct 3, 2023 at 2:40 PM Petr Tesařík <petr@tesarici.cz> wrote:
> > >
> > > On Tue, 3 Oct 2023 14:34:56 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > On Tue, Oct 3, 2023 at 1:02 PM Petr Tesařík <petr@tesarici.cz> wrote:
> > > > >
> > > > > On Tue, 3 Oct 2023 12:15:10 +0200
> > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > >
> > > > > > On Tue, Oct 3, 2023 at 11:31 AM Petr Tesařík <petr@tesarici.cz> wrote:
> > > > > > >
> > > > > > > Hi again (adding more recipients),
> > > > > > >
> > > > > > > On Sat, 30 Sep 2023 12:20:54 +0200
> > > > > > > Petr Tesařík <petr@tesarici.cz> wrote:
> > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > this time no patch (yet). In short, my Thinkpad running v6.6-rc3 fails
> > > > > > > > to resume from S3. It also fails the same way with Tumbleweed v6.5
> > > > > > > > kernel. I was able to capture a crash dump of the v6.5 kernel, and
> > > > > > > > here's my analysis:
> > > > > > > >
> > > > > > > > The system never gets to waking up my SATA SSD disk:
> > > > > > > >
> > > > > > > > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda
> > > > > > > >
> > > > > > > > There is a pending resume work for kworker/u32:12 (PID 11032), but this
> > > > > > > > worker is stuck in 'D' state:
> > > > > > > >
> > > > > > > > >>> prog.stack_trace(11032)
> > > > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > > > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > > > > > > > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> > > > > > > > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > > > > > > > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > > > > > > > #10 kthread (../kernel/kthread.c:389:9)
> > > > > > > > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > > > > > > > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)
> > > > > > > >
> > > > > > > > acpi_device_hotplug() tries to acquire acpi_scan_lock, which is held by
> > > > > > > > systemd-sleep (PID 11002). This task is also in 'D' state:
> > > > > > > >
> > > > > > > > >>> prog.stack_trace(11002)
> > > > > > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > > > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > > > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > > > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > > > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > > > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > > > > > #6  device_lock (../include/linux/device.h:958:2)
> > > > > > > > #7  device_complete (../drivers/base/power/main.c:1063:2)
> > > > > > > > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > > > > > > > #9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2)
> > > > > > >
> > > > > > > I believe the issue must be somewhere here. The whole suspend and
> > > > > > > resume logic in suspend_devices_and_enter() is framed by
> > > > > > > platform_suspend_begin() and platform_resume_end().
> > > > > > >
> > > > > > > My system is an ACPI system, so suspend_ops contains:
> > > > > > >
> > > > > > >         .begin = acpi_suspend_begin,
> > > > > > >         .end = acpi_pm_end,
> > > > > > >
> > > > > > > Now, acpi_suspend_begin() acquires acpi_scan_lock through
> > > > > > > acpi_pm_start(), and the lock is not released until acpi_pm_end().
> > > > > > > Since dpm_complete() waits for the completion of a work that tries to
> > > > > > > acquire acpi_scan_lock, the system will deadlock.
> > > > > >
> > > > > > So holding acpi_scan_lock across suspend-resume is basically to
> > > > > > prevent the hotplug from taking place then IIRC.
> > > > > >
> > > > > > > AFAICS either:
> > > > > > >
> > > > > > > a. the ACPI lock cannot be held while dpm_complete() runs, or
> > > > > > > b. ata_scsi_dev_rescan() must not be scheduled before the system is
> > > > > > > resumed, or
> > > > > > > c. acpi_device_hotplug() must be implemented without taking dev->mutex.
> > > > > > >
> > > > > > > My gut feeling is that b. is the right answer.
> > > > > >
> > > > > > It's been a while since I looked at that code last time, but then it
> > > > > > has not changed for quite some time too.
> > > > > >
> > > > > > It looks like the acpi_device_hotplug() path attempts to acquire
> > > > > > acpi_scan_lock() while holding dev->mutex which is kind of silly.  I
> > > > > > need to check that, though.
> > > > >
> > > > > Thanks for your willingness. Well, it's not quite what you describe. If
> > > > > it was a simple ABBA deadlock, then it would be reported by lockdep.
> > > > > No, it's more complicated:
> > > > >
> > > > > 1. suspend_devices_and_enter() holds acpi_scan_lock,
> > > > > 2. an ACPI hotplug work runs, but acpi_device_hotplug() goes to sleep
> > > > >    when it gets to acquiring acpi_scan_lock,
> > > > > 3. ata_scsi_dev_rescan() submits a SCSI command and waits for its
> > > > >    completion while holding dev->mutex,
> > > > > 4. the SCSI completion work happens to be put on the same workqueue as
> > > > >    the ACPI hotplug work in step 2,
> > > > >    ^^^--- THIS is how the two events are serialized!
> > > >
> > > > Which is unexpected.
> > > >
> > > > And quite honestly I'm not sure how this can happen, because
> > > > acpi_hotplug_schedule() uses a dedicated workqueue and it is called
> > > > from (a) the "eject" sysfs attribute (which cannot happen while system
> > > > suspend-resume is in progress) and (b) acpi_bus_notify() which has
> > > > nothing to do with SCSI.
> > >
> > > Oh, you're right, and I was too quick. They cannot be on the same
> > > queue...
> > >
> > > > Maybe the workqueue used for the SCSI completion is freezable?
> > >
> > > Yes, that's it:
> > >
> > > *(struct workqueue_struct *)0xffff97d240b2fe00 = {
> > > /* ... */
> > >         .flags = (unsigned int)4,
> > > /* WQ_FREEZABLE            = 1 << 2 */
> > >
> > > Good. But if this workqueue is frozen, the system still cannot make
> > > progress.
> >
> > The problem seems to be that dev->mutex is held while the work item
> > goes to a freezable workqueue and is waited for, which is an almost
> > guaranteed deadlock scenario.
>
> Ah. Thanks for explanation and direction! I'm going to dive into the
> block layer and/or SCSI code and bug other people with my findings.

Please feel free to CC me on that in case I can help.

> I'm sorry for taking your time;

No worries.

> I hope it wasn't too much.

Not at all, I'm generally interested in all issues related to
suspend-resume and this one looks like it may affect a bunch of users.

Cheers!
