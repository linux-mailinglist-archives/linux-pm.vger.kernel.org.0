Return-Path: <linux-pm+bounces-24599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0DA753F2
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 02:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A2D1896D36
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 01:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D682EAE4;
	Sat, 29 Mar 2025 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVJDaLVm"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9315A8
	for <linux-pm@vger.kernel.org>; Sat, 29 Mar 2025 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743212665; cv=none; b=svTJNi5+uXut2CCzacMYn8dEhQLYFhHCrFDHOLSBd+IjrhrAr1w1IOLFLPSy7helat8avcTt3y0McvlvenV3yelYCUzt5zeZyi2CDpEMmj9RVSsrDIqBkwLccmT1dXutsP97tBVDkiaAB2d9z6z/1MW4I0Xa+UTNnPOjMrZKB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743212665; c=relaxed/simple;
	bh=DnV7vRN0lEH6EzXjMbUXtQUHI3fnnZRqw/5IC56SvFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keCfjmSEYTUwvXgV+fGePzyqQ1copnALF0y7skNeXCFMgDd5o6GnMrAFCpOVaY1po52tdi3FnDAF0iXY54ZgFGO7wOiuReqBkrHJuqx+msc03R/D3HeN2P1CHUndvSlmfBiBZ18sqxV60D5O6SpLgKcX7fd9kvO3BzJCYoPqwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVJDaLVm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743212660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rrchpPNwlMYuDeEE/R/ZDKIqGUjMFbA0Mk/lyFLmNEU=;
	b=TVJDaLVmGzYc1y6fFe30lcVXG17M1yojvbAIkGF71pe62RfsHvVvvHpkFji/yQAdejlXSS
	J5vtAkwYDrwVa7ZO30BrRYBHussHAvEkM4x5YcYHCaezKMkP5E7nLgmCL+EEX5avh3FD6E
	hh1FfOeAK/cFlBcACNCU3Bv6CMBZC84=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-UkCKEg-cOlK3QBJdhl5i_w-1; Fri,
 28 Mar 2025 21:44:17 -0400
X-MC-Unique: UkCKEg-cOlK3QBJdhl5i_w-1
X-Mimecast-MFC-AGG-ID: UkCKEg-cOlK3QBJdhl5i_w_1743212656
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FE8F196D2CC;
	Sat, 29 Mar 2025 01:44:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A927D180175A;
	Sat, 29 Mar 2025 01:44:11 +0000 (UTC)
Date: Sat, 29 Mar 2025 09:44:06 +0800
From: Baoquan He <bhe@redhat.com>
To: Roberto Ricci <io@r-ricci.it>
Cc: Dave Young <dyoung@redhat.com>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-c7V2hptt9U9UCl@desktop0a>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/29/25 at 01:14am, Roberto Ricci wrote:
> On 2025-01-27 10:42 +0800, Dave Young wrote:
> > On Mon, 27 Jan 2025 at 10:39, Dave Young <dyoung@redhat.com> wrote:
> > > On 01/13/25 at 10:28pm, Roberto Ricci wrote:
> > > > After rebooting the system via kexec, hibernating and rebooting the machine, this oops occurs:
> > > >
> > > [snip]
> > > >
> > > > I will send the kernel config and dmesg in replies to this email.
> > > >
> > >
> > > I tried your config (removed some config driver related which is not useful), but it can not boot on my kvm guest.
> > > Firstly I saw a panic in ftrace path,  then I rebuilt the kernel without ftrace, it panicked again but in kvm related code path.
> > > Both are not related to kexec at all so I suspect your bug is not kexec specific.
> > >
> > > [snip]
> > >
> > > You can find the kernel config here (with the ftrace enabled):
> > > https://people.redhat.com/~ruyang/snakeyear/panic-ftrace.config
> > 
> > BTW, if I disable KASAN then kernel can boot, anyway kexec +
> > hibernation works fine with a few tests, no panics.
> > 
> > >
> > > Thanks
> > > Dave
> 
> Hi,
> 
> sorry for the late reply. I tried your modified config, but I'm getting
> the same oops I originally reported. No idea why the oops is not
> happening for you.

Not that oops is not happening in my side, I can't boot kernel built
with you provided config on Fedora OS. 

> 
> Anyway, I performed yet another bisection, this time with just plain
> defconfig plus CONFIG_KEXEC_FILE=y, and I got different results.
> 
> Updated steps to reproduce:
> 1. Boot kernel >= v6.8 in a virtual machine created with this command:
>    `qemu-system-x86_64 -enable-kvm -smp 1 -m 4.0G -hda disk.qcow2`
> 2. Load the same kernel with:
>    `kexec --kexec-file-syscall -l /boot/vmlinuz-6.14.0 --initrd /boot/initramfs-6.14.0.img --reuse-cmdline`
> 3. Reboot (or call `kexec -e` directly)
> 4. Hibernate and reboot: `printf reboot >/sys/power/disk && printf disk >/sys/power/state`
> 5. Upon resuming, three things could happen, depending on luck:

OK, this is a little complicated. wondering why you need to do the
hibernation and reboot. Just for curiosity.

> 5a. A kernel oops:
> ```
> [   42.574201] BUG: kernel NULL pointer dereference, address: 0000000000000000
...snip... 
> I will send config and dmesg in replies to this email.
> 
> The bisection pointed to
> b3ba234171cd kexec_file: load kernel at top of system RAM if required
> 
> #regzbot introduced: b3ba234171cd0d58df0a13c262210ff8b5fd2830
> 
> Now that I think about it, this was the commit I found when I did the
> very first bisection after I found the bug. But I could not get the same
> result with subsequent bisections, so I didn't mention it in my original
> report.
> 
> When reverting b3ba234171cd on top of v6.14, merge conflicts must be
> solved, I hope I did it right:

I doubt how this caused the failure. I have several questions, could you
help answer:

1) Can this problem be stably reproduced with kexec_file_load?

2) if answer to 1) is yes, can reverting b3ba234171cd fix it stably?

3) If answer to 1) and 2) is yes, does kexec_load works for you? Asking
this because kexec_load interface defaults to put kexec kernel on top of
system RAM which is equivalent to applying commit b3ba234171cd.

4) Can you add '-d' to 'kexec -l' to print more debugging message?

5) Can normal kexec trigger the failure? I mean operating kexec w/o
the hibernation/resumption. 

> 
> ```
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..3014be212afd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -614,10 +614,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
>                                            crashk_res.start, crashk_res.end,
>                                            kbuf, func);
>  #endif
> -       if (kbuf->top_down)
> -               return walk_system_ram_res_rev(0, ULONG_MAX, kbuf, func);
> -       else
> -               return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
> +       return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
>  }
> 
>  /**
> ```
> 
> Applying this diff solves the problem for v6.14.
> 


