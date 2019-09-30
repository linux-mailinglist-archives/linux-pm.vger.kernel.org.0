Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406D6C29BF
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfI3Wjm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 18:39:42 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33602 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3WjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 18:39:15 -0400
Received: by mail-io1-f72.google.com with SMTP id g15so33397450ioc.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 15:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fSg2+3ZjOd6Xm3ek+0uccVLq7lDEKLwVzQo9vBxV9uw=;
        b=GdQL4Y5D46LFh6ujXpEhjz/Q1L823nkkdpCsheNvlzLAPXT7MfRJxDlOYXSNFWDm1F
         7NDAPpUQyvJnalqBHY7MgmRErHSkKLstS6T68m1gpQDll49x5AdX9zoEh6VoBRsceIg0
         RofOF2WEA0p4r0jwNtZVziQgNwJs2TUCdYx7VxzewEEQ9a2T4cakr2YLNdqPo0F/iAa8
         FqEsebjM12MTfvTygS3j0/9FPrwETLDQW9CfLRvqSI+aT7FXkAUFRToaUBuooU6JmM67
         XJnfhBESKStVyY3OO5y++iTf7nxyYFk19+0unsD3oo+5+w4b/0Ixob18xlEppXV8IWtt
         /tsA==
X-Gm-Message-State: APjAAAWeX2jFg6YmxM0qviuQpzEflaG/VAz1KDvSVY+neUzJzkWBDFJn
        9j13g5eQZc3v3E6m23/7jzPKW4pRy0Y4vh7RQK+0X0sRLNXp
X-Google-Smtp-Source: APXvYqw9CTDDQZ7VLGfC6apTmOgAmIv3Iait8U3TrD0s2cylNXj3I3FPbWr4+RIL1PcrGoyLq7CMoJVHMLrxR2zPbahk6Um1C3kL
MIME-Version: 1.0
X-Received: by 2002:a92:3b09:: with SMTP id i9mr23431535ila.301.1569883154183;
 Mon, 30 Sep 2019 15:39:14 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:39:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be807f0593cce7f9@google.com>
Subject: KMSAN: uninit-value in rpm_resume
From:   syzbot <syzbot+f29321f9d6534937db3a@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    61ccdad1 Revert "drm/bochs: Use shadow buffer for bochs fr..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16207574600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27abc558ecb16a3b
dashboard link: https://syzkaller.appspot.com/bug?extid=f29321f9d6534937db3a
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1187d174600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158afe2c600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f29321f9d6534937db3a@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in rpm_resume+0x3e8/0x2bb0  
drivers/base/power/runtime.c:715
CPU: 0 PID: 12437 Comm: syz-executor249 Not tainted 5.3.0-rc3+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  rpm_resume+0x3e8/0x2bb0 drivers/base/power/runtime.c:715
  __pm_runtime_resume+0x116/0x190 drivers/base/power/runtime.c:1076
  pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
  usb_autopm_get_interface+0x5f/0x100 drivers/usb/core/driver.c:1707
  usbhid_power+0xb7/0x170 drivers/hid/usbhid/hid-core.c:1234
  hid_hw_power include/linux/hid.h:1038 [inline]
  hidraw_open+0x459/0xc10 drivers/hid/hidraw.c:282
  chrdev_open+0xc58/0xe00 fs/char_dev.c:414
  do_dentry_open+0xda7/0x1810 fs/open.c:797
  vfs_open+0xaf/0xe0 fs/open.c:906
  do_last fs/namei.c:3416 [inline]
  path_openat+0x17f4/0x6bb0 fs/namei.c:3533
  do_filp_open+0x2b8/0x710 fs/namei.c:3563
  do_sys_open+0x642/0xa30 fs/open.c:1089
  __do_sys_open fs/open.c:1107 [inline]
  __se_sys_open+0xad/0xc0 fs/open.c:1102
  __x64_sys_open+0x4a/0x70 fs/open.c:1102
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x401880
Code: 01 f0 ff ff 0f 83 c0 0b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d 4d 5e 2d 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 94 0b 00 00 c3 48 83 ec 08 e8 fa 00 00 00
RSP: 002b:00007fff8bdb7688 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000401880
RDX: 0000000000000000 RSI: 0000000000088802 RDI: 00007fff8bdb7690
RBP: 6666666666666667 R08: 000000000000000f R09: 000000000000000b
R10: 0000000000000075 R11: 0000000000000246 R12: 00000000004028a0
R13: 0000000000402930 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:187 [inline]
  kmsan_internal_poison_shadow+0x53/0xa0 mm/kmsan/kmsan.c:146
  kmsan_slab_free+0x8d/0x100 mm/kmsan/kmsan_hooks.c:195
  slab_free_freelist_hook mm/slub.c:1472 [inline]
  slab_free mm/slub.c:3038 [inline]
  kfree+0x4c1/0x2db0 mm/slub.c:3980
  usb_release_interface+0x105/0x120 drivers/usb/core/message.c:1633
  device_release+0xe2/0x380 drivers/base/core.c:1060
  kobject_cleanup lib/kobject.c:693 [inline]
  kobject_release lib/kobject.c:722 [inline]
  kref_put include/linux/kref.h:65 [inline]
  kobject_put+0x38d/0x480 lib/kobject.c:739
  put_device+0x51/0x70 drivers/base/core.c:2213
  usb_disable_device+0x69a/0x1150 drivers/usb/core/message.c:1248
  usb_disconnect+0x51e/0xd60 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x3fd0/0x72f0 drivers/usb/core/hub.c:5441
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
