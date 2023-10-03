Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33437B6622
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjJCKP1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 3 Oct 2023 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbjJCKP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 06:15:27 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0BFB0;
        Tue,  3 Oct 2023 03:15:23 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ae4bd149d2so49039b6e.0;
        Tue, 03 Oct 2023 03:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328123; x=1696932923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42N1dQ0IHBJ96zQ+ZL7kKoOE6ouFE7HC3GOwtJOKQgo=;
        b=xIkCkySZWD2RG3u57Wai9V90LxuLzjzH4F3vI/S7Zc9IN89BUc+Q/1tXBjxYXXKDry
         6N7/QhephuNOk2ImCcchUXXDz5sERL7WTT0kmFVb8gHHADcP4UzHPpjhYw2n1jn2JBG0
         mn4oj1yp5iVOrnij3vWajN43R86pCTbTE61yMxji06VPNykl9OevT15jgwoHzuvXzNUt
         fKYE+WunwK3gumxw3KNJmr5u8j2DDbn3nS0SRrFgbxjrfmurTrES7gSeA//KCzH0lQBM
         7mHHBOXjXfPgzsEF0ljcd5VJo6LjLN/kF0lEwPrqS8+Uy1JV8tb2B37zIZd7umbB4K5Z
         sIug==
X-Gm-Message-State: AOJu0Yw6N9Np47KubZBGTosGLGe3xYG+0kYUKoKor3Qr12R45WI0w+Yd
        qKPgmjgdqm7rnxoXGzvLiCuCmatOKXPoFQUUK3LpB6/SGtA=
X-Google-Smtp-Source: AGHT+IHfyI+E4QlSUOpO/CLF61g294Nf8YsRulOrEWYrj0TOTxq0DwKZoQBPqEFakrDsIsgb1jA0HljyO0SRBjUxnUo=
X-Received: by 2002:a05:6808:1997:b0:3ad:f525:52d5 with SMTP id
 bj23-20020a056808199700b003adf52552d5mr16699126oib.4.1696328122844; Tue, 03
 Oct 2023 03:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230930122054.3cf727a4@meshulam> <20231003113135.38384a87@meshulam.tesarici.cz>
In-Reply-To: <20231003113135.38384a87@meshulam.tesarici.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 12:15:10 +0200
Message-ID: <CAJZ5v0i-FV29TUq8E=FGxB_dRKEJvdoKxzwPGAX0C9vnD7O8eg@mail.gmail.com>
Subject: Re: Thinkpad E595 system deadlock on resume from S3
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 3, 2023 at 11:31 AM Petr Tesařík <petr@tesarici.cz> wrote:
>
> Hi again (adding more recipients),
>
> On Sat, 30 Sep 2023 12:20:54 +0200
> Petr Tesařík <petr@tesarici.cz> wrote:
>
> > Hi all,
> >
> > this time no patch (yet). In short, my Thinkpad running v6.6-rc3 fails
> > to resume from S3. It also fails the same way with Tumbleweed v6.5
> > kernel. I was able to capture a crash dump of the v6.5 kernel, and
> > here's my analysis:
> >
> > The system never gets to waking up my SATA SSD disk:
> >
> > [0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda
> >
> > There is a pending resume work for kworker/u32:12 (PID 11032), but this
> > worker is stuck in 'D' state:
> >
> > >>> prog.stack_trace(11032)
> > #0  context_switch (../kernel/sched/core.c:5381:2)
> > #1  __schedule (../kernel/sched/core.c:6710:8)
> > #2  schedule (../kernel/sched/core.c:6786:3)
> > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > #6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
> > #7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
> > #8  process_one_work (../kernel/workqueue.c:2600:2)
> > #9  worker_thread (../kernel/workqueue.c:2751:4)
> > #10 kthread (../kernel/kthread.c:389:9)
> > #11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
> > #12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)
> >
> > acpi_device_hotplug() tries to acquire acpi_scan_lock, which is held by
> > systemd-sleep (PID 11002). This task is also in 'D' state:
> >
> > >>> prog.stack_trace(11002)
> > #0  context_switch (../kernel/sched/core.c:5381:2)
> > #1  __schedule (../kernel/sched/core.c:6710:8)
> > #2  schedule (../kernel/sched/core.c:6786:3)
> > #3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
> > #4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
> > #5  __mutex_lock (../kernel/locking/mutex.c:747:9)
> > #6  device_lock (../include/linux/device.h:958:2)
> > #7  device_complete (../drivers/base/power/main.c:1063:2)
> > #8  dpm_complete (../drivers/base/power/main.c:1121:3)
> > #9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2)
>
> I believe the issue must be somewhere here. The whole suspend and
> resume logic in suspend_devices_and_enter() is framed by
> platform_suspend_begin() and platform_resume_end().
>
> My system is an ACPI system, so suspend_ops contains:
>
>         .begin = acpi_suspend_begin,
>         .end = acpi_pm_end,
>
> Now, acpi_suspend_begin() acquires acpi_scan_lock through
> acpi_pm_start(), and the lock is not released until acpi_pm_end().
> Since dpm_complete() waits for the completion of a work that tries to
> acquire acpi_scan_lock, the system will deadlock.

So holding acpi_scan_lock across suspend-resume is basically to
prevent the hotplug from taking place then IIRC.

> AFAICS either:
>
> a. the ACPI lock cannot be held while dpm_complete() runs, or
> b. ata_scsi_dev_rescan() must not be scheduled before the system is
> resumed, or
> c. acpi_device_hotplug() must be implemented without taking dev->mutex.
>
> My gut feeling is that b. is the right answer.

It's been a while since I looked at that code last time, but then it
has not changed for quite some time too.

It looks like the acpi_device_hotplug() path attempts to acquire
acpi_scan_lock() while holding dev->mutex which is kind of silly.  I
need to check that, though.
