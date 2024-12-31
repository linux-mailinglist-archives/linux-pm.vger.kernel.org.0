Return-Path: <linux-pm+bounces-19863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4609FEC98
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 04:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21091882878
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 03:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E593713D521;
	Tue, 31 Dec 2024 03:52:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD03211
	for <linux-pm@vger.kernel.org>; Tue, 31 Dec 2024 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735617144; cv=none; b=jH+tG8Vk1HPxbE6Wv7t6Urs8hJ6ualL9kSa8myKVRNCfJpPSmeDjlwPuSoZVrOUDhkcgP+HhWS+3E9g8aTAhElKc0enp7M1ucQekZSoNzBj7seCTm5ua0EfRW618xktah5Z1Udig2Z2sWS/crGF33xEXUSbppI0dxHGZ18Omp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735617144; c=relaxed/simple;
	bh=llqlyr57jPEm73zj1SnbD0rVIbgW2fsi2JAqT/kSd3o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jPsRrg9QkWAna0MBSQQEaD7enwVdcOXp34InfwEIK44U1v9oXrb6ybSQdegEeJr1yf6EbaOFn5MKuPmnx/DYjc23ww86K96dovIgCGNRGJSdiq0sLogXGnNfejrbglbSDy7MfCphCuPWrqUiPr3k/fDG7Y+j96hFz6cyayV3FjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso106705865ab.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 19:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735617142; x=1736221942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbSqyRgaN3HtuSeIx3anoXya0bSqEBFujqJsWXRF/+8=;
        b=wqZIVaTwkASP+YZ4gOOLCwqGFP2WTCg8nvOMxuD+H7tQJJi00zLAnN1Se49GzMFX+k
         f4R7uBSqsowgUgKs3tSels6ELGdf/gqJrITeZhgJGuFIzXHXOWffLUSiBqO9hqGHvjva
         HmXTCSHzTJSdI70g3DaRsMt2nIYQXkZ1n1iH2QRv2YoF2H3IaVfI7p+ki9V3ilbzl8Up
         SD8THHUJI6DpOaZbrQ3t0CZf0/K+WPrLiAWFI47KmHa/05ilcqtrgOkNRxPEqPBwYzyE
         nlvWr9IL09dbz02eZcx6KkZ6mFpNlrhke35AZJASNYXIiWb9B+miKp1FuSojrLj8tEWm
         vlcw==
X-Forwarded-Encrypted: i=1; AJvYcCXpWut2/NnyiBYSOM0fnN8GeWny2ihUZ/Jcq+eUXGSZkA/AZvhBoSSkU1CB12KSiOpycdhx20oQVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUCwJO0fhYAee4VnZ0J3lCc9m5h+i7KbKXKtKXj/ScKyfhGNVS
	rSDLAfaRY/CTt+IC8SVUTdFMZAfwKBQV46G87CZzCZWVyqc8XlbNZoZe8qjLWJRlpH8x10sDz8n
	/grLJ52fhDMM/mFGn+DGXRqYbqGLniUNYQVPLf9lQ33RFE/YyKnIlfpI=
X-Google-Smtp-Source: AGHT+IFVdgzu1nSxDtG6pnW+zSovd7kbiyMJ3kVZa63RVuM2TW0k+cij2OCpLkokfrLVxGS7cwJhnBM8eBti+U3L8PVf5HeJNUot
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b42:b0:3a7:e83c:2d07 with SMTP id
 e9e14a558f8ab-3c2d2d52b3dmr225673365ab.14.1735617142077; Mon, 30 Dec 2024
 19:52:22 -0800 (PST)
Date: Mon, 30 Dec 2024 19:52:22 -0800
In-Reply-To: <6767d3f5.050a0220.226966.001e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67736a76.050a0220.2f3838.04d6.GAE@google.com>
Subject: Re: [syzbot] [pm?] possible deadlock in rpm_suspend
From: syzbot <syzbot+361e2c54f7f4bf035391@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15b4eac4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=361e2c54f7f4bf035391
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136beaf8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16491818580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b18faca00a0e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+361e2c54f7f4bf035391@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc3-next-20241220-syzkaller #0 Not tainted
------------------------------------------------------
kworker/0:0/8 is trying to acquire lock:
ffffffff8e813700 (console_owner){....}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:2048 [inline]
ffffffff8e813700 (console_owner){....}-{0:0}, at: vprintk_emit+0x530/0xa10 kernel/printk/printk.c:2431

but task is already holding lock:
ffff8880b863e118 (&pool->lock){-.-.}-{2:2}, at: start_flush_work kernel/workqueue.c:4148 [inline]
ffff8880b863e118 (&pool->lock){-.-.}-{2:2}, at: __flush_work+0x1b0/0xc60 kernel/workqueue.c:4199

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&pool->lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x759/0xf50
       queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
       queue_work include/linux/workqueue.h:662 [inline]
       rpm_suspend+0xe70/0x1730 drivers/base/power/runtime.c:662
       __pm_runtime_idle+0x131/0x1a0 drivers/base/power/runtime.c:1104
       pm_runtime_put include/linux/pm_runtime.h:448 [inline]
       __device_attach+0x3e5/0x520 drivers/base/dd.c:1048
       bus_probe_device+0x189/0x260 drivers/base/bus.c:534
       device_add+0x856/0xbf0 drivers/base/core.c:3665
       serial_base_port_add+0x2b6/0x3f0 drivers/tty/serial/serial_base_bus.c:179
       serial_core_port_device_add drivers/tty/serial/serial_core.c:3344 [inline]
       serial_core_register_port+0x377/0x2870 drivers/tty/serial/serial_core.c:3383
       serial8250_register_8250_port+0x1545/0x1ec0 drivers/tty/serial/8250/8250_core.c:820
       serial_pnp_probe+0x4f9/0x9d0 drivers/tty/serial/8250/8250_pnp.c:490
       pnp_device_probe+0x2ba/0x460 drivers/pnp/driver.c:111
       really_probe+0x2b9/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
       bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
       bus_add_driver+0x346/0x670 drivers/base/bus.c:675
       driver_register+0x23a/0x320 drivers/base/driver.c:246
       serial8250_init+0xc1/0x1c0 drivers/tty/serial/8250/8250_platform.c:324
       do_one_initcall+0x248/0x870 init/main.c:1267
       do_initcall_level+0x157/0x210 init/main.c:1329
       do_initcalls+0x3f/0x80 init/main.c:1345
       kernel_init_freeable+0x435/0x5d0 init/main.c:1578
       kernel_init+0x1d/0x2b0 init/main.c:1467
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&dev->power.lock){-.-.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __pm_runtime_resume+0x112/0x180 drivers/base/power/runtime.c:1171
       pm_runtime_get include/linux/pm_runtime.h:396 [inline]
       __uart_start+0x17c/0x450 drivers/tty/serial/serial_core.c:148
       uart_write+0x280/0xa40 drivers/tty/serial/serial_core.c:635
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0xd62/0x1230 drivers/tty/n_tty.c:2389
       iterate_tty_write drivers/tty/tty_io.c:1015 [inline]
       file_tty_write+0x546/0x9b0 drivers/tty/tty_io.c:1090
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xacf/0xd10 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:715 [inline]
       serial8250_console_write+0x1a7/0x1ed0 drivers/tty/serial/8250/8250_port.c:3372
       console_emit_next_record kernel/printk/printk.c:3122 [inline]
       console_flush_all+0x86b/0xeb0 kernel/printk/printk.c:3210
       __console_flush_and_unlock kernel/printk/printk.c:3269 [inline]
       console_unlock+0x14f/0x3b0 kernel/printk/printk.c:3309
       vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2432
       _printk+0xd5/0x120 kernel/printk/printk.c:2457
       register_console+0xbf5/0xfd0 kernel/printk/printk.c:4099
       univ8250_console_init+0x52/0x90 drivers/tty/serial/8250/8250_core.c:513
       console_init+0x1b8/0x6f0 kernel/printk/printk.c:4292
       start_kernel+0x2dd/0x510 init/main.c:1038
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:515
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:496
       common_startup_64+0x13e/0x147

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       console_trylock_spinning kernel/printk/printk.c:2048 [inline]
       vprintk_emit+0x54d/0xa10 kernel/printk/printk.c:2431
       _printk+0xd5/0x120 kernel/printk/printk.c:2457
       __warn_printk+0x237/0x360 kernel/panic.c:794
       check_flush_dependency+0x328/0x3c0 kernel/workqueue.c:3708
       start_flush_work kernel/workqueue.c:4162 [inline]
       __flush_work+0x286/0xc60 kernel/workqueue.c:4199
       flush_work kernel/workqueue.c:4256 [inline]
       flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4278
       hfs_file_fsync+0xea/0x140 fs/hfs/inode.c:680
       generic_write_sync include/linux/fs.h:2952 [inline]
       dio_complete+0x55c/0x6b0 fs/direct-io.c:313
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  console_owner --> &dev->power.lock --> &pool->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pool->lock);
                               lock(&dev->power.lock);
                               lock(&pool->lock);
  lock(console_owner);

 *** DEADLOCK ***

5 locks held by kworker/0:0/8:
 #0: ffff8880325f5d48 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff8880325f5d48 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc900000d7c60 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900000d7c60 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88807b1a29a0 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #2: ffff88807b1a29a0 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: hfs_file_fsync+0x95/0x140 fs/hfs/inode.c:673
 #3: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #3: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: start_flush_work kernel/workqueue.c:4141 [inline]
 #3: ffffffff8e937da0 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xe9/0xc60 kernel/workqueue.c:4199
 #4: ffff8880b863e118 (&pool->lock){-.-.}-{2:2}, at: start_flush_work kernel/workqueue.c:4148 [inline]
 #4: ffff8880b863e118 (&pool->lock){-.-.}-{2:2}, at: __flush_work+0x1b0/0xc60 kernel/workqueue.c:4199

stack backtrace:
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: dio/loop4 dio_aio_complete_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 console_trylock_spinning kernel/printk/printk.c:2048 [inline]
 vprintk_emit+0x54d/0xa10 kernel/printk/printk.c:2431
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 __warn_printk+0x237/0x360 kernel/panic.c:794
 check_flush_dependency+0x328/0x3c0 kernel/workqueue.c:3708
 start_flush_work kernel/workqueue.c:4162 [inline]
 __flush_work+0x286/0xc60 kernel/workqueue.c:4199
 flush_work kernel/workqueue.c:4256 [inline]
 flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4278
 hfs_file_fsync+0xea/0x140 fs/hfs/inode.c:680
 generic_write_sync include/linux/fs.h:2952 [inline]
 dio_complete+0x55c/0x6b0 fs/direct-io.c:313
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
workqueue: WQ_MEM_RECLAIM dio/loop4:dio_aio_complete_work is flushing !WQ_MEM_RECLAIM events_long:flush_mdb
WARNING: CPU: 0 PID: 8 at kernel/workqueue.c:3712 check_flush_dependency+0x329/0x3c0 kernel/workqueue.c:3708
Modules linked in:
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: dio/loop4 dio_aio_complete_work
RIP: 0010:check_flush_dependency+0x329/0x3c0 kernel/workqueue.c:3708
Code: 08 4c 89 f7 e8 e8 f6 9d 00 49 8b 16 49 81 c4 78 01 00 00 48 c7 c7 20 d6 09 8c 4c 89 ee 4c 89 e1 4c 8b 04 24 e8 38 3f f8 ff 90 <0f> 0b 90 90 e9 4a ff ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 09
RSP: 0018:ffffc900000d77c0 EFLAGS: 00010046
RAX: 026468fd203def00 RBX: ffff888031531808 RCX: ffff88801d2c5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000008 R08: ffffffff817feaa2 R09: fffffbfff1cfa1a8
R10: dffffc0000000000 R11: fffffbfff1cfa1a8 R12: ffff88801ac81578
R13: ffff8880325f5d78 R14: ffff88801cad8718 R15: ffff88801cad8720
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000075182000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 start_flush_work kernel/workqueue.c:4162 [inline]
 __flush_work+0x286/0xc60 kernel/workqueue.c:4199
 flush_work kernel/workqueue.c:4256 [inline]
 flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4278
 hfs_file_fsync+0xea/0x140 fs/hfs/inode.c:680
 generic_write_sync include/linux/fs.h:2952 [inline]
 dio_complete+0x55c/0x6b0 fs/direct-io.c:313
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

