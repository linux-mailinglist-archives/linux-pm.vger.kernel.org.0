Return-Path: <linux-pm+bounces-16978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB14F9BBB3C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520F5B223D3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288E1C4A01;
	Mon,  4 Nov 2024 17:13:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7751C3054
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740415; cv=none; b=QfE9KI6GQlT2MlBJAQIQGnxSsWRhztIDOzubAFH3ZfqcsMVzIMhot3ePrVXGMwHVeSqUPhiJ1/tSkBIAeITIflFSJz0BjwAKRWwpb/1k0f+pHVX+w3qKt+FLcKaPH+9of70hY9Aj8enuz5ENrux0Vk62m2/InV+9rudH8LgMrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740415; c=relaxed/simple;
	bh=G8Ku4+gnMNQxGjwnwfpFle0PN06wg5ZR1TJLyaP3EEw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Jy6dSGXe9ezM6bX9p7jc3Ew9Z08ZPHyhdCnj1OXeh5lEMBQMnHpKA51WtiSnEdYHRHvSOo1eS5SB0bdy3Vhlo2R5c453kfeLrV4wRf2olRgWgYHAvrUWU9AqhceQeCEaXRU/Uo2UWg43z+lAU6vjGVLUiyurkZtrbkQNtmNPI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so48222755ab.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 09:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740413; x=1731345213;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oz2AZID5JvkC+uYPtICCB0YgXhCUefbGhxCMrWVQg6A=;
        b=ThdaFvVEQRogbanOIulgIydLkF5X4ju9OBAMnX6wXPnk7xUoyzkvTpeHuDXo4K1V9O
         bNx5WZa9KPHTEhdyKcuiGDneuQ4L9mFeVsnnwBjFUfbMRD4mRzqeJsfaK2R2qiTJ7UWY
         rFltui9YXClbNahnbwQRXaAqwrCbdcMTdHB+Zlk1wdGghly1kkE5iSGzmLxk40h5+SSH
         78NLNHvCrCgr+6KJ+wSBtayz+7spL7Qbq4r+mjo9nLEQyZGq/xR2O9FOaOrUJJO8GheF
         smfcBPk283HR6RcFBJ65ThRQm1y1m0/ts1GGjJ2LGqstnjmuMFCK/2YfoBmYSeXrgbXp
         8rHA==
X-Forwarded-Encrypted: i=1; AJvYcCXQwkmKDTY6+sNvWKybpbGmwZKuCMkkLSQJyCcDCsmsJZyq4H8nfSwB0kZ2uGfMZ8x0UdVbDBt9ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4e7ykNBOmezzyH18CvUSdQcyKoRd59MEwQTkZvfEc8EobSy66
	Vx6+27J5GLL01em/jFhIxQ4YU7J7zcFmtwALhEACGEQphZFZ/+Y6Mkcvhm6mhC/YTivEAADI0KR
	WKeDaP02j64fidY2cYCwcndcKa0cFSJ9O1wOtZxMQzKxv8PP+31eBCvQ=
X-Google-Smtp-Source: AGHT+IHt35m5zRDXKTreY+nYM02FF50L60osu4Bux0ACgDHGdDRStRM5pw1ygZ9Kf9LLM+bBDLsEsV0uL3pwsUiOANcX9Z9ViHdz
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cd:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a6b02cf8edmr134955305ab.10.1730740412962; Mon, 04 Nov 2024
 09:13:32 -0800 (PST)
Date: Mon, 04 Nov 2024 09:13:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672900bc.050a0220.701a.000e.GAE@google.com>
Subject: [syzbot] [pm?] INFO: trying to register non-static key in
 netdev_unregister_kobject (2)
From: syzbot <syzbot+70bd31b69512b90375b6@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, pavel@ucw.cz, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    157a4881225b Merge branch 'add-ethernet-dts-schema-for-qcs..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=108ca630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a3b9ec43446307a
dashboard link: https://syzkaller.appspot.com/bug?extid=70bd31b69512b90375b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b088f73cb031/disk-157a4881.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dadddc2fd943/vmlinux-157a4881.xz
kernel image: https://storage.googleapis.com/syzbot-assets/941f3e9fcf4e/bzImage-157a4881.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+70bd31b69512b90375b6@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 15994 Comm: kbnepd bnep0 Not tainted 6.12.0-rc4-syzkaller-01012-g157a4881225b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 assign_lock_key+0x241/0x280 kernel/locking/lockdep.c:981
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1295
 __lock_acquire+0xf0/0x2050 kernel/locking/lockdep.c:5077
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:376 [inline]
 pm_runtime_set_memalloc_noio+0x13d/0x260 drivers/base/power/runtime.c:228
 netdev_unregister_kobject+0x178/0x250 net/core/net-sysfs.c:2109
 unregister_netdevice_many_notify+0x1859/0x1da0 net/core/dev.c:11513
 unregister_netdevice_many net/core/dev.c:11541 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11413
 unregister_netdevice include/linux/netdevice.h:3175 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11559
 bnep_session+0x2e0e/0x3000 net/bluetooth/bnep/core.c:525
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

