Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545A6744A9
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 07:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390345AbfGYFEG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 01:04:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47200 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390343AbfGYFEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 01:04:06 -0400
Received: by mail-io1-f71.google.com with SMTP id r27so53579763iob.14
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 22:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=L3X65vZ3rUayuRUS9zN2GDw/XxLqoFgPS3n++Iwna6A=;
        b=WNYKQvDeSYi4ki+zfaV5x2D5m1srFWurqN4/7IHvT3bg3xwaRUIBM8pE0PPQnvSqeV
         cVYU8a0DOEpBr8ijkvoXFUIe0cU4uRgr2ZKqeZ1wqBjuPtE8M9YQ+Z9VrNU7jD7FSeeU
         3h36PRXmK9mRz1cYMDlp0pDSbf8mwnHq9QE3UgyprmXahFwL11tEEo2y81/f/se65Rfw
         /TXMWDUEZP8av6W3n0QeD8vm0n6uR0mFkn9bqXU+NCAWyizQMyjoKzs/JME5Zr7j9AAU
         wYopDCjqgSNmACbbbQ2W7WkvXDaFXLsfnLO9l8EwP1l/DzavmQKGcHQDmjgXzSPXEy9o
         hNrA==
X-Gm-Message-State: APjAAAUMRXGKXtwnGyxQRZmGLpguRwI4YfwlVTpadJy9gCf5L5KYEQm2
        K52/TKOJsEjvbM8Ot8zRAKB3kvkOpJ276PFbsC4cFAltYhp/
X-Google-Smtp-Source: APXvYqzY2yjxTZN7foDFPwt5tMSC/DMH88SCMokplXfOZycOYHM8wdRoZvOlXN32Jc9l/IU3X+nVJ88t3J/1E7NAJoWMPDLtLebS
MIME-Version: 1.0
X-Received: by 2002:a6b:b985:: with SMTP id j127mr27063494iof.186.1564031045859;
 Wed, 24 Jul 2019 22:04:05 -0700 (PDT)
Date:   Wed, 24 Jul 2019 22:04:05 -0700
In-Reply-To: <0000000000003acc06058e6d6b70@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e80c0e058e7a5a31@google.com>
Subject: Re: general protection fault in __pm_runtime_resume
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=108edb68600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=3cbe5cd105d2ad56a1df
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f0b4c8600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172d8758600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 1740 Comm: syz-executor618 Not tainted 5.2.0-rc6+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__pm_runtime_resume+0x49/0x180 drivers/base/power/runtime.c:1069
Code: ed 74 d5 fe 45 85 ed 0f 85 9a 00 00 00 e8 6f 73 d5 fe 48 8d bd c1 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 fe 00 00 00
RSP: 0018:ffff8881cf5878e0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000020 RCX: ffffffff82676833
RDX: 000000021d463be5 RSI: ffffffff82676841 RDI: 00000010ea31df2b
RBP: 00000010ea31dc6a R08: ffff8881d1b7e000 R09: fffffbfff0e84c25
R10: ffff8881cf587940 R11: ffffffff87426127 R12: 0000000000000004
R13: 0000000000000000 R14: ffff8881cfd7a500 R15: ffffffff897f9040
FS:  0000555555808880(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043f760 CR3: 00000001d0f29000 CR4: 00000000001406f0
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
RIP: 0033:0x401ad0
Code: 01 f0 ff ff 0f 83 c0 0b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d fd 5b 2d 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 94 0b 00 00 c3 48 83 ec 08 e8 fa 00 00 00
RSP: 002b:00007ffed8d15738 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000401ad0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffed8d15740
RBP: 6666666666666667 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402af0
R13: 0000000000402b80 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 60987a9feed42828 ]---
RIP: 0010:__pm_runtime_resume+0x49/0x180 drivers/base/power/runtime.c:1069
Code: ed 74 d5 fe 45 85 ed 0f 85 9a 00 00 00 e8 6f 73 d5 fe 48 8d bd c1 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 fe 00 00 00
RSP: 0018:ffff8881cf5878e0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000020 RCX: ffffffff82676833
RDX: 000000021d463be5 RSI: ffffffff82676841 RDI: 00000010ea31df2b
RBP: 00000010ea31dc6a R08: ffff8881d1b7e000 R09: fffffbfff0e84c25
R10: ffff8881cf587940 R11: ffffffff87426127 R12: 0000000000000004
R13: 0000000000000000 R14: ffff8881cfd7a500 R15: ffffffff897f9040
FS:  0000555555808880(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043f760 CR3: 00000001d0f29000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

