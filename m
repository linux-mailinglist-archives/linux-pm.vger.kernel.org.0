Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B167B6916
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjJCMfM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 3 Oct 2023 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJCMfM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 08:35:12 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DCA83;
        Tue,  3 Oct 2023 05:35:09 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6c4c40ca4f4so116435a34.0;
        Tue, 03 Oct 2023 05:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696336508; x=1696941308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtH+7RMt/39KAP0RthxxIDywxVlr9bMDsEp2gtt3+iQ=;
        b=O05FjHcVLKBXCzFCCmabJAybQ6WcUoZgamLbMDCyE1myR5oah5qRTZ4j8+i87+rBMa
         4dI8fsS734MtiJyqB/jEfRlzJmNcp2Qf8IWEve37pPKiYyKxniwew+NH6vuA5BSmKMlr
         x3y766PulsVLBTRjdmr8GuCd4GCwgB2UZIDYIuw9xtZYe8Xj9alh0QwcDE/aOBX2ud3N
         ozoNYTPrF+ba681pPs5vUwmJ8vMw48BI8rRKnDe8OKAorpfEdsJjHGoraEM3QFydhNuU
         hO6/RIAdKUrfa+6nCvOpP1lZBoTp3ZCH8NLeSx3cQ2UXlwE95rG1V9im8o0yUy89F0zs
         c66g==
X-Gm-Message-State: AOJu0Yxl8Qgamei5conuG+cHyWtWeKBGJNzMhofbhZinRELu7GheEqKN
        cZ5jtKYjo5fe+jcOx1vcjiuXUBTSIaTFTvsUSDrdWU6hNio=
X-Google-Smtp-Source: AGHT+IHQQ0CNKqlZRcvT9J3Syi4wqrtsLXlqZRE7rXZP6ZR8JX03uugMVPuXdHJ7WExWRzk9XFBJVnvzQAPhGUrHOtE=
X-Received: by 2002:a05:6808:1997:b0:3af:6453:2d83 with SMTP id
 bj23-20020a056808199700b003af64532d83mr17702627oib.2.1696336508304; Tue, 03
 Oct 2023 05:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230930122054.3cf727a4@meshulam> <20231003113135.38384a87@meshulam.tesarici.cz>
 <CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com> <20231003130240.0c64bc2e@meshulam.tesarici.cz>
In-Reply-To: <20231003130240.0c64bc2e@meshulam.tesarici.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 14:34:56 +0200
Message-ID: <CAJZ5v0hvEyVAwA3r5OWv4W_vTbRXt_Oxv+Avvn6N0=1RoN=NCg@mail.gmail.com>
Subject: Re: Thinkpad E595 system deadlock on resume from S3
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Tue, Oct 3, 2023 at 1:02 PM Petr Tesařík <petr@tesarici.cz> wrote:
>
> On Tue, 3 Oct 2023 12:15:10 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Oct 3, 2023 at 11:31 AM Petr Tesařík <petr@tesarici.cz> wrote:
> > >
> > > Hi again (adding more recipients),
> > >
> > > On Sat, 30 Sep 2023 12:20:54 +0200
> > > Petr Tesařík <petr@tesarici.cz> wrote:
> > >
> > > > Hi all,
> > > >
> > > > this time no patch (yet). In short, my Thinkpad running v6.6-rc3 fails
> > > > to resume from S3. It also fails the same way with Tumbleweed v6.5
> > > > kernel. I was able to capture a crash dump of the v6.5 kernel, and
> > > > here's my analysis:
> > > >
> > > > The system never gets to waking up my SATA SSD disk:
> > > >
> > > > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda
> > > >
> > > > There is a pending resume work for kworker/u32:12 (PID 11032), but this
> > > > worker is stuck in 'D' state:
> > > >
> > > > >>> prog.stack_trace(11032)
> > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > > > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> > > > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > > > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > > > #10 kthread (../kernel/kthread.c:389:9)
> > > > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > > > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)
> > > >
> > > > acpi_device_hotplug() tries to acquire acpi_scan_lock, which is held by
> > > > systemd-sleep (PID 11002). This task is also in 'D' state:
> > > >
> > > > >>> prog.stack_trace(11002)
> > > > #0  context_switch (../kernel/sched/core.c:5381:2)
> > > > #1  __schedule (../kernel/sched/core.c:6710:8)
> > > > #2  schedule (../kernel/sched/core.c:6786:3)
> > > > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > > > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > > > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > > > #6  device_lock (../include/linux/device.h:958:2)
> > > > #7  device_complete (../drivers/base/power/main.c:1063:2)
> > > > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > > > #9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2)
> > >
> > > I believe the issue must be somewhere here. The whole suspend and
> > > resume logic in suspend_devices_and_enter() is framed by
> > > platform_suspend_begin() and platform_resume_end().
> > >
> > > My system is an ACPI system, so suspend_ops contains:
> > >
> > >         .begin = acpi_suspend_begin,
> > >         .end = acpi_pm_end,
> > >
> > > Now, acpi_suspend_begin() acquires acpi_scan_lock through
> > > acpi_pm_start(), and the lock is not released until acpi_pm_end().
> > > Since dpm_complete() waits for the completion of a work that tries to
> > > acquire acpi_scan_lock, the system will deadlock.
> >
> > So holding acpi_scan_lock across suspend-resume is basically to
> > prevent the hotplug from taking place then IIRC.
> >
> > > AFAICS either:
> > >
> > > a. the ACPI lock cannot be held while dpm_complete() runs, or
> > > b. ata_scsi_dev_rescan() must not be scheduled before the system is
> > > resumed, or
> > > c. acpi_device_hotplug() must be implemented without taking dev->mutex.
> > >
> > > My gut feeling is that b. is the right answer.
> >
> > It's been a while since I looked at that code last time, but then it
> > has not changed for quite some time too.
> >
> > It looks like the acpi_device_hotplug() path attempts to acquire
> > acpi_scan_lock() while holding dev->mutex which is kind of silly.  I
> > need to check that, though.
>
> Thanks for your willingness. Well, it's not quite what you describe. If
> it was a simple ABBA deadlock, then it would be reported by lockdep.
> No, it's more complicated:
>
> 1. suspend_devices_and_enter() holds acpi_scan_lock,
> 2. an ACPI hotplug work runs, but acpi_device_hotplug() goes to sleep
>    when it gets to acquiring acpi_scan_lock,
> 3. ata_scsi_dev_rescan() submits a SCSI command and waits for its
>    completion while holding dev->mutex,
> 4. the SCSI completion work happens to be put on the same workqueue as
>    the ACPI hotplug work in step 2,
>    ^^^--- THIS is how the two events are serialized!

Which is unexpected.

And quite honestly I'm not sure how this can happen, because
acpi_hotplug_schedule() uses a dedicated workqueue and it is called
from (a) the "eject" sysfs attribute (which cannot happen while system
suspend-resume is in progress) and (b) acpi_bus_notify() which has
nothing to do with SCSI.

Maybe the workqueue used for the SCSI completion is freezable?

> 5. suspend_devices_and_enter() calls dpm_complete() ->
>    device_complete() -> device_lock() and cannot acquire dev->mutex.
