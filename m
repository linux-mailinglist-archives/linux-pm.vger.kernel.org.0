Return-Path: <linux-pm+bounces-14531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E60A97DFB7
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 03:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A34A1C20AA2
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 01:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA741917E7;
	Sun, 22 Sep 2024 01:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iD17Jsmn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0851917C4
	for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726967501; cv=none; b=lps+WtwCIIGrRVW0V4/orS8XzfHx+zajAqRW+cu1p7UAHV8C+NPLry0QT1b5ou4a7vbmkCh1QT6kJbE2t70GfgdZGfSufJ8I8uk7mlSBENgYq0kX4fnQEyP2fpoG3A2PlxZsbdRY5RVsDxzKuNof3XKbAQlRNTR43fZtd3W9Bhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726967501; c=relaxed/simple;
	bh=mkPZTZ4+7X6YfRtxtJvsGondZDr3cT+dPb4FafRwtlc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pfMYrF0towSWvckSoFD9QmcEmriZcMahv0MwVDbyNQYT7/bESxMf8Xlo8057F7FBOHuOuhnJ1VfuSDvzjFkKKBxnVO+Ebu2mKryUI4RPgCFShmXYR/f3JOO/Y6KLHffYDCVoBjPDbKHowWxVN6kZ3m/UAT+IPLKEayaK+IUE6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iD17Jsmn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so2811a12.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Sep 2024 18:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726967497; x=1727572297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2KUuVhA2iLT4DM8BXrMGBBR4oEH2j4WLFiTg/43RbgU=;
        b=iD17JsmnF63TWL61UBkCOk+f84qtZUYIeuK3yrghPIiJuXNAGzAu+g4RkSCi73pYXo
         0FjSJONUGguXFtJQ5zCrHDtsKMn9uEAJOLOHkGODSSoctFoiaEsZEJGoe3gViEc6KiZy
         QuG1r1z4wZX7k2T+OPk6JD9Dle/Wc1lP41GTML4fuivfbTOTCD5p0wYG4VUI/y9B7nJw
         clvC0PcsIY1mvkb0aKPTXAnFLaAvajFPyjfiW3yvvWcN3SIh4XxvGMJCmdvebjWJWntj
         ANIgfu9yycWFyuphNvDa+C4eYW65TL0Aa0VS1cpE9n4T4HBWWz360GD7mHRPoCCS3JRb
         XIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726967497; x=1727572297;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KUuVhA2iLT4DM8BXrMGBBR4oEH2j4WLFiTg/43RbgU=;
        b=aBwGdqFiaG5R6lBWjgpuxZevRZOBuzkAQ+2Zf5CAqSfvf6BCfahWu9u6DDBxmL/C90
         eHT2xypu0PeKXu1O+FyfScKs2IR5TlYKegRw1nkdZw8kUZkKFg3KVPEPs/tGz5HdL+5X
         PZJK1JFrJ7826KhEHiyqa61Ahhr6Yr503cxmO0Huds/5sBgNzdfShR4chsY8EQiBddKt
         8XlZOl/shA9eEe1+LTk8DXslV6EjO8xOrYIk8yTyfwu2Yb07pLIq7Y0L9xDOJyTrTzLG
         QTauOlAROX8jPcsowVLMs7rjAOz6/gsww13Hzt/PL7oIQzeZ1X6wrHhGxzGOz4llt7/+
         DfeA==
X-Gm-Message-State: AOJu0Ywiukwyyw751lPMSN1naMRvE4pMUqTZ5xiappQAjrlFWIpxadAw
	R4VEyRVo9Ei4nXneM9p56O26USK891fpc7F2v6Wt9/oo7UUEfHj5UwUvyaSphrl5WsOMXqpnb2a
	u7UbdvdPOHjPVNnJz4crf+o7nSu60lgEAVzM0
X-Google-Smtp-Source: AGHT+IGDmCMq0c04L7WDXF6pJrRZIraPcPIIO/dV9PrR/c2TmXM8wUqd7VfSgbRwDhKV1hUl4eLr7f40znDL+x9wu5o=
X-Received: by 2002:a05:6402:26c2:b0:5c4:6376:bb68 with SMTP id
 4fb4d7f45d1cf-5c5b846d1aemr39682a12.3.1726967496849; Sat, 21 Sep 2024
 18:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Sun, 22 Sep 2024 03:10:59 +0200
Message-ID: <CAG48ez1xYXWfvTy4N7Ut9MAs2+GGWNOwYgQb6zToRpJfQEacfg@mail.gmail.com>
Subject: lockdep detected circular locking between rtnl_mutex and
 pm_chain_head.rwsem [wireguard and r8152]
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-pm@vger.kernel.org, wireguard@lists.zx2c4.com, 
	Network Development <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

While trying out a kernel at commit
88264981f2082248e892a706b2c5004650faac54 (latest mainline) with
lockdep enabled, I hit a lockdep warning - it looks like wireguard
takes the rtnl_lock in a PM callback (meaning pm_chain_head.rwsem is
already held), while r8152 registers a PM callback in a context where
the rtnl_lock is held, and this makes lockdep unhappy. But I don't
know enough about the PM code to know which of those is the problem or
whether this race could even occur. I'm also not sure whether this is
a regression - I don't usually run lockdep kernels on this machine.


[ 1749.181131] PM: suspend entry (s2idle)
[ 1749.209736] Filesystems sync: 0.028 seconds

[ 1749.220240] ======================================================
[ 1749.220242] WARNING: possible circular locking dependency detected
[ 1749.220244] 6.11.0-slowkasan+ #140 Not tainted
[ 1749.220247] ------------------------------------------------------
[ 1749.220249] systemd-sleep/5239 is trying to acquire lock:
[ 1749.220252] ffffffffb1156c88 (rtnl_mutex){+.+.}-{3:3}, at:
wg_pm_notification (drivers/net/wireguard/device.c:81
drivers/net/wireguard/device.c:64)
[ 1749.220265]
but task is already holding lock:
[ 1749.220267] ffffffffb077e170 ((pm_chain_head).rwsem){++++}-{3:3},
at: blocking_notifier_call_chain_robust (kernel/notifier.c:128
kernel/notifier.c:353 kernel/notifier.c:341)
[ 1749.220277]
which lock already depends on the new lock.

[ 1749.220279]
the existing dependency chain (in reverse order) is:
[ 1749.220281]
-> #1 ((pm_chain_head).rwsem){++++}-{3:3}:
[ 1749.220287] down_write (./arch/x86/include/asm/preempt.h:79
kernel/locking/rwsem.c:1304 kernel/locking/rwsem.c:1315
kernel/locking/rwsem.c:1580)
[ 1749.220292] blocking_notifier_chain_register (kernel/notifier.c:272
kernel/notifier.c:290)
[ 1749.220295] rtl8152_open (drivers/net/usb/r8152.c:6994)
[ 1749.220300] __dev_open (net/core/dev.c:1476)
[ 1749.220304] __dev_change_flags (net/core/dev.c:8837)
[ 1749.220308] dev_change_flags (net/core/dev.c:8909)
[ 1749.220311] do_setlink (net/core/rtnetlink.c:2900)
[ 1749.220315] __rtnl_newlink (net/core/rtnetlink.c:3696)
[ 1749.220318] rtnl_newlink (net/core/rtnetlink.c:3744)
[ 1749.220322] rtnetlink_rcv_msg (net/core/rtnetlink.c:6646)
[ 1749.220325] netlink_rcv_skb (net/netlink/af_netlink.c:2550)
[ 1749.220329] netlink_unicast (net/netlink/af_netlink.c:1331
net/netlink/af_netlink.c:1357)
[ 1749.220332] netlink_sendmsg (net/netlink/af_netlink.c:1901)
[ 1749.220335] ____sys_sendmsg (net/socket.c:730 net/socket.c:745
net/socket.c:2603)
[ 1749.220339] ___sys_sendmsg (net/socket.c:2659)
[ 1749.220342] __sys_sendmsg (net/socket.c:2686)
[ 1749.220344] do_syscall_64 (arch/x86/entry/common.c:52
arch/x86/entry/common.c:83)
[ 1749.220348] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[ 1749.220352]
-> #0 (rtnl_mutex){+.+.}-{3:3}:
[ 1749.220357] __lock_acquire (kernel/locking/lockdep.c:3159
kernel/locking/lockdep.c:3277 kernel/locking/lockdep.c:3901
kernel/locking/lockdep.c:5199)
[ 1749.220362] lock_acquire (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5824 kernel/locking/lockdep.c:5787)
[ 1749.220365] __mutex_lock (kernel/locking/mutex.c:610
kernel/locking/mutex.c:752)
[ 1749.220369] wg_pm_notification (drivers/net/wireguard/device.c:81
drivers/net/wireguard/device.c:64)
[ 1749.220372] notifier_call_chain (kernel/notifier.c:93)
[ 1749.220375] blocking_notifier_call_chain_robust
(kernel/notifier.c:129 kernel/notifier.c:353 kernel/notifier.c:341)
[ 1749.220378] pm_notifier_call_chain_robust
(./include/linux/notifier.h:207 kernel/power/main.c:104)
[ 1749.220382] pm_suspend (kernel/power/suspend.c:367
kernel/power/suspend.c:588 kernel/power/suspend.c:625)
[ 1749.220386] state_store (kernel/power/main.c:746)
[ 1749.220389] kernfs_fop_write_iter (fs/kernfs/file.c:334)
[ 1749.220393] vfs_write (fs/read_write.c:590 fs/read_write.c:683)
[ 1749.220397] ksys_write (fs/read_write.c:736)
[ 1749.220399] do_syscall_64 (arch/x86/entry/common.c:52
arch/x86/entry/common.c:83)
[ 1749.220402] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[ 1749.220406]
other info that might help us debug this:

[ 1749.220408]  Possible unsafe locking scenario:

[ 1749.220409]        CPU0                    CPU1
[ 1749.220411]        ----                    ----
[ 1749.220413]   rlock((pm_chain_head).rwsem);
[ 1749.220416]                                lock(rtnl_mutex);
[ 1749.220420]                                lock((pm_chain_head).rwsem);
[ 1749.220423]   lock(rtnl_mutex);
[ 1749.220426]
*** DEADLOCK ***

[ 1749.220428] 5 locks held by systemd-sleep/5239:
[ 1749.220430] #0: ffff888125d2e3f8 (sb_writers#6){.+.+}-{0:0}, at:
ksys_write (fs/read_write.c:736)
[ 1749.220439] #1: ffff8881e5cb9888 (&of->mutex){+.+.}-{3:3}, at:
kernfs_fop_write_iter (fs/kernfs/file.c:326)
[ 1749.220447] #2: ffff888460aee2d8 (kn->active#166){.+.+}-{0:0}, at:
kernfs_fop_write_iter (fs/kernfs/file.c:326)
[ 1749.220455] #3: ffffffffb0757008
(system_transition_mutex){+.+.}-{3:3}, at: pm_suspend
(kernel/power/suspend.c:574 kernel/power/suspend.c:625)
[ 1749.220463] #4: ffffffffb077e170
((pm_chain_head).rwsem){++++}-{3:3}, at:
blocking_notifier_call_chain_robust (kernel/notifier.c:128
kernel/notifier.c:353 kernel/notifier.c:341)
[ 1749.220471]
stack backtrace:
[ 1749.220474] CPU: 1 UID: 0 PID: 5239 Comm: systemd-sleep Not tainted
6.11.0-slowkasan+ #140
[ 1749.220478] Hardware name: [...]
[ 1749.220480] Call Trace:
[ 1749.220483]  <TASK>
[ 1749.220485] dump_stack_lvl (lib/dump_stack.c:124)
[ 1749.220491] print_circular_bug (kernel/locking/lockdep.c:2077)
[ 1749.220496] check_noncircular (kernel/locking/lockdep.c:2203)
[...]
[ 1749.220519] __lock_acquire (kernel/locking/lockdep.c:3159
kernel/locking/lockdep.c:3277 kernel/locking/lockdep.c:3901
kernel/locking/lockdep.c:5199)
[...]
[ 1749.220546] lock_acquire (kernel/locking/lockdep.c:467
kernel/locking/lockdep.c:5824 kernel/locking/lockdep.c:5787)
[...]
[ 1749.220577] __mutex_lock (kernel/locking/mutex.c:610
kernel/locking/mutex.c:752)
[...]
[ 1749.220627] wg_pm_notification (drivers/net/wireguard/device.c:81
drivers/net/wireguard/device.c:64)
[ 1749.220631] notifier_call_chain (kernel/notifier.c:93)
[ 1749.220636] blocking_notifier_call_chain_robust
(kernel/notifier.c:129 kernel/notifier.c:353 kernel/notifier.c:341)
[...]
[ 1749.220649] pm_notifier_call_chain_robust
(./include/linux/notifier.h:207 kernel/power/main.c:104)
[ 1749.220652] pm_suspend (kernel/power/suspend.c:367
kernel/power/suspend.c:588 kernel/power/suspend.c:625)
[ 1749.220656] state_store (kernel/power/main.c:746)
[ 1749.220661] kernfs_fop_write_iter (fs/kernfs/file.c:334)
[ 1749.220665] vfs_write (fs/read_write.c:590 fs/read_write.c:683)
[...]
[ 1749.220693] ksys_write (fs/read_write.c:736)
[...]
[ 1749.220701] do_syscall_64 (arch/x86/entry/common.c:52
arch/x86/entry/common.c:83)
[ 1749.220704] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[ 1749.220708] RIP: 0033:0x7fe2e2917240
[...]
[ 1749.220735]  </TASK>
[ 1749.223599] Freezing user space processes
[ 1749.226307] Freezing user space processes completed (elapsed 0.002 seconds)

