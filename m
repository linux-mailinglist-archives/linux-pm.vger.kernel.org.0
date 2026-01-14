Return-Path: <linux-pm+bounces-40872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FDD2030F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 17:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01B7A3004420
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC90D31B108;
	Wed, 14 Jan 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2UbEHU7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365053A35A9
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407807; cv=none; b=CQGd/RZnkmsoahJJKQ7qtDOovQbb2dJQIqICQN/4QYA9/SgpqrSPxbS6PMxN9DbeR6SpGXbq+twxi6iqGA43+Bcx8c0pjCluLKGQluhTrnaPwARo72kZok5zRORsGZIeUPjEkNI6ZfNz5HdhpWyXGP1COprwlieuPVGVPYvpbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407807; c=relaxed/simple;
	bh=E7995ovoS7pK1KnBifI4kLYCdIWJQsDF6WqbXGQOCxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjFqdZW5YkL9lVDoCEVd+x9hQggqzXzDuIECegS3Hqx4PUGa7kPirSQjQlH9YmlHrvguNoG/+XTwGXMHaXCsXcLvnL8HB9yr9ozMxZGDYdjcnBajvhGbrCqVFcgzPb4LZ+3s4feH4kKoQF5obXrEuRyLSXVpitXe3WyM40tg1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2UbEHU7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b87693c981fso4579266b.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768407803; x=1769012603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikvxKJIuLP7xPyw5aj9CliT/WHnLxLhC8YGnX6DGna8=;
        b=C2UbEHU7fTcYrHB3zD3wljIhKlsM/m7ODDO/AsQugy0HKOmvKXK/zYknz8AwWhfst8
         /7ggmx37d0F5f3gN0Y+Qz9M3C0EIGQO37BgEuXO8D12P+G6xh3QKwKwpQ+igLPfbcmCD
         7zf5dcC4Dt2z4cCpGnigTXyuVDR4zkRXwM5kbkOa2dCQwnNJHhl+wHmA2R82Cf2S7yTS
         6kEXtAWJDI2nHkOHy+avTDrA8X5gQdQ5nReTltwpG2N6uNiwPhLo6PpP9o1fGkKb+Mlw
         ucPOwgw3M9XnfJwY1mLon9KfP2XK/nLqTkA5NvtvITTde+FjvOuB8Riz/JFDbdRGFQnU
         NtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768407803; x=1769012603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikvxKJIuLP7xPyw5aj9CliT/WHnLxLhC8YGnX6DGna8=;
        b=vwOtpqCohAnt+IxeAw/3ut1zHn5gN3GkgEtoybrDfJuC0cpM3L0AVfADJ7btNRvxnK
         bRYzy7gL1/NWOhPbwAak6i6f0qsvDK/9ZV1fo/CFmUy2U5egC1EgpEEOtl45HsG2pfb6
         8tXQgD9NVyhVzC85cDZVdQ9PW5xVt2BmkskH8lo5XcZpOO7+90T5P7MCRKgC4kXYnB42
         8J/89rOOvSj/kw9dACPc/dKWzK4NOwFpbN56rCfSF8DKVyUXcySh/GPcDLhWhb+FN7Qm
         o92ktMHl+fFyRQrESuFhrN4VwdIx/ATaGqNswHEdc51V/p1UjCS1zQsg5y5UfZm5Ymhr
         mhig==
X-Forwarded-Encrypted: i=1; AJvYcCWMkcNntJJ0ngYRnZtJD5wmvRS4zgC6KwcsMGzXDZHsnAzVk3UVICMxqjRVXbvuyd0ciZWI96XtrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8fSBAURg8yL4F9Y3BwKzsjhCZLQSwGjniIoQkCZCV4AKW9VN
	BPjHnQF+GT4njlVvuBFRzX6BOhbqhzloMgYnkdFbfFgr5muye8wUVnOOe3S0jJvicDMfWS0zps2
	zyeV+s7QI+9F1pnLk+ye2/g6n78CZllg=
X-Gm-Gg: AY/fxX62Lq4aLhFqEiEB+Y+OxIjsFu5LodB6Hixq0nT3Y4S/Dsn4Dzv8BcOpqHL7Cq+
	kjDoqJ0qRKJHmV1x7as1WDhS49ivDo0BJSXg8NgdFXWi2ecv26WoFVihWjcUSXPGn/Bm1VXevpq
	zbSakq9SHmHdQ1+l4bSmeaUh2laGfMsD26e0el00PzXGfK5OebKFYkPYPHk4I4L8JuBR8yah3i1
	oKNpUyTT+IKmVQNPxCHtv8y5y2IvilxRHrzFCLjOo+O2HzjwDxQrkeCUrQah88wInZ4ZvTEaaRg
	3R0pefeI63NFSsc6JLXM+yjh4hIc
X-Received: by 2002:a17:906:730f:b0:b76:63b8:7394 with SMTP id
 a640c23a62f3a-b87677e100fmr199785666b.51.1768407802544; Wed, 14 Jan 2026
 08:23:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
 <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com> <aWeZ4LmfwiS9iwYF@ly-workstation>
In-Reply-To: <aWeZ4LmfwiS9iwYF@ly-workstation>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 15 Jan 2026 00:22:45 +0800
X-Gm-Features: AZwV_QhBWPQyAd5qCFCLWs0OG7Cd_OMO0uTc5Ks-lryX8Aohf2JMaesrVs9Q1xI
Message-ID: <CAMgjq7AQWswq1Hv_vbPnpNgVuzaRFyGttwm+euE3S=C6+iFHaA@mail.gmail.com>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:28=E2=80=AFPM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
>
> Hi Kairui Song,
>
> Greetings!
>
> I used Syzkaller and found that there is possible deadlock in swap_free_h=
ibernation_slot in linux-next next-20260113.
>
> After bisection and the first bad commit is:
> "
> 33be6f68989d mm. swap: cleanup swap entry management workflow
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260114_102849_swap_=
free_hibernation_slot
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260114_102849_swap_=
free_hibernation_slot/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260114_102849_swap_=
free_hibernation_slot/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260114_102849_swap_=
free_hibernation_slot/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/260114_102849_swap_=
free_hibernation_slot/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/260114_102849_swap_=
free_hibernation_slot/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/260114_10=
2849_swap_free_hibernation_slot/bzImage_0f853ca2a798ead9d24d39cad99b0966815=
c582a
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/260114_102849_swap_=
free_hibernation_slot/0f853ca2a798ead9d24d39cad99b0966815c582a_dmesg.log
>
> "
> [   62.477554] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   62.477802] WARNING: possible recursive locking detected
> [   62.478059] 6.19.0-rc5-next-20260113-0f853ca2a798 #1 Not tainted
> [   62.478324] --------------------------------------------
> [   62.478549] repro/668 is trying to acquire lock:
> [   62.478759] ffff888011664018 (&cluster_info[i].lock){+.+.}-{3:3}, at: =
swap_free_hibernation_slot+0x13e/0x2a0
> [   62.479271]
> [   62.479271] but task is already holding lock:
> [   62.479519] ffff888011664018 (&cluster_info[i].lock){+.+.}-{3:3}, at: =
swap_free_hibernation_slot+0xfa/0x2a0
> [   62.479984]
> [   62.479984] other info that might help us debug this:
> [   62.480293]  Possible unsafe locking scenario:
> [   62.480293]
> [   62.480565]        CPU0
> [   62.480686]        ----
> [   62.480809]   lock(&cluster_info[i].lock);
> [   62.481010]   lock(&cluster_info[i].lock);
> [   62.481205]
> [   62.481205]  *** DEADLOCK ***
> [   62.481205]
> [   62.481481]  May be due to missing lock nesting notation
> [   62.481481]
> [   62.481802] 2 locks held by repro/668:
> [   62.481981]  #0: ffffffff87542e28 (system_transition_mutex){+.+.}-{4:4=
}, at: lock_system_sleep+0x92/0xb0
> [   62.482439]  #1: ffff888011664018 (&cluster_info[i].lock){+.+.}-{3:3},=
 at: swap_free_hibernation_slot+0xfa/0x0
> [   62.482936]
> [   62.482936] stack backtrace:
> [   62.483131] CPU: 0 UID: 0 PID: 668 Comm: repro Not tainted 6.19.0-rc5-=
next-20260113-0f853ca2a798 #1 PREEMPT(l
> [   62.483143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.q4
> [   62.483151] Call Trace:
> [   62.483156]  <TASK>
> [   62.483160]  dump_stack_lvl+0xea/0x150
> [   62.483195]  dump_stack+0x19/0x20
> [   62.483206]  print_deadlock_bug+0x22e/0x300
> [   62.483215]  __lock_acquire+0x1325/0x2210
> [   62.483226]  lock_acquire+0x170/0x2f0
> [   62.483234]  ? swap_free_hibernation_slot+0x13e/0x2a0
> [   62.483249]  _raw_spin_lock+0x38/0x50
> [   62.483267]  ? swap_free_hibernation_slot+0x13e/0x2a0
> [   62.483279]  swap_free_hibernation_slot+0x13e/0x2a0
> [   62.483291]  ? __pfx_swap_free_hibernation_slot+0x10/0x10
> [   62.483303]  ? locks_remove_file+0xe2/0x7f0
> [   62.483322]  ? __pfx_snapshot_release+0x10/0x10
> [   62.483331]  free_all_swap_pages+0xdd/0x160
> [   62.483339]  ? __pfx_snapshot_release+0x10/0x10
> [   62.483346]  snapshot_release+0xac/0x200
> [   62.483353]  __fput+0x41f/0xb70
> [   62.483369]  ____fput+0x22/0x30
> [   62.483376]  task_work_run+0x19e/0x2b0
> [   62.483391]  ? __pfx_task_work_run+0x10/0x10
> [   62.483398]  ? nsproxy_free+0x2da/0x5b0
> [   62.483410]  ? switch_task_namespaces+0x118/0x130
> [   62.483421]  do_exit+0x869/0x2810
> [   62.483435]  ? do_group_exit+0x1d8/0x2c0
> [   62.483445]  ? __pfx_do_exit+0x10/0x10
> [   62.483451]  ? __this_cpu_preempt_check+0x21/0x30
> [   62.483463]  ? _raw_spin_unlock_irq+0x2c/0x60
> [   62.483474]  ? lockdep_hardirqs_on+0x85/0x110
> [   62.483486]  ? _raw_spin_unlock_irq+0x2c/0x60
> [   62.483498]  ? trace_hardirqs_on+0x26/0x130
> [   62.483516]  do_group_exit+0xe4/0x2c0
> [   62.483524]  __x64_sys_exit_group+0x4d/0x60
> [   62.483531]  x64_sys_call+0x21a2/0x21b0
> [   62.483544]  do_syscall_64+0x6d/0x1180
> [   62.483560]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   62.483584] RIP: 0033:0x7fe84fb18a4d
> [   62.483595] Code: Unable to access opcode bytes at 0x7fe84fb18a23.
> [   62.483602] RSP: 002b:00007fff3e35c928 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000e7
> [   62.483610] RAX: ffffffffffffffda RBX: 00007fe84fbf69e0 RCX: 00007fe84=
fb18a4d
> [   62.483615] RDX: 00000000000000e7 RSI: ffffffffffffff80 RDI: 000000000=
0000001
> [   62.483620] RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000=
0000020
> [   62.483624] R10: 00007fff3e35c7d0 R11: 0000000000000246 R12: 00007fe84=
fbf69e0
> [   62.483629] R13: 00007fe84fbfbf00 R14: 0000000000000001 R15: 00007fe84=
fbfbee8
> [   62.483640]  </TASK>
> "
>
> Hope this cound be insightful to you.
>
> Regards,
> Yi Lai
>
> ---
>
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>

Thanks Lai!

The issue is with the WARN_ON I added... Didn't notice that the
WARN_ON requires ci lock, so we better just remove that.

Following change should fix the issue you reported:
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 85bf4f7d9ae7..8c0f31363c1f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2096,7 +2096,6 @@ void swap_free_hibernation_slot(swp_entry_t entry)

        ci =3D swap_cluster_lock(si, offset);
        swap_entry_put_locked(si, ci, entry, 1);
-       WARN_ON(swap_entry_swapped(si, entry));
        swap_cluster_unlock(ci);

        /* In theory readahead might add it to the swap cache by accident *=
/

---

swap_entry_swapped requires CI lock. There wasn't any WARN_ON before,
it was added to just ensure things worked as expected, really not
needed.

