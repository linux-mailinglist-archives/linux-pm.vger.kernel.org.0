Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0AB57BC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 23:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfIQVoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 17:44:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37695 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfIQVoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 17:44:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id s28so4487520otd.4;
        Tue, 17 Sep 2019 14:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKcqtrlEn/n7PxU2KI9m0reyHk+S72VlPvTAhNccCIk=;
        b=oqolPs6GBOPW6oOzxdjNn+DydqyQOnnFMvxhKuUxFpbnvHsKxmTEdhyrvRO58ThFzv
         WBC4mWzhpnlbEcF9CLdjqxv/FKNt3GW7tx8lFk4gwHMqJPNt9xg5y1XY+C4EFxM+FIbt
         BVCUQ8kcu1qkotgl0LahrVcHxxhjcTUdlOn/5COLgf5GKUpxE4wTCEaZMvDBES6eXXaJ
         26ttxxELER/VavR7xgu0IYFXOiYKObcbLkw/km/HoAoQVtADtElUz8c1u3KB1nrGbHKw
         A3c7Mtum517ibpFa4hfIjqT0tjpefeG64xBvjNmjMwumpX4OMZ1fbeagOYmjPWaA95Ka
         9E7w==
X-Gm-Message-State: APjAAAXLBxuCOQ2XTNV3p8GJFQJtkyLzzLkI8K2QSjUgjlTlcbZsBWAr
        3M51HoOMUoVx7SH6HNoctKEfd6kAMDSCLApgAME=
X-Google-Smtp-Source: APXvYqyCYK0dOI+H2F4Q0CNJNe1MfTsCf3c6o9QICE8GfKRLMyVhO8zBnfaDp14Mv/e2wZsL6j2D6C6FkDxHaG8rCBo=
X-Received: by 2002:a9d:6a16:: with SMTP id g22mr789647otn.118.1568756659913;
 Tue, 17 Sep 2019 14:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000044408c0592b00ff5@google.com>
In-Reply-To: <00000000000044408c0592b00ff5@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Sep 2019 23:44:08 +0200
Message-ID: <CAJZ5v0j5-Jg8Wi_hEfM3DhzmY3sEwmrFjC2bTjyGgZ2afOKBEQ@mail.gmail.com>
Subject: Re: KASAN: global-out-of-bounds Read in __pm_runtime_resume
To:     syzbot <syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 16, 2019 at 8:49 PM syzbot
<syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=10efb5fa600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> dashboard link: https://syzkaller.appspot.com/bug?extid=cd157359d82e8d98c17b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: global-out-of-bounds in __pm_runtime_resume+0x162/0x180
> drivers/base/power/runtime.c:1069

This means that the caller of __pm_runtime_resume() did something odd.

> Read of size 1 at addr ffffffff863d87b1 by task syz-executor.2/13622
>
> CPU: 0 PID: 13622 Comm: syz-executor.2 Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:618
>   __pm_runtime_resume+0x162/0x180 drivers/base/power/runtime.c:1069
>   pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
>   usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1709
>   usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234

In this particular case usbhid_power() probably shouldn't have called
pm_runtime_get_sync() or it shouldn't have been called itself or
similar.

>   hid_hw_power include/linux/hid.h:1038 [inline]
>   hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
>   chrdev_open+0x219/0x5c0 fs/char_dev.c:414
>   do_dentry_open+0x494/0x1120 fs/open.c:797
>   do_last fs/namei.c:3416 [inline]
>   path_openat+0x1430/0x3f50 fs/namei.c:3533
>   do_filp_open+0x1a1/0x280 fs/namei.c:3563
>   do_sys_open+0x3c0/0x580 fs/open.c:1089
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4137d1
> Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48
> 83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48
> 89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007faea59927a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00000000004137d1
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007faea5992850
> RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007faea59936d4
> R13: 00000000004c8cbf R14: 00000000004dfc90 R15: 00000000ffffffff
>
> The buggy address belongs to the variable:
>   __param_str_xfer_debug+0x91/0x4a0
>
> Memory state around the buggy address:
>   ffffffff863d8680: fa fa fa fa 00 00 00 02 fa fa fa fa 00 00 00 00
>   ffffffff863d8700: fa fa fa fa 00 00 00 02 fa fa fa fa 00 07 fa fa
> > ffffffff863d8780: fa fa fa fa 00 00 fa fa fa fa fa fa 00 00 07 fa
>                                       ^
>   ffffffff863d8800: fa fa fa fa 00 00 00 00 00 00 fa fa fa fa fa fa
>   ffffffff863d8880: 00 07 fa fa fa fa fa fa 00 00 06 fa fa fa fa fa
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
