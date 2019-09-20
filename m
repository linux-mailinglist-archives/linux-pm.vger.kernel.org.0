Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295DCB9774
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405734AbfITS7K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 14:59:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33394 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406366AbfITS7J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 14:59:09 -0400
Received: by mail-io1-f72.google.com with SMTP id g15so12070872ioc.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 11:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fHMyxSwiQcNUowrlP4OwXGhbD4PSsSnYKAbGNNWdWLA=;
        b=EVnuXMMVfrWhidcxtty6WZurzmW9G0snFh4OBr3NzwBHOjcmN4lxIC3g/Xkk2H7kyd
         QdrocCykhGDDKxzAzmhUpuldoEB8lk97ExDBduxcu5vR9Cks5NhMhE6Oy4/y8g6okUCj
         kK48Om8OpN69GwYb8dZjh1rWenfDe1jBqCe0cevTD9ogKXwXaK50FN6rVqTCtqZOXKQq
         UwRDySUcClth007up5iQCo5cRJB66uqT1H3gIEqG5EGxwlvO498qiXgM3BFabUI6dtBv
         cqV3ykM4ZASCYnpYqD5AfeBriBdB4KiyCWFj8GGVMMckokRG0GcHwVwy1KW+Sl5rlr3v
         oKwQ==
X-Gm-Message-State: APjAAAV/h3kTmQv3kpaYNXH+kmrgTTZ6bh2ksUEvCLNIR/PQUJ0PE9Yo
        /MN8uiK3QnWEQzZinFMW4JHzQxU2ZURqmSQQMIN5HeTT1cZd
X-Google-Smtp-Source: APXvYqz5/sCdVeuK7ngAhTFRPzQFbcZSs5qN8slbau2sIUwcivybpDVGzUvM2pnS3Al9wCHnQeEEv7jevX1gbbemcbKtR1V5YD9d
MIME-Version: 1.0
X-Received: by 2002:a6b:f315:: with SMTP id m21mr17837544ioh.12.1569005948028;
 Fri, 20 Sep 2019 11:59:08 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:59:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ed3ab059300aaf1@google.com>
Subject: BUG: unable to handle kernel paging request in __pm_runtime_resume
From:   syzbot <syzbot+28ecdc146b8e7def92dd@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, pavel@ucw.cz,
        rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1670fa55600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=28ecdc146b8e7def92dd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+28ecdc146b8e7def92dd@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffbfff23530b1
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 21ffef067 P4D 21ffef067 PUD 21ffb2067 PMD 0
Oops: 0000 [#1] SMP KASAN
CPU: 1 PID: 17297 Comm: syz-executor.5 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:92 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:109 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x117/0x190 mm/kasan/generic.c:192
Code: 75 2f 49 89 e9 49 29 c1 e9 6c ff ff ff 5b b8 01 00 00 00 5d 41 5c c3  
4d 85 c9 74 f1 49 01 d9 eb 09 48 83 c0 01 4c 39 c8 74 e3 <80> 38 00 74 f2  
eb 92 4d 39 c2 74 4b e8 f8 e7 ff ff 31 c0 5b 5d 41
RSP: 0018:ffff8881c7427710 EFLAGS: 00010086
RAX: fffffbfff23530b1 RBX: fffffbfff23530b1 RCX: ffffffff8125804b
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff91a98588
RBP: fffffbfff23530b2 R08: 0000000000000001 R09: fffffbfff23530b2
R10: fffffbfff23530b1 R11: ffffffff91a9858f R12: ba771047467ec365
R13: 00000000467ec365 R14: 0000000000000003 R15: ffff8881cbca2078
FS:  00007f1c25a58700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff23530b1 CR3: 00000001d664d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  test_bit include/asm-generic/bitops-instrumented.h:237 [inline]
  __lock_acquire+0x133b/0x3eb0 kernel/locking/lockdep.c:3925
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4487
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
  __pm_runtime_resume+0xf5/0x180 drivers/base/power/runtime.c:1077
  pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
  usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1709
  usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234
  hid_hw_power include/linux/hid.h:1038 [inline]
  hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
  chrdev_open+0x219/0x5c0 fs/char_dev.c:414
  do_dentry_open+0x494/0x1120 fs/open.c:797
  do_last fs/namei.c:3408 [inline]
  path_openat+0x1430/0x3f50 fs/namei.c:3525
  do_filp_open+0x1a1/0x280 fs/namei.c:3555
  do_sys_open+0x3c0/0x580 fs/open.c:1089
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4138f1
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48  
83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f1c25a577a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00000000004138f1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f1c25a57850
RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f1c25a586d4
R13: 00000000004c8df7 R14: 00000000004dff20 R15: 00000000ffffffff
Modules linked in:
CR2: fffffbfff23530b1
---[ end trace 839607b5f3b5bbdf ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:92 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:109 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x117/0x190 mm/kasan/generic.c:192
Code: 75 2f 49 89 e9 49 29 c1 e9 6c ff ff ff 5b b8 01 00 00 00 5d 41 5c c3  
4d 85 c9 74 f1 49 01 d9 eb 09 48 83 c0 01 4c 39 c8 74 e3 <80> 38 00 74 f2  
eb 92 4d 39 c2 74 4b e8 f8 e7 ff ff 31 c0 5b 5d 41
RSP: 0018:ffff8881c7427710 EFLAGS: 00010086
RAX: fffffbfff23530b1 RBX: fffffbfff23530b1 RCX: ffffffff8125804b
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff91a98588
RBP: fffffbfff23530b2 R08: 0000000000000001 R09: fffffbfff23530b2
R10: fffffbfff23530b1 R11: ffffffff91a9858f R12: ba771047467ec365
R13: 00000000467ec365 R14: 0000000000000003 R15: ffff8881cbca2078
FS:  00007f1c25a58700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff23530b1 CR3: 00000001d664d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
