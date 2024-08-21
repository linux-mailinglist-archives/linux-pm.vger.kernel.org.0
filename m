Return-Path: <linux-pm+bounces-12624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18DA9599B8
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694CB281E78
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F14211CC3;
	Wed, 21 Aug 2024 10:14:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07740211CA1
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235268; cv=none; b=Ezbu/jj8L5Rt99iIcjQjM2Z+RI4eMgMo2qCqZI07IZfaAOtTreJE5o7b1FsvX/bPjjT2J4uLzIAdJFcdEXmquAeuSPvSqTNwMt1DPc9U3Pe+YUkWHPWIojqFIWIwGvp8DQN0I75ajb6HM+TxKyMJDu4bxdjwQYyFaYIwfSAYRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235268; c=relaxed/simple;
	bh=acMQ9nkgLpBswSkNb7WLmMxY1DhCSaMfF4fjYgqHKZg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hXB6PNU6c2vqS9cQTC4GLD7vkN6iluENYw99VLlBkR6/LGsi1nwtDfQnqvpCDNHzzg/71f0C2GQcBxPXyfRnR5U0E403lBPToMy+sAedibgutTk52ei9IFQVqRoRep2GCD66SYBHaxlJZi1nI92S1rx4Ay47s0TvEPj5o+Iwaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-821dabd4625so665390439f.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 03:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724235266; x=1724840066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JYUytGtfjn6tJfzTuVwuHzUclQO1v7IYmJIdgkUE04=;
        b=NBLRMoTMrZ0g5JP88NrfEHWml7tU2lUn+INGDWyck1HIBuPQxKCXcJ+D4wp1uxMlLk
         V/TLPCSAq/c2DAU/KOi6s5jgHv6U0ClmGD4r/i2DgZSL7RcZPjEu3yVvhHko+6+jC0XI
         eWO6EpEKE6yOiFfWiA6DBsOMbS8ALf+EakYVJAOd8G4N7fRwZvgWQayGpqVfi+CN2KFt
         D7C3xx5rsEt25i3teOjgqFzzVyYLX1EXkeGqZQDEZ43ZtQ6sRzpDohZ/b6Z54mlVrMWA
         JzSOw3nhh61G73a53SFIv3XDkWzAIm/dWUOqRuIjwRdpwe4USizpEk58+/apqWmkjtUS
         l73w==
X-Forwarded-Encrypted: i=1; AJvYcCWDkcu1QCjhPFSX+qpvhUEGWcvwU/EjcO2ae3uGX/Rf5WufIQTfV98znm00mi0jVWzc4MWo9Ac1dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/we85l0fDNOlARSATvj7N9anwbBq+W0zip5HUyHOewatPgbu
	YYP8ls3xqtyagVOG/xw8+Mw1um7xggSkUWJaFZkiEZQTJI1FyriE7p6c/hnMOJ2CYKHXleBd+mb
	4pV1KoEOyGQwpmD0iRGJv/IgeG6zqhtVAhmXLwID74ExS8YrXw9qupL4=
X-Google-Smtp-Source: AGHT+IHJbLjWjkNRjKj4RjkrUWc2f4gC9xqwFLogbJZofuY9wX2/QGMraGdn/UAVmGoyzCh4+DRilmeLEkiN6fDLeXhta5PryRFM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:380:9233:96e6 with SMTP id
 e9e14a558f8ab-39d6c3c4b5cmr959485ab.4.1724235266163; Wed, 21 Aug 2024
 03:14:26 -0700 (PDT)
Date: Wed, 21 Aug 2024 03:14:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c97fd06202ece3b@google.com>
Subject: [syzbot] [pm?] WARNING in enable_work
From: syzbot <syzbot+7053fbd8757fecbbe492@syzkaller.appspotmail.com>
To: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5fa841af679 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b8adf3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f8ce1609883/disk-e5fa841a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a0d8aabc8a5/vmlinux-e5fa841a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a7f6c33922b/bzImage-e5fa841a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7053fbd8757fecbbe492@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: work disable count underflowed
WARNING: CPU: 1 PID: 5233 at kernel/workqueue.c:4290 work_offqd_enable kernel/workqueue.c:4290 [inline]
WARNING: CPU: 1 PID: 5233 at kernel/workqueue.c:4290 enable_work+0x34d/0x360 kernel/workqueue.c:4461
Modules linked in:
CPU: 1 UID: 0 PID: 5233 Comm: kworker/1:3 Not tainted 6.11.0-rc3-syzkaller-00279-ge5fa841af679 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:work_offqd_enable kernel/workqueue.c:4290 [inline]
RIP: 0010:enable_work+0x34d/0x360 kernel/workqueue.c:4461
Code: d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 88 cd 92 0a e8 68 17 36 00 c6 05 bf 2e a4 0e 01 90 48 c7 c7 80 10 0a 8c e8 a4 3e f8 ff 90 <0f> 0b 90 90 e9 56 ff ff ff e8 e5 25 59 0a 0f 1f 44 00 00 90 90 90
RSP: 0018:ffffc900042270c0 EFLAGS: 00010046
RAX: 022b146294645100 RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc900177a9000 RSI: 00000000000fffff RDI: 0000000000100000
RBP: ffffc90004227190 R08: ffffffff8155b4d2 R09: 1ffff1101726519a
R10: dffffc0000000000 R11: ffffed101726519b R12: 1ffff92000844e1c
R13: 1ffff92000844e24 R14: 0000000000800001 R15: ffff88802d570738
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3321bff8 CR3: 000000005bbf0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __cancel_work_sync+0xf5/0x110 kernel/workqueue.c:4331
 thermal_zone_device_unregister+0x296/0x3f0 drivers/thermal/thermal_core.c:1660
 psy_unregister_thermal drivers/power/supply/power_supply_core.c:1333 [inline]
 power_supply_unregister+0xe8/0x140 drivers/power/supply/power_supply_core.c:1610
 thunderstrike_destroy drivers/hid/hid-nvidia-shield.c:927 [inline]
 shield_remove+0x72/0x120 drivers/hid/hid-nvidia-shield.c:1104
 hid_device_remove+0x227/0x370
 device_remove drivers/base/dd.c:566 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x4ab/0x7c0 drivers/base/dd.c:1295
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
 device_del+0x57a/0x9b0 drivers/base/core.c:3871
 hid_remove_device drivers/hid/hid-core.c:2914 [inline]
 hid_destroy_device+0x68/0x100 drivers/hid/hid-core.c:2934
 usbhid_disconnect+0x9e/0xc0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x260/0x940 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x505/0x7c0 drivers/base/dd.c:1295
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
 device_del+0x57a/0x9b0 drivers/base/core.c:3871
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1418
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

