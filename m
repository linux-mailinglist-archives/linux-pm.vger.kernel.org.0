Return-Path: <linux-pm+bounces-14383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26097B742
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 06:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8211F23FDA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 04:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B94F137930;
	Wed, 18 Sep 2024 04:50:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E962B2D7
	for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2024 04:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726635026; cv=none; b=R2jQOHcW0oo5YGG45jvxMhvSi2BxXJ91uYWl04kl/YGSJ58ooOglsrrYD8POnK8h7+f2bZe0+TCeYaN62Xf0uYQEU3aVjvpEBDhnG2IdxpkLGbenJ7LLx/dR17GynIkXQevRRopvqTTUVFebx+08RtltDnxupP6v9J3WKS8pSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726635026; c=relaxed/simple;
	bh=BoxUpSCPngrY2sJbiNIrXqsmF2cJ70ktieZJOF9we2E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ol11tgkP8lNf88VbDxQ6OmlyOcdJs8UeepBBuh5HvBS1GXICFvjWoCc9se7N69uI7OGbh63fzva/4L7ISX1ki5waf46hpj/RiBTlqv62wJkMEooZrJD8y4uzOtiMgsVqzMv6rqvQSFVVAtbbNhIi048D2EDKbbVBI4+n5K6YrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so90392725ab.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 21:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726635024; x=1727239824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6cMvyGRah0zmyP/FS/bLHhfL/2sIxnCnkoejgKKoZA=;
        b=VbNf7rpw9oRyctQL09h+kJihoh6h7TculuhTqKeFYF+2vokBqBmytBOXLMpvX8KT1a
         BwhElHb77+Rzdl+KBNYYmTu/t9M1d2KBkL+ZF4i18+13whNizgJeHOkQDENYkOvpDjpG
         vqgTAfzznhX5qOHF7bOJ9CqlJkex02xzhl+YuWkUCrzagm6h0dvyQnMDGlysirD6fh5J
         zvfIEQav94aXwfwuY8H9OYi0jWx1z14lF6X5nm21EQfJ0B/Zz6W2+DjHW6kc4ZypNHVN
         3UCUO6vYKkzTM3gQFryvsPoe8m8K9T98Tu8YSTXN6HujN05JWDMLVdFgVMPQYgHvQ5kS
         t2uw==
X-Forwarded-Encrypted: i=1; AJvYcCXE0WTsQq/YZ+XJHQgGt7BDCbpAm5qR++3L969W6mXCYNB46NmIvcDQi+bqTB+sE5x5UV/bnu+AzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKi1czDsF8Q4YspeSlnlDc5aIUWYm6aAHIllsANAKwF9P7aYti
	+N1O8KisioJ8rW8/3fz7TdLA+E8RWa5VgXTqas+a43kDFj5W23Fi+ivDo4aD2sbI1ankvLt27xo
	6Qvl9FShn5iQ9ssmVfo7b8PkiKJ3vVOYyVRmuecTJ6phhF6Opx5IIfy0=
X-Google-Smtp-Source: AGHT+IGx6xekz9dBy7KyvLqiSonuN4bnePX8E1WfOkWexihRUoF/5MBPIUOCbaoeGw6qptNCwiyFS8dnhs2NtDJeTGvrr5keMm1O
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:3a0:378a:884b with SMTP id
 e9e14a558f8ab-3a08b6f87c3mr136149505ab.3.1726635023955; Tue, 17 Sep 2024
 21:50:23 -0700 (PDT)
Date: Tue, 17 Sep 2024 21:50:23 -0700
In-Reply-To: <0000000000008c97fd06202ece3b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000428af806225d8bf6@google.com>
Subject: Re: [syzbot] [pm?] WARNING in enable_work
From: syzbot <syzbot+7053fbd8757fecbbe492@syzkaller.appspotmail.com>
To: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a940d9a43e62 Merge tag 'soc-arm-6.12' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1236bfc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
dashboard link: https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144a9207980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124a9207980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a940d9a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9929bfe422c/vmlinux-a940d9a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6c74ee261ed/bzImage-a940d9a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7053fbd8757fecbbe492@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: work disable count underflowed
WARNING: CPU: 1 PID: 56 at kernel/workqueue.c:4298 work_offqd_enable kernel/workqueue.c:4298 [inline]
WARNING: CPU: 1 PID: 56 at kernel/workqueue.c:4298 enable_work+0x2fa/0x340 kernel/workqueue.c:4469
Modules linked in:
CPU: 1 UID: 0 PID: 56 Comm: kworker/1:1 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:work_offqd_enable kernel/workqueue.c:4298 [inline]
RIP: 0010:enable_work+0x2fa/0x340 kernel/workqueue.c:4469
Code: 89 ee e8 f9 4d 35 00 45 84 ed 0f 85 28 fe ff ff e8 0b 4c 35 00 c6 05 50 81 af 0e 01 90 48 c7 c7 80 dc 4b 8b e8 47 32 f7 ff 90 <0f> 0b 90 90 e9 05 fe ff ff 48 89 ef e8 05 09 94 00 e9 a9 fe ff ff
RSP: 0018:ffffc90000a87448 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814e2c49
RDX: ffff88802052c880 RSI: ffffffff814e2c56 RDI: 0000000000000001
RBP: ffff888027663718 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff92000150e8a
R13: 0000000000000000 R14: ffffffff8f5ed040 R15: ffffffff8f5ed040
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc995722e18 CR3: 000000000db7c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __cancel_work_sync+0xe7/0x130 kernel/workqueue.c:4339
 thermal_zone_device_unregister drivers/thermal/thermal_core.c:1599 [inline]
 thermal_zone_device_unregister+0x27c/0x460 drivers/thermal/thermal_core.c:1569
 psy_unregister_thermal drivers/power/supply/power_supply_core.c:1333 [inline]
 power_supply_unregister+0x10a/0x150 drivers/power/supply/power_supply_core.c:1610
 thunderstrike_destroy drivers/hid/hid-nvidia-shield.c:927 [inline]
 shield_remove+0x75/0x130 drivers/hid/hid-nvidia-shield.c:1104
 hid_device_remove+0xce/0x260 drivers/hid/hid-core.c:2730
 device_remove+0xc8/0x170 drivers/base/dd.c:566
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 hid_remove_device drivers/hid/hid-core.c:2914 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2934
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1da5/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

