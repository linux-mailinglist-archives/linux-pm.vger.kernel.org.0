Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A50312D5C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 10:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhBHJfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 04:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhBHJcd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2021 04:32:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF06FC061786
        for <linux-pm@vger.kernel.org>; Mon,  8 Feb 2021 01:31:52 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b9so23401968ejy.12
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2021 01:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=U1QXB/h23taU5h8F+8gtZlTYZ1RSyUzqB5LCB1YoKQw=;
        b=xwVJhtnKflT/7gBIuc+B8as2yXVLmx4VPg+cYPzntDEm0pTIFZfS174xy4E2DC6755
         FNbshXgfUDlcAYq59axokXpixR2VXiOrVoHTK0imQnjySOJGfWO0S2qWzdZUMgXrWt8G
         d/rXexGkiOrQCiS4YRT+qMBmiJKML+6tmPg4USyPiJd5wDAgdC48mzZ3OHcEuD26mi7C
         NDr/S8L6yLy8TLGrvEmpEL7QNaPKCXzbM/eqsrMcuCdQvnp+g6f+yAiuZaeO3dWEFB3H
         d9ZwKt2bDzBjRSOozkEr5EU6X3rmKkdSl5dMD/IxqQIHOKTjbLKW+Xk/DKl69j2iVfMy
         LJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=U1QXB/h23taU5h8F+8gtZlTYZ1RSyUzqB5LCB1YoKQw=;
        b=OTc4InWceaFf2BdgwApjGkq3KPycGmJfi+QgqJJqosXUWlR4Fkr5hZVEdCAQGgrpbl
         htp+ghJVzjFrCXcc7MEjQb1/GHvRLcL/9fdOrHDD2tPePMz4KU9SGTIw5tJ233gIocGN
         rmdZsfQ9I9+Q/QKOg8h4ux7e9hYCfLXsQ8N+Zx/mZwYcEwxq3J08DEGnTc++ZWQanwOo
         1250698uSLO2k3el2bbskP7I/FyYC4Jr3CEclu7hFhvGCuxoKjUXvs/I4tfIc1C+IQve
         V00LTLBV54LL4tJ1s6sd7GvYtXyqqAHxeavdO9lFWQBxNSmepLyavm4FlLv0q/wbIB1a
         C4wQ==
X-Gm-Message-State: AOAM530CAdi/o7LnNMVEVfe9ce3QcMSceBbAkx32xZbN+xqqcMyIHud9
        5p1QBtNVUUC4aGqr8wzQt2NMU4lWC3N7Rps0TCnk3w==
X-Google-Smtp-Source: ABdhPJx7xohRsvqRJeFvRZPsXTmoE7tn2u2NdFkdO3+KXZNGvVUOJnu5QXaiQYPrAggUCxu/B7v6rKc56NK3zAhPLYU=
X-Received: by 2002:a17:906:24d1:: with SMTP id f17mr15973206ejb.503.1612776711165;
 Mon, 08 Feb 2021 01:31:51 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 8 Feb 2021 15:01:39 +0530
Message-ID: <CA+G9fYtURD4R+KT+5mFHxYNZSPbmhBF9rS+RXaFqyZhV+k-U3g@mail.gmail.com>
Subject: WARNING: at arch/x86/kernel/irq.c:390 thermal_set_handler
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        rcu@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        X86 ML <x86@kernel.org>, lkft-triage@lists.linaro.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rui.zhang@intel.com,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following kernel warning noticed on Linux next tag 20210205 while booting
x86_64 and i386.

step to reproduce:
  - Boot linux next tag 20210205 on x86_64
  - While booting you will notice the below warning


[    1.046552] ------------[ cut here ]------------
[    1.046552] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/irq.c:390
thermal_set_handler+0x31/0x40
[    1.046552] Modules linked in:
[    1.046552] CPU: 1 PID: 0 Comm: swapper/1 Not tainted
5.11.0-rc6-next-20210205 #2
[    1.046552] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[    1.046552] RIP: 0010:thermal_set_handler+0x31/0x40
[    1.046552] Code: 89 e5 48 85 ff 74 16 48 81 3d 3f 75 99 01 33 59
8a a1 75 16 48 89 3d 36 75 99 01 5d c3 48 c7 05 29 75 99 01 33 59 8a
a1 5d c3 <0f> 0b eb e6 cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00
55 45
[    1.046552] RSP: 0000:ffffb351800afe60 EFLAGS: 00010093
[    1.046552] RAX: 0000000000000003 RBX: ffffa27d9fc91460 RCX: 00000000000001b2
[    1.046552] RDX: 0000000000000000 RSI: 00000000000100fa RDI: ffffffffa1505340
[    1.046552] RBP: ffffb351800afe60 R08: 0000000000000000 R09: 0000000000000020
[    1.046552] R10: 0000000000000100 R11: 0000000000000000 R12: 0000000000000000
[    1.046552] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
[    1.046552] FS:  0000000000000000(0000) GS:ffffa27d9fc80000(0000)
knlGS:0000000000000000
[    1.046552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.046552] CR2: 0000000000000000 CR3: 00000003ff610001 CR4: 00000000003706a0
[    1.046552] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.046552] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.046552] Call Trace:
[    1.046552]  intel_init_thermal+0x152/0x410
[    1.046552]  init_intel+0x113/0x480
[    1.046552]  identify_cpu+0x343/0x7b0
[    1.046552]  identify_secondary_cpu+0x18/0x90
[    1.046552]  smp_store_cpu_info+0x4e/0x60
[    1.046552]  start_secondary+0x55/0x150
[    1.046552]  secondary_startup_64_no_verify+0xc2/0xcb
[    1.046552] ---[ end trace 88e67487dd39a322 ]---
[    1.330140]  #2
[    1.046552] ------------[ cut here ]------------
[    1.046552] WARNING: CPU: 2 PID: 0 at arch/x86/kernel/irq.c:390
thermal_set_handler+0x31/0x40
[    1.046552] Modules linked in:
[    1.046552] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G        #
W         5.11.0-rc6-next-20210205 #2
[    1.046552] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[    1.046552] RIP: 0010:thermal_set_handler+0x31/0x40
[    1.046552] Code: 89 e5 48 85 ff 74 16 48 81 3d 3f 75 99 01 33 59
8a a1 75 16 48 89 3d 36 75 99 01 5d c3 48 c7 05 29 75 99 01 33 59 8a
a1 5d c3 <0f> 0b eb e6 cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00
55 45
[    1.046552] RSP: 0000:ffffb351800b7e60 EFLAGS: 00010093
[    1.046552] RAX: 0000000000000003 RBX: ffffa27d9fd11460 RCX: 00000000000001b2
[    1.046552] RDX: 0000000000000000 RSI: 00000000000100fa RDI: ffffffffa1505340
[    1.046552] RBP: ffffb351800b7e60 R08: 0000000000000000 R09: 0000000000000020
[    1.046552] R10: 0000000000000100 R11: 0000000000000000 R12: 0000000000000000
[    1.046552] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
[    1.046552] FS:  0000000000000000(0000) GS:ffffa27d9fd00000(0000)
knlGS:0000000000000000
[    1.046552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.046552] CR2: 0000000000000000 CR3: 00000003ff610001 CR4: 00000000003706a0
[    1.046552] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.046552] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.046552] Call Trace:
[    1.046552]  intel_init_thermal+0x152/0x410
[    1.046552]  init_intel+0x113/0x480
[    1.046552]  identify_cpu+0x343/0x7b0
[    1.046552]  identify_secondary_cpu+0x18/0x90
[    1.046552]  smp_store_cpu_info+0x4e/0x60
[    1.046552]  start_secondary+0x55/0x150
[    1.046552]  secondary_startup_64_no_verify+0xc2/0xcb
[    1.046552] ---[ end trace 88e67487dd39a323 ]---
[    1.500028]  #3
[    1.046552] ------------[ cut here ]------------
[    1.046552] WARNING: CPU: 3 PID: 0 at arch/x86/kernel/irq.c:390
thermal_set_handler+0x31/0x40
[    1.046552] Modules linked in:
[    1.046552] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W
  5.11.0-rc6-next-20210205#
 #2
[    1.046552] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[    1.046552] RIP: 0010:thermal_set_handler+0x31/0x40
[    1.046552] Code: 89 e5 48 85 ff 74 16 48 81 3d 3f 75 99 01 33 59
8a a1 75 16 48 89 3d 36 75 99 01 5d c3 48 c7 05 29 75 99 01 33 59 8a
a1 5d c3 <0f> 0b eb e6 cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00
55 45
[    1.046552] RSP: 0000:ffffb351800bfe60 EFLAGS: 00010093
[    1.046552] RAX: 0000000000000003 RBX: ffffa27d9fd91460 RCX: 00000000000001b2
[    1.046552] RDX: 0000000000000000 RSI: 00000000000100fa RDI: ffffffffa1505340
[    1.046552] RBP: ffffb351800bfe60 R08: 0000000000000000 R09: 0000000000000020
[    1.046552] R10: 0000000000000100 R11: 0000000000000000 R12: 0000000000000000
[    1.046552] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
[    1.046552] FS:  0000000000000000(0000) GS:ffffa27d9fd80000(0000)
knlGS:0000000000000000
[    1.046552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.046552] CR2: 0000000000000000 CR3: 00000003ff610001 CR4: 00000000003706a0
[    1.046552] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.046552] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.046552] Call Trace:
[    1.046552]  intel_init_thermal+0x152/0x410
[    1.046552]  init_intel+0x113/0x480
[    1.046552]  identify_cpu+0x343/0x7b0
[    1.046552]  identify_secondary_cpu+0x18/0x90
[    1.046552]  smp_store_cpu_info+0x4e/0x60
[    1.046552]  start_secondary+0x55/0x150
[    1.046552]  secondary_startup_64_no_verify+0xc2/0xcb
[    1.046552] ---[ end trace 88e67487dd39a324 ]---
[    1.670074] smp: Brought up 1 node, 4 CPUs
[    1.670523] smpboot: Max logical packages: 1
[    1.671522] smpboot: Total of 4 processors activated (24000.00 BogoMIPS)
[    1.673543] devtmpfs: initialized
[    1.674629] PM: Registering ACPI NVS region [mem
0x8879d000-0x8879dfff] (4096 bytes)
[    1.675523] PM: Registering ACPI N#
VS region [mem 0x8d11f000-0x8d891fff] (7811072 bytes)
[    1.676615] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.677523] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    1.678701] PM: RTC time: 11:53:55, date: 2021-02-05
[    1.679575] NET: Registered protocol family 16
[    1.680593] audit: initializing netlink subsys (disabled)
[    1.681526] audit: type=2000 audit(1612526033.562:1):
state=initialized audit_enabled=0 res=1
[    1.681583] thermal_sys: Registered thermal governor 'step_wise'
[    1.682523] thermal_sys: Registered thermal governor 'user_space'
[    1.683530] cpuidle: using governor menu


Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/2233628#L498


metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git describe: next-20210205
  kernel-config: https://builds.tuxbuild.com/1o3nLyZtkkU2dUsallc286STyPX/config
  build link: https://builds.tuxbuild.com/1o3nLyZtkkU2dUsallc286STyPX/

--
Linaro LKFT
https://lkft.linaro.org
