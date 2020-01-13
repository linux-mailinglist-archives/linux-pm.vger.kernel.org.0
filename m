Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62018138FC4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgAMLHn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 06:07:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49513 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgAMLHn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 06:07:43 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id c7ad015d3098e161; Mon, 13 Jan 2020 12:07:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Johannes Stezenbach <js@sig21.net>,
        Alexander Potapenko <glider@google.com>,
        "Acked-by: Kees Cook" <keescook@chromium.org>,
        "Acked-by: Michal Hocko" <mhocko@suse.cz>
Cc:     linux-pm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: init_on_free breaks hibernate
Date:   Mon, 13 Jan 2020 12:07:40 +0100
Message-ID: <2661668.lOhekKA4Va@kreacher>
In-Reply-To: <20200113092604.GA26365@sig21.net>
References: <20191223211309.GA4609@sig21.net> <20200113092604.GA26365@sig21.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, January 13, 2020 10:26:04 AM CET Johannes Stezenbach wrote:
> Hi,
> 
> On Mon, Dec 23, 2019 at 10:13:09PM +0100, Johannes Stezenbach wrote:
> > I upgraded the kernel on one of my machines to 5.3.18 (from 5.2.x)
> > and found it failed after resume from hibernate due to what seemed
> > to be memory corruption. I had a hunch it could be related to
> > CONFIG_INIT_ON_ALLOC_DEFAULT_ON or CONFIG_INIT_ON_FREE_DEFAULT_ON,
> > and a quick web search found this which seems to confirm:
> > https://bbs.archlinux.org/viewtopic.php?pid=1877845#p1877845
> > 
> > I rebuilt the kernel with CONFIG_INIT_ON_FREE_DEFAULT_ON disabled,
> > and hibernate works again.  I'm fine with this workaround and
> > just wanted to share this information.
> > 
> > The commit that introduces CONFIG_INIT_ON_FREE_DEFAULT_ON:
> > 6471384af2a6 mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options
> 
> I tested 5.4.11 and current git master (b07f636fca1c8)
> in Qemu and was able to reproduce the issue in both.

Let's add more people and the LKML to the CC.

Alex, Kees, Michal, any comments?

> Basically I followed the description here
> http://ncmiller.github.io/2016/05/14/linux-and-qemu.html
> to build a minimal image using busybox (I'm using
> the binary from Debian's busybox-static package),
> then added s swap image (-drive file=disk.img,if=virtio),
> do "mkswap /dev/vda" the first time.
> 
> hibernate: swapon /dev/vda; echo disk >/sys/power/state
> resume: echo 254:0 >/sys/power/resume
> 
> Since busybox is very light on memory usage it doesn't
> trigger immediately, but these commands seem to do it
> reliably:
> 
>   dmesg | gzip >/dev/null
>   find /sys | bzip2 | sha512sum
> 
> 
> my initramfs:
>   6012997      4 drwxr-xr-x   4 js       js           4096 Jan  8 21:25 initramfs
>   6022584      4 drwxr-xr-x   2 js       js           4096 Jan  8 21:21 initramfs/dev
>   5909013      4 -rwxr-xr-x   1 js       js            514 Jan  8 21:25 initramfs/init
>   6012998      4 drwxr-xr-x   2 js       js           4096 Jan  8 20:41 initramfs/bin
>   5909011   1904 -rwxr-xr-x   1 js       js        1945856 Apr  1  2019 initramfs/bin/busybox
>   5909012      0 lrwxrwxrwx   1 js       js              7 Feb 14  2018 initramfs/bin/sh -> busybox
> 
> my /init:
> #!/bin/sh
> 
> PATH=/bin
> export PATH
> 
> # Create dirs
> /bin/busybox mkdir -p /proc /sys /etc /tmp /usr
> /bin/busybox ln -s /bin /sbin
> /bin/busybox ln -s /bin /usr/bin
> /bin/busybox ln -s /bin /usr/sbin
> # Create all the symlinks to busybox
> /bin/busybox --install -s
> 
> mount -t proc proc /proc
> mount -t sysfs sysfs /sys
> mount -t devtmpfs devtmpfs /dev
> 
> echo -e "\nBoot took $(cut -d' ' -f1 /proc/uptime) seconds\n"
> 
> # shell where ^C works
> setsid busybox cttyhack sh
> # avoid "PID 1 exited" oops
> poweroff -f
> ---------
> 
> 
> qemu-system-x86_64 -m 128 -enable-kvm \
>   -kernel ../linux/arch/x86/boot/bzImage \
>   -initrd initramfs.cpio \
>   -drive file=disk.img,if=virtio \
>   -nographic -append "console=ttyS0 init_on_alloc=1 init_on_free=1"
> 
> 
> Johannes
> 




