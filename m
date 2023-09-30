Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59E7B3FEF
	for <lists+linux-pm@lfdr.de>; Sat, 30 Sep 2023 12:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjI3K3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Sep 2023 06:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjI3K3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Sep 2023 06:29:35 -0400
X-Greylist: delayed 512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Sep 2023 03:29:31 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDAE193
        for <linux-pm@vger.kernel.org>; Sat, 30 Sep 2023 03:29:31 -0700 (PDT)
Received: from meshulam (37-48-48-31.nat.epc.tmcz.cz [37.48.48.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 404481881B7
        for <linux-pm@vger.kernel.org>; Sat, 30 Sep 2023 12:20:56 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1696069256; bh=4TD1HZ1LGPGRYRQGWhCDM4MlJtyBb6h0t9nDK8inbtc=;
        h=Date:From:To:Subject:From;
        b=OhsVefXqbkZHl9i8yCbevuYNOQOjDWVxK07+ZcMXbvQNBSZvBhwlWqI0AD/VK6T6x
         5bdvcrHJS+qh33G5v+GScQ6tjYoGxzaXG2toEJtkS+zXcZ2VATdXAjeZHPC7xRu2sP
         MnK16ioPcszaYyPZoPEB79zfF6A3U5NH16gEvfb8H5SrK8CFA/fhyMitPGGSsrRHVB
         6wLk5AWxQpkjLezXeF/w7B1wZaT5z9Q0lOHPLEwfvl88Dv1UY93WAFymcMn/4FWwAz
         znTVeTjQ89R+CotdyWhLLJXioEBrADV2Z2tMZY8suIMcuJe7+LKVEE4bHtWoQVvCkp
         Qd/l+kWuxUMzA==
Date:   Sat, 30 Sep 2023 12:20:54 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     linux-pm@vger.kernel.org
Subject: Thinkpad E595 system deadlock on resume from S3
Message-ID: <20230930122054.3cf727a4@meshulam>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

this time no patch (yet). In short, my Thinkpad running v6.6-rc3 fails
to resume from S3. It also fails the same way with Tumbleweed v6.5
kernel. I was able to capture a crash dump of the v6.5 kernel, and
here's my analysis:

The system never gets to waking up my SATA SSD disk:

[0:0:0:0]    disk    ATA      KINGSTON SEDC600 H5.1  /dev/sda 

There is a pending resume work for kworker/u32:12 (PID 11032), but this
worker is stuck in 'D' state:

>>> prog.stack_trace(11032)
#0  context_switch (../kernel/sched/core.c:5381:2)
#1  __schedule (../kernel/sched/core.c:6710:8)
#2  schedule (../kernel/sched/core.c:6786:3)
#3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
#4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
#5  __mutex_lock (../kernel/locking/mutex.c:747:9)
#6  acpi_device_hotplug (../drivers/acpi/scan.c:382:2)
#7  acpi_hotplug_work_fn (../drivers/acpi/osl.c:1162:2)
#8  process_one_work (../kernel/workqueue.c:2600:2)
#9  worker_thread (../kernel/workqueue.c:2751:4)
#10 kthread (../kernel/kthread.c:389:9)
#11 ret_from_fork (../arch/x86/kernel/process.c:145:3)
#12 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)

acpi_device_hotplug() tries to acquire acpi_scan_lock, which is held by
systemd-sleep (PID 11002). This task is also in 'D' state:

>>> prog.stack_trace(11002)
#0  context_switch (../kernel/sched/core.c:5381:2)
#1  __schedule (../kernel/sched/core.c:6710:8)
#2  schedule (../kernel/sched/core.c:6786:3)
#3  schedule_preempt_disabled (../kernel/sched/core.c:6845:2)
#4  __mutex_lock_common (../kernel/locking/mutex.c:679:3)
#5  __mutex_lock (../kernel/locking/mutex.c:747:9)
#6  device_lock (../include/linux/device.h:958:2)
#7  device_complete (../drivers/base/power/main.c:1063:2)
#8  dpm_complete (../drivers/base/power/main.c:1121:3)
#9  suspend_devices_and_enter (../kernel/power/suspend.c:516:2)
#10 enter_state (../kernel/power/suspend.c:592:10)
#11 pm_suspend (../kernel/power/suspend.c:619:10)
#12 state_store (../kernel/power/main.c:707:11)
#13 kernfs_fop_write_iter (../fs/kernfs/file.c:334:9)
#14 call_write_iter (../include/linux/fs.h:1877:9)
#15 new_sync_write (../fs/read_write.c:491:8)
#16 vfs_write (../fs/read_write.c:584:9)
#17 ksys_write (../fs/read_write.c:637:9)
#18 do_syscall_x64 (../arch/x86/entry/common.c:50:14)
#19 do_syscall_64 (../arch/x86/entry/common.c:80:7)
#20 entry_SYSCALL_64+0xaa/0x1a6 (../arch/x86/entry/entry_64.S:120)

It is trying to acquire dev->mutex, which is in turn held by
kworker/0:0 (PID 10830), also in 'D' state:

>>> prog.stack_trace(10830)
#0  context_switch (../kernel/sched/core.c:5381:2)
#1  __schedule (../kernel/sched/core.c:6710:8)
#2  schedule (../kernel/sched/core.c:6786:3)
#3  blk_queue_enter (../block/blk-core.c:326:3)
#4  blk_mq_alloc_request (../block/blk-mq.c:592:9)
#5  scsi_alloc_request (../drivers/scsi/scsi_lib.c:1139:7)
#6  scsi_execute_cmd (../drivers/scsi/scsi_lib.c:217:8)
#7  scsi_vpd_inquiry (../drivers/scsi/scsi.c:312:11)
#8  scsi_get_vpd_size (../drivers/scsi/scsi.c:345:11)
#9  scsi_get_vpd_size (../drivers/scsi/scsi.c:336:5)
#10 scsi_get_vpd_buf (../drivers/scsi/scsi.c:415:12)
#11 scsi_attach_vpd (../drivers/scsi/scsi.c:483:12)
#12 scsi_rescan_device (../drivers/scsi/scsi_scan.c:1628:2)
#13 ata_scsi_dev_rescan (../drivers/ata/libata-scsi.c:4894:4)
#14 process_one_work (../kernel/workqueue.c:2600:2)
#15 worker_thread (../kernel/workqueue.c:2751:4)
#16 kthread (../kernel/kthread.c:389:9)
#17 ret_from_fork (../arch/x86/kernel/process.c:145:3)
#18 ret_from_fork_asm+0x1b/0x20 (../arch/x86/entry/entry_64.S:304)

And here we are, waiting for the completion of the resume work that is
scheduled on the blocked kworker/u32:12 (PID 11032), see above.

FWIW the deadlock does not happen if autosuspend is turned off for this
disk.

I'm willing to invest more time into debugging, but I'm not well-versed
in power management, so I may need some help from you as to what else I
should look at. Please, include me in Cc of all potential replies; I'm
not subscribed to linux-pm.

Petr T
