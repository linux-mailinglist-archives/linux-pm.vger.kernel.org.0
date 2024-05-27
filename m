Return-Path: <linux-pm+bounces-8158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DC8CFFC2
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D2DB21234
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9F15D5D5;
	Mon, 27 May 2024 12:16:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B01581E2
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812188; cv=none; b=Nj6HeREN0GLxiYDSaVinIEczLM1Lff8RXLU5beTJlDB1Au/JW0y1p1cOff0UyknpCfAVq+TocfLkEVrSPtQjJqd8AGNP+13OAPHpY2Qq60XaumF/J2Onvq58mWRDQ1RmB5wz0cfJTYTooV0ccDjQWQMjHHJhWtiEXnfSImQ1B1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812188; c=relaxed/simple;
	bh=h/cCEDGEjDMZokInJrxDqPxuXuDSHn/PMcav3S+K7M0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uKzzQBcgqjQ8zQSVbxQYROFM+0Q4FLi/GioF6vDZSECo0496JFlleu88EoCVdzahPvxH+1QriZCuQJu+vaQfl5Frg1HUK7Uwtq2czC8v4EgGzZel2jtX2FFFOFrl8LnvulaTc9noQhOBTA5ouYGnCXjwnsZ3Q3k+ESH7HQn0O/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ead3d6a782so42413739f.3
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 05:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716812185; x=1717416985;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrBiLoAdyCH10N5ozN0LOe9Z9wcZUeZXZWDt75VIcFo=;
        b=r8FjFqiwCSd6cvCwJQil6a5Blbzqp5kFUQXz9Wq/2pAmceY3jPyMMGACwZjKyLkF/Q
         RiXBj47cNHlppDiAurX7CS4HadFpxHecwZZhwkPinWbFB80xWqtliOZSJVsIb7xvQ4oL
         tQHu/UfQ/vDoBfnE50q/zRBcWl2/iNBII46SRUDmw0zIVhI6ZO6cV37aT1PtWKtbGmZX
         05f/fl1zh/xJnbDzqWzmUOqsUMUtBz2Tj1zFbuCvTZFhILBMxpWcaxVvJ35aljbp5mIi
         0+Odjd6ktSXaTAMwerNF4YuwZXK5BLKWgPpA/9MHoAjnD5GRezUymZSYd4X3cxPbqqlO
         V3rw==
X-Forwarded-Encrypted: i=1; AJvYcCUQU4OuA4BE6AI4zureJoN21HlG0CS2RbOZC+PP7jIZRru7e0a2AONqcrThEqUHZ+ueHe2O4gVxzUf0oe9y55xiv9OiXcPu8+k=
X-Gm-Message-State: AOJu0Yz8/DdNrlnE/bLwqFboDYhO0yu8Q3BOTtZiTREvMJl8vAQwnFh2
	l8l4xFt5am1RZYJ3UBOb52/FNR0jtijxmA3BiLR/i8hCIEISRuALIh4RKJA1bApqJRGyTtaDSkd
	md1I0DWbMsJ3F3rU+F5COkglP48VywWoB4O6GWzmtg1PzQv35fq7sSdQ=
X-Google-Smtp-Source: AGHT+IEbBn/QaySLifpjOdCpj35VHWfvoCsYrtjfXQWB00zO9FUs7RrTkgFqooyZMqp0llCXrixKB0gyVf01EwR74GbtBGJuN8Us
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c3:b0:7de:e506:e54a with SMTP id
 ca18e2360f4ac-7e8c6f10a40mr48872939f.3.1716812185684; Mon, 27 May 2024
 05:16:25 -0700 (PDT)
Date: Mon, 27 May 2024 05:16:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000795a2506196e7cd5@google.com>
Subject: [syzbot] [pm?] INFO: trying to register non-static key in netdev_unregister_kobject
From: syzbot <syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e67572cd2204 Linux 6.9-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15715640980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=27c3c57b78da2a0995d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152ab240980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13274a87180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7ece3eebb82c/disk-e67572cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81b1e26c57c9/vmlinux-e67572cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/be9561f066e4/bzImage-e67572cd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/825a80609ef9/mount_4.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1526f2a7180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1726f2a7180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1326f2a7180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27c3c57b78da2a0995d8@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 5076 Comm: kbnepd bnep0 Not tainted 6.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:976
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1289
 __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:376 [inline]
 pm_runtime_set_memalloc_noio+0x13d/0x260 drivers/base/power/runtime.c:228
 netdev_unregister_kobject+0x178/0x250 net/core/net-sysfs.c:2106
 unregister_netdevice_many_notify+0x11dd/0x16e0 net/core/dev.c:11135
 unregister_netdevice_many net/core/dev.c:11163 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11042
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11181
 bnep_session+0x2e09/0x3000 net/bluetooth/bnep/core.c:525
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_lock+0x299/0x370 kernel/locking/spinlock_debug.c:115
Read of size 4 at addr ffff88801b70970c by task kbnepd bnep0/5076

CPU: 1 PID: 5076 Comm: kbnepd bnep0 Not tainted 6.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x299/0x370 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:120 [inline]
 _raw_spin_lock_irq+0xdf/0x120 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:376 [inline]
 pm_runtime_set_memalloc_noio+0x13d/0x260 drivers/base/power/runtime.c:228
 netdev_unregister_kobject+0x178/0x250 net/core/net-sysfs.c:2106
 unregister_netdevice_many_notify+0x11dd/0x16e0 net/core/dev.c:11135
 unregister_netdevice_many net/core/dev.c:11163 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11042
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11181
 bnep_session+0x2e09/0x3000 net/bluetooth/bnep/core.c:525
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 4524:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x194/0x380 mm/slub.c:3888
 kmalloc_reserve+0xa8/0x2a0 net/core/skbuff.c:577
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:668
 netlink_sendmsg+0x637/0xcb0 net/netlink/af_netlink.c:1880
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5097:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x10b/0x2c0 mm/slub.c:4344
 skb_kfree_head net/core/skbuff.c:1094 [inline]
 skb_free_head net/core/skbuff.c:1108 [inline]
 skb_release_data+0x556/0x870 net/core/skbuff.c:1136
 skb_release_all net/core/skbuff.c:1202 [inline]
 __kfree_skb net/core/skbuff.c:1216 [inline]
 consume_skb+0xb3/0x160 net/core/skbuff.c:1432
 netlink_recvmsg+0x60a/0x11d0 net/netlink/af_netlink.c:1983
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 ____sys_recvmsg+0x1db/0x470 net/socket.c:2803
 ___sys_recvmsg net/socket.c:2845 [inline]
 __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801b709500
 which belongs to the cache skbuff_small_head of size 640
The buggy address is located 524 bytes inside of
 freed 640-byte region [ffff88801b709500, ffff88801b709780)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1b708
head: order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888019695a00 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080150015 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888019695a00 dead000000000122 0000000000000000
head: 0000000000000000 0000000080150015 00000001ffffffff 0000000000000000
head: 00fff80000000002 ffffea00006dc201 dead000000000122 00000000ffffffff
head: 0000000400000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5097, tgid 64786829 (udevd), ts 5097, free_ts 60180817158
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_node+0x24a/0x380 mm/slub.c:3888
 kmalloc_reserve+0xa8/0x2a0 net/core/skbuff.c:577
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:668
 netlink_sendmsg+0x637/0xcb0 net/netlink/af_netlink.c:1880
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5063 tgid 5063 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __folio_put_large+0x168/0x1d0 mm/swap.c:132
 __folio_put+0x299/0x390 mm/swap.c:140
 folio_put include/linux/mm.h:1508 [inline]
 free_large_kmalloc+0x105/0x1c0 mm/slub.c:4361
 kfree+0x1ca/0x3a0 mm/slub.c:4384
 hci_release_dev+0x1516/0x16a0 net/bluetooth/hci_core.c:2833
 bt_host_release+0x83/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 vhci_release+0x8b/0xd0 drivers/bluetooth/hci_vhci.c:675
 __fput+0x429/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036

Memory state around the buggy address:
 ffff88801b709600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801b709680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801b709700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88801b709780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801b709800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

