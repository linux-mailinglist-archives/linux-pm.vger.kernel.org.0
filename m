Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7BB4095
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390630AbfIPStb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 14:49:31 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:32897 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390525AbfIPStM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2019 14:49:12 -0400
Received: by mail-io1-f71.google.com with SMTP id g15so1195620ioc.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2019 11:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RkXqwUWWqXYWsyolkE4DiEvym9AqlDpeXVcvjbM0T6E=;
        b=r+jxNkbYzGB1E8F7m3XIEFjVxh/Dw7nVJr69oHUarCGuzzWCPjcr4Mn/hhK9aiuAQf
         Yo+rbbdRvRTVfhOOzMSbBi2MZhvOIcfJVofNtSGdzI0fvsJ8dSvGsM/QclLE0DQxZ4Om
         x2sIhP9xgnKYPPSnv/75kHT75Auv5WObQclLMxQ0Nm7Ou8u4uxLcLg1GDLIxMrYPh410
         XlzhQByFKH4+iqlqfsCgXRDxG2ChgNGnHVHzD/8bvq/eR743r4M4RByyKkrSomN5LpXE
         MiC1C0yzH8h4Hre2ZOCK/0hQA4mQzZKe5fYdzCuRLUKlgPU0bLNnwrk+cUapZTMFXF3n
         VQ8A==
X-Gm-Message-State: APjAAAW0NVbDPc2xiJmLIMymIUW0+60RKsUWMyzoAF4sWmzduQqMryBx
        OIIePSYC6HFhOFC04XA0jszIk7r5iqzqaTc2yIFX4ZeRH64J
X-Google-Smtp-Source: APXvYqxxXCpmjr04+y3jhfncZOzWpQL4Rd6k+zewclwOpwBkr50eP18zWgNtJ6jKP8XvsrKB6dxhBv8Q1sBeZAuvY1k7PjgPnXkW
MIME-Version: 1.0
X-Received: by 2002:a6b:210:: with SMTP id 16mr1534512ioc.104.1568659751579;
 Mon, 16 Sep 2019 11:49:11 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:49:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044408c0592b00ff5@google.com>
Subject: KASAN: global-out-of-bounds Read in __pm_runtime_resume
From:   syzbot <syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com>
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

HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10efb5fa600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=cd157359d82e8d98c17b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in __pm_runtime_resume+0x162/0x180  
drivers/base/power/runtime.c:1069
Read of size 1 at addr ffffffff863d87b1 by task syz-executor.2/13622

CPU: 0 PID: 13622 Comm: syz-executor.2 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:618
  __pm_runtime_resume+0x162/0x180 drivers/base/power/runtime.c:1069
  pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
  usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1709
  usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234
  hid_hw_power include/linux/hid.h:1038 [inline]
  hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
  chrdev_open+0x219/0x5c0 fs/char_dev.c:414
  do_dentry_open+0x494/0x1120 fs/open.c:797
  do_last fs/namei.c:3416 [inline]
  path_openat+0x1430/0x3f50 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3c0/0x580 fs/open.c:1089
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4137d1
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48  
83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007faea59927a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00000000004137d1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007faea5992850
RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007faea59936d4
R13: 00000000004c8cbf R14: 00000000004dfc90 R15: 00000000ffffffff

The buggy address belongs to the variable:
  __param_str_xfer_debug+0x91/0x4a0

Memory state around the buggy address:
  ffffffff863d8680: fa fa fa fa 00 00 00 02 fa fa fa fa 00 00 00 00
  ffffffff863d8700: fa fa fa fa 00 00 00 02 fa fa fa fa 00 07 fa fa
> ffffffff863d8780: fa fa fa fa 00 00 fa fa fa fa fa fa 00 00 07 fa
                                      ^
  ffffffff863d8800: fa fa fa fa 00 00 00 00 00 00 fa fa fa fa fa fa
  ffffffff863d8880: 00 07 fa fa fa fa fa fa 00 00 06 fa fa fa fa fa
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
