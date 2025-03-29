Return-Path: <linux-pm+bounces-24595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33BA7539D
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 01:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180413AE590
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 00:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17551819;
	Sat, 29 Mar 2025 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="Ps0FphjZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106E635
	for <linux-pm@vger.kernel.org>; Sat, 29 Mar 2025 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743207270; cv=none; b=HKwdLj2fPhrGWCOdQ83F/uZzfsMCJZnRuObfE7KxXHjaA7UTXcCL44UCHo6iHqPJqnvw0l7FKeScrM6aMC54eeADgwiGZCPnC761yrdarLVCLDLo3mWRtIybz6920oEXyXUV+JjqGzHZ1BDTawvQJfB7oyuOY2dNOI3soO3DZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743207270; c=relaxed/simple;
	bh=yELwC7Jm7oaJNhOb+/l0AJpibERj9nsAmIKEJMJotWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXTdg/RIOYRec0NDBVaYA2OfSLJyjP4tgVx+H57cUKGsO1yVFtSKNLY2ULO25qyOeJh8RqlbCcwkk8EdEXV8buHn3CGAkjoZaJuPXlZmqcJq2KGHVwSmI+sf+eG7MYYCd52KM5pYQEkBGLPY2r7+uRoEzt6WJeMEHdVg0lcDzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=Ps0FphjZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Sat, 29 Mar 2025 01:14:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743207259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNax2lMaBXSLUMj+8x9Q7eUm8I0qR5/VNqQoOVPR7Zk=;
	b=Ps0FphjZRgKW9P0/HENf9nFKPoJUopvJ0UYw6SeGiMbGNMfmCWT7XdFTxoio7+Gr+2kyD0
	YBI4V4pmYqW85SLenRHlnK7XriK0mJW/DnPlLjwA7mYNqO6lz9mkU+P8Nnn/7JoBRyxIYU
	JXHHnDfHJ80Wpulp+veJ6rhmrff262PLEDrliwkPazJT7j1wO9A1CKBspM0Mvb7+lWt2IA
	uQGmQ5eV2lvF9Y2lgi5tiBRmnPRQZ1IfzWBxe8m3OK3jxSqCWevc1ozoJD9b9Ig7aC3QjS
	lZiIbiFAQwT4KY82iKKeOhC6T+/HbYpt/MP5Ok6StBCF6kUdoIcQVuOTDvRDOQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Dave Young <dyoung@redhat.com>, bhe@redhat.com
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z-c7V2hptt9U9UCl@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2025-01-27 10:42 +0800, Dave Young wrote:
> On Mon, 27 Jan 2025 at 10:39, Dave Young <dyoung@redhat.com> wrote:
> > On 01/13/25 at 10:28pm, Roberto Ricci wrote:
> > > After rebooting the system via kexec, hibernating and rebooting the machine, this oops occurs:
> > >
> > [snip]
> > >
> > > I will send the kernel config and dmesg in replies to this email.
> > >
> >
> > I tried your config (removed some config driver related which is not useful), but it can not boot on my kvm guest.
> > Firstly I saw a panic in ftrace path,  then I rebuilt the kernel without ftrace, it panicked again but in kvm related code path.
> > Both are not related to kexec at all so I suspect your bug is not kexec specific.
> >
> > [snip]
> >
> > You can find the kernel config here (with the ftrace enabled):
> > https://people.redhat.com/~ruyang/snakeyear/panic-ftrace.config
> 
> BTW, if I disable KASAN then kernel can boot, anyway kexec +
> hibernation works fine with a few tests, no panics.
> 
> >
> > Thanks
> > Dave

Hi,

sorry for the late reply. I tried your modified config, but I'm getting
the same oops I originally reported. No idea why the oops is not
happening for you.

Anyway, I performed yet another bisection, this time with just plain
defconfig plus CONFIG_KEXEC_FILE=y, and I got different results.

Updated steps to reproduce:
1. Boot kernel >= v6.8 in a virtual machine created with this command:
   `qemu-system-x86_64 -enable-kvm -smp 1 -m 4.0G -hda disk.qcow2`
2. Load the same kernel with:
   `kexec --kexec-file-syscall -l /boot/vmlinuz-6.14.0 --initrd /boot/initramfs-6.14.0.img --reuse-cmdline`
3. Reboot (or call `kexec -e` directly)
4. Hibernate and reboot: `printf reboot >/sys/power/disk && printf disk >/sys/power/state`
5. Upon resuming, three things could happen, depending on luck:
5a. A kernel oops:
```
[   42.574201] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   42.574680] #PF: supervisor read access in kernel mode
[   42.575001] #PF: error_code(0x0000) - not-present page
[   42.575324] PGD 0 P4D 0
[   42.575556] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[   42.575860] CPU: 0 UID: 0 PID: 535 Comm: dhcpcd Kdump: loaded Not tainted 6.14.0 #1
[   42.576333] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   42.576926] RIP: 0010:pcpu_alloc_noprof (??:?) 
[ 42.577242] Code: 39 c6 0f 8f 0b 01 00 00 44 89 7c 24 40 48 8b 05 f6 f3 40 01 4c 89 74 24 20 4c 63 ce 49 c1 e1 04 4a 8d 0c 08 4d 89 cf 48 8b 19 <4c> 8b 33 48 39 d9 0f 84 c4 00 00 00 89 34 24 eb 34 89 c1 4c 89 e2
All code
========
   0:	39 c6                	cmp    %eax,%esi
   2:	0f 8f 0b 01 00 00    	jg     0x113
   8:	44 89 7c 24 40       	mov    %r15d,0x40(%rsp)
   d:	48 8b 05 f6 f3 40 01 	mov    0x140f3f6(%rip),%rax        # 0x140f40a
  14:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
  19:	4c 63 ce             	movslq %esi,%r9
  1c:	49 c1 e1 04          	shl    $0x4,%r9
  20:	4a 8d 0c 08          	lea    (%rax,%r9,1),%rcx
  24:	4d 89 cf             	mov    %r9,%r15
  27:	48 8b 19             	mov    (%rcx),%rbx
  2a:*	4c 8b 33             	mov    (%rbx),%r14		<-- trapping instruction
  2d:	48 39 d9             	cmp    %rbx,%rcx
  30:	0f 84 c4 00 00 00    	je     0xfa
  36:	89 34 24             	mov    %esi,(%rsp)
  39:	eb 34                	jmp    0x6f
  3b:	89 c1                	mov    %eax,%ecx
  3d:	4c 89 e2             	mov    %r12,%rdx

Code starting with the faulting instruction
===========================================
   0:	4c 8b 33             	mov    (%rbx),%r14
   3:	48 39 d9             	cmp    %rbx,%rcx
   6:	0f 84 c4 00 00 00    	je     0xd0
   c:	89 34 24             	mov    %esi,(%rsp)
   f:	eb 34                	jmp    0x45
  11:	89 c1                	mov    %eax,%ecx
  13:	4c 89 e2             	mov    %r12,%rdx
[   42.578146] RSP: 0018:ffffa083804b7de8 EFLAGS: 00010002
[   42.578466] RAX: ffff8bc0bfffa5c0 RBX: 0000000000000000 RCX: ffff8bc0bfffa5e0
[   42.578848] RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffffffff9d77bb04
[   42.579232] RBP: 0000000000000004 R08: 000000010004e063 R09: 0000000000000020
[   42.579613] R10: 0000000000000000 R11: 000000004dd19067 R12: 0000000000000002
[   42.579994] R13: 0000000000000000 R14: 0000000000000202 R15: 0000000000000020
[   42.580382] FS:  00007f52ed1a3740(0000) GS:ffff8bc0bfa00000(0000) knlGS:0000000000000000
[   42.580867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.581211] CR2: 0000000000000000 CR3: 0000000102398000 CR4: 00000000000006f0
[   42.581595] Call Trace:
[   42.581823]  <TASK>
[   42.582040] ? __die (??:?) 
[   42.582498] ? page_fault_oops (fault.c:?) 
[   42.582784] ? search_extable (??:?) 
[   42.583061] ? pcpu_alloc_noprof (??:?) 
[   42.583354] ? search_module_extables (??:?) 
[   42.583652] ? exc_page_fault (??:?) 
[   42.583930] ? asm_exc_page_fault (??:?) 
[   42.584221] ? pcpu_alloc_noprof (??:?) 
[   42.584509] ? pcpu_alloc_noprof (??:?) 
[   42.584796] mm_init.isra.0 (fork.c:?) 
[   42.585070] alloc_bprm (exec.c:?) 
[   42.585335] do_execveat_common.isra.0 (exec.c:?) 
[   42.585638] __x64_sys_execve (??:?) 
[   42.585912] do_syscall_64 (??:?) 
[   42.586185] entry_SYSCALL_64_after_hwframe (??:?) 
[   42.586500] RIP: 0033:0x7f52ed27bbd7
[ 42.586766] Code: eb cf e8 fc e9 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 05 e9 53 10 00 48 8b 10 e9 01 00 00 00 90 b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 21 52 10 00 f7 d8 64 89 01 48
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
[   42.587811] RSP: 002b:00007f52ed175e68 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[   42.588313] RAX: ffffffffffffffda RBX: 00007ffec82864f0 RCX: 00007f52ed27bbd7
[   42.588683] RDX: 00005581792386d0 RSI: 00007ffec82866a0 RDI: 000055816c62b6a3
[   42.589052] RBP: 00007f52ed175ff0 R08: 0000000000000000 R09: 0000000000000000
[   42.589468] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffec8286220
[   42.589838] R13: 0000000000000040 R14: 0000000000000001 R15: 00007f52ed175f20
[   42.590487]  </TASK>
[   42.590705] Modules linked in:
[   42.590949] CR2: 0000000000000000
```
5b. The system hangs
5c. The system resumes, but if you execute again the command in step 2,
    it fails

I will send config and dmesg in replies to this email.

The bisection pointed to
b3ba234171cd kexec_file: load kernel at top of system RAM if required

#regzbot introduced: b3ba234171cd0d58df0a13c262210ff8b5fd2830

Now that I think about it, this was the commit I found when I did the
very first bisection after I found the bug. But I could not get the same
result with subsequent bisections, so I didn't mention it in my original
report.

When reverting b3ba234171cd on top of v6.14, merge conflicts must be
solved, I hope I did it right:

```
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..3014be212afd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -614,10 +614,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
                                           crashk_res.start, crashk_res.end,
                                           kbuf, func);
 #endif
-       if (kbuf->top_down)
-               return walk_system_ram_res_rev(0, ULONG_MAX, kbuf, func);
-       else
-               return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
+       return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }

 /**
```

Applying this diff solves the problem for v6.14.

