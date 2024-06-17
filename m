Return-Path: <linux-pm+bounces-9396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D0C90BF33
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 00:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA761C22B20
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A8199388;
	Mon, 17 Jun 2024 22:49:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6768480
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664561; cv=none; b=szPd5zJ83ULhDoH+NKBlEZvmOiRvwXuuTeHuoHUnteS4olJn6LKWxZuMx9Eiu7rbCXL3UXRCmnBSNjV+IETRYxieAmH45aV7RZ/3hm5DabBZIJLEwU1c6oLJobxg2ZJv/8MEC1BXzPD2sUdzPtikZI00qP1jgyhf0dOo8oEFHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664561; c=relaxed/simple;
	bh=xx2LywGhTwgqH1CinzO8LOvYUUcCTfKK/iF7Srs6YLk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=maKbpeB285TOSAx9KbedWMlV/jip4CsUzNx1uLtobe2HETWM4VcJoR4pj1ltq4Vstz5MEhrudX+SsuoiWy+boYFE0ZmqSyXYxUH7tTLsCIzU7xuDVd/OXVTVuUXk9u64zeC5eJoLkROOMeunOQyKtEN5Xc6BaVPbhxt84YLwtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7ebff1004acso290330839f.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 15:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664559; x=1719269359;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYcXVvNI6NR2zjCzSOS52zTHKAEGh6gq9RycfhrD/xo=;
        b=FYOxiBU3PcrTSYrVOlspgRHPvzarDTekkYxa74IZawwBDS5fPYsiA+Yt6M548Bc116
         Kwsx5B6BpO/fmwG9YtAFJB8oMojfeCheDT5EX2B9WUgZJf1HKY2lWin/hgWI0YTT0Nzi
         E1YHpRKsr/N4ozqX0L1hCf+Ane8w+75nsx270pekeQvPdCSpLJp4hVy5tIuH2RBW6xvp
         JZn/eexOCeSU5we6yNuN/PPpHkGqf2rrVqJiExu8XdpMx1JE4iHqiVUPF1kUAE2fBMuT
         WrYWxdvkIcBw1S6JWAQDVnQB6DOfHvgoBcQyM6EtQCWyqYasOmVC4snlXOyjmqNhvU90
         EfiA==
X-Forwarded-Encrypted: i=1; AJvYcCWVFBe+h+hmFGKrNXki32KuNnNr18EoqJkhDCExAYigbZj7BNzEyq+IBqkW3QaZ7wXMhzIyMeTykpkyWSbWmtgcBxS0L+Qa4/Y=
X-Gm-Message-State: AOJu0Yz2Ujcu6LSYn5YeQiQ0YmvYsl3gm7nIMmY3vA3hdreSx47ihO5p
	Ld5hqhez4ZufWxDWrhvTe8KG/igkLONS0cvsK7kqLW5+pz+GgtdHsluyk913mc+yR8T2+2h2ZWk
	rGssJsDBgDyNiHbGD1iDBn+lXNieOjsesy7xhQ8DKCmaYzNPenAcWOZ8=
X-Google-Smtp-Source: AGHT+IErOIbdQ54HLWY6mbEYpga5ZSrldS5PZAVOl7vdP649oa59HGXxS5R6KA5L/SFxxz5YvCQ1C6zan907cmZYsarNpBX3C5TQ
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40aa:b0:4b9:165a:ffbe with SMTP id
 8926c6da1cb9f-4b963c9c2b8mr335973173.0.1718664559251; Mon, 17 Jun 2024
 15:49:19 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:49:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ae1b4061b1dc635@google.com>
Subject: [syzbot] [net?] [pm?] BUG: soft lockup in call_timer_fn
From: syzbot <syzbot+7b5fc3357809198870e3@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f936b8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f7a2b43b9e58995
dashboard link: https://syzkaller.appspot.com/bug?extid=7b5fc3357809198870e3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/189d8c93c6e5/disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4981fc2493bb/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa15dc2bbc61/bzImage-dccb07f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b5fc3357809198870e3@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 246s! [kworker/u8:8:1096]
Modules linked in:
irq event stamp: 18717831
hardirqs last  enabled at (18717830): [<ffffffff8ae04d12>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (18717830): [<ffffffff8ae04d12>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
hardirqs last disabled at (18717831): [<ffffffff8adc9dee>] sysvec_apic_timer_interrupt+0xe/0xb0 arch/x86/kernel/apic/apic.c:1043
softirqs last  enabled at (18717822): [<ffffffff815361de>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (18717822): [<ffffffff815361de>] handle_softirqs+0x5be/0x8f0 kernel/softirq.c:582
softirqs last disabled at (18717825): [<ffffffff81536fab>] __do_softirq kernel/softirq.c:588 [inline]
softirqs last disabled at (18717825): [<ffffffff81536fab>] invoke_softirq kernel/softirq.c:428 [inline]
softirqs last disabled at (18717825): [<ffffffff81536fab>] __irq_exit_rcu kernel/softirq.c:637 [inline]
softirqs last disabled at (18717825): [<ffffffff81536fab>] irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
CPU: 0 PID: 1096 Comm: kworker/u8:8 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:trace_timer_expire_exit include/trace/events/timer.h:127 [inline]
RIP: 0010:call_timer_fn+0x4b6/0x610 kernel/time/timer.c:1794
Code: ee e8 ae 24 13 00 45 84 ed 0f 84 8b fc ff ff e8 20 2a 13 00 e8 bb b8 84 ff e9 88 fc ff ff e8 11 2a 13 00 e8 cc 9a f9 ff 31 ff <89> c5 89 c6 e8 81 24 13 00 40 84 ed 0f 85 3c fd ff ff e8 f3 29 13
RSP: 0018:ffffc90000007c70 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffffc90000007cb0 RCX: ffffffff817be08b
RDX: 0000000000000000 RSI: ffffffff8b8f8360 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff8b2f3800 R12: 1ffff92000000f90
R13: 0000000000000001 R14: 0000000000000101 R15: 000000000003d7cc
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e728000 CR3: 000000000d77a000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 expire_timers kernel/time/timer.c:1844 [inline]
 __run_timers+0x74b/0xaf0 kernel/time/timer.c:2418
 __run_timer_base kernel/time/timer.c:2429 [inline]
 __run_timer_base kernel/time/timer.c:2422 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2438
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2448
 handle_softirqs+0x219/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x1c/0x60 kernel/kcov.c:207
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 15 64 ca 74 7e 65 8b 05 65 ca 74 7e a9 00 01 ff 00 48 8b 34 24 <74> 0f f6 c4 01 74 35 8b 82 14 16 00 00 85 c0 74 2b 8b 82 f0 15 00
RSP: 0018:ffffc90004407908 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffff8880b9544740 RCX: ffffffff818305bb
RDX: ffff888022045a00 RSI: ffffffff81830595 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffffed10172a88e9
R13: 0000000000000001 R14: ffff8880b9544748 R15: ffff8880b943fc40
 rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]
 cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]
 csd_lock_wait kernel/smp.c:311 [inline]
 smp_call_function_many_cond+0x4e5/0x1420 kernel/smp.c:855
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2086 [inline]
 text_poke_bp_batch+0x22b/0x760 arch/x86/kernel/alternative.c:2296
 text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2484 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2494
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x154/0x1c0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:831 [inline]
 toggle_allocation_gate+0x143/0x250 mm/kfence/core.c:818
 process_one_work+0x9ac/0x1ac0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3429
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 17281 Comm: syz-executor.1 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:advance_sched+0x5ad/0xc60 net/sched/sch_taprio.c:976
Code: 00 00 00 00 74 18 e8 92 86 9f f8 49 8d bf 00 01 00 00 48 c7 c6 c0 e5 ee 88 e8 ff 53 87 f8 e8 7a 86 9f f8 49 8d bd 50 01 00 00 <48> b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f
RSP: 0018:ffffc90000a08d80 EFLAGS: 00000046
RAX: 0000000080010002 RBX: 17cd302767294ecf RCX: ffffffff88ef84ff
RDX: ffff888022fdda00 RSI: ffffffff88ef86d6 RDI: ffff88807a839150
RBP: ffff88807a839010 R08: 0000000000000004 R09: 0000000000000002
R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000002
R13: ffff88807a839000 R14: ffff88802195f340 R15: ffff88807a83a400
FS:  00007fd4376336c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f89c21ad988 CR3: 000000002b270000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x20f/0xcc0 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 56 db 8c f6 48 89 df e8 ae 57 8d f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 95 92 7e f6 65 8b 05 c6 8a 23 75 85 c0 74 16 5b
RSP: 0018:ffffc9000e39fa28 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffff88801c286088 RCX: 1ffffffff1f7fcd1
RDX: 0000000000000000 RSI: ffffffff8b2cbf40 RDI: ffffffff8b8f83e0
RBP: 0000000000000283 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fc02917 R11: ffffffff936de7e0 R12: dffffc0000000000
R13: 19aa02f4ae83767b R14: 17cd2ca4ae83767b R15: ffff88801c286088
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 timerfd_clock_was_set+0x164/0x310 fs/timerfd.c:113
 clock_was_set+0x67c/0x850 kernel/time/hrtimer.c:983
 timekeeping_inject_offset+0x4d1/0x640 kernel/time/timekeeping.c:1396
 do_adjtimex+0x373/0xaa0 kernel/time/timekeeping.c:2445
 do_clock_adjtime kernel/time/posix-timers.c:1159 [inline]
 __do_sys_clock_adjtime+0x176/0x290 kernel/time/posix-timers.c:1171
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd43687dca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd4376330c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
RAX: ffffffffffffffda RBX: 00007fd4369abf80 RCX: 00007fd43687dca9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 00007fd4368c947e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd4369abf80 R15: 00007ffc2cd9c1e8
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

