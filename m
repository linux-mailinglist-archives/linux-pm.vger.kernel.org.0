Return-Path: <linux-pm+bounces-15237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71551992325
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA6928142B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1719B210EC;
	Mon,  7 Oct 2024 03:45:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4122089
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272728; cv=none; b=M4PZTWpYZ7iF587eztbmhqvLMN3gvw/to8LMIwrLklKacUJjUuiO4nONqd6xefiePJsyNpUpDYzl/R9ddORHsq6D36hk7x8mYxK1OiIuK3sHG/MDYhONn8OhWOsutQxRICGLLyk+rk648/fVWOH+Vx1YVTnWuxzNqGInLPIaitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272728; c=relaxed/simple;
	bh=0rEOej+eeIy2aV6tTdznd+XFRwHAORlpFAS+RP9YmB0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=phJ1P3wZKQ8S1fpMR8X83f4rxoLUs2g/mw26pZ7MTzNbeRo2Xxr5SiIZs3Des2NpzQnIJZ5YG2aiDh3IQUNJbtysu/Jju+4jOeqU4/rdwLR/xYlCqSVg173Hnle5emHR9clH+pNv5s5xf+fIj/Lzwn5yE2Xf3NiaarOeVwh7mGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce4692a4so37565645ab.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Oct 2024 20:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728272725; x=1728877525;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHDFllNFkJYjZMg3+UKblc+rJSGQvVCNk33TyfmVclQ=;
        b=FdaHYyEQrBOcpppZ5/8TXiRxsVyfJPz8rBg5/SP9GMbvXSdgLqmyR3yNqJYj6+ORP4
         D39X4Pb8bzloyBRYCzEysIEYUhq+G+i03SVn/XTcOdR8w2oAajah14NlQWXSgAocDOhb
         mAfawHKBEsSeFAN4Bz2Y9zFi0lYAXDGtdsq3nLNWJjb67G+V2nlPTbR75XgazW4yyQch
         kXCumFVoUAmRwpHgGmRnywaj7WP9b2oZqBZdHF9PMYz6qQC/I2uGwKAiB636KXXDw7gW
         SnETFWA+HZRPlio3y0ld2H3QIKaE5ucO+ZLYsaOIwr3QH4H0RkcgpaNK/9gG9mUUzfAL
         XXVA==
X-Forwarded-Encrypted: i=1; AJvYcCXKzkYfh8R72Kfm2xNmRbG0rlfgAU1m3K46oNObl/OlvO33gT+Ea1Jv5/20P8JWqm3R0uz1MW5mug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyASM7dTSuy7Oq/rtuZacQjbiNFmmPcCe2S2Dqj5X6rHzGw8rdc
	NZ1I9l/BQRgHn9f00eFWaZS3UmwuyrWGzcrlb+lEqVpBgSfP2rRVcz1+f4hkw7kNmDgkkOvgujP
	Pi+FdKWG4vD95JuxH8VC6rWzGhhjJO7Ge11qRsP0UVBSXsVC97UUqPj4=
X-Google-Smtp-Source: AGHT+IFSSQ0O5NWCPHLfJ5FTMmjfexyxQ1RllCpsR04JHvoL9xjwUXEmb4lw+HPAshkq7f3cP1F1kXhMVWg4ypVjqBwph10rhpdp
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148b:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a375c3a577mr79101665ab.1.1728272725250; Sun, 06 Oct 2024
 20:45:25 -0700 (PDT)
Date: Sun, 06 Oct 2024 20:45:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67035955.050a0220.49194.04f6.GAE@google.com>
Subject: [syzbot] [pm?] INFO: task hung in rpm_resume
From: syzbot <syzbot+73932f4591b9b973aa0c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f602276d390 Merge tag 'bcachefs-2024-10-05' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16837380580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9775e9a1af839423
dashboard link: https://syzkaller.appspot.com/bug?extid=73932f4591b9b973aa0c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ee98512e98a/disk-8f602276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49013050a378/vmlinux-8f602276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8c78e7f7a33/bzImage-8f602276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73932f4591b9b973aa0c@syzkaller.appspotmail.com

INFO: task syz.1.4401:14591 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.4401      state:D stack:21664 pid:14591 tgid:14591 ppid:5216   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 rpm_resume+0x504/0x1670 drivers/base/power/runtime.c:834
 rpm_resume+0x8fe/0x1670 drivers/base/power/runtime.c:892
 __pm_runtime_resume+0x120/0x180 drivers/base/power/runtime.c:1172
 pm_runtime_resume_and_get include/linux/pm_runtime.h:430 [inline]
 usb_autopm_get_interface+0x22/0xf0 drivers/usb/core/driver.c:1833
 wdm_manage_power+0x1c/0xa0 drivers/usb/class/cdc-wdm.c:1134
 wdm_release+0x20f/0x460 drivers/usb/class/cdc-wdm.c:779
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9a6fb7dff9
RSP: 002b:00007ffddf8ae408 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f9a6fd37a80 RCX: 00007f9a6fb7dff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f9a6fd37a80 R08: 0000000000000006 R09: 00007ffddf8ae6ff
R10: 00000000005ea99c R11: 0000000000000246 R12: 00000000000441aa
R13: 00007ffddf8ae510 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:0/11:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000107d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000107d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
7 locks held by kworker/u8:3/51:
 #0: ffff88801baeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bc7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bc7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcb2cd0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffff8880604220e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880604220e8 (&dev->mutex){....}-{3:3}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
 #3: ffff8880604220e8 (&dev->mutex){....}-{3:3}, at: devlink_pernet_pre_exit+0x13b/0x440 net/devlink/core.c:506
 #4: ffff888060423250 (&devlink->lock_key#2){+.+.}-{3:3}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff888060423250 (&devlink->lock_key#2){+.+.}-{3:3}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff888060423250 (&devlink->lock_key#2){+.+.}-{3:3}, at: devlink_pernet_pre_exit+0x14d/0x440 net/devlink/core.c:506
 #5: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
 #6: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:6025 [inline]
 #6: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x5ea/0x1da0 net/core/dev.c:11384
2 locks held by getty/4973:
 #0: ffff88802e81e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
7 locks held by kworker/1:4/5270:
 #0: ffff888144af2d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888144af2d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: 
ffffc90004317d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
ffffc90004317d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888144f8b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144f8b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff88807b70f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88807b70f190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #4: ffff88805f9fc160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88805f9fc160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #5: ffff8880286d1a20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff8880286d1a20 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #6: ffffffff8f599410 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x13a/0x5a0 drivers/usb/core/file.c:134
8 locks held by kworker/1:7/5273:
3 locks held by kworker/1:8/5301:
 #0: ffff88801c293148 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801c293148 ((wq_completion)pm){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90004407d00 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004407d00 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff8880284d4510 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #2: ffff8880284d4510 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_port_suspend+0x1c6/0x14d0 drivers/usb/core/hub.c:3463
1 lock held by syz.1.4401/14591:
 #0: ffffffff8f621188 (wdm_mutex){+.+.}-{3:3}, at: wdm_release+0x4f/0x460 drivers/usb/class/cdc-wdm.c:764
2 locks held by syz.4.5516/17073:
 #0: ffffffff8f599410 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
 #1: ffffffff8f621188 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x56/0x550 drivers/usb/class/cdc-wdm.c:715
2 locks held by syz.4.5516/17097:
 #0: ffffffff8f599410 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
 #1: ffffffff8f621188 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x56/0x550 drivers/usb/class/cdc-wdm.c:715
1 lock held by syz.1.5856/17832:
 #0: ffffffff8f599410 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.5915/17956:
 #0: ffff888144f8b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144f8b190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x156/0x770 drivers/usb/core/devio.c:1051
1 lock held by syz.3.6186/18612:
 #0: ffff888144f8b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144f8b190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x156/0x770 drivers/usb/core/devio.c:1051
1 lock held by syz-executor/18673:
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: __tun_chr_ioctl+0x48c/0x2400 drivers/net/tun.c:3121
1 lock held by syz-executor/18677:
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/18682:
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/18684:
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: __rtnl_newlink net/core/rtnetlink.c:3720 [inline]
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_newlink+0xab7/0x20a0 net/core/rtnetlink.c:3743
1 lock held by syz.2.6228/18755:
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcbf7c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5273 Comm: kworker/1:7 Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x28/0x70 kernel/kcov.c:217
Code: 90 90 f3 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 80 d7 03 00 65 8b 15 50 01 6f 7e 81 e2 00 01 ff 00 74 11 81 fa 00 01 00 00 75 35 <83> b9 1c 16 00 00 00 74 2c 8b 91 f8 15 00 00 83 fa 02 75 21 48 8b
RSP: 0018:ffffc90000a18ad8 EFLAGS: 00000246
RAX: ffffffff898cbc1f RBX: 0000000000000001 RCX: ffff88807e6ada00
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000008
RBP: ffffc90000a18c08 R08: ffffffff898cbc11 R09: 1ffffffff285211d
R10: dffffc0000000000 R11: fffffbfff285211e R12: ffff8880b8740168
R13: ffff8880b87402b0 R14: 0000000000000001 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f517f114100 CR3: 00000000317e0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 process_backlog+0x2ff/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
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

