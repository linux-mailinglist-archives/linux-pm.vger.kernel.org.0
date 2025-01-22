Return-Path: <linux-pm+bounces-20805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF4A191F7
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBCF16BD17
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590D12CD96;
	Wed, 22 Jan 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="FTfL7UZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B74315E
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550885; cv=none; b=BpzV5nyKZQF+pv3LqsNOmgO2uB3N2+0Bc1PsIyrdxGlzs8qnz0VMtsTP+eo03M2X8IEfl8r6YvTeMpTBpF4cWNMAkoEQhijrjzOcuez+Rlz9wIV5y6K9rneqXOlfSwgaRNAHfR3HM7VFLjfSjJaVurweGKN1RzxdShh6DikLZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550885; c=relaxed/simple;
	bh=7+EgZBd/xRCCf4ESV6cwj0q/MEOM2EvCQU/M+W1ss5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyCVe21YqnsySjayRkpq7nOiHxIsOOtTgP5NPSkVRITideCmbxaSkNyumz0Vj12+AFOaYqpQG18FRxAOmrMSYIim22I0MCtNLUqYTkE2Si188XL23ZpH2mMF8tmXBHPLesgMuqb1s3zF3iVAjHruS3EAKvT2CTlPx9rgMCiyLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=FTfL7UZT; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Wed, 22 Jan 2025 14:01:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1737550876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2phdRioz+FPeu2qwKUYHdIsmJATa7bzMGgHi9VlFHo=;
	b=FTfL7UZTsxDgahGFlDHjMsxRy3TFUFJosHWHwbYxc4KCdjdAX3AfEFqEEPWVggte/W5i5T
	//NlabcvalcZnazUIma/vyF+Khg5JhBmNHpX+Two97l1iHu5OVmmHSJEudrM87NaC8E4XJ
	B3d1BBuPQb+lXA0Vl8cCHR5z3kOWytna4TrKneHGzFBTD8I0HQNpriqRUSPCyoLkRRneC2
	XkSCx9dCoMJjYweVEFoFZPbWMneS6aBsbksvf58yvSlaAgtC38ZLcf0VsRqqrB/6VKSr9X
	WcUilMOUdRLXuDxp5EvpaQrImwCJwsy14MqbAmmW3SMk+ON4WVCRsmY2duYdlg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: RuiRui Yang <ruyang@redhat.com>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z5DsGE4n2uYWedRX@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <CALu+AoQhCjUPr2dnYdN751dyUgNUpyx1HCfyztF5GaP3QRzibQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoQhCjUPr2dnYdN751dyUgNUpyx1HCfyztF5GaP3QRzibQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2025-01-22 Wed 17:45:41 +0800, RuiRui Yang wrote:
> > I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> > running Void Linux, with the following commands:
> >
> > ```
> > # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> > # reboot
> > # printf reboot >/sys/power/disk
> > # printf disk >/sys/power/state
> > ```
> 
> Which kexec-tools version have you used?  I'm just asking to see which
> syscall is used for loading the new kernel.   From your bisect results
> it seems kexec_file_load, but just a double check as kexec_load and
> kexec_file_load use different sources for building the e820 table.

I have kexec-tools 2.0.29. strace confirms that kexec_file_load() is being used:

```
execve("/usr/sbin/kexec", ["kexec", "-l", "/boot/vmlinuz-6.13.0_ricci", "--initrd=/boot/initramfs-6.13.0_"..., "--reuse-cmdline"], 0x7ffeab8e8910 /* 15 vars */) = 0
brk(NULL)                               = 0x55f2897ea000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=10415, ...}) = 0
mmap(NULL, 10415, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7ff2d596e000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/liblzma.so.5", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=194704, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff2d596c000
mmap(NULL, 192544, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7ff2d593c000
mmap(0x7ff2d5940000, 122880, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4000) = 0x7ff2d5940000
mmap(0x7ff2d595e000, 49152, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x7ff2d595e000
mmap(0x7ff2d596a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e000) = 0x7ff2d596a000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=100488, ...}) = 0
mmap(NULL, 102416, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7ff2d5922000
mmap(0x7ff2d5925000, 57344, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7ff2d5925000
mmap(0x7ff2d5933000, 28672, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11000) = 0x7ff2d5933000
mmap(0x7ff2d593a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) = 0x7ff2d593a000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\236\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
fstat(3, {st_mode=S_IFREG|0755, st_size=12652992, ...}) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
mmap(NULL, 2006416, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7ff2d5738000
mmap(0x7ff2d5760000, 1413120, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x28000) = 0x7ff2d5760000
mmap(0x7ff2d58b9000, 352256, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x181000) = 0x7ff2d58b9000
mmap(0x7ff2d590f000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d6000) = 0x7ff2d590f000
mmap(0x7ff2d5915000, 52624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7ff2d5915000
close(3)                                = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff2d5735000
arch_prctl(ARCH_SET_FS, 0x7ff2d5735740) = 0
set_tid_address(0x7ff2d5735a10)         = 587
set_robust_list(0x7ff2d5735a20, 24)     = 0
rseq(0x7ff2d5736060, 0x20, 0, 0x53053053) = 0
mprotect(0x7ff2d590f000, 16384, PROT_READ) = 0
mprotect(0x7ff2d593a000, 4096, PROT_READ) = 0
mprotect(0x7ff2d596a000, 4096, PROT_READ) = 0
mprotect(0x55f260483000, 20480, PROT_READ) = 0
mprotect(0x7ff2d59a9000, 8192, PROT_READ) = 0
prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
munmap(0x7ff2d596e000, 10415)           = 0
access("/proc/xen", F_OK)               = -1 ENOENT (No such file or directory)
getrandom("\xa1\x28\xc8\xbe\xf9\xc2\xac\xa0", 8, GRND_NONBLOCK) = 8
brk(NULL)                               = 0x55f2897ea000
brk(0x55f28980b000)                     = 0x55f28980b000
openat(AT_FDCWD, "/boot/vmlinuz-6.13.0_ricci", O_RDONLY) = 3
lseek(3, 0, SEEK_CUR)                   = 0
read(3, "MZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) = 8192
close(3)                                = 0
openat(AT_FDCWD, "/boot/vmlinuz-6.13.0_ricci", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26563072, ...}) = 0
read(3, "MZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
close(3)                                = 0
openat(AT_FDCWD, "/boot/vmlinuz-6.13.0_ricci", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26563072, ...}) = 0
mmap(NULL, 26566656, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7ff2d3ddf000
read(3, "MZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 26563072) = 26563072
close(3)                                = 0
close(3)                                = -1 EBADF (Bad file descriptor)
memfd_create("kernel", MFD_ALLOW_SEALING) = 3
write(3, "MZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 26563072) = 26563072
openat(AT_FDCWD, "/proc/cmdline", O_RDONLY) = 4
read(4, "BOOT_IMAGE=/boot/vmlinuz-6.13.0_"..., 128) = 128
read(4, "el=512M\n", 128)               = 8
read(4, "", 120)                        = 0
read(4, "", 376)                        = 0
openat(AT_FDCWD, "/boot/initramfs-6.13.0_ricci.img", O_RDONLY) = 5
kexec_file_load(3, 5, 98, "root=UUID=71b5e20d-efaa-4c09-b18"..., 0) = 0
close(3)                                = 0
sync()                                  = 0
exit_group(0)                           = ?
+++ exited with 0 +++
```

The issue persists with the latest 6.13 kernel.

I also noticed that the bug is not 100% deterministic, but occurs most
of the times. I could test again with KMSAN and KCSAN, if I have a bit
of time this week.

