Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CEB33AC06
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 08:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCOHIa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 03:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCOHIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Mar 2021 03:08:18 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382B5C06175F
        for <linux-pm@vger.kernel.org>; Mon, 15 Mar 2021 00:08:18 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id n24so531968qkh.9
        for <linux-pm@vger.kernel.org>; Mon, 15 Mar 2021 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1GxjtXWQ8Nd14Ufajvp9SrNLduuTL53iMB054m6SMU=;
        b=KEfEimh9dM40dA1zZafls3aEw+6Z07Yeu8m0VER2zVSQf/g+ZdGfbpwTONCcaryh0I
         FxiKGjb5SN/PwQgNlOQhVfj77ghs+eLASxkOcV7UOLAdmovzABqBKqgH0jhI7jbltUi1
         c4Be37SegG3QuYntNXwlJLIXGI9J2+4hsJMEQd12b3HqazuEUTXsM6Qiuvi4OZYR4ui5
         GGN11/mNAfAuAKXExg6aCwWSH5DTMJjrpeinJH0qoUJqcyNemoCKSFiVpV3p7Yc+hB4d
         /JcfCp8mwyM3L5m+S5sl0KfAwoBJkos3a0/Zn06ZFCw4SymtYo0ZZKhRw/ehQzo2h8aA
         jmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1GxjtXWQ8Nd14Ufajvp9SrNLduuTL53iMB054m6SMU=;
        b=nyQp9An8QQu8Flqm92T5LkaK1s3Aw/RdtRNlUZiUlOgUjCm0MR3Cs09YMGsxST3d+q
         YWz7/QqbolibBFH6Goc/64p61JNE2RSYbBUqqJRo8bPdQLKQQkSfR/qSlXzht/c6Jto3
         lnv8na4JlHHyK/d1N434TU9zhwMXNpQyBEjVmAaa2C5v9QOEIAlbRoGcSz9tD1+lwkh3
         hui9WSdvfQu5cdUBjiIEM2uvGHB4MOSA0CCo4nDuEdIryuYPQyNE/cILGtBSt3UScERq
         4JwwfjdXcek3fB2QltrQGAOaKsWz8dqXuLoNTuWk+LfaDSDOzIoj9bcXOtlTfuWU7aDr
         9QjA==
X-Gm-Message-State: AOAM533//2tKWGE45Qo5Ujg2k1IwgMeWkpcyJMmIKhPOGblehP3HcNkG
        HpnssIWoCC7pBG2PgBg1YxCHX7C2d1dW6AtQTktE2w==
X-Google-Smtp-Source: ABdhPJzzlYdgJ5mNQKGOstXrhtgxu9pIahAYDwuPGSbJop4bjD1+f0J9srYU7t/DkE5Dg3r8vxl5larrmU0tnBhBwuE=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr24039751qko.424.1615792097213;
 Mon, 15 Mar 2021 00:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009c21de05ba6849e7@google.com>
In-Reply-To: <0000000000009c21de05ba6849e7@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 08:08:06 +0100
Message-ID: <CACT4Y+ZjVc+_fg+Ggx8zRWSGqzf4gmZcngBXLf_R4F-GKU4a9A@mail.gmail.com>
Subject: Re: kernel BUG in memory_bm_free
To:     syzbot <syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 3, 2021 at 6:59 AM syzbot
<syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3aaf0a27 Merge tag 'clang-format-for-linux-v5.11-rc7' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ef6108d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=10152c2ea16351e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=5ecbe63baca437585bd4
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com

The BUG is:
BUG_ON(!virt_addr_valid(addr));

#syz fix: arm64: Do not pass tagged addresses to __is_lm_address()

> ------------[ cut here ]------------
> kernel BUG at kernel/power/snapshot.c:257!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 2394 Comm: syz-executor.0 Not tainted 5.11.0-rc6-syzkaller-00055-g3aaf0a27ffc2 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 20400009 (nzCv daif +PAN -UAO -TCO BTYPE=--)
> pc : free_image_page kernel/power/snapshot.c:257 [inline]
> pc : free_image_page kernel/power/snapshot.c:253 [inline]
> pc : free_list_of_pages kernel/power/snapshot.c:274 [inline]
> pc : memory_bm_free+0x260/0x320 kernel/power/snapshot.c:726
> lr : free_basic_memory_bitmaps+0x3c/0x90 kernel/power/snapshot.c:1173
> sp : ffff8000163dbc50
> x29: ffff8000163dbc50 x28: f4ff000025204070
> x27: ffff800012d4c000 x26: f4ff000025204008
> x25: f5ff00002827c700 x24: ffff800012d4c000
> x23: 00007fffffffffff x22: f4ff000025204018
> x21: 0000000000000001 x20: ffff800013b576d0
> x19: f5ff00002827c700 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000000 x14: 0000000000000000
> x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000
> x9 : fcff000025205400 x8 : 0000000000000002
> x7 : f6ff000025205000 x6 : 00000000000001ff
> x5 : 0000000000000000 x4 : 0000000000000000
> x3 : ffff800013b576d0 x2 : f4ff00002517e000
> x1 : 0000000000000001 x0 : 0b0000002517e000
> Call trace:
>  free_image_page kernel/power/snapshot.c:257 [inline]
>  free_list_of_pages kernel/power/snapshot.c:274 [inline]
>  memory_bm_free+0x260/0x320 kernel/power/snapshot.c:726
>  free_basic_memory_bitmaps+0x3c/0x90 kernel/power/snapshot.c:1173
>  snapshot_release+0x74/0x90 kernel/power/user.c:120
>  __fput+0x78/0x230 fs/file_table.c:280
>  ____fput+0x10/0x20 fs/file_table.c:313
>  task_work_run+0x80/0x160 kernel/task_work.c:140
>  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>  do_notify_resume+0x20c/0x13e0 arch/arm64/kernel/signal.c:939
>  work_pending+0xc/0x3d4
> Code: cb000260 d34cfc00 97fcf6fe 35fffc20 (d4210000)
> ---[ end trace 174c294156b0dfb3 ]---
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
