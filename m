Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89FD3BC88E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhGFJiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 05:38:24 -0400
Received: from first.geanix.com ([116.203.34.67]:44334 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhGFJiY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 05:38:24 -0400
Received: from skn-laptop (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 565D04C5704;
        Tue,  6 Jul 2021 09:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1625564143; bh=d/k8860e8AFp6tYBkjh53bVB2t0WYaWnLcXmdEFyTFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NIeERh8FH0EypgDkT5dX93Za4SZ7gO2QpeD4YUHwRTe46f7tUcsV/PPJcCYfzBxMh
         G5WG+A5oKnl8zDKLJtGOWsHJRhD6vdNJ0r4GMLAJisijCv19dwYrAadxOGns4vfVgH
         ECB5IiYcdAeH9krU+wNkpV6Ga4PlPDkGwfRTx/rgPVmCTli8VJ/slJ+LYpuWaNnkYJ
         C63QPbg7MOKVvm3jKffqz19ZyNNV6wiNwP9pNFwIWLwFfA11EH7wTQXCn4NE7gsycY
         +1+yQYTHIqCE265OcrYtQvAtKruDBd9sJh7Wao3VpBq4glu2NXr4Zi2v6lTEhRLi9o
         HpDOMoH/sd1eg==
Date:   Tue, 6 Jul 2021 11:35:41 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     s.hauer@pengutronix.de, miquel.raynal@bootlin.com, richard@nod.at
Cc:     linux-pm@vger.kernel.org, han.xu@nxp.com,
        linux-mtd@lists.infradead.org
Subject: Re: [BUG RESEND] unsuspend failure under load
Message-ID: <20210706093541.f4kjxqrkft7fqbcx@skn-laptop>
References: <20210705065833.2ezlhaspkkju4bh7@skn-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210705065833.2ezlhaspkkju4bh7@skn-laptop>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 05, 2021 at 08:58:38AM +0200, Sean Nyekjaer wrote:
> Hi Miquel and Sascha,
+ Richard + linux-pm
> 
> We are having some trouble when our i.MX6 unsuspends while writes to
> ubifs is in progess. In the log it looks like it syncing the filesystem
> before suspend.
> 
> The SoC a i.MX6ul/ull, the issue is (lucky for us) quite easy to reproduce.
> The reproduce script: [0]
> Kernel log when it happens: [1]
> 
> I have bisected the bug to: ef347c0cfd61 ("mtd: rawnand: gpmi: Implement exec_op")
> 
> Any idea to where I should start looking? or to what happens?
> 
> Esben have posted to patches that relates to suspend/unsuspend but it
> doesn't seem to releated to this issue.
> 5bc6bb603b4d ("mtd: rawnand: gpmi: Fix suspend/resume problem")
> d70486668cdf ("mtd: rawnand: gpmi: Restore nfc timing setup after suspend/resume")
> 
> /Sean

nand_resume() is called some time after ubi_io_write tries to write. Thats why
mtd_write() is returning -EBUSY.

I have tried patch [3], and it seems to fix it.
I think it would be okay to add the retry option, but the mdelay is not
obviously a nogo.

Any idea to how we could wait here for the nand_resume() to be called?

@linux-pm:
I have noticed "Filsystems sync" happens before "Freezing user space
processes".
If I apply patch [4] (without [3]), it would also fix our issue. But I
don't have en insight in to what impact the change might have.

/Sean

> 
> [0]
> #!/bin/sh
> dd if=/dev/urandom of=/tmp/test50M bs=1M count=50
> cp /tmp/test50M /data/ &
> echo mem > /sys/power/state
> 
> [1]
> root@iwg26-v2:/data/root# ./ubicrash.sh
> 50+0 records in
> 50+0 records out
> PM: suspend entry (deep)
> Filesystems sync: 33.642 seconds
> Freezing user space processes ... (elapsed 0.004 seconds) done.
> OOM killer disabled.
> Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
> printk: Suspending console(s) (use no_console_suspend to debug)
> <SUSPEND/WAKE>
> PM: suspend devices took 0.040 seconds
> Disabling non-boot CPUs ...
> ubi0 error: ubi_io_write: error -16 while writing 4096 bytes to PEB 544:53248, written 0 bytes
> CPU: 0 PID: 69 Comm: kworker/u2:2 Not tainted 5.13.0 #3
> Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> Workqueue: writeback wb_workfn (flush-ubifs_0_8)
> [<c010d9b0>] (unwind_backtrace) from [<c010a28c>] (show_stack+0x10/0x14)
> [<c010a28c>] (show_stack) from [<c0970798>] (dump_stack+0xc0/0xdc)
> [<c0970798>] (dump_stack) from [<c05dfe10>] (ubi_io_write+0x510/0x6b0)
> [<c05dfe10>] (ubi_io_write) from [<c05dcd90>] (ubi_eba_write_leb+0x388/0x910)
> [<c05dcd90>] (ubi_eba_write_leb) from [<c05daf34>] (ubi_leb_write+0xd0/0xe8)
> [<c05daf34>] (ubi_leb_write) from [<c03cfeb4>] (ubifs_leb_write+0x68/0x104)

[ ... ]

> UBIFS error (ubi0:8 pid 157): make_reservation: cannot reserve 4144 bytes in jhead 2, error -30
> UBIFS error (ubi0:8 pid 157): do_writepage: cannot write page 10962 of inode 821, error -30
> UBIFS error (ubi0:8 pid 157): make_reservation: cannot reserve 4144 bytes in jhead 2, error -30
> UBIFS error (ubi0:8 pid 157): do_writepage: cannot write page 10963 of inode 821, error -30
> UBIFS error (ubi0:8 pid 157): make_reservation: cannot reserve 696 bytes in jhead 2, error -30
> UBIFS error (ubi0:8 pid 157): do_writepage: cannot write page 0 of inode 819, error -30
> UBIFS error (ubi0:8 pid 157): make_reservation: cannot reserve 4144 bytes in jhead 2, error -30

[3]:
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 14d890b00d2c..b24c571fa022 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -268,8 +269,18 @@ int ubi_io_write(struct ubi_device *ubi, const void *buf, int pnum, int offset,
 	}

 	addr = (loff_t)pnum * ubi->peb_size + offset;
+retry:
 	err = mtd_write(ubi->mtd, addr, len, &written, buf);
 	if (err) {
+		if (retries++ < UBI_IO_RETRIES) {
+			ubi_warn(ubi, "error %d while writing %d bytes to PEB %d:%d, written %zd bytes",
+				 err, len, pnum, offset, written);
+			mdelay(25); yield();
+			goto retry;
+		}
+
 		ubi_err(ubi, "error %d while writing %d bytes to PEB %d:%d, written %zd bytes",
 			err, len, pnum, offset, written);
 		dump_stack();

[4]:
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 32391acc806b..61a213ad5a13 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -563,18 +563,18 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
-	if (sync_on_suspend_enabled) {
-		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
-		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
-	}
-
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
 	pm_suspend_clear_flags();
 	error = suspend_prepare(state);
 	if (error)
 		goto Unlock;
 
+	if (sync_on_suspend_enabled) {
+		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+		ksys_sync_helper();
+		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+	}
+
 	if (suspend_test(TEST_FREEZER))
 		goto Finish;
 
