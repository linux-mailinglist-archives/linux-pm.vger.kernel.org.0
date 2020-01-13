Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F968138DBA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 10:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgAMJ0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 04:26:13 -0500
Received: from mail.sig21.net ([80.244.240.74]:38390 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgAMJ0N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 04:26:13 -0500
Received: from localhorst ([127.0.0.1])
         by mail.sig21.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
         (Exim 4.84_2)
        (envelope-from <js@sig21.net>)
         id 1iqvz6-0006Qo-Ur ; Mon, 13 Jan 2020 10:26:11 +0100
Received: from js by abc.local with local (Exim 4.93)
        (envelope-from <js@sig21.net>)
        id 1iqvz2-00075O-HY; Mon, 13 Jan 2020 10:26:04 +0100
Date:   Mon, 13 Jan 2020 10:26:04 +0100
From:   Johannes Stezenbach <js@sig21.net>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Potapenko <glider@google.com>
Subject: Re: init_on_free breaks hibernate
Message-ID: <20200113092604.GA26365@sig21.net>
References: <20191223211309.GA4609@sig21.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223211309.GA4609@sig21.net>
X-Spam-21-Score: -2.9 (--)
X-Spam-21-Report: No, score=-2.9 required=8.0 tests=ALL_TRUSTED=-1,BAYES_00=-1.9 autolearn=ham autolearn_force=no
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, Dec 23, 2019 at 10:13:09PM +0100, Johannes Stezenbach wrote:
> I upgraded the kernel on one of my machines to 5.3.18 (from 5.2.x)
> and found it failed after resume from hibernate due to what seemed
> to be memory corruption. I had a hunch it could be related to
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON or CONFIG_INIT_ON_FREE_DEFAULT_ON,
> and a quick web search found this which seems to confirm:
> https://bbs.archlinux.org/viewtopic.php?pid=1877845#p1877845
> 
> I rebuilt the kernel with CONFIG_INIT_ON_FREE_DEFAULT_ON disabled,
> and hibernate works again.  I'm fine with this workaround and
> just wanted to share this information.
> 
> The commit that introduces CONFIG_INIT_ON_FREE_DEFAULT_ON:
> 6471384af2a6 mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options

I tested 5.4.11 and current git master (b07f636fca1c8)
in Qemu and was able to reproduce the issue in both.

Basically I followed the description here
http://ncmiller.github.io/2016/05/14/linux-and-qemu.html
to build a minimal image using busybox (I'm using
the binary from Debian's busybox-static package),
then added s swap image (-drive file=disk.img,if=virtio),
do "mkswap /dev/vda" the first time.

hibernate: swapon /dev/vda; echo disk >/sys/power/state
resume: echo 254:0 >/sys/power/resume

Since busybox is very light on memory usage it doesn't
trigger immediately, but these commands seem to do it
reliably:

  dmesg | gzip >/dev/null
  find /sys | bzip2 | sha512sum


my initramfs:
  6012997      4 drwxr-xr-x   4 js       js           4096 Jan  8 21:25 initramfs
  6022584      4 drwxr-xr-x   2 js       js           4096 Jan  8 21:21 initramfs/dev
  5909013      4 -rwxr-xr-x   1 js       js            514 Jan  8 21:25 initramfs/init
  6012998      4 drwxr-xr-x   2 js       js           4096 Jan  8 20:41 initramfs/bin
  5909011   1904 -rwxr-xr-x   1 js       js        1945856 Apr  1  2019 initramfs/bin/busybox
  5909012      0 lrwxrwxrwx   1 js       js              7 Feb 14  2018 initramfs/bin/sh -> busybox

my /init:
#!/bin/sh

PATH=/bin
export PATH

# Create dirs
/bin/busybox mkdir -p /proc /sys /etc /tmp /usr
/bin/busybox ln -s /bin /sbin
/bin/busybox ln -s /bin /usr/bin
/bin/busybox ln -s /bin /usr/sbin
# Create all the symlinks to busybox
/bin/busybox --install -s

mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs devtmpfs /dev

echo -e "\nBoot took $(cut -d' ' -f1 /proc/uptime) seconds\n"

# shell where ^C works
setsid busybox cttyhack sh
# avoid "PID 1 exited" oops
poweroff -f
---------


qemu-system-x86_64 -m 128 -enable-kvm \
  -kernel ../linux/arch/x86/boot/bzImage \
  -initrd initramfs.cpio \
  -drive file=disk.img,if=virtio \
  -nographic -append "console=ttyS0 init_on_alloc=1 init_on_free=1"


Johannes
