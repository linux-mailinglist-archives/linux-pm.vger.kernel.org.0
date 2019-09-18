Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF1AB6201
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 13:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfIRLEb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 07:04:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34138 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfIRLEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 07:04:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so3866233pgc.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 04:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSDsY/hDm2eeYEnq9WTa9wXPHp0ZxF/gk9i7RQwPo3g=;
        b=NiK+MLkaMkniiMcmS86T3kt+8oQbT16PG8Q90AyR+2mPy/omovQc1hSJ+vwDJgaBiX
         oVav6do24xQQ5hQxLaZFtOazYcByGF3qYemyfsUtySy4V3Hmeq/agngv9HWfas62s6En
         4MAIDY5jX7eYGuTyetX+jR6wbBtgRUup+ClfT0iaXl4ELRGaKIMtuffafuFJOkcXEAz9
         XUuFWwJZEoXmzPEqKEiQ6wDSKkVUekPtFmQAJ0uV8H0wOG5u/R7fww907Aa5jl/Wd3hT
         6ouQoA58hep+orkHOdq1dQ9QvrbUd7+fQFXlsXLoonVjLS8WycjAX24w73ey/1r6Mrxz
         vupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSDsY/hDm2eeYEnq9WTa9wXPHp0ZxF/gk9i7RQwPo3g=;
        b=dQB9+zIajEAQ/dFPKUOMyBGCEpSWtjad0pLROPTi3MswY+lC5NbLB8ftfdlJVMcYrK
         CXAQwkOkfRpRkdSYHU3pe9q66HxzXWw+NyMfO5cduE9vuAZhwfCgvSWkAaOOWw7oIg4c
         uX6/KiQ7f7yciT8AQzdv1Tmjn7E7EvMdfW1sLgT1dLJrBV69HeCryMqKFo4/XG+kmyQb
         zvJ/M0GbZeF8B/qhiE6uwMW3swZyxJCOvjLRjmJOqOPH+VCk+Q2pxaNSJcxRLGyiWmYt
         dnlmz/CUOvrIpzIA3oLPul0gFCBsTVpcppMItdD0TD+DFoQgzPefy2IBlpMy2zw7zJaR
         T2fg==
X-Gm-Message-State: APjAAAUYtdEeCQ15craVwEsQd33T2PJZdbFFPBjJWwcK9GSS79hgYEKR
        ipCGeRypImtQLv3BNrSNM92TLYAsmekFChdX7BnVeg==
X-Google-Smtp-Source: APXvYqxfkV9EERZ0pfDrC6A7v4+K7jWGyBCkUR+CMb+w5uGlu3/Gqyg3ntbKCMmM+RZc3cAsVQbfEjsBxL2fmasjsTA=
X-Received: by 2002:aa7:8bcc:: with SMTP id s12mr3451353pfd.93.1568804670111;
 Wed, 18 Sep 2019 04:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000044408c0592b00ff5@google.com> <CAJZ5v0j5-Jg8Wi_hEfM3DhzmY3sEwmrFjC2bTjyGgZ2afOKBEQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j5-Jg8Wi_hEfM3DhzmY3sEwmrFjC2bTjyGgZ2afOKBEQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 18 Sep 2019 13:04:18 +0200
Message-ID: <CAAeHK+xrFhG=Lirn_hPboH98EFCToyD0cWMJqRmAewgDLUo_6A@mail.gmail.com>
Subject: Re: KASAN: global-out-of-bounds Read in __pm_runtime_resume
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     syzbot <syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com>,
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

On Tue, Sep 17, 2019 at 11:44 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Sep 16, 2019 at 8:49 PM syzbot
> <syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10efb5fa600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cd157359d82e8d98c17b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+cd157359d82e8d98c17b@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: global-out-of-bounds in __pm_runtime_resume+0x162/0x180
> > drivers/base/power/runtime.c:1069
>
> This means that the caller of __pm_runtime_resume() did something odd.
>
> > Read of size 1 at addr ffffffff863d87b1 by task syz-executor.2/13622
> >
> > CPU: 0 PID: 13622 Comm: syz-executor.2 Not tainted 5.3.0-rc7+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   print_address_description+0x6a/0x32c mm/kasan/report.c:351
> >   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
> >   kasan_report+0xe/0x12 mm/kasan/common.c:618
> >   __pm_runtime_resume+0x162/0x180 drivers/base/power/runtime.c:1069
> >   pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
> >   usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1709
> >   usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234
>
> In this particular case usbhid_power() probably shouldn't have called
> pm_runtime_get_sync() or it shouldn't have been called itself or
> similar.

Hi Rafael,

This report is caused by a major memory corruption that can lead to
all kinds of weird things. Let's wait for the fix to be in the
mainline and then see if these bugs are still occurring.

Thanks!

>
> >   hid_hw_power include/linux/hid.h:1038 [inline]
> >   hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
> >   chrdev_open+0x219/0x5c0 fs/char_dev.c:414
> >   do_dentry_open+0x494/0x1120 fs/open.c:797
> >   do_last fs/namei.c:3416 [inline]
> >   path_openat+0x1430/0x3f50 fs/namei.c:3533
> >   do_filp_open+0x1a1/0x280 fs/namei.c:3563
> >   do_sys_open+0x3c0/0x580 fs/open.c:1089
> >   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x4137d1
> > Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48
> > 83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48
> > 89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
> > RSP: 002b:00007faea59927a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> > RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00000000004137d1
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007faea5992850
> > RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000293 R12: 00007faea59936d4
> > R13: 00000000004c8cbf R14: 00000000004dfc90 R15: 00000000ffffffff
> >
> > The buggy address belongs to the variable:
> >   __param_str_xfer_debug+0x91/0x4a0
> >
> > Memory state around the buggy address:
> >   ffffffff863d8680: fa fa fa fa 00 00 00 02 fa fa fa fa 00 00 00 00
> >   ffffffff863d8700: fa fa fa fa 00 00 00 02 fa fa fa fa 00 07 fa fa
> > > ffffffff863d8780: fa fa fa fa 00 00 fa fa fa fa fa fa 00 00 07 fa
> >                                       ^
> >   ffffffff863d8800: fa fa fa fa 00 00 00 00 00 00 fa fa fa fa fa fa
> >   ffffffff863d8880: 00 07 fa fa fa fa fa fa 00 00 06 fa fa fa fa fa
> > ==================================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
