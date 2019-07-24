Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF38E7300B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGXNiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 09:38:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37119 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfGXNiG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 09:38:06 -0400
Received: by mail-io1-f71.google.com with SMTP id v3so51117510ios.4
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 06:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YmlYbeeXg8KipqZm+95RyiuSWYiaWNME9/ZKLNADTzI=;
        b=AnpJwaRExVi4h1pJDald9E5SZa8ycSOVzBUzYSBFmzg/+00HsEVmmLrLE3unOPx9FD
         98ppiQAJIkS4bsxHiimYmQ2RVRVhjFTMJUD1y0V4t+4G5ZlEGUTl0WPZZkQ5fQhJi+RF
         TqGlFtiFqUQ1Iq/lr0YVlKxd6vULSJusanJ6unPRjM8n3+RYHVdDzp1HpZVJQM7iLCvn
         ye8XVVa7UsTQpdXO/5PAlRhvPheTH61W5dS4kXG7q/jZvYzf6r0p5X3OXhJGYzavrSUz
         /d3LlQNBq27ikU50bnGvIv5g0GgSuaw3hgL78M2slxksHk8OEFV8baQTM/U49ByKUT4G
         dxSQ==
X-Gm-Message-State: APjAAAUcubkPJXSLk1bwA09BItqANWoRq32VgISU0oBfgDlxE+ACPON5
        xZFHWSLsDZTi37Hbqsh0XmmCNXBJnhg+a+hdHMdqnPIOqS1a
X-Google-Smtp-Source: APXvYqz2PxYFGpRCTtrjQIXkXtIveQHB4aG4N+6UmgzI6K4L4WM1q80LZoqSsv2AF51hyBZCqSCxZDmCm99YFNaGIo/9e+AxJw1A
MIME-Version: 1.0
X-Received: by 2002:a02:c550:: with SMTP id g16mr83081468jaj.49.1563975485145;
 Wed, 24 Jul 2019 06:38:05 -0700 (PDT)
Date:   Wed, 24 Jul 2019 06:38:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003acc06058e6d6b70@google.com>
Subject: general protection fault in __pm_runtime_resume
From:   syzbot <syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com>
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

HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=15562358600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=3cbe5cd105d2ad56a1df
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 3715 Comm: syz-executor.3 Not tainted 5.2.0-rc6+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__pm_runtime_resume+0x49/0x180 drivers/base/power/runtime.c:1069
Code: ed 74 d5 fe 45 85 ed 0f 85 9a 00 00 00 e8 6f 73 d5 fe 48 8d bd c1 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 fe 00 00 00
RSP: 0018:ffff8881d99d78e0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000020 RCX: ffffc90003f3f000
RDX: 0000000416d8686d RSI: ffffffff82676841 RDI: 00000020b6c3436a
RBP: 00000020b6c340a9 R08: ffff8881c6d64800 R09: fffffbfff0e84c25
R10: ffff8881d99d7940 R11: ffffffff87426127 R12: 0000000000000004
R13: 0000000000000000 R14: ffff8881d9b94000 R15: ffffffff897f9048
FS:  00007f047f542700(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30f21000 CR3: 00000001ca032000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
  usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1707
  usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234
  hid_hw_power include/linux/hid.h:1038 [inline]
  hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
  chrdev_open+0x219/0x5c0 fs/char_dev.c:413
  do_dentry_open+0x497/0x1040 fs/open.c:778
  do_last fs/namei.c:3416 [inline]
  path_openat+0x1430/0x3ff0 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3c0/0x580 fs/open.c:1070
  do_syscall_64+0xb7/0x560 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413711
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48  
83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f047f5417a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000413711
RDX: 0000000000000000 RSI: 0000000000084002 RDI: 00007f047f541850
RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f047f5426d4
R13: 00000000004c8a7a R14: 00000000004df748 R15: 00000000ffffffff
Modules linked in:
---[ end trace a2dcf3f649bfec9a ]---
RIP: 0010:__pm_runtime_resume+0x49/0x180 drivers/base/power/runtime.c:1069
Code: ed 74 d5 fe 45 85 ed 0f 85 9a 00 00 00 e8 6f 73 d5 fe 48 8d bd c1 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 fe 00 00 00
RSP: 0018:ffff8881d99d78e0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000020 RCX: ffffc90003f3f000
RDX: 0000000416d8686d RSI: ffffffff82676841 RDI: 00000020b6c3436a
RBP: 00000020b6c340a9 R08: ffff8881c6d64800 R09: fffffbfff0e84c25
R10: ffff8881d99d7940 R11: ffffffff87426127 R12: 0000000000000004
R13: 0000000000000000 R14: ffff8881d9b94000 R15: ffffffff897f9048
FS:  00007f047f542700(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30f21000 CR3: 00000001ca032000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
