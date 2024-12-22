Return-Path: <linux-pm+bounces-19649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6E9FA4DE
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2024 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0D2166DEE
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2024 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6D1836D9;
	Sun, 22 Dec 2024 08:55:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2A80B
	for <linux-pm@vger.kernel.org>; Sun, 22 Dec 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734857720; cv=none; b=vAE0CQsQRew/WfxiBLn1oQBAV4af/+1cUeB0O5Fye0zQjkdxMHD54FLwkaW9KMYN3ZUFV3adIhkVhhE4S1yCkdX07q+4+IpEhnpWIr6QsU2ToqB0f0O7XXyTd0e2DfhcoNaEwuZAzV8g6+9QXW64FMWHo/oOwIyQ2PpeIRGz05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734857720; c=relaxed/simple;
	bh=Q0rdIcOnreAS4lubUxgSs2lcx8dF0xIP2RWCT1y2KQU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kKJZnuX76hQ8hjdv96Ht8qVjyKbgcA5rNCoi6XhMePOJTyXeL80+MBCMcNNBtmdPuP7dXBejm9QsY2cerQ7DMbrydmLNXWSBdFLDa41amcuO7N9Mdri5ZQbXQVdSUnWAyCxK8C1x/Rrw0xM+cN0ddcAfLACdIuVr2babk/Uo654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso62887595ab.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Dec 2024 00:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734857717; x=1735462517;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6JNUb6DOFwm0onweZZMRbnRAc6MD57XRPc4cuzmAOk=;
        b=fiF170PIQ9vwn25PAUN/RMxA/1+sKsyG30MfNyGrdd6eX+cyBlJ1kaEek1vfyYGjzg
         ntPPpt5bh+xls1W5jBKdsZO8lnlw8euBm6Aj4VzdVPu0d4lKNpRGw2gjhUH/tUj8OytH
         +WcldcBv+tnfCem+7qYqr1100RLT7jHWcEiK3J0hxpHjh1Ne8iqC9Gq2QqYCsBkzE4W7
         PcdnfweQOCJ/ILl8k9vyC+6GrY7D7uzhCnWvmrYMD4dxeyXikLgz0+U+YyS6YoansM7Y
         1AiHIi4ToNi5x5JmcvENjDmLQfu0AkNRhlW4luYKZkLyTNfR2nLchNL6YK1JUh9iJh65
         gIZg==
X-Forwarded-Encrypted: i=1; AJvYcCVFOQEw/ByjLBjz+jh8DlUrqepljruzzOAC49UuDjqsxW4oxvWbE5Bu8co5lUyCs9SisJ1R3TrrXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6PiKdvSlG4SC8l1TlGEaOStE+etA8i8h3uDEp6SD1y2CBSfP
	cVQ2p1aDQjnQRoWycx62wv3sMZNeFavpVj01erF/OWy3E36HHWiFvDfnDybz+b7RlivXo6Vfh4Z
	LaI0LcQM7pJkulLy/UftYJIni4dp62HuGzL6Yy8NoZLRM7uimrbutiGk=
X-Google-Smtp-Source: AGHT+IE3xdu485BrPSua2lHkPwZDz/De+zhZx+2R20099svA68K1AI5fzd2vf+8vbqGrrvbYbKoNpGVPxPlqPRTXf8glgXMQKYD3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2687:b0:3a7:e83c:2d10 with SMTP id
 e9e14a558f8ab-3c2d5b37857mr99599655ab.24.1734857717679; Sun, 22 Dec 2024
 00:55:17 -0800 (PST)
Date: Sun, 22 Dec 2024 00:55:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6767d3f5.050a0220.226966.001e.GAE@google.com>
Subject: [syzbot] [pm?] possible deadlock in rpm_suspend
From: syzbot <syzbot+361e2c54f7f4bf035391@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7fa366f1b6e3 Add linux-next specific files for 20241218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13580cf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26a4b4cc7f877b28
dashboard link: https://syzkaller.appspot.com/bug?extid=361e2c54f7f4bf035391
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76406ccde331/disk-7fa366f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49c56a285987/vmlinux-7fa366f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92d20cf0cd8a/bzImage-7fa366f1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+361e2c54f7f4bf035391@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc3-next-20241218-syzkaller #0 Not tainted
------------------------------------------------------
kworker/0:1/9 is trying to acquire lock:
ffffffff8e813680 (console_owner){-...}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:2048 [inline]
ffffffff8e813680 (console_owner){-...}-{0:0}, at: vprintk_emit+0x530/0xa10 kernel/printk/printk.c:2431

but task is already holding lock:
ffff8880b863e118 (&pool->lock){-.-.}-{2:2}, at: start_flush_work kernel/workqueue.c:4144 [inline]
ffff8880b863e118 (&pool->lock){-.-.}-{2:2}, at: __flush_work+0x1a9/0xc50 kernel/workqueue.c:4195

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
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

-> #0 (console_owner){-...}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       console_trylock_spinning kernel/printk/printk.c:2048 [inline]
       vprintk_emit+0x54d/0xa10 kernel/printk/printk.c:2431
       _printk+0xd5/0x120 kernel/printk/printk.c:2457
       __warn_printk+0x237/0x360 kernel/panic.c:794
       check_flush_dependency+0x2ee/0x390 kernel/workqueue.c:3704
       start_flush_work kernel/workqueue.c:4158 [inline]
       __flush_work+0x286/0xc50 kernel/workqueue.c:4195
       flush_work kernel/workqueue.c:4252 [inline]
       flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4274
       hfs_file_fsync+0xea/0x140 fs/hfs/inode.c:680
       generic_write_sync include/linux/fs.h:2952 [inline]
       dio_complete+0x55c/0x6b0 fs/direct-io.c:313
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

5 locks held by kworker/0:1/9:
 #0: ffff8880274aed48 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff8880274aed48 ((wq_completion)dio/loop4){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc900000e7c60 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900000e7c60 ((work_completion)(&dio->complete_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88802a329620 (&sb->s_type->i_mutex_key#27){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:863 [inline]
 #2: ffff88802a329620 (&sb->s_type->i_mutex_key#27){+.+.}-{4:4}, at: hfs_file_fsync+0x95/0x140 fs/hfs/inode.c:673
 #3: ffffffff8e937d20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #3: ffffffff8e937d20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8e937d20 (rcu_read_lock){....}-{1:3}, at: start_flush_work kernel/workqueue.c:4137 [inline]
 #3: ffffffff8e937d20 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xe7/0xc50 kernel/workqueue.c:4195
 #4: ffff8880b863e118 (&pool->lock){-.-.}-{2:2}, at: start_flush_work kernel/workqueue.c:4144 [inline]
 #4: ffff8880b863e118 (&pool->lock){-.-.}-{2:2}, at: __flush_work+0x1a9/0xc50 kernel/workqueue.c:4195

stack backtrace:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.13.0-rc3-next-20241218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
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
 check_flush_dependency+0x2ee/0x390 kernel/workqueue.c:3704
 start_flush_work kernel/workqueue.c:4158 [inline]
 __flush_work+0x286/0xc50 kernel/workqueue.c:4195
 flush_work kernel/workqueue.c:4252 [inline]
 flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4274
 hfs_file_fsync+0xea/0x140 fs/hfs/inode.c:680
 generic_write_sync include/linux/fs.h:2952 [inline]
 dio_complete+0x55c/0x6b0 fs/direct-io.c:313
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
workqueue: WQ_MEM_RECLAIM dio/loop4:dio_aio_complete_work is flushing !WQ_MEM_RECLAIM events_long:flush_mdb
WARNING: CPU: 0 PID: 9 at kernel/workqueue.c:3708 check_flush_dependency+0x2ef/0x390 kernel/workqueue.c:3704
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.13.0-rc3-next-20241218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: dio/loop4 dio_aio_complete_work
RIP: 0010:check_flush_dependency+0x2ef/0x390 kernel/workqueue.c:3704
Code: e7 e8 45 ed 9d 00 49 8b 14 24 48 8b 4c 24 08 48 81 c1 78 01 00 00 48 c7 c7 60 d2 09 8c 4c 89 ee 4c 8b 04 24 e8 72 3f f8 ff 90 <0f> 0b 90 90 e9 63 ff ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 66
RSP: 0018:ffffc900000e77b8 EFLAGS: 00010046
RAX: 9a34564af5aef900 RBX: ffff888028aeac08 RCX: ffff88801ce80000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000008 R08: ffffffff817ffa32 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff88801cad7818
R13: ffff8880274aed78 R14: dffffc0000000000 R15: ffff88801cad7820
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3050bff8 CR3: 0000000032b66000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 start_flush_work kernel/workqueue.c:4158 [inline]
 __flush_work+0x286/0xc50 kernel/workqueue.c:4195
 flush_work kernel/workqueue.c:4252 [inline]
 flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4274
 hfs_file_fsync+0xea/0x140 fs/hfs/inode.c:680
 generic_write_sync include/linux/fs.h:2952 [inline]
 dio_complete+0x55c/0x6b0 fs/direct-io.c:313
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

