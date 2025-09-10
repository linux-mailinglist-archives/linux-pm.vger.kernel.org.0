Return-Path: <linux-pm+bounces-34341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19570B5119D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD6E3A4CF6
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBB3101DE;
	Wed, 10 Sep 2025 08:39:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305BF30FC3F
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493573; cv=none; b=r0Ac+jVQLklrE1fYp2k0ylrzv6HU83Fgl4wKyW0chG8VcrUSahAc7ER0iCm7BLmkYL4tDcm+4KrxXhP19eJY4gcBwmMMRv81xHYdWFWnNAsBvOW8WkqQbjffFjQaZ0lDDrsvXrK2j4RVqYMm9HnxcYOoGbzlwE5fzOP7i39M1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493573; c=relaxed/simple;
	bh=gHUOBAA7IPO3zDO+c6Ess0VHuZtiEVnFeT47kyDldPg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PzE7+xs8i9NJpZ/ODDY7u1tqmP1GDqj+aVna3K54dFQkcpMV9glxU6uhtvJ01jPOczRea8fD6+2rVXWGNPoBbHgszBnz1q+/rl1tpZrQJC2rjGsAU7mVFKzt+LXE31AAbnn3rIMf3u4XPXbZPr/dJz+fQSMEaZ8zweAkwhtSiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-406f47faa7cso47060875ab.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 01:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493570; x=1758098370;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nu5sjJ3Kj9vfAvoH6O79CBSHJ/9V26w5M2RStjiB2QM=;
        b=Fg5nBl5LZkf6cF80PRdVNpnbxBgovHi792RH4H4EVW2Gn+XbuI8Kf/91KqXGGrmmSA
         v9/MSfUpXFPXW1aF0BKN/IyUeMpDUJDwf6xUuiU2JmBeB8wuyJY6HYJB4Y/LJCBJQ4qF
         +Xfb5hRjPxbds0jdcLAbwLHFHm8yXwOC6uPbFplrBfJeIFtaZsg0OGl/I72Lstl1upCF
         2EdMRuXcUMa+AZoPdUGyGpKR1HGSZw2yCdujHHzNShaS78F0dPyAHrShakOWnpmiPmA4
         WX9Gc1GX1ajfgS1iYPRPj91mIH+1gjExR1x+BiK+tihbjnCjqAXE1Lxw5K/FbohjhI3S
         eVgA==
X-Forwarded-Encrypted: i=1; AJvYcCUxti283DhIno+16ITc8W6aEQK+e7nZCGVgGuS074/zy6WKQgx0UFM2iN7m0cOTzs7mOKdIixq0FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0YPAy3l7HtJxHzX2W9nEQ5jslC6JmXFwLGuBDz6bkwT5ZasVM
	9BaoT/AE2xT/MYZiQ3IQIPv4aDrPvYcARnZq/qaY6BSOsl8PL3xdBdakwd6zWFmJ3wdDUTgPyzx
	pIQezxy/qX+mdvKYTrH/zN1hA8bsGSPRyWAHh7XqEmp0ptfvKJilOT5+B5VA=
X-Google-Smtp-Source: AGHT+IEVWd9Gw2k+8W7rHv7FXslPf9KU3R9cCsBZq3xEhDRRhz12uYr7hs+ivVWP5G4EOjmKLZ8a+7XJkJNbF5U91w4P94KCfrxP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d97:b0:40d:e8bd:fdd1 with SMTP id
 e9e14a558f8ab-40de8be0078mr107984185ab.0.1757493570399; Wed, 10 Sep 2025
 01:39:30 -0700 (PDT)
Date: Wed, 10 Sep 2025 01:39:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c13942.050a0220.2ff435.000b.GAE@google.com>
Subject: [syzbot] [pm?] KASAN: slab-use-after-free Read in rpm_suspend
From: syzbot <syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12989962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=6c905ab800f20cf4086c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/55786c35304b/disk-d69eb204.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aca8d9b9f676/vmlinux-d69eb204.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0ab73c6a8de8/bzImage-d69eb204.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c905ab800f20cf4086c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rt_spin_lock+0x88/0x2c0 kernel/locking/spinlock_rt.c:56
Read of size 1 at addr ffff8880235c7250 by task kworker/1:1/12993

CPU: 1 UID: 0 PID: 12993 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: pm pm_runtime_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:568
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 rt_spin_lock+0x88/0x2c0 kernel/locking/spinlock_rt.c:56
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 rpm_suspend+0x1223/0x1710 drivers/base/power/runtime.c:729
 pm_runtime_work+0x132/0x1b0 drivers/base/power/runtime.c:-1
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 17088:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x1a8/0x320 mm/slub.c:4407
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 usb_alloc_dev+0x5d/0xcc0 drivers/usb/core/usb.c:650
 hub_port_connect drivers/usb/core/hub.c:5469 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x2214/0x4a20 drivers/usb/core/hub.c:5952
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 12978:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x195/0x550 mm/slub.c:4894
 device_release+0x99/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 hub_port_connect drivers/usb/core/hub.c:5406 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x1cf5/0x4a20 drivers/usb/core/hub.c:5952
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2184
 __queue_work+0xd63/0x1010 kernel/workqueue.c:2339
 queue_work_on+0x181/0x270 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:669 [inline]
 rpm_suspend+0xe5a/0x1710 drivers/base/power/runtime.c:685
 pm_suspend_timer_fn+0xe8/0x120 drivers/base/power/runtime.c:1028
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x54f/0xd40 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x1a3/0x2e0 kernel/time/hrtimer.c:1842
 handle_softirqs+0x22f/0x710 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880235c7000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 592 bytes inside of
 freed 2048-byte region [ffff8880235c7000, ffff8880235c7800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x235c0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff888019842000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0080000000000040 ffff888019842000 0000000000000000 dead000000000001
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0080000000000003 ffffea00008d7001 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 27321, tgid 27321 (syz-executor), ts 2084499712633, free_ts 2083844771676
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2119/0x21b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0x8d1/0xdc0 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_node_track_caller_noprof+0x14c/0x450 mm/slub.c:4395
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:600
 pskb_expand_head+0x18e/0x1150 net/core/skbuff.c:2240
 netlink_trim+0x1d5/0x2e0 net/netlink/af_netlink.c:1301
 netlink_broadcast_filtered+0xd6/0x12c0 net/netlink/af_netlink.c:1514
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0xf0/0x1a0 net/netlink/af_netlink.c:2595
 __dev_notify_flags+0xf4/0x2e0 net/core/dev.c:9584
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9617
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3143
 rtnl_changelink net/core/rtnetlink.c:3761 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3920 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4057
page last free pid 3181 tgid 3181 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xb59/0xce0 mm/page_alloc.c:2895
 free_large_kmalloc+0x13a/0x1f0 mm/slub.c:4820
 wg_destruct+0x284/0x2f0 drivers/net/wireguard/device.c:265
 netdev_run_todo+0xcd7/0xea0 net/core/dev.c:11506
 default_device_exit_batch+0x81e/0x890 net/core/dev.c:12734
 ops_exit_list net/core/net_namespace.c:204 [inline]
 ops_undo_list+0x522/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4cb/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880235c7100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880235c7180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880235c7200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff8880235c7280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880235c7300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

