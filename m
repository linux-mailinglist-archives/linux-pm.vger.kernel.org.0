Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC189120
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfHKJqe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 05:46:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37580 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfHKJqd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 05:46:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so100961930eds.4;
        Sun, 11 Aug 2019 02:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9BeOw8Uu2quOpfN1Fz6s59CWeM59ggKmEfAja51g3bE=;
        b=nPwIydAXCS1xxU/OjpFyu5qZYYSLyVmpxqnTmBpNsVEra6l+UPhcoNDstyhyg17gfX
         zuAGgX0gLJoGERvZNYJ0nVZ5msTBmaD/KINjyXrCrJrBqmfap4xmsMFelDWFVx3buoeb
         +lztWhVT75kcb7CD8Nbo0AONmWxMueY8sB3H9FYwbjmqr/IeQvgA4xm/E6wQ6dCTyomH
         Em5AvzLdgDgGKIdBR5eYzy+YqAGOSnjQLK+AaxEfOjyJojBhfVTxErFJg9H9p8LHb21O
         X8vZrov9/HS/zVsCswZ6qBoP3yRxCBI6HgAV5Ps6aWU8AaW+wJJY6tRrXULSBBT/uppv
         HYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9BeOw8Uu2quOpfN1Fz6s59CWeM59ggKmEfAja51g3bE=;
        b=qYBC2slo8c3MMn22SmJnXzTZMEArOY4k47e+cSKD/JOpmsPu6YJP1QjeuTkTx901KB
         5RK7ZQjt7DCOF0cho18hYN+ZjVYi2dHntYTg8McwMTPeCLnZegAoFOPK42rYEqhRePNV
         9XWalV5TjmwZYRWe61k21vuEFRpMTaG9P0slRu1ncnKnlqCq0OixW6dct1Gg9Swz9ELW
         1UcJqYqFXDU1TFHwQgCM5IxuJVlSSv/f9zkSeWDw07bOEcyK36TZTBhc7Sw1uPVfcc4+
         hF5S8wwxFpSuL/JqdY7ADZitzXgQw7n1DaYcHhG60IG9rD3K2NYquC6/BvyfiD0y+06H
         KeyA==
X-Gm-Message-State: APjAAAW9/RF+KlpOmNrm1w5yf152a3E97ol4t97+z0finQ8Jnzyj+6/h
        1nK7sj9lHE7bF7XgLoQTDwk/IijJPZo=
X-Google-Smtp-Source: APXvYqyMrSkzivMD8igLqxNXfU025m0/vmS+bwi0lqjfvd5jzkQ3vvr6p5f9+rBAMZ5GLTEMYVwhBg==
X-Received: by 2002:a17:906:1e89:: with SMTP id e9mr27040006ejj.56.1565516791454;
        Sun, 11 Aug 2019 02:46:31 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id f21sm23144299edj.36.2019.08.11.02.46.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 02:46:31 -0700 (PDT)
Date:   Sun, 11 Aug 2019 11:46:30 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [Linux 5.2.x]
 /sys/kernel/debug/tracing/events/power/cpu_idle/id: BUG: kernel NULL pointer
 dereference, address: 0000000000000000
Message-ID: <20190811094630.GA18925@eldamar.local>
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de>
 <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de>
 <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de>
 <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
 <alpine.DEB.2.21.1908110822110.7324@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1908110822110.7324@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi,

On Sun, Aug 11, 2019 at 08:22:35AM +0200, Thomas Gleixner wrote:
> On Sat, 10 Aug 2019, Paul Menzel wrote:
> 
> Cc+ Steven
> 
> > [+ INTEL IDLE DRIVER]
> > 
> > Dear Linux folks,
> > 
> > 
> > On 10.08.19 20:28, Paul Menzel wrote:
> > 
> > > On 10.08.19 19:31, Thomas Gleixner wrote:
> > > 
> > > > On Sat, 10 Aug 2019, Paul Menzel wrote:
> > > > > 
> > > > > I have no idea, who to report this to, so I please refer me to the
> > > > > correct
> > > > > list.
> > > > 
> > > > I have no idea yet either :)
> > > > 
> > > > > With Linux 5.2.7 from Debian Sid/unstable and PowerTOP 2.10, executing
> > > > > 
> > > > >      sudo powertop --auto-tune
> > > > > 
> > > > > causes a NULL pointer dereference, and the graphical session crashes due
> > > > > to an
> > > > > effect on the i915 driver. It worked in the past with the 4.19 series
> > > > > from
> > > > > Debian.
> > > > > 
> > > > > Here is the trace, and please find all Linux kernel logs attached.
> > > > > 
> > > > > > [ 2027.170589] BUG: kernel NULL pointer dereference, address:
> > > > > > 0000000000000000
> > > > > > [ 2027.170600] #PF: supervisor instruction fetch in kernel mode
> > > > > > [ 2027.170604] #PF: error_code(0x0010) - not-present page
> > > > > > [ 2027.170609] PGD 0 P4D 0 [ 2027.170619] Oops: 0010 [#1] SMP PTI
> > > > ...
> > > > > > [ 2027.170730]  do_dentry_open+0x13a/0x370
> > > > 
> > > > If you have compiled with debug info, please decode the line:
> > > > 
> > > >    linux/scripts/faddr2line vmlinux do_dentry_open+0x13a/0x370
> > > > 
> > > > That gives us the fops pointer which is NULL.
> > > 
> > > Hah, luckily it’s reproducible.
> > > 
> > > ```
> > > $ scripts/faddr2line /usr/lib/debug/boot/vmlinux-5.2.0-2-amd64
> > > do_dentry_open+0x13a/0x370
> > > do_dentry_open+0x13a/0x370:
> > > do_dentry_open at fs/open.c:799
> > > ```
> > > 
> > > > > > [ 2027.170745]  path_openat+0x2c6/0x1480
> > > > > > [ 2027.170757]  ? terminate_walk+0xe6/0x100
> > > > > > [ 2027.170767]  ? path_lookupat.isra.48+0xa3/0x220
> > > > > > [ 2027.170779]  ? reuse_swap_page+0x105/0x320
> > > > > > [ 2027.170791]  do_filp_open+0x93/0x100
> > > > > > [ 2027.170804]  ? __check_object_size+0x15d/0x189
> > > > > > [ 2027.170816]  do_sys_open+0x184/0x220
> > > > > > [ 2027.170828]  do_syscall_64+0x53/0x130
> > > > > > [ 2027.170837]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > 
> > > > That's an open crashing. We just don't know which file. Is the machine
> > > > completely hosed after that or is it just the graphics stuff dying?
> > > 
> > > No, the graphical login manager showed up, and I could log back in, and
> > > continue using hte machine.
> > > 
> > > > If it's not completely dead then instead of running it from your graphical
> > > > desktop you could switch to a VGA terminal Alt+Ctrl+F1 (or whatever
> > > > function key your distro maps to) after boot and run powertop with strace
> > > > from there:
> > > > 
> > > >    strace -f -o xxx.log powertop
> > > > 
> > > > With a bit of luck xxx.log should contain the information about the file
> > > > it
> > > > tries to open.
> > > 
> > > ```
> > > 2157  access("/sys/class/drm/card0/power/rc6_residency_ms", R_OK) = 0
> > > 2157  openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/power/cpu_idle/id",
> > > O_RDONLY) = ?
> > > 2157  +++ killed by SIGKILL +++
> > > ```
> > > 
> > > > Alternatively if you have a serial console you can enable the
> > > > sys_enter_open* tracepoints:
> > > > 
> > > > # echo 1 >/sys/kernel/debug/tracing/events/syscalls/sys_enter_open
> > > > # echo 1 >/sys/kernel/debug/tracing/events/syscalls/sys_enter_openat
> > > > 
> > > > Either add 'ftrace_dump_on_oops' to the kernel command line or enable it
> > > > from the shell:
> > > > 
> > > > # echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
> > > > 
> > > > Then run powertop. After the crash it will take some time to spill out the
> > > > trace buffer over serial, but it will pinpoint the offending file.
> > > 
> > > I do not have serial console on this device.
> > 
> > For the record. It is also reproducible with Linux 5.2.6, and trying to print
> > the file contents with cat already fails.
> > 
> > ```
> > $ sudo ls -l /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > -r--r--r-- 1 root root 0 Aug 10 23:05
> > /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > $ sudo cat /sys/kernel/debug/tracing/events/power/cpu_idle/id
> > Killed
> > ```

This seems to be related to https://bugs.debian.org/934304 (in
particular https://bugs.debian.org/934304#29). The mentioned patch
features/all/lockdown/0031-tracefs-Restrict-tracefs-when-the-kernel-is-locked-d.patch
is a backport of https://patchwork.kernel.org/patch/11069661/ with
only change that it is converted back to the non-LSM lockdown API.

Regards,
Salvatore
