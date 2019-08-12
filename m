Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167C789E6D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfHLMc0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 08:32:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38653 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfHLMcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 08:32:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so4278699pfg.5
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvTdbRjaEW3UrnRu3vY1zSLb0Sex69k/AMIh01pDgys=;
        b=uw8AWp11fDPrgvIdRenk9JPjafF1eJeFY12qfIl+CtHpJ82MZ2HLpodOljXylrrDNu
         /n6wOTwBagb7qTyIaxC/iM+sKncsvCNw7wy0M0ZPTBOWOMHbfb+XqKiEuV08io0zo2gR
         0a52DtahhLcE5LgLGY4WVg7u2snezlzhEBcisCLraYXYWd8mGHVbrsTJCjkXil44/rRo
         kaoo0qOrjUT/d9wjWd07rZ48cEQhosVqWrhBxiYjq82jEDUpqRjQSRMH6vPdSv0T7lhZ
         gO2oWjwn6c+fWn+UqOqIJ6JK5/NCV7OlsPyW9fUkND/JHMr0NKLAKmu+eJxWODZ9OI0G
         acWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvTdbRjaEW3UrnRu3vY1zSLb0Sex69k/AMIh01pDgys=;
        b=onTakXuv3NBL+hz2aNnWEgHJxR6ng7mAJPAshU4SrTgfGjQqJIG7L557dt5tUISZot
         GG2yvmH4FRNipIfxOZXr99qKlPdUPAMcP7Hf97MYEUuXQcRODm9h+NSgqMD1kN5/15/l
         vK6EZRPPI8ztUdNbEM0S4AvGzRcjpCI3XOZT7ox2+o0mdXPmM/IxzldArFXj5HwpTiK2
         gjuZgLd6xH+m3pVPXgQ/YJAJ+S3ZhqCysSEMU7LE57ITC5HXu+Z+MYhRrFuDfRiz5c3L
         ZsK0gasHp1x6FySdzdW2lVGuLpc3OL3I3sXq535OCpiXvy2fS44wIJK54+DqxIoejk4S
         IJSw==
X-Gm-Message-State: APjAAAXhgCshE6maGWPsTAB5Vz9tGipH72HnT/gl+3srslPTszKKbWjK
        crp281LFIm+Pmp8jU438IIXJKlReDciW6tzcNA2vGQ==
X-Google-Smtp-Source: APXvYqyab+2lpXjAFZAlZOQ6Ym9sgCUA1ZBAJn1epTN9hBZr2MJlnQKUOo1XV4OpsiQGhRubcEjFsqeqRK66sKPZVZs=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr29838015pgq.130.1565613144555;
 Mon, 12 Aug 2019 05:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003acc06058e6d6b70@google.com> <000000000000e80c0e058e7a5a31@google.com>
In-Reply-To: <000000000000e80c0e058e7a5a31@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 12 Aug 2019 14:32:13 +0200
Message-ID: <CAAeHK+wnqRzpUDfspoXPVw76bAbrZ49JiwkeTj-g3U9zqLjZRg@mail.gmail.com>
Subject: Re: general protection fault in __pm_runtime_resume
To:     syzbot <syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: multipart/mixed; boundary="00000000000056dee3058feab79d"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--00000000000056dee3058feab79d
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 25, 2019 at 7:04 AM syzbot
<syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=108edb68600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> dashboard link: https://syzkaller.appspot.com/bug?extid=3cbe5cd105d2ad56a1df
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f0b4c8600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172d8758600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 1740 Comm: syz-executor618 Not tainted 5.2.0-rc6+ #15
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__pm_runtime_resume+0x49/0x180 drivers/base/power/runtime.c:1069
> Code: ed 74 d5 fe 45 85 ed 0f 85 9a 00 00 00 e8 6f 73 d5 fe 48 8d bd c1 02
> 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48
> 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 fe 00 00 00
> RSP: 0018:ffff8881cf5878e0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000020 RCX: ffffffff82676833
> RDX: 000000021d463be5 RSI: ffffffff82676841 RDI: 00000010ea31df2b
> RBP: 00000010ea31dc6a R08: ffff8881d1b7e000 R09: fffffbfff0e84c25
> R10: ffff8881cf587940 R11: ffffffff87426127 R12: 0000000000000004
> R13: 0000000000000000 R14: ffff8881cfd7a500 R15: ffffffff897f9040
> FS:  0000555555808880(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043f760 CR3: 00000001d0f29000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
>   usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1707
>   usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234
>   hid_hw_power include/linux/hid.h:1038 [inline]
>   hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
>   chrdev_open+0x219/0x5c0 fs/char_dev.c:413
>   do_dentry_open+0x497/0x1040 fs/open.c:778
>   do_last fs/namei.c:3416 [inline]
>   path_openat+0x1430/0x3ff0 fs/namei.c:3533
>   do_filp_open+0x1a1/0x280 fs/namei.c:3563
>   do_sys_open+0x3c0/0x580 fs/open.c:1070
>   do_syscall_64+0xb7/0x560 arch/x86/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x401ad0
> Code: 01 f0 ff ff 0f 83 c0 0b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> 44 00 00 83 3d fd 5b 2d 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 94 0b 00 00 c3 48 83 ec 08 e8 fa 00 00 00
> RSP: 002b:00007ffed8d15738 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000401ad0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffed8d15740
> RBP: 6666666666666667 R08: 000000000000000f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402af0
> R13: 0000000000402b80 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 60987a9feed42828 ]---
> RIP: 0010:__pm_runtime_resume+0x49/0x180 drivers/base/power/runtime.c:1069
> Code: ed 74 d5 fe 45 85 ed 0f 85 9a 00 00 00 e8 6f 73 d5 fe 48 8d bd c1 02
> 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48
> 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 fe 00 00 00
> RSP: 0018:ffff8881cf5878e0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000020 RCX: ffffffff82676833
> RDX: 000000021d463be5 RSI: ffffffff82676841 RDI: 00000010ea31df2b
> RBP: 00000010ea31dc6a R08: ffff8881d1b7e000 R09: fffffbfff0e84c25
> R10: ffff8881cf587940 R11: ffffffff87426127 R12: 0000000000000004
> R13: 0000000000000000 R14: ffff8881cfd7a500 R15: ffffffff897f9040
> FS:  0000555555808880(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043f760 CR3: 00000001d0f29000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>

Let's try Hillf's patch here as well:

#syz test: https://github.com/google/kasan.git 6a3599ce

--00000000000056dee3058feab79d
Content-Type: application/x-patch; name="hid-core.patch"
Content-Disposition: attachment; filename="hid-core.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jz8dm6mt0>
X-Attachment-Id: f_jz8dm6mt0

LS0tIGEvZHJpdmVycy9oaWQvdXNiaGlkL2hpZC1jb3JlLmMKKysrIGIvZHJpdmVycy9oaWQvdXNi
aGlkL2hpZC1jb3JlLmMKQEAgLTE0MTAsNiArMTQxMCw3IEBAIHN0YXRpYyB2b2lkIHVzYmhpZF9k
aXNjb25uZWN0KHN0cnVjdCB1c2IKIAlzcGluX2xvY2tfaXJxKCZ1c2JoaWQtPmxvY2spOwkvKiBT
eW5jIHdpdGggZXJyb3IgYW5kIGxlZCBoYW5kbGVycyAqLwogCXNldF9iaXQoSElEX0RJU0NPTk5F
Q1RFRCwgJnVzYmhpZC0+aW9mbCk7CiAJc3Bpbl91bmxvY2tfaXJxKCZ1c2JoaWQtPmxvY2spOwor
CWhpZF9od19zdG9wKGhpZCk7CiAJaGlkX2Rlc3Ryb3lfZGV2aWNlKGhpZCk7CiAJa2ZyZWUodXNi
aGlkKTsKIH0K
--00000000000056dee3058feab79d--
