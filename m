Return-Path: <linux-pm+bounces-15950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874FB9A3CD7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 13:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150561F22FF6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB320403F;
	Fri, 18 Oct 2024 11:07:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1320262D
	for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249655; cv=none; b=n0oaACPBeyDx6wvAF7s8fK04SL1ru4kF0JIyJbeLNNmxdK5Z3Djt9mBNnR034T0MbVgjjIP7meBwrYlMnaVRKarpkx9U/UIRdE1xGWLbo8ld9tKeaMspDmj/fKERTd9qC1jfiJOp6ZJyGRMFyCHqoJ1Xwf//oT19MWKySY4BlnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249655; c=relaxed/simple;
	bh=N1WTYhKo8iTm67koSSjIAdU2i0KeEnRKF4LrPcOgrgY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b0rmFVbGhMznRZ15tCX2B9/AhB5wqBzI6tyvAMS9fikIafLG3pViHrHkEsY/3SHailROL7KTg/SLRUS1GjCgDGHwXqNd1YReXZN1Udjpd7ws24SF//zgFgEHB0HMVE+feiNXruFf6sbKk1SKG3ofcYiWJCnBxpRjEC1TxwAYKq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso18616755ab.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2024 04:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729249653; x=1729854453;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C72w+3uPUzoz0HKooV4z9jWdHJhkKtLSXpMEvCoalBc=;
        b=loX2mxUc1a/oDAnQRHc+SddW5FSfMmFGWs9eObGq5LgxsNLDQZDoN71JqUYN0w7u6W
         rne9vuaMC94HXbigZDaEMzchMgWQolAz2emm+bBEtGtCU+ocvartmKYs3+RxtHSwGlMH
         gnzOEcxhDhmJZhgub95L9gZu2zP4wBohJ0WF7o20M53fepLNCNX5wFD6OD0el/uSz5wD
         TnipxYlLrW3FnILkg3kCspu+stW6PXvAWK5egz4CfXn6zogi8HTIHC0BpioojbH2wgeY
         kKkbIwFju+wkSk1WvilPLZo1dvOLidzSboOyqryPpEZIjwLVAYKUeH6tSbwpyORXB042
         oMlg==
X-Forwarded-Encrypted: i=1; AJvYcCWBcyhk1PkU6hL7MkqsO6Y/D+emU73/PTh990v2EoGVQpUNZuPWQL8k/vYOf0ky+vRRIiaaRXEDQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fo0rulQg5MUWDeR4A9l7IC8ZAd0jSeJmcnc5joxhhvalPZMo
	qHDVgGD5jMBXoFdEgJKt0SELMzvUqPrVZOcKrvD7AHXhhlmp2tmOBByLpRAStfmpSSGmEJQdlBy
	qQoXTDGo2QKkTR5zyd34zss1v+u6s4RImapMDCX4xMbEETqdMWscjjWg=
X-Google-Smtp-Source: AGHT+IF7AaTYncNS8ilO3bhXIksa2eWkGMJ6FP7e0uj1r8BE3zSPk6cISARX8slUk7N6mxpSad2Zao3LX1GUSh+dbKtsgrvCmiMR
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc2:b0:3a3:40f0:cb8c with SMTP id
 e9e14a558f8ab-3a3f40a8528mr20878255ab.17.1729249653340; Fri, 18 Oct 2024
 04:07:33 -0700 (PDT)
Date: Fri, 18 Oct 2024 04:07:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67124175.050a0220.10f4f4.0012.GAE@google.com>
Subject: [syzbot] [pm?] WARNING in thermal_thresholds_flush
From: syzbot <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com>
To: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=123c2f27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
dashboard link: https://syzkaller.appspot.com/bug?extid=f24dd060c1911fe54c85
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1192f887980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1417e830580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c85347a66a1c/vmlinux-15e7d45e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/648cf8e59c13/bzImage-15e7d45e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 51 at drivers/thermal/thermal_thresholds.c:28 thermal_thresholds_flush+0x1ff/0x230 drivers/thermal/thermal_thresholds.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Not tainted 6.12.0-rc3-next-20241016-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:thermal_thresholds_flush+0x1ff/0x230 drivers/thermal/thermal_thresholds.c:28
Code: 34 24 eb 05 e8 02 76 36 f9 4c 89 f7 be 0f 00 00 00 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d e9 c7 3a ff ff e8 e2 75 36 f9 90 <0f> 0b 90 e9 7f fe ff ff 48 c7 c1 3c e6 1d 90 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90000bb7168 EFLAGS: 00010293
RAX: ffffffff885e6c6e RBX: 0000000000000000 RCX: ffff88802068da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8f97be40 R08: ffffffff885e6ae2 R09: 1ffffffff285d30e
R10: dffffc0000000000 R11: fffffbfff285d30f R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff8880468a4000 R15: ffff8880468a47c0
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9c90c27c78 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 thermal_zone_device_unregister+0x29e/0x370 drivers/thermal/thermal_core.c:1612
 psy_unregister_thermal drivers/power/supply/power_supply_core.c:1326 [inline]
 power_supply_unregister+0xe8/0x140 drivers/power/supply/power_supply_core.c:1539
 thunderstrike_destroy drivers/hid/hid-nvidia-shield.c:927 [inline]
 shield_remove+0x72/0x120 drivers/hid/hid-nvidia-shield.c:1104
 hid_device_remove+0x225/0x370
 device_remove drivers/base/dd.c:567 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x4a9/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3864
 hid_remove_device drivers/hid/hid-core.c:2968 [inline]
 hid_destroy_device+0x6a/0x1b0 drivers/hid/hid-core.c:2990
 usbhid_disconnect+0x9e/0xc0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x25e/0x940 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3864
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1418
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
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

