Return-Path: <linux-pm+bounces-36012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30FBD6954
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCF274FBE0F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9F72F1FD3;
	Mon, 13 Oct 2025 22:09:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757021CFFA
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393374; cv=none; b=ggFP1LQf1Ky1VyrxQQdzuz4hmh0tH62yGBFujTFcQV4oCd1elBgW6yK9T/ebH03YZesHgJ4xb1jzGA1LalJTulDEDEJkpEAE4hG3XYI+qlbete8GTTzXW5+SSOAII54TapPY3rXjgcYqxuvljjv+hmM2glRliEsJFNKIu4YMylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393374; c=relaxed/simple;
	bh=8IoqDUZvnByJ9mvw3a8RIWIbHihcaXMG4jML6izeX4o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ix3d595oncAvDTpzn/KB1SLnvgMYue85as1+4p1IcP/UDgL5RTYCwBEWMtxTJauZOqm5h6PA47VFjY7y63H1qCsVI3jBZ2GooXT2lL7KjlyLA14Z8oR09Zp8jVFIjEqH8hQKguaq/CHPzqA/KEmdLb6ooVtFox4hKg5q8bWvY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42486f6da6fso147347265ab.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 15:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393371; x=1760998171;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ec1wTm8Dfxtbgl7+JN4oUQsuTXuJwhC4tnsYXBjZkE=;
        b=Ama9Umay/xFxux2mcvHkDKEgyvw0xi69B9KFrVH9rmunBL7rhnEAfPkK2RpSnFTY/T
         xn1BX7RSeVIbk9xgQM6GeiZcaTBCVilSjb1yXA6WsUQv44LKzDGSqDDeYQnTtpIR7Zem
         jCqoXwf193wiEP9sxaArY2k3ey7jcUX4vJ/AEOqDiOjZsv5y1AkvMySgf3/q98tmg97c
         dbJQ9MHvfnmb0WdAtVSnGd5MG8lRJfbd5Vr7x3i5wh+Yjv+CX5y0Aj+c+lhKh2/QX7gt
         ZvycwrKCKyMLAoK+rTEj59+yFhepXwj31+FZcy3FhM/Nbiq+GZfDhigwBrVeXBDKIj0O
         QLDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEITCmdvw6H2PJoSfH8EOE6yYomDNu5RXW/JoMnGBClyzByNp5wlwpPz8TOAxiY4PaVcBxNTirnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxN775Z1t3mTPRO+ur+CZnawYvuSXdZqQ3u/SDouagmluDjyE
	sFj145XO40N9XQ3Z82guoN1ZxdHxMXwPS9aUOKyNDPzM4a2iuRIdfTTEoJbVHF+4vSWfKurMkwg
	1RewXznLUOxXm+W1QCEMK/pvlv15XLl8XRmmAR6SSgnF+e7/Fz/g35FIZvPk=
X-Google-Smtp-Source: AGHT+IFTQifWmg3zDjnQ77HA/SplbzhJKj3Ui+rDN3t5MhumpFxfGFqP34Kll6+hWXzF8ULRE1mvFwFcZ9d8zBxsRh7hkWmixTTU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e05:b0:42f:a779:6f43 with SMTP id
 e9e14a558f8ab-42fa779724bmr97421415ab.7.1760393371174; Mon, 13 Oct 2025
 15:09:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:09:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed789b.050a0220.91a22.01f1.GAE@google.com>
Subject: [syzbot] [pm?] INFO: task hung in rpm_resume (2)
From: syzbot <syzbot+48dc1e8dfc92faf1124c@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, pavel@kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    64b229b5b681 usb: dwc3: dwc3-generic-plat: Add layerscape ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14feb304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1924ae3301255907
dashboard link: https://syzkaller.appspot.com/bug?extid=48dc1e8dfc92faf1124c
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119919e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15acdb34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8706c6056174/disk-64b229b5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a138e94650a/vmlinux-64b229b5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e83036b842b/bzImage-64b229b5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48dc1e8dfc92faf1124c@syzkaller.appspotmail.com

INFO: task kworker/1:1:42 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:23224 pid:42    tgid:42    ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x12fc/0x3b80 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7026
 rpm_resume+0x587/0x1320 drivers/base/power/runtime.c:859
 rpm_resume+0x72f/0x1320 drivers/base/power/runtime.c:917
 __pm_runtime_resume+0xb6/0x170 drivers/base/power/runtime.c:1197
 pm_runtime_get_active include/linux/pm_runtime.h:520 [inline]
 pm_runtime_resume_and_get include/linux/pm_runtime.h:539 [inline]
 usb_autopm_get_interface+0x20/0xe0 drivers/usb/core/driver.c:1864
 aqc111_write_cmd drivers/net/usb/aqc111.c:132 [inline]
 aqc111_write32_cmd drivers/net/usb/aqc111.c:180 [inline]
 aqc111_suspend+0x7f8/0xb20 drivers/net/usb/aqc111.c:1409
 usb_suspend_interface drivers/usb/core/driver.c:1323 [inline]
 usb_suspend_both+0x2ff/0xc70 drivers/usb/core/driver.c:1445
 usb_runtime_suspend+0x49/0x180 drivers/usb/core/driver.c:1997
 __rpm_callback+0xc5/0x610 drivers/base/power/runtime.c:406
 rpm_callback+0xea/0x200 drivers/base/power/runtime.c:457
 rpm_suspend+0x2e1/0x11d0 drivers/base/power/runtime.c:698
 __pm_runtime_suspend+0xba/0x1a0 drivers/base/power/runtime.c:1167
 pm_runtime_put_sync_autosuspend include/linux/pm_runtime.h:728 [inline]
 usb_new_device+0x1025/0x1a60 drivers/usb/core/hub.c:2721
 hub_port_connect drivers/usb/core/hub.c:5561 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5701 [inline]
 port_event drivers/usb/core/hub.c:5865 [inline]
 hub_event+0x2fce/0x5060 drivers/usb/core/hub.c:5947
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x700 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task dhcpcd:2894 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:24504 pid:2894  tgid:2894  ppid:2893   task_flags:0x400140 flags:0x00080001
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x12fc/0x3b80 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7026
 rpm_resume+0x587/0x1320 drivers/base/power/runtime.c:859
 rpm_resume+0x72f/0x1320 drivers/base/power/runtime.c:917
 __pm_runtime_resume+0xb6/0x170 drivers/base/power/runtime.c:1197
 pm_runtime_get_active include/linux/pm_runtime.h:520 [inline]
 pm_runtime_resume_and_get include/linux/pm_runtime.h:539 [inline]
 usb_autopm_get_interface+0x20/0xe0 drivers/usb/core/driver.c:1864
 usbnet_open+0x71/0xbe0 drivers/net/usb/usbnet.c:899
 __dev_open+0x3a3/0x850 net/core/dev.c:1682
 __dev_change_flags+0x55d/0x720 net/core/dev.c:9637
 netif_change_flags+0x8d/0x160 net/core/dev.c:9700
 dev_change_flags+0xb6/0x170 net/core/dev_api.c:68
 devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1199
 inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x42f/0x6a0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4d0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcbde649378
RSP: 002b:00007ffdcdfa7d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007fcbde649378
RDX: 00007ffdcdfb7f10 RSI: 0000000000008914 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdcdfc80b0
R13: 00007fcbde5496c8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff892c89a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff892c89a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff892c89a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
3 locks held by kworker/1:1/42:
 #0: ffff8881072e5948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3238
 #1: ffffc900002c7d10 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3239
 #2: ffff88810b74b198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:914 [inline]
 #2: ffff88810b74b198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1be/0x5060 drivers/usb/core/hub.c:5893
3 locks held by kworker/u8:3/48:
 #0: ffff888111b47148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3238
 #1: ffffc90000537d10 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3239
 #2: ffffffff8a630488 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8a630488 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4734
1 lock held by dhcpcd/2894:
 #0: ffffffff8a630488 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8a630488 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x26d/0x1f50 net/ipv4/devinet.c:1120
2 locks held by getty/2917:
 #0: ffff8881123490a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf3f/0x1170 kernel/hung_task.c:495
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x700 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
RIP: 0010:sysvec_call_function_single+0x7b/0xb0 arch/x86/kernel/smp.c:266
Code: c7 c7 60 0f 65 87 e8 e4 22 00 00 48 c7 c7 20 0f 65 87 65 c6 05 ef 7e 53 05 01 e8 d0 22 00 00 65 4c 8b 1d a8 7e 53 05 49 89 23 <4c> 89 dc e8 6d bd fe f9 48 89 df e8 f5 a0 f3 f9 e8 60 be fe f9 5c
RSP: 0018:ffffffff89007d40 EFLAGS: 00000092
RAX: 0000000000000000 RBX: ffffffff89007d58 RCX: ffffffff8186489f
RDX: 0000000000000000 RSI: ffffffff87650f20 RDI: ffffffff87897640
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff15419fa
R10: ffffffff8aa0cfd7 R11: ffffc90000007ff8 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888268ea4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8efbda21e0 CR3: 0000000114588000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 2a 9c 01 e9 53 b6 02 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 89 21 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff89007e08 EFLAGS: 000002c2
RAX: 00000000000cedbb RBX: 0000000000000000 RCX: ffffffff87445b79
RDX: 0000000000000000 RSI: ffffffff88c876c2 RDI: ffffffff87897640
RBP: fffffbfff1205d38 R08: 0000000000000001 R09: ffffed103eb06605
R10: ffff8881f583302b R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8902e9c0 R14: ffffffff8aa0cfd0 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x38d/0x500 kernel/sched/idle.c:330
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:428
 rest_init+0x16b/0x2b0 init/main.c:757
 start_kernel+0x3ee/0x4d0 init/main.c:1111
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x148
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

