Return-Path: <linux-pm+bounces-18871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779169EA1AF
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 23:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CE3188684E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 22:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEB0198833;
	Mon,  9 Dec 2024 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7R5dg52"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF346B8;
	Mon,  9 Dec 2024 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782562; cv=none; b=F0DpB9C3KEE+sxxfmXURaDT81oXhyQLlZ6wepPA2jsMMzD7muMl8DM+kQo+f/v+3tTJCWunpxEuodjSEYFbWOUr8bJgeuhaQJdXNcmU6NU9wWeNEuYxdqC1632/w2bZCAUj07flCtiMEQC4H+HYvuToDVf/uRIa9HRZy6fasjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782562; c=relaxed/simple;
	bh=wnP4NseBllUFpL2rlwDlCwj2pZ0TD2GGH92m6gsVCfs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=W+mo8q0CSgvOB0yx2BOgcUCQQ3XniF4XipKz5Rxmgvt4tgPbFWpy1tVYHJrZRZOagbY+Rtx2hMZOZQ3lFYB4GYhBn0sbPmtnBf1L9Xkzh6L0sEVlgRe4ueFuuAZY7VKo63AmX6KyhTRfL4Srt7DTDzTRot/qUs7VcEPQvxuBTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7R5dg52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91029C4CEE2;
	Mon,  9 Dec 2024 22:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733782561;
	bh=wnP4NseBllUFpL2rlwDlCwj2pZ0TD2GGH92m6gsVCfs=;
	h=Date:To:Cc:From:Subject:From;
	b=Y7R5dg52vA6FMrI//DTkyTBUb1OcMePgSMG/bEVeA/Ygn9s8GSPFmv9NdmJ8f2erC
	 ogyzTVRE/FRKxntdN3nr6x3yXdipeTT1hV2Ts7EG+M4+UOzjKZgOsF6rKbAWGkSfWe
	 EqhcU04Ysrs1gkFW0dwCtdgoA3oNOJL/e/zIIUvBBMsBHCHg1aQP64v6PtgNbw53GL
	 skPxjrmgOyHR45mPhnClGZsPq/3WDxUxfTMNtsq1r8dGXEsHa1KppEXTPMu+rX2CF+
	 dDgBsN3Vng41o9LDwIBTL3jnmepib02/tNPmJWRcwm/fg6qDRsYL5Rw7LteDhJbYRs
	 vC/YbH15YtrsQ==
Message-ID: <93978193-1273-4954-893a-f27528ed1d0e@kernel.org>
Date: Mon, 9 Dec 2024 16:16:00 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
From: Mario Limonciello <superm1@kernel.org>
Subject: [6.13] Power Supply regression on bootup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a laptop here that upgrading from 6.11 to 6.13-rc1/6.13-rc2 is 
causing a kernel panic at startup.

I caught it with a crash kernel and it starts with what looks like a 
race condition of some sort to me.  I didn't see something obvious on 
the list about this so I figured I'd raise it now in case it jumps out 
to anyone before I have any progress on a bisect.  I'll come back with 
more details as I have them.

Oops: general protection fault, probably for non-canonical address 
0x8be733ac87a733a8: 0000 [#1] PREEMPT SMP NOPTI
CPU: 15 UID: 0 PID: 657 Comm: udevadm Not tainted 6.13.0-rc2 #48
RIP: 0010:string+0x48/0xe0
Code: 3b 45 89 d1 45 31 c0 49 01 f9 66 45 85 d2 75 1a eb 1f 48 39 f7 73 
02 88 07 48 83 c7 01 41 83 c0 01 48 83 c2 01 4c 39 cf 74 07 <0f> b6 02 
84 c0 75 e1 48 89 f2 44 89 c6 e9 a6 ee ff ff 48 c7 c0 83
RSP: 0018:ffffb98b01197880 EFLAGS: 00010286
RAX: 8be733ac87a723a8 RBX: ffffffff90c1d519 RCX: ffff0a00ffffff04
RDX: 8be733ac87a733a8 RSI: ffff8f3a899b7a1c RDI: ffff8f3a899b72c0
RBP: ffff8f3a899b72c0 R08: 0000000000000000 R09: ffff8f3b899b72bf
R10: ffffffffffffffff R11: 0000000000000000 R12: ffffb98b011978e8
R13: ffff8f3a899b7a1c R14: ffffffff90c1d519 R15: 000000000000076e
FS:  00007f47992288c0(0000) GS:ffff8f41be380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a7520cc6a8 CR3: 0000000104206000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
  <TASK>
  ? die_addr+0x32/0x80
  ? exc_general_protection+0x1c8/0x3b0
  ? asm_exc_general_protection+0x22/0x30
  ? string+0x48/0xe0
  vsnprintf+0x267/0x590
  add_uevent_var+0x96/0x190
  ? netlink_broadcast_filtered+0x143/0x490
  power_supply_uevent+0x59/0x1e0
  dev_uevent+0x10b/0x2c0
  kobject_uevent_env+0x28c/0x800
  kobject_synth_uevent+0x34a/0x380
  uevent_store+0x1a/0x50
  kernfs_fop_write_iter+0x11d/0x1b0
  vfs_write+0x263/0x430
  ksys_write+0x62/0xe0
  do_syscall_64+0x80/0x170
  ? terminate_walk+0xee/0x100
  ? path_openat+0x4aa/0x12e0
  ? syscall_exit_to_user_mode+0xc/0x200
  ? do_syscall_64+0x8c/0x170
  ? refill_obj_stock+0x169/0x230
  ? kmem_cache_alloc_noprof+0x27b/0x390
  ? preempt_count_add+0x69/0xa0
  ? do_sys_openat2+0x7d/0xc0
  ? syscall_exit_to_user_mode+0xc/0x200
  ? do_syscall_64+0x8c/0x170
  ? syscall_exit_to_user_mode+0xc/0x200
  ? do_syscall_64+0x8c/0x170
  ? do_syscall_64+0x8c/0x170
  ? do_syscall_64+0x8c/0x170
  ? do_syscall_64+0x8c/0x170
  ? common_interrupt+0x71/0x100
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f479911c574
Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 
f3 0f 1e fa 80 3d d5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
RSP: 002b:00007fffcecab378 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f479911c574
RDX: 0000000000000004 RSI: 00007fffcecab430 RDI: 0000000000000004
RBP: 00007fffcecab3a0 R08: 0000000000000000 R09: 00007fffcecab530
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000004
R13: 00007fffcecab430 R14: 000055760d84e070 R15: 0000000000000004
  </TASK>
Modules linked in: squashfs parport_pc ppdev lp parport fuse loop 
nfnetlink ip_tables cdc_ncm cdc_ether usbnet typec_displayport r8152 mii 
hid_multitouch nvme i2c_hid_acpi crc32_pclmul i2c_hid thunderbolt 
crc32c_intel nvme_core ucsi_acpi drm typec_ucsi typec video 
drm_panel_orientation_quirks
---[ end trace 0000000000000000 ]---

A full kernel log is at 
https://gist.github.com/superm1/82f1c09b1572fd066759e44cb8787031

Thanks,

