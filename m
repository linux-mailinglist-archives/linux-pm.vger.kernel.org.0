Return-Path: <linux-pm+bounces-20536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469BA1397D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 12:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AC3A367B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 11:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77E1DE4D4;
	Thu, 16 Jan 2025 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="MBdPnd7l"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D01DE4E5
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028368; cv=none; b=IFhkOVfU4OPIiK0bzPluVhHlnXDEd+yfubVO1wuiPe8XVEcy5mInXjfhem+dDe6zYFxFFyHYILf5vBMZupj3z1LRdNKnbRkrjIK5p5GBqp0Dla3FnrMku4peQm0SvWaGupA7XN6Cd3wSp4PC71yahLlbbqqZmKbuiuIo8mW2h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028368; c=relaxed/simple;
	bh=DsUSBk/7EHEoKrI+JXZw5sLMubkh+qHo9S2jsaL3ZQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcvh4IGwqA0XNyJLI5bTWH0NNJjCKgLr5563vPiWTt5QGypSKivFd34OEB7MnI+YSxGV8UfpYhDnM2Xuz9MDvNiuKQtkUoEmddkermGyHLN39AMW/w10CULRMVEegPGpe99WW90nmzTZk9JjbHUfmiCuSKFJxZeXHSXfGXdKrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=MBdPnd7l; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Thu, 16 Jan 2025 12:52:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1737028348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aaFkthdj6obOTrZCIiY1D9Y8V5kmUE3f30+96Ns4/4E=;
	b=MBdPnd7ldMCni5KDPAsDVxyqre0UB5qoJOBqj+d1E1mREYm9oj8S7+cUgqtFf8KyjSiuED
	uJZLU6pd9pvw2xzdOFkt+38NK19gmTQGtnhr1W4u9phb17WBdd98zfoEG2rYQQBe8/0AMq
	kLFItGn/tLhGqBTmgdnVdCqV6BvGMRIvp72B8tgkOdJjtJIIebEXLorswPyFNoVug2/Ula
	bgx7/HORJaa4oonYexb+pAp2QPOL+LnzuLduuHGrnpnpCMW5HF13XztfEkRs9A0ee0KhP+
	l3PkzeIhZJ7pmai9uO+IDXWZWhWUkZbl80yIvM5o9QmQ+INm+Gop8FmwOBfxsA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4jy-NoLxpwaLfyD@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
 <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
 <Z4ejbdJr87V3IwV8@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4ejbdJr87V3IwV8@desktop0a>
X-Migadu-Flow: FLOW_OUT

On 2025-01-15 Wed 13:00:52 +0100, Roberto Ricci wrote:
> On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
> > On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> > > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> > > > I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> > > > running Void Linux, with the following commands:
> > > > 
> > > > ```
> > > > # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> > > > # reboot
> > > > # printf reboot >/sys/power/disk
> > > > # printf disk >/sys/power/state
> > > > ```
> > > 
> > > Looks like it's the kernel performing the kexec which causes the issue,
> > > not the target one. E.g.: kexec-ing 6.7 from 6.13-rc7 makes resume from
> > > hibernation fail; but if I kexec 6.13-rc7 from 6.7, then it works fine.
> > 
> > I tried the latest mainline kernel with your above command execution
> > series, I didn't see the problem you reported. Can you try kexec from
> > 6.7 to 6.7 or something like that and try to bisect a specific criminal
> > commit?
> 
> As I mentioned in my initial report, only versions >= 6.8 are affected.
> Anyway, I actually was kexec-ing the same kernel which was already booted
> when I did the bisection which pointed to 18d565ea95fe.
> 
> > As for below commit, it seems not a suspect.
> > 18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")
> > 
> > If possible, can you revert below two commits altogether to have a try?
> > I am not sure if they caused the problem.
> > 
> > 18d565ea95fe kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
> > 816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()
> 
> Reverting these two commits does not fix things on v6.13-rc7.
> 
> But I have found that reverting 18d565ea95fe fixes the issue for kernels
> up to 6.11. Since 6.12 this is not enough. So I'm doing another bisection.
> I will report results maybe later today.

For brevity, let's call "A" this commit:
18d565ea95fe kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down().
And let's call "B" this other commit:
7856a565416e Merge tag 'mm-nonmm-stable-2024-09-21-07-52' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.

Revision B~1 is affected, but the stack trace is
different than the one I sent initially (which was on v6.13-rc7):

```
[   52.605903] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
[   52.606292] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   52.606589] CPU: 0 UID: 0 PID: 601 Comm: dhcpcd Kdump: loaded Not tainted 6.11.0_ricci+ #4
[   52.606852] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   52.607166] RIP: 0010:pcpu_alloc_noprof (mm/percpu.c:1824) 
[ 52.607452] Code: 47 e0 84 02 48 89 d3 48 c1 e3 04 48 01 d8 48 89 c1 48 c1 e9 03 42 80 3c 29 00 0f 85 b7 09 00 00 4c 8b 38 4c 89 f9 48 c1 e9 03 <42> 80 3c 29 00 0f 85 c1 09 00 00 4d 8b 37 44 8b 64 24 20 4c 39 f8
All code
========
   0:	47 e0 84             	rex.RXB loopne 0xffffffffffffff87
   3:	02 48 89             	add    -0x77(%rax),%cl
   6:	d3 48 c1             	rorl   %cl,-0x3f(%rax)
   9:	e3 04                	jrcxz  0xf
   b:	48 01 d8             	add    %rbx,%rax
   e:	48 89 c1             	mov    %rax,%rcx
  11:	48 c1 e9 03          	shr    $0x3,%rcx
  15:	42 80 3c 29 00       	cmpb   $0x0,(%rcx,%r13,1)
  1a:	0f 85 b7 09 00 00    	jne    0x9d7
  20:	4c 8b 38             	mov    (%rax),%r15
  23:	4c 89 f9             	mov    %r15,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
  2a:*	42 80 3c 29 00       	cmpb   $0x0,(%rcx,%r13,1)		<-- trapping instruction
  2f:	0f 85 c1 09 00 00    	jne    0x9f6
  35:	4d 8b 37             	mov    (%r15),%r14
  38:	44 8b 64 24 20       	mov    0x20(%rsp),%r12d
  3d:	4c 39 f8             	cmp    %r15,%rax

Code starting with the faulting instruction
===========================================
   0:	42 80 3c 29 00       	cmpb   $0x0,(%rcx,%r13,1)
   5:	0f 85 c1 09 00 00    	jne    0x9cc
   b:	4d 8b 37             	mov    (%r15),%r14
   e:	44 8b 64 24 20       	mov    0x20(%rsp),%r12d
  13:	4c 39 f8             	cmp    %r15,%rax
[   52.608033] RSP: 0018:ffff888137a07cb8 EFLAGS: 00010046
[   52.608317] RAX: ffff88813fffaca0 RBX: 0000000000000020 RCX: 0000000000000000
[   52.608604] RDX: 0000000000000002 RSI: 0000000000000002 RDI: ffff888137a07c58
[   52.608893] RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1026f40f8b
[   52.609187] R10: 0000000000000003 R11: 0000000100060063 R12: 0000000000000246
[   52.609478] R13: dffffc0000000000 R14: 0000000000000010 R15: 0000000000000000
[   52.609769] FS:  00007f4f99b4b740(0000) GS:ffff888118e00000(0000) knlGS:0000000000000000
[   52.610074] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.610368] CR2: 000055f8e4944045 CR3: 0000000108fe8000 CR4: 00000000000006f0
[   52.610671] Call Trace:
[   52.610959]  <TASK>
[   52.611247] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460) 
[   52.611551] ? exc_general_protection (arch/x86/kernel/traps.c:751 arch/x86/kernel/traps.c:693) 
[   52.611863] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:617) 
[   52.612170] ? pcpu_alloc_noprof (mm/percpu.c:1824) 
[   52.612460] ? pcpu_alloc_noprof (mm/percpu.c:1801 (discriminator 1)) 
[   52.612747] ? pgd_alloc (arch/x86/mm/pgtable.c:485) 
[   52.613046] mm_init (./include/linux/mm_types.h:1188 (discriminator 1) kernel/fork.c:1299 (discriminator 1)) 
[   52.613332] ? __asan_memset (mm/kasan/shadow.c:84 (discriminator 2)) 
[   52.613626] alloc_bprm (fs/exec.c:383 fs/exec.c:1617) 
[   52.613922] do_execveat_common.isra.0 (fs/exec.c:1972) 
[   52.614265] ? getname_flags.part.0 (./arch/x86/include/asm/atomic.h:28 ./include/linux/atomic/atomic-arch-fallback.h:503 ./include/linux/atomic/atomic-instrumented.h:68 fs/namei.c:207) 
[   52.614585] __x64_sys_execve (fs/exec.c:2166 (discriminator 1)) 
[   52.614982] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[   52.615283] ? fpregs_assert_state_consistent (arch/x86/kernel/fpu/context.h:38 (discriminator 1) arch/x86/kernel/fpu/core.c:822 (discriminator 1)) 
[   52.615590] ? syscall_exit_to_user_mode (./arch/x86/include/asm/entry-common.h:57 (discriminator 1) ./arch/x86/include/asm/entry-common.h:65 (discriminator 1) ./include/linux/entry-common.h:330 (discriminator 1) kernel/entry/common.c:207 (discriminator 1) kernel/entry/common.c:218 (discriminator 1)) 
[   52.615889] ? do_syscall_64 (./arch/x86/include/asm/cpufeature.h:178 arch/x86/entry/common.c:98) 
[   52.616192] ? do_syscall_64 (./arch/x86/include/asm/cpufeature.h:178 arch/x86/entry/common.c:98) 
[   52.616484] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   52.616787] RIP: 0033:0x7f4f99c23bd7
[ 52.617113] Code: eb cf e8 fc e9 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 05 e9 53 10 00 48 8b 10 e9 01 00 00 00 90 b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 21 52 10 00 f7 d8 64 89 01 48
All code
========
   0:	eb cf                	jmp    0xffffffffffffffd1
   2:	e8 fc e9 03 00       	call   0x3ea03
   7:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   e:	00 00 00 
  11:	66 90                	xchg   %ax,%ax
  13:	48 8b 05 e9 53 10 00 	mov    0x1053e9(%rip),%rax        # 0x105403
  1a:	48 8b 10             	mov    (%rax),%rdx
  1d:	e9 01 00 00 00       	jmp    0x23
  22:	90                   	nop
  23:	b8 3b 00 00 00       	mov    $0x3b,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 21 52 10 00 	mov    0x105221(%rip),%rcx        # 0x10525b
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 21 52 10 00 	mov    0x105221(%rip),%rcx        # 0x105231
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   52.617816] RSP: 002b:00007f4f99b1de68 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[   52.618198] RAX: ffffffffffffffda RBX: 00007ffebf5ac9e0 RCX: 00007f4f99c23bd7
[   52.618538] RDX: 000055cfaca1a040 RSI: 00007ffebf5acb90 RDI: 000055cf7b57e6a3
[   52.618878] RBP: 00007f4f99b1dff0 R08: 0000000000000000 R09: 0000000000000000
[   52.619261] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffebf5ac710
[   52.619606] R13: 0000000000000040 R14: 0000000000000001 R15: 00007f4f99b1df20
[   52.619952]  </TASK>
[   52.620288] Modules linked in: cfg80211 8021q garp stp mrp llc ppdev e1000 evdev parport_pc input_leds i2c_piix4 mac_hid intel_agp parport pcspkr intel_gtt i2c_smbus tiny_power_button button rfkill vhost_vsock vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost_iotlb tap vfio_iommu_type1 vfio iommufd uhid hid dm_mod uinput userio ppp_generic slhc tun loop cuse fuse ext4 crc32c_generic crc16 mbcache jbd2 bochs drm_vram_helper drm_ttm_helper ttm agpgart drm_kms_helper sd_mod ata_generic pata_acpi ata_piix drm libata scsi_mod serio_raw scsi_common qemu_fw_cfg
```

Reverting A from B~1 fixes things.

B is affected, with a stack trace similar to the one I already sent.
Reverting A from B does not fix things, but the stack trace changes:

```
[   43.955734] kernel BUG at kernel/power/snapshot.c:259!
[   43.955813] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[   43.956199] CPU: 0 UID: 0 PID: 560 Comm: zzz Kdump: loaded Not tainted 6.11.0_ricci+ #6
[   43.956496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   43.956769] RIP: 0010:memory_bm_free (kernel/power/snapshot.c:259 (discriminator 1) kernel/power/snapshot.c:582 (discriminator 1) kernel/power/snapshot.c:732 (discriminator 1)) 
[ 43.957079] Code: ff 45 85 e4 74 9c 48 8b 3d e0 86 da 04 48 85 ff 74 90 48 89 de 48 2b 35 f1 ed e3 02 48 c1 fe 06 e8 a0 fb ff ff e9 78 ff ff ff <0f> 0b 4d 8b 36 4d 39 f7 0f 85 be fe ff ff 49 8b 6f 10 48 85 ed 75
All code
========
   0:	ff 45 85             	incl   -0x7b(%rbp)
   3:	e4 74                	in     $0x74,%al
   5:	9c                   	pushf
   6:	48 8b 3d e0 86 da 04 	mov    0x4da86e0(%rip),%rdi        # 0x4da86ed
   d:	48 85 ff             	test   %rdi,%rdi
  10:	74 90                	je     0xffffffffffffffa2
  12:	48 89 de             	mov    %rbx,%rsi
  15:	48 2b 35 f1 ed e3 02 	sub    0x2e3edf1(%rip),%rsi        # 0x2e3ee0d
  1c:	48 c1 fe 06          	sar    $0x6,%rsi
  20:	e8 a0 fb ff ff       	call   0xfffffffffffffbc5
  25:	e9 78 ff ff ff       	jmp    0xffffffffffffffa2
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	4d 8b 36             	mov    (%r14),%r14
  2f:	4d 39 f7             	cmp    %r14,%r15
  32:	0f 85 be fe ff ff    	jne    0xfffffffffffffef6
  38:	49 8b 6f 10          	mov    0x10(%r15),%rbp
  3c:	48 85 ed             	test   %rbp,%rbp
  3f:	75                   	.byte 0x75

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	4d 8b 36             	mov    (%r14),%r14
   5:	4d 39 f7             	cmp    %r14,%r15
   8:	0f 85 be fe ff ff    	jne    0xfffffffffffffecc
   e:	49 8b 6f 10          	mov    0x10(%r15),%rbp
  12:	48 85 ed             	test   %rbp,%rbp
  15:	75                   	.byte 0x75
[   43.957766] RSP: 0018:ffff8881382a7970 EFLAGS: 00010246
[   43.958130] RAX: 0000000000000000 RBX: ffff8881036dc000 RCX: 0000000000000000
[   43.958493] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000001
[   43.958801] RBP: ffff888137757070 R08: 0000000000000000 R09: ffffed10271388a0
[   43.959149] R10: ffff8881389c4507 R11: 000000000000002f R12: 0000000000000001
[   43.959471] R13: ffff888137757018 R14: ffff888137757008 R15: ffff888137013480
[   43.959762] FS:  00007f893a7f1740(0000) GS:ffff888118e00000(0000) knlGS:0000000000000000
[   43.960071] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.960471] CR2: 00007f893a9779b1 CR3: 00000001382f6000 CR4: 00000000000006f0
[   43.960831] Call Trace:
[   43.961160]  <TASK>
[   43.961444] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[   43.961738] ? do_trap (arch/x86/kernel/traps.c:156 arch/x86/kernel/traps.c:197) 
[   43.962028] ? memory_bm_free (kernel/power/snapshot.c:259 (discriminator 1) kernel/power/snapshot.c:582 (discriminator 1) kernel/power/snapshot.c:732 (discriminator 1)) 
[   43.962307] ? do_error_trap (./arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:218) 
[   43.962582] ? memory_bm_free (kernel/power/snapshot.c:259 (discriminator 1) kernel/power/snapshot.c:582 (discriminator 1) kernel/power/snapshot.c:732 (discriminator 1)) 
[   43.962857] ? handle_invalid_op (arch/x86/kernel/traps.c:256) 
[   43.963142] ? memory_bm_free (kernel/power/snapshot.c:259 (discriminator 1) kernel/power/snapshot.c:582 (discriminator 1) kernel/power/snapshot.c:732 (discriminator 1)) 
[   43.963414] ? exc_invalid_op (arch/x86/kernel/traps.c:316) 
[   43.963718] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621) 
[   43.964062] ? memory_bm_free (kernel/power/snapshot.c:259 (discriminator 1) kernel/power/snapshot.c:582 (discriminator 1) kernel/power/snapshot.c:732 (discriminator 1)) 
[   43.964348] free_basic_memory_bitmaps (kernel/power/snapshot.c:1183) 
[   43.964637] hibernate (kernel/power/hibernate.c:828) 
[   43.964944] state_store (kernel/power/main.c:739) 
[   43.965229] kernfs_fop_write_iter (fs/kernfs/file.c:338) 
[   43.965526] vfs_write (fs/read_write.c:590 fs/read_write.c:683) 
[   43.965813] ? _raw_spin_unlock (./arch/x86/include/asm/preempt.h:103 (discriminator 1) ./include/linux/spinlock_api_smp.h:143 (discriminator 1) kernel/locking/spinlock.c:186 (discriminator 1)) 
[   43.966106] ? do_fcntl (./include/linux/spinlock.h:392 fs/fcntl.c:86 fs/fcntl.c:473) 
[   43.966391] ? __pfx_vfs_write (fs/read_write.c:664) 
[   43.966672] ? __pfx_do_fcntl (fs/fcntl.c:443) 
[   43.966959] ? __pfx_expand_files (fs/file.c:213) 
[   43.967246] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[   43.967527] ksys_write (fs/read_write.c:736) 
[   43.967806] ? __pfx_ksys_write (fs/read_write.c:726) 
[   43.968092] ? __x64_sys_dup2 (fs/file.c:1403 (discriminator 1) fs/file.c:1387 (discriminator 1) fs/file.c:1387 (discriminator 1)) 
[   43.968372] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[   43.968656] ? preempt_count_add (./include/linux/ftrace.h:976 (discriminator 1) kernel/sched/core.c:5710 (discriminator 1) kernel/sched/core.c:5707 (discriminator 1) kernel/sched/core.c:5735 (discriminator 1)) 
[   43.968953] ? fd_install (./arch/x86/include/asm/preempt.h:103 (discriminator 1) ./include/linux/rcupdate.h:964 (discriminator 1) fs/file.c:627 (discriminator 1)) 
[   43.969233] ? f_dupfd (fs/file.c:1433) 
[   43.969510] ? do_fcntl (fs/fcntl.c:454 (discriminator 1)) 
[   43.969787] ? preempt_count_add (./include/linux/ftrace.h:976 (discriminator 1) kernel/sched/core.c:5710 (discriminator 1) kernel/sched/core.c:5707 (discriminator 1) kernel/sched/core.c:5735 (discriminator 1)) 
[   43.970072] ? __pfx_do_fcntl (fs/fcntl.c:443) 
[   43.970347] ? __pfx_locks_remove_posix (fs/locks.c:2610) 
[   43.970634] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:107 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
[   43.970904] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[   43.971178] ? file_close_fd_locked (./arch/x86/include/asm/bitops.h:94 ./include/asm-generic/bitops/instrumented-non-atomic.h:45 fs/file.c:267 fs/file.c:572 fs/file.c:657) 
[   43.971440] ? fpregs_assert_state_consistent (arch/x86/kernel/fpu/context.h:38 (discriminator 1) arch/x86/kernel/fpu/core.c:822 (discriminator 1)) 
[   43.971705] ? syscall_exit_to_user_mode (./arch/x86/include/asm/entry-common.h:57 (discriminator 1) ./arch/x86/include/asm/entry-common.h:65 (discriminator 1) ./include/linux/entry-common.h:330 (discriminator 1) kernel/entry/common.c:207 (discriminator 1) kernel/entry/common.c:218 (discriminator 1)) 
[   43.971957] ? do_syscall_64 (./arch/x86/include/asm/cpufeature.h:178 arch/x86/entry/common.c:98) 
[   43.972187] ? fpregs_assert_state_consistent (arch/x86/kernel/fpu/context.h:38 (discriminator 1) arch/x86/kernel/fpu/core.c:822 (discriminator 1)) 
[   43.972421] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   43.972654] RIP: 0033:0x7f893a8ef5d0
[ 43.972909] Code: Unable to access opcode bytes at 0x7f893a8ef5a6.

Code starting with the faulting instruction
===========================================
[   43.973166] RSP: 002b:00007fffd0672248 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   43.973413] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f893a8ef5d0
[   43.973660] RDX: 0000000000000004 RSI: 000055fcbd647b00 RDI: 0000000000000001
[   43.973901] RBP: 000055fcbd647b00 R08: 0000000000000002 R09: 000000000000003f
[   43.974145] R10: 00007f893a8a0b00 R11: 0000000000000202 R12: 0000000000000001
[   43.974379] R13: 0000000000000004 R14: 0000000000000000 R15: 000055fcbd647900
[   43.974616]  </TASK>
[   43.974832] Modules linked in: cfg80211 8021q garp stp mrp llc ppdev e1000 evdev parport_pc input_leds i2c_piix4 mac_hid intel_agp pcspkr parport intel_gtt i2c_smbus tiny_power_button button rfkill vhost_vsock vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost_iotlb tap vfio_iommu_type1 vfio iommufd uhid hid dm_mod uinput userio ppp_generic slhc tun loop cuse fuse ext4 crc32c_generic crc16 mbcache jbd2 bochs drm_vram_helper drm_ttm_helper ttm agpgart drm_kms_helper sd_mod ata_generic pata_acpi ata_piix drm libata scsi_mod serio_raw scsi_common qemu_fw_cfg
```

Now, the weird thing is that tag "mm-nonmm-stable-2024-09-21-07-52" from
akpm's tree is affected but could be fixed by reverting A.

My guess is that the problem was originally introduced by A, then B
introduced some other bug; but none of the commits merged is the cause,
rather it's something related to how the merge conflicts were resolved.
I can't tell whether my guess is correct or not because I know nothing
about kernel's internals, so I'm not able to resolve the merge
conflicts.
For the same reason I can't revert B from current mainline.

Another odd thing I discovered is that the issue disappears if I disable
loadable modules support (CONFIG_MODULES=n). I don't know if this
information is useful.
Also, I can't reproduce with the default config (make defconfig),
therefore something in my config (I already sent it) may play a role.

