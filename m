Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77330D341
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 07:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBCF77 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 00:59:59 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54743 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBCF76 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 00:59:58 -0500
Received: by mail-io1-f69.google.com with SMTP id g7so20681012ion.21
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2021 21:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GJ/TBvcrz0gRxndvI+wg7NtGKj1+puWSs8F15LZl46U=;
        b=JpyJ+bEj8wItZv9X9n5g+TeTBRyXD99jTrAPHr/roQYHVdxEGW/ZqDOWNw0EkDdd1Y
         f9QRBV5aFOZYtd+GUuFZp4r+Jc8o6sn1y4h+tUK2D+MJipEWzBxilBxcGSQd+u6wVVMj
         oMGWGy0TYfgMq+Lw1Sz274tqn9Ul9rdfcSd4I6ZZNvutjiKYu1ycolYv2dHKJh4b6oM4
         SjySRfAm6TcKzK224a31N8O3/mCq4GWtgZ6gsoerIyZ+R5l1iVTTfTgiUCyt/OXnT4KH
         hRr7pczFHw7zXT8XNO3E2z9xB9gP+B6NNYEI/CCZCIGMEwPn+43vXyANQWRRa6t4XbVS
         wQuA==
X-Gm-Message-State: AOAM531MW9MvY74+m5NhNh3ayr8B83ONTBmSHzdH4wDO5/MwS4F2YC3D
        yPlSUxZjkRGSW6ojMLYMCUacvcqlWgCRSEPbQSGV2eeIo/pZ
X-Google-Smtp-Source: ABdhPJxaUdC+nGpiCRbkZxim1ZR61kTpD+WH8WNtEd5gGBmrnQCM/aWCBMtMpHiU9uRTLWr0C68F4Wq4cswrWQGJaRKEGj4nQ5uH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1928:: with SMTP id p40mr1582615jal.71.1612331957886;
 Tue, 02 Feb 2021 21:59:17 -0800 (PST)
Date:   Tue, 02 Feb 2021 21:59:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c21de05ba6849e7@google.com>
Subject: kernel BUG in memory_bm_free
From:   syzbot <syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com>
To:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3aaf0a27 Merge tag 'clang-format-for-linux-v5.11-rc7' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ef6108d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10152c2ea16351e7
dashboard link: https://syzkaller.appspot.com/bug?extid=5ecbe63baca437585bd4
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at kernel/power/snapshot.c:257!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 2394 Comm: syz-executor.0 Not tainted 5.11.0-rc6-syzkaller-00055-g3aaf0a27ffc2 #0
Hardware name: linux,dummy-virt (DT)
pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
pc : free_image_page kernel/power/snapshot.c:257 [inline]
pc : free_image_page kernel/power/snapshot.c:253 [inline]
pc : free_list_of_pages kernel/power/snapshot.c:274 [inline]
pc : memory_bm_free+0x260/0x320 kernel/power/snapshot.c:726
lr : free_basic_memory_bitmaps+0x3c/0x90 kernel/power/snapshot.c:1173
sp : ffff8000163dbc50
x29: ffff8000163dbc50 x28: f4ff000025204070 
x27: ffff800012d4c000 x26: f4ff000025204008 
x25: f5ff00002827c700 x24: ffff800012d4c000 
x23: 00007fffffffffff x22: f4ff000025204018 
x21: 0000000000000001 x20: ffff800013b576d0 
x19: f5ff00002827c700 x18: 0000000000000000 
x17: 0000000000000000 x16: 0000000000000000 
x15: 0000000000000000 x14: 0000000000000000 
x13: 0000000000000000 x12: 0000000000000000 
x11: 0000000000000000 x10: 0000000000000000 
x9 : fcff000025205400 x8 : 0000000000000002 
x7 : f6ff000025205000 x6 : 00000000000001ff 
x5 : 0000000000000000 x4 : 0000000000000000 
x3 : ffff800013b576d0 x2 : f4ff00002517e000 
x1 : 0000000000000001 x0 : 0b0000002517e000 
Call trace:
 free_image_page kernel/power/snapshot.c:257 [inline]
 free_list_of_pages kernel/power/snapshot.c:274 [inline]
 memory_bm_free+0x260/0x320 kernel/power/snapshot.c:726
 free_basic_memory_bitmaps+0x3c/0x90 kernel/power/snapshot.c:1173
 snapshot_release+0x74/0x90 kernel/power/user.c:120
 __fput+0x78/0x230 fs/file_table.c:280
 ____fput+0x10/0x20 fs/file_table.c:313
 task_work_run+0x80/0x160 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 do_notify_resume+0x20c/0x13e0 arch/arm64/kernel/signal.c:939
 work_pending+0xc/0x3d4
Code: cb000260 d34cfc00 97fcf6fe 35fffc20 (d4210000) 
---[ end trace 174c294156b0dfb3 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
