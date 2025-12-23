Return-Path: <linux-pm+bounces-39852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA756CD93FC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5266B30198D6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966932AABE;
	Tue, 23 Dec 2025 12:28:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A432D3A69
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492905; cv=none; b=BdaQR42sVlxuNSkPgC3ZddmwwbcQ1dD5EVPZ0NVqoc39KWpRTDW9JwuC+7uaDuAVquTLGemy5GV6wCjBPD8lw08/L+l/JaAvJ1lXGc9GzVrDErHF96MqxlqxMxC/2ya8RzCzfQYBGH4X6mDtJx4aNOP8dEyhAxOkDX/ZXJ7RTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492905; c=relaxed/simple;
	bh=gD0SEXL2+DXzNth1fr0SiKv1es1wIqr9oKrfas9t8jA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DIb36wfYY4UaPhUc8XbTqB09zD8jHR2YQzL8IjDRZDYOMjc3Phs4Oxk3QVQYB+VrgSn45eE2Im4uKOUzIeJ/wSZVoHXMXU2vkGAVF3IHPh4jQ6CmuzMGVcD43eZzOvDHGlkqW4l2U2cyZeyU0lWvPBdffeF2HzfJ/2n0YSne4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6574d3d44f9so7990379eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 04:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766492902; x=1767097702;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJVW7jt0QGN4IyXhFjx6JZEDzM1Hdk7Z4ctneZxH1M0=;
        b=vrwQgG0ar9L0wiuY/Ub2+fKnBzqvoo26PsId9jG5YT6VjedWivloiR0yUiiM3CgM+1
         XWucBM4W7gZi2zw44iHu6fRnMF7dNy9Efd5Ia5UTUJdGeSrY00GcH2LTCn3zEhDoD7Yl
         dzCPi4FKa20UrBpQ3AYRFL4hZVpQQpp8cWRff5PyWbAbG9jMtkLvQueDV7vdDspVEAZz
         YIMBtOcBk7HqFcu7Djmi4LhfPwbiaq5CWz4PBXrQDTKwVmRx8+JLNOkXVrsG1MuC4mK9
         5JbQbU0LzEr4fB5BsFxLmO4u/XXwd8zUh+E1o4izyacDlB2zzKXoaY7O0EAu5Maxwx4T
         veTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5zIoYrzHU31L6X9nT21kojviJg1eoqwQXWHD6qVx46pphx0Rxsb+dxXILQjRorfczzQguWrrYKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiybaSx7ND3Bp7BUencuF4Nkp4LcGJO27y/yjxvZSg0h3gWKPP
	tmQ5g0linJGP6BQVn+thkE6hd1iho3X6UP0xuMzX4UzKQoNlSAWrEdnh6PYDP2jD1FivEehSvy+
	zE1SLhdd3+T1BPwTOfOEJwogprg5UzbKg259OSjrMLT9zJu16VW8lqz0TmOo=
X-Google-Smtp-Source: AGHT+IG78JSMVF7rpwwoKalNUcpb2BjuqZTxAC3l2K642yQGwNkp0iUgJh1Tmr8rAWFtc+hDL2Hrfl2J9+y682Aql/wu/SkNmC95
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a6:b0:659:9a49:9009 with SMTP id
 006d021491bc7-65d0ea7234dmr5942525eaf.54.1766492902352; Tue, 23 Dec 2025
 04:28:22 -0800 (PST)
Date: Tue, 23 Dec 2025 04:28:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694a8ae6.050a0220.19928e.0025.GAE@google.com>
Subject: [syzbot] [pm?] KASAN: slab-use-after-free Read in thermal_zone_device_check
From: syzbot <syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com>
To: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dd9b004b7ff3 Merge tag 'trace-v6.19-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150d131a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=3b3852c6031d0f30dfaf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea0a8b24838c/disk-dd9b004b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67ac69e3e131/vmlinux-dd9b004b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/570521afa03d/bzImage-dd9b004b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:593 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x147/0x1350 kernel/locking/mutex.c:776
Read of size 8 at addr ffff888065d7f6f8 by task kworker/0:3/22405

CPU: 0 UID: 0 PID: 22405 Comm: kworker/0:3 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events_freezable_pwr_efficient thermal_zone_device_check
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __mutex_lock_common kernel/locking/mutex.c:593 [inline]
 __mutex_lock+0x147/0x1350 kernel/locking/mutex.c:776
 class_thermal_zone_constructor drivers/thermal/thermal_core.h:155 [inline]
 thermal_zone_device_update drivers/thermal/thermal_core.c:704 [inline]
 thermal_zone_device_check+0x22/0xb0 drivers/thermal/thermal_core.c:1396
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 22405:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_noprof+0x41d/0x800 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 thermal_zone_device_register_with_trips+0x178/0xd70 drivers/thermal/thermal_core.c:1541
 thermal_tripless_zone_device_register+0x35/0x50 drivers/thermal/thermal_core.c:1655
 psy_register_thermal+0x1fe/0x310 drivers/power/supply/power_supply_core.c:1534
 __power_supply_register+0xc37/0xf90 drivers/power/supply/power_supply_core.c:1640
 thunderstrike_psy_create+0x1f3/0x3c0 drivers/hid/hid-nvidia-shield.c:841
 thunderstrike_create drivers/hid/hid-nvidia-shield.c:897 [inline]
 shield_probe+0x7ee/0xb00 drivers/hid/hid-nvidia-shield.c:1058
 __hid_device_probe drivers/hid/hid-core.c:2775 [inline]
 hid_device_probe+0x416/0x7a0 drivers/hid/hid-core.c:2812
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0xad0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x320 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:831
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:500
 __device_attach+0x2b8/0x430 drivers/base/dd.c:1031
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1086
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:574
 device_add+0x7b6/0xb80 drivers/base/core.c:3689
 hid_add_device+0x272/0x3e0 drivers/hid/hid-core.c:2951
 usbhid_probe+0xe13/0x12c0 drivers/hid/usbhid/hid-core.c:1435
 usb_probe_interface+0x668/0xc90 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0xad0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x320 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:831
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:500
 __device_attach+0x2b8/0x430 drivers/base/dd.c:1031
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1086
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:574
 device_add+0x7b6/0xb80 drivers/base/core.c:3689
 usb_set_configuration+0x1a87/0x2110 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x3c0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x26d/0xad0 drivers/base/dd.c:659
 __driver_probe_device+0x18c/0x320 drivers/base/dd.c:801
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:831
 __device_attach_driver+0x279/0x430 drivers/base/dd.c:959
 bus_for_each_drv+0x251/0x2e0 drivers/base/bus.c:500
 __device_attach+0x2b8/0x430 drivers/base/dd.c:1031
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1086
 bus_probe_device+0x12a/0x220 drivers/base/bus.c:574
 device_add+0x7b6/0xb80 drivers/base/core.c:3689
 usb_new_device+0xa39/0x1720 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x29b1/0x4ef0 drivers/usb/core/hub.c:5953
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Freed by task 1790:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6668 [inline]
 kfree+0x1c0/0x660 mm/slub.c:6876
 psy_unregister_thermal drivers/power/supply/power_supply_core.c:1551 [inline]
 power_supply_unregister+0xf9/0x140 drivers/power/supply/power_supply_core.c:1767
 thunderstrike_destroy drivers/hid/hid-nvidia-shield.c:927 [inline]
 shield_remove+0x72/0x120 drivers/hid/hid-nvidia-shield.c:1104
 hid_device_remove+0x228/0x370 drivers/hid/hid-core.c:-1
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1282 [inline]
 device_release_driver_internal+0x46f/0x800 drivers/base/dd.c:1305
 bus_remove_device+0x34d/0x440 drivers/base/bus.c:616
 device_del+0x511/0x8e0 drivers/base/core.c:3878
 hid_remove_device drivers/hid/hid-core.c:3008 [inline]
 hid_destroy_device+0x6b/0x1b0 drivers/hid/hid-core.c:3030
 usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1462
 usb_unbind_interface+0x26e/0x910 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:571 [inline]
 __device_release_driver drivers/base/dd.c:1282 [inline]
 device_release_driver_internal+0x4d9/0x800 drivers/base/dd.c:1305
 bus_remove_device+0x34d/0x440 drivers/base/bus.c:616
 device_del+0x511/0x8e0 drivers/base/core.c:3878
 usb_disable_device+0x3d4/0x8e0 drivers/usb/core/message.c:1418
 usb_disconnect+0x32f/0x990 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1ca9/0x4ef0 drivers/usb/core/hub.c:5953
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2180
 __queue_work+0xcd0/0xf90 kernel/workqueue.c:2335
 mod_delayed_work_on+0xf8/0x200 kernel/workqueue.c:2591
 mod_delayed_work include/linux/workqueue.h:699 [inline]
 thermal_zone_pm_complete drivers/thermal/thermal_core.c:1839 [inline]
 thermal_pm_notify_complete drivers/thermal/thermal_core.c:1851 [inline]
 thermal_pm_notify+0x223/0x560 drivers/thermal/thermal_core.c:1866
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 blocking_notifier_call_chain+0x6a/0x90 kernel/notifier.c:380
 snapshot_release+0x123/0x1d0 kernel/power/user.c:125
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
 exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2d0/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2180
 __queue_work+0xcd0/0xf90 kernel/workqueue.c:2335
 call_timer_fn+0x16e/0x590 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1794 [inline]
 __run_timers kernel/time/timer.c:2373 [inline]
 __run_timer_base+0x646/0x860 kernel/time/timer.c:2385
 run_timer_base kernel/time/timer.c:2394 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2404
 handle_softirqs+0x27d/0x850 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

The buggy address belongs to the object at ffff888065d7f000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1784 bytes inside of
 freed 2048-byte region [ffff888065d7f000, ffff888065d7f800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x65d78
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ffa7000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813ffa7000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001975e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1790, tgid 1790 (kworker/0:5), ts 1662150126386, free_ts 1662115181412
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xf2b/0x1960 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_node_track_caller_noprof+0x5d4/0x820 mm/slub.c:5764
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:608
 __alloc_skb+0x27e/0x430 net/core/skbuff.c:690
 alloc_skb include/linux/skbuff.h:1383 [inline]
 mld_newpack+0x13c/0xc40 net/ipv6/mcast.c:1775
 add_grhead+0x5a/0x2a0 net/ipv6/mcast.c:1886
 add_grec+0x1452/0x1740 net/ipv6/mcast.c:2025
 mld_send_cr net/ipv6/mcast.c:2148 [inline]
 mld_ifc_work+0x6ed/0xd60 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xd70/0x1870 kernel/rcu/tree.c:2857
 handle_softirqs+0x27d/0x850 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Memory state around the buggy address:
 ffff888065d7f580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888065d7f600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888065d7f680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888065d7f700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888065d7f780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

