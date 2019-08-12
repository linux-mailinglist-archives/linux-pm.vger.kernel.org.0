Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC178A111
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 16:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfHLO16 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 10:27:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32931 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfHLO15 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 10:27:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so8762642pgn.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ey5t6Z7+NFJy49eO7tTR7Aiye6/bMn8cHyeq52BlSSc=;
        b=Yw+0SxQno/EStVztJgzclFL24slqtlNeGgggZrxqYnwJuIcXwWUZ097tFpDzznEdtD
         sxI+1zP2MtVNXNRa9aERisjZjjovMIkNBIF3tShcDx8N3IHlYfzaVazudG5oMynTIql2
         L0Sd3EMmsbqAwXpyP9wyqEqtKcpnajBw8nF2NVrpvhoM5AwUbx0ytzval/TxbUlUghqi
         adFyZKD7BVMXb+5+U5xpGxfLg32RvFh9SRPELB6tOBxcclUiq2k0Nkihc/MWQJGYeBC2
         SwIpddxqMvWQI976EFFWBMnp1WTpxEjUQvMXTdnuMsvdGUtevCBOHsnN6kI5J2sbL2BH
         +6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ey5t6Z7+NFJy49eO7tTR7Aiye6/bMn8cHyeq52BlSSc=;
        b=d3S8oidrJUV77OpkTBJDSVfEClI5wNPKTLZZRRsaCLT7EAGA8i8cvDIFVk27WV2MGR
         tCqI/LyWtfuQam4BeO+GPMKbunntB8w4DmE2LLooKeX3ukP1CJxo8+4RnR0XKpdQFWt9
         9aqnUWF48qOtX89ORXrB6WsEeDWRkK+oEy2IHZAxBrtOedF17IPIWtjt5MkNeu9ah8JQ
         z+EwqXGdDgEHNr4/vl3OXFT2NpL0iwrH9NYQjS5vTgxDNCUptVnFPmlLIhD4EaFlueAl
         VPWiB6kkdEjDUJWHxET668GEYr/pLgzKFZtDb7TKMsLOTvvC9ReQyA7Zp2UE8AxE6DD6
         SVsA==
X-Gm-Message-State: APjAAAWEhPmtG2u4FdRARpeqL4HLHb8P7K/nyGclJWRviKarZd5vvMOP
        Vso/Ova+u7EiwfLpamzFFvgPIL+hMzJHjCSHavEokGKThNel4A==
X-Google-Smtp-Source: APXvYqxLcE1zsWsJPDnJEQe/jyc643JTMt6PtTFANULGnHA4bGrUmYbS7DJFrP+O/VYPI8hIzOetLJt2+6vBvqG/jT0=
X-Received: by 2002:aa7:9e9a:: with SMTP id p26mr36630927pfq.25.1565620076692;
 Mon, 12 Aug 2019 07:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+x2n11zWO7yC1zWz45d_2qJTFW=ODZ-1bxSGpn5BuVuGA@mail.gmail.com>
 <000000000000563ccb058fec51a5@google.com>
In-Reply-To: <000000000000563ccb058fec51a5@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 12 Aug 2019 16:27:45 +0200
Message-ID: <CAAeHK+xW2QLj3g1PkxXfqSUoDPeSc9YWLKfPrJ9CiSnDpSdcLg@mail.gmail.com>
Subject: Re: Re: KASAN: use-after-free Read in __pm_runtime_resume
To:     syzbot <syzbot+b156665cf4d1b5e00c76@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>, len.brown@intel.com,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        USB list <linux-usb@vger.kernel.org>, rjw@rjwysocki.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 4:27 PM syzbot
<syzbot+b156665cf4d1b5e00c76@syzkaller.appspotmail.com> wrote:
>
> > On Sat, Aug 3, 2019 at 11:12 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> >> On Fri, 02 Aug 2019 05:58:05 -0700
> >> > Hello,
> >> >
> >> > syzbot found the following crash on:
> >> >
> >> > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> >> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> >> > console output:
> >> https://syzkaller.appspot.com/x/log.txt?x=146071b4600000
> >> > kernel config:
> >> https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> >> > dashboard link:
> >> https://syzkaller.appspot.com/bug?extid=b156665cf4d1b5e00c76
> >> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >> >
> >> > Unfortunately, I don't have any reproducer for this crash yet.
> >> >
> >> > IMPORTANT: if you fix the bug, please add the following tag to the
> >> commit:
> >> > Reported-by: syzbot+b156665cf4d1b5e00c76@syzkaller.appspotmail.com
> >> >
> >> > ==================================================================
> >> > BUG: KASAN: use-after-free in __pm_runtime_resume+0x162/0x180
> >> > drivers/base/power/runtime.c:1069
> >> > Read of size 1 at addr ffff8881c775b671 by task syz-executor.4/5918
> >> >
> >> > CPU: 1 PID: 5918 Comm: syz-executor.4 Not tainted 5.3.0-rc2+ #24
> >> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> > Google 01/01/2011
> >> > Call Trace:
> >> >   __dump_stack lib/dump_stack.c:77 [inline]
> >> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >> >   print_address_description+0x6a/0x32c mm/kasan/report.c:351
> >> >   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
> >> >   kasan_report+0xe/0x12 mm/kasan/common.c:612
> >> >   __pm_runtime_resume+0x162/0x180 drivers/base/power/runtime.c:1069
> >> >   pm_runtime_get_sync include/linux/pm_runtime.h:226 [inline]
> >> >   usb_autopm_get_interface+0x1b/0x50 drivers/usb/core/driver.c:1707
> >> >   usbhid_power+0x7c/0xe0 drivers/hid/usbhid/hid-core.c:1234
> >> >   hid_hw_power include/linux/hid.h:1038 [inline]
> >> >   hidraw_open+0x20d/0x740 drivers/hid/hidraw.c:282
> >> >   chrdev_open+0x219/0x5c0 fs/char_dev.c:414
> >> >   do_dentry_open+0x494/0x1120 fs/open.c:797
> >> >   do_last fs/namei.c:3416 [inline]
> >> >   path_openat+0x1430/0x3f50 fs/namei.c:3533
> >> >   do_filp_open+0x1a1/0x280 fs/namei.c:3563
> >> >   do_sys_open+0x3c0/0x580 fs/open.c:1089
> >> >   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
> >> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >> > RIP: 0033:0x413711
> >> > Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00
> >> c3 48
> >> > 83 ec 08 e8 0a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24
> >> 48
> >> > 89 c2 e8 53 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
> >> > RSP: 002b:00007fa3309ef7a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> >> > RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000413711
> >> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fa3309ef850
> >> > RBP: 000000000075bf20 R08: 000000000000000f R09: 0000000000000000
> >> > R10: ffffffffffffffff R11: 0000000000000293 R12: 00007fa3309f06d4
> >> > R13: 00000000004c8c02 R14: 00000000004dfa80 R15: 00000000ffffffff
> >> >
> >> > Allocated by task 103:
> >> >   save_stack+0x1b/0x80 mm/kasan/common.c:69
> >> >   set_track mm/kasan/common.c:77 [inline]
> >> >   __kasan_kmalloc mm/kasan/common.c:487 [inline]
> >> >   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
> >> >   kmalloc include/linux/slab.h:552 [inline]
> >> >   kzalloc include/linux/slab.h:748 [inline]
> >> >   usb_set_configuration+0x2c4/0x1670 drivers/usb/core/message.c:1846
> >> >   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >> >   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >> >   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
> >> >   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
> >> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >> >   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
> >> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >> >   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >> >   kthread+0x318/0x420 kernel/kthread.c:255
> >> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >> >
> >> > Freed by task 103:
> >> >   save_stack+0x1b/0x80 mm/kasan/common.c:69
> >> >   set_track mm/kasan/common.c:77 [inline]
> >> >   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
> >> >   slab_free_hook mm/slub.c:1423 [inline]
> >> >   slab_free_freelist_hook mm/slub.c:1470 [inline]
> >> >   slab_free mm/slub.c:3012 [inline]
> >> >   kfree+0xe4/0x2f0 mm/slub.c:3953
> >> >   device_release+0x71/0x200 drivers/base/core.c:1064
> >> >   kobject_cleanup lib/kobject.c:693 [inline]
> >> >   kobject_release lib/kobject.c:722 [inline]
> >> >   kref_put include/linux/kref.h:65 [inline]
> >> >   kobject_put+0x171/0x280 lib/kobject.c:739
> >> >   put_device+0x1b/0x30 drivers/base/core.c:2213
> >> >   usb_disable_device+0x2ce/0x690 drivers/usb/core/message.c:1244
> >> >   usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
> >> >   hub_port_connect drivers/usb/core/hub.c:4949 [inline]
> >> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >> >   hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
> >> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >> >   process_scheduled_works kernel/workqueue.c:2331 [inline]
> >> >   worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
> >> >   kthread+0x318/0x420 kernel/kthread.c:255
> >> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >> >
> >> > The buggy address belongs to the object at ffff8881c775b300
> >> >   which belongs to the cache kmalloc-2k of size 2048
> >> > The buggy address is located 881 bytes inside of
> >> >   2048-byte region [ffff8881c775b300, ffff8881c775bb00)
> >> > The buggy address belongs to the page:
> >> > page:ffffea00071dd600 refcount:1 mapcount:0 mapping:ffff8881da00c000
> >> > index:0x0 compound_mapcount: 0
> >> > flags: 0x200000000010200(slab|head)
> >> > raw: 0200000000010200 ffffea0007541a00 0000000300000003
> >> ffff8881da00c000
> >> > raw: 0000000000000000 00000000000f000f 00000001ffffffff
> >> 0000000000000000
> >> > page dumped because: kasan: bad access detected
> >> >
> >> > Memory state around the buggy address:
> >> >   ffff8881c775b500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> >   ffff8881c775b580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> > > ffff8881c775b600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> >                                                               ^
> >> >   ffff8881c775b680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> >   ffff8881c775b700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >> > ==================================================================
>
> >> --- a/drivers/hid/usbhid/hid-core.c
> >> +++ b/drivers/hid/usbhid/hid-core.c
> >> @@ -1410,6 +1410,7 @@ static void usbhid_disconnect(struct usb
> >>          spin_lock_irq(&usbhid->lock);   /* Sync with error and led
> >> handlers */
> >>          set_bit(HID_DISCONNECTED, &usbhid->iofl);
> >>          spin_unlock_irq(&usbhid->lock);
> >> +       hid_hw_stop(hid);
> >>          hid_destroy_device(hid);
> >>          kfree(usbhid);
> >>   }
> >> --
>
>
> > Hi Hillf,
>
> > Looks like your patch fixes the issue (one of the issues at least), as
> > tested on this report:
>
> > https://syzkaller.appspot.com/bug?extid=3cbe5cd105d2ad56a1df
>
> > I'm duping this bug to that one:
>
> > #syz dup: KASAN: use-after-free Read in __pm_runtime_resume
>
> Can't dup bug to itself.

Wrong name.

#syz dup: general protection fault in __pm_runtime_resume

>
>
> > Could you submit your patch?
>
> > Thanks!
