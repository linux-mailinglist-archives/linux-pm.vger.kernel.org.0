Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F00988FF4
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfHKGW4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 02:22:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58537 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfHKGW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 02:22:56 -0400
Received: from p200300ddd71876477e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7647:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwhFa-00054Y-1X; Sun, 11 Aug 2019 08:22:42 +0200
Date:   Sun, 11 Aug 2019 08:22:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Linux 5.2.x] /sys/kernel/debug/tracing/events/power/cpu_idle/id:
 BUG: kernel NULL pointer dereference, address: 0000000000000000
In-Reply-To: <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1908110822110.7324@nanos.tec.linutronix.de>
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de> <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de> <01c7bc6b-dc6d-5eca-401a-8869e02f7c2a@molgen.mpg.de> <e18e2a11-ea96-a612-48cd-877fa307115f@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1450168681-1565504562=:7324"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1450168681-1565504562=:7324
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sat, 10 Aug 2019, Paul Menzel wrote:

Cc+ Steven

> [+ INTEL IDLE DRIVER]
> 
> Dear Linux folks,
> 
> 
> On 10.08.19 20:28, Paul Menzel wrote:
> 
> > On 10.08.19 19:31, Thomas Gleixner wrote:
> > 
> > > On Sat, 10 Aug 2019, Paul Menzel wrote:
> > > > 
> > > > I have no idea, who to report this to, so I please refer me to the
> > > > correct
> > > > list.
> > > 
> > > I have no idea yet either :)
> > > 
> > > > With Linux 5.2.7 from Debian Sid/unstable and PowerTOP 2.10, executing
> > > > 
> > > >      sudo powertop --auto-tune
> > > > 
> > > > causes a NULL pointer dereference, and the graphical session crashes due
> > > > to an
> > > > effect on the i915 driver. It worked in the past with the 4.19 series
> > > > from
> > > > Debian.
> > > > 
> > > > Here is the trace, and please find all Linux kernel logs attached.
> > > > 
> > > > > [ 2027.170589] BUG: kernel NULL pointer dereference, address:
> > > > > 0000000000000000
> > > > > [ 2027.170600] #PF: supervisor instruction fetch in kernel mode
> > > > > [ 2027.170604] #PF: error_code(0x0010) - not-present page
> > > > > [ 2027.170609] PGD 0 P4D 0 [ 2027.170619] Oops: 0010 [#1] SMP PTI
> > > ...
> > > > > [ 2027.170730]  do_dentry_open+0x13a/0x370
> > > 
> > > If you have compiled with debug info, please decode the line:
> > > 
> > >    linux/scripts/faddr2line vmlinux do_dentry_open+0x13a/0x370
> > > 
> > > That gives us the fops pointer which is NULL.
> > 
> > Hah, luckily it’s reproducible.
> > 
> > ```
> > $ scripts/faddr2line /usr/lib/debug/boot/vmlinux-5.2.0-2-amd64
> > do_dentry_open+0x13a/0x370
> > do_dentry_open+0x13a/0x370:
> > do_dentry_open at fs/open.c:799
> > ```
> > 
> > > > > [ 2027.170745]  path_openat+0x2c6/0x1480
> > > > > [ 2027.170757]  ? terminate_walk+0xe6/0x100
> > > > > [ 2027.170767]  ? path_lookupat.isra.48+0xa3/0x220
> > > > > [ 2027.170779]  ? reuse_swap_page+0x105/0x320
> > > > > [ 2027.170791]  do_filp_open+0x93/0x100
> > > > > [ 2027.170804]  ? __check_object_size+0x15d/0x189
> > > > > [ 2027.170816]  do_sys_open+0x184/0x220
> > > > > [ 2027.170828]  do_syscall_64+0x53/0x130
> > > > > [ 2027.170837]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > 
> > > That's an open crashing. We just don't know which file. Is the machine
> > > completely hosed after that or is it just the graphics stuff dying?
> > 
> > No, the graphical login manager showed up, and I could log back in, and
> > continue using hte machine.
> > 
> > > If it's not completely dead then instead of running it from your graphical
> > > desktop you could switch to a VGA terminal Alt+Ctrl+F1 (or whatever
> > > function key your distro maps to) after boot and run powertop with strace
> > > from there:
> > > 
> > >    strace -f -o xxx.log powertop
> > > 
> > > With a bit of luck xxx.log should contain the information about the file
> > > it
> > > tries to open.
> > 
> > ```
> > 2157  access("/sys/class/drm/card0/power/rc6_residency_ms", R_OK) = 0
> > 2157  openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/power/cpu_idle/id",
> > O_RDONLY) = ?
> > 2157  +++ killed by SIGKILL +++
> > ```
> > 
> > > Alternatively if you have a serial console you can enable the
> > > sys_enter_open* tracepoints:
> > > 
> > > # echo 1 >/sys/kernel/debug/tracing/events/syscalls/sys_enter_open
> > > # echo 1 >/sys/kernel/debug/tracing/events/syscalls/sys_enter_openat
> > > 
> > > Either add 'ftrace_dump_on_oops' to the kernel command line or enable it
> > > from the shell:
> > > 
> > > # echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
> > > 
> > > Then run powertop. After the crash it will take some time to spill out the
> > > trace buffer over serial, but it will pinpoint the offending file.
> > 
> > I do not have serial console on this device.
> 
> For the record. It is also reproducible with Linux 5.2.6, and trying to print
> the file contents with cat already fails.
> 
> ```
> $ sudo ls -l /sys/kernel/debug/tracing/events/power/cpu_idle/id
> -r--r--r-- 1 root root 0 Aug 10 23:05
> /sys/kernel/debug/tracing/events/power/cpu_idle/id
> $ sudo cat /sys/kernel/debug/tracing/events/power/cpu_idle/id
> Killed
> ```
> 
> 
> Kind regards,
> 
> Paul
> 
--8323329-1450168681-1565504562=:7324--
